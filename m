Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5ED441A0BEC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Feb 2015 15:56:02 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 13 Feb 2015 14:56:01 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 937872CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Feb 2015 15:55:58 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1D4toPI39321796
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Feb 2015 15:55:58 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1D4tOjC013548
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Feb 2015 15:55:25 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Subject: [PATCH 0/4] Support registering specific reset handler
Date: Fri, 13 Feb 2015 15:54:55 +1100
Message-Id: <1423803299-22356-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: bhelgaas@google.com, linuxppc-dev@lists.ozlabs.org,
 cascardo@linux.vnet.ibm.com, Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

VFIO PCI infrastructure depends on pci_reset_function() to do reset on
PCI devices so that they would be in clean state when host or guest grabs
them. Unfortunately, the function doesn't work (or not well) on some PCI
devices that require EEH PE reset.

The patchset extends the quirk for PCI device speicific reset methods to
allow dynamically registration. With it, we can translate reset requests
for those special PCI devcies to EEH PE reset, which is only avaialble on
64-bits PowerPC platforms.

Gavin Shan (4):
  PCI: Rename struct pci_dev_reset_methods
  PCI: Introduce list for device reset methods
  PCI: Allow registering reset method
  powerpc/powernv: Register PCI dev specific reset handlers

 arch/powerpc/platforms/powernv/pci.c |  61 +++++++++++++++
 drivers/pci/pci.h                    |   3 +-
 drivers/pci/quirks.c                 | 139 ++++++++++++++++++++++++++++++-----
 include/linux/pci.h                  |   9 +++
 4 files changed, 192 insertions(+), 20 deletions(-)

-- 
1.8.3.2
