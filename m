Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9C4521A0B9B
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Dec 2014 16:51:10 +1100 (AEDT)
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5F0C514010B
 for <linuxppc-dev@ozlabs.org>; Thu,  4 Dec 2014 16:51:09 +1100 (AEDT)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 4 Dec 2014 11:21:07 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id EC54C3940057
 for <linuxppc-dev@ozlabs.org>; Thu,  4 Dec 2014 11:21:04 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sB45peW127984024
 for <linuxppc-dev@ozlabs.org>; Thu, 4 Dec 2014 11:21:41 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sB45p3ea001355
 for <linuxppc-dev@ozlabs.org>; Thu, 4 Dec 2014 11:21:03 +0530
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2 0/3] powerpc/pci: PCI slot unified reset
Date: Thu,  4 Dec 2014 16:50:50 +1100
Message-Id: <1417672253-26692-1-git-send-email-gwshan@linux.vnet.ibm.com>
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
PCI slot reset OPAL API - this patchset; (B) powernv-php driver to
support PCI hotplug for PowerNV platform, which will be sent separately.

This patchset affects EEH, PCI reset logics, which is used mainly by
VFIO. A couple of cases have been tested out on P7/P8 boxes and looks
good: EEH on PowerNV, EEH support for guest, PCI passthrou.

Changelog
=========
v1 -> v2
        * Keep opal_pci_reinit(). In case the slot is resetted by kernel,
          instead of skiboot, this API should be called to restore states
          for those affected devices.
        * Reworked slot ID scheme so that old/new kernel can work with
          skiboot with or without unified PCI slot management support.
        * Code cleanup here and there.

Gavin Shan (3):
  powerpc/powernv: Use PCI slot reset infrastructure
  powerpc/powernv: Refactor ioda_eeh_reset()
  powerpc/powernv: Issue fundamental reset if required

 arch/powerpc/include/asm/eeh.h            |   1 +
 arch/powerpc/include/asm/opal.h           |   9 +-
 arch/powerpc/platforms/powernv/eeh-ioda.c | 240 ++++++++++++++++--------------
 3 files changed, 132 insertions(+), 118 deletions(-)

Thanks,
Gavin
