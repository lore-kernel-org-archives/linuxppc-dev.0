Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sl3c007yyzDsff
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Sep 2016 15:51:43 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8T5m5XR022209
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Sep 2016 01:51:42 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25ruyvt20p-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Sep 2016 01:51:41 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 29 Sep 2016 15:51:39 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 103582BB0057
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Sep 2016 15:51:37 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8T5pbMs65929434
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Sep 2016 15:51:37 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8T5palY016712
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Sep 2016 15:51:36 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: bhelgaas@google.com, mpe@ellerman.id.au,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v4 0/7] powerpc/powernv: PCI Surprise Hotplug Support
Date: Thu, 29 Sep 2016 15:51:58 +1000
Message-Id: <1475128325-5367-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series of patches supports PCI surprise hotplug on PowerNV platform.
Without the corresponding skiboot patches, this feature won't be enabled
and workable.

   * The skiboot patches can be found in below link (PATCH[01/16):
     https://patchwork.ozlabs.org/project/skiboot/list/?submitter=63923
   * This newly added functionality depends on skiboot's changes. However,
     the functionality is disabled simply when skiboot doesn't support it.
     For one specific slot, property "ibm,slot-surprise-pluggable" of the
     slot's device node is set to 1 when surprise hotplug is claimed by
     skiboot.
   * The interrupts because of presence and link state change are enabled
     in order to support PCI surprise hotplug. The surprise hotplug events
     are queued to the PCI slot and they're picked up for further processing
     in serialized fashion. The surprise and managed hotplug share same code
     flow except: the affected PEs are put into frozen state to avoid unexpected
     EEH error reporting in surprise hot remove path.

PATCH[1/7] to PATCH[3/7] allow to freeze PEs to avoid unexpected EEH error
reporting in PCI surprise hot remove path. PATCH[4/7] clears PE's frozen state
on initializing it because the PE might have been put into frozen state in last
PCI surprise hot remove. PATCH[5/7] removes likely() and unlikely() in pnv_php.c
as they are not too useful. PATCH[6/7] replaces of_get_property() with of_property_
read_u32() and of_property_read_string(). PATCH[7/7] supports PCI surprise hotplug
for PowerNV PCI hotplug driver.

Changelog
=========
v2:
   * Add one patch to remove likely() and unlikely() in pnv_php.c.
   * Remove likely() and unlikely() in PATCH[v1 4/4].
   * The event isn't pre-allocated. It's always allocated from slab
     in the interrupt handler. The removed PE is put into frozen state
     before the event is allocated.
v3:
   * Add one patch to export confirm_error_lock to avoid building error
     when having CONFIG_HOTPLUG_PCI_POWERNV=m
v4:
   * Add patch to replace of_get_property() with of_property_read_u32()
     and of_property_read_string(). Also, the of_get_property() in last
     patch was replaced to of_property_read_u32().

Gavin Shan (7):
  powerpc/eeh: Allow to freeze PE in eeh_pe_set_option()
  powerpc/eeh: Export confirm_error_lock
  powerpc/eeh: Export eeh_pe_state_mark()
  powerpc/powernv: Unfreeze PE on allocation
  drivers/pci/hotplug: Remove likely() and unlikely() in powernv driver
  drivers/pci/hotplug: Use of_property_read_u32() in powernv driver
  drivers/pci/hotplug: Support surprise hotplug in powernv driver

 arch/powerpc/include/asm/pnv-pci.h        |   2 +
 arch/powerpc/kernel/eeh.c                 |   2 +
 arch/powerpc/kernel/eeh_pe.c              |   1 +
 arch/powerpc/platforms/powernv/pci-ioda.c |  12 ++
 drivers/pci/hotplug/pnv_php.c             | 281 ++++++++++++++++++++++++++----
 5 files changed, 264 insertions(+), 34 deletions(-)

-- 
2.1.0
