Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 59A6367B60
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Aug 2006 04:11:51 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k7UIBmhS013088
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Aug 2006 14:11:48 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k7UIBmMp260686
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Aug 2006 14:11:48 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k7UIBl7d009499
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Aug 2006 14:11:48 -0400
Subject: Re: [PATCH] powerpc: emulate power5 popcntb instruction
From: Will Schmidt <will_schmidt@vnet.ibm.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <6DCD2C4D-BB97-487D-A094-7F288970F3F3@kernel.crashing.org>
References: <1155840829.9659.16.camel@farscape.rchland.ibm.com>
	<200608182105.45264.arnd@arndb.de>
	<50883.84.105.60.119.1156014614.squirrel@gate.crashing.org>
	<200608192219.03178.arnd@arndb.de>
	<37280.84.105.60.119.1156030372.squirrel@gate.crashing.org>
	<1156190965.9659.41.camel@farscape.rchland.ibm.com>
	<17645.18647.720814.903612@cargo.ozlabs.ibm.com>
	<1156788215.5959.25.camel@localhost>
	<6DCD2C4D-BB97-487D-A094-7F288970F3F3@kernel.crashing.org>
Content-Type: text/plain
Date: Wed, 30 Aug 2006 13:11:38 -0500
Message-Id: <1156961498.5959.53.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	segher@gate.crashing.org, arnd@arndb.de
Reply-To: will_schmidt@vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-29-08 at 08:43 +0200, Segher Boessenkool wrote:
> >> I just did a patch to fix the existing masks.
> 
> Thanks Paul.
> 
> >> Could you do a new
> >> version of this patch that doesn't include the unrelated mask fixes
> >> please?  Also it would be really nice if you could figure out a  
> >> way to
> >> avoid doing the unnecessary 64-bit logical operations on 32-bit
> >> machines - i.e. using an unsigned long for tmp, but then the  
> >> constants
> >> become problematic.  Maybe you need something like
> >>
> >> #define LCONST(x)	((unsigned long)(x##ULL))
> >
> > Ok, how about this..
> 
> Hrm.  The LCONST() thing is butt ugly though; you can just write
> 0x3333333333333333ULL etc. and GCC will do the right thing (i.e.
> efficient code), and not warn (don't need the "ULL" even when in
> C99/gnu99 mode, as we should be but aren't, heh).
> 
> You want to make tmp and unsigned long instead of an u64...

Ok, so back to unsigned-long to let the 32-bit stuff be happy..

Now a bit of a tangent question:  As far as just 64-bit is concerned, is
there actually any difference between u64 and unsigned long?   Am
wondering why you suggested that change to u64 from unsigned long
earlier in the thread.


this version looks to build clean with arch=ppc (32-bit). 

This provides emulation of the power5 instruction popcntb.

Signed-off-by: Will Schmidt <will_schmidt@vnet.ibm.com>


---
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 2105767..4014d71 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -588,6 +588,9 @@ #define INST_LSWX		0x7c00042a
 #define INST_STSWI		0x7c0005aa
 #define INST_STSWX		0x7c00052a
 
+#define INST_POPCNTB		0x7c0000f4
+#define INST_POPCNTB_MASK	0xfc0007fe
+
 static int emulate_string_inst(struct pt_regs *regs, u32 instword)
 {
 	u8 rT = (instword >> 21) & 0x1f;
@@ -656,6 +659,23 @@ static int emulate_string_inst(struct pt
 	return 0;
 }
 
+static int emulate_popcntb_inst(struct pt_regs *regs, u32 instword)
+{
+	u32 ra,rs;
+	unsigned long tmp;
+
+	ra = (instword >> 16) & 0x1f;
+	rs = (instword >> 21) & 0x1f;
+
+	tmp = regs->gpr[rs];
+	tmp = tmp - ((tmp >> 1) & 0x5555555555555555ULL);
+	tmp = (tmp & 0x3333333333333333ULL) + ((tmp >> 2) & 0x3333333333333333ULL);
+	tmp = (tmp + (tmp >> 4)) & 0x0f0f0f0f0f0f0f0fULL;
+	regs->gpr[ra] = tmp;
+
+	return 0;
+}
+
 static int emulate_instruction(struct pt_regs *regs)
 {
 	u32 instword;
@@ -693,6 +713,11 @@ static int emulate_instruction(struct pt
 	if ((instword & INST_STRING_GEN_MASK) == INST_STRING)
 		return emulate_string_inst(regs, instword);
 
+	/* Emulate the popcntb (Population Count Bytes) instruction. */
+	if ((instword & INST_POPCNTB_MASK) == INST_POPCNTB) {
+		return emulate_popcntb_inst(regs, instword);
+	}
+
 	return -EINVAL;
 }
 
