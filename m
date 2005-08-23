Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0CF15680DD
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Aug 2005 15:36:56 +1000 (EST)
Date: Tue, 23 Aug 2005 02:31:25 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Dan Malek <dan@embeddededge.com>
Message-ID: <20050823053125.GB10386@dmt.cnet>
References: <20050823022011.GE9667@dmt.cnet>
	<f45653d49c79423af587cff97181ac74@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f45653d49c79423af587cff97181ac74@embeddededge.com>
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: Enabling 8xx debug mode
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Aug 23, 2005 at 12:58:21AM -0400, Dan Malek wrote:
> 
> On Aug 22, 2005, at 10:20 PM, Marcelo Tosatti wrote:
> 
> >I know now that the BDI automatically enables debug mode by asserting
> >the DSCK signal (available through the JTAG port). Is there any way
> >to enable debugging mode purely via software?
> 
> I'm not sure I really understand the question, but I'll give some
> answers anyway :-)  The 8xx has the development/debug support,
> which is a bunch of registers that allow setting instruction/data
> breakpoints and so on.  These are accessible from software, along
> with other standard PowerPC debug (like single step).
> 
> The DSCK is a BDM/JTAG clock signal, and along with the other
> signals allow the clocking of instructions and data through the BDM
> pins.  One of the things you can do is strobe in instructions that will
> set these same breakpoint or other debug registers as are accessible
> from software running on the part.
> 
> So, if you have software running on the processor, you can do the
> same things.  Obviously, if you are stuck someplace you need to
> get the attention of the processor.  You can do this with some interrupt
> like kgdb does, then use the debug interface to help.
> 
> Does this make sense?

Yep.. my misunderstanding was the debug mode can only be turned ON by
asserting the DSCK signal during SRESET as the manual says.

That's fine.

I'm trying to use the debugging registers - seem to work (the example
is a data breakpoint). Just need a real interrupt handler, the current
one breaks  at trap but since the console is not yet initialized I 
et no output (that sucks).

It panic()'s, as expected.


Index: arch/ppc/boot/simple/head.S
===================================================================
RCS file: /mnt/test1/tslinux_mv21/linux-2.6/arch/ppc/boot/simple/head.S,v
retrieving revision 1.3
diff -u -r1.3 head.S
--- arch/ppc/boot/simple/head.S	16 Mar 2005 22:04:09 -0000	1.3
+++ arch/ppc/boot/simple/head.S	23 Aug 2005 01:41:07 -0000
@@ -130,7 +130,18 @@
 	 * processor correctly. Don't do this if you want to debug
 	 * using a BDM device.
 	 */
+#define CONFIG_8xx_DEBUG
+#ifdef CONFIG_8xx_DEBUG
+	/* bit 2: Checkstop enable
+	 * bit 3: Machine check interrupt enable
+	 * bits [28,30]: load/store, instruction and external breakpoint resp.
+	 * bit 31: Development port nonmaskable request enable
+	 */
+	li	r4,0x000F
+	lis	r4,0x3000
+#else
 	li	r4,0		/* Zero DER to prevent FRZ */
+#endif
 	mtspr	SPRN_DER,r4
 #endif
 
Index: arch/ppc/kernel/head_8xx.S
===================================================================
RCS file: /mnt/test1/tslinux_mv21/linux-2.6/arch/ppc/kernel/head_8xx.S,v
retrieving revision 1.4
diff -u -r1.4 head_8xx.S
--- arch/ppc/kernel/head_8xx.S	16 Mar 2005 22:04:09 -0000	1.4
+++ arch/ppc/kernel/head_8xx.S	23 Aug 2005 03:05:35 -0000
@@ -554,7 +554,17 @@
  * support of breakpoints and such.  Someday I will get around to
  * using them.
  */
-	EXCEPTION(0x1c00, Trap_1c, UnknownException, EXC_XFER_EE)
+. = 0x1c00
+DataBreakpoint:
+
+	EXCEPTION_PROLOG
+	mfspr r4,DAR
+	stw r4,_DAR(r11)
+	mfspr r5,DSISR
+	stw r5,_DSISR(r11)
+	trap
+
+/*	EXCEPTION(0x1c00, Trap_1c, UnknownException, EXC_XFER_EE) */
 	EXCEPTION(0x1d00, Trap_1d, UnknownException, EXC_XFER_EE)
 	EXCEPTION(0x1e00, Trap_1e, UnknownException, EXC_XFER_EE)
 	EXCEPTION(0x1f00, Trap_1f, UnknownException, EXC_XFER_EE)
Index: arch/ppc/kernel/misc.S
===================================================================
RCS file: /mnt/test1/tslinux_mv21/linux-2.6/arch/ppc/kernel/misc.S,v
retrieving revision 1.4
diff -u -r1.4 misc.S
--- arch/ppc/kernel/misc.S	21 Jun 2005 16:43:24 -0000	1.4
+++ arch/ppc/kernel/misc.S	22 Aug 2005 23:23:06 -0000
@@ -1276,6 +1276,31 @@
 	addi	r1,r1,16
 	blr
 
+#define LCTRL1	156
+#define LCTRL2	157
+#define CMPE	152
+#define CMPF	153
+
+/* initrd_watchpoint(unsigned long start, unsigned long end) */
+_GLOBAL(initrd_watchpoint)
+	stw	r5, 4(r0)
+
+	mtspr	CMPE, r3
+	mtspr	CMPF, r4
+
+	li 	r5, 0x0000
+	lis	r5, 0xD4F0
+
+	mtspr	LCTRL1,	r5
+
+	li 	r5, 0x0002
+	lis	r5, 0x8A00
+
+	mtspr	LCTRL2, r5
+
+	lwz	r5, 4(r0)
+	blr
+
 /*
  * This routine is just here to keep GCC happy - sigh...
  */
Index: arch/ppc/syslib/m8xx_setup.c
===================================================================
RCS file: /mnt/test1/tslinux_mv21/linux-2.6/arch/ppc/syslib/m8xx_setup.c,v
retrieving revision 1.12
diff -u -r1.12 m8xx_setup.c
--- arch/ppc/syslib/m8xx_setup.c	30 Jun 2005 23:02:49 -0000	1.12
+++ arch/ppc/syslib/m8xx_setup.c	23 Aug 2005 03:08:27 -0000
@@ -70,6 +70,8 @@
 
 unsigned char __res[sizeof(bd_t)];
 
+extern void initrd_watchpoint(unsigned long start, unsigned long end);
+
 extern void m8xx_ide_init(void);
 
 extern unsigned long find_available_memory(void);
@@ -618,6 +620,9 @@
 	}
 #endif /* CONFIG_BLK_DEV_INITRD */
 	/* take care of cmd line */
+	
+	//initrd_watchpoint(initrd_start, initrd_end);
+	
 	if ( r6 )
 	{
 		*(char *)(r7+KERNELBASE) = 0;
diff -u -r1.6 main.c
--- init/main.c	14 Jun 2005 18:17:07 -0000	1.6
+++ init/main.c	23 Aug 2005 03:08:10 -0000
@@ -453,6 +453,8 @@
  *	Activate the first processor.
  */
 
+extern void initrd_watchpoint(unsigned long start, unsigned long end);
+
 asmlinkage void __init start_kernel(void)
 {
 	char * command_line;
@@ -495,6 +497,7 @@
 		   __stop___param - __start___param,
 		   &unknown_bootoption);
 	sort_main_extable();
+	initrd_watchpoint(initrd_start, initrd_end);	
 	trap_init();
 	rcu_init();
 	init_IRQ();
