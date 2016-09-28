Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3skPxR6d5XzDrWL
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Sep 2016 14:34:35 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8S4X3KO079989
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Sep 2016 00:34:34 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25r4h0xe5n-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Sep 2016 00:34:33 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 28 Sep 2016 14:34:31 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 262DC3578058
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Sep 2016 14:34:29 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8S4YToh1638744
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Sep 2016 14:34:29 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8S4YSPE011608
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Sep 2016 14:34:28 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: bhelgaas@google.com, mpe@ellerman.id.au,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v3 0/6] powerpc/powernv: PCI Surprise Hotplug Support
Date: Wed, 28 Sep 2016 14:34:52 +1000
Message-Id: <1475037298-19188-1-git-send-email-gwshan@linux.vnet.ibm.com>
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

PATCH[1/6] to PATCH[3/6] allow to freeze PEs to avoid unexpected EEH error
reporting in PCI surprise hot remove path. PATCH[4/6] clears PE's frozen state
on initializing it because the PE might have been put into frozen state in last
PCI surprise hot remove. PATCH[5/6] removes likely() and unlikely() in pnv_php.c
as they are not too useful. PATCH[6/6] supports PCI surprise hotplug for PowerNV
PCI hotplug driver.

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

Gavin Shan (6):
  powerpc/eeh: Allow to freeze PE in eeh_pe_set_option()
  powerpc/eeh: Export confirm_error_lock
  powerpc/eeh: Export eeh_pe_state_mark()
  powerpc/powernv: Unfreeze PE on allocation
  drivers/pci/hotplug: Remove likely() and unlikely() in powernv driver
  drivers/pci/hotplug: Support surprise hotplug in powernv driver

 arch/powerpc/include/asm/pnv-pci.h        |   2 +
 arch/powerpc/kernel/eeh.c                 |   2 +
 arch/powerpc/kernel/eeh_pe.c              |   1 +
 arch/powerpc/platforms/powernv/pci-ioda.c |  12 ++
 drivers/pci/hotplug/pnv_php.c             | 268 ++++++++++++++++++++++++++----
 5 files changed, 257 insertions(+), 28 deletions(-)

-- 
2.1.0
