Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B3AA71A2C04
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2015 16:25:33 +1000 (AEST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 18 Sep 2015 16:25:30 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 485B32BB004D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2015 16:25:27 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8I6P9Go58065028
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2015 16:25:17 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8I6OsIC003810
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2015 16:24:54 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, david@gibson.dropbear.id.au,
 alex.williamson@redhat.com, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH 0/2] VFIO: Accept IOMMU group (PE) ID
Date: Fri, 18 Sep 2015 16:24:27 +1000
Message-Id: <1442557469-22185-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This allows to accept IOMMU group (PE) ID from the parameter from userland
when handling EEH operation so that the operation only affects the target
IOMMU group (PE). If the IOMMU group (PE) ID in the parameter from userland
is invalid, all IOMMU groups (PEs) attached to the specified container are
affected as before.

Gavin Shan (2):
  drivers/vfio: Support EEH API revision
  drivers/vfio: Support IOMMU group for EEH operations

 drivers/vfio/vfio_iommu_spapr_tce.c | 50 ++++++++++++++++++++++++++++++++++---
 drivers/vfio/vfio_spapr_eeh.c       | 46 ++++++++++++++++++++++------------
 include/linux/vfio.h                | 13 +++++++---
 include/uapi/linux/vfio.h           |  6 +++++
 4 files changed, 93 insertions(+), 22 deletions(-)

-- 
2.1.0
