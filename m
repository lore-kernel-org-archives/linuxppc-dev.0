Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B889C1A006D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Mar 2016 11:33:52 +1100 (AEDT)
Date: Thu, 10 Mar 2016 11:33:49 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/xmon: Fix SPR read/write commands and add command to
 dump SPRs
Message-ID: <20160310003349.GA1230@fergus.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Xmon has commands for reading and writing SPRs, but they don't work
currently for several reasons.  They attempt to synthesize a small
function containing an mfspr or mtspr instruction and call it.
However, the instructions are on the stack, which is usually not
executable.  Also, for 64-bit we set up a procedure descriptor, which
is fine for the big-endian ABIv1, but not correct for ABIv2.  Finally,
the code uses the infrastructure for catching memory errors, but that
only catches data storage interrupts and machine check interrupts,
but a failed mfspr/mtspr can generate a program interrupt or a
hypervisor emulation assist interrupt, or be a no-op.

Instead of trying to synthesize a function on the fly, this adds two
new functions, do_mfspr and do_mtspr, which take an SPR number as an
argument and read or write the SPR.  Because there is no Power ISA
instruction which takes an SPR number in a register, we have to
generate one of each possible mfspr and mtspr instruction, for all
1024 possible SPRs.  Thus we get just over 8k bytes of code for each
of do_mfspr and do_mtspr.  However, this 16kB of code pales in
comparison to the > 130kB of PPC opcode tables used by the
dissasembler.

To catch interrupts caused by the mfspr/mtspr instructions, we add a
new 'doing_spr_access' flag.  If an interrupt occurs while it is set,
we come back into xmon() via program_check_interrupt(), _exception()
and die(), see that doing_spr_access is set and do a longjmp to
bus_error_jmp, back into read_spr or write_spr.

This adds a couple of other nice features: first, a "SA" command that
attempts to read and print out the value of all 1024 SPRs, excluding
SPRs 4, 5 and 6 (which never exist on any PPC processor later than
the 601).  If any mfspr instruction acts as a no-op, then the SPR
is not implemented and not printed.

Secondly, the Sr and Sw commands detect when an SPR is not implemented
(i.e. mfspr is a no-op) and print a message to that effect rather than
printing a bogus value.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/xmon/Makefile    |   2 +-
 arch/powerpc/xmon/spraccess.S |  40 +++++++++++++++
 arch/powerpc/xmon/xmon.c      | 115 +++++++++++++++++++++++-------------------
 3 files changed, 104 insertions(+), 53 deletions(-)
 create mode 100644 arch/powerpc/xmon/spraccess.S

diff --git a/arch/powerpc/xmon/Makefile b/arch/powerpc/xmon/Makefile
index 436062d..8a971dc 100644
--- a/arch/powerpc/xmon/Makefile
+++ b/arch/powerpc/xmon/Makefile
@@ -7,7 +7,7 @@ UBSAN_SANITIZE := n
 
 ccflags-$(CONFIG_PPC64) := $(NO_MINIMAL_TOC)
 
-obj-y			+= xmon.o nonstdio.o
+obj-y			+= xmon.o nonstdio.o spraccess.o
 
 ifdef CONFIG_XMON_DISASSEMBLY
 obj-y			+= ppc-dis.o ppc-opc.o
diff --git a/arch/powerpc/xmon/spraccess.S b/arch/powerpc/xmon/spraccess.S
new file mode 100644
index 0000000..6e0f9ca
--- /dev/null
+++ b/arch/powerpc/xmon/spraccess.S
@@ -0,0 +1,40 @@
+#include <asm/ppc_asm.h>
+
+/* do_mfspr(sprn, default_value) */
+_GLOBAL(do_mfspr)
+	mflr	r0
+	bcl	20, 31, 1f		/* get address of next instr into LR */
+1:	rlwinm	r3, r3, 3, 0x3ff * 8	/* sprn = (sprn & 0x3ff) << 3 */
+	mflr	r5
+	mtlr	r0
+	add	r5, r5, r3
+	addi	r5, r5, 2f - 1b
+	mtctr	r5
+	mr	r3, r4
+	bctr
+2:
+	spr = 0
+	.rept	1024
+	mfspr	r3, spr
+	blr
+	spr = spr + 1
+	.endr
+
+/* do_mtspr(sprn, new_value) */
+_GLOBAL(do_mtspr)
+	mflr	r0
+	bcl	20, 31, 1f		/* get address of next instr into LR */
+1:	rlwinm	r3, r3, 3, 0x3ff * 8	/* sprn = (sprn & 0x3ff) << 3 */
+	mflr	r5
+	mtlr	r0
+	add	r5, r5, r3
+	addi	r5, r5, 2f - 1b
+	mtctr	r5
+	bctr
+2:
+	spr = 0
+	.rept	1024
+	mtspr	spr, r4
+	blr
+	spr = spr + 1
+	.endr
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 942796f..90374f1 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -86,6 +86,7 @@ static char tmpstr[128];
 
 static long bus_error_jmp[JMP_BUF_LEN];
 static int catch_memory_errors;
+static int doing_spr_access;
 static long *xmon_fault_jmp[NR_CPUS];
 
 /* Breakpoint stuff */
@@ -147,7 +148,7 @@ void getstring(char *, int);
 static void flush_input(void);
 static int inchar(void);
 static void take_input(char *);
-static unsigned long read_spr(int);
+static int  read_spr(int, unsigned long *);
 static void write_spr(int, unsigned long);
 static void super_regs(void);
 static void remove_bpts(void);
@@ -442,6 +443,8 @@ static int xmon_core(struct pt_regs *regs, int fromipi)
 #ifdef CONFIG_SMP
 	cpu = smp_processor_id();
 	if (cpumask_test_cpu(cpu, &cpus_in_xmon)) {
+		if (doing_spr_access)
+			longjmp(bus_error_jmp, 1);
 		get_output_lock();
 		excprint(regs);
 		printf("cpu 0x%x: Exception %lx %s in xmon, "
@@ -1635,76 +1638,42 @@ static void cacheflush(void)
 	catch_memory_errors = 0;
 }
 
-static unsigned long
-read_spr(int n)
+extern unsigned long do_mfspr(int spr, unsigned long default_value);
+extern unsigned long do_mtspr(int spr, unsigned long value);
+
+static int
+read_spr(int n, unsigned long *vp)
 {
-	unsigned int instrs[2];
-	unsigned long (*code)(void);
 	unsigned long ret = -1UL;
-#ifdef CONFIG_PPC64
-	unsigned long opd[3];
-
-	opd[0] = (unsigned long)instrs;
-	opd[1] = 0;
-	opd[2] = 0;
-	code = (unsigned long (*)(void)) opd;
-#else
-	code = (unsigned long (*)(void)) instrs;
-#endif
-
-	/* mfspr r3,n; blr */
-	instrs[0] = 0x7c6002a6 + ((n & 0x1F) << 16) + ((n & 0x3e0) << 6);
-	instrs[1] = 0x4e800020;
-	store_inst(instrs);
-	store_inst(instrs+1);
+	int ok = 0;
 
 	if (setjmp(bus_error_jmp) == 0) {
-		catch_memory_errors = 1;
+		doing_spr_access = 1;
 		sync();
 
-		ret = code();
+		ret = do_mfspr(n, *vp);
 
 		sync();
-		/* wait a little while to see if we get a machine check */
-		__delay(200);
-		n = size;
+		*vp = ret;
+		ok = 1;
 	}
+	doing_spr_access = 0;
 
-	return ret;
+	return ok;
 }
 
 static void
 write_spr(int n, unsigned long val)
 {
-	unsigned int instrs[2];
-	unsigned long (*code)(unsigned long);
-#ifdef CONFIG_PPC64
-	unsigned long opd[3];
-
-	opd[0] = (unsigned long)instrs;
-	opd[1] = 0;
-	opd[2] = 0;
-	code = (unsigned long (*)(unsigned long)) opd;
-#else
-	code = (unsigned long (*)(unsigned long)) instrs;
-#endif
-
-	instrs[0] = 0x7c6003a6 + ((n & 0x1F) << 16) + ((n & 0x3e0) << 6);
-	instrs[1] = 0x4e800020;
-	store_inst(instrs);
-	store_inst(instrs+1);
-
 	if (setjmp(bus_error_jmp) == 0) {
-		catch_memory_errors = 1;
+		doing_spr_access = 1;
 		sync();
 
-		code(val);
+		do_mtspr(n, val);
 
 		sync();
-		/* wait a little while to see if we get a machine check */
-		__delay(200);
-		n = size;
 	}
+	doing_spr_access = 0;
 }
 
 static unsigned long regno;
@@ -1714,6 +1683,7 @@ extern char dec_exc;
 static void super_regs(void)
 {
 	int cmd;
+	int spr;
 	unsigned long val;
 
 	cmd = skipbl();
@@ -1734,15 +1704,56 @@ static void super_regs(void)
 		return;
 	}
 
+	if (cmd == 'A') {
+		/* dump ALL SPRs */
+		for (spr = 1; spr < 1024; ++spr) {
+			if (spr >= 4 && spr <= 6)
+				continue;
+			val = 0xdeadbeef;
+			if (read_spr(spr, &val)) {
+				if (val == 0xdeadbeef) {
+					val = 0x0badcafe;
+					if (read_spr(spr, &val) &&
+					    val == 0x0badcafe) {
+						/* unimplemented, skip it */
+						continue;
+					}
+				}
+				printf("SPR 0x%3x (%4d) = %lx\n", spr, spr,
+				       val);
+			} else {
+				printf("SPR 0x%3x (%4d): ERROR\n", spr, spr);
+			}
+		}
+		return;
+	}
+
 	scanhex(&regno);
 	switch (cmd) {
 	case 'w':
-		val = read_spr(regno);
+		val = 0;
+		read_spr(regno, &val);
 		scanhex(&val);
 		write_spr(regno, val);
 		/* fall through */
 	case 'r':
-		printf("spr %lx = %lx\n", regno, read_spr(regno));
+		val = 0xdeadbeef;
+		if (!read_spr(regno, &val)) {
+			printf("Error reading SPR 0x%lx\n", regno);
+			break;
+		}
+		if (val == 0xdeadbeef) {
+			val = 0x0badcafe;
+			if (!read_spr(regno, &val)) {
+				printf("Error rereading SPR 0x%lx\n", regno);
+				break;
+			}
+			if (val == 0x0badcafe) {
+				printf("spr 0x%lx is not implemented\n", regno);
+				break;
+			}
+		}
+		printf("spr 0x%lx = %lx\n", regno, val);
 		break;
 	}
 	scannl();
-- 
2.6.4
