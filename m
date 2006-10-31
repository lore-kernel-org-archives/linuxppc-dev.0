Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/2] Add MPC52xx Interrupt controller support for
	ARCH=powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nicolas DET <nd@bplan-gmbh.de>
In-Reply-To: <4546F7DE.6070104@bplan-gmbh.de>
References: <200610292310.k9TNAHXZ013852@post.webmailer.de>
	<7BDB728E-0CC2-4940-9856-B496022F3482@kernel.crashing.org>
	<4546F7DE.6070104@bplan-gmbh.de>
Content-Type: text/plain
Date: Tue, 31 Oct 2006 18:38:55 +1100
Message-Id: <1162280335.25682.302.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, sl@bplan-gmbh.de, sha@pengutronix.de,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Well, on a personal point of view, the only usable mailer I know does 
> not run on my 'work' OS. I'll copy/paste from an editor ;-)

And both are ? (mailer and 'work' OS ? :)

> > +/* MBAR position */
> > +#define MPC52xx_MBAR        0xf0000000    /* Phys address */
> > +#define MPC52xx_MBAR_VIRT    0xf0000000    /* Virt address */
> > +#define MPC52xx_MBAR_SIZE    0x00010000
> > +
> > +#define MPC52xx_PA(x)        ((phys_addr_t)(MPC52xx_MBAR + (x)))
> > +#define MPC52xx_VA(x)        ((void __iomem *)(MPC52xx_MBAR_VIRT + (x)))
> > 
> > This should be handled dynamically (pulled from the device tree), I 
> > doubt MBAR will be at the same location for all boards.
> 
> Well, 0xf000000 seems some kind of 'standart' value. we could have a 
> global variable 'mpc52xx_mbar' which would be default 0xf0000000 and 
> modified by each platform.

No. No magic globals. If we need some common code for dealing with some
52xx specific bits, them have a file somewhere, possibly in sysdev,
containing those and exposing functions.

> > * can you split out the interrupt controller header info into a 
> > mpc52xx_pic.h [mpc52xx_intr, MPC52xx_IRQ_...]
> 
> Well, I dod personally have the whole structure/define in a single 
> header rather than splitting in xxx files.
