Return-Path: <aik@ozlabs.ru>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 818D91A01EA
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:39:56 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Tue, 15 Jul 2014 19:39:56 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 71301357805A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:39:53 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6F9HALS18677976
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:17:10 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6F9dpvU026521
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:39:52 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH QEMU 10/12] headers: update for KVM_CAP_SPAPR_TCE_64 and VFIO
 KVM device
Date: Tue, 15 Jul 2014 19:39:42 +1000
Message-Id: <1405417184-14333-11-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1405417184-14333-1-git-send-email-aik@ozlabs.ru>
References: <1405417184-14333-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 linux-headers/asm-mips/kvm_para.h |  6 +++++-
 linux-headers/asm-powerpc/kvm.h   |  9 +++++++++
 linux-headers/linux/kvm.h         | 12 ++++++++++++
 linux-headers/linux/kvm_para.h    |  3 +++
 4 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/linux-headers/asm-mips/kvm_para.h b/linux-headers/asm-mips/kvm_para.h
index 14fab8f..dbb2464 100644
--- a/linux-headers/asm-mips/kvm_para.h
+++ b/linux-headers/asm-mips/kvm_para.h
@@ -1 +1,5 @@
-#include <asm-generic/kvm_para.h>
+#ifndef _ASM_MIPS_KVM_PARA_H
+#define _ASM_MIPS_KVM_PARA_H
+
+
+#endif /* _ASM_MIPS_KVM_PARA_H */
diff --git a/linux-headers/asm-powerpc/kvm.h b/linux-headers/asm-powerpc/kvm.h
index 2bc4a94..39325bf 100644
--- a/linux-headers/asm-powerpc/kvm.h
+++ b/linux-headers/asm-powerpc/kvm.h
@@ -333,6 +333,15 @@ struct kvm_create_spapr_tce {
 	__u32 window_size;
 };
 
+/* for KVM_CAP_SPAPR_TCE_64 */
+struct kvm_create_spapr_tce_64 {
+	__u64 liobn;
+	__u32 page_shift;
+	__u64 offset;	/* in pages */
+	__u64 size; 	/* in pages */
+	__u32 flags;
+};
+
 /* for KVM_ALLOCATE_RMA */
 struct kvm_allocate_rma {
 	__u64 rma_size;
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index f5d2c38..fd728d3 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -758,6 +758,8 @@ struct kvm_ppc_smmu_info {
 #define KVM_CAP_VM_ATTRIBUTES 101
 #define KVM_CAP_ARM_PSCI_0_2 102
 #define KVM_CAP_PPC_FIXUP_HCALL 103
+#define KVM_CAP_SPAPR_TCE_VFIO 104
+#define KVM_CAP_SPAPR_TCE_64 105
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -947,9 +949,17 @@ struct kvm_device_attr {
 #define  KVM_DEV_VFIO_GROUP			1
 #define   KVM_DEV_VFIO_GROUP_ADD			1
 #define   KVM_DEV_VFIO_GROUP_DEL			2
+#define   KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE_LIOBN	3
 #define KVM_DEV_TYPE_ARM_VGIC_V2	5
 #define KVM_DEV_TYPE_FLIC		6
 
+struct kvm_vfio_spapr_tce_liobn {
+	__u32	argsz;
+	__s32	fd;
+	__u32	liobn;
+	__u64	start_addr;
+};
+
 /*
  * ioctls for VM fds
  */
@@ -1031,6 +1041,8 @@ struct kvm_s390_ucas_mapping {
 /* Available with KVM_CAP_PPC_ALLOC_HTAB */
 #define KVM_PPC_ALLOCATE_HTAB	  _IOWR(KVMIO, 0xa7, __u32)
 #define KVM_CREATE_SPAPR_TCE	  _IOW(KVMIO,  0xa8, struct kvm_create_spapr_tce)
+#define KVM_CREATE_SPAPR_TCE_64	  _IOW(KVMIO,  0xa8, \
+				       struct kvm_create_spapr_tce_64)
 /* Available with KVM_CAP_RMA */
 #define KVM_ALLOCATE_RMA	  _IOR(KVMIO,  0xa9, struct kvm_allocate_rma)
 /* Available with KVM_CAP_PPC_HTAB_FD */
diff --git a/linux-headers/linux/kvm_para.h b/linux-headers/linux/kvm_para.h
index 2dff783..e61661e 100644
--- a/linux-headers/linux/kvm_para.h
+++ b/linux-headers/linux/kvm_para.h
@@ -20,6 +20,9 @@
 #define KVM_HC_FEATURES			3
 #define KVM_HC_PPC_MAP_MAGIC_PAGE	4
 #define KVM_HC_KICK_CPU			5
+#define KVM_HC_MIPS_GET_CLOCK_FREQ	6
+#define KVM_HC_MIPS_EXIT_VM		7
+#define KVM_HC_MIPS_CONSOLE_OUTPUT	8
 
 /*
  * hypercalls use architecture specific
-- 
2.0.0
