Return-Path: <paulus@ozlabs.org>
Date: Wed, 29 Jun 2011 20:41:03 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
	Alexander Graf <agraf@suse.de>
Subject: [RFC PATCH 17/17] KVM: PPC: Add an ioctl for userspace to select
	which platform to emulate
Message-ID: <20110629104103.GR25406@bloggs.ozlabs.ibm.com>
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

This new ioctl allows userspace to specify what paravirtualization
interface (if any) KVM should implement, what architecture version
the guest virtual processors should conform to, and whether the guest
can be permitted to use a real supervisor mode.

At present the only effect of the ioctl is to indicate whether the
requested emulation is available, but in future it may be used to
select between different emulation techniques (book3s_pr vs. book3s_hv)
or set the CPU compatibility mode for the guest.

If book3s_pr KVM is enabled in the kernel config, then this new
ioctl accepts platform values of KVM_PPC_PV_NONE and KVM_PPC_PV_KVM,
but not KVM_PPC_PV_SPAPR.  If book3s_hv KVM is enabled, then this
ioctl requires that the platform is KVM_PPC_PV_SPAPR and the
guest_arch field contains one of 201 or 206 (for architecture versions
2.01 and 2.06) -- when running on a PPC970, it must contain 201, and
when running on a POWER7, it must contain 206.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 Documentation/virtual/kvm/api.txt   |   35 +++++++++++++++++++++++++++++++++++
 arch/powerpc/include/asm/kvm.h      |   15 +++++++++++++++
 arch/powerpc/include/asm/kvm_host.h |    1 +
 arch/powerpc/kvm/powerpc.c          |   28 ++++++++++++++++++++++++++++
 include/linux/kvm.h                 |    1 +
 5 files changed, 80 insertions(+), 0 deletions(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index b0e4b9c..3ab012c 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -1430,6 +1430,41 @@ is supported; 2 if the processor requires all virtual machines to have
 an RMA, or 1 if the processor can use an RMA but doesn't require it,
 because it supports the Virtual RMA (VRMA) facility.
 
+4.64 KVM_PPC_SET_PLATFORM
+
+Capability: none
+Architectures: powerpc
+Type: vm ioctl
+Parameters: struct kvm_ppc_set_platform (in)
+Returns: 0, or -1 on error
+
+This is used by userspace to tell KVM what sort of platform it should
+emulate.  The return value of the ioctl tells userspace whether the
+emulation it is requesting is supported by KVM.
+
+struct kvm_ppc_set_platform {
+	__u16 platform;		/* defines the OS/hypervisor ABI */
+	__u16 guest_arch;	/* e.g. decimal 206 for v2.06 */
+	__u32 flags;
+};
+
+/* Values for platform */
+#define KVM_PPC_PV_NONE		0	/* bare-metal, non-paravirtualized */
+#define KVM_PPC_PV_KVM		1	/* as defined in kvm_para.h */
+#define KVM_PPC_PV_SPAPR	2	/* IBM Server PAPR (a la PowerVM) */
+
+/* Values for flags */
+#define KVM_PPC_CROSS_ARCH	1	/* guest architecture != host */
+
+The KVM_PPC_CROSS_ARCH bit being 1 indicates that the guest is of a
+sufficiently different architecture to the host that the guest cannot
+be permitted to use supervisor mode.  For example, if the host is a
+64-bit machine and the guest is a 32-bit machine, then this bit should
+be set.
+
+The return value is 0 if KVM supports the requested emulation, or -1
+with errno == EINVAL if not.
+
 5. The kvm_run structure
 
 Application code obtains a pointer to the kvm_run structure by
diff --git a/arch/powerpc/include/asm/kvm.h b/arch/powerpc/include/asm/kvm.h
index a4f6c85..0dd5cfb 100644
--- a/arch/powerpc/include/asm/kvm.h
+++ b/arch/powerpc/include/asm/kvm.h
@@ -287,4 +287,19 @@ struct kvm_allocate_rma {
 	__u64 rma_size;
 };
 
+/* for KVM_PPC_SET_PLATFORM */
+struct kvm_ppc_set_platform {
+	__u16 platform;		/* defines the OS/hypervisor ABI */
+	__u16 guest_arch;	/* e.g. decimal 206 for v2.06 */
+	__u32 flags;
+};
+
+/* Values for platform */
+#define KVM_PPC_PV_NONE		0	/* bare-metal, non-paravirtualized */
+#define KVM_PPC_PV_KVM		1	/* as defined in kvm_para.h */
+#define KVM_PPC_PV_SPAPR	2	/* IBM Server PAPR (a la PowerVM) */
+
+/* Values for flags */
+#define KVM_PPC_CROSS_ARCH	1	/* guest architecture != host */
+
 #endif /* __LINUX_KVM_POWERPC_H */
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index cc22b28..00e7f1b 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -167,6 +167,7 @@ struct kvmppc_rma_info {
 };
 
 struct kvm_arch {
+	struct kvm_ppc_set_platform platform;
 #ifdef CONFIG_KVM_BOOK3S_64_HV
 	unsigned long hpt_virt;
 	unsigned long ram_npages;
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index a107c9b..83265cd 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -690,6 +690,34 @@ long kvm_arch_vm_ioctl(struct file *filp,
 		break;
 	}
 #endif /* CONFIG_KVM_BOOK3S_64_HV */
+	case KVM_PPC_SET_PLATFORM: {
+		struct kvm_ppc_set_platform plat;
+		struct kvm *kvm = filp->private_data;
+
+		r = -EFAULT;
+		if (copy_from_user(&plat, argp, sizeof(plat)))
+			goto out;
+		r = -EINVAL;
+#ifdef CONFIG_KVM_BOOK3S_64_HV
+		if (plat.platform != KVM_PPC_PV_SPAPR || plat.flags)
+			goto out;
+		/* requested guest arch must match real CPU */
+		if (!((plat.guest_arch == 201 &&
+		       cpu_has_feature(CPU_FTR_ARCH_201)) ||
+		      (plat.guest_arch == 206 &&
+		       cpu_has_feature(CPU_FTR_ARCH_206))))
+			goto out;
+#else
+		if (plat.flags & ~KVM_PPC_CROSS_ARCH)
+			goto out;
+		if (plat.platform != KVM_PPC_PV_NONE &&
+		    plat.platform != KVM_PPC_PV_KVM)
+			goto out;
+#endif
+		kvm->arch.platform = plat;
+		r = 0;
+		break;
+	}
 
 	default:
 		r = -ENOTTY;
diff --git a/include/linux/kvm.h b/include/linux/kvm.h
index 2c366b5..e6258e7 100644
--- a/include/linux/kvm.h
+++ b/include/linux/kvm.h
@@ -758,6 +758,7 @@ struct kvm_clock_data {
 #define KVM_CREATE_SPAPR_TCE	  _IOW(KVMIO,  0xa8, struct kvm_create_spapr_tce)
 /* Available with KVM_CAP_RMA */
 #define KVM_ALLOCATE_RMA	  _IOR(KVMIO,  0xa9, struct kvm_allocate_rma)
+#define KVM_PPC_SET_PLATFORM	  _IOR(KVMIO,  0xaa, struct kvm_ppc_set_platform)
 
 #define KVM_DEV_ASSIGN_ENABLE_IOMMU	(1 << 0)
 
-- 
1.7.5.4
