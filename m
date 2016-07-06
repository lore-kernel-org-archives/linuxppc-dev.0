Return-Path: <sam.bobroff@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rkqGY4wW7zDqx9
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jul 2016 15:35:33 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u665XXT5100368
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jul 2016 01:35:31 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0b-001b2d01.pphosted.com with ESMTP id 240nehsfdw-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Jul 2016 01:35:31 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sam.bobroff@au1.ibm.com>;
 Wed, 6 Jul 2016 15:35:27 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id D85392BB0057
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jul 2016 15:35:24 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u665ZOAY7405752
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jul 2016 15:35:24 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u665ZOtp007232
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jul 2016 15:35:24 +1000
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
To: david@gibson.dropbear.id.au
Cc: anton@au1.ibm.com, mikey@neuling.org, aik@ozlabs.ru, mpe@ellerman.id.au,
 agraf@suse.de, qemu-devel@nongnu.org, paulus@samba.org,
 qemu-ppc@nongnu.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 3/3] spapr: Set ibm, pa-features HTM from KVM_CAP_PPC_HTM
Date: Wed,  6 Jul 2016 15:35:23 +1000
In-Reply-To: <cover.1467783317.git.sam.bobroff@au1.ibm.com>
References: <cover.1467695915.git.sam.bobroff@au1.ibm.com>
 <cover.1467783317.git.sam.bobroff@au1.ibm.com>
In-Reply-To: <cover.1467783317.git.sam.bobroff@au1.ibm.com>
References: <cover.1467783317.git.sam.bobroff@au1.ibm.com>
Message-Id: <fb64116eb0795e0b2b0789a02b4ce8f694fc69e4.1467783317.git.sam.bobroff@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Advertise HTM support in ibm, pa-features if KVM indicates support when
queried via a new capability (KVM_CAP_PPC_HTM).

If KVM returns false for the capability (which may indicate that the
host kernel doesn't support the capability itself) attempt to
determine availability using a fallback method based on KVM being
KVM-HV and HTM being available to the QEMU process.

Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
---
v2:

* Improve readability of HTM bit set code.
* Move the test for KVM into kvmppc_get_htm_support().

 hw/ppc/spapr.c       |  3 +++
 target-ppc/kvm.c     | 29 +++++++++++++++++++++++++++++
 target-ppc/kvm_ppc.h |  6 ++++++
 3 files changed, 38 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 704aae7..843fbe7 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -712,6 +712,9 @@ static void spapr_populate_cpu_dt(CPUState *cs, void *fdt, int offset,
     } else /* env->mmu_model == POWERPC_MMU_2_07 */ {
         pa_features = pa_features_207;
         pa_size = sizeof(pa_features_207);
+        if (kvmppc_get_htm_support(env)) {
+            pa_features[24] |= 0x80;
+        }
     }
     if (env->ci_large_pages) {
         pa_features[3] |= 0x20;
diff --git a/target-ppc/kvm.c b/target-ppc/kvm.c
index 884d564..9d13446 100644
--- a/target-ppc/kvm.c
+++ b/target-ppc/kvm.c
@@ -20,6 +20,7 @@
 #include <sys/vfs.h>
 
 #include <linux/kvm.h>
+#include "elf.h"
 
 #include "qemu-common.h"
 #include "qemu/error-report.h"
@@ -1976,6 +1977,34 @@ uint32_t kvmppc_get_dfp(void)
     return kvmppc_read_int_cpu_dt("ibm,dfp");
 }
 
+bool kvmppc_get_htm_support(CPUPPCState *env)
+{
+    PowerPCCPU *cpu = ppc_env_get_cpu(env);
+    CPUState *cs = CPU(cpu);
+
+    if (!kvm_enabled()) {
+        return false;
+    }
+    if (kvm_vm_check_extension(cs->kvm_state, KVM_CAP_PPC_HTM)) {
+        return true;
+    }
+    /*
+     * Fallback test for host kernels that don't yet support KVM_CAP_PPC_HTM.
+     * This will be unnecessary when KVM_API_VERSION is incremented (to 13 or
+     * above) because that will remove the ambiguity between the host kernel
+     * lacking support for KVM_CAP_PPC_HTM and it having support but reporting
+     * HTM as unavailable (both of which return 0, above).
+     */
+    if (kvm_vm_check_extension(cs->kvm_state, KVM_CAP_PPC_GET_PVINFO)) {
+        /* Assume this means PR KVM, so no TM. */
+        return false;
+    } else {
+        /* Assume this means HV KVM, propagate whatever host userspace sees. */
+        unsigned long hwcap2 = qemu_getauxval(AT_HWCAP2);
+        return !!(hwcap2 & PPC_FEATURE2_HAS_HTM);
+    }
+}
+
 static int kvmppc_get_pvinfo(CPUPPCState *env, struct kvm_ppc_pvinfo *pvinfo)
  {
      PowerPCCPU *cpu = ppc_env_get_cpu(env);
diff --git a/target-ppc/kvm_ppc.h b/target-ppc/kvm_ppc.h
index 20bfb59..b01c717 100644
--- a/target-ppc/kvm_ppc.h
+++ b/target-ppc/kvm_ppc.h
@@ -17,6 +17,7 @@ uint32_t kvmppc_get_tbfreq(void);
 uint64_t kvmppc_get_clockfreq(void);
 uint32_t kvmppc_get_vmx(void);
 uint32_t kvmppc_get_dfp(void);
+bool kvmppc_get_htm_support(CPUPPCState *env);
 bool kvmppc_get_host_model(char **buf);
 bool kvmppc_get_host_serial(char **buf);
 int kvmppc_get_hasidle(CPUPPCState *env);
@@ -90,6 +91,11 @@ static inline uint32_t kvmppc_get_dfp(void)
     return 0;
 }
 
+static inline bool kvmppc_get_htm_support(KVMState *kvm_state)
+{
+    return false;
+}
+
 static inline int kvmppc_get_hasidle(CPUPPCState *env)
 {
     return 0;
-- 
2.1.0
