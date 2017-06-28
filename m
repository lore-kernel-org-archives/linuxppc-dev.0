Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wyTr104svzDr3r
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 03:12:32 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5SH9IcW091804
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 13:12:30 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bcge08nbq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 13:12:30 -0400
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Wed, 28 Jun 2017 13:12:29 -0400
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
To: linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Uma Krishnan <ukrishn@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>,
 Hannes Reinecke <hare@suse.com>
Cc: Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
Subject: [PATCH 0/3] cxlflash: Minor fix and EH refactoring
Date: Wed, 28 Jun 2017 12:12:09 -0500
Message-Id: <1498669929-39684-1-git-send-email-mrochs@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This small series fixes a recently injected double free and also includes
two patches to refactor the host and reset handlers to ease the burden of
making this driver compatible with an updated SCSI EH framework.

This series is intended for 4.13 and is bisectable.

Matthew R. Ochs (3):
  cxlflash: Avoid double free of character device
  cxlflash: Update send_tmf() parameters
  cxlflash: Update debug prints in reset handlers

 drivers/scsi/cxlflash/main.c | 44 +++++++++++++++-----------------------------
 1 file changed, 15 insertions(+), 29 deletions(-)

-- 
2.1.0
