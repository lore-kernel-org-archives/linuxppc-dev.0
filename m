Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F08751A0019
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Jul 2014 15:07:11 +1000 (EST)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Mon, 7 Jul 2014 23:07:09 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id EEA763E40045
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Jul 2014 23:07:07 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (b03eismtpcl100.ahe.boulder.ibm.com
 [9.17.195.167])
 by b03cxnp08027.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6855w6h7995668
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Jul 2014 07:05:58 +0200
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s685776A010069
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Jul 2014 23:07:07 -0600
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, paulus@samba.org, kvm-ppc@vger.kernel.org
Subject: [PATCH v2] Use the POWER8 Micro Partition Prefetch Engine in KVM HV
 on POWER8
Date: Tue,  8 Jul 2014 15:06:28 +1000
Message-Id: <1404795988-9892-1-git-send-email-stewart@linux.vnet.ibm.com>
In-Reply-To: <1404437035-4336-1-git-send-email-stewart@linux.vnet.ibm.com>
References: <1404437035-4336-1-git-send-email-stewart@linux.vnet.ibm.com>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The POWER8 processor has a Micro Partition Prefetch Engine, which is
a fancy way of saying "has way to store and load contents of L2 or
L2+MRU way of L3 cache". We initiate the storing of the log (list of
addresses) using the logmpp instruction and start restore by writing
to a SPR.

The logmpp instruction takes parameters in a single 64bit register:
- starting address of the table to store log of L2/L2+L3 cache contents
  - 32kb for L2
  - 128kb for L2+L3
  - Aligned relative to maximum size of the table (32kb or 128kb)
- Log control (no-op, L2 only, L2 and L3, abort logout)

We should abort any ongoing logging before initiating one.

To initiate restore, we write to the MPPR SPR. The format of what to write
to the SPR is similar to the logmpp instruction parameter:
- starting address of the table to read from (same alignment requirements)
- table size (no data, until end of table)
- prefetch rate (from fastest possible to slower. about every 8, 16, 24 or
  32 cycles)

The idea behind loading and storing the contents of L2/L3 cache is to
reduce memory latency in a system that is frequently swapping vcores on
a physical CPU.

The best case scenario for doing this is when some vcores are doing very
cache heavy workloads. The worst case is when they have about 0 cache hits,
so we just generate needless memory operations.

This implementation just does L2 store/load. In my benchmarks this proves
to be useful.

Benchmark 1:
 - 16 core POWER8
 - 3x Ubuntu 14.04LTS guests (LE) with 8 VCPUs each
 - No split core/SMT
 - two guests running sysbench memory test.
   sysbench --test=memory --num-threads=8 run
 - one guest running apache bench (of default HTML page)
   ab -n 490000 -c 400 http://localhost/

This benchmark aims to measure performance of real world application (apache)
where other guests are cache hot with their own workloads. The sysbench memory
benchmark does pointer sized writes to a (small) memory buffer in a loop.

In this benchmark with this patch I can see an improvement both in requests
per second (~5%) and in mean and median response times (again, about 5%).
The spread of minimum and maximum response times were largely unchanged.

benchmark 2:
 - Same VM config as benchmark 1
 - all three guests running sysbench memory benchmark

This benchmark aims to see if there is a positive or negative affect to this
cache heavy benchmark. Although due to the nature of the benchmark (stores) we
may not see a difference in performance, but rather hopefully an improvement
in consistency of performance (when vcore switched in, don't have to wait
many times for cachelines to be pulled in)

The results of this benchmark are improvements in consistency of performance
rather than performance itself. With this patch, the few outliers in duration
go away and we get more consistent performance in each guest.

benchmark 3:
 - same 3 guests and CPU configuration as benchmark 1 and 2.
 - two idle guests
 - 1 guest running STREAM benchmark

This scenario also saw performance improvement with this patch. On Copy and
Scale workloads from STREAM, I got 5-6% improvement with this patch. For
Add and triad, it was around 10% (or more).

benchmark 4:
 - same 3 guests as previous benchmarks
 - two guests running sysbench --memory, distinctly different cache heavy
   workload
 - one guest running STREAM benchmark.

Similar improvements to benchmark 3.

benchmark 5:
 - 1 guest, 8 VCPUs, Ubuntu 14.04
 - Host configured with split core (SMT8, subcores-per-core=4)
 - STREAM benchmark

In this benchmark, we see a 10-20% performance improvement across the board
of STREAM benchmark results with this patch.

Based on preliminary investigation and microbenchmarks
by Prerna Saxena <prerna@linux.vnet.ibm.com>

Signed-off-by: Stewart Smith <stewart@linux.vnet.ibm.com>

--
changes since v1:
- s/mppe/mpp_buffer/
- add MPP_BUFFER_ORDER define.
---
 arch/powerpc/include/asm/kvm_host.h   |    1 +
 arch/powerpc/include/asm/ppc-opcode.h |   10 ++++++
 arch/powerpc/include/asm/reg.h        |    1 +
 arch/powerpc/kvm/book3s_hv.c          |   54 ++++++++++++++++++++++++++++++++-
 4 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 1eaea2d..83ed249 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -305,6 +305,7 @@ struct kvmppc_vcore {
 	u32 arch_compat;
 	ulong pcr;
 	ulong dpdes;		/* doorbell state (POWER8) */
+	unsigned long mpp_buffer; /* Micro Partition Prefetch buffer */
 };
 
 #define VCORE_ENTRY_COUNT(vc)	((vc)->entry_exit_count & 0xff)
diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index 3132bb9..6201440 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -139,6 +139,7 @@
 #define PPC_INST_ISEL			0x7c00001e
 #define PPC_INST_ISEL_MASK		0xfc00003e
 #define PPC_INST_LDARX			0x7c0000a8
+#define PPC_INST_LOGMPP			0x7c0007e4
 #define PPC_INST_LSWI			0x7c0004aa
 #define PPC_INST_LSWX			0x7c00042a
 #define PPC_INST_LWARX			0x7c000028
@@ -275,6 +276,13 @@
 #define __PPC_EH(eh)	0
 #endif
 
+/* POWER8 Micro Partition Prefetch parameters */
+#define PPC_MPPE_ADDRESS_MASK 0xffffffffc000
+#define PPC_MPPE_WHOLE_TABLE (0x2ULL << 60)
+#define PPC_MPPE_LOG_L2 (0x02ULL << 54)
+#define PPC_MPPE_LOG_L2L3 (0x01ULL << 54)
+#define PPC_MPPE_LOG_ABORT (0x03ULL << 54)
+
 /* Deal with instructions that older assemblers aren't aware of */
 #define	PPC_DCBAL(a, b)		stringify_in_c(.long PPC_INST_DCBAL | \
 					__PPC_RA(a) | __PPC_RB(b))
@@ -283,6 +291,8 @@
 #define PPC_LDARX(t, a, b, eh)	stringify_in_c(.long PPC_INST_LDARX | \
 					___PPC_RT(t) | ___PPC_RA(a) | \
 					___PPC_RB(b) | __PPC_EH(eh))
+#define PPC_LOGMPP(b)		stringify_in_c(.long PPC_INST_LOGMPP | \
+					__PPC_RB(b))
 #define PPC_LWARX(t, a, b, eh)	stringify_in_c(.long PPC_INST_LWARX | \
 					___PPC_RT(t) | ___PPC_RA(a) | \
 					___PPC_RB(b) | __PPC_EH(eh))
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index e5d2e0b..5164beb 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -224,6 +224,7 @@
 #define   CTRL_TE	0x00c00000	/* thread enable */
 #define   CTRL_RUNLATCH	0x1
 #define SPRN_DAWR	0xB4
+#define SPRN_MPPR	0xB8	/* Micro Partition Prefetch Register */
 #define SPRN_CIABR	0xBB
 #define   CIABR_PRIV		0x3
 #define   CIABR_PRIV_USER	1
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 8227dba..41dab67 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -67,6 +67,13 @@
 /* Used as a "null" value for timebase values */
 #define TB_NIL	(~(u64)0)
 
+#if defined(CONFIG_PPC_64K_PAGES)
+#define MPP_BUFFER_ORDER	0
+#elif defined(CONFIG_PPC_4K_PAGES)
+#define MPP_BUFFER_ORDER	4
+#endif
+
+
 static void kvmppc_end_cede(struct kvm_vcpu *vcpu);
 static int kvmppc_hv_setup_htab_rma(struct kvm_vcpu *vcpu);
 
@@ -1528,6 +1535,7 @@ static void kvmppc_run_core(struct kvmppc_vcore *vc)
 	int i, need_vpa_update;
 	int srcu_idx;
 	struct kvm_vcpu *vcpus_to_update[threads_per_core];
+	phys_addr_t phy_addr, tmp;
 
 	/* don't start if any threads have a signal pending */
 	need_vpa_update = 0;
@@ -1590,9 +1598,48 @@ static void kvmppc_run_core(struct kvmppc_vcore *vc)
 
 	srcu_idx = srcu_read_lock(&vc->kvm->srcu);
 
+	/* If we have a saved list of L2/L3, restore it */
+	if (cpu_has_feature(CPU_FTR_ARCH_207S) && vc->mpp_buffer) {
+		phy_addr = virt_to_phys((void *)vc->mpp_buffer);
+#if defined(CONFIG_PPC_4K_PAGES)
+		phy_addr = (phy_addr + 8*4096) & ~(8*4096);
+#endif
+		tmp = phy_addr & PPC_MPPE_ADDRESS_MASK;
+		tmp = tmp | PPC_MPPE_WHOLE_TABLE;
+
+		/* For sanity, abort any 'save' requests in progress */
+		asm volatile(PPC_LOGMPP(R1) : : "r" (tmp));
+
+		/* Inititate a cache-load request */
+		mtspr(SPRN_MPPR, tmp);
+	}
+
+	/* Allocate memory before switching out of guest so we don't
+	   trash L2/L3 with memory allocation stuff */
+	if (cpu_has_feature(CPU_FTR_ARCH_207S) && !vc->mpp_buffer) {
+		vc->mpp_buffer = __get_free_pages(GFP_KERNEL|__GFP_ZERO,
+						  MPP_BUFFER_ORDER);
+	}
+
 	__kvmppc_vcore_entry();
 
 	spin_lock(&vc->lock);
+
+	if (cpu_has_feature(CPU_FTR_ARCH_207S) && vc->mpp_buffer) {
+		phy_addr = (phys_addr_t)virt_to_phys((void *)vc->mpp_buffer);
+#if defined(CONFIG_PPC_4K_PAGES)
+		phy_addr = (phy_addr + 8*4096) & ~(8*4096);
+#endif
+		tmp = PPC_MPPE_ADDRESS_MASK & phy_addr;
+		tmp = tmp | PPC_MPPE_LOG_L2;
+
+		/* Abort any existing 'fetch' operations for this core */
+		mtspr(SPRN_MPPR, tmp&0x0fffffffffffffff);
+
+		/* Finally, issue logmpp to save cache contents for L2 */
+		asm volatile(PPC_LOGMPP(R1) : : "r" (tmp));
+	}
+
 	/* disable sending of IPIs on virtual external irqs */
 	list_for_each_entry(vcpu, &vc->runnable_threads, arch.run_list)
 		vcpu->cpu = -1;
@@ -2329,8 +2376,13 @@ static void kvmppc_free_vcores(struct kvm *kvm)
 {
 	long int i;
 
-	for (i = 0; i < KVM_MAX_VCORES; ++i)
+	for (i = 0; i < KVM_MAX_VCORES; ++i) {
+		if (kvm->arch.vcores[i] && kvm->arch.vcores[i]->mpp_buffer) {
+			free_pages(kvm->arch.vcores[i]->mpp_buffer,
+				   MPP_BUFFER_ORDER);
+		}
 		kfree(kvm->arch.vcores[i]);
+	}
 	kvm->arch.online_vcores = 0;
 }
 
-- 
1.7.10.4
