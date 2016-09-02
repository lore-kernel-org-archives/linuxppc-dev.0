Return-Path: <ukrishn@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sQrYV6YGPzDrpK
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Sep 2016 06:38:22 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u82KXdIN139444
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Sep 2016 16:38:20 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25756bsas7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Sep 2016 16:38:20 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ukrishn@linux.vnet.ibm.com>;
 Fri, 2 Sep 2016 14:38:19 -0600
From: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
To: linux-scsi@vger.kernel.org, James Bottomley <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Cc: Brian King <brking@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
Subject: [PATCH 0/6] cxlflash: Miscellaneous fixes
Date: Fri,  2 Sep 2016 15:36:52 -0500
Message-Id: <1472848612-64888-1-git-send-email-ukrishn@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch set contains miscellaneous fixes in the device cleanup and
EEH recovery paths. One of the patches simplifies the WWPN assignment
routine.

There are a couple of fixes that resolve regressions introduced by
Commit 704c4b0ddc03 ("cxlflash: Shutdown notify support for CXL Flash
cards") and Commit 888baf069f49 ("scsi: cxlflash: Add kref to context")

This series is based upon mkp's 4.9/scsi-queue and is bisectable.

Matthew R. Ochs (4):
  cxlflash: Fix to avoid EEH and host reset collisions
  cxlflash: Improve EEH recovery time
  cxlflash: Refactor WWPN setup
  cxlflash: Fix context reference tracking on detach

Uma Krishnan (2):
  cxlflash: Scan host only after the port is ready for I/O
  cxlflash: Remove the device cleanly in the system shutdown path

 drivers/scsi/cxlflash/main.c      | 81 +++++++++++++++++----------------------
 drivers/scsi/cxlflash/superpipe.c |  3 +-
 2 files changed, 37 insertions(+), 47 deletions(-)

-- 
2.1.0
