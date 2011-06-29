Return-Path: <paulus@ozlabs.org>
Date: Wed, 29 Jun 2011 20:22:05 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
	Alexander Graf <agraf@suse.de>
Subject: [PATCH 11/17] KVM: PPC: Handle some PAPR hcalls in the kernel
Message-ID: <20110629102205.GL25406@bloggs.ozlabs.ibm.com>
References: <20110629101552.GA25406@bloggs.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110629101552.GA25406@bloggs.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds the infrastructure for handling PAPR hcalls in the kernel,
either early in the guest exit path while we are still in real mode,
or later once the MMU has been turned back on and we are in the full
kernel context.  The advantage of handling hcalls in real mode if
possible is that we avoid two partition switches -- and this will
become more important when we support SMT4 guests, since a partition
switch means we have to pull all of the threads in the core out of
the guest.  The disadvantage is that we can only access the kernel
linear mapping, not anything vmalloced or ioremapped, since the MMU
is off.

This also adds code to handle the following hcalls in real mode:

H_ENTER       Add an HPTE to the hashed page table
H_REMOVE      Remove an HPTE from the hashed page table
H_READ        Read HPTEs from the hashed page table
H_PROTECT     Change the protection bits in an HPTE
H_BULK_REMOVE Remove up to 4 HPTEs from the hashed page table
H_SET_DABR    Set the data address breakpoint register

Plus code to handle the following hcalls in the kernel:

H_CEDE        Idle the vcpu until an interrupt or H_PROD hcall arrives
H_PROD        Wake up a ceded vcpu
H_REGISTER_VPA Register a virtual processor area (VPA)

The code that runs in real mode has to be in the base kernel, not in
the module, if KVM is compiled as a module.  The real-mode code can
only access the kernel linear mapping, not vmalloc or ioremap space.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/hvcall.h       |    5 +
 arch/powerpc/include/asm/kvm_host.h     |   11 +
 arch/powerpc/include/asm/kvm_ppc.h      |    1 +
 arch/powerpc/kernel/asm-offsets.c       |    2 +
 arch/powerpc/kvm/Makefile               |    8 +-
 arch/powerpc/kvm/book3s_hv.c            |  170 ++++++++++++++-
 arch/powerpc/kvm/book3s_hv_rm_mmu.c     |  368 +++++++++++++++++++++++++++++++
 arch/powerpc/kvm/book3s_hv_rmhandlers.S |  158 +++++++++++++-
 arch/powerpc/kvm/powerpc.c              |    2 +-
 9 files changed, 718 insertions(+), 7 deletions(-)
 create mode 100644 arch/powerpc/kvm/book3s_hv_rm_mmu.c

diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
index fd8201d..1c324ff 100644
--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -29,6 +29,10 @@
 #define H_LONG_BUSY_ORDER_100_SEC	9905  /* Long busy, hint that 100sec \
 						 is a good time to retry */
 #define H_LONG_BUSY_END_RANGE		9905  /* End of long busy range */
+
+/* Internal value used in book3s_hv kvm support; not returned to guests */
+#define H_TOO_HARD	9999
+
 #define H_HARDWARE	-1	/* Hardware error */
 #define H_FUNCTION	-2	/* Function not supported */
 #define H_PRIVILEGE	-3	/* Caller not privileged */
@@ -100,6 +104,7 @@
 #define H_PAGE_SET_ACTIVE	H_PAGE_STATE_CHANGE
 #define H_AVPN			(1UL<<(63-32))	/* An avpn is provided as a sanity test */
 #define H_ANDCOND		(1UL<<(63-33))
+#define H_LOCAL			(1UL<<(63-35))
 #define H_ICACHE_INVALIDATE	(1UL<<(63-40))	/* icbi, etc.  (ignored for IO pages) */
 #define H_ICACHE_SYNCHRONIZE	(1UL<<(63-41))	/* dcbst, icbi, etc (ignored for IO pages */
 #define H_COALESCE_CAND	(1UL<<(63-42))	/* page is a good candidate for coalescing */
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 4a3f790..6ebf172 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -59,6 +59,10 @@ struct kvm;
 struct kvm_run;
 struct kvm_vcpu;
 
+struct lppaca;
+struct slb_shadow;
+struct dtl;
+
 struct kvm_vm_stat {
 	u32 remote_tlb_flush;
 };
@@ -344,7 +348,14 @@ struct kvm_vcpu_arch {
 	u64 dec_expires;
 	unsigned long pending_exceptions;
 	u16 last_cpu;
+	u8 ceded;
+	u8 prodded;
 	u32 last_inst;
+
+	struct lppaca *vpa;
+	struct slb_shadow *slb_shadow;
+	struct dtl *dtl;
+	struct dtl *dtl_end;
 	int trap;
 	struct kvm_vcpu_arch_shared *shared;
 	unsigned long magic_page_pa; /* phys addr to map the magic page to */
diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index 0dafd53..2afe92e 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -118,6 +118,7 @@ extern long kvmppc_prepare_vrma(struct kvm *kvm,
 				struct kvm_userspace_memory_region *mem);
 extern void kvmppc_map_vrma(struct kvm *kvm,
 			    struct kvm_userspace_memory_region *mem);
+extern int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu);
 extern int kvmppc_core_init_vm(struct kvm *kvm);
 extern void kvmppc_core_destroy_vm(struct kvm *kvm);
 extern int kvmppc_core_prepare_memory_region(struct kvm *kvm,
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 9362674..c70d106 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -189,6 +189,7 @@ int main(void)
 	DEFINE(LPPACADECRINT, offsetof(struct lppaca, int_dword.fields.decr_int));
 	DEFINE(LPPACA_PMCINUSE, offsetof(struct lppaca, pmcregs_in_use));
 	DEFINE(LPPACA_DTLIDX, offsetof(struct lppaca, dtl_idx));
+	DEFINE(LPPACA_YIELDCOUNT, offsetof(struct lppaca, yield_count));
 	DEFINE(PACA_DTL_RIDX, offsetof(struct paca_struct, dtl_ridx));
 #endif /* CONFIG_PPC_STD_MMU_64 */
 	DEFINE(PACAEMERGSP, offsetof(struct paca_struct, emergency_sp));
@@ -459,6 +460,7 @@ int main(void)
 	DEFINE(VCPU_DEC, offsetof(struct kvm_vcpu, arch.dec));
 	DEFINE(VCPU_DEC_EXPIRES, offsetof(struct kvm_vcpu, arch.dec_expires));
 	DEFINE(VCPU_LPCR, offsetof(struct kvm_vcpu, arch.lpcr));
+	DEFINE(VCPU_VPA, offsetof(struct kvm_vcpu, arch.vpa));
 	DEFINE(VCPU_MMCR, offsetof(struct kvm_vcpu, arch.mmcr));
 	DEFINE(VCPU_PMC, offsetof(struct kvm_vcpu, arch.pmc));
 	DEFINE(VCPU_SLB, offsetof(struct kvm_vcpu, arch.slb));
diff --git a/arch/powerpc/kvm/Makefile b/arch/powerpc/kvm/Makefile
index 8a435a6..2ecffc0 100644
--- a/arch/powerpc/kvm/Makefile
+++ b/arch/powerpc/kvm/Makefile
@@ -54,14 +54,17 @@ kvm-book3s_64-objs-$(CONFIG_KVM_BOOK3S_64_HV) := \
 	book3s_hv.o \
 	book3s_hv_interrupts.o \
 	book3s_64_mmu_hv.o
+kvm-book3s_64-builtin-objs-$(CONFIG_KVM_BOOK3S_64_HV) := \
+	book3s_hv_rm_mmu.o
 
-kvm-book3s_64-objs := \
+kvm-book3s_64-module-objs := \
 	../../../virt/kvm/kvm_main.o \
 	powerpc.o \
 	emulate.o \
 	book3s.o \
 	$(kvm-book3s_64-objs-y)
-kvm-objs-$(CONFIG_KVM_BOOK3S_64) := $(kvm-book3s_64-objs)
+
+kvm-objs-$(CONFIG_KVM_BOOK3S_64) := $(kvm-book3s_64-module-objs)
 
 kvm-book3s_32-objs := \
 	$(common-objs-y) \
@@ -83,3 +86,4 @@ obj-$(CONFIG_KVM_E500) += kvm.o
 obj-$(CONFIG_KVM_BOOK3S_64) += kvm.o
 obj-$(CONFIG_KVM_BOOK3S_32) += kvm.o
 
+obj-y += $(kvm-book3s_64-builtin-objs-y)
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 60b7300..af862c3 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -124,6 +124,158 @@ void kvmppc_dump_regs(struct kvm_vcpu *vcpu)
 	       vcpu->arch.last_inst);
 }
 
+struct kvm_vcpu *kvmppc_find_vcpu(struct kvm *kvm, int id)
+{
+	int r;
+	struct kvm_vcpu *v, *ret = NULL;
+
+	mutex_lock(&kvm->lock);
+	kvm_for_each_vcpu(r, v, kvm) {
+		if (v->vcpu_id == id) {
+			ret = v;
+			break;
+		}
+	}
+	mutex_unlock(&kvm->lock);
+	return ret;
+}
+
+static void init_vpa(struct kvm_vcpu *vcpu, struct lppaca *vpa)
+{
+	vpa->shared_proc = 1;
+	vpa->yield_count = 1;
+}
+
+static unsigned long do_h_register_vpa(struct kvm_vcpu *vcpu,
+				       unsigned long flags,
+				       unsigned long vcpuid, unsigned long vpa)
+{
+	struct kvm *kvm = vcpu->kvm;
+	unsigned long pg_index, ra, len;
+	unsigned long pg_offset;
+	void *va;
+	struct kvm_vcpu *tvcpu;
+
+	tvcpu = kvmppc_find_vcpu(kvm, vcpuid);
+	if (!tvcpu)
+		return H_PARAMETER;
+
+	flags >>= 63 - 18;
+	flags &= 7;
+	if (flags == 0 || flags == 4)
+		return H_PARAMETER;
+	if (flags < 4) {
+		if (vpa & 0x7f)
+			return H_PARAMETER;
+		/* registering new area; convert logical addr to real */
+		pg_index = vpa >> kvm->arch.ram_porder;
+		pg_offset = vpa & (kvm->arch.ram_psize - 1);
+		if (pg_index >= kvm->arch.ram_npages)
+			return H_PARAMETER;
+		if (kvm->arch.ram_pginfo[pg_index].pfn == 0)
+			return H_PARAMETER;
+		ra = kvm->arch.ram_pginfo[pg_index].pfn << PAGE_SHIFT;
+		ra |= pg_offset;
+		va = __va(ra);
+		if (flags <= 1)
+			len = *(unsigned short *)(va + 4);
+		else
+			len = *(unsigned int *)(va + 4);
+		if (pg_offset + len > kvm->arch.ram_psize)
+			return H_PARAMETER;
+		switch (flags) {
+		case 1:		/* register VPA */
+			if (len < 640)
+				return H_PARAMETER;
+			tvcpu->arch.vpa = va;
+			init_vpa(vcpu, va);
+			break;
+		case 2:		/* register DTL */
+			if (len < 48)
+				return H_PARAMETER;
+			if (!tvcpu->arch.vpa)
+				return H_RESOURCE;
+			len -= len % 48;
+			tvcpu->arch.dtl = va;
+			tvcpu->arch.dtl_end = va + len;
+			break;
+		case 3:		/* register SLB shadow buffer */
+			if (len < 8)
+				return H_PARAMETER;
+			if (!tvcpu->arch.vpa)
+				return H_RESOURCE;
+			tvcpu->arch.slb_shadow = va;
+			len = (len - 16) / 16;
+			tvcpu->arch.slb_shadow = va;
+			break;
+		}
+	} else {
+		switch (flags) {
+		case 5:		/* unregister VPA */
+			if (tvcpu->arch.slb_shadow || tvcpu->arch.dtl)
+				return H_RESOURCE;
+			tvcpu->arch.vpa = NULL;
+			break;
+		case 6:		/* unregister DTL */
+			tvcpu->arch.dtl = NULL;
+			break;
+		case 7:		/* unregister SLB shadow buffer */
+			tvcpu->arch.slb_shadow = NULL;
+			break;
+		}
+	}
+	return H_SUCCESS;
+}
+
+int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu)
+{
+	unsigned long req = kvmppc_get_gpr(vcpu, 3);
+	unsigned long target, ret = H_SUCCESS;
+	struct kvm_vcpu *tvcpu;
+
+	switch (req) {
+	case H_CEDE:
+		vcpu->arch.shregs.msr |= MSR_EE;
+		vcpu->arch.ceded = 1;
+		smp_mb();
+		if (!vcpu->arch.prodded)
+			kvmppc_vcpu_block(vcpu);
+		else
+			vcpu->arch.prodded = 0;
+		smp_mb();
+		vcpu->arch.ceded = 0;
+		break;
+	case H_PROD:
+		target = kvmppc_get_gpr(vcpu, 4);
+		tvcpu = kvmppc_find_vcpu(vcpu->kvm, target);
+		if (!tvcpu) {
+			ret = H_PARAMETER;
+			break;
+		}
+		tvcpu->arch.prodded = 1;
+		smp_mb();
+		if (vcpu->arch.ceded) {
+			if (waitqueue_active(&vcpu->wq)) {
+				wake_up_interruptible(&vcpu->wq);
+				vcpu->stat.halt_wakeup++;
+			}
+		}
+		break;
+	case H_CONFER:
+		break;
+	case H_REGISTER_VPA:
+		ret = do_h_register_vpa(vcpu, kvmppc_get_gpr(vcpu, 4),
+					kvmppc_get_gpr(vcpu, 5),
+					kvmppc_get_gpr(vcpu, 6));
+		break;
+	default:
+		return RESUME_HOST;
+	}
+	kvmppc_set_gpr(vcpu, 3, ret);
+	vcpu->arch.hcall_needed = 0;
+	return RESUME_GUEST;
+}
+
 static int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
 			      struct task_struct *tsk)
 {
@@ -318,7 +470,7 @@ void kvmppc_core_vcpu_free(struct kvm_vcpu *vcpu)
 
 extern int __kvmppc_vcore_entry(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu);
 
-int kvmppc_vcpu_run(struct kvm_run *run, struct kvm_vcpu *vcpu)
+static int kvmppc_run_vcpu(struct kvm_run *run, struct kvm_vcpu *vcpu)
 {
 	u64 now;
 
@@ -370,6 +522,22 @@ int kvmppc_vcpu_run(struct kvm_run *run, struct kvm_vcpu *vcpu)
 	return -EBUSY;
 }
 
+int kvmppc_vcpu_run(struct kvm_run *run, struct kvm_vcpu *vcpu)
+{
+	int r;
+
+	do {
+		r = kvmppc_run_vcpu(run, vcpu);
+
+		if (run->exit_reason == KVM_EXIT_PAPR_HCALL &&
+		    !(vcpu->arch.shregs.msr & MSR_PR)) {
+			r = kvmppc_pseries_do_hcall(vcpu);
+			kvmppc_core_deliver_interrupts(vcpu);
+		}
+	} while (r == RESUME_GUEST);
+	return r;
+}
+
 int kvmppc_core_prepare_memory_region(struct kvm *kvm,
 				struct kvm_userspace_memory_region *mem)
 {
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
new file mode 100644
index 0000000..edb0aae
--- /dev/null
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -0,0 +1,368 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
+ * published by the Free Software Foundation.
+ *
+ * Copyright 2010-2011 Paul Mackerras, IBM Corp. <paulus@au1.ibm.com>
+ */
+
+#include <linux/types.h>
+#include <linux/string.h>
+#include <linux/kvm.h>
+#include <linux/kvm_host.h>
+#include <linux/hugetlb.h>
+
+#include <asm/tlbflush.h>
+#include <asm/kvm_ppc.h>
+#include <asm/kvm_book3s.h>
+#include <asm/mmu-hash64.h>
+#include <asm/hvcall.h>
+#include <asm/synch.h>
+#include <asm/ppc-opcode.h>
+
+/* For now use fixed-size 16MB page table */
+#define HPT_ORDER	24
+#define HPT_NPTEG	(1ul << (HPT_ORDER - 7))	/* 128B per pteg */
+#define HPT_HASH_MASK	(HPT_NPTEG - 1)
+
+#define HPTE_V_HVLOCK	0x40UL
+
+static inline long lock_hpte(unsigned long *hpte, unsigned long bits)
+{
+	unsigned long tmp, old;
+
+	asm volatile("	ldarx	%0,0,%2\n"
+		     "	and.	%1,%0,%3\n"
+		     "	bne	2f\n"
+		     "	ori	%0,%0,%4\n"
+		     "  stdcx.	%0,0,%2\n"
+		     "	beq+	2f\n"
+		     "	li	%1,%3\n"
+		     "2:	isync"
+		     : "=&r" (tmp), "=&r" (old)
+		     : "r" (hpte), "r" (bits), "i" (HPTE_V_HVLOCK)
+		     : "cc", "memory");
+	return old == 0;
+}
+
+long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
+		    long pte_index, unsigned long pteh, unsigned long ptel)
+{
+	unsigned long porder;
+	struct kvm *kvm = vcpu->kvm;
+	unsigned long i, lpn, pa;
+	unsigned long *hpte;
+
+	/* only handle 4k, 64k and 16M pages for now */
+	porder = 12;
+	if (pteh & HPTE_V_LARGE) {
+		if ((ptel & 0xf000) == 0x1000) {
+			/* 64k page */
+			porder = 16;
+		} else if ((ptel & 0xff000) == 0) {
+			/* 16M page */
+			porder = 24;
+			/* lowest AVA bit must be 0 for 16M pages */
+			if (pteh & 0x80)
+				return H_PARAMETER;
+		} else
+			return H_PARAMETER;
+	}
+	lpn = (ptel & HPTE_R_RPN) >> kvm->arch.ram_porder;
+	if (lpn >= kvm->arch.ram_npages || porder > kvm->arch.ram_porder)
+		return H_PARAMETER;
+	pa = kvm->arch.ram_pginfo[lpn].pfn << PAGE_SHIFT;
+	if (!pa)
+		return H_PARAMETER;
+	/* Check WIMG */
+	if ((ptel & HPTE_R_WIMG) != HPTE_R_M &&
+	    (ptel & HPTE_R_WIMG) != (HPTE_R_W | HPTE_R_I | HPTE_R_M))
+		return H_PARAMETER;
+	pteh &= ~0x60UL;
+	ptel &= ~(HPTE_R_PP0 - kvm->arch.ram_psize);
+	ptel |= pa;
+	if (pte_index >= (HPT_NPTEG << 3))
+		return H_PARAMETER;
+	if (likely((flags & H_EXACT) == 0)) {
+		pte_index &= ~7UL;
+		hpte = (unsigned long *)(kvm->arch.hpt_virt + (pte_index << 4));
+		for (i = 0; ; ++i) {
+			if (i == 8)
+				return H_PTEG_FULL;
+			if ((*hpte & HPTE_V_VALID) == 0 &&
+			    lock_hpte(hpte, HPTE_V_HVLOCK | HPTE_V_VALID))
+				break;
+			hpte += 2;
+		}
+	} else {
+		i = 0;
+		hpte = (unsigned long *)(kvm->arch.hpt_virt + (pte_index << 4));
+		if (!lock_hpte(hpte, HPTE_V_HVLOCK | HPTE_V_VALID))
+			return H_PTEG_FULL;
+	}
+	hpte[1] = ptel;
+	eieio();
+	hpte[0] = pteh;
+	asm volatile("ptesync" : : : "memory");
+	atomic_inc(&kvm->arch.ram_pginfo[lpn].refcnt);
+	vcpu->arch.gpr[4] = pte_index + i;
+	return H_SUCCESS;
+}
+
+static unsigned long compute_tlbie_rb(unsigned long v, unsigned long r,
+				      unsigned long pte_index)
+{
+	unsigned long rb, va_low;
+
+	rb = (v & ~0x7fUL) << 16;		/* AVA field */
+	va_low = pte_index >> 3;
+	if (v & HPTE_V_SECONDARY)
+		va_low = ~va_low;
+	/* xor vsid from AVA */
+	if (!(v & HPTE_V_1TB_SEG))
+		va_low ^= v >> 12;
+	else
+		va_low ^= v >> 24;
+	va_low &= 0x7ff;
+	if (v & HPTE_V_LARGE) {
+		rb |= 1;			/* L field */
+		if (r & 0xff000) {
+			/* non-16MB large page, must be 64k */
+			/* (masks depend on page size) */
+			rb |= 0x1000;		/* page encoding in LP field */
+			rb |= (va_low & 0x7f) << 16; /* 7b of VA in AVA/LP field */
+			rb |= (va_low & 0xfe);	/* AVAL field (P7 doesn't seem to care) */
+		}
+	} else {
+		/* 4kB page */
+		rb |= (va_low & 0x7ff) << 12;	/* remaining 11b of VA */
+	}
+	rb |= (v >> 54) & 0x300;		/* B field */
+	return rb;
+}
+
+#define LOCK_TOKEN	(*(u32 *)(&get_paca()->lock_token))
+
+static inline int try_lock_tlbie(unsigned int *lock)
+{
+	unsigned int tmp, old;
+	unsigned int token = LOCK_TOKEN;
+
+	asm volatile("1:lwarx	%1,0,%2\n"
+		     "	cmpwi	cr0,%1,0\n"
+		     "	bne	2f\n"
+		     "  stwcx.	%3,0,%2\n"
+		     "	bne-	1b\n"
+		     "  isync\n"
+		     "2:"
+		     : "=&r" (tmp), "=&r" (old)
+		     : "r" (lock), "r" (token)
+		     : "cc", "memory");
+	return old == 0;
+}
+
+long kvmppc_h_remove(struct kvm_vcpu *vcpu, unsigned long flags,
+		     unsigned long pte_index, unsigned long avpn,
+		     unsigned long va)
+{
+	struct kvm *kvm = vcpu->kvm;
+	unsigned long *hpte;
+	unsigned long v, r, rb;
+
+	if (pte_index >= (HPT_NPTEG << 3))
+		return H_PARAMETER;
+	hpte = (unsigned long *)(kvm->arch.hpt_virt + (pte_index << 4));
+	while (!lock_hpte(hpte, HPTE_V_HVLOCK))
+		cpu_relax();
+	if ((hpte[0] & HPTE_V_VALID) == 0 ||
+	    ((flags & H_AVPN) && (hpte[0] & ~0x7fUL) != avpn) ||
+	    ((flags & H_ANDCOND) && (hpte[0] & avpn) != 0)) {
+		hpte[0] &= ~HPTE_V_HVLOCK;
+		return H_NOT_FOUND;
+	}
+	if (atomic_read(&kvm->online_vcpus) == 1)
+		flags |= H_LOCAL;
+	vcpu->arch.gpr[4] = v = hpte[0] & ~HPTE_V_HVLOCK;
+	vcpu->arch.gpr[5] = r = hpte[1];
+	rb = compute_tlbie_rb(v, r, pte_index);
+	hpte[0] = 0;
+	if (!(flags & H_LOCAL)) {
+		while(!try_lock_tlbie(&kvm->arch.tlbie_lock))
+			cpu_relax();
+		asm volatile("ptesync" : : : "memory");
+		asm volatile(PPC_TLBIE(%1,%0)"; eieio; tlbsync"
+			     : : "r" (rb), "r" (kvm->arch.lpid));
+		asm volatile("ptesync" : : : "memory");
+		kvm->arch.tlbie_lock = 0;
+	} else {
+		asm volatile("ptesync" : : : "memory");
+		asm volatile("tlbiel %0" : : "r" (rb));
+		asm volatile("ptesync" : : : "memory");
+	}
+	return H_SUCCESS;
+}
+
+long kvmppc_h_bulk_remove(struct kvm_vcpu *vcpu)
+{
+	struct kvm *kvm = vcpu->kvm;
+	unsigned long *args = &vcpu->arch.gpr[4];
+	unsigned long *hp, tlbrb[4];
+	long int i, found;
+	long int n_inval = 0;
+	unsigned long flags, req, pte_index;
+	long int local = 0;
+	long int ret = H_SUCCESS;
+
+	if (atomic_read(&kvm->online_vcpus) == 1)
+		local = 1;
+	for (i = 0; i < 4; ++i) {
+		pte_index = args[i * 2];
+		flags = pte_index >> 56;
+		pte_index &= ((1ul << 56) - 1);
+		req = flags >> 6;
+		flags &= 3;
+		if (req == 3)
+			break;
+		if (req != 1 || flags == 3 ||
+		    pte_index >= (HPT_NPTEG << 3)) {
+			/* parameter error */
+			args[i * 2] = ((0xa0 | flags) << 56) + pte_index;
+			ret = H_PARAMETER;
+			break;
+		}
+		hp = (unsigned long *)(kvm->arch.hpt_virt + (pte_index << 4));
+		while (!lock_hpte(hp, HPTE_V_HVLOCK))
+			cpu_relax();
+		found = 0;
+		if (hp[0] & HPTE_V_VALID) {
+			switch (flags & 3) {
+			case 0:		/* absolute */
+				found = 1;
+				break;
+			case 1:		/* andcond */
+				if (!(hp[0] & args[i * 2 + 1]))
+					found = 1;
+				break;
+			case 2:		/* AVPN */
+				if ((hp[0] & ~0x7fUL) == args[i * 2 + 1])
+					found = 1;
+				break;
+			}
+		}
+		if (!found) {
+			hp[0] &= ~HPTE_V_HVLOCK;
+			args[i * 2] = ((0x90 | flags) << 56) + pte_index;
+			continue;
+		}
+		/* insert R and C bits from PTE */
+		flags |= (hp[1] >> 5) & 0x0c;
+		args[i * 2] = ((0x80 | flags) << 56) + pte_index;
+		tlbrb[n_inval++] = compute_tlbie_rb(hp[0], hp[1], pte_index);
+		hp[0] = 0;
+	}
+	if (n_inval == 0)
+		return ret;
+
+	if (!local) {
+		while(!try_lock_tlbie(&kvm->arch.tlbie_lock))
+			cpu_relax();
+		asm volatile("ptesync" : : : "memory");
+		for (i = 0; i < n_inval; ++i)
+			asm volatile(PPC_TLBIE(%1,%0)
+				     : : "r" (tlbrb[i]), "r" (kvm->arch.lpid));
+		asm volatile("eieio; tlbsync; ptesync" : : : "memory");
+		kvm->arch.tlbie_lock = 0;
+	} else {
+		asm volatile("ptesync" : : : "memory");
+		for (i = 0; i < n_inval; ++i)
+			asm volatile("tlbiel %0" : : "r" (tlbrb[i]));
+		asm volatile("ptesync" : : : "memory");
+	}
+	return ret;
+}
+
+long kvmppc_h_protect(struct kvm_vcpu *vcpu, unsigned long flags,
+		      unsigned long pte_index, unsigned long avpn,
+		      unsigned long va)
+{
+	struct kvm *kvm = vcpu->kvm;
+	unsigned long *hpte;
+	unsigned long v, r, rb;
+
+	if (pte_index >= (HPT_NPTEG << 3))
+		return H_PARAMETER;
+	hpte = (unsigned long *)(kvm->arch.hpt_virt + (pte_index << 4));
+	while (!lock_hpte(hpte, HPTE_V_HVLOCK))
+		cpu_relax();
+	if ((hpte[0] & HPTE_V_VALID) == 0 ||
+	    ((flags & H_AVPN) && (hpte[0] & ~0x7fUL) != avpn)) {
+		hpte[0] &= ~HPTE_V_HVLOCK;
+		return H_NOT_FOUND;
+	}
+	if (atomic_read(&kvm->online_vcpus) == 1)
+		flags |= H_LOCAL;
+	v = hpte[0];
+	r = hpte[1] & ~(HPTE_R_PP0 | HPTE_R_PP | HPTE_R_N |
+			HPTE_R_KEY_HI | HPTE_R_KEY_LO);
+	r |= (flags << 55) & HPTE_R_PP0;
+	r |= (flags << 48) & HPTE_R_KEY_HI;
+	r |= flags & (HPTE_R_PP | HPTE_R_N | HPTE_R_KEY_LO);
+	rb = compute_tlbie_rb(v, r, pte_index);
+	hpte[0] = v & ~HPTE_V_VALID;
+	if (!(flags & H_LOCAL)) {
+		while(!try_lock_tlbie(&kvm->arch.tlbie_lock))
+			cpu_relax();
+		asm volatile("ptesync" : : : "memory");
+		asm volatile(PPC_TLBIE(%1,%0)"; eieio; tlbsync"
+			     : : "r" (rb), "r" (kvm->arch.lpid));
+		asm volatile("ptesync" : : : "memory");
+		kvm->arch.tlbie_lock = 0;
+	} else {
+		asm volatile("ptesync" : : : "memory");
+		asm volatile("tlbiel %0" : : "r" (rb));
+		asm volatile("ptesync" : : : "memory");
+	}
+	hpte[1] = r;
+	eieio();
+	hpte[0] = v & ~HPTE_V_HVLOCK;
+	asm volatile("ptesync" : : : "memory");
+	return H_SUCCESS;
+}
+
+static unsigned long reverse_xlate(struct kvm *kvm, unsigned long realaddr)
+{
+	long int i;
+	unsigned long offset, rpn;
+
+	offset = realaddr & (kvm->arch.ram_psize - 1);
+	rpn = (realaddr - offset) >> PAGE_SHIFT;
+	for (i = 0; i < kvm->arch.ram_npages; ++i)
+		if (rpn == kvm->arch.ram_pginfo[i].pfn)
+			return (i << PAGE_SHIFT) + offset;
+	return HPTE_R_RPN;	/* all 1s in the RPN field */
+}
+
+long kvmppc_h_read(struct kvm_vcpu *vcpu, unsigned long flags,
+		   unsigned long pte_index)
+{
+	struct kvm *kvm = vcpu->kvm;
+	unsigned long *hpte, r;
+	int i, n = 1;
+
+	if (pte_index >= (HPT_NPTEG << 3))
+		return H_PARAMETER;
+	if (flags & H_READ_4) {
+		pte_index &= ~3;
+		n = 4;
+	}
+	for (i = 0; i < n; ++i, ++pte_index) {
+		hpte = (unsigned long *)(kvm->arch.hpt_virt + (pte_index << 4));
+		r = hpte[1];
+		if ((flags & H_R_XLATE) && (hpte[0] & HPTE_V_VALID))
+			r = reverse_xlate(kvm, r & HPTE_R_RPN) |
+				(r & ~HPTE_R_RPN);
+		vcpu->arch.gpr[4 + i * 2] = hpte[0];
+		vcpu->arch.gpr[5 + i * 2] = r;
+	}
+	return H_SUCCESS;
+}
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 9af2648..319ff63b 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -166,6 +166,14 @@ kvmppc_hv_entry:
 	/* Save R1 in the PACA */
 	std	r1, HSTATE_HOST_R1(r13)
 
+	/* Increment yield count if they have a VPA */
+	ld	r3, VCPU_VPA(r4)
+	cmpdi	r3, 0
+	beq	25f
+	lwz	r5, LPPACA_YIELDCOUNT(r3)
+	addi	r5, r5, 1
+	stw	r5, LPPACA_YIELDCOUNT(r3)
+25:
 	/* Load up DAR and DSISR */
 	ld	r5, VCPU_DAR(r4)
 	lwz	r6, VCPU_DSISR(r4)
@@ -401,6 +409,10 @@ kvmppc_interrupt:
 	cmpwi	r3,0
 	bge	ignore_hdec
 2:
+	/* See if this is something we can handle in real mode */
+	cmpwi	r12,BOOK3S_INTERRUPT_SYSCALL
+	beq	hcall_try_real_mode
+hcall_real_cont:
 
 	/* Check for mediated interrupts (could be done earlier really ...) */
 	cmpwi	r12,BOOK3S_INTERRUPT_EXTERNAL
@@ -579,13 +591,28 @@ hdec_soon:
 	std	r5, VCPU_SPRG2(r9)
 	std	r6, VCPU_SPRG3(r9)
 
-	/* Save PMU registers */
+	/* Increment yield count if they have a VPA */
+	ld	r8, VCPU_VPA(r9)	/* do they have a VPA? */
+	cmpdi	r8, 0
+	beq	25f
+	lwz	r3, LPPACA_YIELDCOUNT(r8)
+	addi	r3, r3, 1
+	stw	r3, LPPACA_YIELDCOUNT(r8)
+25:
+	/* Save PMU registers if requested */
+	/* r8 and cr0.eq are live here */
 	li	r3, 1
 	sldi	r3, r3, 31		/* MMCR0_FC (freeze counters) bit */
 	mfspr	r4, SPRN_MMCR0		/* save MMCR0 */
 	mtspr	SPRN_MMCR0, r3		/* freeze all counters, disable ints */
 	isync
-	mfspr	r5, SPRN_MMCR1
+	beq	21f			/* if no VPA, save PMU stuff anyway */
+	lbz	r7, LPPACA_PMCINUSE(r8)
+	cmpwi	r7, 0			/* did they ask for PMU stuff to be saved? */
+	bne	21f
+	std	r3, VCPU_MMCR(r9)	/* if not, set saved MMCR0 to FC */
+	b	22f
+21:	mfspr	r5, SPRN_MMCR1
 	mfspr	r6, SPRN_MMCRA
 	std	r4, VCPU_MMCR(r9)
 	std	r5, VCPU_MMCR + 8(r9)
@@ -676,6 +703,125 @@ hdec_soon:
 	mfspr	r7,SPRN_HDSISR
 	b	7b
 
+/*
+ * Try to handle an hcall in real mode.
+ * Returns to the guest if we handle it, or continues on up to
+ * the kernel if we can't (i.e. if we don't have a handler for
+ * it, or if the handler returns H_TOO_HARD).
+ */
+	.globl	hcall_try_real_mode
+hcall_try_real_mode:
+	ld	r3,VCPU_GPR(r3)(r9)
+	andi.	r0,r11,MSR_PR
+	bne	hcall_real_cont
+	clrrdi	r3,r3,2
+	cmpldi	r3,hcall_real_table_end - hcall_real_table
+	bge	hcall_real_cont
+	LOAD_REG_ADDR(r4, hcall_real_table)
+	lwzx	r3,r3,r4
+	cmpwi	r3,0
+	beq	hcall_real_cont
+	add	r3,r3,r4
+	mtctr	r3
+	mr	r3,r9		/* get vcpu pointer */
+	ld	r4,VCPU_GPR(r4)(r9)
+	bctrl
+	cmpdi	r3,H_TOO_HARD
+	beq	hcall_real_fallback
+	ld	r4,HSTATE_KVM_VCPU(r13)
+	std	r3,VCPU_GPR(r3)(r4)
+	ld	r10,VCPU_PC(r4)
+	ld	r11,VCPU_MSR(r4)
+	b	fast_guest_return
+
+	/* We've attempted a real mode hcall, but it's punted it back
+	 * to userspace.  We need to restore some clobbered volatiles
+	 * before resuming the pass-it-to-qemu path */
+hcall_real_fallback:
+	li	r12,BOOK3S_INTERRUPT_SYSCALL
+	ld	r9, HSTATE_KVM_VCPU(r13)
+	ld	r11, VCPU_MSR(r9)
+
+	b	hcall_real_cont
+
+	.globl	hcall_real_table
+hcall_real_table:
+	.long	0		/* 0 - unused */
+	.long	.kvmppc_h_remove - hcall_real_table
+	.long	.kvmppc_h_enter - hcall_real_table
+	.long	.kvmppc_h_read - hcall_real_table
+	.long	0		/* 0x10 - H_CLEAR_MOD */
+	.long	0		/* 0x14 - H_CLEAR_REF */
+	.long	.kvmppc_h_protect - hcall_real_table
+	.long	0		/* 0x1c - H_GET_TCE */
+	.long	0		/* 0x20 - H_SET_TCE */
+	.long	0		/* 0x24 - H_SET_SPRG0 */
+	.long	.kvmppc_h_set_dabr - hcall_real_table
+	.long	0		/* 0x2c */
+	.long	0		/* 0x30 */
+	.long	0		/* 0x34 */
+	.long	0		/* 0x38 */
+	.long	0		/* 0x3c */
+	.long	0		/* 0x40 */
+	.long	0		/* 0x44 */
+	.long	0		/* 0x48 */
+	.long	0		/* 0x4c */
+	.long	0		/* 0x50 */
+	.long	0		/* 0x54 */
+	.long	0		/* 0x58 */
+	.long	0		/* 0x5c */
+	.long	0		/* 0x60 */
+	.long	0		/* 0x64 */
+	.long	0		/* 0x68 */
+	.long	0		/* 0x6c */
+	.long	0		/* 0x70 */
+	.long	0		/* 0x74 */
+	.long	0		/* 0x78 */
+	.long	0		/* 0x7c */
+	.long	0		/* 0x80 */
+	.long	0		/* 0x84 */
+	.long	0		/* 0x88 */
+	.long	0		/* 0x8c */
+	.long	0		/* 0x90 */
+	.long	0		/* 0x94 */
+	.long	0		/* 0x98 */
+	.long	0		/* 0x9c */
+	.long	0		/* 0xa0 */
+	.long	0		/* 0xa4 */
+	.long	0		/* 0xa8 */
+	.long	0		/* 0xac */
+	.long	0		/* 0xb0 */
+	.long	0		/* 0xb4 */
+	.long	0		/* 0xb8 */
+	.long	0		/* 0xbc */
+	.long	0		/* 0xc0 */
+	.long	0		/* 0xc4 */
+	.long	0		/* 0xc8 */
+	.long	0		/* 0xcc */
+	.long	0		/* 0xd0 */
+	.long	0		/* 0xd4 */
+	.long	0		/* 0xd8 */
+	.long	0		/* 0xdc */
+	.long	0		/* 0xe0 */
+	.long	0		/* 0xe4 */
+	.long	0		/* 0xe8 */
+	.long	0		/* 0xec */
+	.long	0		/* 0xf0 */
+	.long	0		/* 0xf4 */
+	.long	0		/* 0xf8 */
+	.long	0		/* 0xfc */
+	.long	0		/* 0x100 */
+	.long	0		/* 0x104 */
+	.long	0		/* 0x108 */
+	.long	0		/* 0x10c */
+	.long	0		/* 0x110 */
+	.long	0		/* 0x114 */
+	.long	0		/* 0x118 */
+	.long	0		/* 0x11c */
+	.long	0		/* 0x120 */
+	.long	.kvmppc_h_bulk_remove - hcall_real_table
+hcall_real_table_end:
+
 ignore_hdec:
 	mr	r4,r9
 	b	fast_guest_return
@@ -688,10 +834,16 @@ bounce_ext_interrupt:
 	LOAD_REG_IMMEDIATE(r11,MSR_SF | MSR_ME);
 	b	fast_guest_return
 
+_GLOBAL(kvmppc_h_set_dabr)
+	std	r4,VCPU_DABR(r3)
+	mtspr	SPRN_DABR,r4
+	li	r3,0
+	blr
+
 /*
  * Save away FP, VMX and VSX registers.
  * r3 = vcpu pointer
-*/
+ */
 _GLOBAL(kvmppc_save_fp)
 	mfmsr	r9
 	ori	r8,r9,MSR_FP
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 3a4f379..6fc9ee4 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -42,7 +42,7 @@ int kvm_arch_vcpu_runnable(struct kvm_vcpu *v)
 	return !(v->arch.shared->msr & MSR_WE) ||
 	       !!(v->arch.pending_exceptions);
 #else
-	return 1;
+	return !(v->arch.ceded) || !!(v->arch.pending_exceptions);
 #endif
 }
 
-- 
1.7.5.4
