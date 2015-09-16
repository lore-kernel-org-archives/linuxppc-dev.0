Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7653D1A2C25
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2015 07:28:17 +1000 (AEST)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Wed, 16 Sep 2015 15:28:15 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id AD66019D8041
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2015 15:19:07 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t8GLSE9u3277150
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2015 14:28:14 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8GLSDss021277
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2015 15:28:13 -0600
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
To: linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
 Brian King <brking@linux.vnet.ibm.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Daniel Axtens <dja@ozlabs.au.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Subject: [PATCH v2 06/30] cxlflash: Fix to avoid sizeof(bool)
Date: Wed, 16 Sep 2015 16:27:51 -0500
Message-Id: <1442438871-49393-1-git-send-email-mrochs@linux.vnet.ibm.com>
In-Reply-To: <1442438635-49044-1-git-send-email-mrochs@linux.vnet.ibm.com>
References: <1442438635-49044-1-git-send-email-mrochs@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Using sizeof(bool) is considered poor form for various reasons and
sparse warns us of that. Correct by changing type from bool to u8.

Signed-off-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
Signed-off-by: Manoj N. Kumar <manoj@linux.vnet.ibm.com>
---
 drivers/scsi/cxlflash/superpipe.c | 2 +-
 drivers/scsi/cxlflash/superpipe.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/cxlflash/superpipe.c b/drivers/scsi/cxlflash/superpipe.c
index 1fa4af6..cf2a85d 100644
--- a/drivers/scsi/cxlflash/superpipe.c
+++ b/drivers/scsi/cxlflash/superpipe.c
@@ -737,7 +737,7 @@ static struct ctx_info *create_context(struct cxlflash_cfg *cfg,
 	struct afu *afu = cfg->afu;
 	struct ctx_info *ctxi = NULL;
 	struct llun_info **lli = NULL;
-	bool *ws = NULL;
+	u8 *ws = NULL;
 	struct sisl_rht_entry *rhte;
 
 	ctxi = kzalloc(sizeof(*ctxi), GFP_KERNEL);
diff --git a/drivers/scsi/cxlflash/superpipe.h b/drivers/scsi/cxlflash/superpipe.h
index fffb179..72d53cf 100644
--- a/drivers/scsi/cxlflash/superpipe.h
+++ b/drivers/scsi/cxlflash/superpipe.h
@@ -97,7 +97,7 @@ struct ctx_info {
 	u32 rht_out;		/* Number of checked out RHT entries */
 	u32 rht_perms;		/* User-defined permissions for RHT entries */
 	struct llun_info **rht_lun;       /* Mapping of RHT entries to LUNs */
-	bool *rht_needs_ws;	/* User-desired write-same function per RHTE */
+	u8 *rht_needs_ws;	/* User-desired write-same function per RHTE */
 
 	struct cxl_ioctl_start_work work;
 	u64 ctxid;
-- 
2.1.0
