Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s4b450TKjzDqQs
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Aug 2016 13:28:05 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Jack Miller <jack@codezen.org>, linuxppc-dev@lists.ozlabs.org
Cc: jk@ozlabs.org, stewart@linux.vnet.ibm.com, benh@kernel.crashing.org
Subject: Re: [PATCH] powernv: Search for new flash DT node location
In-Reply-To: <20160803164412.7039-1-jack@codezen.org>
References: <147020859492.19099.3536038186529840354@concordia>
 <20160803164412.7039-1-jack@codezen.org>
Date: Thu, 04 Aug 2016 13:28:04 +1000
Message-ID: <87vazhb4cb.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Jack Miller <jack@codezen.org> writes:

> On Wed, Aug 03, 2016 at 05:16:34PM +1000, Michael Ellerman wrote:
>> We could instead just search for all nodes that are compatible with
>> "ibm,opal-flash". We do that for i2c, see opal_i2c_create_devs().
>> 
>> Is there a particular reason not to do that?
>
> I'm actually surprised that this is preferred. Jeremy mentioned something
> similar, but I guess I just don't like the idea of finding devices in weird
> places in the tree.

But where is "weird". Arguably "/opal/flash" is weird. What does it
mean? There's a bus called "opal" and a device on it called "flash"? No.

Point being the structure is fairly arbitrary, or at least debatable, so
tying the code 100% to the structure is inflexible. As we have discovered.

Our other option is to tell skiboot to get stuffed, and leave the flash
node where it was on P8.

> Then again, if we can't trust the DT we're in bigger
> trouble than erroneous flash nodes =).

Quite :)

> If we really just want to find compatible nodes anywhere, let's simplify i2c
> and pdev_init into one function and make that behavior consistent with this
> new patch.

That seems OK to me.

We should get an ack from Stewart though for the other node types.

cheers
