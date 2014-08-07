Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E45C81A088C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Aug 2014 12:47:29 +1000 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 7 Aug 2014 08:17:27 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id DA8AB1258019
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Aug 2014 08:17:28 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s772nYYB5243306
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Aug 2014 08:19:34 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s772lOJn029922
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Aug 2014 08:17:24 +0530
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 0/5] drivers/vfio: EEH Compile and compatibility
Date: Thu,  7 Aug 2014 12:47:15 +1000
Message-Id: <1407379640-13065-1-git-send-email-gwshan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: aik@ozlabs.ru, alex.williamson@redhat.com,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patchset is mainly for fixing errors from building VFIO compoments
as dynamic modules. PATCH[4/4] allows VFIO can be used though EEH fails
to initialize for VFIO PCI devices.


Alexey Kardashevskiy (2):
  drivers/vfio: Allow EEH to be built as module
  drivers/vfio: Enable VFIO if EEH is not supported

Gavin Shan (3):
  powerpc/eeh: Export eeh_iommu_group_to_pe()
  powerpc/eeh: Add warning message in eeh_dev_open()
  drivers/vfio: Fix EEH build error

 arch/powerpc/kernel/eeh.c     |  6 +++++-
 drivers/vfio/Kconfig          |  6 ++++++
 drivers/vfio/Makefile         |  2 +-
 drivers/vfio/pci/vfio_pci.c   |  6 +-----
 drivers/vfio/vfio_spapr_eeh.c | 17 +++++++++++++++--
 include/linux/vfio.h          |  6 +++---
 6 files changed, 31 insertions(+), 12 deletions(-)

--=20
1.8.3.2
