Return-Path: <mikey@neuling.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1C9D6DDE0A
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 22:40:34 +1000 (EST)
From: Michael Neuling <mikey@neuling.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/2] powerpc: Add 2.06 tlbie mnemonics 
In-reply-to: <B5DD5BF4-8EFF-472F-9D96-DE2941AAD70B@kernel.crashing.org> 
References: <20090428050338.221EF1EA0F4@localhost.localdomain>
	<B5DD5BF4-8EFF-472F-9D96-DE2941AAD70B@kernel.crashing.org>
Date: Tue, 28 Apr 2009 22:40:30 +1000
Message-ID: <30284.1240922430@neuling.org>
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

Kumar,

> > From: Milton Miller <miltonm@bga.com>
> >
> > This adds the PowerPC 2.06 tlbie mnemonics and keeps backwards
> > compatibilty for CPUs before 2.06.
> >
> > Only useful for bare metal systems.
> >
> > Signed-off-by: Milton Miller <miltonm@bga.com>
> > Signed-off-by: Michael Neuling <mikey@neuling.org>
> > ---
> >
> > arch/powerpc/include/asm/ppc-opcode.h |    3 +++
> > arch/powerpc/kernel/cputable.c        |    6 ++++--
> > arch/powerpc/mm/hash_native_64.c      |   11 +++++++++--
> 
> did you miss the update to mmu.h to add MMU_FTR_TLBIE_206?

Yep a missing quilt add.  Thanks

> 
> > 3 files changed, 16 insertions(+), 4 deletions(-)
> >
> > Index: linux-2.6-ozlabs/arch/powerpc/include/asm/ppc-opcode.h
> > ===================================================================
> > --- linux-2.6-ozlabs.orig/arch/powerpc/include/asm/ppc-opcode.h
> > +++ linux-2.6-ozlabs/arch/powerpc/include/asm/ppc-opcode.h
> > @@ -79,4 +79,7 @@
> > #define PPC_WAIT(w)		stringify_in_c(.long PPC_INST_WAIT | \
> > 					__PPC_WC(w))
> >
> > +#define TLBIE(lp,a) \
> > +	stringify_in_c(.long 0x7c000264 | ((a) << 11) | ((lp) << 21))
> > +
> 
> Can you match the format of the file and define a PPC_INST_TLBIE

Sorry, I obviously just stuck my crap in there without looking at the
nice macros I could use.

Repost coming.

Mikey
