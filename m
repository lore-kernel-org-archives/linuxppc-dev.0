Message-ID: <3A5FE581.2B696E44@rochcivictheatre.org>
Date: Fri, 12 Jan 2001 23:20:01 -0600
From: Tom Gall <tgall@rochcivictheatre.org>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: OpenPic etc changes for SMP Power3
Content-Type: multipart/mixed;
 boundary="------------2BCB27D155D8C8DEF1C9DC2D"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------2BCB27D155D8C8DEF1C9DC2D
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi All,

  Enclosed is a candidate patch for the current 2.4 tree. The set of
changes include:

1) The removal of openpic_setup_ISU (code moved to rewritten find_ISUs)
2) addition of a few IPI specific functions in open_pic.c
    The reason is mostly centered on POWER3 has a *cough* feature that
you write be but read le when it comes to IPIs.
3) openpic_mapirq only should allow IRQs to go to processor one. The
software interrupt handler is not SMP safe.
4) openpic_enable_irq and openpic_disable_irq should no longer allow the

enablement or disablement of a timer or IPI irq
5) fixed a couple of bugs in smp.c when openpic_cause_IPI was called
with the param computed incorrectly

Additionally some changes (that I will push) for arch/ppc/mm/init.c
are included.
These used to be in the sources and I believe were lost as a result of
the recent difficulties with bk. Regardless they are included.

 Please try and send comments back to tgall@rochcivictheatre.org /
tom_gall@vnet.ibm.com

  I am especially concerned that I don't break anybody else by these
changes or regress current function in 2.4.

  While I have tried to test as much as possible, I ran out of time
today and didn't get a chance to test boot on a b50 (604 chrp) and a F50

(4 way 604 chrp) but I did try this kernel out on a 170 (uni Power3) and

270 ( 2 way Power3) with success.

  Thanks!

--
Hakuna Matata,

Tom

-----------------------------------------------------------
PPC Linux Guy      "My heart is human, my blood is boiling,
                    my brain IBM" -- Mr Roboto, Styxx
tgall@rochcivictheatre.org



--------------2BCB27D155D8C8DEF1C9DC2D
Content-Type: text/plain; charset=us-ascii;
 name="2.4.1-smp-power3-patch"
Content-Disposition: inline;
 filename="2.4.1-smp-power3-patch"
Content-Transfer-Encoding: 7bit

diff -ur linuxppc_2_4/arch/ppc/kernel/chrp_pci.c linuxppc_2_4.works/arch/ppc/kernel/chrp_pci.c
--- linuxppc_2_4/arch/ppc/kernel/chrp_pci.c	Thu Jan 11 17:22:14 2001
+++ linuxppc_2_4.works/arch/ppc/kernel/chrp_pci.c	Fri Jan 12 16:13:55 2001
@@ -403,10 +403,6 @@

 		process_bridge_ranges(hose, dev, index);

-#ifdef CONFIG_POWER3
-                openpic_setup_ISU(index, opprop[index+1]);
-#endif /* CONFIG_POWER3 */
-
 		/* check the first bridge for a property that we can
 		   use to set pci_dram_offset */
 		dma = (unsigned int *)
diff -ur linuxppc_2_4/arch/ppc/kernel/irq.c linuxppc_2_4.works/arch/ppc/kernel/irq.c
--- linuxppc_2_4/arch/ppc/kernel/irq.c	Thu Jan 11 17:22:24 2001
+++ linuxppc_2_4.works/arch/ppc/kernel/irq.c	Fri Jan 12 16:12:06 2001
@@ -172,6 +172,7 @@
 	}
 	spin_unlock_irqrestore(&desc->lock,flags);

+
 	register_irq_proc(irq);
 	return 0;
 }
diff -ur linuxppc_2_4/arch/ppc/kernel/open_pic.c linuxppc_2_4.works/arch/ppc/kernel/open_pic.c
--- linuxppc_2_4/arch/ppc/kernel/open_pic.c	Thu Jan 11 17:22:26 2001
+++ linuxppc_2_4.works/arch/ppc/kernel/open_pic.c	Fri Jan 12 16:16:09 2001
@@ -136,6 +136,19 @@
 	return val;
 }

+/* yes this is right ... bug, feature, you decide! -- tgall */
+u_int openpic_read_IPI(volatile u_int* addr)
+{
+         u_int val = 0;
+#ifdef CONFIG_POWER3
+        val = in_be32(addr);
+#else
+        val = in_le32(addr);
+#endif
+        return val;
+}
+
+
 static inline void openpic_write(volatile u_int *addr, u_int val)
 {
 	out_le32(addr, val);
@@ -154,16 +167,33 @@
 	openpic_write(addr, (val & ~mask) | (field & mask));
 }

+/* because of the power3 be / le above, this is needed */
+inline void openpic_writefield_IPI(volatile u_int* addr, u_int mask, u_int field)
+{
+        u_int  val = openpic_read_IPI(addr);
+        openpic_write(addr, (val & ~mask) | (field & mask));
+}
+
 static inline void openpic_clearfield(volatile u_int *addr, u_int mask)
 {
 	openpic_writefield(addr, mask, 0);
 }

+static inline void openpic_clearfield_IPI(volatile u_int *addr, u_int mask)
+{
+        openpic_writefield_IPI(addr, mask, 0);
+}
+
 static inline void openpic_setfield(volatile u_int *addr, u_int mask)
 {
 	openpic_writefield(addr, mask, mask);
 }

+static inline void openpic_setfield_IPI(volatile u_int *addr, u_int mask)
+{
+        openpic_writefield_IPI(addr, mask, mask);
+}
+
 static void openpic_safe_writefield(volatile u_int *addr, u_int mask,
 				    u_int field)
 {
@@ -172,6 +202,19 @@
 	openpic_writefield(addr, mask | OPENPIC_MASK, field | OPENPIC_MASK);
 }

+static void openpic_safe_writefield_IPI(volatile u_int *addr, u_int mask, u_int field)
+{
+        openpic_setfield_IPI(addr, OPENPIC_MASK);
+
+        /* wait until it's not in use */
+        /* BenH: Is this code really enough ? I would rather check the result
+         *       and eventually retry ...
+         */
+        while(openpic_read_IPI(addr) & OPENPIC_ACTIVITY);
+
+        openpic_writefield_IPI(addr, mask | OPENPIC_MASK, field | OPENPIC_MASK);
+}
+
 void __init openpic_init(int main_pic, int offset, unsigned char* chrp_ack,
 			 int programmer_switch_irq)
 {
@@ -291,37 +334,47 @@
 	if (ppc_md.progress) ppc_md.progress("openpic exit",0x222);
 }

-#ifdef CONFIG_POWER3
-void openpic_setup_ISU(int isu_num, unsigned long addr)
-{
-	if (isu_num >= OPENPIC_MAX_ISU)
-		return;
-	ISU[isu_num] = (OpenPIC_SourcePtr) ioremap(addr, 0x400);
-	if (isu_num >= NumISUs)
-		NumISUs = isu_num + 1;
-}
-#endif
-
 void find_ISUs(void)
 {
-#ifdef CONFIG_POWER3
-        /* Use /interrupt-controller/reg and
-         * /interrupt-controller/interrupt-ranges from OF device tree
-	 * the ISU array is setup in chrp_pci.c in ibm_add_bridges
-	 * as a result
-	 * -- tgall
+        unsigned long *opprop;
+        int len, i;
+
+        opprop = (unsigned long *)get_property(find_path_device("/"),
+                 "platform-open-pic", &len);
+
+        if (!opprop) {
+                 printk("find_ISUs(): could not read platform-open-pic");
+                return;
+        }
+
+        if (!opprop[1]) {
+                /*
+                 * for non-distributed OpenPIC
+                 * implementations it's in the IDU -- Cort
+                 */
+                ISU[0] = (OpenPIC_Source *)OpenPIC->Source;
+                return;
+        }
+        NumSources = 0;
+        len /= sizeof(unsigned int);
+
+        /* basically each ISU is a bus, and this assumes that
+         * open_pic_isu_count interrupts per bus are possible
+         * ISU == Interrupt Source Unit
          */

-	/* basically each ISU is a bus, and this assumes that
-	 * open_pic_isu_count interrupts per bus are possible
-	 * ISU == Interrupt Source
-	 */
-	NumSources = NumISUs * 0x10;
+        /* I hope there is no case where the first OpenPIC address does
+         * not correspond to the first Bus.  - tibit
+         */

-#else
-	/* for non-distributed OpenPIC implementations it's in the IDU -- Cort */
-	ISU[0] = (OpenPIC_Source *)OpenPIC->Source;
-#endif
+        for (i = 0; i < len-1; i++) {
+                ISU[i] = (OpenPIC_Source *) ioremap (opprop[i+1], 0x20);
+                printk("Setting up ISU(%d) at 0x%lx, remapped to 0x%p\n",
+                        i, opprop[i+1], ISU[i]);
+                NumSources += 0x10;
+        }
+	NumISUs=(NumSources / 0x10) + 1;
+printk("This OpenPIC can handle %d Interrupt Sources\n", NumSources);
 }

 static void openpic_reset(void)
@@ -438,7 +491,7 @@
 	check_arg_ipi(ipi);
 	check_arg_pri(pri);
 	check_arg_vec(vec);
-	openpic_safe_writefield(&OpenPIC->Global.IPI_Vector_Priority(ipi),
+	openpic_safe_writefield_IPI(&OpenPIC->Global.IPI_Vector_Priority(ipi),
 				OPENPIC_PRIORITY_MASK | OPENPIC_VECTOR_MASK,
 				(pri << OPENPIC_PRIORITY_SHIFT) | vec);
 }
@@ -502,9 +555,10 @@
  	/* let the openpic know we want intrs. default affinity
  	 * is 0xffffffff until changed via /proc
  	 */
+#if 0
  	for (i = 0; i < NumSources ; i++)
 		openpic_mapirq(i, openpic_read(&GET_ISU(i).Destination) | msk);
-
+#endif
  	openpic_set_priority(0);

 	spin_unlock(&openpic_setup_lock);
@@ -554,6 +608,21 @@
 static void openpic_enable_irq(u_int irq)
 {
 	check_arg_irq(irq);
+
+        /*
+         * Never want to disable a timer or ipi irq
+         * (only want to disable irqs within an ISU).
+         */
+        if (((irq >= OPENPIC_VEC_IPI+open_pic_irq_offset)   &&
+           (irq <  OPENPIC_VEC_IPI+open_pic_irq_offset+OPENPIC_NUM_IPI)) ||
+           ((irq >= OPENPIC_VEC_TIMER+open_pic_irq_offset) &&
+            (irq <  OPENPIC_VEC_TIMER+open_pic_irq_offset+OPENPIC_NUM_TIMERS)))
+        {
+        /* silently ignore the enable of the timer or ipi irq. */
+        return;
+        }
+
+
 	openpic_clearfield(&GET_ISU(irq - open_pic_irq_offset).Vector_Priority, OPENPIC_MASK);
 	/* make sure mask gets to controller before we return to user */
 	do {
@@ -567,6 +636,19 @@
 	u32 vp;

 	check_arg_irq(irq);
+        /*
+         * Never want to disable a timer or ipi irq
+         * (only want to disable irqs within an ISU).
+         */
+        if (((irq >= OPENPIC_VEC_IPI+open_pic_irq_offset)   &&
+             (irq <  OPENPIC_VEC_IPI+open_pic_irq_offset+OPENPIC_NUM_IPI)) ||
+             ((irq >= OPENPIC_VEC_TIMER+open_pic_irq_offset) &&
+             (irq <  OPENPIC_VEC_TIMER+open_pic_irq_offset+OPENPIC_NUM_TIMERS)))
+        {
+                panic("openpic_disable_irq - disabling non-ISU irq");
+        }
+
+
 	openpic_setfield(&GET_ISU(irq - open_pic_irq_offset).Vector_Priority, OPENPIC_MASK);
 	/* make sure mask gets to controller before we return to user */
 	do {
@@ -586,27 +668,14 @@
 {
 	irq -= (OPENPIC_VEC_IPI+open_pic_irq_offset);
 	check_arg_ipi(irq);
-	openpic_clearfield(&OpenPIC->Global.IPI_Vector_Priority(irq), OPENPIC_MASK);
-	/* make sure mask gets to controller before we return to user */
-	do {
-		mb(); /* sync is probably useless here */
-	} while(openpic_readfield(&OpenPIC->Global.IPI_Vector_Priority(irq),
-				  OPENPIC_MASK));
+	openpic_clearfield_IPI(&OpenPIC->Global.IPI_Vector_Priority(irq), OPENPIC_MASK);
+
 }
 void openpic_disable_ipi(u_int irq)
 {
-	u32 vp;
-
-	irq -= (OPENPIC_VEC_IPI+open_pic_irq_offset);
-	check_arg_ipi(irq);
-	openpic_setfield(&OpenPIC->Global.IPI_Vector_Priority(irq), OPENPIC_MASK);
-	/* make sure mask gets to controller before we return to user */
-	do {
-		mb();  /* sync is probably useless here */
-		vp = openpic_readfield(&OpenPIC->Global.IPI_Vector_Priority(irq),
-    			OPENPIC_MASK | OPENPIC_ACTIVITY);
-	} while((vp & OPENPIC_ACTIVITY) && !(vp & OPENPIC_MASK));
+   /* NEVER disable an IPI... that's just plain wrong! */
 }
+
 #endif

 /*
diff -ur linuxppc_2_4/arch/ppc/kernel/smp.c linuxppc_2_4.works/arch/ppc/kernel/smp.c
--- linuxppc_2_4/arch/ppc/kernel/smp.c	Thu Jan 11 17:22:17 2001
+++ linuxppc_2_4.works/arch/ppc/kernel/smp.c	Fri Jan 12 16:17:55 2001
@@ -424,10 +424,11 @@
 		break;
 	case MSG_ALL_BUT_SELF:
 		openpic_cause_IPI(msg,
-				  0xffffffff & ~(1 << smp_processor_id()));
+       			0xffffffff & ~(1 << smp_hw_index[smp_processor_id()]));
+
 		break;
 	default:
-		openpic_cause_IPI(msg, 1<<target);
+		openpic_cause_IPI(msg, smp_hw_index[1<<target]);
 		break;
 	}
 }
diff -ur linuxppc_2_4/arch/ppc/mm/init.c linuxppc_2_4.works/arch/ppc/mm/init.c
--- linuxppc_2_4/arch/ppc/mm/init.c	Thu Jan 11 17:22:15 2001
+++ linuxppc_2_4.works/arch/ppc/mm/init.c	Fri Jan 12 16:02:04 2001
@@ -74,6 +74,7 @@

 int prom_trashed;
 atomic_t next_mmu_context;
+rwlock_t context_overflow_lock __cacheline_aligned = RW_LOCK_UNLOCKED;
 unsigned long *end_of_DRAM;
 unsigned long total_memory;
 unsigned long total_lowmem;
@@ -633,24 +634,32 @@
 	struct task_struct *tsk;

 	printk(KERN_DEBUG "mmu_context_overflow\n");
-	read_lock(&tasklist_lock);
- 	for_each_task(tsk) {
-		if (tsk->mm)
-			tsk->mm->context = NO_CONTEXT;
-	}
-	read_unlock(&tasklist_lock);
-	flush_hash_segments(0x10, 0xffffff);
+	/* acquire the write lock for context overflow */
+	write_lock (&context_overflow_lock);
+	/* recheck if overflow still exists */
+	if (atomic_read(&next_mmu_context) == LAST_CONTEXT) {
+		read_lock(&tasklist_lock);
+		for_each_task(tsk) {
+			if (tsk->mm)
+				tsk->mm->context = NO_CONTEXT;
+
+		}
+		read_unlock(&tasklist_lock);
+		flush_hash_segments(0x10, 0xffffff);
 #ifdef CONFIG_SMP
-	smp_send_tlb_invalidate(0);
+		smp_send_tlb_invalidate(0);
 #endif
-	atomic_set(&next_mmu_context, 0);
-	/* make sure current always has a context */
-	current->mm->context = MUNGE_CONTEXT(atomic_inc_return(&next_mmu_context));
-	/* The PGD is only a placeholder.  It is only used on
-	 * 8xx processors.
-	 */
-	set_context(current->mm->context, current->mm->pgd);
-}
+		atomic_set(&next_mmu_context, 0);
+	}
+	write_unlock (&context_overflow_lock);
+	/* make sure current always has a context */
+	/* need to check to assure current task has an mm */
+	/*   - idle thread does not have an MM */
+	if (current->mm) {
+		current->mm->context = MUNGE_CONTEXT(atomic_inc_return(&next_mmu_context));
+		set_context(current->mm->context, current->mm->pgd);
+	}
+}
 #else /* CONFIG_8xx */
 void
 mmu_context_overflow(void)
@@ -1058,8 +1067,10 @@
 		 * down and slap your hands.  If it causes problems please email me.
 		 *  -- Cort <cort@fsmlabs.com>
 		 */
+#ifndef CONFIG_POWER3
 		setbat(0, 0x80000000, 0x80000000, 0x10000000, IO_PAGE);
 		setbat(1, 0x90000000, 0x90000000, 0x10000000, IO_PAGE);
+#endif
 		break;
 	case _MACH_Pmac:
 		ioremap_base = 0xfe000000;

--------------2BCB27D155D8C8DEF1C9DC2D--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
