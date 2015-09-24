Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 496631A0D98
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2015 05:43:54 +1000 (AEST)
Received: from localhost
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Thu, 24 Sep 2015 13:43:52 -0600
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id CC72D38C804A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2015 15:43:40 -0400 (EDT)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8OJhWUP59310260
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2015 19:43:40 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8OJh7rh005605
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2015 15:43:07 -0400
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
To: linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
 Brian King <brking@linux.vnet.ibm.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Daniel Axtens <dja@ozlabs.au.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Tomas Henzl <thenzl@redhat.com>, David Laight <David.Laight@ACULAB.COM>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Subject: [PATCH v3 27/32] cxlflash: Fix to prevent stale AFU RRQ
Date: Thu, 24 Sep 2015 14:42:06 -0500
Message-Id: <1443123726-17698-1-git-send-email-mrochs@linux.vnet.ibm.com>
In-Reply-To: <1443123193-16498-1-git-send-email-mrochs@linux.vnet.ibm.com>
References: <1443123193-16498-1-git-send-email-mrochs@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Following an adapter reset, the AFU RRQ that resides in host memory
holds stale data. This can lead to a condition where the RRQ interrupt
handler tries to process stale entries and/or endlessly loops due to an
out of sync generation bit.

To fix, the AFU RRQ in host memory needs to be cleared after each reset.

Signed-off-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
Signed-off-by: Manoj N. Kumar <manoj@linux.vnet.ibm.com>
Reviewed-by: Brian King <brking@linux.vnet.ibm.com>
---
 drivers/scsi/cxlflash/main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/cxlflash/main.c b/drivers/scsi/cxlflash/main.c
index 24aedfb..ab11ee6 100644
--- a/drivers/scsi/cxlflash/main.c
+++ b/drivers/scsi/cxlflash/main.c
@@ -1598,6 +1598,9 @@ static int start_afu(struct cxlflash_cfg *cfg)
 
 	init_pcr(cfg);
 
+	/* After an AFU reset, RRQ entries are stale, clear them */
+	memset(&afu->rrq_entry, 0, sizeof(afu->rrq_entry));
+
 	/* Initialize RRQ pointers */
 	afu->hrrq_start = &afu->rrq_entry[0];
 	afu->hrrq_end = &afu->rrq_entry[NUM_RRQ_ENTRY - 1];
-- 
2.1.0
