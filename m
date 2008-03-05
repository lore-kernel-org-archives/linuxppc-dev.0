Return-Path: <phdm@macqel.be>
Received: from mail.macqel.be (mail.macqel.be [194.78.208.39])
	by ozlabs.org (Postfix) with ESMTP id 58E90DDF57
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Mar 2008 03:15:35 +1100 (EST)
Date: Wed, 5 Mar 2008 17:15:10 +0100
From: Philippe De Muyter <phdm@macqel.be>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: ARCH=ppc -> ARCH=powerpc : help needed for dts file
Message-ID: <20080305161509.GA7596@netgate.macqel>
References: <20080303144727.GA27949@ingate.macqel>
	<20080303170719.GC28951@ld0162-tx32.am.freescale.net>
	<20080303210532.GA20382@netgate.macqel>
	<47CC696C.4090103@freescale.com>
	<20080303212622.GB20382@netgate.macqel>
	<47CC73CE.4080801@freescale.com>
	<20080304080828.GA18829@netgate.macqel>
	<1204618939.21545.52.camel@pasglop>
	<20080304091059.GD18829@netgate.macqel>
	<1204693264.21545.165.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1204693264.21545.165.camel@pasglop>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Ben,

thanks for all the answers,

On Wed, Mar 05, 2008 at 04:01:04PM +1100, Benjamin Herrenschmidt wrote:
> 
> > I also attach my current (not working) dts file attempt.  It is actually
> > a modified mpc8540ads.dts file.
> > 
> > I now thinks that the ide-cs (hda) discovery or not depends on the cold
> > or warm reboot.
> > 
> > Here are the patches for my config (MEIP_8540) relative to a vanilla
> > linux-2.6.24.  I hacked the MPC8540ADS config. The PCI4520 is the
> > multi-function chip from TI (dual-socket pc-card + iee1394 ohci and two-port
> > phy)
> 
>  .../...
> 
> > +#ifdef CONFIG_MEIP_8540
> > +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	// External 0 : nINTPFO
> > +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	// External 1 : nINTRTC
> > +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	// External 2 : nINTPLD
> > +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	// External 3 : nINTSTX
> > +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	// External 4 : nINTPHY
> > +#if defined(CONFIG_PCI)
> > +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),      /* External 5 : PCI4520 MFUNC 0 */
> > +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),      /* External 6 : PCI4520 MFUNC 1 */
> > +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),      /* External 7 : PCI4520 MFUNC 2 */
> > +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),      /* External 8 : PCI4520 MFUNC 3 */
> > +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),      /* External 9 : PCI4520 MFUNC 4 */
> > +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),      /* External 10 : PCI4520 MFUNC 5 */
> > +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),      /* External 11 : PCI4520 MFUNC 6 */
> > +#else
> > +	0x0,						/* External  6: */
> > +	0x0,						/* External  7: */
> > +	0x0,						/* External  8: */
> > +	0x0,						/* External  9: */
> > +	0x0,						/* External 10: */
> > +	0x0,						/* External 11: */
> > +#endif
> > +#else
> >  	0x0,						/* External  0: */
> >  #if defined(CONFIG_PCI)
> >  	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* External 1: PCI slot 0 */
> > @@ -77,6 +100,7 @@
> >  	0x0,				/* External  9: */
> >  	0x0,				/* External 10: */
> >  	0x0,				/* External 11: */
> > +#endif
> >  };
> 
> Ok, so based on the above, I deduce that you have 12 external interrupt
> sources:
> 
> 0...4 are those nINT* things. They correspond apparently do discrete
> devices on your board. You will have to create device nodes in your .dts
> for these with the appropriate interrupts property for each of these.
> 
> The rest are ... hrm... weird. You -appear- to have 5 to 8 going to PCI,
> to PIRQA...D. Do that mean that you have wired your connectors on the board
> such that the interrupt does not depend on the actual slot number ?

I asked the guy who designed the hardware, and if I understand correctly :

- the i/o and memory resources of the pci device are connected to the pci bus
- the interrupts are directly connected to the MPIC

Can I describe that in the dts file ?

Philippe

> 
> Or are you doing some swizzling ?
> 
> Also, I would need to know how those external IRQs are connected to the MPIC,
> I don't have the spec of that chip here. Hrm. Somebody from freescale can
> help him here ?
> 
> It's also not clear to me what your interrupts 9 10 and 11 are since you
> seem to only talk about PIRQA...D which is only 4 lines ..
> 
> So at this stage, that's not enough information. We need to know exactly how
> you have wired things on your board, and somebody from fsl needs to tell
> me how the ExtIrq are routed to the MPIC on that guy.
> 
> Once that's done, you seem to have grasped the interrupt map... for any
> device or slot, you provide the mapping between idsel/pirq line on one side,
> and mpic interrupt & sense on the other. For PCI, sense is always 1 for an
> mpic so you mostly have to check your actual MPIC source numbers.
> 
> >From your .dts, I see you've been doing some swizzling of slots using
> interrupts 1...4 ... do that correspond to EXTIRQ 5....8 ?
> 
> Ben.
> 
> >  
> >  /* ************************************************************************ */
> > --- ./arch/ppc/platforms/85xx/mpc85xx_ads_common.hbk	2008-01-24 22:58:37.000000000 +0000
> > +++ ./arch/ppc/platforms/85xx/mpc85xx_ads_common.h	2008-02-20 16:36:07.000000000 +0000
> > @@ -29,10 +29,17 @@
> >  extern void mpc85xx_ads_map_io(void) __init;
> >  
> >  /* PCI interrupt controller */
> > +#ifdef CONFIG_MEIP_8540
> > +#define PIRQA		MPC85xx_IRQ_EXT5
> > +#define PIRQB		MPC85xx_IRQ_EXT6
> > +#define PIRQC		MPC85xx_IRQ_EXT7
> > +#define PIRQD		MPC85xx_IRQ_EXT8
> > +#else
> >  #define PIRQA		MPC85xx_IRQ_EXT1
> >  #define PIRQB		MPC85xx_IRQ_EXT2
> >  #define PIRQC		MPC85xx_IRQ_EXT3
> >  #define PIRQD		MPC85xx_IRQ_EXT4
> > +#endif
> >  
> >  #define MPC85XX_PCI1_LOWER_IO	0x00000000
> >  #define MPC85XX_PCI1_UPPER_IO	0x00ffffff
