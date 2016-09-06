Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sStb1549dzDrpp
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Sep 2016 14:16:45 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3sStb11mkWz9s9G
 for <linuxppc-dev@ozlabs.org>; Tue,  6 Sep 2016 14:16:45 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u864DHF2079918
 for <linuxppc-dev@ozlabs.org>; Tue, 6 Sep 2016 00:16:43 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 259d2rhr7p-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 06 Sep 2016 00:16:43 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 6 Sep 2016 14:16:38 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 7F5DD2BB005A
 for <linuxppc-dev@ozlabs.org>; Tue,  6 Sep 2016 14:16:36 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u864GaxI61079716
 for <linuxppc-dev@ozlabs.org>; Tue, 6 Sep 2016 14:16:36 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u864GZhU003814
 for <linuxppc-dev@ozlabs.org>; Tue, 6 Sep 2016 14:16:36 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: andonnel@au1.ibm.com, fbarrat@linux.vnet.ibm.com, mpe@ellerman.id.au,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/powernv: Fix crash on releasing compound PE
Date: Tue,  6 Sep 2016 14:16:44 +1000
Message-Id: <1473135404-32631-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The compound PE is created to accommodate the devices attached to
one specific PCI bus that consume multiple M64 segments. The compound
PE is made up of one master PE and possibly multiple slave PEs. The
slave PEs should be destroyed when releasing the master PE. A kernel
crash happens when derferencing @pe->pdev on releasing the slave PE
in pnv_ioda_deconfigure_pe().

  # echo 0 > /sys/bus/pci/slots/C7/power
  iommu: Removing device 0000:01:00.1 from group 0
  iommu: Removing device 0000:01:00.0 from group 0
  Unable to handle kernel paging request for data at address 0x00000010
  Faulting instruction address: 0xc00000000005d898
  cpu 0x1: Vector: 300 (Data Access) at [c000000fe8217620]
      pc: c00000000005d898: pnv_ioda_release_pe+0x288/0x610
      lr: c00000000005dbdc: pnv_ioda_release_pe+0x5cc/0x610
      sp: c000000fe82178a0
     msr: 9000000000009033
     dar: 10
   dsisr: 40000000
    current = 0xc000000fe815ab80
    paca    = 0xc00000000ff00400	 softe: 0	 irq_happened: 0x01
      pid   = 2709, comm = sh
  Linux version 4.8.0-rc5-gavin-00006-g745efdb (gwshan@gwshan) \
  (gcc version 4.9.3 (Buildroot 2016.02-rc2-00093-g5ea3bce) ) #586 SMP \
  Tue Sep 6 13:37:29 AEST 2016
  enter ? for help
  [c000000fe8217940] c00000000005d684 pnv_ioda_release_pe+0x74/0x610
  [c000000fe82179e0] c000000000034460 pcibios_release_device+0x50/0x70
  [c000000fe8217a10] c0000000004aba80 pci_release_dev+0x50/0xa0
  [c000000fe8217a40] c000000000704898 device_release+0x58/0xf0
  [c000000fe8217ac0] c000000000470510 kobject_release+0x80/0xf0
  [c000000fe8217b00] c000000000704dd4 put_device+0x24/0x40
  [c000000fe8217b20] c0000000004af94c pci_remove_bus_device+0x12c/0x150
  [c000000fe8217b60] c000000000034244 pci_hp_remove_devices+0x94/0xd0
  [c000000fe8217ba0] c0000000004ca444 pnv_php_disable_slot+0x64/0xb0
  [c000000fe8217bd0] c0000000004c88c0 power_write_file+0xa0/0x190
  [c000000fe8217c50] c0000000004c248c pci_slot_attr_store+0x3c/0x60
  [c000000fe8217c70] c0000000002d6494 sysfs_kf_write+0x94/0xc0
  [c000000fe8217cb0] c0000000002d50f0 kernfs_fop_write+0x180/0x260
  [c000000fe8217d00] c0000000002334a0 __vfs_write+0x40/0x190
  [c000000fe8217d90] c000000000234738 vfs_write+0xc8/0x240
  [c000000fe8217de0] c000000000236250 SyS_write+0x60/0x110
  [c000000fe8217e30] c000000000009524 system_call+0x38/0x108

It fixes the kernel crash by bypassing releasing resources (DMA,
IO and memory segments, PELTM) because there are no resources assigned
to the slave PE.

Fixes: c5f7700bbd2e ("powerpc/powernv: Dynamically release PE")
Reported-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 1321826..18f6fd1 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -3402,12 +3402,6 @@ static void pnv_ioda_release_pe(struct pnv_ioda_pe *pe)
 	struct pnv_phb *phb = pe->phb;
 	struct pnv_ioda_pe *slave, *tmp;
 
-	/* Release slave PEs in compound PE */
-	if (pe->flags & PNV_IODA_PE_MASTER) {
-		list_for_each_entry_safe(slave, tmp, &pe->slaves, list)
-			pnv_ioda_release_pe(slave);
-	}
-
 	list_del(&pe->list);
 	switch (phb->type) {
 	case PNV_PHB_IODA1:
@@ -3422,6 +3416,15 @@ static void pnv_ioda_release_pe(struct pnv_ioda_pe *pe)
 
 	pnv_ioda_release_pe_seg(pe);
 	pnv_ioda_deconfigure_pe(pe->phb, pe);
+
+	/* Release slave PEs in the compound PE */
+	if (pe->flags & PNV_IODA_PE_MASTER) {
+		list_for_each_entry_safe(slave, tmp, &pe->slaves, list) {
+			list_del(&slave->list);
+			pnv_ioda_free_pe(slave);
+		}
+	}
+
 	pnv_ioda_free_pe(pe);
 }
 
-- 
2.1.0
