Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5FB2E1A0026
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Feb 2016 12:32:42 +1100 (AEDT)
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Wed, 10 Feb 2016 20:32:39 -0500
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 73720C9003E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 20:32:33 -0500 (EST)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1B1WZxn27394048
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Feb 2016 01:32:35 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1B1TIU4003594
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 20:29:18 -0500
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
To: james.bottomley@hansenpartnership.com
Cc: martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 nfont@linux.vnet.ibm.com, brking@linux.vnet.ibm.com,
 jthumshirn@suse.de, manoj@linux.vnet.ibm.com,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Subject: [PATCH v2 0/7] ibmvscsi code cleanup
Date: Wed, 10 Feb 2016 19:32:21 -0600
Message-Id: <1455154348-3226-1-git-send-email-tyreld@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fixed up a couple spots that were out of line with the PAPR in regards
to its defined VSCSI protocol. Did away with some magic numbers directly
in the code. Fixed a minor endian issue.

--

v2 changes:

-Renamed CRQ header enums and added enums for INIT formats
-Check that crq->valid != VIOSRP_CRQ_FREE before handling in place
of hacky bitwise & to check for first bit being set.
-Added define for AIX os_type
-Left sysfs config attribute to prevent breaking userspace

Tyrel Datwyler (7):
  ibmvscsi: Correct values for several viosrp_crq_format enums
  ibmvscsi: Add and use enums for valid CRQ header values
  ibmvscsi: Replace magic values in set_adpater_info() with defines
  ibmvscsi: Use of_root to access OF device tree root node
  ibmvscsi: Remove unsupported host config MAD
  ibmvscsi: Add endian conversions to sysfs attribute show functions
  ibmvscsi: use H_CLOSED instead of magic number

 drivers/scsi/ibmvscsi/ibmvscsi.c | 128 ++++++++++-----------------------------
 drivers/scsi/ibmvscsi/viosrp.h   |  26 +++++---
 2 files changed, 49 insertions(+), 105 deletions(-)

-- 
2.5.0
