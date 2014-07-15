Return-Path: <aik@ozlabs.ru>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A1C671A0455
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:39:55 +1000 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Tue, 15 Jul 2014 19:39:54 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id D5A913578056
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:39:52 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6F9daFC5964234
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:39:36 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6F9dqNZ013792
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:39:52 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH QEMU 11/12] target-ppc: kvm: make use of
 KVM_CREATE_SPAPR_TCE_64
Date: Tue, 15 Jul 2014 19:39:43 +1000
Message-Id: <1405417184-14333-12-git-send-email-aik@ozlabs.ru>
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
 hw/ppc/spapr_iommu.c |  7 ++++---
 target-ppc/kvm.c     | 47 ++++++++++++++++++++++++++++++++++++-----------
 target-ppc/kvm_ppc.h | 10 +++++++---
 3 files changed, 47 insertions(+), 17 deletions(-)

diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
index 588d442..1710595 100644
--- a/hw/ppc/spapr_iommu.c
+++ b/hw/ppc/spapr_iommu.c
@@ -113,11 +113,12 @@ static MemoryRegionIOMMUOps spapr_iommu_ops = {
 static int spapr_tce_table_realize(DeviceState *dev)
 {
     sPAPRTCETable *tcet = SPAPR_TCE_TABLE(dev);
-    uint64_t window_size = tcet->nb_table << tcet->page_shift;
 
-    if (kvm_enabled() && !(window_size >> 32)) {
+    if (kvm_enabled()) {
         tcet->table = kvmppc_create_spapr_tce(tcet->liobn,
-                                              window_size,
+                                              tcet->nb_table,
+                                              tcet->bus_offset,
+                                              tcet->page_shift,
                                               &tcet->fd,
                                               tcet->vfio_accel);
     }
diff --git a/target-ppc/kvm.c b/target-ppc/kvm.c
index 42718f7..cfc2599 100644
--- a/target-ppc/kvm.c
+++ b/target-ppc/kvm.c
@@ -62,6 +62,7 @@ static int cap_booke_sregs;
 static int cap_ppc_smt;
 static int cap_ppc_rma;
 static int cap_spapr_tce;
+static int cap_spapr_tce_64;
 static int cap_spapr_multitce;
 static int cap_spapr_vfio;
 static int cap_hior;
@@ -101,6 +102,7 @@ int kvm_arch_init(KVMState *s)
     cap_ppc_smt = kvm_check_extension(s, KVM_CAP_PPC_SMT);
     cap_ppc_rma = kvm_check_extension(s, KVM_CAP_PPC_RMA);
     cap_spapr_tce = kvm_check_extension(s, KVM_CAP_SPAPR_TCE);
+    cap_spapr_tce_64 = kvm_check_extension(s, KVM_CAP_SPAPR_TCE_64);
     cap_spapr_multitce = kvm_check_extension(s, KVM_CAP_SPAPR_MULTITCE);
     cap_spapr_vfio = false;
     cap_one_reg = kvm_check_extension(s, KVM_CAP_ONE_REG);
@@ -1655,13 +1657,10 @@ bool kvmppc_spapr_use_multitce(void)
     return cap_spapr_multitce;
 }
 
-void *kvmppc_create_spapr_tce(uint32_t liobn, uint32_t window_size, int *pfd,
-                              bool vfio_accel)
+void *kvmppc_create_spapr_tce(uint32_t liobn, uint32_t window_shift,
+                              uint64_t bus_offset, uint32_t page_shift,
+                              int *pfd, bool vfio_accel)
 {
-    struct kvm_create_spapr_tce args = {
-        .liobn = liobn,
-        .window_size = window_size,
-    };
     long len;
     int fd;
     void *table;
@@ -1674,14 +1673,40 @@ void *kvmppc_create_spapr_tce(uint32_t liobn, uint32_t window_size, int *pfd,
         return NULL;
     }
 
-    fd = kvm_vm_ioctl(kvm_state, KVM_CREATE_SPAPR_TCE, &args);
-    if (fd < 0) {
-        fprintf(stderr, "KVM: Failed to create TCE table for liobn 0x%x\n",
-                liobn);
+    if (cap_spapr_tce_64) {
+        struct kvm_create_spapr_tce_64 args = {
+            .liobn = liobn,
+            .page_shift = page_shift,
+            .offset = bus_offset >> page_shift,
+            .size = window_shift,
+            .flags = 0
+        };
+        fd = kvm_vm_ioctl(kvm_state, KVM_CREATE_SPAPR_TCE_64, &args);
+        if (fd < 0) {
+            fprintf(stderr,
+                    "KVM: Failed to create TCE64 table for liobn 0x%x\n",
+                    liobn);
+            return NULL;
+        }
+    } else if (cap_spapr_tce) {
+        struct kvm_create_spapr_tce args = {
+            .liobn = liobn,
+            .window_size = window_shift << page_shift,
+        };
+        if (((window_shift << page_shift) != args.window_size) || bus_offset) {
+            return NULL;
+        }
+        fd = kvm_vm_ioctl(kvm_state, KVM_CREATE_SPAPR_TCE, &args);
+        if (fd < 0) {
+            fprintf(stderr, "KVM: Failed to create TCE table for liobn 0x%x\n",
+                    liobn);
+            return NULL;
+        }
+    } else {
         return NULL;
     }
 
-    len = (window_size / SPAPR_TCE_PAGE_SIZE) * sizeof(uint64_t);
+    len = window_shift * sizeof(uint64_t);
     /* FIXME: round this up to page size */
 
     table = mmap(NULL, len, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
diff --git a/target-ppc/kvm_ppc.h b/target-ppc/kvm_ppc.h
index d9516e7..154f434 100644
--- a/target-ppc/kvm_ppc.h
+++ b/target-ppc/kvm_ppc.h
@@ -33,8 +33,9 @@ int kvmppc_booke_watchdog_enable(PowerPCCPU *cpu);
 #ifndef CONFIG_USER_ONLY
 off_t kvmppc_alloc_rma(void **rma);
 bool kvmppc_spapr_use_multitce(void);
-void *kvmppc_create_spapr_tce(uint32_t liobn, uint32_t window_size, int *pfd,
-                              bool vfio_accel);
+void *kvmppc_create_spapr_tce(uint32_t liobn, uint32_t window_shift,
+                              uint64_t bus_offset, uint32_t page_shift,
+                              int *pfd, bool vfio_accel);
 int kvmppc_remove_spapr_tce(void *table, int pfd, uint32_t window_size);
 int kvmppc_reset_htab(int shift_hint);
 uint64_t kvmppc_rma_size(uint64_t current_size, unsigned int hash_shift);
@@ -145,7 +146,10 @@ static inline bool kvmppc_spapr_use_multitce(void)
 }
 
 static inline void *kvmppc_create_spapr_tce(uint32_t liobn,
-                                            uint32_t window_size, int *fd,
+                                            uint32_t window_shift,
+                                            uint64_t bus_offset,
+                                            uint32_t page_shift,
+                                            int *fd,
                                             bool vfio_accel)
 {
     return NULL;
-- 
2.0.0
