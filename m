Return-Path: <aik@ozlabs.ru>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 648E61A09B5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:39:51 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Tue, 15 Jul 2014 19:39:51 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 23A4E2BB0059
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:39:48 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6F9H5qt57540846
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:17:05 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6F9dlid013544
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:39:47 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH QEMU 02/12] spapr_pci: Make find_phb()/find_dev() public
Date: Tue, 15 Jul 2014 19:39:34 +1000
Message-Id: <1405417184-14333-3-git-send-email-aik@ozlabs.ru>
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

This makes find_phb()/find_dev() public and changed its names
to spapr_pci_find_phb()/spapr_pci_find_dev() as they are going to
be used from other parts of QEMU such as VFIO DDW (dynamic DMA window)
or VFIO PCI error injection or VFIO EEH handling - in all these
cases there are RTAS calls which are addressed to BUID+config_addr
in IEEE1275 format.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 hw/ppc/spapr_pci.c          | 22 +++++++++++-----------
 include/hw/pci-host/spapr.h |  4 ++++
 2 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 9ed39a9..230b59c 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -47,7 +47,7 @@
 #define RTAS_TYPE_MSI           1
 #define RTAS_TYPE_MSIX          2
 
-static sPAPRPHBState *find_phb(sPAPREnvironment *spapr, uint64_t buid)
+sPAPRPHBState *spapr_pci_find_phb(sPAPREnvironment *spapr, uint64_t buid)
 {
     sPAPRPHBState *sphb;
 
@@ -61,10 +61,10 @@ static sPAPRPHBState *find_phb(sPAPREnvironment *spapr, uint64_t buid)
     return NULL;
 }
 
-static PCIDevice *find_dev(sPAPREnvironment *spapr, uint64_t buid,
-                           uint32_t config_addr)
+PCIDevice *spapr_pci_find_dev(sPAPREnvironment *spapr, uint64_t buid,
+                              uint32_t config_addr)
 {
-    sPAPRPHBState *sphb = find_phb(spapr, buid);
+    sPAPRPHBState *sphb = spapr_pci_find_phb(spapr, buid);
     PCIHostState *phb = PCI_HOST_BRIDGE(sphb);
     int bus_num = (config_addr >> 16) & 0xFF;
     int devfn = (config_addr >> 8) & 0xFF;
@@ -95,7 +95,7 @@ static void finish_read_pci_config(sPAPREnvironment *spapr, uint64_t buid,
         return;
     }
 
-    pci_dev = find_dev(spapr, buid, addr);
+    pci_dev = spapr_pci_find_dev(spapr, buid, addr);
     addr = rtas_pci_cfgaddr(addr);
 
     if (!pci_dev || (addr % size) || (addr >= pci_config_size(pci_dev))) {
@@ -162,7 +162,7 @@ static void finish_write_pci_config(sPAPREnvironment *spapr, uint64_t buid,
         return;
     }
 
-    pci_dev = find_dev(spapr, buid, addr);
+    pci_dev = spapr_pci_find_dev(spapr, buid, addr);
     addr = rtas_pci_cfgaddr(addr);
 
     if (!pci_dev || (addr % size) || (addr >= pci_config_size(pci_dev))) {
@@ -281,9 +281,9 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, sPAPREnvironment *spapr,
     }
 
     /* Fins sPAPRPHBState */
-    phb = find_phb(spapr, buid);
+    phb = spapr_pci_find_phb(spapr, buid);
     if (phb) {
-        pdev = find_dev(spapr, buid, config_addr);
+        pdev = spapr_pci_find_dev(spapr, buid, config_addr);
     }
     if (!phb || !pdev) {
         rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
@@ -377,9 +377,9 @@ static void rtas_ibm_query_interrupt_source_number(PowerPCCPU *cpu,
     spapr_pci_msi *msi;
 
     /* Find sPAPRPHBState */
-    phb = find_phb(spapr, buid);
+    phb = spapr_pci_find_phb(spapr, buid);
     if (phb) {
-        pdev = find_dev(spapr, buid, config_addr);
+        pdev = spapr_pci_find_dev(spapr, buid, config_addr);
     }
     if (!phb || !pdev) {
         rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
@@ -553,7 +553,7 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    if (find_phb(spapr, sphb->buid)) {
+    if (spapr_pci_find_phb(spapr, sphb->buid)) {
         error_setg(errp, "PCI host bridges must have unique BUIDs");
         return;
     }
diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
index 32f0aa7..14c2ab0 100644
--- a/include/hw/pci-host/spapr.h
+++ b/include/hw/pci-host/spapr.h
@@ -122,4 +122,8 @@ void spapr_pci_msi_init(sPAPREnvironment *spapr, hwaddr addr);
 
 void spapr_pci_rtas_init(void);
 
+sPAPRPHBState *spapr_pci_find_phb(sPAPREnvironment *spapr, uint64_t buid);
+PCIDevice *spapr_pci_find_dev(sPAPREnvironment *spapr, uint64_t buid,
+                              uint32_t config_addr);
+
 #endif /* __HW_SPAPR_PCI_H__ */
-- 
2.0.0
