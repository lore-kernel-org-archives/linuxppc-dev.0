Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id BE036B718F
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 29 Jul 2010 22:48:15 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 27/27] KVM: PPC: Add get_pvinfo interface to query hypercall
	instructions
Date: Thu, 29 Jul 2010 14:48:08 +0200
Message-Id: <1280407688-9815-28-git-send-email-agraf@suse.de>
In-Reply-To: <1280407688-9815-1-git-send-email-agraf@suse.de>
References: <1280407688-9815-1-git-send-email-agraf@suse.de>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	KVM list <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We need to tell the guest the opcodes that make up a hypercall through
interfaces that are controlled by userspace. So we need to add a call
for userspace to allow it to query those opcodes so it can pass them
on.

This is required because the hypercall opcodes can change based on
the hypervisor conditions. If we're running in hardware accelerated
hypervisor mode, a hypercall looks different from when we're running
without hardware acceleration.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 Documentation/kvm/api.txt  |   23 +++++++++++++++++++++++
 arch/powerpc/kvm/powerpc.c |   38 ++++++++++++++++++++++++++++++++++++++
 include/linux/kvm.h        |   11 +++++++++++
 3 files changed, 72 insertions(+), 0 deletions(-)

diff --git a/Documentation/kvm/api.txt b/Documentation/kvm/api.txt
index 5f5b649..44d9893 100644
--- a/Documentation/kvm/api.txt
+++ b/Documentation/kvm/api.txt
@@ -1032,6 +1032,29 @@ are defined as follows:
    eax, ebx, ecx, edx: the values returned by the cpuid instruction for
          this function/index combination
 
+4.46 KVM_PPC_GET_PVINFO
+
+Capability: KVM_CAP_PPC_GET_PVINFO
+Architectures: ppc
+Type: vm ioctl
+Parameters: struct kvm_ppc_pvinfo (out)
+Returns: 0 on success, !0 on error
+
+struct kvm_ppc_pvinfo {
+	__u32 flags;
+	__u32 hcall[4];
+	__u8  pad[108];
+};
+
+This ioctl fetches PV specific information that need to be passed to the guest
+using the device tree or other means from vm context.
+
+For now the only implemented piece of information distributed here is an array
+of 4 instructions that make up a hypercall.
+
+If any additional field gets added to this structure later on, a bit for that
+additional piece of information will be set in the flags bitmap.
+
 5. The kvm_run structure
 
 Application code obtains a pointer to the kvm_run structure by
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index fecfe04..6a53a3f 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -191,6 +191,7 @@ int kvm_dev_ioctl_check_extension(long ext)
 	case KVM_CAP_PPC_UNSET_IRQ:
 	case KVM_CAP_ENABLE_CAP:
 	case KVM_CAP_PPC_OSI:
+	case KVM_CAP_PPC_GET_PVINFO:
 		r = 1;
 		break;
 	case KVM_CAP_COALESCED_MMIO:
@@ -578,16 +579,53 @@ out:
 	return r;
 }
 
+static int kvm_vm_ioctl_get_pvinfo(struct kvm_ppc_pvinfo *pvinfo)
+{
+	u32 inst_lis = 0x3c000000;
+	u32 inst_ori = 0x60000000;
+	u32 inst_nop = 0x60000000;
+	u32 inst_sc = 0x44000002;
+	u32 inst_imm_mask = 0xffff;
+
+	/*
+	 * The hypercall to get into KVM from within guest context is as
+	 * follows:
+	 *
+	 *    lis r0, r0, KVM_SC_MAGIC_R0@h
+	 *    ori r0, KVM_SC_MAGIC_R0@l
+	 *    sc
+	 *    nop
+	 */
+	pvinfo->hcall[0] = inst_lis | ((KVM_SC_MAGIC_R0 >> 16) & inst_imm_mask);
+	pvinfo->hcall[1] = inst_ori | (KVM_SC_MAGIC_R0 & inst_imm_mask);
+	pvinfo->hcall[2] = inst_sc;
+	pvinfo->hcall[3] = inst_nop;
+
+	return 0;
+}
+
 long kvm_arch_vm_ioctl(struct file *filp,
                        unsigned int ioctl, unsigned long arg)
 {
+	void __user *argp = (void __user *)arg;
 	long r;
 
 	switch (ioctl) {
+	case KVM_PPC_GET_PVINFO: {
+		struct kvm_ppc_pvinfo pvinfo;
+		r = kvm_vm_ioctl_get_pvinfo(&pvinfo);
+		if (copy_to_user(argp, &pvinfo, sizeof(pvinfo))) {
+			r = -EFAULT;
+			goto out;
+		}
+
+		break;
+	}
 	default:
 		r = -ENOTTY;
 	}
 
+out:
 	return r;
 }
 
diff --git a/include/linux/kvm.h b/include/linux/kvm.h
index 636fc38..3707704 100644
--- a/include/linux/kvm.h
+++ b/include/linux/kvm.h
@@ -414,6 +414,14 @@ struct kvm_enable_cap {
 	__u8  pad[64];
 };
 
+/* for KVM_PPC_GET_PVINFO */
+struct kvm_ppc_pvinfo {
+	/* out */
+	__u32 flags;
+	__u32 hcall[4];
+	__u8  pad[108];
+};
+
 #define KVMIO 0xAE
 
 /*
@@ -530,6 +538,7 @@ struct kvm_enable_cap {
 #ifdef __KVM_HAVE_XCRS
 #define KVM_CAP_XCRS 56
 #endif
+#define KVM_CAP_PPC_GET_PVINFO 57
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -664,6 +673,8 @@ struct kvm_clock_data {
 /* Available with KVM_CAP_PIT_STATE2 */
 #define KVM_GET_PIT2              _IOR(KVMIO,  0x9f, struct kvm_pit_state2)
 #define KVM_SET_PIT2              _IOW(KVMIO,  0xa0, struct kvm_pit_state2)
+/* Available with KVM_CAP_PPC_GET_PVINFO */
+#define KVM_PPC_GET_PVINFO	  _IOW(KVMIO,  0xa1, struct kvm_ppc_pvinfo)
 
 /*
  * ioctls for vcpu fds
-- 
1.6.0.2
