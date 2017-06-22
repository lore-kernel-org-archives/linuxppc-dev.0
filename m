Return-Path: <ukrishn@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wtQ9B6P9ZzDsZr
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 12:13:18 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5M2A712103222
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 22:13:16 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b7vn7d6jj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 22:13:16 -0400
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ukrishn@linux.vnet.ibm.com>;
 Wed, 21 Jun 2017 22:13:15 -0400
From: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
To: linux-scsi@vger.kernel.org, James Bottomley <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
Subject: [PATCH 00/17] cxlflash: LUN provisioning support and miscellaneous
 fixes
Date: Wed, 21 Jun 2017 21:12:43 -0500
Message-Id: <1498097563-8680-1-git-send-email-ukrishn@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch series contains miscellaneous fixes and several enhancements
such as LUN provisioning support, WS16 unmap and AFU debug capabilities.

This series is intended for 4.13 and is bisectable.

Matthew R. Ochs (8):
  cxlflash: Separate AFU internal command handling from AFU sync
    specifics
  cxlflash: Introduce host ioctl support
  cxlflash: Refactor AFU capability checking
  cxlflash: Support LUN provisioning
  cxlflash: Support AFU debug
  cxlflash: Support WS16 unmap
  cxlflash: Remove zeroing of private command data
  cxlflash: Update TMF command processing

Uma Krishnan (9):
  cxlflash: Combine the send queue locks
  cxlflash: Update cxlflash_afu_sync() to return errno
  cxlflash: Reset hardware queue context via specified register
  cxlflash: Schedule asynchronous reset of the host
  cxlflash: Handle AFU sync failures
  cxlflash: Track pending scsi commands in each hardware queue
  cxlflash: Flush pending commands in cleanup path
  cxlflash: Add scsi command abort handler
  cxlflash: Create character device to provide host management interface

 Documentation/ioctl/ioctl-number.txt |    2 +-
 Documentation/powerpc/cxlflash.txt   |   76 ++-
 drivers/scsi/cxlflash/common.h       |   48 +-
 drivers/scsi/cxlflash/main.c         | 1008 ++++++++++++++++++++++++++++++----
 drivers/scsi/cxlflash/main.h         |    7 +
 drivers/scsi/cxlflash/sislite.h      |   27 +-
 drivers/scsi/cxlflash/superpipe.c    |   34 +-
 drivers/scsi/cxlflash/vlun.c         |   89 ++-
 include/uapi/scsi/cxlflash_ioctl.h   |   85 ++-
 9 files changed, 1217 insertions(+), 159 deletions(-)

-- 
2.1.0
