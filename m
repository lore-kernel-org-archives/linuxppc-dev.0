Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tzfzf099bzDqWX
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jan 2017 20:07:42 +1100 (AEDT)
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org,
	kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH 10/18] KVM: PPC: Book3S HV: Set process table for HPT guests
 on POWER9
Date: Thu, 12 Jan 2017 20:07:18 +1100
Message-Id: <1484212046-29591-11-git-send-email-paulus@ozlabs.org>
In-Reply-To: <1484212046-29591-1-git-send-email-paulus@ozlabs.org>
References: <1484212046-29591-1-git-send-email-paulus@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds the implementation of the KVM_PPC_CONFIGURE_V3_MMU ioctl
for HPT guests on POWER9.  With this, we can return 1 for the
KVM_CAP_PPC_MMU_HASH_V3 capability.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/include/asm/kvm_host.h |  1 +
 arch/powerpc/kvm/book3s_hv.c        | 35 +++++++++++++++++++++++++++++++----
 arch/powerpc/kvm/powerpc.c          |  2 +-
 3 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index e59b172..944532d 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -264,6 +264,7 @@ struct kvm_arch {
 	atomic_t hpte_mod_interest;
 	cpumask_t need_tlb_flush;
 	int hpt_cma_alloc;
+	u64 process_table;
 	struct dentry *debugfs_dir;
 	struct dentry *htab_dentry;
 #endif /* CONFIG_KVM_BOOK3S_HV_POSSIBLE */
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 1736f87..6bd0f4a 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -3092,8 +3092,8 @@ static void kvmppc_setup_partition_table(struct kvm *kvm)
 	/* HTABSIZE and HTABORG fields */
 	dw0 |= kvm->arch.sdr1;
 
-	/* Second dword has GR=0; other fields are unused since UPRT=0 */
-	dw1 = 0;
+	/* Second dword as set by userspace */
+	dw1 = kvm->arch.process_table;
 
 	mmu_partition_table_set_entry(kvm->arch.lpid, dw0, dw1);
 }
@@ -3658,10 +3658,37 @@ static void init_default_hcalls(void)
 	}
 }
 
-/* dummy implementations for now */
 static int kvmhv_configure_mmu(struct kvm *kvm, struct kvm_ppc_mmuv3_cfg *cfg)
 {
-	return -EINVAL;
+	unsigned long lpcr;
+
+	/* If not on a POWER9, reject it */
+	if (!cpu_has_feature(CPU_FTR_ARCH_300))
+		return -ENODEV;
+
+	/* If any unknown flags set, reject it */
+	if (cfg->flags & ~(KVM_PPC_MMUV3_RADIX | KVM_PPC_MMUV3_GTSE))
+		return -EINVAL;
+
+	/* We can't do radix yet */
+	if (cfg->flags & KVM_PPC_MMUV3_RADIX)
+		return -EINVAL;
+
+	/* GR (guest radix) bit in process_table field must match */
+	if (cfg->process_table & PATB_GR)
+		return -EINVAL;
+
+	/* Process table size field must be reasonable, i.e. <= 24 */
+	if ((cfg->process_table & PRTS_MASK) > 24)
+		return -EINVAL;
+
+	kvm->arch.process_table = cfg->process_table;
+	kvmppc_setup_partition_table(kvm);
+
+	lpcr = (cfg->flags & KVM_PPC_MMUV3_GTSE) ? LPCR_GTSE : 0;
+	kvmppc_update_lpcr(kvm, lpcr, LPCR_GTSE);
+
+	return 0;
 }
 
 static int kvmhv_get_rmmu_info(struct kvm *kvm, struct kvm_ppc_rmmu_info *info)
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 38c0d15..1476a48 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -569,7 +569,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		r = !!(0 && hv_enabled && radix_enabled());
 		break;
 	case KVM_CAP_PPC_MMU_HASH_V3:
-		r = !!(0 && hv_enabled && !radix_enabled() &&
+		r = !!(hv_enabled && !radix_enabled() &&
 		       cpu_has_feature(CPU_FTR_ARCH_300));
 		break;
 #endif
-- 
2.7.4
