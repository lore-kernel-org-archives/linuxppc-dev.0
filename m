Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E1008474C1
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Nov 2008 07:53:13 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id mACKrA2O021853
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2008 15:53:10 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mACKrAnF166398
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2008 15:53:10 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mACKr9n5010605
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2008 15:53:10 -0500
Date: Wed, 12 Nov 2008 15:53:02 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] [v3] powerpc/4xx: work around CHIP11 errata in a more
	PAGE_SIZE-friendly way
Message-ID: <20081112155302.36af6034@zod.rchland.ibm.com>
In-Reply-To: <1226522696.7154.28.camel@pasglop>
References: <700c59731cf97778d3a4.1226448406@localhost.localdomain>
	<1226464663.13515.1.camel@pasglop>
	<20081112063129.4d3ae18b@zod.rchland.ibm.com>
	<1226490730.7154.16.camel@pasglop>
	<1226502685.19156.2.camel@localhost.localdomain>
	<1226522696.7154.28.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, yanok@emcraft.com, kvm-ppc@vger.kernel.org,
	Hollis Blanchard <hollisb@us.ibm.com>, dwg@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 13 Nov 2008 07:44:56 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Wed, 2008-11-12 at 09:11 -0600, Hollis Blanchard wrote:
> > Forget pages. The errata is about the last 256 bytes of physical
> > memory.
> > 
> > > I still find it a bit tricky to have memory nodes not aligned on
> > nice
> > > fat big boundaries tho.
> > 
> > I don't know what you're referring to. The patch I sent doesn't touch
> > memory nodes, so they are indeed still aligned on nice fat big
> > boundaries.
> 
> My last comment was about the approach of modifying the memory node.
> 
> > I don't think this is overengineering at all. We can't touch the last
> > 256 bytes, so we mark it reserved, and then we won't. Altering memory
> > nodes is far more complicated and error-prone.
> 
> But your approach is going to be painful for kexec which will have to
> duplicate that logic.
> 
> Again, why can't we just stick something in the kernel code that
> reserves the last page ? It could be in prom.c or it could be called by
> affected 4xx platforms by the platform code, whatever, but the reserve
> map isn't really meant for that and will not be passed over from kernel
> to kernel by kexec.

Again, because newer U-Boot is doing the fixup on memsize for us
already.  This is why it was done in the wrapper to begin with, since
it depends on the version of U-Boot that you happen to be using.

If you have a good idea on how to figure that out in-kernel, do the
fixup when needed, and not make people's eyes bleed, I'm all for it.

josh
