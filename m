Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BEE39679FC
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  2 Jun 2005 08:00:47 +1000 (EST)
Date: Wed, 1 Jun 2005 13:50:54 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>,
	Pantelis Antoniou <panto@intracom.gr>, Dan Malek <dan@embeddededge.com>
Message-ID: <20050601165054.GA2607@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [RFC] handle access to non-present IO ports on 8xx 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

Accessing non present "IO ports" on 8xx generates MCE's. The exception is easily
triggered during insertion/removal/suspension of PCMCIA cards. 

The following (against ancient v2.4) adds exception table entries for I/O
instructions on 8xx (copied from the original Paul's PowerMac code), and
changes MachineCheckException() slightly to cover 8xx specific's (on 8xx
the MCE can be generated while executing the IO access instruction itself,
which is not the case on PowerMac's, as the comment on traps.c details).

A few things I'm wondering:

1) why does the current PowerMac version covers only inb() and not outb() ?  
I had to add outb() exception table entries for 8xx.

2) Is the same wanted for other embedded PPC's? 

3) How to make the misc.S exception entries and additional instructions 
selectable only on the platform who need it? #ifdef does not sound 
a good idea. 

Nevermind the "#ifdef CONFIG_ALL_PPC" crap - that needs to be done
properly.


Index: arch/ppc/kernel/misc.S
===================================================================
RCS file: /mnt/test1/tslinux_mv21/linux-216/arch/ppc/kernel/misc.S,v
retrieving revision 1.2
diff -u -r1.2 misc.S
--- arch/ppc/kernel/misc.S	22 Oct 2003 19:34:30 -0000	1.2
+++ arch/ppc/kernel/misc.S	1 Jun 2005 17:59:30 -0000
@@ -736,8 +736,23 @@
 	subi	r4,r4,1
 	blelr-
 00:	lbz	r5,0(r3)
-	eieio
-	stbu	r5,1(r4)
+01:	eieio
+02:	stbu	r5,1(r4)
+03:	twi 0, r5, 0
+04:	isync
+05:	nop
+06:	.section .fixup,"ax"
+07:		b 9f
+	.text
+08:	.section __ex_table, "a"
+		.align 2
+		.long 00b, 07b
+		.long 01b, 07b
+		.long 02b, 07b
+		.long 03b, 07b
+		.long 04b, 07b
+		.long 05b, 07b
+	.text
 	bdnz	00b
 	blr
 
@@ -747,10 +762,27 @@
 	subi	r4,r4,1
 	blelr-
 00:	lbzu	r5,1(r4)
-	stb	r5,0(r3)
-	eieio
+01:	stb	r5,0(r3)
+02:	eieio
+03:	twi 0, r5, 0
+04:	isync
+05:	nop
+06:	.section .fixup,"ax"
+07:		b 9f
+	.text
+08:	.section __ex_table, "a"
+		.align 2
+		.long 00b, 07b
+		.long 01b, 07b
+		.long 02b, 07b
+		.long 03b, 07b
+		.long 04b, 07b
+		.long 05b, 07b
+	.text
+
 	bdnz	00b
-	blr	
+9:	blr	
+
 
 _GLOBAL(_insw)
 	cmpwi	0,r5,0
@@ -758,10 +790,25 @@
 	subi	r4,r4,2
 	blelr-
 00:	lhbrx	r5,0,r3
-	eieio
-	sthu	r5,2(r4)
+01:	eieio
+02:	sthu	r5,2(r4)
+03:	twi 0, r5, 0
+04:	isync
+05:	nop
+06:	.section .fixup,"ax"
+07:		b 9f
+	.text
+08:	.section __ex_table, "a"
+		.align 2
+		.long 00b, 07b
+		.long 01b, 07b
+		.long 02b, 07b
+		.long 03b, 07b
+		.long 04b, 07b
+		.long 05b, 07b
+	.text
 	bdnz	00b
-	blr
+9:	blr
 
 _GLOBAL(_outsw)
 	cmpwi	0,r5,0
@@ -769,10 +816,25 @@
 	subi	r4,r4,2
 	blelr-
 00:	lhzu	r5,2(r4)
-	eieio
-	sthbrx	r5,0,r3	
+01:	eieio
+02:	sthbrx	r5,0,r3	
+03:	twi 0, r5, 0
+04:	isync
+05:	nop
+06:	.section .fixup,"ax"
+07:		b 9f	
+	.text
+08:	.section __ex_table, "a"
+		.align 2
+		.long 00b, 07b
+		.long 01b, 07b
+		.long 02b, 07b
+		.long 03b, 07b
+		.long 04b, 07b
+		.long 05b, 07b
+	.text
 	bdnz	00b
-	blr	
+9:	blr	
 
 _GLOBAL(_insl)
 	cmpwi	0,r5,0
@@ -780,10 +842,25 @@
 	subi	r4,r4,4
 	blelr-
 00:	lwbrx	r5,0,r3
-	eieio
-	stwu	r5,4(r4)
+01:	eieio
+02:	stwu	r5,4(r4)
+03:	twi 0, r5, 0
+04:	isync
+05:	nop
+06:	.section .fixup,"ax"
+07:		b 9f
+	.text
+08:	.section __ex_table, "a"
+		.align 2
+		.long 00b, 07b
+		.long 01b, 07b
+		.long 02b, 07b
+		.long 03b, 07b
+		.long 04b, 07b
+		.long 05b, 07b
+	.text
 	bdnz	00b
-	blr
+9:	blr
 
 _GLOBAL(_outsl)
 	cmpwi	0,r5,0
@@ -791,10 +868,26 @@
 	subi	r4,r4,4
 	blelr-
 00:	lwzu	r5,4(r4)
-	stwbrx	r5,0,r3
-	eieio
+01:	stwbrx	r5,0,r3
+02:	eieio
+02:	stwu	r5,4(r4)
+03:	twi 0, r5, 0
+04:	isync
+05:	nop
+06:	.section .fixup,"ax"
+07:		b 9f
+	.text
+08:	.section __ex_table, "a"
+		.align 2
+		.long 00b, 07b
+		.long 01b, 07b
+		.long 02b, 07b
+		.long 03b, 07b
+		.long 04b, 07b
+		.long 05b, 07b
+	.text
 	bdnz	00b
-	blr	
+9:	blr	
 
 _GLOBAL(ide_insw)
 _GLOBAL(_insw_ns)
@@ -803,10 +896,25 @@
 	subi	r4,r4,2
 	blelr-
 00:	lhz	r5,0(r3)
-	eieio
-	sthu	r5,2(r4)
+01:	eieio
+02:	sthu	r5,2(r4)
+03:	twi 0, r5, 0
+04:	isync
+05:	nop
+06:	.section .fixup,"ax"
+07:		blr
+	.previous
+08:	.section __ex_table, "a"
+		.align 2
+		.long 00b, 07b
+		.long 01b, 07b
+		.long 02b, 07b
+		.long 03b, 07b
+		.long 04b, 07b
+		.long 05b, 07b
+	.previous
 	bdnz	00b
-	blr
+9:	blr
 
 _GLOBAL(ide_outsw)
 _GLOBAL(_outsw_ns)
@@ -815,10 +923,25 @@
 	subi	r4,r4,2
 	blelr-
 00:	lhzu	r5,2(r4)
-	sth	r5,0(r3)
-	eieio
+01:	sth	r5,0(r3)
+02:	eieio
+03:	twi 0, r5, 0
+04:	isync
+05:	nop
+06:	.section .fixup,"ax"
+07:		b 9f
+	.text
+08:	.section __ex_table, "a"
+		.align 2
+		.long 00b, 07b
+		.long 01b, 07b
+		.long 02b, 07b
+		.long 03b, 07b
+		.long 04b, 07b
+		.long 05b, 07b
+	.text
 	bdnz	00b
-	blr	
+9:	blr	
 
 _GLOBAL(_insl_ns)
 	cmpwi	0,r5,0
@@ -826,10 +949,10 @@
 	subi	r4,r4,4
 	blelr-
 00:	lwz	r5,0(r3)
-	eieio
-	stwu	r5,4(r4)
+01:	eieio
+02:	stwu	r5,4(r4)
 	bdnz	00b
-	blr
+9:	blr
 
 _GLOBAL(_outsl_ns)
 	cmpwi	0,r5,0
@@ -837,10 +960,10 @@
 	subi	r4,r4,4
 	blelr-
 00:	lwzu	r5,4(r4)
-	stw	r5,0(r3)
-	eieio
+01:	stw	r5,0(r3)
+02:	eieio
 	bdnz	00b
-	blr	
+9:	blr	
 
 /*
  * Extended precision shifts.
Index: arch/ppc/kernel/traps.c
===================================================================
RCS file: /mnt/test1/tslinux_mv21/linux-216/arch/ppc/kernel/traps.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 traps.c
--- arch/ppc/kernel/traps.c	19 Jun 2002 18:15:32 -0000	1.1.1.1
+++ arch/ppc/kernel/traps.c	1 Jun 2005 19:09:15 -0000
@@ -130,9 +130,7 @@
 void
 MachineCheckException(struct pt_regs *regs)
 {
-#ifdef CONFIG_ALL_PPC
 	unsigned long fixup;
-#endif /* CONFIG_ALL_PPC */
 	unsigned long msr = regs->msr;
 
 	if (user_mode(regs)) {
@@ -150,7 +148,7 @@
 		return;
 	}
 
-#ifdef CONFIG_ALL_PPC
+//#ifdef CONFIG_ALL_PPC
 	/*
 	 * I/O accesses can cause machine checks on powermacs.
 	 * Check if the NIP corresponds to the address of a sync
@@ -176,20 +174,25 @@
 			nip -= 2;
 		else if (*nip == 0x4c00012c)	/* isync */
 			--nip;
-		if (*nip == 0x7c0004ac || (*nip >> 26) == 3) {
+		/* eieio from I/O string functions */
+		else if ((*nip) == 0x7c0006ac || *(nip+1) == 0x7c0006ac)
+			nip += 2;
+
+		if (*nip == 0x7c0004ac || (*(nip+1) >> 26) == 3 ||
+				(*nip >> 26) == 3) {
 			/* sync or twi */
 			unsigned int rb;
 
 			--nip;
 			rb = (*nip >> 11) & 0x1f;
-			printk(KERN_DEBUG "%s bad port %lx at %p\n",
+			printk(KERN_ERR "%s bad port %lx at %p\n",
 			       (*nip & 0x100)? "OUT to": "IN from",
 			       regs->gpr[rb] - _IO_BASE, nip);
 			regs->nip = fixup;
 			return;
 		}
 	}
-#endif /* CONFIG_ALL_PPC */
+//#endif /* CONFIG_ALL_PPC */
 	printk("Machine check in kernel mode.\n");
 	printk("Caused by (from SRR1=%lx): ", msr);
 	switch (msr & 0x601F0000) {
Index: include/asm-ppc/io.h
===================================================================
RCS file: /mnt/test1/tslinux_mv21/linux-216/include/asm-ppc/io.h,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 io.h
--- include/asm-ppc/io.h	19 Jun 2002 18:16:26 -0000	1.1.1.1
+++ include/asm-ppc/io.h	30 May 2005 21:12:38 -0000
@@ -82,7 +82,7 @@
 #define insl(port, buf, nl)	_insl_ns((u32 *)((port)+_IO_BASE), (buf), (nl))
 #define outsl(port, buf, nl)	_outsl_ns((u32 *)((port)+_IO_BASE), (buf), (nl))
 
-#ifdef CONFIG_ALL_PPC
+#ifdef CONFIG_8xx
 /*
  * On powermacs, we will get a machine check exception if we
  * try to read data from a non-existent I/O port.  Because the
@@ -105,7 +105,7 @@
 {							\
 	unsigned int x;					\
 	__asm__ __volatile__(				\
-			op "	%0,0,%1\n"		\
+		"0:"	op "	%0,0,%1\n"		\
 		"1:	twi	0,%0,0\n"		\
 		"2:	isync\n"			\
 		"3:	nop\n"				\
@@ -116,6 +116,7 @@
 		".previous\n"				\
 		".section __ex_table,\"a\"\n"		\
 		"	.align	2\n"			\
+		"	.long   0b,5b\n"			\
 		"	.long	1b,5b\n"		\
 		"	.long	2b,5b\n"		\
 		"	.long	3b,5b\n"		\
@@ -129,12 +130,20 @@
 extern __inline__ void name(unsigned int val, unsigned int port) \
 {							\
 	__asm__ __volatile__(				\
-		op " %0,0,%1\n"				\
-		"1:	sync\n"				\
-		"2:\n"					\
+		"0:" op " %0,0,%1\n"			\
+		"1:  twi 0, %0, 0\n"			\
+		"2:   isync\n"				\
+		"3:   nop\n"				\
+		"4:\n"					\
+		".section .fixup,\"ax\"\n"		\
+		"5:	b	4b\n"			\
+		".previous\n"				\
 		".section __ex_table,\"a\"\n"		\
 		"	.align	2\n"			\
-		"	.long	1b,2b\n"		\
+		"	.long   0b,5b\n"		\
+		"	.long	1b,5b\n"		\
+		"	.long	2b,5b\n"		\
+		"	.long	3b,5b\n"		\
 		".previous"				\
 		: : "r" (val), "r" (port + _IO_BASE));	\
 }
