Return-Path: <zch@az84smr01.freescale.net>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe004.messaging.microsoft.com [216.32.180.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1026DB6EE7
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jun 2012 21:34:57 +1000 (EST)
Received: from mail46-va3 (localhost [127.0.0.1])	by mail46-va3-R.bigfish.com
 (Postfix) with ESMTP id B0348300355	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Jun 2012 11:34:10 +0000 (UTC)
Received: from VA3EHSMHS030.bigfish.com (unknown [10.7.14.248])	by
 mail46-va3.bigfish.com (Postfix) with ESMTP id 7EEC82A0048	for
 <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jun 2012 11:34:08 +0000 (UTC)
Received: from localhost.localdomain ([10.213.130.145])	by
 az84smr01.freescale.net (8.14.3/8.14.0) with ESMTP id q55BYji0021233	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Jun 2012 04:34:46 -0700
Date: Tue, 5 Jun 2012 19:35:30 +0800
From: Zhao Chenhui <chenhui.zhao@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v5 3/5] powerpc/85xx: add sleep and deep sleep support
Message-ID: <20120605113530.GC22427@localhost.localdomain>
References: <1336737235-15370-1-git-send-email-chenhui.zhao@freescale.com>
 <1336737235-15370-3-git-send-email-chenhui.zhao@freescale.com>
 <4FC93A1B.8060209@freescale.com>
 <20120604111206.GB20676@localhost.localdomain>
 <4FCD3D9E.9010509@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <4FCD3D9E.9010509@freescale.com>
Sender: <zch@az84smr01.freescale.net>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 04, 2012 at 05:58:38PM -0500, Scott Wood wrote:
> On 06/04/2012 06:12 AM, Zhao Chenhui wrote:
> > On Fri, Jun 01, 2012 at 04:54:35PM -0500, Scott Wood wrote:
> >> On 05/11/2012 06:53 AM, Zhao Chenhui wrote:
> >>> diff --git a/arch/powerpc/include/asm/cacheflush.h b/arch/powerpc/include/asm/cacheflush.h
> >>> index 94ec20a..baa000c 100644
> >>> --- a/arch/powerpc/include/asm/cacheflush.h
> >>> +++ b/arch/powerpc/include/asm/cacheflush.h
> >>> @@ -33,6 +33,11 @@ extern void flush_dcache_page(struct page *page);
> >>>  #if defined(CONFIG_FSL_BOOKE) || defined(CONFIG_6xx)
> >>>  extern void __flush_disable_L1(void);
> >>>  #endif
> >>> +#if defined(CONFIG_FSL_BOOKE)
> >>> +extern void flush_dcache_L1(void);
> >>> +#else
> >>> +#define flush_dcache_L1()	do { } while (0)
> >>> +#endif
> >>
> >> It doesn't seem right to no-op this on other platforms.
> > 
> > The pmc_suspend_enter() in fsl_pmc.c used by mpc85xx and mpc86xx,
> > but flush_dcache_L1() have no definition in mpc86xx platform.
> > I will write flush_dcache_L1() for mpc86xx platform.
> 
> How about only calling the function when it's needed?  If we didn't need
> an L1 flush here on 86xx before, why do we need it now?

How about using CONFIG_PPC_85xx to gard it, like this.

	case PM_SUSPEND_STANDBY:
		local_irq_disable();
#ifdef CONFIG_PPC_85xx
		flush_dcache_L1();
#endif
		setbits32(&pmc_regs->powmgtcsr, POWMGTCSR_SLP);

> 
> >>>  extern void __flush_icache_range(unsigned long, unsigned long);
> >>>  static inline void flush_icache_range(unsigned long start, unsigned long stop)
> >>> diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
> >>> index f5808a3..cb70dba 100644
> >>> --- a/arch/powerpc/kernel/Makefile
> >>> +++ b/arch/powerpc/kernel/Makefile
> >>> @@ -64,6 +64,9 @@ obj-$(CONFIG_FA_DUMP)		+= fadump.o
> >>>  ifeq ($(CONFIG_PPC32),y)
> >>>  obj-$(CONFIG_E500)		+= idle_e500.o
> >>>  endif
> >>> +ifneq ($(CONFIG_PPC_E500MC),y)
> >>> +obj-$(CONFIG_PPC_85xx)		+= l2cache_85xx.o
> >>> +endif
> >>
> >> Can we introduce a symbol that specifically means pre-e500mc e500,
> >> rather than using negative logic?
> >>
> >> I think something like CONFIG_PPC_E500_V1_V2 has been proposed before.
> > 
> > Agree. But CONFIG_PPC_E500_V1_V2 haven't been merged.
> 
> Has the concept been NACKed, or just forgotten?  If the latter, you
> could include it in this patchset.
> 
> -Scott

In patchwork, it's state is "Superseded".
http://patchwork.ozlabs.org/patch/124284/

-Chenhui
