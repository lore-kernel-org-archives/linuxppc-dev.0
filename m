Subject: PREEMPT on PPC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Cc: "debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Content-Type: text/plain
Message-Id: <1080197240.1210.2.camel@gaston>
Mime-Version: 1.0
Date: Thu, 25 Mar 2004 17:47:20 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi !

I've start looking into the various issues of running
CONFIG_PREEMPT on ppc32. I found some problems, there
may be more, but here's a first patch that should apply on a
recent 2.6.x.

I suggest if you want to try this out that you run with the
various kernel debugging options enabled. Report me remaining
problems.

Ben.

===== arch/ppc/kernel/entry.S 1.44 vs edited =====
--- 1.44/arch/ppc/kernel/entry.S	Mon Feb 16 18:06:27 2004
+++ edited/arch/ppc/kernel/entry.S	Thu Mar 25 14:10:41 2004
@@ -171,9 +171,10 @@
 	bl	do_show_syscall
 #endif /* SHOW_SYSCALLS */
 	rlwinm	r10,r1,0,0,18	/* current_thread_info() */
+	lwz	r11,TI_LOCAL_FLAGS(r10)
+	rlwinm	r11,r11,0,~_TIFL_FORCE_NOERROR
+	stw	r11,TI_LOCAL_FLAGS(r10)
 	lwz	r11,TI_FLAGS(r10)
-	rlwinm	r11,r11,0,~_TIF_FORCE_NOERROR
-	stw	r11,TI_FLAGS(r10)
 	andi.	r11,r11,_TIF_SYSCALL_TRACE
 	bne-	syscall_dotrace
 syscall_dotrace_cont:
@@ -196,8 +197,8 @@
 	cmpl	0,r3,r11
 	rlwinm	r12,r1,0,0,18	/* current_thread_info() */
 	blt+	30f
-	lwz	r11,TI_FLAGS(r12)
-	andi.	r11,r11,_TIF_FORCE_NOERROR
+	lwz	r11,TI_LOCAL_FLAGS(r12)
+	andi.	r11,r11,_TIFL_FORCE_NOERROR
 	bne	30f
 	neg	r3,r3
 	lwz	r10,_CCR(r1)	/* Set SO bit in CR */
===== arch/ppc/kernel/pci.c 1.57 vs edited =====
--- 1.57/arch/ppc/kernel/pci.c	Tue Mar 23 16:42:53 2004
+++ edited/arch/ppc/kernel/pci.c	Thu Mar 25 15:09:51 2004
@@ -1557,6 +1557,7 @@
 	}

 	vma->vm_pgoff = offset >> PAGE_SHIFT;
+
 	return ret;
 }

===== arch/ppc/kernel/process.c 1.57 vs edited =====
--- 1.57/arch/ppc/kernel/process.c	Mon Nov 17 12:29:47 2003
+++ edited/arch/ppc/kernel/process.c	Thu Mar 25 14:35:07 2004
@@ -164,6 +164,7 @@
 void
 enable_kernel_altivec(void)
 {
+	preempt_disable();
 #ifdef CONFIG_SMP
 	if (current->thread.regs && (current->thread.regs->msr & MSR_VEC))
 		giveup_altivec(current);
@@ -172,12 +173,14 @@
 #else
 	giveup_altivec(last_task_used_altivec);
 #endif /* __SMP __ */
+	preempt_enable();
 }
 #endif /* CONFIG_ALTIVEC */

 void
 enable_kernel_fp(void)
 {
+	preempt_disable();
 #ifdef CONFIG_SMP
 	if (current->thread.regs && (current->thread.regs->msr & MSR_FP))
 		giveup_fpu(current);
@@ -186,13 +189,16 @@
 #else
 	giveup_fpu(last_task_used_math);
 #endif /* CONFIG_SMP */
+	preempt_enable();
 }

 int
 dump_fpu(struct pt_regs *regs, elf_fpregset_t *fpregs)
 {
+	preempt_disable();
 	if (regs->msr & MSR_FP)
 		giveup_fpu(current);
+	preempt_enable();
 	memcpy(fpregs, &current->thread.fpr[0], sizeof(*fpregs));
 	return 1;
 }
@@ -330,12 +336,14 @@

 	if (regs == NULL)
 		return;
+	preempt_disable();
 	if (regs->msr & MSR_FP)
 		giveup_fpu(current);
 #ifdef CONFIG_ALTIVEC
 	if (regs->msr & MSR_VEC)
 		giveup_altivec(current);
 #endif /* CONFIG_ALTIVEC */
+	preempt_enable();
 }

 /*
@@ -480,12 +488,14 @@
 	error = PTR_ERR(filename);
 	if (IS_ERR(filename))
 		goto out;
+	preempt_disable();
 	if (regs->msr & MSR_FP)
 		giveup_fpu(current);
 #ifdef CONFIG_ALTIVEC
 	if (regs->msr & MSR_VEC)
 		giveup_altivec(current);
 #endif /* CONFIG_ALTIVEC */
+	preempt_enable();
 	error = do_execve(filename, (char __user *__user *) a1,
 			  (char __user *__user *) a2, regs);
 	if (error == 0)
===== arch/ppc/kernel/traps.c 1.44 vs edited =====
--- 1.44/arch/ppc/kernel/traps.c	Tue Mar 23 12:46:58 2004
+++ edited/arch/ppc/kernel/traps.c	Thu Mar 25 13:21:47 2004
@@ -438,8 +438,14 @@
 		int code = 0;
 		u32 fpscr;

+		/* We must make sure the FP state is consistent with
+		 * our MSR_FP in regs
+		 */
+		preempt_disable();
 		if (regs->msr & MSR_FP)
 			giveup_fpu(current);
+		preempt_enable();
+
 		fpscr = current->thread.fpscr;
 		fpscr &= fpscr << 22;	/* mask summary bits with enables */
 		if (fpscr & FPSCR_VX)
@@ -603,8 +609,11 @@
 void
 AltivecAssistException(struct pt_regs *regs)
 {
+	preempt_disable();
 	if (regs->msr & MSR_VEC)
 		giveup_altivec(current);
+	preempt_enable();
+
 	/* XXX quick hack for now: set the non-Java bit in the VSCR */
 	current->thread.vscr.u[3] |= 0x10000;
 }
===== arch/ppc/syslib/prom_init.c 1.26 vs edited =====
--- 1.26/arch/ppc/syslib/prom_init.c	Sat Feb 14 19:29:14 2004
+++ edited/arch/ppc/syslib/prom_init.c	Wed Mar 24 12:35:20 2004
@@ -44,8 +44,12 @@
  * things like "driver,AAPL,MacOS,PowerPC" properties.  But this value
  * does need to be big enough to ensure that we don't lose things
  * like the interrupt-map property on a PCI-PCI bridge.
+ *
+ * 24/03/2004 - BenH: Bump that limitation to 512k and remove the
+ *                    filter for the MacOS drivers as we may now run
+ *                    those in a shell
  */
-#define MAX_PROPERTY_LENGTH	4096
+#define MAX_PROPERTY_LENGTH	(512 * 1024)

 #ifndef FB_MAX			/* avoid pulling in all of the fb stuff */
 #define FB_MAX	8
===== drivers/macintosh/adbhid.c 1.33 vs edited =====
--- 1.33/drivers/macintosh/adbhid.c	Sat Feb 14 19:29:16 2004
+++ edited/drivers/macintosh/adbhid.c	Thu Mar 25 16:16:56 2004
@@ -107,7 +107,6 @@
 static void adbhid_probe(void);

 static void adbhid_input_keycode(int, int, int, struct pt_regs *);
-static void leds_done(struct adb_request *);

 static void init_trackpad(int id);
 static void init_trackball(int id);
@@ -446,24 +445,54 @@

 static struct adb_request led_request;
 static int leds_pending[16];
+static int leds_req_pending;
 static int pending_devs[16];
 static int pending_led_start=0;
 static int pending_led_end=0;
+static spinlock_t leds_lock  = SPIN_LOCK_UNLOCKED;
+
+static void leds_done(struct adb_request *req)
+{
+	int leds, device;
+	unsigned long flags;
+
+	spin_lock_irqsave(&leds_lock, flags);
+
+	if (pending_led_start != pending_led_end) {
+		device = pending_devs[pending_led_start];
+		leds = leds_pending[device] & 0xff;
+		leds_pending[device] = 0;
+		pending_led_start++;
+		pending_led_start = (pending_led_start < 16) ? pending_led_start : 0;
+	} else
+		leds_req_pending = 0;
+
+	spin_unlock_irqrestore(&leds_lock, flags);
+	if (leds_req_pending)
+		adb_request(&led_request, leds_done, 0, 3,
+			    ADB_WRITEREG(device, KEYB_LEDREG), 0xff, ~leds);
+}

 static void real_leds(unsigned char leds, int device)
 {
-    if (led_request.complete) {
-	adb_request(&led_request, leds_done, 0, 3,
-		    ADB_WRITEREG(device, KEYB_LEDREG), 0xff,
-		    ~leds);
-    } else {
-	if (!(leds_pending[device] & 0x100)) {
-	    pending_devs[pending_led_end] = device;
-	    pending_led_end++;
-	    pending_led_end = (pending_led_end < 16) ? pending_led_end : 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&leds_lock, flags);
+	if (!leds_req_pending) {
+		leds_req_pending = 1;
+		spin_unlock_irqrestore(&leds_lock, flags);
+		adb_request(&led_request, leds_done, 0, 3,
+			    ADB_WRITEREG(device, KEYB_LEDREG), 0xff, ~leds);
+		return;
+	} else {
+		if (!(leds_pending[device] & 0x100)) {
+			pending_devs[pending_led_end] = device;
+			pending_led_end++;
+			pending_led_end = (pending_led_end < 16) ? pending_led_end : 0;
+		}
+		leds_pending[device] = leds | 0x100;
 	}
-	leds_pending[device] = leds | 0x100;
-    }
+	spin_unlock_irqrestore(&leds_lock, flags);
 }

 /*
@@ -487,21 +516,6 @@
 	return -1;
 }

-static void leds_done(struct adb_request *req)
-{
-    int leds,device;
-
-    if (pending_led_start != pending_led_end) {
-	device = pending_devs[pending_led_start];
-	leds = leds_pending[device] & 0xff;
-	leds_pending[device] = 0;
-	pending_led_start++;
-	pending_led_start = (pending_led_start < 16) ? pending_led_start : 0;
-	real_leds(leds,device);
-    }
-
-}
-
 static int
 adb_message_handler(struct notifier_block *this, unsigned long code, void *x)
 {
@@ -518,7 +532,7 @@
 		}

 		/* Stop pending led requests */
-		while(!led_request.complete)
+		while(leds_req_pending)
 			adb_poll();
 		break;

===== drivers/macintosh/via-pmu.c 1.61 vs edited =====
--- 1.61/drivers/macintosh/via-pmu.c	Thu Mar  4 13:04:36 2004
+++ edited/drivers/macintosh/via-pmu.c	Thu Mar 25 16:04:35 2004
@@ -137,7 +137,8 @@
 static int data_len;
 static volatile int adb_int_pending;
 static volatile int disable_poll;
-static struct adb_request bright_req_1, bright_req_2, bright_req_3;
+static struct adb_request bright_req_1, bright_req_2;
+static unsigned long async_req_locks;
 static struct device_node *vias;
 static int pmu_kind = PMU_UNKNOWN;
 static int pmu_fully_inited = 0;
@@ -404,7 +405,6 @@

 	bright_req_1.complete = 1;
 	bright_req_2.complete = 1;
-	bright_req_3.complete = 1;
 #ifdef CONFIG_PMAC_PBOOK
 	batt_req.complete = 1;
 	if (pmac_call_feature(PMAC_FTR_SLEEP_STATE,NULL,0,-1) >= 0)
@@ -710,6 +710,8 @@
 	pmu_batteries[pmu_cur_battery].amperage = amperage;
 	pmu_batteries[pmu_cur_battery].voltage = voltage;
 	pmu_batteries[pmu_cur_battery].time_remaining = time;
+
+	clear_bit(0, &async_req_locks);
 }

 static void __pmac
@@ -785,12 +787,14 @@
 		pmu_batteries[pmu_cur_battery].time_remaining = 0;

 	pmu_cur_battery = (pmu_cur_battery + 1) % pmu_battery_count;
+
+	clear_bit(0, &async_req_locks);
 }

 static void __pmac
 query_battery_state(void)
 {
-	if (!batt_req.complete)
+	if (test_and_set_bit(0, &async_req_locks))
 		return;
 	if (pmu_kind == PMU_OHARE_BASED)
 		pmu_request(&batt_req, done_battery_state_ohare,
@@ -1690,20 +1694,30 @@
 	return 0;
 }

+static void __openfirmware
+pmu_bright_complete(struct adb_request *req)
+{
+	if (req == &bright_req_1)
+		clear_bit(1, &async_req_locks);
+	if (req == &bright_req_2)
+		clear_bit(2, &async_req_locks);
+}
+
 static int __openfirmware
 pmu_set_backlight_level(int level, void* data)
 {
 	if (vias == NULL)
 		return -ENODEV;

-	if (!bright_req_1.complete)
+	if (test_and_set_bit(1, &async_req_locks))
 		return -EAGAIN;
-	pmu_request(&bright_req_1, NULL, 2, PMU_BACKLIGHT_BRIGHT,
+	pmu_request(&bright_req_1, pmu_bright_complete, 2, PMU_BACKLIGHT_BRIGHT,
 		backlight_to_bright[level]);
-	if (!bright_req_2.complete)
+	if (test_and_set_bit(2, &async_req_locks))
 		return -EAGAIN;
-	pmu_request(&bright_req_2, NULL, 2, PMU_POWER_CTRL, PMU_POW_BACKLIGHT
-		| (level > BACKLIGHT_OFF ? PMU_POW_ON : PMU_POW_OFF));
+	pmu_request(&bright_req_2, pmu_bright_complete, 2, PMU_POWER_CTRL,
+		    PMU_POW_BACKLIGHT | (level > BACKLIGHT_OFF ?
+					 PMU_POW_ON : PMU_POW_OFF));

 	return 0;
 }
@@ -2360,7 +2374,7 @@

 	/* Wait for completion of async backlight requests */
 	while (!bright_req_1.complete || !bright_req_2.complete ||
-		!bright_req_3.complete || !batt_req.complete)
+	       !batt_req.complete)
 		pmu_poll();

 	/* Giveup the lazy FPU & vec so we don't have to back them
@@ -2427,9 +2441,12 @@
 	if (!grackle)
 		return -ENODEV;

+	preempt_disable();
+
 	ret = pmac_suspend_devices();
 	if (ret) {
 		printk(KERN_ERR "Sleep rejected by devices\n");
+		preempt_enable();
 		return ret;
 	}

@@ -2497,6 +2514,8 @@

 	pmac_wakeup_devices();

+	preempt_enable();
+
 	return 0;
 }

@@ -2513,9 +2532,12 @@
 		return -ENOSYS;
 	}

+	preempt_disable();
+
 	ret = pmac_suspend_devices();
 	if (ret) {
 		printk(KERN_ERR "Sleep rejected by devices\n");
+		preempt_enable();
 		return ret;
 	}

@@ -2595,6 +2617,8 @@

 	pmac_wakeup_devices();

+	preempt_enable();
+
 	return 0;
 }

@@ -2619,12 +2643,15 @@
 	}
 	mem_ctrl_sleep = (unsigned int *) (mem_ctrl + PB3400_MEM_CTRL_SLEEP);

+	preempt_disable();
+
 	/* Allocate room for PCI save */
 	pbook_alloc_pci_save();

 	ret = pmac_suspend_devices();
 	if (ret) {
 		pbook_free_pci_save();
+		preempt_enable();
 		printk(KERN_ERR "Sleep rejected by devices\n");
 		return ret;
 	}
@@ -2673,9 +2700,10 @@
 		mb();

 	pmac_wakeup_devices();
-
 	pbook_free_pci_save();
+	preempt_enable();
 	iounmap(mem_ctrl);
+
 	return 0;
 }

===== include/asm-ppc/ptrace.h 1.11 vs edited =====
--- 1.11/include/asm-ppc/ptrace.h	Tue Jun 24 14:45:56 2003
+++ edited/include/asm-ppc/ptrace.h	Thu Mar 25 14:02:44 2004
@@ -49,7 +49,10 @@
 #define instruction_pointer(regs) ((regs)->nip)
 #define user_mode(regs) (((regs)->msr & MSR_PR) != 0)

-#define force_successful_syscall_return()   set_thread_flag(TIF_FORCE_NOERROR)
+#define force_successful_syscall_return()   \
+	do { \
+		current_thread_info()->local_flags |= _TIFL_FORCE_NOERROR; \
+	} while(0)

 /*
  * We use the least-significant bit of the trap field to indicate
===== include/asm-ppc/thread_info.h 1.17 vs edited =====
--- 1.17/include/asm-ppc/thread_info.h	Tue Oct 14 17:28:08 2003
+++ edited/include/asm-ppc/thread_info.h	Thu Mar 25 14:03:56 2004
@@ -18,6 +18,7 @@
 	struct task_struct	*task;		/* main task structure */
 	struct exec_domain	*exec_domain;	/* execution domain */
 	unsigned long		flags;		/* low level flags */
+	unsigned long		local_flags;	/* non-racy flags */
 	int			cpu;		/* cpu we're on */
 	int			preempt_count;
 	struct restart_block	restart_block;
@@ -28,6 +29,7 @@
 	.task =		&tsk,			\
 	.exec_domain =	&default_exec_domain,	\
 	.flags =	0,			\
+	.local_flags =  0,			\
 	.cpu =		0,			\
 	.preempt_count = 1,			\
 	.restart_block = {			\
@@ -69,8 +71,9 @@
 #define TI_TASK		0
 #define TI_EXECDOMAIN	4
 #define TI_FLAGS	8
-#define TI_CPU		12
-#define TI_PREEMPT	16
+#define TI_LOCAL_FLAGS	12
+#define TI_CPU		16
+#define TI_PREEMPT	20

 #define PREEMPT_ACTIVE		0x4000000

@@ -83,16 +86,22 @@
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
 #define TIF_POLLING_NRFLAG	4	/* true if poll_idle() is polling
 					   TIF_NEED_RESCHED */
-#define TIF_FORCE_NOERROR	5	/* don't return error from current
-					   syscall even if result < 0 */
-
 /* as above, but as bit values */
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
 #define _TIF_SIGPENDING		(1<<TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1<<TIF_NEED_RESCHED)
 #define _TIF_POLLING_NRFLAG	(1<<TIF_POLLING_NRFLAG)
-#define _TIF_FORCE_NOERROR	(1<<TIF_FORCE_NOERROR)
+
+/*
+ * Non racy (local) flags bit numbers
+ */
+#define TIFL_FORCE_NOERROR	0	/* don't return error from current
+					   syscall even if result < 0 */
+
+/* as above, but as bit values */
+#define _TIFL_FORCE_NOERROR	(1<<TIFL_FORCE_NOERROR)
+

 #endif /* __KERNEL__ */

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
