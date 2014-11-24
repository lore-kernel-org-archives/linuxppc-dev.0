Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C57EE1A0282
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Nov 2014 09:38:57 +1100 (AEDT)
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 16158140170
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2014 09:38:56 +1100 (AEDT)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 25 Nov 2014 04:08:55 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 6D96BE0044
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2014 04:09:14 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAOMf3gr5177820
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2014 04:11:03 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAOMcqDm021600
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2014 04:08:53 +0530
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v1 0/5] powerpc/pci: PCI slot unified reset
Date: Tue, 25 Nov 2014 09:38:42 +1100
Message-Id: <1416868727-5814-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patchset corresponds to skiboot changes, which manages PCI slots
in a unified way: OPAL APIs used to do slot reset, power management,
presence status retrival. The patchset shouldn't be merged before
the OPAL firmware counterpart is merged.

The kernel changes have been split into 2 parts: (A) Use the unified
PCI slot reset OPAL API - this patchset; (B) Changes to rpaphp.ko to
support PCI slot hotplug via sysfs entries for PowerPC PowerNV platform.

This patchset affects EEH, PCI reset logics, which is used mainly by
VFIO. A couple of cases have been tested out on P7/P8 boxes and looks
good: EEH on PowerNV, EEH support for guest, PCI passthrou.

Gavin Shan (5):
  powerpc/powernv: Use PCI slot reset infrastructure
  powerpc/powernv: Refactor ioda_eeh_reset()
  powerpc/powernv: Avoid do complete reset for twice
  powerpc/powernv: Issue fundamental reset if required
  powerpc/powernv: Drop opal_pci_reinit()

 arch/powerpc/include/asm/eeh.h                 |   2 +-
 arch/powerpc/include/asm/opal.h                |  31 +---
 arch/powerpc/kernel/eeh_pe.c                   |   3 -
 arch/powerpc/platforms/powernv/eeh-ioda.c      | 230 ++++++++++++++-----------
 arch/powerpc/platforms/powernv/eeh-powernv.c   |  24 +--
 arch/powerpc/platforms/powernv/opal-wrappers.S |   1 -
 arch/powerpc/platforms/powernv/pci-ioda.c      |   5 +-
 arch/powerpc/platforms/pseries/eeh_pseries.c   |   3 +-
 8 files changed, 139 insertions(+), 160 deletions(-)

Thanks,
Gavin
