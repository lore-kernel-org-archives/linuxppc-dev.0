Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F0AE067B8E
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Aug 2006 06:10:04 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k7LK9xVe014125
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Aug 2006 16:09:59 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k7LK9xYk291068
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Aug 2006 16:09:59 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k7LK9wim006824
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Aug 2006 16:09:58 -0400
Subject: Re: [PATCH] powerpc: emulate power5 popcntb instruction
From: Will Schmidt <will_schmidt@vnet.ibm.com>
To: segher@gate.crashing.org
In-Reply-To: <37280.84.105.60.119.1156030372.squirrel@gate.crashing.org>
References: <1155840829.9659.16.camel@farscape.rchland.ibm.com>
	<200608182105.45264.arnd@arndb.de>
	<50883.84.105.60.119.1156014614.squirrel@gate.crashing.org>
	<200608192219.03178.arnd@arndb.de>
	<37280.84.105.60.119.1156030372.squirrel@gate.crashing.org>
Content-Type: text/plain
Date: Mon, 21 Aug 2006 15:09:24 -0500
Message-Id: <1156190965.9659.41.camel@farscape.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, arnd@arndb.de
Reply-To: will_schmidt@vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sat, 2006-19-08 at 18:32 -0500, segher@gate.crashing.org wrote:
> >> > Is that the right check? The other similar traps check against a
> >> mask of 0x7c0007fe.
> >>

> So we have a bug here; could you take care of it please
> Arnd?

I'm not Arnd :-) , but since I'm poking at it anyways,.. how about
this? 



In an attempt to make it easier for a power5 optimized app to run on a 
power4 or a 970 or random earlier machine, this provides emulation of
the popcntb instruction.
This version incorporates the suggestions from Arnd, Kumar and Segher;
including using a better MASK for popcntb, updating the existing masks
to include the msb for the instruction primary opcode. 

Signed-off-by: Will Schmidt <will_schmidt@vnet.ibm.com>


diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 2105767..caba187 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -575,19 +575,22 @@ #define INST_MFSPR_PVR		0x7c1f42a6
 #define INST_MFSPR_PVR_MASK	0xfc1fffff
 
 #define INST_DCBA		0x7c0005ec
-#define INST_DCBA_MASK		0x7c0007fe
+#define INST_DCBA_MASK		0xfc0007fe
 
 #define INST_MCRXR		0x7c000400
-#define INST_MCRXR_MASK		0x7c0007fe
+#define INST_MCRXR_MASK		0xfc0007fe
 
 #define INST_STRING		0x7c00042a
-#define INST_STRING_MASK	0x7c0007fe
-#define INST_STRING_GEN_MASK	0x7c00067e
+#define INST_STRING_MASK	0xfc0007fe
+#define INST_STRING_GEN_MASK	0xfc00067e
 #define INST_LSWI		0x7c0004aa
 #define INST_LSWX		0x7c00042a
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
+	u64 tmp;
+
+	ra = (instword >> 16) & 0x1f;
+	rs = (instword >> 21) & 0x1f;
+
+	tmp = regs->gpr[rs];
+	tmp = tmp - ((tmp >> 1) & 0x5555555555555555);
+	tmp = (tmp & 0x3333333333333333) + ((tmp >> 2) & 0x3333333333333333);
+	tmp = (tmp + (tmp >> 4)) & 0x0f0f0f0f0f0f0f0f;
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
 
