Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DD4C6679E2
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 04:54:14 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k7HIsB01009645
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Aug 2006 14:54:11 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k7HIsBsL147660
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Aug 2006 14:54:11 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k7HIsA39018031
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Aug 2006 14:54:10 -0400
Subject: [PATCH] powerpc: emulate power5 popcntb instruction
From: Will Schmidt <will_schmidt@vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Thu, 17 Aug 2006 13:53:49 -0500
Message-Id: <1155840829.9659.16.camel@farscape.rchland.ibm.com>
Mime-Version: 1.0
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
power4 or a 970 or random earlier machine, this provides emulation of the popcntb 
instruction. 

tested on power4 and 970.  

Signed-off-by: Will Schmidt <will_schmidt@vnet.ibm.com>

---

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 2105767..3e5ed30 100644
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
@@ -656,6 +658,26 @@ static int emulate_string_inst(struct pt
 	return 0;
 }
 
+static int emulate_popcntb_inst(struct pt_regs *regs, u32 instword)
+{
+	u32 ra,rs;
+	u32 countreg,tmp;
+	u32 x,y;
+
+	ra = (instword >> 16) & 0x1f;
+	rs = (instword >> 21) & 0x1f;
+	countreg = regs->gpr[rs];
+	regs->gpr[ra] = 0;
+
+	/* y=4 bytes, x=8 bits/byte */
+	for (y = 0; y < 4; y++) {
+		for (tmp = 0, x = 0; x < 8; x++)
+			if (countreg & (0x1 << (x + 8 * y))) tmp++;
+		regs->gpr[ra] += (tmp <<  8 * y );
+	}
+	return 0;
+}
+
 static int emulate_instruction(struct pt_regs *regs)
 {
 	u32 instword;
@@ -693,6 +715,11 @@ static int emulate_instruction(struct pt
 	if ((instword & INST_STRING_GEN_MASK) == INST_STRING)
 		return emulate_string_inst(regs, instword);
 
+	/* Emulate the popcntb (Population Count Bytes) instruction. */
+	if ((instword & INST_POPCNTB) == INST_POPCNTB) {
+		return emulate_popcntb_inst(regs, instword);
+	}
+
 	return -EINVAL;
 }
 
