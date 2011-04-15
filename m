Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <d284a5076d7760656470a5fd16d98ec6501a9bf3.1302856271.git.michael@ellerman.id.au>
Subject: [PATCH 01/15] powerpc/a2: Add some #defines for A2 specific
	instructions
Date: Fri, 15 Apr 2011 18:31:56 +1000 (EST)
From: michael@ozlabs.org (Michael Ellerman)
Cc: Jimi Xenidis <jimix@watson.ibm.com>, jack@codezen.org, imunsie@au.ibm.com,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/include/asm/ppc-opcode.h |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index 384a96d..3e25b25 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -59,6 +59,14 @@
 #define PPC_INST_NAP			0x4c000364
 #define PPC_INST_SLEEP			0x4c0003a4
 
+/* A2 specific instructions */
+#define PPC_INST_ERATWE			0x7c0001a6
+#define PPC_INST_ERATRE			0x7c000166
+#define PPC_INST_ERATILX		0x7c000066
+#define PPC_INST_ERATIVAX		0x7c000666
+#define PPC_INST_ERATSX			0x7c000126
+#define PPC_INST_ERATSX_DOT		0x7c000127
+
 /* macros to insert fields into opcodes */
 #define __PPC_RA(a)	(((a) & 0x1f) << 16)
 #define __PPC_RB(b)	(((b) & 0x1f) << 11)
@@ -70,6 +78,8 @@
 #define __PPC_XT(s)	__PPC_XS(s)
 #define __PPC_T_TLB(t)	(((t) & 0x3) << 21)
 #define __PPC_WC(w)	(((w) & 0x3) << 21)
+#define __PPC_WS(w)	(((w) & 0x1f) << 11)
+
 /*
  * Only use the larx hint bit on 64bit CPUs. e500v1/v2 based CPUs will treat a
  * larx with EH set as an illegal instruction.
@@ -116,6 +126,21 @@
 #define PPC_TLBIVAX(a,b)	stringify_in_c(.long PPC_INST_TLBIVAX | \
 					__PPC_RA(a) | __PPC_RB(b))
 
+#define PPC_ERATWE(s, a, w)	stringify_in_c(.long PPC_INST_ERATWE | \
+					__PPC_RS(s) | __PPC_RA(a) | __PPC_WS(w))
+#define PPC_ERATRE(s, a, w)	stringify_in_c(.long PPC_INST_ERATRE | \
+					__PPC_RS(s) | __PPC_RA(a) | __PPC_WS(w))
+#define PPC_ERATILX(t, a, b)	stringify_in_c(.long PPC_INST_ERATILX | \
+					__PPC_T_TLB(t) | __PPC_RA(a) | \
+					__PPC_RB(b))
+#define PPC_ERATIVAX(s, a, b)	stringify_in_c(.long PPC_INST_ERATIVAX | \
+					__PPC_RS(s) | __PPC_RA(a) | __PPC_RB(b))
+#define PPC_ERATSX(t, a, w)	stringify_in_c(.long PPC_INST_ERATSX | \
+					__PPC_RS(t) | __PPC_RA(a) | __PPC_RB(b))
+#define PPC_ERATSX_DOT(t, a, w)	stringify_in_c(.long PPC_INST_ERATSX_DOT | \
+					__PPC_RS(t) | __PPC_RA(a) | __PPC_RB(b))
+
+
 /*
  * Define what the VSX XX1 form instructions will look like, then add
  * the 128 bit load store instructions based on that.
-- 
1.7.1
