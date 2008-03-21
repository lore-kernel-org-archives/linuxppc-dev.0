Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1E8E3DDE06
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Mar 2008 05:13:26 +1100 (EST)
Date: Fri, 21 Mar 2008 11:12:28 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 1/2 v2] Driver for Freescale 8610 and 5121 DIU
Message-Id: <20080321111228.95a7d9ab.akpm@linux-foundation.org>
In-Reply-To: <47E3DE6E.2050801@freescale.com>
References: <12059526271941-git-send-email-yorksun@freescale.com>
	<12059526274026-git-send-email-yorksun@freescale.com>
	<20080320152708.23c6c734.akpm@linux-foundation.org>
	<47E3DE6E.2050801@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-fbdev-devel@lists.sourceforge.net,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	York Sun <yorksun@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 21 Mar 2008 11:12:30 -0500 Timur Tabi <timur@freescale.com> wrote:

> Andrew Morton wrote:
> 
> >> +static struct diu_hw dr = {
> >> +	.mode = MFB_MODE1,
> >> +	.reg_lock = __SPIN_LOCK_UNLOCKED(old_style_spin_init),
> >> +};
> > 
> > I'm not clear on what's supposed to happen with __SPIN_LOCK_UNLOCKED().  I
> > do know that its documentation is crap.
> 
> Yes, "__SPIN_LOCK_UNLOCKED(old_style_spin_init)" is wrong.  We'll fix it.
> 
> >  static struct diu_hw dr = {
> >  	.mode = MFB_MODE1,
> > -	.reg_lock = __SPIN_LOCK_UNLOCKED(old_style_spin_init),
> > +	.reg_lock = __SPIN_LOCK_UNLOCKED(diu_hw.reg_lock),
> >  };
> 
> Yes, this is better.  Did you already make this change when you applied it to
> your -mm repo?

I did:

--- a/drivers/video/fsl-diu-fb.c~fbdev-driver-for-freescale-8610-and-5121-diu-fix
+++ a/drivers/video/fsl-diu-fb.c
@@ -274,7 +274,7 @@ static struct mfb_info mfb_template[] = 
 
 static struct diu_hw dr = {
 	.mode = MFB_MODE1,
-	.reg_lock = __SPIN_LOCK_UNLOCKED(old_style_spin_init),
+	.reg_lock = __SPIN_LOCK_UNLOCKED(dr.reg_lock),
 };
 
 static struct diu_pool pool;

> > GFP_DMA implies GFP_ATOMIC, but it's appropriate for documentation purposes.
> 
> So does that mean that "GFP_DMA | GFP_KERNEL" is always wrong?

No, that's OK too.  It's just that GFP_DMA|GFP_ATOMIC is a bit redundant
and misleading.  GFP_DMA is already atomic; the only effect of adding
GFP_ATOMIC to GFP_DMA is to add __GFP_HIGH.

Don't wory about it ;)

>  If so, this
> combination is used a lot in the kernel today.
> 
> >> +	if (virt) {
> >> +		*phys = virt_to_phys(virt);
> >> +		pr_debug("virt %p, phys=%llx\n", virt, (uint64_t) *phys);
> >> +		memset(virt, 0, size);
> > 
> > Could have used __GFP_ZERO, I guess.
> 
> I had completely forgotten about __GFP_ZERO.  Thanks.
> 
> >> +	virt = (void *) rh_alloc(&diu_ops.diu_rh_info, size, "DIU");
> > 
> > hm, I'd have expected checkpatch to whine about the space after the cast
> > there.  Whatever.
> 
> I thought a space after a cast is the right thing to do?

Last time I grepped, no-space is a lot more common.

> > please take a look, and please use checkpatch on all future patches.
> 
> Sorry, we forgot to run it again after our second version of the patch.
> 
> >> +static void free_irq_local(int irq)
> >> +{
> >> +	struct diu *hw = dr.diu_reg;
> >> +
> >> +	/* Disable all LCDC interrupt */
> >> +	out_be32(&(hw->int_mask), 0x1f);
> >> +
> >> +	free_irq(irq, 0);
> >> +}
> > 
> > and the free_irq() will go splat?
> 
> Sorry, but I don't understand what's wrong with this code.

You snipped a bit.  Earlier, request_irq() failures were ignored.  So I
think there's a code path where free_irq_local() can free an IRQ which this
driver never owned.

> We'll make the other changes you've suggested and repost.
