Return-Path: <chenhui.zhao@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe001.messaging.microsoft.com [213.199.154.204])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 023322C00A5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Mar 2014 19:34:19 +1100 (EST)
Date: Wed, 12 Mar 2014 16:34:10 +0800
From: Chenhui Zhao <chenhui.zhao@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 7/9] fsl: add EPU FSM configuration for deep sleep
Message-ID: <20140312083410.GF4706@localhost.localdomain>
References: <1394168285-32275-1-git-send-email-chenhui.zhao@freescale.com>
 <1394168285-32275-7-git-send-email-chenhui.zhao@freescale.com>
 <1394582923.13761.81.camel@snotra.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1394582923.13761.81.camel@snotra.buserror.net>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Jason.Jin@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 11, 2014 at 07:08:43PM -0500, Scott Wood wrote:
> On Fri, 2014-03-07 at 12:58 +0800, Chenhui Zhao wrote:
> > From: Hongbo Zhang <hongbo.zhang@freescale.com>
> > 
> > In the last stage of deep sleep, software will trigger a Finite
> > State Machine (FSM) to control the hardware precedure, such as
> > board isolation, killing PLLs, removing power, and so on.
> > 
> > When the system is waked up by an interrupt, the FSM controls the
> > hardware to complete the early resume precedure.
> > 
> > This patch configure the EPU FSM preparing for deep sleep.
> > 
> > Signed-off-by: Hongbo Zhang <hongbo.zhang@freescale.com>
> > Signed-off-by: Chenhui Zhao <chenhui.zhao@freescale.com>
> 
> Couldn't this be part of qoriq_pm.c?

Put the code in drivers/platform/fsl/ so that LS1 can share these code.

> 
> > diff --git a/arch/powerpc/sysdev/fsl_soc.h b/arch/powerpc/sysdev/fsl_soc.h
> > index 9b9a34a..eb83a30 100644
> > --- a/arch/powerpc/sysdev/fsl_soc.h
> > +++ b/arch/powerpc/sysdev/fsl_soc.h
> > @@ -69,5 +69,8 @@ extern const struct fsl_pm_ops *qoriq_pm_ops;
> >  
> >  extern int fsl_rcpm_init(void);
> >  
> > +extern void fsl_dp_fsm_setup(void *dcsr_base);
> > +extern void fsl_dp_fsm_clean(void *dcsr_base);
> 
> __iomem

Thanks. Will add.

> 
> > +
> >  #endif
> >  #endif
> > diff --git a/drivers/platform/Kconfig b/drivers/platform/Kconfig
> > index 09fde58..6539e6d 100644
> > --- a/drivers/platform/Kconfig
> > +++ b/drivers/platform/Kconfig
> > @@ -6,3 +6,7 @@ source "drivers/platform/goldfish/Kconfig"
> >  endif
> >  
> >  source "drivers/platform/chrome/Kconfig"
> > +
> > +if FSL_SOC
> > +source "drivers/platform/fsl/Kconfig"
> > +endif
> 
> Chrome doesn't need an ifdef -- why does this?

Don't wish other platform see these options, and the X86 and GOLDFISH have
ifdefs.

> 
> > diff --git a/drivers/platform/Makefile b/drivers/platform/Makefile
> > index 3656b7b..37c6f72 100644
> > --- a/drivers/platform/Makefile
> > +++ b/drivers/platform/Makefile
> > @@ -6,3 +6,4 @@ obj-$(CONFIG_X86)		+= x86/
> >  obj-$(CONFIG_OLPC)		+= olpc/
> >  obj-$(CONFIG_GOLDFISH)		+= goldfish/
> >  obj-$(CONFIG_CHROME_PLATFORMS)	+= chrome/
> > +obj-$(CONFIG_FSL_SOC)		+= fsl/
> > diff --git a/drivers/platform/fsl/Kconfig b/drivers/platform/fsl/Kconfig
> > new file mode 100644
> > index 0000000..72ed053
> > --- /dev/null
> > +++ b/drivers/platform/fsl/Kconfig
> > @@ -0,0 +1,10 @@
> > +#
> > +# Freescale Specific Power Management Drivers
> > +#
> > +
> > +config FSL_SLEEP_FSM
> > +	bool
> > +	help
> > +	  This driver configures a hardware FSM (Finite State Machine) for deep sleep.
> > +	  The FSM is used to finish clean-ups at the last stage of system entering deep
> > +	  sleep, and also wakes up system when a wake up event happens.
> > diff --git a/drivers/platform/fsl/Makefile b/drivers/platform/fsl/Makefile
> > new file mode 100644
> > index 0000000..d99ca0e
> > --- /dev/null
> > +++ b/drivers/platform/fsl/Makefile
> > @@ -0,0 +1,5 @@
> > +#
> > +# Makefile for linux/drivers/platform/fsl
> > +# Freescale Specific Power Management Drivers
> > +#
> > +obj-$(CONFIG_FSL_SLEEP_FSM)	+= sleep_fsm.o
> 
> Why is this here while the other stuff is in arch/powerpc/sysdev?
> 
> > +/* Block offsets */
> > +#define	RCPM_BLOCK_OFFSET	0x00022000
> > +#define	EPU_BLOCK_OFFSET	0x00000000
> > +#define	NPC_BLOCK_OFFSET	0x00001000
> 
> Why don't these block offsets come from the device tree?

Have maped DCSR registers. Don't wish to remap them.

> 
> > +static void *g_dcsr_base;
> 
> __iomem

OK.

> 
> > +	/* Configure the EPU Counters */
> > +	epu_write(EPCCR15, 0x92840000);
> > +	epu_write(EPCCR14, 0x92840000);
> > +	epu_write(EPCCR12, 0x92840000);
> > +	epu_write(EPCCR11, 0x92840000);
> > +	epu_write(EPCCR10, 0x92840000);
> > +	epu_write(EPCCR9, 0x92840000);
> > +	epu_write(EPCCR8, 0x92840000);
> > +	epu_write(EPCCR5, 0x92840000);
> > +	epu_write(EPCCR4, 0x92840000);
> > +	epu_write(EPCCR2, 0x92840000);
> > +
> > +	/* Configure the SCUs Inputs */
> > +	epu_write(EPSMCR15, 0x76000000);
> > +	epu_write(EPSMCR14, 0x00000031);
> > +	epu_write(EPSMCR13, 0x00003100);
> > +	epu_write(EPSMCR12, 0x7F000000);
> > +	epu_write(EPSMCR11, 0x31740000);
> > +	epu_write(EPSMCR10, 0x65000030);
> > +	epu_write(EPSMCR9, 0x00003000);
> > +	epu_write(EPSMCR8, 0x64300000);
> > +	epu_write(EPSMCR7, 0x30000000);
> > +	epu_write(EPSMCR6, 0x7C000000);
> > +	epu_write(EPSMCR5, 0x00002E00);
> > +	epu_write(EPSMCR4, 0x002F0000);
> > +	epu_write(EPSMCR3, 0x2F000000);
> > +	epu_write(EPSMCR2, 0x6C700000);
> 
> Where do these magic numbers come from?  Which chips are they valid for?

They are for T1040. Can be found in the RCPM chapter of T1040RM.

> 
> > +void fsl_dp_fsm_clean(void *dcsr_base)
> > +{
> > +
> > +	epu_write(EPEVTCR2, 0);
> > +	epu_write(EPEVTCR9, 0);
> > +
> > +	epu_write(EPGCR, 0);
> > +	epu_write(EPECR15, 0);
> > +
> > +	rcpm_write(CSTTACR0, 0);
> > +	rcpm_write(CG1CR0, 0);
> > +
> > +}
> 
> Don't put blank lines at the beginning/end of a block.
> 
> -Scott

Thanks.

-Chenhui
