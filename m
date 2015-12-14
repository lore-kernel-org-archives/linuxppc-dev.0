Return-Path: <ukrishn@linux.vnet.ibm.com>
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49DE71A11C0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Dec 2015 07:56:26 +1100 (AEDT)
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ukrishn@linux.vnet.ibm.com>;
 Mon, 14 Dec 2015 15:56:24 -0500
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id A8952C9003E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Dec 2015 15:44:30 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tBEKuLLv27001006
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Dec 2015 20:56:21 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tBEKuLas021605
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Dec 2015 15:56:21 -0500
From: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
To: linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>,
 Brian King <brking@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Daniel Axtens <dja@ozlabs.au.ibm.com>
Subject: [PATCH v2 0/6] cxlflash: Miscellaneous fixes and updates
Date: Mon, 14 Dec 2015 14:55:43 -0600
Message-Id: <1450126544-47592-1-git-send-email-ukrishn@linux.vnet.ibm.com>
In-Reply-To: <1450126293-47440-1-git-send-email-ukrishn@linux.vnet.ibm.com>
References: <1450126293-47440-1-git-send-email-ukrishn@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch set contains miscellaneous fixes and adds support for
a future IBM CXL adapter. This series is intended for 4.5 and is
bisectable. Please reference the changelog below for details on
what has been altered from previous versions of this patch set.

v2 Changes:
- Incorporate comments from Daniel Axtens
- Incorporate comments from Andrew Donnellan
- Removed driver date and simplified driver load print
- Clarified driver behavior for the future adapter

Manoj Kumar (4):
  cxlflash: Fix to escalate LINK_RESET also on port 1
  cxlflash: Fix to resolve cmd leak after host reset
  cxlflash: Resolve oops in wait_port_offline
  cxlflash: Enable device id for future IBM CXL adapter

Matthew R. Ochs (1):
  cxlflash: Fix to avoid virtual LUN failover failure

Uma Krishnan (1):
  cxlflash: Removed driver date print

 drivers/scsi/cxlflash/common.h     |  2 ++
 drivers/scsi/cxlflash/main.c       | 54 ++++++++++++++++++++++++++++++++------
 drivers/scsi/cxlflash/main.h       |  5 ++--
 drivers/scsi/cxlflash/vlun.c       |  2 ++
 include/uapi/scsi/cxlflash_ioctl.h | 10 +++++++
 5 files changed, 62 insertions(+), 11 deletions(-)

-- 
2.1.0
