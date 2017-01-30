Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vBlnC4WTYzDq9s
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jan 2017 21:22:07 +1100 (AEDT)
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org,
	kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH v2 08/20] KVM: PPC: Book3S HV: Add userspace interfaces for
 POWER9 MMU
Date: Mon, 30 Jan 2017 21:21:41 +1100
Message-Id: <1485771713-24801-9-git-send-email-paulus@ozlabs.org>
In-Reply-To: <1485771713-24801-1-git-send-email-paulus@ozlabs.org>
References: <1485771713-24801-1-git-send-email-paulus@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds two capabilities and two ioctls to allow userspace to
find out about and configure the POWER9 MMU in a guest.  The two
capabilities tell userspace whether KVM can support a guest using
the radix MMU, or using the hashed page table (HPT) MMU with a
process table and segment tables.  (Note that the MMUs in the
POWER9 processor cores do not use the process and segment tables
when in HPT mode, but the nest MMU does).

The KVM_PPC_CONFIGURE_V3_MMU ioctl allows userspace to specify
whether a guest will use the radix MMU or the HPT MMU, and to
specify the size and location (in guest space) of the process
table.

The KVM_PPC_GET_RMMU_INFO ioctl gives userspace information about
the radix MMU.  It returns a list of supported radix tree geometries
(base page size and number of bits indexed at each level of the
radix tree) and the encoding used to specify the various page
sizes for the TLB invalidate entry instruction.

Initially, both capabilities return 0 and the ioctls return -EINVAL,
until the necessary infrastructure for them to operate correctly
is added.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 Documentation/virtual/kvm/api.txt   | 83 +++++++++++++++++++++++++++++++++++++
 arch/powerpc/include/asm/kvm_ppc.h  |  2 +
 arch/powerpc/include/uapi/asm/kvm.h | 20 +++++++++
 arch/powerpc/kvm/book3s_hv.c        | 13 ++++++
 arch/powerpc/kvm/powerpc.c          | 32 ++++++++++++++
 include/uapi/linux/kvm.h            |  6 +++
 6 files changed, 156 insertions(+)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 03145b7..4470671 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -3201,6 +3201,71 @@ struct kvm_reinject_control {
 pit_reinject = 0 (!reinject mode) is recommended, unless running an old
 operating system that uses the PIT for timing (e.g. Linux 2.4.x).
 
+4.99 KVM_PPC_CONFIGURE_V3_MMU
+
+Capability: KVM_CAP_PPC_RADIX_MMU or KVM_CAP_PPC_HASH_MMU_V3
+Architectures: ppc
+Type: vm ioctl
+Parameters: struct kvm_ppc_mmuv3_cfg (in)
+Returns: 0 on success,
+         -EFAULT if struct kvm_ppc_mmuv3_cfg cannot be read,
+         -EINVAL if the configuration is invalid
+
+This ioctl controls whether the guest will use radix or HPT (hashed
+page table) translation, and sets the pointer to the process table for
+the guest.
+
+struct kvm_ppc_mmuv3_cfg {
+	__u64	flags;
+	__u64	process_table;
+};
+
+There are two bits that can be set in flags; KVM_PPC_MMUV3_RADIX and
+KVM_PPC_MMUV3_GTSE.  KVM_PPC_MMUV3_RADIX, if set, configures the guest
+to use radix tree translation, and if clear, to use HPT translation.
+KVM_PPC_MMUV3_GTSE, if set and if KVM permits it, configures the guest
+to be able to use the global TLB and SLB invalidation instructions;
+if clear, the guest may not use these instructions.
+
+The process_table field specifies the address and size of the guest
+process table, which is in the guest's space.  This field is formatted
+as the second doubleword of the partition table entry, as defined in
+the Power ISA V3.00, Book III section 5.7.6.1.
+
+4.100 KVM_PPC_GET_RMMU_INFO
+
+Capability: KVM_CAP_PPC_RADIX_MMU
+Architectures: ppc
+Type: vm ioctl
+Parameters: struct kvm_ppc_rmmu_info (out)
+Returns: 0 on success,
+	 -EFAULT if struct kvm_ppc_rmmu_info cannot be written,
+	 -EINVAL if no useful information can be returned
+
+This ioctl returns a structure containing two things: (a) a list
+containing supported radix tree geometries, and (b) a list that maps
+page sizes to put in the "AP" (actual page size) field for the tlbie
+(TLB invalidate entry) instruction.
+
+struct kvm_ppc_rmmu_info {
+	struct kvm_ppc_radix_geom {
+		__u8	page_shift;
+		__u8	level_bits[4];
+		__u8	pad[3];
+	}	geometries[8];
+	__u32	ap_encodings[8];
+};
+
+The geometries[] field gives up to 8 supported geometries for the
+radix page table, in terms of the log base 2 of the smallest page
+size, and the number of bits indexed at each level of the tree, from
+the PTE level up to the PGD level in that order.  Any unused entries
+will have 0 in the page_shift field.
+
+The ap_encodings gives the supported page sizes and their AP field
+encodings, encoded with the AP value in the top 3 bits and the log
+base 2 of the page size in the bottom 6 bits.
+
 5. The kvm_run structure
 ------------------------
 
@@ -3942,3 +4007,21 @@ In order to use SynIC, it has to be activated by setting this
 capability via KVM_ENABLE_CAP ioctl on the vcpu fd. Note that this
 will disable the use of APIC hardware virtualization even if supported
 by the CPU, as it's incompatible with SynIC auto-EOI behavior.
+
+8.3 KVM_CAP_PPC_RADIX_MMU
+
+Architectures: ppc
+
+This capability, if KVM_CHECK_EXTENSION indicates that it is
+available, means that that the kernel can support guests using the
+radix MMU defined in Power ISA V3.00 (as implemented in the POWER9
+processor).
+
+8.4 KVM_CAP_PPC_HASH_MMU_V3
+
+Architectures: ppc
+
+This capability, if KVM_CHECK_EXTENSION indicates that it is
+available, means that that the kernel can support guests using the
+hashed page table MMU defined in Power ISA V3.00 (as implemented in
+the POWER9 processor), including in-memory segment tables.
diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index 2da67bf..48c760f 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -291,6 +291,8 @@ struct kvmppc_ops {
 				       struct irq_bypass_producer *);
 	void (*irq_bypass_del_producer)(struct irq_bypass_consumer *,
 					struct irq_bypass_producer *);
+	int (*configure_mmu)(struct kvm *kvm, struct kvm_ppc_mmuv3_cfg *cfg);
+	int (*get_rmmu_info)(struct kvm *kvm, struct kvm_ppc_rmmu_info *info);
 };
 
 extern struct kvmppc_ops *kvmppc_hv_ops;
diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
index 3603b6f..cc0908b 100644
--- a/arch/powerpc/include/uapi/asm/kvm.h
+++ b/arch/powerpc/include/uapi/asm/kvm.h
@@ -413,6 +413,26 @@ struct kvm_get_htab_header {
 	__u16	n_invalid;
 };
 
+/* For KVM_PPC_CONFIGURE_V3_MMU */
+struct kvm_ppc_mmuv3_cfg {
+	__u64	flags;
+	__u64	process_table;	/* second doubleword of partition table entry */
+};
+
+/* Flag values for KVM_PPC_CONFIGURE_V3_MMU */
+#define KVM_PPC_MMUV3_RADIX	1	/* 1 = radix mode, 0 = HPT */
+#define KVM_PPC_MMUV3_GTSE	2	/* global translation shootdown enb. */
+
+/* For KVM_PPC_GET_RMMU_INFO */
+struct kvm_ppc_rmmu_info {
+	struct kvm_ppc_radix_geom {
+		__u8	page_shift;
+		__u8	level_bits[4];
+		__u8	pad[3];
+	}	geometries[8];
+	__u32	ap_encodings[8];
+};
+
 /* Per-vcpu XICS interrupt controller state */
 #define KVM_REG_PPC_ICP_STATE	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0x8c)
 
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index ec34e39..5f08ed0 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -3657,6 +3657,17 @@ static void init_default_hcalls(void)
 	}
 }
 
+/* dummy implementations for now */
+static int kvmhv_configure_mmu(struct kvm *kvm, struct kvm_ppc_mmuv3_cfg *cfg)
+{
+	return -EINVAL;
+}
+
+static int kvmhv_get_rmmu_info(struct kvm *kvm, struct kvm_ppc_rmmu_info *info)
+{
+	return -EINVAL;
+}
+
 static struct kvmppc_ops kvm_ops_hv = {
 	.get_sregs = kvm_arch_vcpu_ioctl_get_sregs_hv,
 	.set_sregs = kvm_arch_vcpu_ioctl_set_sregs_hv,
@@ -3694,6 +3705,8 @@ static struct kvmppc_ops kvm_ops_hv = {
 	.irq_bypass_add_producer = kvmppc_irq_bypass_add_producer_hv,
 	.irq_bypass_del_producer = kvmppc_irq_bypass_del_producer_hv,
 #endif
+	.configure_mmu = kvmhv_configure_mmu,
+	.get_rmmu_info = kvmhv_get_rmmu_info,
 };
 
 static int kvm_init_subcore_bitmap(void)
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index cd892de..38c0d15 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -565,6 +565,13 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_PPC_HWRNG:
 		r = kvmppc_hwrng_present();
 		break;
+	case KVM_CAP_PPC_MMU_RADIX:
+		r = !!(0 && hv_enabled && radix_enabled());
+		break;
+	case KVM_CAP_PPC_MMU_HASH_V3:
+		r = !!(0 && hv_enabled && !radix_enabled() &&
+		       cpu_has_feature(CPU_FTR_ARCH_300));
+		break;
 #endif
 	case KVM_CAP_SYNC_MMU:
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
@@ -1468,6 +1475,31 @@ long kvm_arch_vm_ioctl(struct file *filp,
 		r = kvm_vm_ioctl_rtas_define_token(kvm, argp);
 		break;
 	}
+	case KVM_PPC_CONFIGURE_V3_MMU: {
+		struct kvm *kvm = filp->private_data;
+		struct kvm_ppc_mmuv3_cfg cfg;
+
+		r = -EINVAL;
+		if (!kvm->arch.kvm_ops->configure_mmu)
+			goto out;
+		r = -EFAULT;
+		if (copy_from_user(&cfg, argp, sizeof(cfg)))
+			goto out;
+		r = kvm->arch.kvm_ops->configure_mmu(kvm, &cfg);
+		break;
+	}
+	case KVM_PPC_GET_RMMU_INFO: {
+		struct kvm *kvm = filp->private_data;
+		struct kvm_ppc_rmmu_info info;
+
+		r = -EINVAL;
+		if (!kvm->arch.kvm_ops->get_rmmu_info)
+			goto out;
+		r = kvm->arch.kvm_ops->get_rmmu_info(kvm, &info);
+		if (r >= 0 && copy_to_user(argp, &info, sizeof(info)))
+			r = -EFAULT;
+		break;
+	}
 	default: {
 		struct kvm *kvm = filp->private_data;
 		r = kvm->arch.kvm_ops->arch_vm_ioctl(filp, ioctl, arg);
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index cac48ed..e003580 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -871,6 +871,8 @@ struct kvm_ppc_smmu_info {
 #define KVM_CAP_S390_USER_INSTR0 130
 #define KVM_CAP_MSI_DEVID 131
 #define KVM_CAP_PPC_HTM 132
+#define KVM_CAP_PPC_MMU_RADIX 134
+#define KVM_CAP_PPC_MMU_HASH_V3 135
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -1187,6 +1189,10 @@ struct kvm_s390_ucas_mapping {
 #define KVM_ARM_SET_DEVICE_ADDR	  _IOW(KVMIO,  0xab, struct kvm_arm_device_addr)
 /* Available with KVM_CAP_PPC_RTAS */
 #define KVM_PPC_RTAS_DEFINE_TOKEN _IOW(KVMIO,  0xac, struct kvm_rtas_token_args)
+/* Available with KVM_CAP_PPC_RADIX_MMU or KVM_CAP_PPC_HASH_MMU_V3 */
+#define KVM_PPC_CONFIGURE_V3_MMU  _IOW(KVMIO,  0xaf, struct kvm_ppc_mmuv3_cfg)
+/* Available with KVM_CAP_PPC_RADIX_MMU */
+#define KVM_PPC_GET_RMMU_INFO	  _IOW(KVMIO,  0xb0, struct kvm_ppc_rmmu_info)
 
 /* ioctl for vm fd */
 #define KVM_CREATE_DEVICE	  _IOWR(KVMIO,  0xe0, struct kvm_create_device)
-- 
2.7.4
