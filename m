Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2D3C91A0086
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Aug 2014 19:49:14 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 6 Aug 2014 19:49:12 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id CE4D72CE8050
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Aug 2014 19:49:09 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s769Q0an60358854
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Aug 2014 19:26:00 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s769n8AS000551
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Aug 2014 19:49:08 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 0/4] drivers/vfio: EEH Compile and compatibility
Date: Wed,  6 Aug 2014 19:49:01 +1000
Message-Id: <1407318545-17554-1-git-send-email-gwshan@linux.vnet.ibm.com>
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

Gavin Shan (2):
  powerpc/eeh: Export eeh_iommu_group_to_pe()
  drivers/vfio: Fix EEH build error

 arch/powerpc/kernel/eeh.c     |  1 +
 drivers/vfio/Kconfig          |  6 ++++++
 drivers/vfio/Makefile         |  2 +-
 drivers/vfio/pci/vfio_pci.c   |  6 +-----
 drivers/vfio/vfio_spapr_eeh.c | 17 +++++++++++++++--
 include/linux/vfio.h          |  6 +++---
 6 files changed, 27 insertions(+), 11 deletions(-)

--=20
1.8.3.2
