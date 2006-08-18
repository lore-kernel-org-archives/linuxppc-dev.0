Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 11DD067B58
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Aug 2006 04:11:53 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k7IIBjwM029668
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 14:11:45 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k7IIBo3Q240684
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 14:11:50 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k7IIBn0P029578
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 14:11:50 -0400
Subject: Re: [PATCH] powerpc: emulate power5 popcntb instruction
From: Will Schmidt <will_schmidt@vnet.ibm.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <36A1A5C6-5269-4BDA-9F3E-A632B3A627DB@kernel.crashing.org>
References: <1155840829.9659.16.camel@farscape.rchland.ibm.com>
	<36A1A5C6-5269-4BDA-9F3E-A632B3A627DB@kernel.crashing.org>
Content-Type: text/plain
Date: Fri, 18 Aug 2006 13:11:26 -0500
Message-Id: <1155924687.9659.25.camel@farscape.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: will_schmidt@vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


In an attempt to make it easier for a power5 optimized app to run on a 
power4 or a 970 or random earlier machine, this provides emulation of
the popcntb instruction.    Rewritten to use a slicker algorithm as
suggested by Segher.   I left a 'tmp' variable in play, as it seemed
cleaner to use tmp than referring to regs->gpr[rs] and [ra] multiple
times within the magic algorithm.  

Also tested on power4 with both 32 and 64 userspace this time.
*blush*.  :-) 


Signed-off-by: Will Schmidt <will_schmidt@vnet.ibm.com>

---

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 2105767..a0e80dd 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -588,6 +588,8 @@ #define INST_LSWX		0x7c00042a
 #define INST_STSWI		0x7c0005aa
 #define INST_STSWX		0x7c00052a
 
+#define INST_POPCNTB		0x7c0000f4
+
 static int emulate_string_inst(struct pt_regs *regs, u32 instword)
 {
 	u8 rT = (instword >> 21) & 0x1f;
@@ -656,6 +658,23 @@ static int emulate_string_inst(struct pt
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
@@ -693,6 +712,11 @@ static int emulate_instruction(struct pt
 	if ((instword & INST_STRING_GEN_MASK) == INST_STRING)
 		return emulate_string_inst(regs, instword);
 
+	/* Emulate the popcntb (Population Count Bytes) instruction. */
+	if ((instword & INST_POPCNTB) == INST_POPCNTB) {
+		return emulate_popcntb_inst(regs, instword);
+	}
+
 	return -EINVAL;
 }
 
