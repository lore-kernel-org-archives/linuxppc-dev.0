Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A5CA4DDD0C
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2008 22:53:20 +1100 (EST)
Subject: Re: [PATCH] [v3] powerpc/4xx: work around CHIP11 errata in a more
	PAGE_SIZE-friendly way
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20081112063129.4d3ae18b@zod.rchland.ibm.com>
References: <700c59731cf97778d3a4.1226448406@localhost.localdomain>
	<1226464663.13515.1.camel@pasglop>
	<20081112063129.4d3ae18b@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Wed, 12 Nov 2008 22:52:10 +1100
Message-Id: <1226490730.7154.16.camel@pasglop>
Mime-Version: 1.0
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

On Wed, 2008-11-12 at 06:31 -0500, Josh Boyer wrote:
> On Wed, 12 Nov 2008 15:37:43 +1100
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > On Tue, 2008-11-11 at 18:06 -0600, Hollis Blanchard wrote:
> > > The current CHIP11 errata truncates the device tree memory node, and subtracts
> > > (hardcoded) 4096 bytes. This breaks kernels with larger PAGE_SIZE, since the
> > > bootmem allocator assumes that total memory is a multiple of PAGE_SIZE.
> > > 
> > > Instead, use a device tree memory reservation to reserve only the 256 bytes
> > > actually affected by the errata, leaving the total memory size unaltered.
> > > 
> > > Signed-off-by: Hollis Blanchard <hollisb@us.ibm.com>
> > 
> > While I prefer this approach, won't it break kexec ?
> 
> Break it how?  Particularly given that kexec doesn't work on 4xx (yet).

Allright, wrong wording. It will make kexec more painful since it will
have to also create that reserved area in the target DT.

> I don't think that's it.  I think it's more that we're opportunistic and
> the wrapper is the easiest place to do this, given that U-Boot itself
> will be doing the reserve for platforms that don't require the
> wrapper.
> 
> So we could do the fixup in-kernel, but how do you do that
> deterministically given that U-Boot might have already done it?

Bah, do you know many RAM chip that will chop off the last 4K ?

I still find it a bit tricky to have memory nodes not aligned on nice
fat big boundaries tho.

Cheers,
Ben.
