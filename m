Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tfN6Z0mDqzDvjw
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Dec 2016 16:58:46 +1100 (AEDT)
From: David Gibson <david@gibson.dropbear.id.au>
To: paulus@samba.org
Cc: michael@ellerman.id.au, benh@kernel.crashing.org, sjitindarsingh@gmail.com,
 thuth@redhat.com, lvivier@redhat.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 08/11] powerpc/kvm: KVM-HV HPT resizing stub implementation
Date: Thu, 15 Dec 2016 16:54:01 +1100
Message-Id: <20161215055404.29351-9-david@gibson.dropbear.id.au>
In-Reply-To: <20161215055404.29351-1-david@gibson.dropbear.id.au>
References: <20161215055404.29351-1-david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds a stub (always failing) implementation of the ioctl()s
for the HPT resizing PAPR extension.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 arch/powerpc/include/asm/kvm_ppc.h  |  4 ++++
 arch/powerpc/kvm/book3s_64_mmu_hv.c | 16 ++++++++++++++++
 arch/powerpc/kvm/book3s_hv.c        | 22 ++++++++++++++++++++++
 3 files changed, 42 insertions(+)

diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index 3b837bc..f8eaed0 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -215,6 +215,10 @@ extern void kvmppc_bookehv_exit(void);
 extern int kvmppc_prepare_to_enter(struct kvm_vcpu *vcpu);
 
 extern int kvm_vm_ioctl_get_htab_fd(struct kvm *kvm, struct kvm_get_htab_fd *);
+extern long kvm_vm_ioctl_resize_hpt_prepare(struct kvm *kvm,
+					    struct kvm_ppc_resize_hpt *rhpt);
+extern long kvm_vm_ioctl_resize_hpt_commit(struct kvm *kvm,
+					   struct kvm_ppc_resize_hpt *rhpt);
 
 int kvm_vcpu_ioctl_interrupt(struct kvm_vcpu *vcpu, struct kvm_interrupt *irq);
 
diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index cd145eb..ac0f18b 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -1160,6 +1160,22 @@ void kvmppc_unpin_guest_page(struct kvm *kvm, void *va, unsigned long gpa,
 }
 
 /*
+ * HPT resizing
+ */
+
+long kvm_vm_ioctl_resize_hpt_prepare(struct kvm *kvm,
+				     struct kvm_ppc_resize_hpt *rhpt)
+{
+	return -EIO;
+}
+
+long kvm_vm_ioctl_resize_hpt_commit(struct kvm *kvm,
+				    struct kvm_ppc_resize_hpt *rhpt)
+{
+	return -EIO;
+}
+
+/*
  * Functions for reading and writing the hash table via reads and
  * writes on a file descriptor.
  *
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 957e473..d022322 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -3617,6 +3617,28 @@ static long kvm_arch_vm_ioctl_hv(struct file *filp,
 		break;
 	}
 
+	case KVM_PPC_RESIZE_HPT_PREPARE: {
+		struct kvm_ppc_resize_hpt rhpt;
+
+		r = -EFAULT;
+		if (copy_from_user(&rhpt, argp, sizeof(rhpt)))
+			break;
+
+		r = kvm_vm_ioctl_resize_hpt_prepare(kvm, &rhpt);
+		break;
+	}
+
+	case KVM_PPC_RESIZE_HPT_COMMIT: {
+		struct kvm_ppc_resize_hpt rhpt;
+
+		r = -EFAULT;
+		if (copy_from_user(&rhpt, argp, sizeof(rhpt)))
+			break;
+
+		r = kvm_vm_ioctl_resize_hpt_commit(kvm, &rhpt);
+		break;
+	}
+
 	default:
 		r = -ENOTTY;
 	}
-- 
2.9.3
