Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sfJVW3Vs4zDshM
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 22:15:31 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3sfJVV1ShMz9sxb
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Sep 2016 22:15:29 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8LCDL7e004329
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Sep 2016 08:15:27 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0b-001b2d01.pphosted.com with ESMTP id 25kjkx36kb-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Sep 2016 08:15:27 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 21 Sep 2016 22:15:24 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 411FE2CE8057
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Sep 2016 22:15:21 +1000 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8LCFLK62032120
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Sep 2016 22:15:21 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8LCFK9e015768
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Sep 2016 22:15:20 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org, linuxppc-dev@ozlabs.org
Cc: bhelgaas@google.com, mpe@ellerman.id.au,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH 0/4] powerpc/powernv: PCI Surprise Hotplug Support
Date: Wed, 21 Sep 2016 22:15:26 +1000
Message-Id: <1474460130-8316-1-git-send-email-gwshan@linux.vnet.ibm.com>
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

PATCH[1/4] and PATCH[2/4] allows to freeze PEs to avoid unexpected EEH error
reporting in PCI surprise hot remove path. PATCH[3/4] clears PE's frozen state
on initializing it because the PE might have been put into frozen state in last
PCI surprise hot remove. PATCH[4/4] supports PCI surprise hotplug in the PowerNV
PCI hotplug driver.

Gavin Shan (4):
  powerpc/eeh: Allow to freeze PE in eeh_pe_set_option()
  powerpc/eeh: Export eeh_pe_state_mark()
  powerpc/powernv: Unfreeze PE on allocation
  drivers/pci/hotplug: Support surprise hotplug

 arch/powerpc/include/asm/pnv-pci.h        |   9 ++
 arch/powerpc/kernel/eeh.c                 |   1 +
 arch/powerpc/kernel/eeh_pe.c              |   1 +
 arch/powerpc/platforms/powernv/pci-ioda.c |  12 ++
 drivers/pci/hotplug/pnv_php.c             | 219 ++++++++++++++++++++++++++++++
 5 files changed, 242 insertions(+)

-- 
2.1.0
