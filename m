Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qlM8437YHzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Apr 2016 21:31:32 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: Paul Mackerras <paulus@samba.org>
Subject: [PATCH v2] powerpc/xmon: Fix SPR read/write commands and add command
 to dump SPRs
Date: Wed, 13 Apr 2016 21:31:24 +1000
Message-Id: <1460547084-1818-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Paul Mackerras <paulus@ozlabs.org>

xmon has commands for reading and writing SPRs, but they don't work
currently for several reasons. They attempt to synthesize a small
function containing an mfspr or mtspr instruction and call it. However,
the instructions are on the stack, which is usually not executable.
Also, for 64-bit we set up a procedure descriptor, which is fine for the
big-endian ABIv1, but not correct for ABIv2. Finally, the code uses the
infrastructure for catching memory errors, but that only catches data
storage interrupts and machine check interrupts, but a failed
mfspr/mtspr can generate a program interrupt or a hypervisor emulation
assist interrupt, or be a no-op.

Instead of trying to synthesize a function on the fly, this adds two new
functions, xmon_mfspr() and xmon_mtspr(), which take an SPR number as an
argument and read or write the SPR. Because there is no Power ISA
instruction which takes an SPR number in a register, we have to generate
one of each possible mfspr and mtspr instruction, for all 1024 possible
SPRs. Thus we get just over 8k bytes of code for each of xmon_mfspr()
and xmon_mtspr(). However, this 16kB of code pales in comparison to the
> 130kB of PPC opcode tables used by the xmon disassembler.

To catch interrupts caused by the mfspr/mtspr instructions, we add a new
'catch_spr_faults' flag. If an interrupt occurs while it is set, we come
back into xmon() via program_check_interrupt(), _exception() and die(),
see that catch_spr_faults is set and do a longjmp to bus_error_jmp, back
into read_spr() or write_spr().

This adds a couple of other nice features: first, a "Sa" command that
attempts to read and print out the value of all 1024 SPRs. If any mfspr
instruction acts as a no-op, then the SPR is not implemented and not
printed.

Secondly, the Sr and Sw commands detect when an SPR is not
implemented (i.e. mfspr is a no-op) and print a message to that effect
rather than printing a bogus value.

Signed-off-by: Paul Mackerras <paulus@samba.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
v2: Rename spraccess.S to spr_access.S.
    Rename to xmon_mf/tspr().
    Use @got and document rlwinm.
    Consolidate the asm.
    Tweak output formatting.
    Update SPR help message.
    Refactor SPR dump.
    Just let the logic detect 4, 5 & 6 are unimplemented.
    Rename SPR fault flag.
    Switch all to 'Sa'.
    Consolidate to one switch statement.

 arch/powerpc/xmon/Makefile     |   2 +-
 arch/powerpc/xmon/spr_access.S |  45 ++++++++++++++
 arch/powerpc/xmon/xmon.c       | 136 +++++++++++++++++++++++------------------
 3 files changed, 122 insertions(+), 61 deletions(-)
 create mode 100644 arch/powerpc/xmon/spr_access.S

diff --git a/arch/powerpc/xmon/Makefile b/arch/powerpc/xmon/Makefile
index 436062dbb6e2..0b2f771593eb 100644
--- a/arch/powerpc/xmon/Makefile
+++ b/arch/powerpc/xmon/Makefile
@@ -7,7 +7,7 @@ UBSAN_SANITIZE := n
 
 ccflags-$(CONFIG_PPC64) := $(NO_MINIMAL_TOC)
 
-obj-y			+= xmon.o nonstdio.o
+obj-y			+= xmon.o nonstdio.o spr_access.o
 
 ifdef CONFIG_XMON_DISASSEMBLY
 obj-y			+= ppc-dis.o ppc-opc.o
diff --git a/arch/powerpc/xmon/spr_access.S b/arch/powerpc/xmon/spr_access.S
new file mode 100644
index 000000000000..84ad74213c83
--- /dev/null
+++ b/arch/powerpc/xmon/spr_access.S
@@ -0,0 +1,45 @@
+#include <asm/ppc_asm.h>
+
+/* unsigned long xmon_mfspr(sprn, default_value) */
+_GLOBAL(xmon_mfspr)
+	ld	r5, .Lmfspr_table@got(r2)
+	b	xmon_mxspr
+
+/* void xmon_mtspr(sprn, new_value) */
+_GLOBAL(xmon_mtspr)
+	ld	r5, .Lmtspr_table@got(r2)
+	b	xmon_mxspr
+
+/*
+ * r3 = sprn
+ * r4 = default or new value
+ * r5 = table base
+ */
+xmon_mxspr:
+	/*
+	 * To index into the table of mxsprs we need:
+	 *  i = (sprn & 0x3ff) * 8
+	 * or using rwlinm:
+	 *  i = (sprn << 3) & (0x3ff << 3)
+	 */
+	rlwinm	r3, r3, 3, 0x3ff << 3
+	add	r5, r5, r3
+	mtctr	r5
+	mr	r3, r4 /* put default_value in r3 for mfspr */
+	bctr
+
+.Lmfspr_table:
+	spr = 0
+	.rept	1024
+	mfspr	r3, spr
+	blr
+	spr = spr + 1
+	.endr
+
+.Lmtspr_table:
+	spr = 0
+	.rept	1024
+	mtspr	spr, r4
+	blr
+	spr = spr + 1
+	.endr
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 942796fa4767..7f5c74ef80ec 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -86,6 +86,7 @@ static char tmpstr[128];
 
 static long bus_error_jmp[JMP_BUF_LEN];
 static int catch_memory_errors;
+static int catch_spr_faults;
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
@@ -250,6 +251,9 @@ Commands:\n\
   sdi #	disassemble spu local store for spu # (in hex)\n"
 #endif
 "  S	print special registers\n\
+  Sa    print all SPRs\n\
+  Sr #	read SPR #\n\
+  Sw #v write v to SPR #\n\
   t	print backtrace\n\
   x	exit monitor and recover\n\
   X	exit monitor and don't recover\n"
@@ -442,6 +446,12 @@ static int xmon_core(struct pt_regs *regs, int fromipi)
 #ifdef CONFIG_SMP
 	cpu = smp_processor_id();
 	if (cpumask_test_cpu(cpu, &cpus_in_xmon)) {
+		/*
+		 * We catch SPR read/write faults here because the 0x700, 0xf60
+		 * etc. handlers don't call debugger_fault_handler().
+		 */
+		if (catch_spr_faults)
+			longjmp(bus_error_jmp, 1);
 		get_output_lock();
 		excprint(regs);
 		printf("cpu 0x%x: Exception %lx %s in xmon, "
@@ -1635,89 +1645,87 @@ static void cacheflush(void)
 	catch_memory_errors = 0;
 }
 
-static unsigned long
-read_spr(int n)
+extern unsigned long xmon_mfspr(int spr, unsigned long default_value);
+extern void xmon_mtspr(int spr, unsigned long value);
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
+		catch_spr_faults = 1;
 		sync();
 
-		ret = code();
+		ret = xmon_mfspr(n, *vp);
 
 		sync();
-		/* wait a little while to see if we get a machine check */
-		__delay(200);
-		n = size;
+		*vp = ret;
+		ok = 1;
 	}
+	catch_spr_faults = 0;
 
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
+		catch_spr_faults = 1;
 		sync();
 
-		code(val);
+		xmon_mtspr(n, val);
 
 		sync();
-		/* wait a little while to see if we get a machine check */
-		__delay(200);
-		n = size;
+	} else {
+		printf("SPR 0x%03x (%4d) Faulted during write\n", n, n);
 	}
+	catch_spr_faults = 0;
 }
 
 static unsigned long regno;
 extern char exc_prolog;
 extern char dec_exc;
 
+static void dump_one_spr(int spr, bool show_unimplemented)
+{
+	unsigned long val;
+
+	val = 0xdeadbeef;
+	if (!read_spr(spr, &val)) {
+		printf("SPR 0x%03x (%4d) Faulted during read\n", spr, spr);
+		return;
+	}
+
+	if (val == 0xdeadbeef) {
+		/* Looks like read was a nop, confirm */
+		val = 0x0badcafe;
+		if (!read_spr(spr, &val)) {
+			printf("SPR 0x%03x (%4d) Faulted during read\n", spr, spr);
+			return;
+		}
+
+		if (val == 0x0badcafe) {
+			if (show_unimplemented)
+				printf("SPR 0x%03x (%4d) Unimplemented\n", spr, spr);
+			return;
+		}
+	}
+
+	printf("SPR 0x%03x (%4d) = 0x%lx\n", spr, spr, val);
+}
+
 static void super_regs(void)
 {
 	int cmd;
-	unsigned long val;
+	int spr;
 
 	cmd = skipbl();
-	if (cmd == '\n') {
+
+	switch (cmd) {
+	case '\n': {
 		unsigned long sp, toc;
 		asm("mr %0,1" : "=r" (sp) :);
 		asm("mr %0,2" : "=r" (toc) :);
@@ -1730,21 +1738,29 @@ static void super_regs(void)
 		       mfspr(SPRN_DEC), mfspr(SPRN_SPRG2));
 		printf("sp   = "REG"  sprg3= "REG"\n", sp, mfspr(SPRN_SPRG3));
 		printf("toc  = "REG"  dar  = "REG"\n", toc, mfspr(SPRN_DAR));
-
 		return;
 	}
-
-	scanhex(&regno);
-	switch (cmd) {
-	case 'w':
-		val = read_spr(regno);
+	case 'w': {
+		unsigned long val;
+		scanhex(&regno);
+		val = 0;
+		read_spr(regno, &val);
 		scanhex(&val);
 		write_spr(regno, val);
-		/* fall through */
+		dump_one_spr(regno, true);
+		break;
+	}
 	case 'r':
-		printf("spr %lx = %lx\n", regno, read_spr(regno));
+		scanhex(&regno);
+		dump_one_spr(regno, true);
+		break;
+	case 'a':
+		/* dump ALL SPRs */
+		for (spr = 1; spr < 1024; ++spr)
+			dump_one_spr(spr, false);
 		break;
 	}
+
 	scannl();
 }
 
-- 
2.5.0
