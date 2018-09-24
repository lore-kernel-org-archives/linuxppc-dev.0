Return-Path: <bharata@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42JVky1PVHzDrTg
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Sep 2018 13:56:57 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8O3rh1m011019
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Sep 2018 23:56:55 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2mpner4qky-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Sep 2018 23:56:55 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bharata@linux.ibm.com>;
 Mon, 24 Sep 2018 04:56:53 +0100
From: Bharata B Rao <bharata@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: paulus@au1.ibm.com, benh@linux.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 jglisse@redhat.com, linuxram@us.ibm.com,
 Bharata B Rao <bharata@linux.ibm.com>
Subject: [RFC PATCH v0 2/3] kvmppc: H_SVM_INIT_START and H_SVM_INIT_DONE hcalls
Date: Mon, 24 Sep 2018 09:26:40 +0530
In-Reply-To: <20180924035641.14572-1-bharata@linux.ibm.com>
References: <20180924035641.14572-1-bharata@linux.ibm.com>
Message-Id: <20180924035641.14572-3-bharata@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

H_SVM_INIT_START: Initiate securing a VM
H_SVM_INIT_DONE: Conclude securing a VM

During early guest init, these hcalls will be issued by UV.
As part of these hcalls, [un]register memslots with UV.

Signed-off-by: Bharata B Rao <bharata@linux.ibm.com>
---
 arch/powerpc/include/asm/hvcall.h    |  4 ++-
 arch/powerpc/include/asm/kvm_host.h  |  1 +
 arch/powerpc/include/asm/ucall-api.h |  6 ++++
 arch/powerpc/kvm/book3s_hv.c         | 54 ++++++++++++++++++++++++++++++++++++
 4 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
index 89e6b70c1857..6091276fef07 100644
--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -300,7 +300,9 @@
 #define H_INT_RESET             0x3D0
 #define H_SVM_PAGE_IN		0x3D4
 #define H_SVM_PAGE_OUT		0x3D8
-#define MAX_HCALL_OPCODE	H_SVM_PAGE_OUT
+#define H_SVM_INIT_START	0x3DC
+#define H_SVM_INIT_DONE		0x3E0
+#define MAX_HCALL_OPCODE	H_SVM_INIT_DONE
 
 /* H_VIOCTL functions */
 #define H_GET_VIOA_DUMP_SIZE	0x01
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index e03df112c471..3c9b780e55cb 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -292,6 +292,7 @@ struct kvm_arch {
 	struct dentry *debugfs_dir;
 	struct dentry *htab_dentry;
 	struct kvm_resize_hpt *resize_hpt; /* protected by kvm->lock */
+	bool svm_init_start; /* Indicates H_SVM_INIT_START has been called */
 #endif /* CONFIG_KVM_BOOK3S_HV_POSSIBLE */
 #ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
 	struct mutex hpt_mutex;
diff --git a/arch/powerpc/include/asm/ucall-api.h b/arch/powerpc/include/asm/ucall-api.h
index 2c12f514f8ab..9ddfcf541211 100644
--- a/arch/powerpc/include/asm/ucall-api.h
+++ b/arch/powerpc/include/asm/ucall-api.h
@@ -17,4 +17,10 @@ static inline int uv_page_out(u64 lpid, u64 dw0, u64 dw1, u64 dw2, u64 dw3)
 	return U_SUCCESS;
 }
 
+static inline int uv_register_mem_slot(u64 lpid, u64 dw0, u64 dw1, u64 dw2,
+				       u64 dw3)
+{
+	return 0;
+}
+
 #endif	/* _ASM_POWERPC_UCALL_API_H */
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 78865b515e73..708545edb17d 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -819,6 +819,50 @@ static int kvmppc_get_yield_count(struct kvm_vcpu *vcpu)
 	return yield_count;
 }
 
+#ifdef CONFIG_PPC_SVM
+#include <asm/ucall-api.h>
+/*
+ * TODO: Check if memslots related calls here need to be called
+ * under any lock.
+ */
+static unsigned long kvmppc_h_svm_init_start(struct kvm *kvm)
+{
+	struct kvm_memslots *slots;
+	struct kvm_memory_slot *memslot;
+	int ret;
+
+	slots = kvm_memslots(kvm);
+	kvm_for_each_memslot(memslot, slots) {
+		ret = uv_register_mem_slot(kvm->arch.lpid,
+					   memslot->base_gfn << PAGE_SHIFT,
+					   memslot->npages * PAGE_SIZE,
+					   0, memslot->id);
+		if (ret < 0)
+			return H_PARAMETER;
+	}
+	kvm->arch.svm_init_start = true;
+	return H_SUCCESS;
+}
+
+static unsigned long kvmppc_h_svm_init_done(struct kvm *kvm)
+{
+	if (kvm->arch.svm_init_start)
+		return H_SUCCESS;
+	else
+		return H_UNSUPPORTED;
+}
+#else
+static unsigned long kvmppc_h_svm_init_start(struct kvm *kvm)
+{
+	return H_UNSUPPORTED;
+}
+
+static unsigned long kvmppc_h_svm_init_done(struct kvm *kvm)
+{
+	return H_UNSUPPORTED;
+}
+#endif
+
 int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu)
 {
 	unsigned long req = kvmppc_get_gpr(vcpu, 3);
@@ -950,6 +994,12 @@ int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu)
 					    kvmppc_get_gpr(vcpu, 6),
 					    kvmppc_get_gpr(vcpu, 7));
 		break;
+	case H_SVM_INIT_START:
+		ret = kvmppc_h_svm_init_start(vcpu->kvm);
+		break;
+	case H_SVM_INIT_DONE:
+		ret = kvmppc_h_svm_init_done(vcpu->kvm);
+		break;
 	default:
 		return RESUME_HOST;
 	}
@@ -978,6 +1028,8 @@ static int kvmppc_hcall_impl_hv(unsigned long cmd)
 #endif
 	case H_SVM_PAGE_IN:
 	case H_SVM_PAGE_OUT:
+	case H_SVM_INIT_START:
+	case H_SVM_INIT_DONE:
 		return 1;
 	}
 
@@ -4403,6 +4455,8 @@ static unsigned int default_hcall_list[] = {
 #endif
 	H_SVM_PAGE_IN,
 	H_SVM_PAGE_OUT,
+	H_SVM_INIT_START,
+	H_SVM_INIT_DONE,
 	0
 };
 
-- 
2.14.3
