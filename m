Return-Path: <chenhui.zhao@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe004.messaging.microsoft.com [213.199.154.207])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 563A92C00BD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Mar 2014 21:27:39 +1100 (EST)
Date: Mon, 17 Mar 2014 18:27:27 +0800
From: Chenhui Zhao <chenhui.zhao@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 7/9] fsl: add EPU FSM configuration for deep sleep
Message-ID: <20140317102727.GB6204@localhost.localdomain>
References: <1394168285-32275-1-git-send-email-chenhui.zhao@freescale.com>
 <1394168285-32275-7-git-send-email-chenhui.zhao@freescale.com>
 <1394582923.13761.81.camel@snotra.buserror.net>
 <20140312083410.GF4706@localhost.localdomain>
 <1394837469.12479.134.camel@snotra.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1394837469.12479.134.camel@snotra.buserror.net>
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

On Fri, Mar 14, 2014 at 05:51:09PM -0500, Scott Wood wrote:
> On Wed, 2014-03-12 at 16:34 +0800, Chenhui Zhao wrote:
> > On Tue, Mar 11, 2014 at 07:08:43PM -0500, Scott Wood wrote:
> > > On Fri, 2014-03-07 at 12:58 +0800, Chenhui Zhao wrote:
> > > > From: Hongbo Zhang <hongbo.zhang@freescale.com>
> > > > 
> > > > In the last stage of deep sleep, software will trigger a Finite
> > > > State Machine (FSM) to control the hardware precedure, such as
> > > > board isolation, killing PLLs, removing power, and so on.
> > > > 
> > > > When the system is waked up by an interrupt, the FSM controls the
> > > > hardware to complete the early resume precedure.
> > > > 
> > > > This patch configure the EPU FSM preparing for deep sleep.
> > > > 
> > > > Signed-off-by: Hongbo Zhang <hongbo.zhang@freescale.com>
> > > > Signed-off-by: Chenhui Zhao <chenhui.zhao@freescale.com>
> > > 
> > > Couldn't this be part of qoriq_pm.c?
> > 
> > Put the code in drivers/platform/fsl/ so that LS1 can share these code.
> 
> How can LS1 share it if it's got hardcoded T1040 values?
> 
> > > > diff --git a/drivers/platform/Kconfig b/drivers/platform/Kconfig
> > > > index 09fde58..6539e6d 100644
> > > > --- a/drivers/platform/Kconfig
> > > > +++ b/drivers/platform/Kconfig
> > > > @@ -6,3 +6,7 @@ source "drivers/platform/goldfish/Kconfig"
> > > >  endif
> > > >  
> > > >  source "drivers/platform/chrome/Kconfig"
> > > > +
> > > > +if FSL_SOC
> > > > +source "drivers/platform/fsl/Kconfig"
> > > > +endif
> > > 
> > > Chrome doesn't need an ifdef -- why does this?
> > 
> > Don't wish other platform see these options, and the X86 and GOLDFISH have
> > ifdefs.
> 
> The point is you can implement the dependency inside
> drivers/platform/fsl/Kconfig.

OK.

> 
> > > > diff --git a/drivers/platform/fsl/Makefile b/drivers/platform/fsl/Makefile
> > > > new file mode 100644
> > > > index 0000000..d99ca0e
> > > > --- /dev/null
> > > > +++ b/drivers/platform/fsl/Makefile
> > > > @@ -0,0 +1,5 @@
> > > > +#
> > > > +# Makefile for linux/drivers/platform/fsl
> > > > +# Freescale Specific Power Management Drivers
> > > > +#
> > > > +obj-$(CONFIG_FSL_SLEEP_FSM)	+= sleep_fsm.o
> > > 
> > > Why is this here while the other stuff is in arch/powerpc/sysdev?
> > > 
> > > > +/* Block offsets */
> > > > +#define	RCPM_BLOCK_OFFSET	0x00022000
> > > > +#define	EPU_BLOCK_OFFSET	0x00000000
> > > > +#define	NPC_BLOCK_OFFSET	0x00001000
> > > 
> > > Why don't these block offsets come from the device tree?
> > 
> > Have maped DCSR registers. Don't wish to remap them.
> 
> We don't wish to have hardcoded CCSR/DCSR offsets in the kernel source.
> Sorry.

OK.

>  
> > > > +	/* Configure the EPU Counters */
> > > > +	epu_write(EPCCR15, 0x92840000);
> > > > +	epu_write(EPCCR14, 0x92840000);
> > > > +	epu_write(EPCCR12, 0x92840000);
> > > > +	epu_write(EPCCR11, 0x92840000);
> > > > +	epu_write(EPCCR10, 0x92840000);
> > > > +	epu_write(EPCCR9, 0x92840000);
> > > > +	epu_write(EPCCR8, 0x92840000);
> > > > +	epu_write(EPCCR5, 0x92840000);
> > > > +	epu_write(EPCCR4, 0x92840000);
> > > > +	epu_write(EPCCR2, 0x92840000);
> > > > +
> > > > +	/* Configure the SCUs Inputs */
> > > > +	epu_write(EPSMCR15, 0x76000000);
> > > > +	epu_write(EPSMCR14, 0x00000031);
> > > > +	epu_write(EPSMCR13, 0x00003100);
> > > > +	epu_write(EPSMCR12, 0x7F000000);
> > > > +	epu_write(EPSMCR11, 0x31740000);
> > > > +	epu_write(EPSMCR10, 0x65000030);
> > > > +	epu_write(EPSMCR9, 0x00003000);
> > > > +	epu_write(EPSMCR8, 0x64300000);
> > > > +	epu_write(EPSMCR7, 0x30000000);
> > > > +	epu_write(EPSMCR6, 0x7C000000);
> > > > +	epu_write(EPSMCR5, 0x00002E00);
> > > > +	epu_write(EPSMCR4, 0x002F0000);
> > > > +	epu_write(EPSMCR3, 0x2F000000);
> > > > +	epu_write(EPSMCR2, 0x6C700000);
> > > 
> > > Where do these magic numbers come from?  Which chips are they valid for?
> > 
> > They are for T1040. Can be found in the RCPM chapter of T1040RM.
> 
> Then put in a comment to that effect, including what part of the RCPM
> chapter.
> 
> How do you plan to handle the addition of another SoC with different
> values?
> 
> -Scott

Had thought that using an array to put these values (pairs of offset and value)
and passing the array to the function.

However, luckily T104x and LS1 have same values for these registers
according to the current Reference Manuals.

-Chenhui
