Return-Path: <aravinda@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 18D061A028C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jan 2016 18:08:11 +1100 (AEDT)
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5C23514090A
 for <linuxppc-dev@ozlabs.org>; Wed, 13 Jan 2016 18:08:10 +1100 (AEDT)
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aravinda@linux.vnet.ibm.com>;
 Wed, 13 Jan 2016 00:08:08 -0700
Subject: [PATCH v3 1/2] KVM: PPC: New capability to control MCE behaviour
To: gleb@kernel.org, agraf@suse.de, kvm-ppc@vger.kernel.org, paulus@ozlabs.org,
 linuxppc-dev@ozlabs.org, pbonzini@redhat.com
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Cc: mahesh@linux.vnet.ibm.com, david@gibson.dropbear.id.au,
 kvm@vger.kernel.org, mpe@ellerman.id.au
Date: Wed, 13 Jan 2016 12:37:59 +0530
Message-ID: <20160113070759.20248.86252.stgit@aravindap>
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

This patch introduces a new KVM capability to control
how KVM behaves on machine check exception (MCE).
Without this capability, KVM redirects machine check
exceptions to guest's 0x200 vector if the address in
error belongs to the guest. With this capability KVM
causes a guest exit with NMI exit reason.

This is required to avoid problems if a new kernel/KVM
is used with an old QEMU for guests that don't issue
"ibm,nmi-register". As old QEMU does not understand the
NMI exit type, it treats it as a fatal error. However,
the guest could have handled the machine check error
if the exception was delivered to guest's 0x200 interrupt
vector instead of NMI exit in case of old QEMU.

QEMU part can be found at:
http://lists.nongnu.org/archive/html/qemu-ppc/2015-12/msg00199.html

Change Log v3:
  - Split the patch into 2. First patch introduces the
    new capability while the second one enhances KVM to
    redirect MCE.
  - Fix access width bug
  - Rebased to v4.4-rc7

Change Log v2:
  - Added KVM capability

Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/kvm_host.h |    1 +
 arch/powerpc/kernel/asm-offsets.c   |    1 +
 arch/powerpc/kvm/powerpc.c          |    7 +++++++
 include/uapi/linux/kvm.h            |    1 +
 4 files changed, 10 insertions(+)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index cfa758c..9ac2b84 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -243,6 +243,7 @@ struct kvm_arch {
 	int hpt_cma_alloc;
 	struct dentry *debugfs_dir;
 	struct dentry *htab_dentry;
+	u8 fwnmi_enabled;
 #endif /* CONFIG_KVM_BOOK3S_HV_POSSIBLE */
 #ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
 	struct mutex hpt_mutex;
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 221d584..6a4e81a 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -506,6 +506,7 @@ int main(void)
 	DEFINE(KVM_ENABLED_HCALLS, offsetof(struct kvm, arch.enabled_hcalls));
 	DEFINE(KVM_LPCR, offsetof(struct kvm, arch.lpcr));
 	DEFINE(KVM_VRMA_SLB_V, offsetof(struct kvm, arch.vrma_slb_v));
+	DEFINE(KVM_FWNMI, offsetof(struct kvm, arch.fwnmi_enabled));
 	DEFINE(VCPU_DSISR, offsetof(struct kvm_vcpu, arch.shregs.dsisr));
 	DEFINE(VCPU_DAR, offsetof(struct kvm_vcpu, arch.shregs.dar));
 	DEFINE(VCPU_VPA, offsetof(struct kvm_vcpu, arch.vpa.pinned_addr));
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 6fd2405..a8399b5 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -570,6 +570,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		r = 1;
 		break;
 #endif
+	case KVM_CAP_PPC_FWNMI:
+		r = 1;
+		break;
 	default:
 		r = 0;
 		break;
@@ -1132,6 +1135,10 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
 		break;
 	}
 #endif /* CONFIG_KVM_XICS */
+	case KVM_CAP_PPC_FWNMI:
+		r = 0;
+		vcpu->kvm->arch.fwnmi_enabled = true;
+		break;
 	default:
 		r = -EINVAL;
 		break;
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 03f3618..d8a07b5 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -831,6 +831,7 @@ struct kvm_ppc_smmu_info {
 #define KVM_CAP_GUEST_DEBUG_HW_WPS 120
 #define KVM_CAP_SPLIT_IRQCHIP 121
 #define KVM_CAP_IOEVENTFD_ANY_LENGTH 122
+#define KVM_CAP_PPC_FWNMI 123
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
