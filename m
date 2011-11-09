Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE003.bigfish.com (tx2ehsobe002.messaging.microsoft.com
 [65.55.88.12]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 778C1B6F8F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2011 03:12:44 +1100 (EST)
Received: from mail64-tx2 (localhost.localdomain [127.0.0.1])	by
 mail64-tx2-R.bigfish.com (Postfix) with ESMTP id 59DEA3EB8140	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Nov 2011 16:12:29 +0000 (UTC)
Received: from TX2EHSMHS027.bigfish.com (unknown [10.9.14.243])	by
 mail64-tx2.bigfish.com (Postfix) with ESMTP id 1D31031B004E	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Nov 2011 16:12:27 +0000 (UTC)
Date: Wed, 9 Nov 2011 10:12:33 -0600
From: Scott Wood <scottwood@freescale.com>
To: Li Yang-R58472 <r58472@freescale.com>
Subject: Re: [PATCH 2/7] powerpc/85xx: add HOTPLUG_CPU support
Message-ID: <20111109161233.GC7839@schlenkerla.am.freescale.net>
References: <1320409889-14408-1-git-send-email-chenhui.zhao@freescale.com>
 <4EB4305C.6030303@freescale.com>
 <3F607A5180246847A760FD34122A1E052BC6F1@039-SN1MPN1-004.039d.mgd.msft.net>
 <4EB997C5.60105@freescale.com>
 <3F607A5180246847A760FD34122A1E052BD4A4@039-SN1MPN1-004.039d.mgd.msft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <3F607A5180246847A760FD34122A1E052BD4A4@039-SN1MPN1-004.039d.mgd.msft.net>
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Zhao Chenhui-B35336 <B35336@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 09, 2011 at 02:31:23AM -0600, Li Yang-R58472 wrote:
> >-----Original Message-----
> >From: Wood Scott-B07421
> >Sent: Wednesday, November 09, 2011 4:58 AM
> >To: Li Yang-R58472
> >Cc: Wood Scott-B07421; Zhao Chenhui-B35336; linuxppc-dev@lists.ozlabs.org
> >Subject: Re: [PATCH 2/7] powerpc/85xx: add HOTPLUG_CPU support
> >
> >On 11/08/2011 04:05 AM, Li Yang-R58472 wrote:
> >>> Subject: Re: [PATCH 2/7] powerpc/85xx: add HOTPLUG_CPU support
> >>>
> >>>> +	flush_disable_L1();
> >>>
> >>> You'll also need to take down L2 on e500mc.
> >>
> >> Right.  E500mc support is beyond this patch series.  We will work on it
> >after the e500v2 support is finalized.
> >
> >I saw some support with "is_corenet"...  If we don't support e500mc, make
> >sure the code doesn't try to run on e500mc.
> 
> The is_corenet code is just a start of the e500mc support and is far from complete.
> 
> >
> >This isn't an e500v2-only BSP you're putting the code into. :-)
> 
> Yes, I know.  But it will take quite some time to perfect the support
> for different type of cores. 

That's fine, I'm just asking for it to be clearer that e500mc/corenet is TODO,
and ideally for the code to reject hotplug if is_corenet is set, until it's
supported.

> >>>> +static int __cpuinit smp_85xx_map_bootpg(u32 page) {
> >>>> +	__iomem u32 *bootpg_ptr;
> >>>> +	u32 bptr;
> >>>> +
> >>>> +	/* Get the BPTR */
> >>>> +	bootpg_ptr = ioremap(get_immrbase() + MPC85xx_BPTR_OFF, 4);
> >>>> +
> >>>> +	/* Set the BPTR to the secondary boot page */
> >>>> +	bptr = MPC85xx_BPTR_EN | (page & MPC85xx_BPTR_BOOT_PAGE_MASK);
> >>>> +	out_be32(bootpg_ptr, bptr);
> >>>> +
> >>>> +	iounmap(bootpg_ptr);
> >>>> +	return 0;
> >>>> +}
> >>>
> >>> Shouldn't the boot page already be set by U-Boot?
> >>
> >> The register should be lost after a deep sleep.   Better to do it again.
> >
> >How can it be lost after a deep sleep if we're relying on it to hold our
> >wakeup code?
> 
> In order to wake up from deep sleep, the boot page has been set to the
> deep sleep restoration function.  We need to set it back to the
> bootpage from u-boot.

Ah.  That deserves a code comment.

> >It's not "better to do it again" if we're making a bad assumption about
> >the code and the table being in the same page.
> 
> Currently we are reusing the whole boot page including the spin-table
> from u-boot.  Are you suggesting to move just the boot page to kernel?

Just that it might be better to make sure that we put the same value in
BPTR that was in it when Linux booted, rather than assume that the page
that holds the spin table itself is the right one.

-Scott
