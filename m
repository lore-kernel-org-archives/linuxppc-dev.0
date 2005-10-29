Return-Path: <akpm@osdl.org>
Message-Id: <200510290046.j9T0klC0030003@shell0.pdx.osdl.net>
To: paulus@samba.org
From: akpm@osdl.org
Date: Fri, 28 Oct 2005 17:46:16 -0700
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Subject: [patch 06/43] ppc32: handle access to non-present IO ports on 8xx
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>

Accessing non present "IO ports" on 8xx generates MCE's.  The exception is
easily triggered during insertion/removal/suspension of PCMCIA cards.

The following adds exception table entries for I/O instructions on 8xx
(copied from the original Paul's PowerMac code), and changes
MachineCheckException() slightly to cover 8xx specific's (on 8xx the MCE
can be generated while executing the IO access instruction itself, which is
not the case on PowerMac's, as the comment on traps.c details).

Signed-off-by: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/ppc/kernel/misc.S  |  160 ++++++++++++++++++++++++++++++++++++++++++------
 arch/ppc/kernel/traps.c |    8 +-
 include/asm-ppc/io.h    |   24 ++++++-
 3 files changed, 168 insertions(+), 24 deletions(-)

diff -puN arch/ppc/kernel/misc.S~ppc32-handle-access-to-non-present-io-ports-on-8xx arch/ppc/kernel/misc.S
--- devel/arch/ppc/kernel/misc.S~ppc32-handle-access-to-non-present-io-ports-on-8xx	2005-10-28 17:44:02.000000000 -0700
+++ devel-akpm/arch/ppc/kernel/misc.S	2005-10-28 17:44:02.000000000 -0700
@@ -930,8 +930,20 @@ _GLOBAL(_insb)
 	subi	r4,r4,1
 	blelr-
 00:	lbz	r5,0(r3)
-	eieio
-	stbu	r5,1(r4)
+01:	eieio
+02:	stbu	r5,1(r4)
+#ifdef CONFIG_8xx
+	isync
+	.section .fixup,"ax"
+03:            blr
+	.text
+	.section __ex_table, "a"
+		.align 2
+		.long 00b, 03b
+		.long 01b, 03b
+		.long 02b, 03b
+	.text
+#endif
 	bdnz	00b
 	blr
 
@@ -941,8 +953,20 @@ _GLOBAL(_outsb)
 	subi	r4,r4,1
 	blelr-
 00:	lbzu	r5,1(r4)
-	stb	r5,0(r3)
-	eieio
+01:	stb	r5,0(r3)
+02:	eieio
+#ifdef CONFIG_8xx
+        isync
+        .section .fixup,"ax"
+03:            blr
+        .text
+        .section __ex_table, "a"
+                .align 2
+                .long 00b, 03b
+                .long 01b, 03b
+                .long 02b, 03b
+        .text
+#endif
 	bdnz	00b
 	blr
 
@@ -952,8 +976,20 @@ _GLOBAL(_insw)
 	subi	r4,r4,2
 	blelr-
 00:	lhbrx	r5,0,r3
-	eieio
-	sthu	r5,2(r4)
+01:	eieio
+02:	sthu	r5,2(r4)
+#ifdef CONFIG_8xx
+        isync
+        .section .fixup,"ax"
+03:            blr
+        .text
+        .section __ex_table, "a"
+                .align 2
+                .long 00b, 03b
+                .long 01b, 03b
+                .long 02b, 03b
+        .text
+#endif
 	bdnz	00b
 	blr
 
@@ -963,8 +999,20 @@ _GLOBAL(_outsw)
 	subi	r4,r4,2
 	blelr-
 00:	lhzu	r5,2(r4)
-	eieio
-	sthbrx	r5,0,r3
+01:	eieio
+02:	sthbrx	r5,0,r3
+#ifdef CONFIG_8xx
+        isync
+        .section .fixup,"ax"
+03:            blr
+        .text
+        .section __ex_table, "a"
+                .align 2
+                .long 00b, 03b
+                .long 01b, 03b
+                .long 02b, 03b
+        .text
+#endif
 	bdnz	00b
 	blr
 
@@ -974,8 +1022,20 @@ _GLOBAL(_insl)
 	subi	r4,r4,4
 	blelr-
 00:	lwbrx	r5,0,r3
-	eieio
-	stwu	r5,4(r4)
+01:	eieio
+02:	stwu	r5,4(r4)
+#ifdef CONFIG_8xx
+        isync
+        .section .fixup,"ax"
+03:            blr
+        .text
+        .section __ex_table, "a"
+                .align 2
+                .long 00b, 03b
+                .long 01b, 03b
+                .long 02b, 03b
+        .text
+#endif
 	bdnz	00b
 	blr
 
@@ -985,8 +1045,20 @@ _GLOBAL(_outsl)
 	subi	r4,r4,4
 	blelr-
 00:	lwzu	r5,4(r4)
-	stwbrx	r5,0,r3
-	eieio
+01:	stwbrx	r5,0,r3
+02:	eieio
+#ifdef CONFIG_8xx
+        isync
+        .section .fixup,"ax"
+03:            blr
+        .text
+        .section __ex_table, "a"
+                .align 2
+                .long 00b, 03b
+                .long 01b, 03b
+                .long 02b, 03b
+        .text
+#endif
 	bdnz	00b
 	blr
 
@@ -997,8 +1069,20 @@ _GLOBAL(_insw_ns)
 	subi	r4,r4,2
 	blelr-
 00:	lhz	r5,0(r3)
-	eieio
-	sthu	r5,2(r4)
+01:	eieio
+02:	sthu	r5,2(r4)
+#ifdef CONFIG_8xx
+        isync
+        .section .fixup,"ax"
+03:            blr
+        .text
+        .section __ex_table, "a"
+                .align 2
+                .long 00b, 03b
+                .long 01b, 03b
+                .long 02b, 03b
+        .text
+#endif
 	bdnz	00b
 	blr
 
@@ -1009,8 +1093,20 @@ _GLOBAL(_outsw_ns)
 	subi	r4,r4,2
 	blelr-
 00:	lhzu	r5,2(r4)
-	sth	r5,0(r3)
-	eieio
+01:	sth	r5,0(r3)
+02:	eieio
+#ifdef CONFIG_8xx
+        isync
+        .section .fixup,"ax"
+03:            blr
+        .text
+        .section __ex_table, "a"
+                .align 2
+                .long 00b, 03b
+                .long 01b, 03b
+                .long 02b, 03b
+        .text
+#endif
 	bdnz	00b
 	blr
 
@@ -1021,8 +1117,20 @@ _GLOBAL(_insl_ns)
 	subi	r4,r4,4
 	blelr-
 00:	lwz	r5,0(r3)
-	eieio
-	stwu	r5,4(r4)
+01:	eieio
+02:	stwu	r5,4(r4)
+#ifdef CONFIG_8xx
+        isync
+        .section .fixup,"ax"
+03:            blr
+        .text
+        .section __ex_table, "a"
+                .align 2
+                .long 00b, 03b
+                .long 01b, 03b
+                .long 02b, 03b
+        .text
+#endif
 	bdnz	00b
 	blr
 
@@ -1033,8 +1141,20 @@ _GLOBAL(_outsl_ns)
 	subi	r4,r4,4
 	blelr-
 00:	lwzu	r5,4(r4)
-	stw	r5,0(r3)
-	eieio
+01:	stw	r5,0(r3)
+02:	eieio
+#ifdef CONFIG_8xx
+        isync
+        .section .fixup,"ax"
+03:            blr
+        .text
+        .section __ex_table, "a"
+                .align 2
+                .long 00b, 03b
+                .long 01b, 03b
+                .long 02b, 03b
+        .text
+#endif
 	bdnz	00b
 	blr
 
diff -puN arch/ppc/kernel/traps.c~ppc32-handle-access-to-non-present-io-ports-on-8xx arch/ppc/kernel/traps.c
--- devel/arch/ppc/kernel/traps.c~ppc32-handle-access-to-non-present-io-ports-on-8xx	2005-10-28 17:44:02.000000000 -0700
+++ devel-akpm/arch/ppc/kernel/traps.c	2005-10-28 17:44:02.000000000 -0700
@@ -154,7 +154,7 @@ void _exception(int signr, struct pt_reg
  */
 static inline int check_io_access(struct pt_regs *regs)
 {
-#ifdef CONFIG_PPC_PMAC
+#if defined CONFIG_PPC_PMAC || defined CONFIG_8xx
 	unsigned long msr = regs->msr;
 	const struct exception_table_entry *entry;
 	unsigned int *nip = (unsigned int *)regs->nip;
@@ -173,7 +173,11 @@ static inline int check_io_access(struct
 			nip -= 2;
 		else if (*nip == 0x4c00012c)	/* isync */
 			--nip;
-		if (*nip == 0x7c0004ac || (*nip >> 26) == 3) {
+		/* eieio from I/O string functions */
+		else if ((*nip) == 0x7c0006ac || *(nip+1) == 0x7c0006ac)
+			nip += 2;
+		if (*nip == 0x7c0004ac || (*nip >> 26) == 3 ||
+			(*(nip+1) >> 26) == 3) {
 			/* sync or twi */
 			unsigned int rb;
 
diff -puN include/asm-ppc/io.h~ppc32-handle-access-to-non-present-io-ports-on-8xx include/asm-ppc/io.h
--- devel/include/asm-ppc/io.h~ppc32-handle-access-to-non-present-io-ports-on-8xx	2005-10-28 17:44:02.000000000 -0700
+++ devel-akpm/include/asm-ppc/io.h	2005-10-28 17:44:02.000000000 -0700
@@ -257,7 +257,7 @@ extern __inline__ unsigned int name(unsi
 {							\
 	unsigned int x;					\
 	__asm__ __volatile__(				\
-			op "	%0,0,%1\n"		\
+		"0:"	op "	%0,0,%1\n"		\
 		"1:	twi	0,%0,0\n"		\
 		"2:	isync\n"			\
 		"3:	nop\n"				\
@@ -268,6 +268,7 @@ extern __inline__ unsigned int name(unsi
 		".previous\n"				\
 		".section __ex_table,\"a\"\n"		\
 		"	.align	2\n"			\
+		"	.long	0b,5b\n"		\
 		"	.long	1b,5b\n"		\
 		"	.long	2b,5b\n"		\
 		"	.long	3b,5b\n"		\
@@ -276,7 +277,25 @@ extern __inline__ unsigned int name(unsi
 		: "r" (port + ___IO_BASE));		\
 	return x;					\
 }
-
+#ifdef CONFIG_8xx
+#define __do_out_asm(name, op)				\
+extern __inline__ void name(unsigned int val, unsigned int port) \
+{							\
+	__asm__ __volatile__(				\
+		"0:" op " %0,0,%1\n"				\
+		"1:	sync\n"				\
+		"2:\n"					\
+		".section .fixup,\"ax\"\n"              \
+		"3:     b       2b\n"                   \
+		".previous\n"				\
+		".section __ex_table,\"a\"\n"		\
+		"	.align	2\n"			\
+		"	.long	0b,2b\n"		\
+		"	.long	1b,2b\n"		\
+		".previous"				\
+		: : "r" (val), "r" (port + ___IO_BASE));	\
+}
+#else
 #define __do_out_asm(name, op)				\
 extern __inline__ void name(unsigned int val, unsigned int port) \
 {							\
@@ -290,6 +309,7 @@ extern __inline__ void name(unsigned int
 		".previous"				\
 		: : "r" (val), "r" (port + ___IO_BASE));	\
 }
+#endif
 
 __do_out_asm(outb, "stbx")
 #ifdef CONFIG_APUS
_
