Message-ID: <3C0C3300.A33AAF59@mvista.com>
Date: Mon, 03 Dec 2001 18:20:48 -0800
From: Frank Rowand <frank_rowand@mvista.com>
Reply-To: frowand@mvista.com
MIME-Version: 1.0
To: trini@mvista.com, linuxppc-dev@lists.linuxppc.org
Cc: frowand@mvista.com
Subject: Fix for 4xx KGDB continue command
Content-Type: multipart/mixed;
 boundary="------------1966E1A6C5333E9025B5B62D"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------1966E1A6C5333E9025B5B62D
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Tom,

Can you apply the attached patch to fix problems with the 4xx
KGDB continue command in the 2_4_devel tree?

The symptom is that in some cases to continue from a breakpoint
the continue command has to be issued twice.  This can be seen
by: 1) set a breakpoint at sys_sync, 2) type "sync" on the console,
3) type "c" in KGDB -- KGDB will return to the sys_sync breakpoint
instead of continueing, 4) type "c" in KGDB -- KGDB will continue
properly and the console prompt will be printed on the console.

The major change was to always use the Program exception to handle
KGDB trap instructions and to clean up the Program exception code path.


Files modified in the patch:

  arch/ppc/config.in
    - fix the if that allows CONFIG_COMPILE_OPTIONS to be set

  arch/ppc/kernel/head_4xx.S
    - update comments
    - read value of SPRN_SRR3 before clearing the MSR_DE bit in
      it

  arch/ppc/kernel/ppc-stub.c
    - Increase the coverage of the "kdebug" support to show the
      communications protocol involved in continue and single step
      (all other commands were already covered).
    - Don't use the debug exception for the 4xx continue command.
    - For 4xx single step include IDM in the value put in DBCR0,
      don't set the (non-existent) MSR_SE bit, and properly restore msr.

  arch/ppc/kernel/ppc4xx_kgdb.c
    - remove call to ppc4xx_kgdb_init()

  arch/ppc/kernel/ppc4xx_setup.c
    - remove ppc4xx_kgdb_init() (no longer needed since debug exception
      is not used for trap instruction).
    - rename ppc4xx_gdb_init() to ppc4xx_bdi_init() to better reflect
      its purpose.

  arch/ppc/kernel/traps.c
    - For 4xx Program exception, clear bit that indicates a trap
      instruction occurred.


Thanks!

Frank
--
Frank Rowand <frank_rowand@mvista.com>
MontaVista Software, Inc
--------------1966E1A6C5333E9025B5B62D
Content-Type: text/plain; charset=us-ascii;
 name="patch_kgdb_1.731"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="patch_kgdb_1.731"

diff -ruN ORIG/linux/arch/ppc/config.in NEW/linux/arch/ppc/config.in
--- ORIG/linux/arch/ppc/config.in	Mon Dec  3 16:13:54 2001
+++ NEW/linux/arch/ppc/config.in	Mon Dec  3 16:14:12 2001
@@ -603,7 +603,7 @@
 if [ "$CONFIG_KGDB" = "y" -o "$CONFIG_XMON" = "y" \
 	-o "$CONFIG_BDI_SWITCH" = "y" ]; then
   bool 'Add any additional compile options' CONFIG_MORE_COMPILE_OPTIONS
-  if [ "$CONFIG_COMPILE_OPTIONS" = "y" ]; then
+  if [ "$CONFIG_MORE_COMPILE_OPTIONS" = "y" ]; then
     string 'Additional compile arguments' CONFIG_COMPILE_OPTIONS "-O1 -ggdb"
   fi
 fi
diff -ruN ORIG/linux/arch/ppc/kernel/head_4xx.S NEW/linux/arch/ppc/kernel/head_4xx.S
--- ORIG/linux/arch/ppc/kernel/head_4xx.S	Mon Dec  3 17:19:45 2001
+++ NEW/linux/arch/ppc/kernel/head_4xx.S	Mon Dec  3 17:20:37 2001
@@ -684,13 +684,13 @@

 /* 0x2000 - Debug Exception
 */
-	START_EXCEPTION(0x2000, DebugTrap);
+	START_EXCEPTION(0x2000, DebugTrap)
 	b	check_single_step_in_exception
 ret_to_debug_exception:
 	CRIT_EXCEPTION_PROLOG(0x2000)
-	addi	r3,r1,STACK_FRAME_OVERHEAD;
+	addi	r3,r1,STACK_FRAME_OVERHEAD
 	li	r7,CRIT_EXC;
-        li      r20,MSR_KERNEL;  /* don't turn MSR_DE back on yet */
+        li      r20,MSR_KERNEL
 	FINISH_EXCEPTION(DebugException)

 /* Make sure the final interrupt handler has not spilled past the
@@ -698,12 +698,18 @@
  */
         .=0x2100

-/* The Debug Enable in the MSR is not reset upon entering an exception.
- * This causes problems for single step, because we then single step
- * the first exception handler instruction instead of the user instruction.
- * If we get a debug trap while in an exception handler, we reset the
- * MSR_DE and continue.  Upon exit of the exception handler, the original
- * msr is restored, hopefully single stepping the user instruction.
+/* Check for a single step debug exception while in an exception
+ * handler before state has been saved.  This is to catch the case
+ * where an instruction that we are trying to single step causes
+ * an exception (eg ITLB miss) and thus the first instruction of
+ * the exception handler generates a single step debug exception.
+ *
+ * If we get a debug trap on the first instruction of an exception handler,
+ * we reset the MSR_DE in the _exception handlers_ MSR (the debug trap is
+ * a critical exception, so we are using SPRN_SRR3 to manipulate the MSR).
+ * The exception handler was handling a non-critical interrupt, so it will
+ * save (and later restore) the MSR via SPRN_SRR1, which will still have
+ * the MSR_DE bit set.
  */
 check_single_step_in_exception:

@@ -714,17 +720,19 @@
 	mtspr	SPRN_SPRG0,r20		/* Save some working registers... */
 	mtspr	SPRN_SPRG1,r21
 	mfcr	r20			/* ..and the cr because we change it */
-	mfspr   r21,SPRN_SRR3           /* MSR at the time of fault */
+
+	mfspr   r21,SPRN_SRR3		/* MSR at the time of fault */
 	andi.   r21,r21,MSR_PR
-	bne+    2f
+	bne+    2f			/* trapped from problem state */

-	mfspr   r21,SPRN_SRR2           /* Faulting instruction address */
+	mfspr   r21,SPRN_SRR2		/* Faulting instruction address */
 	cmplwi  r21,0x2100
-	bgt+    2f
+	bgt+    2f			/* address above exception vectors */

 	lis     r21,DBSR_IC@h           /* Remove the trap status */
 	mtspr   SPRN_DBSR,r21

+	mfspr	r21,SPRN_SRR3
 	rlwinm	r21,r21,0,23,21		/* clear MSR_DE */
 	mtspr	SPRN_SRR3, r21		/* restore MSR at rcfi without DE */

diff -ruN ORIG/linux/arch/ppc/kernel/ppc-stub.c NEW/linux/arch/ppc/kernel/ppc-stub.c
--- ORIG/linux/arch/ppc/kernel/ppc-stub.c	Mon Dec  3 17:19:45 2001
+++ NEW/linux/arch/ppc/kernel/ppc-stub.c	Mon Dec  3 17:20:37 2001
@@ -564,6 +564,9 @@
 	*ptr++ = 0;

 	putpacket(remcomOutBuffer);
+	if (kdebug) {
+		printk("remcomOutBuffer: %s\n", remcomOutBuffer);
+	}

 	/* XXX We may want to add some features dealing with poking the
 	 * XXX page tables, ... (look at sparc-stub.c for more info)
@@ -719,30 +722,34 @@
 #if defined(CONFIG_4xx)
                         strcpy(remcomOutBuffer, "OK");
                         putpacket(remcomOutBuffer);
-			regs->msr |= MSR_DE;
-			regs->dbcr0 |= DBCR0_IDM;
-
-#else
+#endif
 			set_msr(msr);

-#endif
 			kgdb_interruptible(1);
 			unlock_kernel();
 			kgdb_active = 0;
+			if (kdebug) {
+				printk("remcomInBuffer: %s\n", remcomInBuffer);
+				printk("remcomOutBuffer: %s\n", remcomOutBuffer);
+			}
 			return;

 		case 's':
 			kgdb_flush_cache_all();
-			regs->msr |= MSR_SE;
 #if defined(CONFIG_4xx)
                         regs->msr |= MSR_DE;
-			regs->dbcr0 |= DBCR0_IC;
-
+			regs->dbcr0 |= (DBCR0_IDM | DBCR0_IC);
+			set_msr(msr);
 #else
+                        regs->msr |= MSR_SE;
 			set_msr(msr | MSR_SE);
 #endif
 			unlock_kernel();
 			kgdb_active = 0;
+			if (kdebug) {
+				printk("remcomInBuffer: %s\n", remcomInBuffer);
+				printk("remcomOutBuffer: %s\n", remcomOutBuffer);
+			}
 			return;

 		case 'r':		/* Reset (if user process..exit ???)*/
diff -ruN ORIG/linux/arch/ppc/kernel/ppc4xx_kgdb.c NEW/linux/arch/ppc/kernel/ppc4xx_kgdb.c
--- ORIG/linux/arch/ppc/kernel/ppc4xx_kgdb.c	Mon Dec  3 17:19:45 2001
+++ NEW/linux/arch/ppc/kernel/ppc4xx_kgdb.c	Mon Dec  3 17:20:37 2001
@@ -150,6 +150,5 @@
 void
 kgdb_map_scc(void)
 {
-  ppc4xx_kgdb_init();
   kgdb_debugport = NS16550_init(KGDB_PORT);
 }
diff -ruN ORIG/linux/arch/ppc/kernel/ppc4xx_setup.c NEW/linux/arch/ppc/kernel/ppc4xx_setup.c
--- ORIG/linux/arch/ppc/kernel/ppc4xx_setup.c	Mon Dec  3 17:19:45 2001
+++ NEW/linux/arch/ppc/kernel/ppc4xx_setup.c	Mon Dec  3 17:20:37 2001
@@ -133,10 +133,9 @@
 	board_setup_arch();

 #if defined(CONFIG_BDI_SWITCH)
-	ppc4xx_gdb_init();
+	ppc4xx_bdi_init();
 #endif

-
 }


@@ -242,32 +241,15 @@
 	while(1);
 }

-#if defined CONFIG_BDI_SWITCH
-#define DEBUGGER_FLAGS  DBCR0_EDM | DBCR0_TDE
-#else
-#define DEBUGGER_FLAGS  DBCR0_TDE | DBCR0_IDM
-#endif

 void
-ppc4xx_gdb_init( void )
+ppc4xx_bdi_init( void )
 {
-	mtspr(SPRN_DBCR0, ( DEBUGGER_FLAGS ));
+	mtspr(SPRN_DBCR0, (DBCR0_EDM | DBCR0_TDE));
 	mtspr(SPRN_DBCR1, 0);
-	init_task.thread.regs->dbcr0 = (DEBUGGER_FLAGS);
-	return;
-}
-
-#if defined(CONFIG_KGDB)
-void
-ppc4xx_kgdb_init( void )
-{
-	_nmask_and_or_msr(0, MSR_DE);
-	mtspr(SPRN_DBCR0,
-		(mfspr(SPRN_DBCR0) | DEBUGGER_FLAGS));
-	_nmask_and_or_msr(0, MSR_DE);
+	init_task.thread.regs->dbcr0 = (DBCR0_EDM | DBCR0_TDE);
 	return;
 }
-#endif


 /*
diff -ruN ORIG/linux/arch/ppc/kernel/traps.c NEW/linux/arch/ppc/kernel/traps.c
--- ORIG/linux/arch/ppc/kernel/traps.c	Mon Dec  3 17:19:45 2001
+++ NEW/linux/arch/ppc/kernel/traps.c	Mon Dec  3 17:20:37 2001
@@ -301,6 +301,8 @@
 	int isbpt = esr & ESR_PTR;
 	extern int do_mathemu(struct pt_regs *regs);

+	if (isbpt)
+		mtspr(SPRN_DBSR, DBSR_TIE);
 #ifdef CONFIG_MATH_EMULATION
 	if (!isbpt && do_mathemu(regs) == 0)
 		return;

--------------1966E1A6C5333E9025B5B62D--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
