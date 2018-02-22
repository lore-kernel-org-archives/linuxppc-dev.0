Return-Path: <ukrishn@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3znTMN5RvmzF1jF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Feb 2018 09:20:43 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1MMKdDH137900
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 17:20:40 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ga2pjr94w-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 17:20:40 -0500
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ukrishn@linux.vnet.ibm.com>;
 Thu, 22 Feb 2018 15:20:26 -0700
From: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
To: linux-scsi@vger.kernel.org, James Bottomley <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
Subject: [PATCH 00/38] cxlflash: OpenCXL transport support
Date: Thu, 22 Feb 2018 16:20:10 -0600
Message-Id: <1519338010-51782-1-git-send-email-ukrishn@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch series adds OpenCXL support to the cxlflash driver. With
this support, new devices using the OpenCXL transport will be supported
by the cxlflash driver along with the existing CXL devices. An effort is
made to keep this transport specific function independent of the existing
core driver that communicates with the AFU.

The first three patches contain a minor fix and staging improvements.

This series is intended for 4.17 and is bisectable.

Matthew R. Ochs (1):
  cxlflash: Avoid clobbering context control register value

Uma Krishnan (37):
  cxlflash: Preserve number of interrupts for master contexts
  cxlflash: Add argument identifier names
  cxlflash: Introduce OpenCXL backend
  cxlflash: Hardware AFU for OpenCXL
  cxlflash: Read host function configuration
  cxlflash: Setup function acTag range
  cxlflash: Read host AFU configuration
  cxlflash: Setup AFU acTag range
  cxlflash: Setup AFU PASID
  cxlflash: Adapter context support for OpenCXL
  cxlflash: Use IDR to manage adapter contexts
  cxlflash: Support adapter file descriptors for OpenCXL
  cxlflash: Support adapter context discovery
  cxlflash: Support image reload policy modification
  cxlflash: MMIO map the AFU
  cxlflash: Support starting an adapter context
  cxlflash: Support process specific mappings
  cxlflash: Support AFU state toggling
  cxlflash: Support reading adapter VPD data
  cxlflash: Setup function OpenCXL link
  cxlflash: Setup OpenCXL transaction layer
  cxlflash: Support process element lifecycle
  cxlflash: Support AFU interrupt management
  cxlflash: Support AFU interrupt mapping and registration
  cxlflash: Support starting user contexts
  cxlflash: Support adapter context polling
  cxlflash: Support adapter context reading
  cxlflash: Support adapter context mmap and release
  cxlflash: Support file descriptor mapping
  cxlflash: Introduce object handle fop
  cxlflash: Setup LISNs for user contexts
  cxlflash: Setup LISNs for master contexts
  cxlflash: Update synchronous interrupt status bits
  cxlflash: Introduce OCXL context state machine
  cxlflash: Register for translation errors
  cxlflash: Support AFU reset
  cxlflash: Enable OpenCXL operations

 drivers/scsi/cxlflash/Kconfig     |    2 +-
 drivers/scsi/cxlflash/Makefile    |    2 +-
 drivers/scsi/cxlflash/backend.h   |   50 +-
 drivers/scsi/cxlflash/common.h    |   10 +-
 drivers/scsi/cxlflash/cxl_hw.c    |   13 +
 drivers/scsi/cxlflash/main.c      |   55 +-
 drivers/scsi/cxlflash/main.h      |    1 +
 drivers/scsi/cxlflash/ocxl_hw.c   | 1428 +++++++++++++++++++++++++++++++++++++
 drivers/scsi/cxlflash/ocxl_hw.h   |   76 ++
 drivers/scsi/cxlflash/sislite.h   |   41 +-
 drivers/scsi/cxlflash/superpipe.c |   14 +
 11 files changed, 1644 insertions(+), 48 deletions(-)
 create mode 100644 drivers/scsi/cxlflash/ocxl_hw.c
 create mode 100644 drivers/scsi/cxlflash/ocxl_hw.h

-- 
2.1.0
