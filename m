Return-Path: <paulus@bilbo.ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 10300B70AA
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 27 Jun 2009 15:31:39 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E2B99DDD04
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Jun 2009 15:31:38 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <19013.44722.893263.275594@cargo.ozlabs.ibm.com>
Date: Sat, 27 Jun 2009 15:31:30 +1000
From: Paul Mackerras <paulus@samba.org>
To: Ingo Molnar <mingo@elte.hu>, benh@kernel.crashing.org
Subject: [PATCH 2/2] perf_counter: powerpc: Add callchain support
In-Reply-To: <19013.44646.549261.100582@cargo.ozlabs.ibm.com>
References: <19013.44646.549261.100582@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Peter Zijlstra <a.p.zijlstra@chello.nl>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds support for tracing callchains for powerpc, both 32-bit
and 64-bit, and both in the kernel and userspace, from PMU interrupt
context.

The first three entries stored for each callchain are the NIP (next
instruction pointer), LR (link register), and the contents of the LR
save area in the second stack frame (the first is ignored because the
ABI convention on powerpc is that functions save their return address
in their caller's stack frame).  Because functions don't have to save
their return address (LR value) and don't have to establish a stack
frame, it's possible for either or both of LR and the second stack
frame's LR save area to have valid return addresses in them.  This
is basically impossible to disambiguate without either reading the
code or looking at auxiliary information such as CFI tables.  Since
we don't want to do that at interrupt time, we store both LR and the
second stack frame's LR save area.

Once we get past the second stack frame, there is no ambiguity; all
return addresses we get are reliable.

For kernel traces, we check whether they are valid kernel instruction
addresses and store zero instead if they are not (rather than
omitting them, which would make it impossible for userspace to know
which was which).  We also store zero instead of the second stack
frame's LR save area value if it is the same as LR.

For kernel traces, we check for interrupt frames, and for user traces,
we check for signal frames.  In each case, since we're starting a new
trace, we store a PERF_CONTEXT_KERNEL/USER marker so that userspace
knows that the next three entries are NIP, LR and the second stack fram=
e
for the interrupted context.

We read user memory with __get_user_inatomic.  On 64-bit, we set a flag=

to indicate that the data storage exception handler shouldn't call
hash_page on a MMU hashtable miss.  Instead we get a -EFAULT from
__get_user_inatomic and then read the Linux PTE and access the page
via the kernel linear mapping.  Since 64-bit doesn't use (or need)
highmem there is no need to do kmap_atomic.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/kernel/Makefile         |    2 +-
 arch/powerpc/kernel/perf_callchain.c |  544 ++++++++++++++++++++++++++=
++++++++
 2 files changed, 545 insertions(+), 1 deletions(-)
 create mode 100644 arch/powerpc/kernel/perf_callchain.c

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefil=
e
index b73396b..9619285 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -97,7 +97,7 @@ obj64-$(CONFIG_AUDIT)=09=09+=3D compat_audit.o
=20
 obj-$(CONFIG_DYNAMIC_FTRACE)=09+=3D ftrace.o
 obj-$(CONFIG_FUNCTION_GRAPH_TRACER)=09+=3D ftrace.o
-obj-$(CONFIG_PPC_PERF_CTRS)=09+=3D perf_counter.o
+obj-$(CONFIG_PPC_PERF_CTRS)=09+=3D perf_counter.o perf_callchain.o
 obj64-$(CONFIG_PPC_PERF_CTRS)=09+=3D power4-pmu.o ppc970-pmu.o power5-=
pmu.o \
 =09=09=09=09   power5+-pmu.o power6-pmu.o power7-pmu.o
 obj32-$(CONFIG_PPC_PERF_CTRS)=09+=3D mpc7450-pmu.o
diff --git a/arch/powerpc/kernel/perf_callchain.c b/arch/powerpc/kernel=
/perf_callchain.c
new file mode 100644
index 0000000..3cc1487
--- /dev/null
+++ b/arch/powerpc/kernel/perf_callchain.c
@@ -0,0 +1,544 @@
+/*
+ * Performance counter callchain support - powerpc architecture code
+ *
+ * Copyright =A9 2009 Paul Mackerras, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/perf_counter.h>
+#include <linux/percpu.h>
+#include <linux/uaccess.h>
+#include <linux/mm.h>
+#include <asm/ptrace.h>
+#include <asm/pgtable.h>
+#include <asm/sigcontext.h>
+#include <asm/ucontext.h>
+#include <asm/vdso.h>
+#ifdef CONFIG_PPC64
+#include "ppc32.h"
+#endif
+
+/*
+ * Store another value in a callchain_entry.
+ */
+static inline void callchain_store(struct perf_callchain_entry *entry,=
 u64 ip)
+{
+=09unsigned int nr =3D entry->nr;
+
+=09if (nr < PERF_MAX_STACK_DEPTH) {
+=09=09entry->ip[nr] =3D ip;
+=09=09entry->nr =3D nr + 1;
+=09}
+}
+
+/*
+ * Is sp valid as the address of the next kernel stack frame after pre=
v_sp?
+ * The next frame may be in a different stack area but should not go
+ * back down in the same stack area.
+ */
+static int valid_next_sp(unsigned long sp, unsigned long prev_sp)
+{
+=09if (sp & 0xf)
+=09=09return 0;=09=09/* must be 16-byte aligned */
+=09if (!validate_sp(sp, current, STACK_FRAME_OVERHEAD))
+=09=09return 0;
+=09if (sp >=3D prev_sp + STACK_FRAME_OVERHEAD)
+=09=09return 1;
+=09/*
+=09 * sp could decrease when we jump off an interrupt stack
+=09 * back to the regular process stack.
+=09 */
+=09if ((sp & ~(THREAD_SIZE - 1)) !=3D (prev_sp & ~(THREAD_SIZE - 1)))
+=09=09return 1;
+=09return 0;
+}
+
+static void perf_callchain_kernel(struct pt_regs *regs,
+=09=09=09=09  struct perf_callchain_entry *entry)
+{
+=09unsigned long sp, next_sp;
+=09unsigned long next_ip;
+=09unsigned long lr;
+=09long level =3D 0;
+=09unsigned long *fp;
+
+=09lr =3D regs->link;
+=09sp =3D regs->gpr[1];
+=09callchain_store(entry, PERF_CONTEXT_KERNEL);
+=09callchain_store(entry, regs->nip);
+
+=09if (!validate_sp(sp, current, STACK_FRAME_OVERHEAD))
+=09=09return;
+
+=09for (;;) {
+=09=09fp =3D (unsigned long *) sp;
+=09=09next_sp =3D fp[0];
+
+=09=09if (next_sp =3D=3D sp + STACK_INT_FRAME_SIZE &&
+=09=09    fp[STACK_FRAME_MARKER] =3D=3D STACK_FRAME_REGS_MARKER) {
+=09=09=09/*
+=09=09=09 * This looks like an interrupt frame for an
+=09=09=09 * interrupt that occurred in the kernel
+=09=09=09 */
+=09=09=09regs =3D (struct pt_regs *)(sp + STACK_FRAME_OVERHEAD);
+=09=09=09next_ip =3D regs->nip;
+=09=09=09lr =3D regs->link;
+=09=09=09level =3D 0;
+=09=09=09callchain_store(entry, PERF_CONTEXT_KERNEL);
+
+=09=09} else {
+=09=09=09if (level =3D=3D 0)
+=09=09=09=09next_ip =3D lr;
+=09=09=09else
+=09=09=09=09next_ip =3D fp[STACK_FRAME_LR_SAVE];
+
+=09=09=09/*
+=09=09=09 * We can't tell which of the first two addresses
+=09=09=09 * we get are valid, but we can filter out the
+=09=09=09 * obviously bogus ones here.  We replace them
+=09=09=09 * with 0 rather than removing them entirely so
+=09=09=09 * that userspace can tell which is which.
+=09=09=09 */
+=09=09=09if ((level =3D=3D 1 && next_ip =3D=3D lr) ||
+=09=09=09    (level <=3D 1 && !kernel_text_address(next_ip)))
+=09=09=09=09next_ip =3D 0;
+
+=09=09=09++level;
+=09=09}
+
+=09=09callchain_store(entry, next_ip);
+=09=09if (!valid_next_sp(next_sp, sp))
+=09=09=09return;
+=09=09sp =3D next_sp;
+=09}
+}
+
+#ifdef CONFIG_PPC64
+/*
+ * On 64-bit we don't want to invoke hash_page on user addresses from
+ * interrupt context, so if the access faults, we read the page tables=

+ * to find which page (if any) is mapped and access it directly.
+ */
+static int read_user_stack_slow(void __user *ptr, void *ret, int nb)
+{
+=09pgd_t *pgdir;
+=09pte_t *ptep, pte;
+=09int pagesize;
+=09unsigned long addr =3D (unsigned long) ptr;
+=09unsigned long offset;
+=09unsigned long pfn;
+=09void *kaddr;
+
+=09pgdir =3D current->mm->pgd;
+=09if (!pgdir)
+=09=09return -EFAULT;
+
+=09pagesize =3D get_slice_psize(current->mm, addr);
+
+=09/* align address to page boundary */
+=09offset =3D addr & ((1ul << mmu_psize_defs[pagesize].shift) - 1);
+=09addr -=3D offset;
+
+=09if (HPAGE_SHIFT && mmu_huge_psizes[pagesize])
+=09=09ptep =3D huge_pte_offset(current->mm, addr);
+=09else
+=09=09ptep =3D find_linux_pte(pgdir, addr);
+
+=09if (ptep =3D=3D NULL)
+=09=09return -EFAULT;
+=09pte =3D *ptep;
+=09if (!pte_present(pte) || !(pte_val(pte) & _PAGE_USER))
+=09=09return -EFAULT;
+=09pfn =3D pte_pfn(pte);
+=09if (!page_is_ram(pfn))
+=09=09return -EFAULT;
+
+=09/* no highmem to worry about here */
+=09kaddr =3D pfn_to_kaddr(pfn);
+=09memcpy(ret, kaddr + offset, nb);
+=09return 0;
+}
+
+static int read_user_stack_64(unsigned long __user *ptr, unsigned long=
 *ret)
+{
+=09int err;
+
+=09if ((unsigned long)ptr > TASK_SIZE - sizeof(unsigned long) ||
+=09    ((unsigned long)ptr & 7))
+=09=09return -EFAULT;
+
+=09/*
+=09 * On 64-bit, tell the DSI handler not to call hash_page
+=09 * if this access causes a hashtable miss fault.
+=09 */
+=09get_paca()->in_pmu_nmi =3D 1;
+=09barrier();
+=09err =3D __get_user_inatomic(*ret, ptr);
+=09barrier();
+=09get_paca()->in_pmu_nmi =3D 0;
+
+=09if (!err)
+=09=09return 0;
+
+=09return read_user_stack_slow(ptr, ret, 8);
+}
+
+static int read_user_stack_32(unsigned int __user *ptr, unsigned int *=
ret)
+{
+=09int err;
+
+=09if ((unsigned long)ptr > TASK_SIZE - sizeof(unsigned int) ||
+=09    ((unsigned long)ptr & 3))
+=09=09return -EFAULT;
+
+=09/*
+=09 * On 64-bit, tell the DSI handler not to call hash_page
+=09 * if this access causes a hashtable miss fault.
+=09 */
+=09get_paca()->in_pmu_nmi =3D 1;
+=09barrier();
+=09err =3D __get_user_inatomic(*ret, ptr);
+=09barrier();
+=09get_paca()->in_pmu_nmi =3D 0;
+
+=09if (!err)
+=09=09return 0;
+
+=09return read_user_stack_slow(ptr, ret, 4);
+}
+
+static inline int valid_user_sp(unsigned long sp, int is_64)
+{
+=09if (!sp || (sp & 7) || sp > (is_64 ? TASK_SIZE : 0x100000000UL) - 3=
2)
+=09=09return 0;
+=09return 1;
+}
+
+/*
+ * 64-bit user processes use the same stack frame for RT and non-RT si=
gnals.
+ */
+struct signal_frame_64 {
+=09char=09=09dummy[__SIGNAL_FRAMESIZE];
+=09struct ucontext=09uc;
+=09unsigned long=09unused[2];
+=09unsigned int=09tramp[6];
+=09struct siginfo=09*pinfo;
+=09void=09=09*puc;
+=09struct siginfo=09info;
+=09char=09=09abigap[288];
+};
+
+static int is_sigreturn_64_address(unsigned long nip, unsigned long fp=
)
+{
+=09if (nip =3D=3D fp + offsetof(struct signal_frame_64, tramp))
+=09=09return 1;
+=09if (vdso64_rt_sigtramp && current->mm->context.vdso_base &&
+=09    nip =3D=3D current->mm->context.vdso_base + vdso64_rt_sigtramp)=

+=09=09return 1;
+=09return 0;
+}
+
+/*
+ * Do some sanity checking on the signal frame pointed to by sp.
+ * We check the pinfo and puc pointers in the frame.
+ */
+static int sane_signal_64_frame(unsigned long sp)
+{
+=09struct signal_frame_64 __user *sf;
+=09unsigned long pinfo, puc;
+
+=09sf =3D (struct signal_frame_64 __user *) sp;
+=09if (read_user_stack_64((unsigned long __user *) &sf->pinfo, &pinfo)=
 ||
+=09    read_user_stack_64((unsigned long __user *) &sf->puc, &puc))
+=09=09return 0;
+=09return pinfo =3D=3D (unsigned long) &sf->info &&
+=09=09puc =3D=3D (unsigned long) &sf->uc;
+}
+
+static void perf_callchain_user_64(struct pt_regs *regs,
+=09=09=09=09   struct perf_callchain_entry *entry)
+{
+=09unsigned long sp, next_sp;
+=09unsigned long next_ip;
+=09unsigned long lr;
+=09long level =3D 0;
+=09struct signal_frame_64 __user *sigframe;
+=09unsigned long __user *fp, *uregs;
+
+=09next_ip =3D regs->nip;
+=09lr =3D regs->link;
+=09sp =3D regs->gpr[1];
+=09callchain_store(entry, PERF_CONTEXT_USER);
+=09callchain_store(entry, next_ip);
+
+=09for (;;) {
+=09=09fp =3D (unsigned long __user *) sp;
+=09=09if (!valid_user_sp(sp, 1) || read_user_stack_64(fp, &next_sp))
+=09=09=09return;
+=09=09if (level > 0 && read_user_stack_64(&fp[2], &next_ip))
+=09=09=09return;
+
+=09=09/*
+=09=09 * Note: the next_sp - sp >=3D signal frame size check
+=09=09 * is true when next_sp < sp, which can happen when
+=09=09 * transitioning from an alternate signal stack to the
+=09=09 * normal stack.
+=09=09 */
+=09=09if (next_sp - sp >=3D sizeof(struct signal_frame_64) &&
+=09=09    (is_sigreturn_64_address(next_ip, sp) ||
+=09=09     (level <=3D 1 && is_sigreturn_64_address(lr, sp))) &&
+=09=09    sane_signal_64_frame(sp)) {
+=09=09=09/*
+=09=09=09 * This looks like an signal frame
+=09=09=09 */
+=09=09=09sigframe =3D (struct signal_frame_64 __user *) sp;
+=09=09=09uregs =3D sigframe->uc.uc_mcontext.gp_regs;
+=09=09=09if (read_user_stack_64(&uregs[PT_NIP], &next_ip) ||
+=09=09=09    read_user_stack_64(&uregs[PT_LNK], &lr) ||
+=09=09=09    read_user_stack_64(&uregs[PT_R1], &sp))
+=09=09=09=09return;
+=09=09=09level =3D 0;
+=09=09=09callchain_store(entry, PERF_CONTEXT_USER);
+=09=09=09callchain_store(entry, next_ip);
+=09=09=09continue;
+=09=09}
+
+=09=09if (level =3D=3D 0)
+=09=09=09next_ip =3D lr;
+=09=09callchain_store(entry, next_ip);
+=09=09++level;
+=09=09sp =3D next_sp;
+=09}
+}
+
+static inline int current_is_64bit(void)
+{
+=09/*
+=09 * We can't use test_thread_flag() here because we may be on an
+=09 * interrupt stack, and the thread flags don't get copied over
+=09 * from the thread_info on the main stack to the interrupt stack.
+=09 */
+=09return !test_ti_thread_flag(task_thread_info(current), TIF_32BIT);
+}
+
+#else  /* CONFIG_PPC64 */
+/*
+ * On 32-bit we just access the address and let hash_page create a
+ * HPTE if necessary, so there is no need to fall back to reading
+ * the page tables.  Since this is called at interrupt level,
+ * do_page_fault() won't treat a DSI as a page fault.
+ */
+static int read_user_stack_32(unsigned int __user *ptr, unsigned int *=
ret)
+{
+=09if ((unsigned long)ptr > TASK_SIZE - sizeof(unsigned int) ||
+=09    ((unsigned long)ptr & 3))
+=09=09return -EFAULT;
+
+=09return __get_user_inatomic(*ret, ptr);
+}
+
+static inline void perf_callchain_user_64(struct pt_regs *regs,
+=09=09=09=09=09  struct perf_callchain_entry *entry)
+{
+}
+
+static inline int current_is_64bit(void)
+{
+=09return 0;
+}
+
+static inline int valid_user_sp(unsigned long sp, int is_64)
+{
+=09if (!sp || (sp & 7) || sp > TASK_SIZE - 32)
+=09=09return 0;
+=09return 1;
+}
+
+#define __SIGNAL_FRAMESIZE32=09__SIGNAL_FRAMESIZE
+#define sigcontext32=09=09sigcontext
+#define mcontext32=09=09mcontext
+#define ucontext32=09=09ucontext
+#define compat_siginfo_t=09struct siginfo
+
+#endif /* CONFIG_PPC64 */
+
+/*
+ * Layout for non-RT signal frames
+ */
+struct signal_frame_32 {
+=09char=09=09=09dummy[__SIGNAL_FRAMESIZE32];
+=09struct sigcontext32=09sctx;
+=09struct mcontext32=09mctx;
+=09int=09=09=09abigap[56];
+};
+
+/*
+ * Layout for RT signal frames
+ */
+struct rt_signal_frame_32 {
+=09char=09=09=09dummy[__SIGNAL_FRAMESIZE32 + 16];
+=09compat_siginfo_t=09info;
+=09struct ucontext32=09uc;
+=09int=09=09=09abigap[56];
+};
+
+static int is_sigreturn_32_address(unsigned int nip, unsigned int fp)
+{
+=09if (nip =3D=3D fp + offsetof(struct signal_frame_32, mctx.mc_pad))
+=09=09return 1;
+=09if (vdso32_sigtramp && current->mm->context.vdso_base &&
+=09    nip =3D=3D current->mm->context.vdso_base + vdso32_sigtramp)
+=09=09return 1;
+=09return 0;
+}
+
+static int is_rt_sigreturn_32_address(unsigned int nip, unsigned int f=
p)
+{
+=09if (nip =3D=3D fp + offsetof(struct rt_signal_frame_32,
+=09=09=09=09 uc.uc_mcontext.mc_pad))
+=09=09return 1;
+=09if (vdso32_rt_sigtramp && current->mm->context.vdso_base &&
+=09    nip =3D=3D current->mm->context.vdso_base + vdso32_rt_sigtramp)=

+=09=09return 1;
+=09return 0;
+}
+
+static int sane_signal_32_frame(unsigned int sp)
+{
+=09struct signal_frame_32 __user *sf;
+=09unsigned int regs;
+
+=09sf =3D (struct signal_frame_32 __user *) (unsigned long) sp;
+=09if (read_user_stack_32((unsigned int __user *) &sf->sctx.regs, &reg=
s))
+=09=09return 0;
+=09return regs =3D=3D (unsigned long) &sf->mctx;
+}
+
+static int sane_rt_signal_32_frame(unsigned int sp)
+{
+=09struct rt_signal_frame_32 __user *sf;
+=09unsigned int regs;
+
+=09sf =3D (struct rt_signal_frame_32 __user *) (unsigned long) sp;
+=09if (read_user_stack_32((unsigned int __user *) &sf->uc.uc_regs, &re=
gs))
+=09=09return 0;
+=09return regs =3D=3D (unsigned long) &sf->uc.uc_mcontext;
+}
+
+static unsigned int __user *signal_frame_32_regs(unsigned int sp,
+=09=09=09=09unsigned int next_sp, unsigned int next_ip)
+{
+=09struct mcontext32 __user *mctx =3D NULL;
+=09struct signal_frame_32 __user *sf;
+=09struct rt_signal_frame_32 __user *rt_sf;
+
+=09/*
+=09 * Note: the next_sp - sp >=3D signal frame size check
+=09 * is true when next_sp < sp, for example, when
+=09 * transitioning from an alternate signal stack to the
+=09 * normal stack.
+=09 */
+=09if (next_sp - sp >=3D sizeof(struct signal_frame_32) &&
+=09    is_sigreturn_32_address(next_ip, sp) &&
+=09    sane_signal_32_frame(sp)) {
+=09=09sf =3D (struct signal_frame_32 __user *) (unsigned long) sp;
+=09=09mctx =3D &sf->mctx;
+=09}
+
+=09if (!mctx && next_sp - sp >=3D sizeof(struct rt_signal_frame_32) &&=

+=09    is_rt_sigreturn_32_address(next_ip, sp) &&
+=09    sane_rt_signal_32_frame(sp)) {
+=09=09rt_sf =3D (struct rt_signal_frame_32 __user *) (unsigned long) s=
p;
+=09=09mctx =3D &rt_sf->uc.uc_mcontext;
+=09}
+
+=09if (!mctx)
+=09=09return NULL;
+=09return mctx->mc_gregs;
+}
+
+static void perf_callchain_user_32(struct pt_regs *regs,
+=09=09=09=09   struct perf_callchain_entry *entry)
+{
+=09unsigned int sp, next_sp;
+=09unsigned int next_ip;
+=09unsigned int lr;
+=09long level =3D 0;
+=09unsigned int __user *fp, *uregs;
+
+=09next_ip =3D regs->nip;
+=09lr =3D regs->link;
+=09sp =3D regs->gpr[1];
+=09callchain_store(entry, PERF_CONTEXT_USER);
+=09callchain_store(entry, next_ip);
+
+=09while (entry->nr < PERF_MAX_STACK_DEPTH) {
+=09=09fp =3D (unsigned int __user *) (unsigned long) sp;
+=09=09if (!valid_user_sp(sp, 0) || read_user_stack_32(fp, &next_sp))
+=09=09=09return;
+=09=09if (level > 0 && read_user_stack_32(&fp[1], &next_ip))
+=09=09=09return;
+
+=09=09uregs =3D signal_frame_32_regs(sp, next_sp, next_ip);
+=09=09if (!uregs && level <=3D 1)
+=09=09=09uregs =3D signal_frame_32_regs(sp, next_sp, lr);
+=09=09if (uregs) {
+=09=09=09/*
+=09=09=09 * This looks like an signal frame, so restart
+=09=09=09 * the stack trace with the values in it.
+=09=09=09 */
+=09=09=09if (read_user_stack_32(&uregs[PT_NIP], &next_ip) ||
+=09=09=09    read_user_stack_32(&uregs[PT_LNK], &lr) ||
+=09=09=09    read_user_stack_32(&uregs[PT_R1], &sp))
+=09=09=09=09return;
+=09=09=09level =3D 0;
+=09=09=09callchain_store(entry, PERF_CONTEXT_USER);
+=09=09=09callchain_store(entry, next_ip);
+=09=09=09continue;
+=09=09}
+
+=09=09if (level =3D=3D 0)
+=09=09=09next_ip =3D lr;
+=09=09callchain_store(entry, next_ip);
+=09=09++level;
+=09=09sp =3D next_sp;
+=09}
+}
+
+/*
+ * Since we can't get PMU interrupts inside a PMU interrupt handler,
+ * we don't need separate irq and nmi entries here.
+ */
+static DEFINE_PER_CPU(struct perf_callchain_entry, callchain);
+
+struct perf_callchain_entry *perf_callchain(struct pt_regs *regs)
+{
+=09struct perf_callchain_entry *entry =3D &__get_cpu_var(callchain);
+
+=09entry->nr =3D 0;
+
+=09if (current->pid =3D=3D 0)=09=09/* idle task? */
+=09=09return entry;
+
+=09if (!user_mode(regs)) {
+=09=09perf_callchain_kernel(regs, entry);
+=09=09if (current->mm)
+=09=09=09regs =3D task_pt_regs(current);
+=09=09else
+=09=09=09regs =3D NULL;
+=09}
+
+=09if (regs) {
+=09=09if (current_is_64bit())
+=09=09=09perf_callchain_user_64(regs, entry);
+=09=09else
+=09=09=09perf_callchain_user_32(regs, entry);
+=09}
+
+=09return entry;
+}
--=20
1.6.0.4
