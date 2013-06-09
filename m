Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6880A2C00A4
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  9 Jun 2013 17:00:54 +1000 (EST)
Message-ID: <1370761242.14883.1.camel@pasglop>
Subject: [PATCH 1/3] powerpc/math-emu: Fix decoding of some instructions
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Sun, 09 Jun 2013 17:00:42 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The decoding of some instructions such as fsqrt{s} was incorrect,
using the wrong registers, and thus could not work.

This fixes it and also adds a couple of place holders for missing
instructions.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Note: fre.c etc.. are still empty placeholders, just like fres.c
is today. Eventually somebody needs to fill-in the missing bits

 arch/powerpc/math-emu/Makefile   |    3 ++-
 arch/powerpc/math-emu/fre.c      |   11 +++++++++++
 arch/powerpc/math-emu/frsqrtes.c |   11 +++++++++++
 arch/powerpc/math-emu/math.c     |   14 ++++++++++----
 4 files changed, 34 insertions(+), 5 deletions(-)
 create mode 100644 arch/powerpc/math-emu/fre.c
 create mode 100644 arch/powerpc/math-emu/frsqrtes.c

diff --git a/arch/powerpc/math-emu/Makefile b/arch/powerpc/math-emu/Makefile
index 7d1dba0..8d035d2 100644
--- a/arch/powerpc/math-emu/Makefile
+++ b/arch/powerpc/math-emu/Makefile
@@ -4,7 +4,8 @@ obj-$(CONFIG_MATH_EMULATION)	+= fabs.o fadd.o fadds.o fcmpo.o fcmpu.o \
 					fmadd.o fmadds.o fmsub.o fmsubs.o \
 					fmul.o fmuls.o fnabs.o fneg.o \
 					fnmadd.o fnmadds.o fnmsub.o fnmsubs.o \
-					fres.o frsp.o frsqrte.o fsel.o lfs.o \
+					fres.o fre.o frsp.o fsel.o lfs.o \
+					frsqrte.o frsqrtes.o \
 					fsqrt.o	fsqrts.o fsub.o fsubs.o \
 					mcrfs.o mffs.o mtfsb0.o mtfsb1.o \
 					mtfsf.o mtfsfi.o stfiwx.o stfs.o \
diff --git a/arch/powerpc/math-emu/fre.c b/arch/powerpc/math-emu/fre.c
new file mode 100644
index 0000000..49ccf2c
--- /dev/null
+++ b/arch/powerpc/math-emu/fre.c
@@ -0,0 +1,11 @@
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <asm/uaccess.h>
+
+int fre(void *frD, void *frB)
+{
+#ifdef DEBUG
+	printk("%s: %p %p\n", __func__, frD, frB);
+#endif
+	return -ENOSYS;
+}
diff --git a/arch/powerpc/math-emu/frsqrtes.c b/arch/powerpc/math-emu/frsqrtes.c
new file mode 100644
index 0000000..7e838e3
--- /dev/null
+++ b/arch/powerpc/math-emu/frsqrtes.c
@@ -0,0 +1,11 @@
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <asm/uaccess.h>
+
+int frsqrtes(void *frD, void *frB)
+{
+#ifdef DEBUG
+	printk("%s: %p %p\n", __func__, frD, frB);
+#endif
+	return 0;
+}
diff --git a/arch/powerpc/math-emu/math.c b/arch/powerpc/math-emu/math.c
index 164d559..0328e66 100644
--- a/arch/powerpc/math-emu/math.c
+++ b/arch/powerpc/math-emu/math.c
@@ -58,8 +58,10 @@ FLOATFUNC(fnabs);
 FLOATFUNC(fneg);
 
 /* Optional */
+FLOATFUNC(fre);
 FLOATFUNC(fres);
 FLOATFUNC(frsqrte);
+FLOATFUNC(frsqrtes);
 FLOATFUNC(fsel);
 FLOATFUNC(fsqrt);
 FLOATFUNC(fsqrts);
@@ -97,6 +99,7 @@ FLOATFUNC(fsqrts);
 #define FSQRTS		0x016		/*   22 */
 #define FRES		0x018		/*   24 */
 #define FMULS		0x019		/*   25 */
+#define FRSQRTES	0x01a		/*   26 */
 #define FMSUBS		0x01c		/*   28 */
 #define FMADDS		0x01d		/*   29 */
 #define FNMSUBS		0x01e		/*   30 */
@@ -109,6 +112,7 @@ FLOATFUNC(fsqrts);
 #define FADD		0x015		/*   21 */
 #define FSQRT		0x016		/*   22 */
 #define FSEL		0x017		/*   23 */
+#define FRE		0x018		/*   24 */
 #define FMUL		0x019		/*   25 */
 #define FRSQRTE		0x01a		/*   26 */
 #define FMSUB		0x01c		/*   28 */
@@ -299,9 +303,10 @@ do_mathemu(struct pt_regs *regs)
 		case FDIVS:	func = fdivs;	type = AB;	break;
 		case FSUBS:	func = fsubs;	type = AB;	break;
 		case FADDS:	func = fadds;	type = AB;	break;
-		case FSQRTS:	func = fsqrts;	type = AB;	break;
-		case FRES:	func = fres;	type = AB;	break;
+		case FSQRTS:	func = fsqrts;	type = XB;	break;
+		case FRES:	func = fres;	type = XB;	break;
 		case FMULS:	func = fmuls;	type = AC;	break;
+		case FRSQRTES:	func = frsqrtes;type = XB;	break;
 		case FMSUBS:	func = fmsubs;	type = ABC;	break;
 		case FMADDS:	func = fmadds;	type = ABC;	break;
 		case FNMSUBS:	func = fnmsubs;	type = ABC;	break;
@@ -317,10 +322,11 @@ do_mathemu(struct pt_regs *regs)
 			case FDIV:	func = fdiv;	type = AB;	break;
 			case FSUB:	func = fsub;	type = AB;	break;
 			case FADD:	func = fadd;	type = AB;	break;
-			case FSQRT:	func = fsqrt;	type = AB;	break;
+			case FSQRT:	func = fsqrt;	type = XB;	break;
+			case FRE:	func = fre;	type = XB;	break;
 			case FSEL:	func = fsel;	type = ABC;	break;
 			case FMUL:	func = fmul;	type = AC;	break;
-			case FRSQRTE:	func = frsqrte;	type = AB;	break;
+			case FRSQRTE:	func = frsqrte;	type = XB;	break;
 			case FMSUB:	func = fmsub;	type = ABC;	break;
 			case FMADD:	func = fmadd;	type = ABC;	break;
 			case FNMSUB:	func = fnmsub;	type = ABC;	break;
