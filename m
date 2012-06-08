Return-Path: <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <michael@ellerman.id.au>
From: Michael Neuling <mikey@neuling.org>
Date: Fri, 08 Jun 2012 21:36:05 +1000
Subject: [PATCH 6/15] powerpc/pasemi: move lbz/stbciz to ppc-opcode.h
In-Reply-To: <1339155365.316308.981577666228.qpush@ale>
Message-Id: <20120608113605.78D97D43B2A@localhost.localdomain>
Cc: mikey@neuling.org, linuxppc-dev@ozlabs.org,
 Anton Blanchard <anton@samba.org>, Olof Johannsson <olof@lixom.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

move lbz/stbciz to ppc-opcode.h.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---

 arch/powerpc/include/asm/ppc-opcode.h |    7 +++++++
 arch/powerpc/kernel/misc_64.S         |    5 -----
 2 files changed, 7 insertions(+), 5 deletions(-)

Index: clone3/arch/powerpc/include/asm/ppc-opcode.h
===================================================================
--- clone3.orig/arch/powerpc/include/asm/ppc-opcode.h
+++ clone3/arch/powerpc/include/asm/ppc-opcode.h
@@ -107,6 +107,8 @@
 #define PPC_INST_NEG			0x7c0000d0
 #define PPC_INST_BRANCH			0x48000000
 #define PPC_INST_BRANCH_COND		0x40800000
+#define PPC_INST_LBZCIX			0x7c0006aa
+#define PPC_INST_STBCIX			0x7c0007aa
 
 /* macros to insert fields into opcodes */
 #define __PPC_RA(a)	(((a) & 0x1f) << 16)
@@ -186,6 +188,11 @@
 					__PPC_RS(t) | __PPC_RA(a) | __PPC_RB(b))
 #define PPC_SLBFEE_DOT(t, b)	stringify_in_c(.long PPC_INST_SLBFEE | \
 					__PPC_RT(t) | __PPC_RB(b))
+/* PASemi instructions */
+#define LBZCIX(t,a,b)		stringify_in_c(.long PPC_INST_LBZCIX | \
+				       __PPC_RT(t) | __PPC_RA(a) | __PPC_RB(b))
+#define STBCIX(s,a,b)		stringify_in_c(.long PPC_INST_STBCIX | \
+				       __PPC_RS(s) | __PPC_RA(a) | __PPC_RB(b))
 
 /*
  * Define what the VSX XX1 form instructions will look like, then add
Index: clone3/arch/powerpc/kernel/misc_64.S
===================================================================
--- clone3.orig/arch/powerpc/kernel/misc_64.S
+++ clone3/arch/powerpc/kernel/misc_64.S
@@ -301,11 +301,6 @@ _GLOBAL(real_writeb)
 
 #ifdef CONFIG_PPC_PASEMI
 
-/* No support in all binutils for these yet, so use defines */
-#define LBZCIX(RT,RA,RB)  .long (0x7c0006aa|(RT<<21)|(RA<<16)|(RB << 11))
-#define STBCIX(RS,RA,RB)  .long (0x7c0007aa|(RS<<21)|(RA<<16)|(RB << 11))
-
-
 _GLOBAL(real_205_readb)
 	mfmsr	r7
 	ori	r0,r7,MSR_DR
