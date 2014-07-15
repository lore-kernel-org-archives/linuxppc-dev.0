Return-Path: <aik@ozlabs.ru>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3CA451A09B5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:39:52 +1000 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Tue, 15 Jul 2014 19:39:49 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 8F3482BB0052
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:39:47 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6F9N1oo63635506
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:23:01 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6F9dkak008901
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:39:47 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH QEMU 01/12] spapr_iommu: Disable in-kernel IOMMU tables for
 >4GB windows
Date: Tue, 15 Jul 2014 19:39:33 +1000
Message-Id: <1405417184-14333-2-git-send-email-aik@ozlabs.ru>
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

The existing KVM_CREATE_SPAPR_TCE ioctl only support 4G windows max.
We are going to add huge DMA windows support so this will create small
window and unexpectedly fail later.

This disables KVM_CREATE_SPAPR_TCE for windows bigger that 4GB. Since
those windows are normally mapped at the boot time, there will be no
performance impact.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 hw/ppc/spapr_iommu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
index f6e32a4..36f5d27 100644
--- a/hw/ppc/spapr_iommu.c
+++ b/hw/ppc/spapr_iommu.c
@@ -113,11 +113,11 @@ static MemoryRegionIOMMUOps spapr_iommu_ops = {
 static int spapr_tce_table_realize(DeviceState *dev)
 {
     sPAPRTCETable *tcet = SPAPR_TCE_TABLE(dev);
+    uint64_t window_size = tcet->nb_table << tcet->page_shift;
 
-    if (kvm_enabled()) {
+    if (kvm_enabled() && !(window_size >> 32)) {
         tcet->table = kvmppc_create_spapr_tce(tcet->liobn,
-                                              tcet->nb_table <<
-                                              tcet->page_shift,
+                                              window_size,
                                               &tcet->fd,
                                               tcet->vfio_accel);
     }
-- 
2.0.0
