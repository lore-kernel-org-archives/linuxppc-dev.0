Return-Path: <ukrishn@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qVgFK6bZJzDq6W
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Mar 2016 06:52:05 +1100 (AEDT)
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ukrishn@linux.vnet.ibm.com>;
 Wed, 23 Mar 2016 13:52:03 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id E8CD63E4003E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Mar 2016 13:52:00 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2NJq00U36438058
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Mar 2016 12:52:00 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2NJpwQS032599
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Mar 2016 13:52:00 -0600
From: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
To: linux-scsi@vger.kernel.org, James Bottomley <jejb@us.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Cc: Brian King <brking@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
Subject: [PATCH 0/2] Fix regression and performance issue in cxlflash
Date: Wed, 23 Mar 2016 14:49:32 -0500
Message-Id: <1458762572-44316-1-git-send-email-ukrishn@linux.vnet.ibm.com>
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

Manoj N. Kumar (2):
  cxlflash: Fix regression issue with re-ordering patch
  cxlflash: Move to exponential back-off when cmd_room is not available

 drivers/scsi/cxlflash/main.c | 138 +++++++++++++++++++++++++++++--------------
 drivers/scsi/cxlflash/main.h |   5 +-
 2 files changed, 97 insertions(+), 46 deletions(-)

-- 
2.1.0
