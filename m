Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3F740B6FD1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Oct 2011 19:30:00 +1100 (EST)
Subject: RE: [PATCH] mlx4_en: fix transmit of packages when blue frame is
 enabled
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Laight <David.Laight@ACULAB.COM>
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6D8AE77@saturn3.aculab.com>
References: <AE90C24D6B3A694183C094C60CF0A2F6D8AE77@saturn3.aculab.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 10 Oct 2011 10:29:40 +0200
Message-ID: <1318235380.29415.411.camel@pasglop>
Mime-Version: 1.0
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Yevgeny Petrilin <yevgenyp@mellanox.co.il>, Eli Cohen <eli@mellanox.co.il>,
 Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>,
 Eli Cohen <eli@dev.mellanox.co.il>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2011-10-10 at 09:20 +0100, David Laight wrote:
> 
> For the above I'd actually suggest making 'doorbell_qpn' have the
> correct endianness in order to avoid the (potential) swap every
> time it is set.

Well, the problem is that either you'll end up swapping on x86 or you'll
end up swapping on ppc, there is no "native" MMIO accessor that allow
you to do a no-swap access whatever the arch you are on. Or rather,
there is the __raw_ one but you shouldn't use it for most things :-)
(Because it also doesn't have the right memory barriers).

So I'd rather they do it right using the simpler method, the cost of
swap is going to be negligible, probably not even measurable, and if and
only if they think they can improve on that in a second step, then
consider doing otherwise with appropriate measurements showing a
significant difference.

> You also need to treble-check the required endianness for the
> 'vlan_tag' in the tx descriptor. What would be needed is the
> MAC PCI slave were on an x86 (LE) system.

Cheers,
Ben.
