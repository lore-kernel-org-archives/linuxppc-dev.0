Return-Path: <paulus@ozlabs.org>
Date: Wed, 29 Jun 2011 20:25:44 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
	Alexander Graf <agraf@suse.de>
Subject: [PATCH 14/17] KVM: PPC: Allocate RMAs (Real Mode Areas) at boot for
	use by guests
Message-ID: <20110629102544.GO25406@bloggs.ozlabs.ibm.com>
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

This adds infrastructure which will be needed to allow book3s_hv KVM to
run on older POWER processors, including PPC970, which don't support
the Virtual Real Mode Area (VRMA) facility, but only the Real Mode
Offset (RMO) facility.  These processors require a physically
contiguous, aligned area of memory for each guest.  When the guest does
an access in real mode (MMU off), the address is compared against a
limit value, and if it is lower, the address is ORed with an offset
value (from the Real Mode Offset Register (RMOR)) and the result becomes
the real address for the access.  The size of the RMA has to be one of
a set of supported values, which usually includes 64MB, 128MB, 256MB
and some larger powers of 2.

Since we are unlikely to be able to allocate 64MB or more of physically
contiguous memory after the kernel has been running for a while, we
allocate a pool of RMAs at boot time using the bootmem allocator.  The
size and number of the RMAs can be set using the kvm_rma_size=xx and
kvm_rma_count=xx kernel command line options.

KVM exports a new capability, KVM_CAP_PPC_RMA, to signal the availability
of the pool of preallocated RMAs.  The capability value is 1 if the
processor can use an RMA but doesn't require one (because it supports
the VRMA facility), or 2 if the processor requires an RMA for each guest.

This adds a new ioctl, KVM_ALLOCATE_RMA, which allocates an RMA from the
pool and returns a file descriptor which can be used to map the RMA.  It
also returns the size of the RMA in the argument structure.

Having an RMA means we will get multiple KMV_SET_USER_MEMORY_REGION
ioctl calls from userspace.  To cope with this, we now preallocate the
kvm->arch.ram_pginfo array when the VM is created with a size sufficient
for up to 64GB of guest memory.  Subsequently we will get rid of this
array and use memory associated with each memslot instead.

This moves most of the code that translates the user addresses into
host pfns (page frame numbers) out of kvmppc_prepare_vrma up one level
to kvmppc_core_prepare_memory_region.  Also, instead of having to look
up the VMA for each page in order to check the page size, we now check
that the pages we get are compound pages of 16MB.  However, if we are
adding memory that is mapped to an RMA, we don't bother with calling
get_user_pages_fast and instead just offset from the base pfn for the
RMA.

Typically the RMA gets added after vcpus are created, which makes it
inconvenient to have the LPCR (logical partition control register) value
in the vcpu->arch struct, since the LPCR controls whether the processor
uses RMA or VRMA for the guest.  This moves the LPCR value into the
kvm->arch struct and arranges for the MER (mediated external request)
bit, which is the only bit that varies between vcpus, to be set in
assembly code when going into the guest if there is a pending external
interrupt request.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 Documentation/virtual/kvm/api.txt       |   32 ++++
 arch/powerpc/include/asm/kvm.h          |    5 +
 arch/powerpc/include/asm/kvm_book3s.h   |    8 -
 arch/powerpc/include/asm/kvm_host.h     |   15 ++-
 arch/powerpc/include/asm/kvm_ppc.h      |   10 ++
 arch/powerpc/include/asm/reg.h          |    1 +
 arch/powerpc/kernel/asm-offsets.c       |    4 +-
 arch/powerpc/kernel/setup_64.c          |    3 +
 arch/powerpc/kvm/Makefile               |    3 +-
 arch/powerpc/kvm/book3s_64_mmu_hv.c     |   97 +-----------
 arch/powerpc/kvm/book3s_hv.c            |  259 +++++++++++++++++++++++++++++-
 arch/powerpc/kvm/book3s_hv_builtin.c    |  152 ++++++++++++++++++
 arch/powerpc/kvm/book3s_hv_rmhandlers.S |   19 ++-
 arch/powerpc/kvm/powerpc.c              |   13 ++
 include/linux/kvm.h                     |    3 +
 15 files changed, 505 insertions(+), 119 deletions(-)
 create mode 100644 arch/powerpc/kvm/book3s_hv_builtin.c

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 6818713..b0e4b9c 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -1398,6 +1398,38 @@ the entries written by kernel-handled H_PUT_TCE calls, and also lets
 userspace update the TCE table directly which is useful in some
 circumstances.
 
+4.63 KVM_ALLOCATE_RMA
+
+Capability: KVM_CAP_PPC_RMA
+Architectures: powerpc
+Type: vm ioctl
+Parameters: struct kvm_allocate_rma (out)
+Returns: file descriptor for mapping the allocated RMA
+
+This allocates a Real Mode Area (RMA) from the pool allocated at boot
+time by the kernel.  An RMA is a physically-contiguous, aligned region
+of memory used on older POWER processors to provide the memory which
+will be accessed by real-mode (MMU off) accesses in a KVM guest.
+POWER processors support a set of sizes for the RMA that usually
+includes 64MB, 128MB, 256MB and some larger powers of two.
+
+/* for KVM_ALLOCATE_RMA */
+struct kvm_allocate_rma {
+	__u64 rma_size;
+};
+
+The return value is a file descriptor which can be passed to mmap(2)
+to map the allocated RMA into userspace.  The mapped area can then be
+passed to the KVM_SET_USER_MEMORY_REGION ioctl to establish it as the
+RMA for a virtual machine.  The size of the RMA in bytes (which is
+fixed at host kernel boot time) is returned in the rma_size field of
+the argument structure.
+
+The KVM_CAP_PPC_RMA capability is 1 or 2 if the KVM_ALLOCATE_RMA ioctl
+is supported; 2 if the processor requires all virtual machines to have
+an RMA, or 1 if the processor can use an RMA but doesn't require it,
+because it supports the Virtual RMA (VRMA) facility.
+
 5. The kvm_run structure
 
 Application code obtains a pointer to the kvm_run structure by
diff --git a/arch/powerpc/include/asm/kvm.h b/arch/powerpc/include/asm/kvm.h
index 471bb3d..a4f6c85 100644
--- a/arch/powerpc/include/asm/kvm.h
+++ b/arch/powerpc/include/asm/kvm.h
@@ -282,4 +282,9 @@ struct kvm_create_spapr_tce {
 	__u32 window_size;
 };
 
+/* for KVM_ALLOCATE_RMA */
+struct kvm_allocate_rma {
+	__u64 rma_size;
+};
+
 #endif /* __LINUX_KVM_POWERPC_H */
diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
index 5537c45..3f91ebd 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -298,14 +298,6 @@ static inline unsigned long kvmppc_interrupt_offset(struct kvm_vcpu *vcpu)
 static inline void kvmppc_update_int_pending(struct kvm_vcpu *vcpu,
 			unsigned long pending_now, unsigned long old_pending)
 {
-	/* Recalculate LPCR:MER based on the presence of
-	 * a pending external interrupt
-	 */
-	if (test_bit(BOOK3S_IRQPRIO_EXTERNAL, &pending_now) ||
-	    test_bit(BOOK3S_IRQPRIO_EXTERNAL_LEVEL, &pending_now))
-		vcpu->arch.lpcr |= LPCR_MER;
-	else
-		vcpu->arch.lpcr &= ~((u64)LPCR_MER);
 }
 
 static inline void kvmppc_set_gpr(struct kvm_vcpu *vcpu, int num, ulong val)
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 0d6d569..f572d9c 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -28,6 +28,8 @@
 #include <linux/threads.h>
 #include <linux/spinlock.h>
 #include <linux/kvm_para.h>
+#include <linux/list.h>
+#include <linux/atomic.h>
 #include <asm/kvm_asm.h>
 #include <asm/processor.h>
 
@@ -156,6 +158,14 @@ struct kvmppc_spapr_tce_table {
 	struct page *pages[0];
 };
 
+struct kvmppc_rma_info {
+	void		*base_virt;
+	unsigned long	 base_pfn;
+	unsigned long	 npages;
+	struct list_head list;
+	atomic_t 	 use_count;
+};
+
 struct kvm_arch {
 #ifdef CONFIG_KVM_BOOK3S_64_HV
 	unsigned long hpt_virt;
@@ -169,6 +179,10 @@ struct kvm_arch {
 	unsigned long sdr1;
 	unsigned long host_sdr1;
 	int tlbie_lock;
+	int n_rma_pages;
+	unsigned long lpcr;
+	unsigned long rmor;
+	struct kvmppc_rma_info *rma;
 	struct list_head spapr_tce_tables;
 	unsigned short last_vcpu[NR_CPUS];
 	struct kvmppc_vcore *vcores[KVM_MAX_VCORES];
@@ -295,7 +309,6 @@ struct kvm_vcpu_arch {
 	ulong guest_owned_ext;
 	ulong purr;
 	ulong spurr;
-	ulong lpcr;
 	ulong dscr;
 	ulong amr;
 	ulong uamor;
diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index 6ef7344..d121f49 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -124,6 +124,10 @@ extern void kvmppc_map_vrma(struct kvm *kvm,
 extern int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu);
 extern long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
 				struct kvm_create_spapr_tce *args);
+extern long kvm_vm_ioctl_allocate_rma(struct kvm *kvm,
+				struct kvm_allocate_rma *rma);
+extern struct kvmppc_rma_info *kvm_alloc_rma(void);
+extern void kvm_release_rma(struct kvmppc_rma_info *ri);
 extern int kvmppc_core_init_vm(struct kvm *kvm);
 extern void kvmppc_core_destroy_vm(struct kvm *kvm);
 extern int kvmppc_core_prepare_memory_region(struct kvm *kvm,
@@ -177,9 +181,15 @@ static inline void kvmppc_set_xics_phys(int cpu, unsigned long addr)
 {
 	paca[cpu].kvm_hstate.xics_phys = addr;
 }
+
+extern void kvm_rma_init(void);
+
 #else
 static inline void kvmppc_set_xics_phys(int cpu, unsigned long addr)
 {}
+
+static inline void kvm_rma_init(void)
+{}
 #endif
 
 #endif /* __POWERPC_KVM_PPC_H__ */
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 36a611b..20a053c 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -242,6 +242,7 @@
 #define   LPCR_VRMA_LP1	(1ul << (63-16))
 #define   LPCR_VRMASD_SH (63-16)
 #define   LPCR_RMLS    0x1C000000      /* impl dependent rmo limit sel */
+#define	  LPCR_RMLS_SH	(63-37)
 #define   LPCR_ILE     0x02000000      /* !HV irqs set MSR:LE */
 #define   LPCR_PECE	0x00007000	/* powersave exit cause enable */
 #define     LPCR_PECE0	0x00004000	/* ext. exceptions can cause exit */
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index d0f2387f..f4aba93 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -437,6 +437,8 @@ int main(void)
 	DEFINE(KVM_TLBIE_LOCK, offsetof(struct kvm, arch.tlbie_lock));
 	DEFINE(KVM_ONLINE_CPUS, offsetof(struct kvm, online_vcpus.counter));
 	DEFINE(KVM_LAST_VCPU, offsetof(struct kvm, arch.last_vcpu));
+	DEFINE(KVM_LPCR, offsetof(struct kvm, arch.lpcr));
+	DEFINE(KVM_RMOR, offsetof(struct kvm, arch.rmor));
 	DEFINE(VCPU_DSISR, offsetof(struct kvm_vcpu, arch.shregs.dsisr));
 	DEFINE(VCPU_DAR, offsetof(struct kvm_vcpu, arch.shregs.dar));
 #endif
@@ -459,7 +461,7 @@ int main(void)
 	DEFINE(VCPU_HFLAGS, offsetof(struct kvm_vcpu, arch.hflags));
 	DEFINE(VCPU_DEC, offsetof(struct kvm_vcpu, arch.dec));
 	DEFINE(VCPU_DEC_EXPIRES, offsetof(struct kvm_vcpu, arch.dec_expires));
-	DEFINE(VCPU_LPCR, offsetof(struct kvm_vcpu, arch.lpcr));
+	DEFINE(VCPU_PENDING_EXC, offsetof(struct kvm_vcpu, arch.pending_exceptions));
 	DEFINE(VCPU_VPA, offsetof(struct kvm_vcpu, arch.vpa));
 	DEFINE(VCPU_MMCR, offsetof(struct kvm_vcpu, arch.mmcr));
 	DEFINE(VCPU_PMC, offsetof(struct kvm_vcpu, arch.pmc));
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index a88bf27..532054f 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -63,6 +63,7 @@
 #include <asm/kexec.h>
 #include <asm/mmu_context.h>
 #include <asm/code-patching.h>
+#include <asm/kvm_ppc.h>
 
 #include "setup.h"
 
@@ -580,6 +581,8 @@ void __init setup_arch(char **cmdline_p)
 	/* Initialize the MMU context management stuff */
 	mmu_context_init();
 
+	kvm_rma_init();
+
 	ppc64_boot_msg(0x15, "Setup Done");
 }
 
diff --git a/arch/powerpc/kvm/Makefile b/arch/powerpc/kvm/Makefile
index 1de3d54..08428e2 100644
--- a/arch/powerpc/kvm/Makefile
+++ b/arch/powerpc/kvm/Makefile
@@ -56,7 +56,8 @@ kvm-book3s_64-objs-$(CONFIG_KVM_BOOK3S_64_HV) := \
 	book3s_64_mmu_hv.o
 kvm-book3s_64-builtin-objs-$(CONFIG_KVM_BOOK3S_64_HV) := \
 	book3s_hv_rm_mmu.o \
-	book3s_64_vio_hv.o
+	book3s_64_vio_hv.o \
+	book3s_hv_builtin.o
 
 kvm-book3s_64-module-objs := \
 	../../../virt/kvm/kvm_main.o \
diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 4a4fbec..96ba96a 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -79,103 +79,8 @@ long kvmppc_alloc_hpt(struct kvm *kvm)
 
 void kvmppc_free_hpt(struct kvm *kvm)
 {
-	unsigned long i;
-	struct kvmppc_pginfo *pginfo;
-
 	clear_bit(kvm->arch.lpid, lpid_inuse);
 	free_pages(kvm->arch.hpt_virt, HPT_ORDER - PAGE_SHIFT);
-
-	if (kvm->arch.ram_pginfo) {
-		pginfo = kvm->arch.ram_pginfo;
-		kvm->arch.ram_pginfo = NULL;
-		for (i = 0; i < kvm->arch.ram_npages; ++i)
-			put_page(pfn_to_page(pginfo[i].pfn));
-		kfree(pginfo);
-	}
-}
-
-static unsigned long user_page_size(unsigned long addr)
-{
-	struct vm_area_struct *vma;
-	unsigned long size = PAGE_SIZE;
-
-	down_read(&current->mm->mmap_sem);
-	vma = find_vma(current->mm, addr);
-	if (vma)
-		size = vma_kernel_pagesize(vma);
-	up_read(&current->mm->mmap_sem);
-	return size;
-}
-
-static pfn_t hva_to_pfn(unsigned long addr)
-{
-	struct page *page[1];
-	int npages;
-
-	might_sleep();
-
-	npages = get_user_pages_fast(addr, 1, 1, page);
-
-	if (unlikely(npages != 1))
-		return 0;
-
-	return page_to_pfn(page[0]);
-}
-
-long kvmppc_prepare_vrma(struct kvm *kvm,
-			 struct kvm_userspace_memory_region *mem)
-{
-	unsigned long psize, porder;
-	unsigned long i, npages;
-	struct kvmppc_pginfo *pginfo;
-	pfn_t pfn;
-	unsigned long hva;
-
-	/* First see what page size we have */
-	psize = user_page_size(mem->userspace_addr);
-	/* For now, only allow 16MB pages */
-	if (psize != 1ul << VRMA_PAGE_ORDER || (mem->memory_size & (psize - 1))) {
-		pr_err("bad psize=%lx memory_size=%llx @ %llx\n",
-		       psize, mem->memory_size, mem->userspace_addr);
-		return -EINVAL;
-	}
-	porder = __ilog2(psize);
-
-	npages = mem->memory_size >> porder;
-	pginfo = kzalloc(npages * sizeof(struct kvmppc_pginfo), GFP_KERNEL);
-	if (!pginfo) {
-		pr_err("kvmppc_prepare_vrma: couldn't alloc %lu bytes\n",
-		       npages * sizeof(struct kvmppc_pginfo));
-		return -ENOMEM;
-	}
-
-	for (i = 0; i < npages; ++i) {
-		hva = mem->userspace_addr + (i << porder);
-		if (user_page_size(hva) != psize)
-			goto err;
-		pfn = hva_to_pfn(hva);
-		if (pfn == 0) {
-			pr_err("oops, no pfn for hva %lx\n", hva);
-			goto err;
-		}
-		if (pfn & ((1ul << (porder - PAGE_SHIFT)) - 1)) {
-			pr_err("oops, unaligned pfn %llx\n", pfn);
-			put_page(pfn_to_page(pfn));
-			goto err;
-		}
-		pginfo[i].pfn = pfn;
-	}
-
-	kvm->arch.ram_npages = npages;
-	kvm->arch.ram_psize = psize;
-	kvm->arch.ram_porder = porder;
-	kvm->arch.ram_pginfo = pginfo;
-
-	return 0;
-
- err:
-	kfree(pginfo);
-	return -EINVAL;
 }
 
 void kvmppc_map_vrma(struct kvm *kvm, struct kvm_userspace_memory_region *mem)
@@ -199,6 +104,8 @@ void kvmppc_map_vrma(struct kvm *kvm, struct kvm_userspace_memory_region *mem)
 
 	for (i = 0; i < npages; ++i) {
 		pfn = pginfo[i].pfn;
+		if (!pfn)
+			break;
 		/* can't use hpt_hash since va > 64 bits */
 		hash = (i ^ (VRMA_VSID ^ (VRMA_VSID << 25))) & HPT_HASH_MASK;
 		/*
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 36b6d98..04da135c 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -27,6 +27,8 @@
 #include <linux/fs.h>
 #include <linux/anon_inodes.h>
 #include <linux/cpumask.h>
+#include <linux/spinlock.h>
+#include <linux/page-flags.h>
 
 #include <asm/reg.h>
 #include <asm/cputable.h>
@@ -40,11 +42,22 @@
 #include <asm/lppaca.h>
 #include <asm/processor.h>
 #include <asm/cputhreads.h>
+#include <asm/page.h>
 #include <linux/gfp.h>
 #include <linux/sched.h>
 #include <linux/vmalloc.h>
 #include <linux/highmem.h>
 
+/*
+ * For now, limit memory to 64GB and require it to be large pages.
+ * This value is chosen because it makes the ram_pginfo array be
+ * 64kB in size, which is about as large as we want to be trying
+ * to allocate with kmalloc.
+ */
+#define MAX_MEM_ORDER		36
+
+#define LARGE_PAGE_ORDER	24	/* 16MB pages */
+
 /* #define EXIT_DEBUG */
 /* #define EXIT_DEBUG_SIMPLE */
 /* #define EXIT_DEBUG_INT */
@@ -129,7 +142,7 @@ void kvmppc_dump_regs(struct kvm_vcpu *vcpu)
 		pr_err("  ESID = %.16llx VSID = %.16llx\n",
 		       vcpu->arch.slb[r].orige, vcpu->arch.slb[r].origv);
 	pr_err("lpcr = %.16lx sdr1 = %.16lx last_inst = %.8x\n",
-	       vcpu->arch.lpcr, vcpu->kvm->arch.sdr1,
+	       vcpu->kvm->arch.lpcr, vcpu->kvm->arch.sdr1,
 	       vcpu->arch.last_inst);
 }
 
@@ -441,7 +454,6 @@ struct kvm_vcpu *kvmppc_core_vcpu_create(struct kvm *kvm, unsigned int id)
 	int err = -EINVAL;
 	int core;
 	struct kvmppc_vcore *vcore;
-	unsigned long lpcr;
 
 	core = id / threads_per_core;
 	if (core >= KVM_MAX_VCORES)
@@ -464,10 +476,6 @@ struct kvm_vcpu *kvmppc_core_vcpu_create(struct kvm *kvm, unsigned int id)
 	vcpu->arch.pvr = mfspr(SPRN_PVR);
 	kvmppc_set_pvr(vcpu, vcpu->arch.pvr);
 
-	lpcr = kvm->arch.host_lpcr & (LPCR_PECE | LPCR_LPES);
-	lpcr |= LPCR_VPM0 | LPCR_VRMA_L | (4UL << LPCR_DPFD_SH) | LPCR_HDICE;
-	vcpu->arch.lpcr = lpcr;
-
 	kvmppc_mmu_book3s_hv_init(vcpu);
 
 	/*
@@ -910,24 +918,216 @@ fail:
 	return ret;
 }
 
+/* Work out RMLS (real mode limit selector) field value for a given RMA size.
+   Assumes POWER7. */
+static inline int lpcr_rmls(unsigned long rma_size)
+{
+	switch (rma_size) {
+	case 32ul << 20:	/* 32 MB */
+		return 8;
+	case 64ul << 20:	/* 64 MB */
+		return 3;
+	case 128ul << 20:	/* 128 MB */
+		return 7;
+	case 256ul << 20:	/* 256 MB */
+		return 4;
+	case 1ul << 30:		/* 1 GB */
+		return 2;
+	case 16ul << 30:	/* 16 GB */
+		return 1;
+	case 256ul << 30:	/* 256 GB */
+		return 0;
+	default:
+		return -1;
+	}
+}
+
+static int kvm_rma_fault(struct vm_area_struct *vma, struct vm_fault *vmf)
+{
+	struct kvmppc_rma_info *ri = vma->vm_file->private_data;
+	struct page *page;
+
+	if (vmf->pgoff >= ri->npages)
+		return VM_FAULT_SIGBUS;
+
+	page = pfn_to_page(ri->base_pfn + vmf->pgoff);
+	get_page(page);
+	vmf->page = page;
+	return 0;
+}
+
+static const struct vm_operations_struct kvm_rma_vm_ops = {
+	.fault = kvm_rma_fault,
+};
+
+static int kvm_rma_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	vma->vm_flags |= VM_RESERVED;
+	vma->vm_ops = &kvm_rma_vm_ops;
+	return 0;
+}
+
+static int kvm_rma_release(struct inode *inode, struct file *filp)
+{
+	struct kvmppc_rma_info *ri = filp->private_data;
+
+	kvm_release_rma(ri);
+	return 0;
+}
+
+static struct file_operations kvm_rma_fops = {
+	.mmap           = kvm_rma_mmap,
+	.release	= kvm_rma_release,
+};
+
+long kvm_vm_ioctl_allocate_rma(struct kvm *kvm, struct kvm_allocate_rma *ret)
+{
+	struct kvmppc_rma_info *ri;
+	long fd;
+
+	ri = kvm_alloc_rma();
+	if (!ri)
+		return -ENOMEM;
+
+	fd = anon_inode_getfd("kvm-rma", &kvm_rma_fops, ri, O_RDWR);
+	if (fd < 0)
+		kvm_release_rma(ri);
+
+	ret->rma_size = ri->npages << PAGE_SHIFT;
+	return fd;
+}
+
+static struct page *hva_to_page(unsigned long addr)
+{
+	struct page *page[1];
+	int npages;
+
+	might_sleep();
+
+	npages = get_user_pages_fast(addr, 1, 1, page);
+
+	if (unlikely(npages != 1))
+		return 0;
+
+	return page[0];
+}
+
 int kvmppc_core_prepare_memory_region(struct kvm *kvm,
 				struct kvm_userspace_memory_region *mem)
 {
-	if (mem->guest_phys_addr == 0 && mem->memory_size != 0)
-		return kvmppc_prepare_vrma(kvm, mem);
+	unsigned long psize, porder;
+	unsigned long i, npages, totalpages;
+	unsigned long pg_ix;
+	struct kvmppc_pginfo *pginfo;
+	unsigned long hva;
+	struct kvmppc_rma_info *ri = NULL;
+	struct page *page;
+
+	/* For now, only allow 16MB pages */
+	porder = LARGE_PAGE_ORDER;
+	psize = 1ul << porder;
+	if ((mem->memory_size & (psize - 1)) ||
+	    (mem->guest_phys_addr & (psize - 1))) {
+		pr_err("bad memory_size=%llx @ %llx\n",
+		       mem->memory_size, mem->guest_phys_addr);
+		return -EINVAL;
+	}
+
+	npages = mem->memory_size >> porder;
+	totalpages = (mem->guest_phys_addr + mem->memory_size) >> porder;
+
+	/* More memory than we have space to track? */
+	if (totalpages > (1ul << (MAX_MEM_ORDER - LARGE_PAGE_ORDER)))
+		return -EINVAL;
+
+	/* Do we already have an RMA registered? */
+	if (mem->guest_phys_addr == 0 && kvm->arch.rma)
+		return -EINVAL;
+
+	if (totalpages > kvm->arch.ram_npages)
+		kvm->arch.ram_npages = totalpages;
+
+	/* Is this one of our preallocated RMAs? */
+	if (mem->guest_phys_addr == 0) {
+		struct vm_area_struct *vma;
+
+		down_read(&current->mm->mmap_sem);
+		vma = find_vma(current->mm, mem->userspace_addr);
+		if (vma && vma->vm_file &&
+		    vma->vm_file->f_op == &kvm_rma_fops &&
+		    mem->userspace_addr == vma->vm_start)
+			ri = vma->vm_file->private_data;
+		up_read(&current->mm->mmap_sem);
+	}
+
+	if (ri) {
+		unsigned long rma_size;
+		unsigned long lpcr;
+		long rmls;
+
+		rma_size = ri->npages << PAGE_SHIFT;
+		if (rma_size > mem->memory_size)
+			rma_size = mem->memory_size;
+		rmls = lpcr_rmls(rma_size);
+		if (rmls < 0) {
+			pr_err("Can't use RMA of 0x%lx bytes\n", rma_size);
+			return -EINVAL;
+		}
+		atomic_inc(&ri->use_count);
+		kvm->arch.rma = ri;
+		kvm->arch.n_rma_pages = rma_size >> porder;
+		lpcr = kvm->arch.lpcr & ~(LPCR_VPM0 | LPCR_VRMA_L);
+		lpcr |= rmls << LPCR_RMLS_SH;
+		kvm->arch.lpcr = lpcr;
+		kvm->arch.rmor = kvm->arch.rma->base_pfn << PAGE_SHIFT;
+		pr_info("Using RMO at %lx size %lx (LPCR = %lx)\n",
+			ri->base_pfn << PAGE_SHIFT, rma_size, lpcr);
+	}
+
+	pg_ix = mem->guest_phys_addr >> porder;
+	pginfo = kvm->arch.ram_pginfo + pg_ix;
+	for (i = 0; i < npages; ++i, ++pg_ix) {
+		if (ri && pg_ix < kvm->arch.n_rma_pages) {
+			pginfo[i].pfn = ri->base_pfn +
+				(pg_ix << (porder - PAGE_SHIFT));
+			continue;
+		}
+		hva = mem->userspace_addr + (i << porder);
+		page = hva_to_page(hva);
+		if (!page) {
+			pr_err("oops, no pfn for hva %lx\n", hva);
+			goto err;
+		}
+		/* Check it's a 16MB page */
+		if (!PageHead(page) ||
+		    compound_order(page) != (LARGE_PAGE_ORDER - PAGE_SHIFT)) {
+			pr_err("page at %lx isn't 16MB (o=%d)\n",
+			       hva, compound_order(page));
+			goto err;
+		}
+		pginfo[i].pfn = page_to_pfn(page);
+	}
+
 	return 0;
+
+ err:
+	return -EINVAL;
 }
 
 void kvmppc_core_commit_memory_region(struct kvm *kvm,
 				struct kvm_userspace_memory_region *mem)
 {
-	if (mem->guest_phys_addr == 0 && mem->memory_size != 0)
+	if (mem->guest_phys_addr == 0 && mem->memory_size != 0 &&
+	    !kvm->arch.rma)
 		kvmppc_map_vrma(kvm, mem);
 }
 
 int kvmppc_core_init_vm(struct kvm *kvm)
 {
 	long r;
+	unsigned long npages = 1ul << (MAX_MEM_ORDER - LARGE_PAGE_ORDER);
+	long err = -ENOMEM;
+	unsigned long lpcr;
 
 	/* Allocate hashed page table */
 	r = kvmppc_alloc_hpt(kvm);
@@ -935,11 +1135,52 @@ int kvmppc_core_init_vm(struct kvm *kvm)
 		return r;
 
 	INIT_LIST_HEAD(&kvm->arch.spapr_tce_tables);
+
+	kvm->arch.ram_pginfo = kzalloc(npages * sizeof(struct kvmppc_pginfo),
+				       GFP_KERNEL);
+	if (!kvm->arch.ram_pginfo) {
+		pr_err("kvmppc_core_init_vm: couldn't alloc %lu bytes\n",
+		       npages * sizeof(struct kvmppc_pginfo));
+		goto out_free;
+	}
+
+	kvm->arch.ram_npages = 0;
+	kvm->arch.ram_psize = 1ul << LARGE_PAGE_ORDER;
+	kvm->arch.ram_porder = LARGE_PAGE_ORDER;
+	kvm->arch.rma = NULL;
+	kvm->arch.n_rma_pages = 0;
+
+	lpcr = kvm->arch.host_lpcr & (LPCR_PECE | LPCR_LPES);
+	lpcr |= (4UL << LPCR_DPFD_SH) | LPCR_HDICE |
+		LPCR_VPM0 | LPCR_VRMA_L;
+	kvm->arch.lpcr = lpcr;
+
+
 	return 0;
+
+ out_free:
+	kvmppc_free_hpt(kvm);
+	return err;
 }
 
 void kvmppc_core_destroy_vm(struct kvm *kvm)
 {
+	struct kvmppc_pginfo *pginfo;
+	unsigned long i;
+
+	if (kvm->arch.ram_pginfo) {
+		pginfo = kvm->arch.ram_pginfo;
+		kvm->arch.ram_pginfo = NULL;
+		for (i = kvm->arch.n_rma_pages; i < kvm->arch.ram_npages; ++i)
+			if (pginfo[i].pfn)
+				put_page(pfn_to_page(pginfo[i].pfn));
+		kfree(pginfo);
+	}
+	if (kvm->arch.rma) {
+		kvm_release_rma(kvm->arch.rma);
+		kvm->arch.rma = NULL;
+	}
+
 	kvmppc_free_hpt(kvm);
 	WARN_ON(!list_empty(&kvm->arch.spapr_tce_tables));
 }
diff --git a/arch/powerpc/kvm/book3s_hv_builtin.c b/arch/powerpc/kvm/book3s_hv_builtin.c
new file mode 100644
index 0000000..581c6b3
--- /dev/null
+++ b/arch/powerpc/kvm/book3s_hv_builtin.c
@@ -0,0 +1,152 @@
+/*
+ * Copyright 2011 Paul Mackerras, IBM Corp. <paulus@au1.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kvm_host.h>
+#include <linux/preempt.h>
+#include <linux/sched.h>
+#include <linux/spinlock.h>
+#include <linux/bootmem.h>
+#include <linux/init.h>
+
+#include <asm/cputable.h>
+#include <asm/kvm_ppc.h>
+#include <asm/kvm_book3s.h>
+
+/*
+ * This maintains a list of RMAs (real mode areas) for KVM guests to use.
+ * Each RMA has to be physically contiguous and of a size that the
+ * hardware supports.  PPC970 and POWER7 support 64MB, 128MB and 256MB,
+ * and other larger sizes.  Since we are unlikely to be allocate that
+ * much physically contiguous memory after the system is up and running,
+ * we preallocate a set of RMAs in early boot for KVM to use.
+ */
+static unsigned long kvm_rma_size = 64 << 20;	/* 64MB */
+static unsigned long kvm_rma_count;
+
+static int __init early_parse_rma_size(char *p)
+{
+	if (!p)
+		return 1;
+
+	kvm_rma_size = memparse(p, &p);
+
+	return 0;
+}
+early_param("kvm_rma_size", early_parse_rma_size);
+
+static int __init early_parse_rma_count(char *p)
+{
+	if (!p)
+		return 1;
+
+	kvm_rma_count = simple_strtoul(p, NULL, 0);
+
+	return 0;
+}
+early_param("kvm_rma_count", early_parse_rma_count);
+
+static struct kvmppc_rma_info *rma_info;
+static LIST_HEAD(free_rmas);
+static DEFINE_SPINLOCK(rma_lock);
+
+/* Work out RMLS (real mode limit selector) field value for a given RMA size.
+   Assumes POWER7. */
+static inline int lpcr_rmls(unsigned long rma_size)
+{
+	switch (rma_size) {
+	case 32ul << 20:	/* 32 MB */
+		return 8;
+	case 64ul << 20:	/* 64 MB */
+		return 3;
+	case 128ul << 20:	/* 128 MB */
+		return 7;
+	case 256ul << 20:	/* 256 MB */
+		return 4;
+	case 1ul << 30:		/* 1 GB */
+		return 2;
+	case 16ul << 30:	/* 16 GB */
+		return 1;
+	case 256ul << 30:	/* 256 GB */
+		return 0;
+	default:
+		return -1;
+	}
+}
+
+/*
+ * Called at boot time while the bootmem allocator is active,
+ * to allocate contiguous physical memory for the real memory
+ * areas for guests.
+ */
+void kvm_rma_init(void)
+{
+	unsigned long i;
+	unsigned long j, npages;
+	void *rma;
+	struct page *pg;
+
+	/* Only do this on POWER7 in HV mode */
+	if (!cpu_has_feature(CPU_FTR_HVMODE_206))
+		return;
+
+	if (!kvm_rma_size || !kvm_rma_count)
+		return;
+
+	/* Check that the requested size is one supported in hardware */
+	if (lpcr_rmls(kvm_rma_size) < 0) {
+		pr_err("RMA size of 0x%lx not supported\n", kvm_rma_size);
+		return;
+	}
+
+	npages = kvm_rma_size >> PAGE_SHIFT;
+	rma_info = alloc_bootmem(kvm_rma_count * sizeof(struct kvmppc_rma_info));
+	for (i = 0; i < kvm_rma_count; ++i) {
+		rma = alloc_bootmem_align(kvm_rma_size, kvm_rma_size);
+		pr_info("Allocated KVM RMA at %p (%ld MB)\n", rma,
+			kvm_rma_size >> 20);
+		rma_info[i].base_virt = rma;
+		rma_info[i].base_pfn = __pa(rma) >> PAGE_SHIFT;
+		rma_info[i].npages = npages;
+		list_add_tail(&rma_info[i].list, &free_rmas);
+		atomic_set(&rma_info[i].use_count, 0);
+
+		pg = pfn_to_page(rma_info[i].base_pfn);
+		for (j = 0; j < npages; ++j) {
+			atomic_inc(&pg->_count);
+			++pg;
+		}
+	}
+}
+
+struct kvmppc_rma_info *kvm_alloc_rma(void)
+{
+	struct kvmppc_rma_info *ri;
+
+	ri = NULL;
+	spin_lock(&rma_lock);
+	if (!list_empty(&free_rmas)) {
+		ri = list_first_entry(&free_rmas, struct kvmppc_rma_info, list);
+		list_del(&ri->list);
+		atomic_inc(&ri->use_count);
+	}
+	spin_unlock(&rma_lock);
+	return ri;
+}
+EXPORT_SYMBOL_GPL(kvm_alloc_rma);
+
+void kvm_release_rma(struct kvmppc_rma_info *ri)
+{
+	if (atomic_dec_and_test(&ri->use_count)) {
+		spin_lock(&rma_lock);
+		list_add_tail(&ri->list, &free_rmas);
+		spin_unlock(&rma_lock);
+
+	}
+}
+EXPORT_SYMBOL_GPL(kvm_release_rma);
+
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index c9bf177..9ee223c 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -235,10 +235,10 @@ kvmppc_hv_entry:
 	bne	21b
 
 	/* Primary thread switches to guest partition. */
+	ld	r9,VCPU_KVM(r4)		/* pointer to struct kvm */
 	lwz	r6,VCPU_PTID(r4)
 	cmpwi	r6,0
 	bne	20f
-	ld	r9,VCPU_KVM(r4)		/* pointer to struct kvm */
 	ld	r6,KVM_SDR1(r9)
 	lwz	r7,KVM_LPID(r9)
 	li	r0,LPID_RSVD		/* switch to reserved LPID */
@@ -255,8 +255,18 @@ kvmppc_hv_entry:
 20:	lbz	r0,VCORE_IN_GUEST(r5)
 	cmpwi	r0,0
 	beq	20b
-10:	ld	r8,VCPU_LPCR(r4)
-	mtspr	SPRN_LPCR,r8
+
+	/* Set LPCR.  Set the MER bit if there is a pending external irq. */
+10:	ld	r8,KVM_LPCR(r9)
+	ld	r0,VCPU_PENDING_EXC(r4)
+	li	r7,(1 << BOOK3S_IRQPRIO_EXTERNAL)
+	oris	r7,r7,(1 << BOOK3S_IRQPRIO_EXTERNAL_LEVEL)@h
+	and.	r0,r0,r7
+	beq	11f
+	ori	r8,r8,LPCR_MER
+11:	mtspr	SPRN_LPCR,r8
+	ld	r8,KVM_RMOR(r9)
+	mtspr	SPRN_RMOR,r8
 	isync
 
 	/* Check if HDEC expires soon */
@@ -464,7 +474,8 @@ hcall_real_cont:
 	/* Check for mediated interrupts (could be done earlier really ...) */
 	cmpwi	r12,BOOK3S_INTERRUPT_EXTERNAL
 	bne+	1f
-	ld	r5,VCPU_LPCR(r9)
+	ld	r5,VCPU_KVM(r9)
+	ld	r5,KVM_LPCR(r5)
 	andi.	r0,r11,MSR_EE
 	beq	1f
 	andi.	r0,r5,LPCR_MER
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 4c54966..72c5065 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -211,6 +211,9 @@ int kvm_dev_ioctl_check_extension(long ext)
 	case KVM_CAP_PPC_SMT:
 		r = threads_per_core;
 		break;
+	case KVM_CAP_PPC_RMA:
+		r = 1;
+		break;
 #endif
 	default:
 		r = 0;
@@ -673,6 +676,16 @@ long kvm_arch_vm_ioctl(struct file *filp,
 		r = kvm_vm_ioctl_create_spapr_tce(kvm, &create_tce);
 		goto out;
 	}
+
+	case KVM_ALLOCATE_RMA: {
+		struct kvm *kvm = filp->private_data;
+		struct kvm_allocate_rma rma;
+
+		r = kvm_vm_ioctl_allocate_rma(kvm, &rma);
+		if (r >= 0 && copy_to_user(argp, &rma, sizeof(rma)))
+			r = -EFAULT;
+		break;
+	}
 #endif /* CONFIG_KVM_BOOK3S_64_HV */
 
 	default:
diff --git a/include/linux/kvm.h b/include/linux/kvm.h
index e2a378d..2c366b5 100644
--- a/include/linux/kvm.h
+++ b/include/linux/kvm.h
@@ -552,6 +552,7 @@ struct kvm_ppc_pvinfo {
 #define KVM_CAP_PPC_BOOKE_SREGS 62
 #define KVM_CAP_SPAPR_TCE 63
 #define KVM_CAP_PPC_SMT 64
+#define KVM_CAP_PPC_RMA	65
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -755,6 +756,8 @@ struct kvm_clock_data {
 #define KVM_GET_XCRS		  _IOR(KVMIO,  0xa6, struct kvm_xcrs)
 #define KVM_SET_XCRS		  _IOW(KVMIO,  0xa7, struct kvm_xcrs)
 #define KVM_CREATE_SPAPR_TCE	  _IOW(KVMIO,  0xa8, struct kvm_create_spapr_tce)
+/* Available with KVM_CAP_RMA */
+#define KVM_ALLOCATE_RMA	  _IOR(KVMIO,  0xa9, struct kvm_allocate_rma)
 
 #define KVM_DEV_ASSIGN_ENABLE_IOMMU	(1 << 0)
 
-- 
1.7.5.4
