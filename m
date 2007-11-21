Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id 9987CDDDD8
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Nov 2007 00:09:24 +1100 (EST)
Date: Wed, 21 Nov 2007 14:09:17 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] Emulate isel (Integer Select) instruction
In-Reply-To: <B82E6C31-8BB7-4348-9426-B18A971172A9@kernel.crashing.org>
Message-ID: <Pine.LNX.4.62.0711211407260.12720@pademelon.sonytel.be>
References: <Pine.LNX.4.64.0711192135460.24923@blarg.am.freescale.net>
	<20071120175416.GA4389@loki.buserror.net>
	<B82E6C31-8BB7-4348-9426-B18A971172A9@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584337861-2077758037-1195650557=:12720"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584337861-2077758037-1195650557=:12720
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 20 Nov 2007, Kumar Gala wrote:
> On Nov 20, 2007, at 11:54 AM, Scott Wood wrote:
> > On Mon, Nov 19, 2007 at 09:36:57PM -0600, Kumar Gala wrote:
> >> isel (Integer Select) is a new user space instruction in the
> >> PowerISA 2.04 spec.  Not all processors implement it so lets emulate
> >> to ensure code built with isel will run everywhere.
> >
> > Given that the instruction is meant to be a performance enhancement,
> > we should probably warn the first few times it's emulated, so the user
> > knows they should change their toolchain setup if possible.
> 
> The same is true of mcrxr, popcntb, and possibly string ld/st.
> 
> Feel free to submit a patch that warns about their usage.

Something like this?

Probably we also want it for:

  - arch/powerpc/kernel/align.c
      o emulate_dcbz()
      o emulate_multiple()
      o emulate_fp_pair()
      o emulate_spe()

  - arch/powerpc/kernel/softemu8xx.c
      o Soft_emulate_8xx()

  - arch/powerpc/kernel/traps.c
      o SoftwareEmulation()

  - arch/powerpc/kernel/vecemu.c
      o emulate_altivec()

Question: do we want it for emulate_single_step(), too?

So far my Debian userland didn't trigger any of them on the PS3, I had to
write an explicit test ;-)
---
 arch/powerpc/kernel/traps.c |   19 +++++++++++++++++--
 1 files changed, 17 insertions(+), 2 deletions(-)

--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -707,6 +707,14 @@ static int emulate_popcntb_inst(struct p
 	return 0;
 }
 
+#define WARN_EMULATE(type)						\
+	do {								\
+	    static unsigned int count;					\
+	    if (count++ < 10)						\
+		    pr_warning("%s used emulated %s instruction\n",	\
+			       current->comm, type);			\
+	} while (0)
+
 static int emulate_instruction(struct pt_regs *regs)
 {
 	u32 instword;
@@ -721,31 +729,38 @@ static int emulate_instruction(struct pt
 
 	/* Emulate the mfspr rD, PVR. */
 	if ((instword & INST_MFSPR_PVR_MASK) == INST_MFSPR_PVR) {
+		WARN_EMULATE("mfpvr");
 		rd = (instword >> 21) & 0x1f;
 		regs->gpr[rd] = mfspr(SPRN_PVR);
 		return 0;
 	}
 
 	/* Emulating the dcba insn is just a no-op.  */
-	if ((instword & INST_DCBA_MASK) == INST_DCBA)
+	if ((instword & INST_DCBA_MASK) == INST_DCBA) {
+		WARN_EMULATE("dcba");
 		return 0;
+	}
 
 	/* Emulate the mcrxr insn.  */
 	if ((instword & INST_MCRXR_MASK) == INST_MCRXR) {
 		int shift = (instword >> 21) & 0x1c;
 		unsigned long msk = 0xf0000000UL >> shift;
 
+		WARN_EMULATE("mcrxr");
 		regs->ccr = (regs->ccr & ~msk) | ((regs->xer >> shift) & msk);
 		regs->xer &= ~0xf0000000UL;
 		return 0;
 	}
 
 	/* Emulate load/store string insn. */
-	if ((instword & INST_STRING_GEN_MASK) == INST_STRING)
+	if ((instword & INST_STRING_GEN_MASK) == INST_STRING) {
+		WARN_EMULATE("string");
 		return emulate_string_inst(regs, instword);
+	}
 
 	/* Emulate the popcntb (Population Count Bytes) instruction. */
 	if ((instword & INST_POPCNTB_MASK) == INST_POPCNTB) {
+		WARN_EMULATE("popcntb");
 		return emulate_popcntb_inst(regs, instword);
 	}
 

With kind regards,
 
Geert Uytterhoeven
Software Architect

Sony Network and Software Technology Center Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium
 
Phone:    +32 (0)2 700 8453	
Fax:      +32 (0)2 700 8622	
E-mail:   Geert.Uytterhoeven@sonycom.com	
Internet: http://www.sony-europe.com/
 	
Sony Network and Software Technology Center Europe	
A division of Sony Service Centre (Europe) N.V.	
Registered office: Technologielaan 7 · B-1840 Londerzeel · Belgium	
VAT BE 0413.825.160 · RPR Brussels	
Fortis Bank Zaventem · Swift GEBABEBB08A · IBAN BE39001382358619
---584337861-2077758037-1195650557=:12720--
