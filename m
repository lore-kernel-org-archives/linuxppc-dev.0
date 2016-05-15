Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r6qy855V7zDqFL
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 May 2016 14:15:28 +1000 (AEST)
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3r6qy80yHTz9t5w
 for <linuxppc-dev@ozlabs.org>; Sun, 15 May 2016 14:15:28 +1000 (AEST)
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Sun, 15 May 2016 14:15:27 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 62DD02BB0054
 for <linuxppc-dev@ozlabs.org>; Sun, 15 May 2016 14:15:23 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4F4FFeD11075890
 for <linuxppc-dev@ozlabs.org>; Sun, 15 May 2016 14:15:23 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4F4Epsc014839
 for <linuxppc-dev@ozlabs.org>; Sun, 15 May 2016 14:14:51 +1000
Subject: [PATCH v2 2/2] powerpc/book3s: Fix TB corruption in guest exit path
 on HMI interrupt.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: KVM <kvm@vger.kernel.org>, KVM-PPC <kvm-ppc@vger.kernel.org>
Date: Sun, 15 May 2016 09:44:26 +0530
Message-ID: <20160515041426.2280.92697.stgit@mars>
In-Reply-To: <20160515041413.2280.747.stgit@mars>
References: <20160515041413.2280.747.stgit@mars>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

When a guest is assigned to a core it converts the host Timebase (TB)
into guest TB by adding guest timebase offset before entering into
guest. During guest exit it restores the guest TB to host TB. This means
under certain conditions (Guest migration) host TB and guest TB can differ.

When we get an HMI for TB related issues the opal HMI handler would
try fixing errors and restore the correct host TB value. With no guest
running, we don't have any issues. But with guest running on the core
we run into TB corruption issues.

If we get an HMI while in the guest, the current HMI handler invokes opal
hmi handler before forcing guest to exit. The guest exit path subtracts
the guest TB offset from the current TB value which may have already
been restored with host value by opal hmi handler. This leads to incorrect
host and guest TB values.

With split-core, things become more complex. With split-core, TB also gets
split and each subcore gets its own TB register. When a hmi handler fixes
a TB error and restores the TB value, it affects all the TB values of
sibling subcores on the same core. On TB errors all the thread in the core
gets HMI. With existing code, the individual threads call opal hmi handle
independently which can easily throw TB out of sync if we have guest
running on subcores. Hence we will need to co-ordinate with all the
threads before making opal hmi handler call followed by TB resync.

This patch introduces a sibling subcore state structure (shared by all
threads in the core) in paca which holds information about whether sibling
subcores are in Guest mode or host mode. An array in_guest[] of size
MAX_SUBCORE_PER_CORE=4 is used to maintain the state of each subcore.
The subcore id is used as index into in_guest[] array. Only primary
thread entering/exiting the guest is responsible to set/unset its
designated array element.

On TB error, we get HMI interrupt on every thread on the core. Upon HMI,
this patch will now force guest to vacate the core/subcore. Primary
thread from each subcore will then turn off its respective bit
from the above bitmap during the guest exit path just after the
guest->host partition switch is complete.

All other threads that have just exited the guest OR were already in host
will wait until all other subcores clears their respective bit.
Once all the subcores turn off their respective bit, all threads will
will make call to opal hmi handler.

It is not necessary that opal hmi handler would resync the TB value for
every HMI interrupts. It would do so only for the HMI caused due to
TB errors. For rest, it would not touch TB value. Hence to make things
simpler, primary thread would call TB resync explicitly once for each
core immediately after opal hmi handler instead of subtracting guest
offset from TB. TB resync call will restore the TB with host value.
Thus we can be sure about the TB state.

One of the primary threads exiting the guest will take up the
responsibility of calling TB resync. It will use one of the top bits
(bit 63) from subcore state flags bitmap to make the decision. The first
primary thread (among the subcores) that is able to set the bit will
have to call the TB resync. Rest all other threads will wait until TB
resync is complete.  Once TB resync is complete all threads will then
proceed.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/hmi.h          |   45 ++++++++
 arch/powerpc/include/asm/paca.h         |    6 +
 arch/powerpc/kernel/Makefile            |    2 
 arch/powerpc/kernel/exceptions-64s.S    |    4 +
 arch/powerpc/kernel/hmi.c               |   56 ++++++++++
 arch/powerpc/kernel/idle_power7.S       |    5 +
 arch/powerpc/kernel/traps.c             |    5 +
 arch/powerpc/kvm/book3s_hv.c            |   37 +++++++
 arch/powerpc/kvm/book3s_hv_ras.c        |  176 +++++++++++++++++++++++++++++++
 arch/powerpc/kvm/book3s_hv_rmhandlers.S |   65 +++++++++++
 10 files changed, 396 insertions(+), 5 deletions(-)
 create mode 100644 arch/powerpc/include/asm/hmi.h
 create mode 100644 arch/powerpc/kernel/hmi.c

diff --git a/arch/powerpc/include/asm/hmi.h b/arch/powerpc/include/asm/hmi.h
new file mode 100644
index 0000000..88b4901
--- /dev/null
+++ b/arch/powerpc/include/asm/hmi.h
@@ -0,0 +1,45 @@
+/*
+ * Hypervisor Maintenance Interrupt header file.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.
+ *
+ * Copyright 2015 IBM Corporation
+ * Author: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
+ */
+
+#ifndef __ASM_PPC64_HMI_H__
+#define __ASM_PPC64_HMI_H__
+
+#ifdef CONFIG_PPC_BOOK3S_64
+
+#define	CORE_TB_RESYNC_REQ_BIT		63
+#define MAX_SUBCORE_PER_CORE		4
+
+/*
+ * sibling_subcore_state structure is used to co-ordinate all threads
+ * during HMI to avoid TB corruption. This structure is allocated once
+ * per each core and shared by all threads on that core.
+ */
+struct sibling_subcore_state {
+	unsigned long	flags;
+	u8		in_guest[MAX_SUBCORE_PER_CORE];
+};
+
+extern void wait_for_subcore_guest_exit(void);
+extern void wait_for_tb_resync(void);
+#else
+static inline void wait_for_subcore_guest_exit(void) { }
+static inline void wait_for_tb_resync(void) { }
+#endif
+#endif /* __ASM_PPC64_HMI_H__ */
diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index 546540b..4b17bd0 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -25,6 +25,7 @@
 #ifdef CONFIG_KVM_BOOK3S_64_HANDLER
 #include <asm/kvm_book3s_asm.h>
 #endif
+#include <asm/hmi.h>
 
 register struct paca_struct *local_paca asm("r13");
 
@@ -181,6 +182,11 @@ struct paca_struct {
 	 */
 	u16 in_mce;
 	u8 hmi_event_available;		 /* HMI event is available */
+	/*
+	 * Bitmap for sibling subcore status. See kvm/book3s_hv_ras.c for
+	 * more details
+	 */
+	struct sibling_subcore_state *sibling_subcore_state;
 #endif
 
 	/* Stuff for accurate time accounting */
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 2da380f..6972a23 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -41,7 +41,7 @@ obj-$(CONFIG_VDSO32)		+= vdso32/
 obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
 obj-$(CONFIG_PPC_BOOK3S_64)	+= cpu_setup_ppc970.o cpu_setup_pa6t.o
 obj-$(CONFIG_PPC_BOOK3S_64)	+= cpu_setup_power.o
-obj-$(CONFIG_PPC_BOOK3S_64)	+= mce.o mce_power.o
+obj-$(CONFIG_PPC_BOOK3S_64)	+= mce.o mce_power.o hmi.o
 obj64-$(CONFIG_RELOCATABLE)	+= reloc_64.o
 obj-$(CONFIG_PPC_BOOK3E_64)	+= exceptions-64e.o idle_book3e.o
 obj-$(CONFIG_PPC64)		+= vdso64/
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 7716ceb..0607ae9 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -690,6 +690,8 @@ _GLOBAL(__replay_interrupt)
 BEGIN_FTR_SECTION
 	cmpwi	r3,0xe80
 	beq	h_doorbell_common
+	cmpwi	r3,0xe60
+	beq	hmi_exception_common
 FTR_SECTION_ELSE
 	cmpwi	r3,0xa00
 	beq	doorbell_super_common
@@ -1261,7 +1263,7 @@ fwnmi_data_area:
 
 	.globl hmi_exception_early
 hmi_exception_early:
-	EXCEPTION_PROLOG_1(PACA_EXGEN, NOTEST, 0xe60)
+	EXCEPTION_PROLOG_1(PACA_EXGEN, KVMTEST, 0xe62)
 	mr	r10,r1			/* Save r1			*/
 	ld	r1,PACAEMERGSP(r13)	/* Use emergency stack		*/
 	subi	r1,r1,INT_FRAME_SIZE	/* alloc stack frame		*/
diff --git a/arch/powerpc/kernel/hmi.c b/arch/powerpc/kernel/hmi.c
new file mode 100644
index 0000000..e3f738e
--- /dev/null
+++ b/arch/powerpc/kernel/hmi.c
@@ -0,0 +1,56 @@
+/*
+ * Hypervisor Maintenance Interrupt (HMI) handling.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.
+ *
+ * Copyright 2015 IBM Corporation
+ * Author: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
+ */
+
+#undef DEBUG
+
+#include <linux/types.h>
+#include <linux/compiler.h>
+#include <asm/paca.h>
+#include <asm/hmi.h>
+
+void wait_for_subcore_guest_exit(void)
+{
+	int i;
+
+	/*
+	 * NULL bitmap pointer indicates that KVM module hasn't
+	 * been loaded yet and hence no guests are running.
+	 * If no KVM is in use, no need to co-ordinate among threads
+	 * as all of them will always be in host and no one is going
+	 * to modify TB other than the opal hmi handler.
+	 * Hence, just return from here.
+	 */
+	if (!local_paca->sibling_subcore_state)
+		return;
+
+	for (i = 0; i < MAX_SUBCORE_PER_CORE; i++)
+		while (local_paca->sibling_subcore_state->in_guest[i])
+			cpu_relax();
+}
+
+void wait_for_tb_resync(void)
+{
+	if (!local_paca->sibling_subcore_state)
+		return;
+
+	while (test_bit(CORE_TB_RESYNC_REQ_BIT,
+				&local_paca->sibling_subcore_state->flags))
+		cpu_relax();
+}
diff --git a/arch/powerpc/kernel/idle_power7.S b/arch/powerpc/kernel/idle_power7.S
index 470ceeb..bb51129 100644
--- a/arch/powerpc/kernel/idle_power7.S
+++ b/arch/powerpc/kernel/idle_power7.S
@@ -270,8 +270,9 @@ ALT_FTR_SECTION_END_NESTED_IFSET(CPU_FTR_ARCH_207S, 66);		\
 	ld	r2,PACATOC(r13);					\
 	ld	r1,PACAR1(r13);						\
 	std	r3,ORIG_GPR3(r1);	/* Save original r3 */		\
-	li	r0,OPAL_HANDLE_HMI;	/* Pass opal token argument*/	\
-	bl	opal_call_realmode;					\
+	li	r3,0;			/* NULL argument */		\
+	bl	hmi_exception_realmode;					\
+	nop;								\
 	ld	r3,ORIG_GPR3(r1);	/* Restore original r3 */	\
 20:	nop;
 
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 9229ba6..9ec95da 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -60,6 +60,7 @@
 #include <asm/switch_to.h>
 #include <asm/tm.h>
 #include <asm/debug.h>
+#include <asm/hmi.h>
 #include <sysdev/fsl_pci.h>
 
 #if defined(CONFIG_DEBUGGER) || defined(CONFIG_KEXEC)
@@ -307,9 +308,13 @@ long hmi_exception_realmode(struct pt_regs *regs)
 {
 	__this_cpu_inc(irq_stat.hmi_exceptions);
 
+	wait_for_subcore_guest_exit();
+
 	if (ppc_md.hmi_exception_early)
 		ppc_md.hmi_exception_early(regs);
 
+	wait_for_tb_resync();
+
 	return 0;
 }
 
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 84fb4fc..cfb4a42 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -51,6 +51,7 @@
 #include <asm/switch_to.h>
 #include <asm/smp.h>
 #include <asm/dbell.h>
+#include <asm/hmi.h>
 #include <linux/gfp.h>
 #include <linux/vmalloc.h>
 #include <linux/highmem.h>
@@ -3394,6 +3395,38 @@ static struct kvmppc_ops kvm_ops_hv = {
 	.hcall_implemented = kvmppc_hcall_impl_hv,
 };
 
+static int kvm_init_subcore_bitmap(void)
+{
+	int i, j;
+	int nr_cores = cpu_nr_cores();
+	struct sibling_subcore_state *sibling_subcore_state;
+
+	for (i = 0; i < nr_cores; i++) {
+		int first_cpu = i * threads_per_core;
+		int node = cpu_to_node(first_cpu);
+
+		/* Ignore if it is already allocated. */
+		if (paca[first_cpu].sibling_subcore_state)
+			continue;
+
+		sibling_subcore_state =
+			kmalloc_node(sizeof(struct sibling_subcore_state),
+							GFP_KERNEL, node);
+		if (!sibling_subcore_state)
+			return -ENOMEM;
+
+		memset(sibling_subcore_state, 0,
+				sizeof(struct sibling_subcore_state));
+
+		for (j = 0; j < threads_per_core; j++) {
+			int cpu = first_cpu + j;
+
+			paca[cpu].sibling_subcore_state = sibling_subcore_state;
+		}
+	}
+	return 0;
+}
+
 static int kvmppc_book3s_init_hv(void)
 {
 	int r;
@@ -3404,6 +3437,10 @@ static int kvmppc_book3s_init_hv(void)
 	if (r < 0)
 		return -ENODEV;
 
+	r = kvm_init_subcore_bitmap();
+	if (r)
+		return r;
+
 	kvm_ops_hv.owner = THIS_MODULE;
 	kvmppc_hv_ops = &kvm_ops_hv;
 
diff --git a/arch/powerpc/kvm/book3s_hv_ras.c b/arch/powerpc/kvm/book3s_hv_ras.c
index 93b5f5c..0fa70a9 100644
--- a/arch/powerpc/kvm/book3s_hv_ras.c
+++ b/arch/powerpc/kvm/book3s_hv_ras.c
@@ -13,6 +13,9 @@
 #include <linux/kernel.h>
 #include <asm/opal.h>
 #include <asm/mce.h>
+#include <asm/machdep.h>
+#include <asm/cputhreads.h>
+#include <asm/hmi.h>
 
 /* SRR1 bits for machine check on POWER7 */
 #define SRR1_MC_LDSTERR		(1ul << (63-42))
@@ -140,3 +143,176 @@ long kvmppc_realmode_machine_check(struct kvm_vcpu *vcpu)
 {
 	return kvmppc_realmode_mc_power7(vcpu);
 }
+
+/* Check if dynamic split is in force and return subcore size accordingly. */
+static inline int kvmppc_cur_subcore_size(void)
+{
+	if (local_paca->kvm_hstate.kvm_split_mode)
+		return local_paca->kvm_hstate.kvm_split_mode->subcore_size;
+
+	return threads_per_subcore;
+}
+
+void kvmppc_subcore_enter_guest(void)
+{
+	int thread_id, subcore_id;
+
+	thread_id = cpu_thread_in_core(local_paca->paca_index);
+	subcore_id = thread_id / kvmppc_cur_subcore_size();
+
+	local_paca->sibling_subcore_state->in_guest[subcore_id] = 1;
+}
+
+void kvmppc_subcore_exit_guest(void)
+{
+	int thread_id, subcore_id;
+
+	thread_id = cpu_thread_in_core(local_paca->paca_index);
+	subcore_id = thread_id / kvmppc_cur_subcore_size();
+
+	local_paca->sibling_subcore_state->in_guest[subcore_id] = 0;
+}
+
+static bool kvmppc_tb_resync_required(void)
+{
+	if (test_and_set_bit(CORE_TB_RESYNC_REQ_BIT,
+				&local_paca->sibling_subcore_state->flags))
+		return false;
+
+	return true;
+}
+
+static void kvmppc_tb_resync_done(void)
+{
+	clear_bit(CORE_TB_RESYNC_REQ_BIT,
+			&local_paca->sibling_subcore_state->flags);
+}
+
+/*
+ * kvmppc_realmode_hmi_handler() is called only by primary thread during
+ * guest exit path.
+ *
+ * There are multiple reasons why HMI could occur, one of them is
+ * Timebase (TB) error. If this HMI is due to TB error, then TB would
+ * have been in stopped state. The opal hmi handler Will fix it and
+ * restore the TB value with host timebase value. For HMI caused due
+ * to non-TB errors, opal hmi handler will not touch/restore TB register
+ * and hence there won't be any change in TB value.
+ *
+ * Since we are not sure about the cause of this HMI, we can't be sure
+ * about the content of TB register whether it holds guest or host timebase
+ * value. Hence the idea is to resync the TB on every HMI, so that we
+ * know about the exact state of the TB value. Resync TB call will
+ * restore TB to host timebase.
+ *
+ * Things to consider:
+ * - On TB error, HMI interrupt is reported on all the threads of the core
+ *   that has encountered TB error irrespective of split-core mode.
+ * - The very first thread on the core that get chance to fix TB error
+ *   would rsync the TB with local chipTOD value.
+ * - The resync TB is a core level action i.e. it will sync all the TBs
+ *   in that core independent of split-core mode. This means if we trigger
+ *   TB sync from a thread from one subcore, it would affect TB values of
+ *   sibling subcores of the same core.
+ *
+ * All threads need to co-ordinate before making opal hmi handler.
+ * All threads will use sibling_subcore_state->in_guest[] (shared by all
+ * threads in the core) in paca which holds information about whether
+ * sibling subcores are in Guest mode or host mode. The in_guest[] array
+ * is of size MAX_SUBCORE_PER_CORE=4, indexed using subcore id to set/unset
+ * subcore status. Only primary threads from each subcore is responsible
+ * to set/unset its designated array element while entering/exiting the
+ * guset.
+ *
+ * After invoking opal hmi handler call, one of the thread (of entire core)
+ * will need to resync the TB. Bit 63 from subcore state bitmap flags
+ * (sibling_subcore_state->flags) will be used to co-ordinate between
+ * primary threads to decide who takes up the responsibility.
+ *
+ * This is what we do:
+ * - Primary thread from each subcore tries to set resync required bit[63]
+ *   of paca->sibling_subcore_state->flags.
+ * - The first primary thread that is able to set the flag takes the
+ *   responsibility of TB resync. (Let us call it as thread leader)
+ * - All other threads which are in host will call
+ *   wait_for_subcore_guest_exit() and wait for in_guest[0-3] from
+ *   paca->sibling_subcore_state to get cleared.
+ * - All the primary thread will clear its subcore status from subcore
+ *   state in_guest[] array respectively.
+ * - Once all primary threads clear in_guest[0-3], all of them will invoke
+ *   opal hmi handler.
+ * - Now all threads will wait for TB resync to complete by invoking
+ *   wait_for_tb_resync() except the thread leader.
+ * - Thread leader will do a TB resync by invoking opal_resync_timebase()
+ *   call and the it will clear the resync required bit.
+ * - All other threads will now come out of resync wait loop and proceed
+ *   with individual execution.
+ * - On return of this function, primary thread will signal all
+ *   secondary threads to proceed.
+ * - All secondary threads will eventually call opal hmi handler on
+ *   their exit path.
+ */
+
+long kvmppc_realmode_hmi_handler(void)
+{
+	int ptid = local_paca->kvm_hstate.ptid;
+	bool resync_req;
+
+	/* This is only called on primary thread. */
+	BUG_ON(ptid != 0);
+	__this_cpu_inc(irq_stat.hmi_exceptions);
+
+	/*
+	 * By now primary thread has already completed guest->host
+	 * partition switch but haven't signaled secondaries yet.
+	 * All the secondary threads on this subcore is waiting
+	 * for primary thread to signal them to go ahead.
+	 *
+	 * For threads from subcore which isn't in guest, they all will
+	 * wait until all other subcores on this core exit the guest.
+	 *
+	 * Now set the resync required bit. If you are the first to
+	 * set this bit then kvmppc_tb_resync_required() function will
+	 * return true. For rest all other subcores
+	 * kvmppc_tb_resync_required() will return false.
+	 *
+	 * If resync_req == true, then this thread is responsible to
+	 * initiate TB resync after hmi handler has completed.
+	 * All other threads on this core will wait until this thread
+	 * clears the resync required bit flag.
+	 */
+	resync_req = kvmppc_tb_resync_required();
+
+	/* Reset the subcore status to indicate it has exited guest */
+	kvmppc_subcore_exit_guest();
+
+	/*
+	 * Wait for other subcores on this core to exit the guest.
+	 * All the primary threads and threads from subcore that are
+	 * not in guest will wait here until all subcores are out
+	 * of guest context.
+	 */
+	wait_for_subcore_guest_exit();
+
+	/*
+	 * At this point we are sure that primary threads from each
+	 * subcore on this core have completed guest->host partition
+	 * switch. Now it is safe to call HMI handler.
+	 */
+	if (ppc_md.hmi_exception_early)
+		ppc_md.hmi_exception_early(NULL);
+
+	/*
+	 * Check if this thread is responsible to resync TB.
+	 * All other threads will wait until this thread completes the
+	 * TB resync.
+	 */
+	if (resync_req) {
+		opal_resync_timebase();
+		/* Reset TB resync req bit */
+		kvmppc_tb_resync_done();
+	} else {
+		wait_for_tb_resync();
+	}
+	return 0;
+}
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index e571ad2..0d246fc 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -29,6 +29,7 @@
 #include <asm/kvm_book3s_asm.h>
 #include <asm/book3s/64/mmu-hash.h>
 #include <asm/tm.h>
+#include <asm/opal.h>
 
 #define VCPU_GPRS_TM(reg) (((reg) * ULONG_SIZE) + VCPU_GPR_TM)
 
@@ -373,6 +374,18 @@ kvm_secondary_got_guest:
 	lwsync
 	std	r0, HSTATE_KVM_VCORE(r13)
 
+	/*
+	 * All secondaries exiting guest will fall through this path.
+	 * Before proceeding, just check for HMI interrupt and
+	 * invoke opal hmi handler. By now we are sure that the
+	 * primary thread on this core/subcore has already made partition
+	 * switch/TB resync and we are good to call opal hmi handler.
+	 */
+	cmpwi	r12, BOOK3S_INTERRUPT_HMI
+	bne	kvm_no_guest
+
+	li	r3,0			/* NULL argument */
+	bl	hmi_exception_realmode
 /*
  * At this point we have finished executing in the guest.
  * We need to wait for hwthread_req to become zero, since
@@ -428,6 +441,22 @@ kvm_no_guest:
  */
 kvm_unsplit_nap:
 	/*
+	 * When secondaries are napping in kvm_unsplit_nap() with
+	 * hwthread_req = 1, HMI goes ignored even though subcores are
+	 * already exited the guest. Hence HMI keeps waking up secondaries
+	 * from nap in a loop and secondaries always go back to nap since
+	 * no vcore is assigned to them. This makes impossible for primary
+	 * thread to get hold of secondary threads resulting into a soft
+	 * lockup in KVM path.
+	 *
+	 * Let us check if HMI is pending and handle it before we go to nap.
+	 */
+	cmpwi	r12, BOOK3S_INTERRUPT_HMI
+	bne	55f
+	li	r3, 0			/* NULL argument */
+	bl	hmi_exception_realmode
+55:
+	/*
 	 * Ensure that secondary doesn't nap when it has
 	 * its vcore pointer set.
 	 */
@@ -601,6 +630,11 @@ BEGIN_FTR_SECTION
 	mtspr	SPRN_DPDES, r8
 END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 
+	/* Mark the subcore state as inside guest */
+	bl	kvmppc_subcore_enter_guest
+	nop
+	ld	r5, HSTATE_KVM_VCORE(r13)
+	ld	r4, HSTATE_KVM_VCPU(r13)
 	li	r0,1
 	stb	r0,VCORE_IN_GUEST(r5)	/* signal secondaries to continue */
 
@@ -1683,6 +1717,23 @@ BEGIN_FTR_SECTION
 	mtspr	SPRN_DPDES, r8
 END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 
+	/* If HMI, call kvmppc_realmode_hmi_handler() */
+	cmpwi	r12, BOOK3S_INTERRUPT_HMI
+	bne	27f
+	bl	kvmppc_realmode_hmi_handler
+	nop
+	li	r12, BOOK3S_INTERRUPT_HMI
+	/*
+	 * At this point kvmppc_realmode_hmi_handler would have resync-ed
+	 * the TB. Hence it is not required to subtract guest timebase
+	 * offset from timebase. So, skip it.
+	 *
+	 * Also, do not call kvmppc_subcore_exit_guest() because it has
+	 * been invoked as part of kvmppc_realmode_hmi_handler().
+	 */
+	b	30f
+
+27:
 	/* Subtract timebase offset from timebase */
 	ld	r8,VCORE_TB_OFFSET(r5)
 	cmpdi	r8,0
@@ -1698,8 +1749,13 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 	addis	r8,r8,0x100		/* if so, increment upper 40 bits */
 	mtspr	SPRN_TBU40,r8
 
+17:	bl	kvmppc_subcore_exit_guest
+	nop
+30:	ld	r5,HSTATE_KVM_VCORE(r13)
+	ld	r4,VCORE_KVM(r5)	/* pointer to struct kvm */
+
 	/* Reset PCR */
-17:	ld	r0, VCORE_PCR(r5)
+	ld	r0, VCORE_PCR(r5)
 	cmpdi	r0, 0
 	beq	18f
 	li	r0, 0
@@ -2461,6 +2517,8 @@ BEGIN_FTR_SECTION
 	cmpwi	r6, 3			/* hypervisor doorbell? */
 	beq	3f
 END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
+	cmpwi	r6, 0xa			/* Hypervisor maintenance ? */
+	beq	4f
 	li	r3, 1			/* anything else, return 1 */
 0:	blr
 
@@ -2482,6 +2540,11 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 	li	r3, -1
 	blr
 
+	/* Woken up due to Hypervisor maintenance interrupt */
+4:	li	r12, BOOK3S_INTERRUPT_HMI
+	li	r3, 1
+	blr
+
 /*
  * Determine what sort of external interrupt is pending (if any).
  * Returns:
