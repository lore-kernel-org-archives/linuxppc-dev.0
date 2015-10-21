Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6C45B1A0BE0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Oct 2015 07:17:22 +1100 (AEDT)
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Wed, 21 Oct 2015 16:17:20 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id F1DE9C9003C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2015 16:05:29 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9LKHI4L58065030
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2015 20:17:18 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9LKHHKO009739
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2015 16:17:18 -0400
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
To: linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
 Brian King <brking@linux.vnet.ibm.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Daniel Axtens <dja@ozlabs.au.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Tomas Henzl <thenzl@redhat.com>, David Laight <David.Laight@ACULAB.COM>
Cc: Michael Neuling <mikey@neuling.org>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v6 33/37] cxlflash: Fix to avoid leaving dangling interrupt
 resources
Date: Wed, 21 Oct 2015 15:16:00 -0500
Message-Id: <1445458560-61693-1-git-send-email-mrochs@linux.vnet.ibm.com>
In-Reply-To: <1445458134-63197-1-git-send-email-mrochs@linux.vnet.ibm.com>
References: <1445458134-63197-1-git-send-email-mrochs@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When running with an unsupported AFU, the cxlflash driver fails
the probe. When the driver is removed, the following Oops is
encountered on a show_interrupts() thread:

Call Trace:
[c000001fba5a7a10] [0000000000000003] 0x3 (unreliable)
[c000001fba5a7a60] [c00000000053dcf4] vsnprintf+0x204/0x4c0
[c000001fba5a7ae0] [c00000000030045c] seq_vprintf+0x5c/0xd0
[c000001fba5a7b20] [c00000000030051c] seq_printf+0x4c/0x60
[c000001fba5a7b50] [c00000000013e140] show_interrupts+0x370/0x4f0
[c000001fba5a7c10] [c0000000002ff898] seq_read+0xe8/0x530
[c000001fba5a7ca0] [c00000000035d5c0] proc_reg_read+0xb0/0x110
[c000001fba5a7cf0] [c0000000002ca74c] __vfs_read+0x6c/0x180
[c000001fba5a7d90] [c0000000002cb464] vfs_read+0xa4/0x1c0
[c000001fba5a7de0] [c0000000002cc51c] SyS_read+0x6c/0x110
[c000001fba5a7e30] [c000000000009204] system_call+0x38/0xb4

The Oops is due to not cleaning up correctly on the unsupported
AFU error path, leaving various allocated and registered resources.
In this case, interrupts are in a semi-allocated/registered state,
which the show_interrupts() thread attempts to use.

To fix, the cleanup logic in init_afu() is consolidated to error
gates at the bottom of the function and the appropriate goto is
added to each error path. As a mini side fix while refactoring
in this routine, the else statement following the AFU version
evaluation is eliminated as it is not needed.

Signed-off-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
Acked-by: Manoj Kumar <manoj@linux.vnet.ibm.com>
Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
---
 drivers/scsi/cxlflash/main.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/scsi/cxlflash/main.c b/drivers/scsi/cxlflash/main.c
index 998373e..c152703 100644
--- a/drivers/scsi/cxlflash/main.c
+++ b/drivers/scsi/cxlflash/main.c
@@ -1721,15 +1721,14 @@ static int init_afu(struct cxlflash_cfg *cfg)
 	if (rc) {
 		dev_err(dev, "%s: call to init_mc failed, rc=%d!\n",
 			__func__, rc);
-		goto err1;
+		goto out;
 	}
 
 	/* Map the entire MMIO space of the AFU */
 	afu->afu_map = cxl_psa_map(cfg->mcctx);
 	if (!afu->afu_map) {
-		rc = -ENOMEM;
-		term_mc(cfg, UNDO_START);
 		dev_err(dev, "%s: call to cxl_psa_map failed!\n", __func__);
+		rc = -ENOMEM;
 		goto err1;
 	}
 
@@ -1743,19 +1742,17 @@ static int init_afu(struct cxlflash_cfg *cfg)
 		       "interface version 0x%llx\n", afu->version,
 		       afu->interface_version);
 		rc = -EINVAL;
-		goto err1;
-	} else
-		pr_debug("%s: afu version %s, interface version 0x%llX\n",
-			 __func__, afu->version, afu->interface_version);
+		goto err2;
+	}
+
+	pr_debug("%s: afu version %s, interface version 0x%llX\n", __func__,
+		 afu->version, afu->interface_version);
 
 	rc = start_afu(cfg);
 	if (rc) {
 		dev_err(dev, "%s: call to start_afu failed, rc=%d!\n",
 			__func__, rc);
-		term_mc(cfg, UNDO_START);
-		cxl_psa_unmap((void __iomem *)afu->afu_map);
-		afu->afu_map = NULL;
-		goto err1;
+		goto err2;
 	}
 
 	afu_err_intr_init(cfg->afu);
@@ -1763,9 +1760,16 @@ static int init_afu(struct cxlflash_cfg *cfg)
 
 	/* Restore the LUN mappings */
 	cxlflash_restore_luntable(cfg);
-err1:
+out:
 	pr_debug("%s: returning rc=%d\n", __func__, rc);
 	return rc;
+
+err2:
+	cxl_psa_unmap((void __iomem *)afu->afu_map);
+	afu->afu_map = NULL;
+err1:
+	term_mc(cfg, UNDO_START);
+	goto out;
 }
 
 /**
-- 
2.1.0
