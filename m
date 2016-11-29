Return-Path: <ukrishn@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tSPq05JMFzDvjw
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 11:40:44 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAT0cbp1103504
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2016 19:40:42 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0b-001b2d01.pphosted.com with ESMTP id 270t5crve0-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2016 19:40:42 -0500
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ukrishn@linux.vnet.ibm.com>;
 Mon, 28 Nov 2016 17:40:41 -0700
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
Subject: [PATCH v2 00/14] cxlflash: Fixes, enhancements, cleanup and staging
Date: Mon, 28 Nov 2016 18:39:44 -0600
Message-Id: <1480379984-60114-1-git-send-email-ukrishn@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The first four patches in this patch series include fixes for command
room violation and lun table management.

The remaining patches remove the reliance upon an internally maintained
private command pool in favor of private commands being allocated
alongside the SCSI commands. Several cleanup opportunities were noticed
while removing the private command pool infrastructure and have been
included as well. Lastly, the final two patches provide staging for
supporting hardware with a different queuing model.

The series is based upon 4.9-rc5, intended for 4.10 and is bisectable.

v2 Changes:
- Incorporate comments from Matthew R. Ochs
- Updated command room violation patch to use a spin lock

Matthew R. Ochs (10):
  cxlflash: Remove unused buffer from AFU command
  cxlflash: Allocate memory instead of using command pool for AFU sync
  cxlflash: Use cmd_size for private commands
  cxlflash: Remove private command pool
  cxlflash: Wait for active AFU commands to timeout upon tear down
  cxlflash: Remove AFU command lock
  cxlflash: Cleanup send_tmf()
  cxlflash: Cleanup queuecommand()
  cxlflash: Migrate IOARRIN specific routines to function pointers
  cxlflash: Migrate scsi command pointer to AFU command

Uma Krishnan (4):
  cxlflash: Set sg_tablesize to 1 instead of SG_NONE
  cxlflash: Fix crash in cxlflash_restore_luntable()
  cxlflash: Improve context_reset() logic
  cxlflash: Avoid command room violation

 drivers/scsi/cxlflash/common.h  |  39 ++--
 drivers/scsi/cxlflash/lunmgt.c  |   6 +
 drivers/scsi/cxlflash/main.c    | 410 ++++++++++------------------------------
 drivers/scsi/cxlflash/sislite.h |   2 +-
 4 files changed, 130 insertions(+), 327 deletions(-)

-- 
2.1.0
