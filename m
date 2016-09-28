Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3skpY95gGzzDrZl
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Sep 2016 06:03:25 +1000 (AEST)
Message-ID: <1475092993.4283.51.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: "C.H. Zhao" <chenhui.zhao@nxp.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "z.chenhui@gmail.com" <z.chenhui@gmail.com>,  Jason Jin <jason.jin@nxp.com>
Date: Wed, 28 Sep 2016 15:03:13 -0500
In-Reply-To: <AM4PR0401MB23559F508FC92E0FD670998095CC0@AM4PR0401MB2355.eurprd04.prod.outlook.com>
References: <1470139172-12699-5-git-send-email-chenhui.zhao@nxp.com>
 ,<20160925072400.GA17928@home.buserror.net>
 <AM4PR0401MB23559F508FC92E0FD670998095CC0@AM4PR0401MB2355.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [v3,4/5] powerpc/pm: support deep sleep feature on T104x
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-09-27 at 11:05 +0000, C.H. Zhao wrote:
> From: Scott Wood <oss@buserror.net>
> Sent: Sunday, September 25, 2016 3:24 PM
> To: C.H. Zhao
> Cc: linuxppc-dev@lists.ozlabs.org; linux-kernel@vger.kernel.org; z.chenhui@g
> mail.com; Jason Jin
> Subject: Re: [v3,4/5] powerpc/pm: support deep sleep feature on T104x
>     
> On Tue, Aug 02, 2016 at 07:59:31PM +0800, Chenhui Zhao wrote:
> > 
> > T104x has deep sleep feature, which can switch off most parts of
> > the SoC when it is in deep sleep mode. This way, it becomes more
> > energy-efficient.
> > 
> > The DDR controller will also be powered off in deep sleep. Therefore,
> > the last stage (the latter part of fsl_dp_enter_low) will run without DDR
> > access. This piece of code and related TLBs are prefetched in advance.
> > 
> > Due to the different initialization code between 32-bit and 64-bit, they
> > have separate resume entry and precedure.
> > 
> > The feature supports 32-bit and 64-bit kernel mode.
> > 
> > Signed-off-by: Chenhui Zhao <chenhui.zhao@nxp.com>
> > ---
> >   arch/powerpc/include/asm/fsl_pm.h             |  24 ++
> >   arch/powerpc/kernel/asm-offsets.c             |  12 +
> >   arch/powerpc/kernel/fsl_booke_entry_mapping.S |  10 +
> >   arch/powerpc/kernel/head_64.S                 |   2 +-
> >   arch/powerpc/platforms/85xx/Makefile          |   1 +
> >   arch/powerpc/platforms/85xx/deepsleep.c       | 278 ++++++++++++++
> >   arch/powerpc/platforms/85xx/qoriq_pm.c        |  25 ++
> >   arch/powerpc/platforms/85xx/t104x_deepsleep.S | 531
> > ++++++++++++++++++++++++++
> >   arch/powerpc/sysdev/fsl_rcpm.c                |   8 +-
> >   9 files changed, 889 insertions(+), 2 deletions(-)
> >   create mode 100644 arch/powerpc/platforms/85xx/deepsleep.c
> >   create mode 100644 arch/powerpc/platforms/85xx/t104x_deepsleep.S
> > 
> > diff --git a/arch/powerpc/include/asm/fsl_pm.h
> > b/arch/powerpc/include/asm/fsl_pm.h
> > index e05049b..48c2631 100644
> > --- a/arch/powerpc/include/asm/fsl_pm.h
> > +++ b/arch/powerpc/include/asm/fsl_pm.h
> > @@ -20,6 +20,7 @@
> >   
> >   #define PLAT_PM_SLEEP        20
> >   #define PLAT_PM_LPM20        30
> > +#define PLAT_PM_LPM35        40
> >   
> >   #define FSL_PM_SLEEP         (1 << 0)
> >   #define FSL_PM_DEEP_SLEEP    (1 << 1)
> > @@ -48,4 +49,27 @@ extern const struct fsl_pm_ops *qoriq_pm_ops;
> >   
> >   int __init fsl_rcpm_init(void);
> >   
> > +#ifdef CONFIG_FSL_QORIQ_PM
> > +int fsl_enter_deepsleep(void);
> > +int fsl_deepsleep_init(void);
> > +#else
> > +static inline int fsl_enter_deepsleep(void) { return -1; }
> > +static inline int fsl_deepsleep_init(void) { return -1; }
> > +#endif
> Please return proper error codes.
> 
> Where can fsl_deepsleep_init() be called without CONFIG_FSL_QORIQ_PM?
> 
> [Chenhui] I can get rid of the ifdef here. And add it
> in arch/powerpc/sysdev/fsl_rcpm.c.

No, this is the right place for the ifdef for functions that are called from
code that doesn't depend on CONFIG_FSL_QORIQ_PM.  But fsl_deepsleep_init() is
called from deepsleep.c which is only built with CONFIG_FSL_QORIQ_PM, and it's
hard to picture a scenario where it would be called from elsewhere.

> > diff --git a/arch/powerpc/kernel/fsl_booke_entry_mapping.S
> > b/arch/powerpc/kernel/fsl_booke_entry_mapping.S
> > index 83dd0f6..659b059 100644
> > --- a/arch/powerpc/kernel/fsl_booke_entry_mapping.S
> > +++ b/arch/powerpc/kernel/fsl_booke_entry_mapping.S
> > @@ -173,6 +173,10 @@ skpinv:  addi    r6,r6,1                         /*
> > Increment */
> >         lis     r6,MAS2_VAL(PAGE_OFFSET, BOOK3E_PAGESZ_64M, M_IF_NEEDED)@h
> >         ori     r6,r6,MAS2_VAL(PAGE_OFFSET, BOOK3E_PAGESZ_64M,
> > M_IF_NEEDED)@l
> >         mtspr   SPRN_MAS2,r6
> > +#ifdef ENTRY_DEEPSLEEP_SETUP
> > +     LOAD_REG_IMMEDIATE(r8, MEMORY_START)
> > +     ori     r8,r8,(MAS3_SX|MAS3_SW|MAS3_SR)
> > +#endif
> >         mtspr   SPRN_MAS3,r8
> >         tlbwe
> >   
> Have you tried this with a relocatable kernel?
> 
> [Chenhui] Not yet. Not sure whether it has been supported on QorIQ platform.

It is supported, and deep sleep needs to work with it.

> > +static void fsl_dp_set_resume_pointer(void)
> > +{
> > +     u32 resume_addr;
> > +
> > +     /* the bootloader will finally jump to this address to return kernel
> > */
> > +#ifdef CONFIG_PPC32
> > +     resume_addr = (u32)(__pa(fsl_booke_deep_sleep_resume));
> > +#else
> > +     resume_addr = (u32)(__pa(*(u64 *)fsl_booke_deep_sleep_resume)
> > +                         & 0xffffffff);
> > +#endif
> Why are you masking the physical address by 0xffffffff?  Besides the
> (u32) cast accomplishing the same thing, wouldn't it be a problem if
> (e.g. due to a relocatable kernel) the address is above 4 GiB?
> 
> [Chenhui] Here, I assumed kernel is below 4 GiB. Maybe I should add a
> comment here.

It needs a fix rather than a comment, unless you can show that the relocatable
mechanism doesn't support kernels over 4 GiB (I don't remember of the top of
my head whether it does).

-Scott
