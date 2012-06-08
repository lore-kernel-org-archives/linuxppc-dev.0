Return-Path: <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <michael@ellerman.id.au>
From: Michael Neuling <mikey@neuling.org>
Date: Fri, 08 Jun 2012 21:36:05 +1000
Subject: [PATCH 2/15] powerpc: modify macro ready for %r0 register change
In-Reply-To: <1339155365.316308.981577666228.qpush@ale>
Message-Id: <20120608113605.62692D43B24@localhost.localdomain>
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

The assembler doesn't take %r0 register arguments in braces, so remove them.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---

 arch/powerpc/include/asm/ppc_asm.h |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

Index: clone3/arch/powerpc/include/asm/ppc_asm.h
===================================================================
--- clone3.orig/arch/powerpc/include/asm/ppc_asm.h
+++ clone3/arch/powerpc/include/asm/ppc_asm.h
@@ -295,14 +295,14 @@ n:
  */
 #ifdef __powerpc64__
 #define LOAD_REG_IMMEDIATE(reg,expr)		\
-	lis     (reg),(expr)@highest;		\
-	ori     (reg),(reg),(expr)@higher;	\
-	rldicr  (reg),(reg),32,31;		\
-	oris    (reg),(reg),(expr)@h;		\
-	ori     (reg),(reg),(expr)@l;
+	lis     reg,(expr)@highest;		\
+	ori     reg,reg,(expr)@higher;	\
+	rldicr  reg,reg,32,31;		\
+	oris    reg,reg,(expr)@h;		\
+	ori     reg,reg,(expr)@l;
 
 #define LOAD_REG_ADDR(reg,name)			\
-	ld	(reg),name@got(r2)
+	ld	reg,name@got(r2)
 
 #define LOAD_REG_ADDRBASE(reg,name)	LOAD_REG_ADDR(reg,name)
 #define ADDROFF(name)			0
@@ -313,12 +313,12 @@ n:
 #else /* 32-bit */
 
 #define LOAD_REG_IMMEDIATE(reg,expr)		\
-	lis	(reg),(expr)@ha;		\
-	addi	(reg),(reg),(expr)@l;
+	lis	reg,(expr)@ha;		\
+	addi	reg,reg,(expr)@l;
 
 #define LOAD_REG_ADDR(reg,name)		LOAD_REG_IMMEDIATE(reg, name)
 
-#define LOAD_REG_ADDRBASE(reg, name)	lis	(reg),name@ha
+#define LOAD_REG_ADDRBASE(reg, name)	lis	reg,name@ha
 #define ADDROFF(name)			name@l
 
 /* offsets for stack frame layout */
