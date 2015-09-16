Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 77E151A2CC3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2015 02:53:30 +1000 (AEST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Wed, 16 Sep 2015 10:53:28 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id DAE3019D8047
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2015 10:44:19 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8GGrIeG5505328
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2015 09:53:26 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8GGqrNY016449
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2015 10:52:53 -0600
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
To: linux-scsi@vger.kernel.org, James.Bottomley@HansenPartnership.com,
 nab@linux-iscsi.org, brking@linux.vnet.ibm.com, imunsie@au1.ibm.com,
 dja@ozlabs.au.ibm.com, andrew.donnellan@au1.ibm.com
Cc: mikey@neuling.org, linuxppc-dev@lists.ozlabs.org,
 Manoj Kumar <kumarmn@us.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Subject: [PATCH v2 01/30] cxlflash: Fix to avoid invalid port_sel value
Date: Wed, 16 Sep 2015 11:51:57 -0500
Message-Id: <1442422317-40957-1-git-send-email-mrochs@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Manoj Kumar <kumarmn@us.ibm.com>

If two concurrent MANAGE_LUN ioctls are issued with the same
WWID parameter, it would result in an incorrect value of port_sel.

This is because port_sel is modified without any locks being
held. If the first caller stalls after the return from
find_and_create_lun(), the value of port_sel will be set
incorrectly to indicate a single port, though in this case
it should have been set to both ports.

To fix, use the global mutex to serialize the lookup of the
WWID and the subsequent modification of port_sel.

Signed-off-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
Signed-off-by: Manoj N. Kumar <manoj@linux.vnet.ibm.com>
---
 drivers/scsi/cxlflash/lunmgt.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/cxlflash/lunmgt.c b/drivers/scsi/cxlflash/lunmgt.c
index d98ad0f..8c372fc 100644
--- a/drivers/scsi/cxlflash/lunmgt.c
+++ b/drivers/scsi/cxlflash/lunmgt.c
@@ -120,7 +120,8 @@ static struct glun_info *lookup_global(u8 *wwid)
  *
  * The LUN is kept both in a local list (per adapter) and in a global list
  * (across all adapters). Certain attributes of the LUN are local to the
- * adapter (such as index, port selection mask etc.).
+ * adapter (such as index, port selection mask, etc.).
+ *
  * The block allocation map is shared across all adapters (i.e. associated
  * wih the global list). Since different attributes are associated with
  * the per adapter and global entries, allocate two separate structures for each
@@ -128,6 +129,8 @@ static struct glun_info *lookup_global(u8 *wwid)
  *
  * Keep a pointer back from the local to the global entry.
  *
+ * This routine assumes the caller holds the global mutex.
+ *
  * Return: Found/Allocated local lun_info structure on success, NULL on failure
  */
 static struct llun_info *find_and_create_lun(struct scsi_device *sdev, u8 *wwid)
@@ -137,7 +140,6 @@ static struct llun_info *find_and_create_lun(struct scsi_device *sdev, u8 *wwid)
 	struct Scsi_Host *shost = sdev->host;
 	struct cxlflash_cfg *cfg = shost_priv(shost);
 
-	mutex_lock(&global.mutex);
 	if (unlikely(!wwid))
 		goto out;
 
@@ -169,7 +171,6 @@ static struct llun_info *find_and_create_lun(struct scsi_device *sdev, u8 *wwid)
 	list_add(&gli->list, &global.gluns);
 
 out:
-	mutex_unlock(&global.mutex);
 	pr_debug("%s: returning %p\n", __func__, lli);
 	return lli;
 }
@@ -235,6 +236,7 @@ int cxlflash_manage_lun(struct scsi_device *sdev,
 	u64 flags = manage->hdr.flags;
 	u32 chan = sdev->channel;
 
+	mutex_lock(&global.mutex);
 	lli = find_and_create_lun(sdev, manage->wwid);
 	pr_debug("%s: ENTER: WWID = %016llX%016llX, flags = %016llX li = %p\n",
 		 __func__, get_unaligned_le64(&manage->wwid[0]),
@@ -261,6 +263,7 @@ int cxlflash_manage_lun(struct scsi_device *sdev,
 	}
 
 out:
+	mutex_unlock(&global.mutex);
 	pr_debug("%s: returning rc=%d\n", __func__, rc);
 	return rc;
 }
-- 
2.1.0
