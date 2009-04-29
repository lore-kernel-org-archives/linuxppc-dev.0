Return-Path: <mikey@neuling.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 99A35DDF03
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Apr 2009 17:20:41 +1000 (EST)
To: Michael Neuling <mikey@neuling.org>, Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Michael Neuling <mikey@neuling.org>
Date: Wed, 29 Apr 2009 17:20:40 +1000
Subject: [PATCH 2/2] powerpc: Move VSX load/stores into ppc-opcode.h
In-Reply-To: <1240989640.548113.69052602556.qpush@pale>
Message-Id: <20090429072040.A3C761222D@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Move VSX load/stores into ppc-opcode.h

Signed-off-by: Michael Neuling <mikey@neuling.org>
---

 arch/powerpc/include/asm/ppc-opcode.h |    9 +++++++++
 arch/powerpc/include/asm/ppc_asm.h    |   10 ----------
 2 files changed, 9 insertions(+), 10 deletions(-)

Index: linux-2.6-ozlabs/arch/powerpc/include/asm/ppc-opcode.h
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/include/asm/ppc-opcode.h
+++ linux-2.6-ozlabs/arch/powerpc/include/asm/ppc-opcode.h
@@ -49,6 +49,7 @@
 /* macros to insert fields into opcodes */
 #define __PPC_RA(a)	(((a) & 0x1f) << 16)
 #define __PPC_RB(b)	(((b) & 0x1f) << 11)
+#define __PPC_XS(s)	((((s) & 0x1f) << 21) | (((s) & 0x20) >> 5))
 #define __PPC_T_TLB(t)	(((t) & 0x3) << 21)
 #define __PPC_WC(w)	(((w) & 0x3) << 21)
 
@@ -70,4 +71,12 @@
 #define PPC_WAIT(w)		stringify_in_c(.long PPC_INST_WAIT | \
 					__PPC_WC(w))
 
+/*
+ * Define what the VSX XX1 form instructions will look like, then add
+ * the 128 bit load store instructions based on that.
+ */
+#define VSX_XX1(s, a, b)	(__PPC_XS(s) | __PPC_RA(a) | __PPC_RB(b))
+#define STXVD2X(s, a, b)	.long (0x7c000798 | VSX_XX1((s), (a), (b)))
+#define LXVD2X(s, a, b)		.long (0x7c000698 | VSX_XX1((s), (a), (b)))
+
 #endif /* _ASM_POWERPC_PPC_OPCODE_H */
Index: linux-2.6-ozlabs/arch/powerpc/include/asm/ppc_asm.h
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/include/asm/ppc_asm.h
+++ linux-2.6-ozlabs/arch/powerpc/include/asm/ppc_asm.h
@@ -75,16 +75,6 @@ END_FTR_SECTION_IFCLR(CPU_FTR_PURR);				
 				REST_10GPRS(22, base)
 #endif
 
-/*
- * Define what the VSX XX1 form instructions will look like, then add
- * the 128 bit load store instructions based on that.
- */
-#define VSX_XX1(xs, ra, rb)	(((xs) & 0x1f) << 21 | ((ra) << 16) |  \
-				 ((rb) << 11) | (((xs) >> 5)))
-
-#define STXVD2X(xs, ra, rb)	.long (0x7c000798 | VSX_XX1((xs), (ra), (rb)))
-#define LXVD2X(xs, ra, rb)	.long (0x7c000698 | VSX_XX1((xs), (ra), (rb)))
-
 #define SAVE_2GPRS(n, base)	SAVE_GPR(n, base); SAVE_GPR(n+1, base)
 #define SAVE_4GPRS(n, base)	SAVE_2GPRS(n, base); SAVE_2GPRS(n+2, base)
 #define SAVE_8GPRS(n, base)	SAVE_4GPRS(n, base); SAVE_4GPRS(n+4, base)
