Return-Path: <sam.bobroff@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rkqxl4y4FzDqxH
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jul 2016 16:06:03 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u665wfe8127018
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jul 2016 02:06:01 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 240ndwtfxh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Jul 2016 02:06:01 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sam.bobroff@au1.ibm.com>;
 Wed, 6 Jul 2016 16:05:59 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id EAA512BB005D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jul 2016 16:05:55 +1000 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6665t9x5898734
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jul 2016 16:05:55 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6665t4f031039
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jul 2016 16:05:55 +1000
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, david@gibson.dropbear.id.au,
 aik@ozlabs.ru, mpe@ellerman.id.au, agraf@suse.de,
 qemu-devel@nongnu.org, paulus@samba.org
Subject: [PATCH 1/1] KVM: PPC: Introduce KVM_CAP_PPC_HTM
Date: Wed,  6 Jul 2016 16:05:54 +1000
Message-Id: <741e7a7860e055603a311bcc6051bd88fdad1215.1467785081.git.sam.bobroff@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Introduce a new KVM capability, KVM_CAP_PPC_HTM, that can be queried to
determine if a PowerPC KVM guest should use HTM (Hardware Transactional
Memory).

This will be used by QEMU to populate the pa-features bits in the
guest's device tree.

Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
---

 arch/powerpc/kvm/powerpc.c | 4 ++++
 include/uapi/linux/kvm.h   | 1 +
 2 files changed, 5 insertions(+)

diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 02416fe..06d79bc 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -588,6 +588,10 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		r = 1;
 		break;
 #endif
+	case KVM_CAP_PPC_HTM:
+		r = cpu_has_feature(CPU_FTR_TM)
+		    && is_kvmppc_hv_enabled(kvm);
+		break;
 	default:
 		r = 0;
 		break;
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 05ebf47..f421d0e 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -866,6 +866,7 @@ struct kvm_ppc_smmu_info {
 #define KVM_CAP_ARM_PMU_V3 126
 #define KVM_CAP_VCPU_ATTRIBUTES 127
 #define KVM_CAP_MAX_VCPU_ID 128
+#define KVM_CAP_PPC_HTM 129
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
2.1.0
