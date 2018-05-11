Return-Path: <ukrishn@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40jKJp30kFzF2pD
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 May 2018 05:04:22 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4BIx2RR061696
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 May 2018 15:04:19 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2hwdhx8yds-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 May 2018 15:04:19 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ukrishn@linux.vnet.ibm.com>;
 Fri, 11 May 2018 13:04:19 -0600
From: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
To: linux-scsi@vger.kernel.org, James Bottomley <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
Subject: [PATCH 0/7] Miscellaneous patches and bug fixes
Date: Fri, 11 May 2018 14:04:00 -0500
Message-Id: <1526065440-38806-1-git-send-email-ukrishn@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch series adds few improvements to the cxlflash driver and
it also contains couple of bug fixes.

This patch series is intended for 4.18 and is bisectable.

Matthew R. Ochs (1):
  cxlflash: Use local mutex for AFU serialization

Uma Krishnan (6):
  cxlflash: Yield to active send threads
  cxlflash: Limit the debug logs in the IO path
  cxlflash: Acquire semaphore before invoking ioctl services
  cxlflash: Add include guards to backend.h
  cxlflash: Abstract hardware dependent assignments
  cxlflash: Isolate external module dependencies

 drivers/scsi/cxlflash/Kconfig     |  2 +-
 drivers/scsi/cxlflash/Makefile    |  4 +++-
 drivers/scsi/cxlflash/backend.h   |  5 +++++
 drivers/scsi/cxlflash/common.h    |  1 +
 drivers/scsi/cxlflash/lunmgt.c    |  4 +++-
 drivers/scsi/cxlflash/main.c      | 21 +++++++++------------
 drivers/scsi/cxlflash/main.h      | 20 ++++++++++++++++++++
 drivers/scsi/cxlflash/superpipe.c |  9 ++++++++-
 drivers/scsi/cxlflash/vlun.c      |  3 ++-
 9 files changed, 52 insertions(+), 17 deletions(-)

-- 
2.1.0
