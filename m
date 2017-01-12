Return-Path: <ukrishn@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tzSZV4vlVzDqNL
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jan 2017 12:18:42 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 v0C0xI2u082665
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jan 2017 20:18:40 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27wrqm11ex-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jan 2017 20:18:40 -0500
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ukrishn@linux.vnet.ibm.com>;
 Wed, 11 Jan 2017 18:18:39 -0700
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
Subject: [PATCH v2 0/4] cxlflash: Enhancements, cleanup and fixes
Date: Wed, 11 Jan 2017 19:18:18 -0600
Message-Id: <1484183898-22714-1-git-send-email-ukrishn@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch series includes an enhancement to support a new command queuing
model and also cleans up prints throughout the driver. The last patch in
the series fixes a racing issue.

The series is based upon v4.10-rc2, intended for 4.11 and is bisectable.

v2 Changes:
- Fixed SOBs for all the submitted patches

Matthew R. Ochs (3):
  cxlflash: Refactor context reset to share reset logic
  cxlflash: Support SQ Command Mode
  cxlflash: Cleanup prints

Uma Krishnan (1):
  cxlflash: Cancel scheduled workers before stopping AFU

 drivers/scsi/cxlflash/common.h     |  32 ++-
 drivers/scsi/cxlflash/lunmgt.c     |  31 +--
 drivers/scsi/cxlflash/main.c       | 465 +++++++++++++++++++++----------------
 drivers/scsi/cxlflash/sislite.h    |  19 +-
 drivers/scsi/cxlflash/superpipe.c  | 183 ++++++++-------
 drivers/scsi/cxlflash/vlun.c       | 169 +++++++-------
 include/uapi/scsi/cxlflash_ioctl.h |   1 +
 7 files changed, 518 insertions(+), 382 deletions(-)

-- 
2.1.0
