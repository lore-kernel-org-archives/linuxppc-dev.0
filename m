Return-Path: <hollisb@us.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D05C4DDDE0
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Nov 2008 02:11:36 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id mACFBMA4018637
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2008 10:11:22 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mACFBScn138028
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2008 10:11:28 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mACFBRLg011699
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2008 10:11:28 -0500
Subject: Re: [PATCH] [v3] powerpc/4xx: work around CHIP11 errata in a more
	PAGE_SIZE-friendly way
From: Hollis Blanchard <hollisb@us.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1226490730.7154.16.camel@pasglop>
References: <700c59731cf97778d3a4.1226448406@localhost.localdomain>
	<1226464663.13515.1.camel@pasglop>
	<20081112063129.4d3ae18b@zod.rchland.ibm.com>
	<1226490730.7154.16.camel@pasglop>
Content-Type: text/plain
Date: Wed, 12 Nov 2008 09:11:25 -0600
Message-Id: <1226502685.19156.2.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, yanok@emcraft.com, kvm-ppc@vger.kernel.org,
	dwg@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-11-12 at 22:52 +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2008-11-12 at 06:31 -0500, Josh Boyer wrote:
> > On Wed, 12 Nov 2008 15:37:43 +1100
> > Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > 
> > > On Tue, 2008-11-11 at 18:06 -0600, Hollis Blanchard wrote:
> > > > The current CHIP11 errata truncates the device tree memory node, and subtracts
> > > > (hardcoded) 4096 bytes. This breaks kernels with larger PAGE_SIZE, since the
> > > > bootmem allocator assumes that total memory is a multiple of PAGE_SIZE.
> > > > 
> > > > Instead, use a device tree memory reservation to reserve only the 256 bytes
> > > > actually affected by the errata, leaving the total memory size unaltered.
> > > > 
> > > > Signed-off-by: Hollis Blanchard <hollisb@us.ibm.com>
> > > 
> > > While I prefer this approach, won't it break kexec ?
> > 
> > Break it how?  Particularly given that kexec doesn't work on 4xx (yet).
> 
> Allright, wrong wording. It will make kexec more painful since it will
> have to also create that reserved area in the target DT.
> 
> > I don't think that's it.  I think it's more that we're opportunistic and
> > the wrapper is the easiest place to do this, given that U-Boot itself
> > will be doing the reserve for platforms that don't require the
> > wrapper.
> > 
> > So we could do the fixup in-kernel, but how do you do that
> > deterministically given that U-Boot might have already done it?
> 
> Bah, do you know many RAM chip that will chop off the last 4K ?

Forget pages. The errata is about the last 256 bytes of physical memory.

> I still find it a bit tricky to have memory nodes not aligned on nice
> fat big boundaries tho.

I don't know what you're referring to. The patch I sent doesn't touch
memory nodes, so they are indeed still aligned on nice fat big
boundaries.

I don't think this is overengineering at all. We can't touch the last
256 bytes, so we mark it reserved, and then we won't. Altering memory
nodes is far more complicated and error-prone.

-- 
Hollis Blanchard
IBM Linux Technology Center
