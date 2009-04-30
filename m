Return-Path: <mikey@neuling.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 87FD3DDED6
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Apr 2009 10:24:44 +1000 (EST)
From: Michael Neuling <mikey@neuling.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/2] powerpc: Move VSX load/stores into ppc-opcode.h 
In-reply-to: <1271A9EB-6489-4A72-B3A0-0C36AEE554CB@kernel.crashing.org> 
References: <20090429072040.A3C761222D@localhost.localdomain>
	<1271A9EB-6489-4A72-B3A0-0C36AEE554CB@kernel.crashing.org>
Date: Thu, 30 Apr 2009 10:24:44 +1000
Message-ID: <23749.1241051084@neuling.org>
Cc: Paul Mackerras <paulus@samba.org>, Milton Miller <miltonm@bga.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> > Index: linux-2.6-ozlabs/arch/powerpc/include/asm/ppc-opcode.h
> > ===================================================================
> > --- linux-2.6-ozlabs.orig/arch/powerpc/include/asm/ppc-opcode.h
> > +++ linux-2.6-ozlabs/arch/powerpc/include/asm/ppc-opcode.h
> > @@ -49,6 +49,7 @@
> > /* macros to insert fields into opcodes */
> > #define __PPC_RA(a)	(((a) & 0x1f) << 16)
> > #define __PPC_RB(b)	(((b) & 0x1f) << 11)
> > +#define __PPC_XS(s)	((((s) & 0x1f) << 21) | (((s) & 0x20) >> 5))
> > #define __PPC_T_TLB(t)	(((t) & 0x3) << 21)
> > #define __PPC_WC(w)	(((w) & 0x3) << 21)
> >
> > @@ -70,4 +71,12 @@
> > #define PPC_WAIT(w)		stringify_in_c(.long PPC_INST_WAIT | \
> > 					__PPC_WC(w))
> >
> > +/*
> > + * Define what the VSX XX1 form instructions will look like, then add
> > + * the 128 bit load store instructions based on that.
> > + */
> > +#define VSX_XX1(s, a, b)	(__PPC_XS(s) | __PPC_RA(a) | __PPC_RB(b))
> > +#define STXVD2X(s, a, b)	.long (0x7c000798 | VSX_XX1((s), (a), (b)))
> > +#define LXVD2X(s, a, b)		.long (0x7c000698 | VSX_XX1((s), (a), (
b)))
> > +
> 
> previous gripe of matching style of file for the .long 0x7c000798

Sorry, yes.  

I also didn't sort the PPC_INST_* alphabetically for the tlbie patch.

Mikey
