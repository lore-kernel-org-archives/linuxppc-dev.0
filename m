Return-Path: <ukrishn@linux.vnet.ibm.com>
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qWtcj6VPQzDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Mar 2016 06:28:05 +1100 (AEDT)
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ukrishn@linux.vnet.ibm.com>;
 Fri, 25 Mar 2016 15:28:03 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 04162C90027
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Mar 2016 15:27:57 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2PJS1FW23986216
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Mar 2016 19:28:01 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2PJS0or012087
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Mar 2016 15:28:00 -0400
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
Subject: [PATCH v2 0/2] Fix regression and performance issue in cxlflash
Date: Fri, 25 Mar 2016 14:25:20 -0500
Message-Id: <1458933920-28788-1-git-send-email-ukrishn@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series has a couple of patches in cxlflash.

The first patch is critical as it fixes a regression that was introduced
by Commit 6ded8b3cbd9a ("cxlflash: Unmap problem state area before
detaching master context") as part of the first SCSI push for v4.6.

The second patch addresses a performance issue.

This series is intended for v4.6 and is bisectable. We would like to see
these included in the second merge window push for v4.6 (if there is one).
Otherwise these can be a candidate for v4.6-rc2.

v2 Changes:
- Added the ack/review tags including one which was sent privately.

Manoj N. Kumar (2):
  cxlflash: Fix regression issue with re-ordering patch
  cxlflash: Move to exponential back-off when cmd_room is not available

 drivers/scsi/cxlflash/main.c | 138 +++++++++++++++++++++++++++++--------------
 drivers/scsi/cxlflash/main.h |   5 +-
 2 files changed, 97 insertions(+), 46 deletions(-)

-- 
2.1.0
