Return-Path: <kim.phillips@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 59B9967C84
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Nov 2006 09:10:02 +1100 (EST)
Date: Wed, 22 Nov 2006 16:09:57 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Add support for FP emulation for the e300c2 core
Message-Id: <20061122160957.5b516c65.kim.phillips@freescale.com>
In-Reply-To: <1164231274.5653.28.camel@localhost.localdomain>
References: <20061122142020.3e700bac.kim.phillips@freescale.com>
	<1164231274.5653.28.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 23 Nov 2006 08:34:34 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> > +BEGIN_FTR_SECTION
> > +/*
> > + * certain freescale cores treat 'normal' floating point instructions
> > + * as FP Unavail exception.  Redirect to normal illegal/emulation handling.
> > + */
> > +	b 	ProgramCheck
> > +END_FTR_SECTION_IFSET(CPU_FTR_FP_TAKES_FPUNAVAIL)
> >  	EXCEPTION_PROLOG
> >  	bne	load_up_fpu		/* if from user, just load it up */
> >  	addi	r3,r1,STACK_FRAME_OVERHEAD
> 
> Do you absolutely need that ? Is there any way those cores will actually

The feature section provides a means of distinguishing among other processors (i.e. those with FPUs) at runtime.

> send a "normal" FPUnavail exception ? If not, don't bother. There aren't

no, it never takes the Illegal instruction/ProgramCheck exception by itself when a FP insn is in the pipe.

> that many CPU feature bits left so let's not use one for something that
> never happens.
> 
this happens when executing a binary with FP instructions compiled in.  This feature will be reused when support for other FPUless core variants coming from freescale are added.

Kim
