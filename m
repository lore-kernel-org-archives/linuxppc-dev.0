Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CB1491A2CC6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2015 07:31:15 +1000 (AEST)
Received: from /spool/local
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Wed, 16 Sep 2015 17:31:12 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 2136D38C8039
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2015 17:31:10 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8GLV9JV52101334
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2015 21:31:09 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8GLV8nt008815
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2015 17:31:09 -0400
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
To: linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
 Brian King <brking@linux.vnet.ibm.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Daniel Axtens <dja@ozlabs.au.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Subject: [PATCH v2 19/30] cxlflash: Fix AFU version access/storage and add
 check
Date: Wed, 16 Sep 2015 16:30:43 -0500
Message-Id: <1442439043-49932-1-git-send-email-mrochs@linux.vnet.ibm.com>
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

The AFU version is stored as a non-terminated string of bytes within
a 64-bit little-endian register. Presently the value is read directly
(no MMIO accessor) and is stored in a buffer that is not big enough
to contain a NULL terminator. Additionally the version obtained is not
evaluated against a known value to prevent usage with unsupported AFUs.
All of these deficiencies can lead to a variety of problems.

To remedy, use the correct MMIO accessor to read the version value into
a null-terminated buffer and add a check to prevent an incompatible AFU
from being used with this driver.

Signed-off-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
Signed-off-by: Manoj N. Kumar <manoj@linux.vnet.ibm.com>
---
 drivers/scsi/cxlflash/common.h  |  2 +-
 drivers/scsi/cxlflash/main.c    | 18 ++++++++++++------
 drivers/scsi/cxlflash/sislite.h |  2 +-
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/cxlflash/common.h b/drivers/scsi/cxlflash/common.h
index 517da25..f392319 100644
--- a/drivers/scsi/cxlflash/common.h
+++ b/drivers/scsi/cxlflash/common.h
@@ -180,7 +180,7 @@ struct afu {
 	u32 cmd_couts;		/* Number of command checkouts */
 	u32 internal_lun;	/* User-desired LUN mode for this AFU */
 
-	char version[8];
+	char version[16];
 	u64 interface_version;
 
 	struct cxlflash_cfg *parent; /* Pointer back to parent cxlflash_cfg */
diff --git a/drivers/scsi/cxlflash/main.c b/drivers/scsi/cxlflash/main.c
index e2cc410..fc77cd4 100644
--- a/drivers/scsi/cxlflash/main.c
+++ b/drivers/scsi/cxlflash/main.c
@@ -1762,14 +1762,20 @@ static int init_afu(struct cxlflash_cfg *cfg)
 		goto err1;
 	}
 
-	/* don't byte reverse on reading afu_version, else the string form */
-	/*     will be backwards */
-	reg = afu->afu_map->global.regs.afu_version;
-	memcpy(afu->version, &reg, 8);
+	/* No byte reverse on reading afu_version or string will be backwards */
+	reg = readq(&afu->afu_map->global.regs.afu_version);
+	memcpy(afu->version, &reg, sizeof(reg));
 	afu->interface_version =
 	    readq_be(&afu->afu_map->global.regs.interface_version);
-	pr_debug("%s: afu version %s, interface version 0x%llX\n",
-		 __func__, afu->version, afu->interface_version);
+	if ((afu->interface_version + 1) == 0) {
+		pr_err("Back level AFU, please upgrade. AFU version %s "
+		       "interface version 0x%llx\n", afu->version,
+		       afu->interface_version);
+		rc = -EINVAL;
+		goto err1;
+	} else
+		pr_debug("%s: afu version %s, interface version 0x%llX\n",
+			 __func__, afu->version, afu->interface_version);
 
 	rc = start_afu(cfg);
 	if (rc) {
diff --git a/drivers/scsi/cxlflash/sislite.h b/drivers/scsi/cxlflash/sislite.h
index 63bf394..8425d1a 100644
--- a/drivers/scsi/cxlflash/sislite.h
+++ b/drivers/scsi/cxlflash/sislite.h
@@ -340,7 +340,7 @@ struct sisl_global_regs {
 #define SISL_AFUCONF_MBOX_CLR_READ     0x0010ULL
 	__be64 afu_config;
 	__be64 rsvd[0xf8];
-	__be64 afu_version;
+	__le64 afu_version;
 	__be64 interface_version;
 };
 
-- 
2.1.0
