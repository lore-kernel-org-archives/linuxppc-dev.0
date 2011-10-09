Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 68D70B70C8
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  9 Oct 2011 20:52:30 +1100 (EST)
Subject: Re: [PATCH] mlx4_en: fix transmit of packages when blue frame is
 enabled
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Eli Cohen <eli@dev.mellanox.co.il>
In-Reply-To: <20111009092102.GK2681@mtldesk30>
References: <20111003205358.GB3596@oc1711230544.ibm.com>
 <1317708132.29415.213.camel@pasglop>
 <20111004202620.GA3455@oc1711230544.ibm.com>
 <20111005081502.GB2681@mtldesk30> <20111006135759.GH2681@mtldesk30>
 <1318145118.29415.371.camel@pasglop> <20111009073546.GI2681@mtldesk30>
 <1318147254.29415.377.camel@pasglop> <20111009080747.GJ2681@mtldesk30>
 <1318149536.29415.384.camel@pasglop>  <20111009092102.GK2681@mtldesk30>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 09 Oct 2011 11:52:19 +0200
Message-ID: <1318153939.29415.401.camel@pasglop>
Mime-Version: 1.0
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Eli Cohen <eli@mellanox.co.il>, linuxppc-dev@lists.ozlabs.org,
 Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>,
 Yevgeny Petrilin <yevgenyp@mellanox.co.il>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> > To go back to the driver code, the statements that ring a "bell" are:
> > 
> > 	*(u32 *) (&tx_desc->ctrl.vlan_tag) |= ring->doorbell_qpn;
> > 
> > This doesn't look right unless "doorbell_qpn" itself is already somewhat
> > in the appropriate byte order.

> This is something that supports my claim that the chipset swaps
> endianess in ppc.

No the chipset doesn't swap

> Look at mlx4_en_activate_tx_ring():
> ring->doorbell_qpn = swab32(ring->qp.qpn << 8);

That looks gross, I think somebody writing this driver doesn't
understand endianness.

> so in LE machines it layed as big endian in memory while in BE machines
> it is layed as little endian in memory.

Yes which is very odd, it should be layed out the same in memory
regardless of the machine. However in this case, this isn't accessed
directly via DMA (this field at least), so what you appear to be doing
here is to artificially "undo" what writel does later on (see below).

> Then we write this value to the device registers which must get it in
> big endian otherwise it won't work - and we know this works in both
> ppc and x86. You can ignore the case of blue flame:

Well it works because your device is odd and has BE registers :-) It's
however not the right way to do and it's broken in your blue flame case
(for what is now obvious reasons, see below).

What's happening basically here is that you are swapping once in
swab32 , store that swapped value, then writel will re-swap on power and
not swap on x86 (because the writel accessor performs swapping). So on
x86 you basically do LE -> BE and on ppc you do BE -> LE -> BE :-)
Pretty inefficient.

None of this has anything to do with the chipset which doesn't swap
anything behind your back.

Ideally you want to avoid that swapping altogether and use the right
accessor that indicates that your register is BE to start with. IE.
remove the swab32 completely and then use something like 
iowrite32be() instead of writel().

Basically, the problem you have is that writel() has an implicit "write
to LE register" semantic. Your register is BE. the "iomap" variants
provide you with more fine grained "be" variants to use in that case.
There's also writel_be() but that one doesn't exist on every
architecture afaik.

Now, once the mmio problem is out of the way, let's look back at how you
then use that qpn.

With the current code, you've generated something in memory which is
byte reversed, so essentially "LE" on ppc and "BE" on x86.

Then, this statement:

*(u32 *) (&tx_desc->ctrl.vlan_tag) |= ring->doorbell_qpn;

Will essentially write it out as-is in memory for use by the chip. The chip,
from what you say, expects BE, so this will be broken on PPC.

Here too, the right solution is to instead not do that swab32 to begin
with (ring->doorbell_qpn remains a native endian value) and instead do,
in addition to the above mentioned change to the writel:

	*(u32 *) (&tx_desc->ctrl.vlan_tag) |= cpu_to_be32(ring->doorbell_qpn);

(Also get rid of that cast and define vlan_tag as a __be32 to start
with).

Cheers,
Ben.
