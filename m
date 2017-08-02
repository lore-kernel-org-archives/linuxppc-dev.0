Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xMhrJ4Nn1zDsPY
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Aug 2017 15:41:20 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v725fI4J100249
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Aug 2017 01:41:18 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2c31xu96th-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Aug 2017 01:41:17 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 1 Aug 2017 23:41:16 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Anton Blanchard <anton@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [RFC PATCH 10/17] powerpc/mm: Add new firmware feature HASH API
Date: Wed,  2 Aug 2017 11:10:09 +0530
In-Reply-To: <20170802054016.8927-1-aneesh.kumar@linux.vnet.ibm.com>
References: <20170802054016.8927-1-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <20170802054016.8927-11-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We will use this feature to check whether hypervisor implements hash based
remove and protect hcalls

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/firmware.h       | 3 ++-
 arch/powerpc/kvm/powerpc.c                | 4 ++++
 arch/powerpc/platforms/pseries/firmware.c | 1 +
 include/uapi/linux/kvm.h                  | 1 +
 4 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/firmware.h b/arch/powerpc/include/asm/firmware.h
index 8645897472b1..152d704ac3c3 100644
--- a/arch/powerpc/include/asm/firmware.h
+++ b/arch/powerpc/include/asm/firmware.h
@@ -51,6 +51,7 @@
 #define FW_FEATURE_BEST_ENERGY	ASM_CONST(0x0000000080000000)
 #define FW_FEATURE_TYPE1_AFFINITY ASM_CONST(0x0000000100000000)
 #define FW_FEATURE_PRRN		ASM_CONST(0x0000000200000000)
+#define FW_FEATURE_HASH_API	ASM_CONST(0x0000000400000000)
 
 #ifndef __ASSEMBLY__
 
@@ -67,7 +68,7 @@ enum {
 		FW_FEATURE_CMO | FW_FEATURE_VPHN | FW_FEATURE_XCMO |
 		FW_FEATURE_SET_MODE | FW_FEATURE_BEST_ENERGY |
 		FW_FEATURE_TYPE1_AFFINITY | FW_FEATURE_PRRN |
-		FW_FEATURE_HPT_RESIZE,
+		FW_FEATURE_HPT_RESIZE | FW_FEATURE_HASH_API,
 	FW_FEATURE_PSERIES_ALWAYS = 0,
 	FW_FEATURE_POWERNV_POSSIBLE = FW_FEATURE_OPAL,
 	FW_FEATURE_POWERNV_ALWAYS = 0,
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 1a75c0b5f4ca..bd551edfa155 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -632,6 +632,10 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		/* Disable this on POWER9 until code handles new HPTE format */
 		r = !!hv_enabled && !cpu_has_feature(CPU_FTR_ARCH_300);
 		break;
+	case KVM_CAP_SPAPR_HASH_API:
+		/* Only enable for HV kvm */
+		r = is_kvmppc_hv_enabled(kvm);
+		break;
 #endif
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
 	case KVM_CAP_PPC_FWNMI:
diff --git a/arch/powerpc/platforms/pseries/firmware.c b/arch/powerpc/platforms/pseries/firmware.c
index 63cc82ad58ac..32081d4406e8 100644
--- a/arch/powerpc/platforms/pseries/firmware.c
+++ b/arch/powerpc/platforms/pseries/firmware.c
@@ -65,6 +65,7 @@ hypertas_fw_features_table[] = {
 	{FW_FEATURE_SET_MODE,		"hcall-set-mode"},
 	{FW_FEATURE_BEST_ENERGY,	"hcall-best-energy-1*"},
 	{FW_FEATURE_HPT_RESIZE,		"hcall-hpt-resize"},
+	{FW_FEATURE_HASH_API,		"hcall-hash-api"},
 };
 
 /* Build up the firmware features bitmask using the contents of
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 6cd63c18708a..698b202b4c53 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -929,6 +929,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_PPC_SMT_POSSIBLE 147
 #define KVM_CAP_HYPERV_SYNIC2 148
 #define KVM_CAP_HYPERV_VP_INDEX 149
+#define KVM_CAP_SPAPR_HASH_API 150
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
2.13.3
