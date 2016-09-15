Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sZMHR4T7lzDsW3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 12:07:15 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3sZMHQ6y5kz9t0p
 for <linuxppc-dev@ozlabs.org>; Thu, 15 Sep 2016 12:07:14 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8F23J5Y083672
 for <linuxppc-dev@ozlabs.org>; Wed, 14 Sep 2016 22:07:13 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25ewqam1h5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 14 Sep 2016 22:07:12 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 15 Sep 2016 12:07:09 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 3D6FB2BB0054
 for <linuxppc-dev@ozlabs.org>; Thu, 15 Sep 2016 12:07:07 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8F277Bc2425174
 for <linuxppc-dev@ozlabs.org>; Thu, 15 Sep 2016 12:07:07 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8F276U3024587
 for <linuxppc-dev@ozlabs.org>; Thu, 15 Sep 2016 12:07:07 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH 0/4] powerpc/powernv: PCI Surprise Hotplug Support
Date: Thu, 15 Sep 2016 12:07:18 +1000
Message-Id: <1473905242-898-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series of patches supports PCI surprise hotplug on PowerNV platform.

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
