Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2A2CA1A0B20
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2015 05:44:53 +1000 (AEST)
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Thu, 24 Sep 2015 13:44:52 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id CD3D61FF004A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2015 13:35:58 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t8OJfiC83801596
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2015 12:41:44 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8OJimd6025878
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2015 13:44:49 -0600
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
Subject: [PATCH v3 31/32] cxlflash: Fix to avoid corrupting adapter fops
Date: Thu, 24 Sep 2015 14:44:11 -0500
Message-Id: <1443123851-17893-1-git-send-email-mrochs@linux.vnet.ibm.com>
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

The fops owned by the adapter can be corrupted in certain scenarios,
opening a window where certain fops are temporarily NULLed before being
reset to their proper value. This can potentially lead software to make
incorrect decisions, leaving the user with the inability to function as
intended.

An example of this behavior can be observed when there are a number of
users with a high rate of turn around (attach to LUN, perform an I/O,
detach from LUN, repeat). Every so often a user is given a valid
context and adapter file descriptor, but the file associated with the
descriptor lacks the correct read permission bit (FMODE_CAN_READ) and
thus the read system call bails before calling the valid read fop.

Background:

The fops is stored in the adapter structure to provide the ability to
lookup the adapter structure from within the fop handler. CXL services
use the file's private_data and at present, the CXL context does not
have a private section. In an effort to limit areas of the cxlflash
driver with code specific the superpipe function, a design choice was
made to keep the details of the fops situated away from the legacy
portions of the driver. This drove the behavior that the adapter fops
is set at the beginning of the disk attach ioctl handler when there
are no users present.

The corruption that this fix remedies is due to the fact that the fops
is initially defaulted to values found within a static structure. When
the fops is handed down to the CXL services later in the attach path,
certain services are patched. The fops structure remains correct until
the user count drops to 0 and the fops is reset, triggering the process
to repeat again. The user counts are tightly coupled with the creation
and deletion of the user context. If multiple users perform a disk
attach at the same time, when the user count is currently 0, some users
can be in the middle of obtaining a file descriptor and have not yet
reached the context creation code that [in addition to creating the
context] increments the user count. Subsequent users coming in to
perform the attach see that the user count is still 0, and reinitialize
the fops, temporarily removing the patched fops. The users that are in
the middle obtaining their file descriptor may then receive an invalid
descriptor.

The fix simply removes the user count altogether and changes the logic
found within disk attach to only perform the initialization one time
for the life of the adapter. In the future, if the CXL services adopt
a private member for their context, that could be used to store the
adapter structure reference and cxlflash could revert to a model that
does not require an embedded fops.

Signed-off-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
Signed-off-by: Manoj N. Kumar <manoj@linux.vnet.ibm.com>
---
 drivers/scsi/cxlflash/common.h    | 2 --
 drivers/scsi/cxlflash/superpipe.c | 6 ++----
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/cxlflash/common.h b/drivers/scsi/cxlflash/common.h
index 89c82d2..5efad98 100644
--- a/drivers/scsi/cxlflash/common.h
+++ b/drivers/scsi/cxlflash/common.h
@@ -115,8 +115,6 @@ struct cxlflash_cfg {
 	struct list_head ctx_err_recovery; /* contexts w/ recovery pending */
 	struct file_operations cxl_fops;
 
-	atomic_t num_user_contexts;
-
 	/* Parameters that are LUN table related */
 	int last_lun_index[CXLFLASH_NUM_FC_PORTS];
 	int promote_lun_index;
diff --git a/drivers/scsi/cxlflash/superpipe.c b/drivers/scsi/cxlflash/superpipe.c
index 6aaeee0..a171e8c 100644
--- a/drivers/scsi/cxlflash/superpipe.c
+++ b/drivers/scsi/cxlflash/superpipe.c
@@ -712,7 +712,6 @@ static void destroy_context(struct cxlflash_cfg *cfg,
 	kfree(ctxi->rht_needs_ws);
 	kfree(ctxi->rht_lun);
 	kfree(ctxi);
-	atomic_dec_if_positive(&cfg->num_user_contexts);
 }
 
 /**
@@ -769,7 +768,6 @@ static struct ctx_info *create_context(struct cxlflash_cfg *cfg,
 	INIT_LIST_HEAD(&ctxi->luns);
 	INIT_LIST_HEAD(&ctxi->list); /* initialize for list_empty() */
 
-	atomic_inc(&cfg->num_user_contexts);
 	mutex_lock(&ctxi->mutex);
 out:
 	return ctxi;
@@ -1293,8 +1291,8 @@ static int cxlflash_disk_attach(struct scsi_device *sdev,
 
 	int fd = -1;
 
-	/* On first attach set fileops */
-	if (atomic_read(&cfg->num_user_contexts) == 0)
+	/* On very first attach set fileops for adapter */
+	if (cfg->cxl_fops.owner != THIS_MODULE)
 		cfg->cxl_fops = cxlflash_cxl_fops;
 
 	if (attach->num_interrupts > 4) {
-- 
2.1.0
