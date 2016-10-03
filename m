Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3snplz2sfFzDqLv
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Oct 2016 04:23:10 +1100 (AEDT)
Message-ID: <1475515377.4917.7.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: "C.H. Zhao" <chenhui.zhao@nxp.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "z.chenhui@gmail.com" <z.chenhui@gmail.com>,  Jason Jin <jason.jin@nxp.com>
Date: Mon, 03 Oct 2016 12:22:57 -0500
In-Reply-To: <AM4PR0401MB2355465DF56ECC2CC4DF7E8B95CE0@AM4PR0401MB2355.eurprd04.prod.outlook.com>
References: <1470139172-12699-5-git-send-email-chenhui.zhao@nxp.com>
 ,<20160925072400.GA17928@home.buserror.net>
 <AM4PR0401MB23559F508FC92E0FD670998095CC0@AM4PR0401MB2355.eurprd04.prod.outlook.com>
 ,<1475092993.4283.51.camel@buserror.net>
 <AM4PR0401MB2355465DF56ECC2CC4DF7E8B95CE0@AM4PR0401MB2355.eurprd04.prod.outlook.com>
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

On Thu, 2016-09-29 at 10:21 +0000, C.H. Zhao wrote:
> 
> From: Scott Wood <oss@buserror.net>
> Sent: Thursday, September 29, 2016 4:03 AM
> To: C.H. Zhao
> Cc: linuxppc-dev@lists.ozlabs.org; linux-kernel@vger.kernel.org; z.chenhui@g
> mail.com; Jason Jin
> Subject: Re: [v3,4/5] powerpc/pm: support deep sleep feature on T104x
>     
> On Tue, 2016-09-27 at 11:05 +0000, C.H. Zhao wrote:
> > 
> > From: Scott Wood <oss@buserror.net>
> > Sent: Sunday, September 25, 2016 3:24 PM
> > To: C.H. Zhao
> > Cc: linuxppc-dev@lists.ozlabs.org; linux-kernel@vger.kernel.org; z.chenhui
> > @g
> > mail.com; Jason Jin
> > Subject: Re: [v3,4/5] powerpc/pm: support deep sleep feature on T104x
> >     
> > On Tue, Aug 02, 2016 at 07:59:31PM +0800, Chenhui Zhao wrote:
> > > 
> > > 
> > > T104x has deep sleep feature, which can switch off most parts of
> > > the SoC when it is in deep sleep mode. This way, it becomes more
> > > energy-efficient.
> > > 
> > > The DDR controller will also be powered off in deep sleep. Therefore,
> > > the last stage (the latter part of fsl_dp_enter_low) will run without
> > > DDR
> > > access. This piece of code and related TLBs are prefetched in advance.
> > > 
> > > Due to the different initialization code between 32-bit and 64-bit, they
> > > have separate resume entry and precedure.
> > > 
> > > The feature supports 32-bit and 64-bit kernel mode.
> > > 
> > > Signed-off-by: Chenhui Zhao <chenhui.zhao@nxp.com>
> > > ---
> > >   arch/powerpc/include/asm/fsl_pm.h             |  24 ++
> > >   arch/powerpc/kernel/asm-offsets.c             |  12 +
> > >   arch/powerpc/kernel/fsl_booke_entry_mapping.S |  10 +
> > >   arch/powerpc/kernel/head_64.S                 |   2 +-
> > >   arch/powerpc/platforms/85xx/Makefile          |   1 +
> > >   arch/powerpc/platforms/85xx/deepsleep.c       | 278 ++++++++++++++
> > >   arch/powerpc/platforms/85xx/qoriq_pm.c        |  25 ++
> > >   arch/powerpc/platforms/85xx/t104x_deepsleep.S | 531
> > > ++++++++++++++++++++++++++
> > >   arch/powerpc/sysdev/fsl_rcpm.c                |   8 +-
> > >   9 files changed, 889 insertions(+), 2 deletions(-)
> > >   create mode 100644 arch/powerpc/platforms/85xx/deepsleep.c
> > >   create mode 100644 arch/powerpc/platforms/85xx/t104x_deepsleep.S
> > > 
> > > diff --git a/arch/powerpc/include/asm/fsl_pm.h
> > > b/arch/powerpc/include/asm/fsl_pm.h
> > > index e05049b..48c2631 100644
> > > --- a/arch/powerpc/include/asm/fsl_pm.h
> > > +++ b/arch/powerpc/include/asm/fsl_pm.h
> > > @@ -20,6 +20,7 @@
> > >   
> > >   #define PLAT_PM_SLEEP        20
> > >   #define PLAT_PM_LPM20        30
> > > +#define PLAT_PM_LPM35        40
> > >   
> > >   #define FSL_PM_SLEEP         (1 << 0)
> > >   #define FSL_PM_DEEP_SLEEP    (1 << 1)
> > > @@ -48,4 +49,27 @@ extern const struct fsl_pm_ops *qoriq_pm_ops;
> > >   
> > >   int __init fsl_rcpm_init(void);
> > >   
> > > +#ifdef CONFIG_FSL_QORIQ_PM
> > > +int fsl_enter_deepsleep(void);
> > > +int fsl_deepsleep_init(void);
> > > +#else
> > > +static inline int fsl_enter_deepsleep(void) { return -1; }
> > > +static inline int fsl_deepsleep_init(void) { return -1; }
> > > +#endif
> > Please return proper error codes.
> > 
> > Where can fsl_deepsleep_init() be called without CONFIG_FSL_QORIQ_PM?
> > 
> > [Chenhui] I can get rid of the ifdef here. And add it
> > in arch/powerpc/sysdev/fsl_rcpm.c.
> No, this is the right place for the ifdef for functions that are called from
> code that doesn't depend on CONFIG_FSL_QORIQ_PM.  But fsl_deepsleep_init()
> is
> called from deepsleep.c which is only built with CONFIG_FSL_QORIQ_PM, and
> it's
> hard to picture a scenario where it would be called from elsewhere.
> 
> 
> [Chenhui] You are right. No need to enclose fsl_deepsleep_init() in the
> ifdef.
>                  But regarding fsl_enter_deepsleep(), it is called in
> rcpm_v2_plat_enter_sleep()
>                  in arch/powerpc/sysdev/fsl_rcpm.c. It still needs to be
> enclosed in the ifdef.

Right.  That's why I specifically asked about fsl_deepsleep_init(). :-)

-Scott
