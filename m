Return-Path: <deepthi@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 832332C0402
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Feb 2014 06:29:52 +1100 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <deepthi@linux.vnet.ibm.com>;
 Tue, 4 Feb 2014 00:59:50 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 6EF26E0056
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Feb 2014 01:03:00 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s13JTo1F43188348
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Feb 2014 00:59:50 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s13JTmSM005008
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Feb 2014 00:59:48 +0530
Received: from [192.168.1.7] ([9.79.188.145])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 s13JTl58004967
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Feb 2014 00:59:48 +0530
Subject: [PATCH V4 3/3] powerpc/powernv: Have uniform logging of errors in
 opal-elog.c
To: linuxppc-dev@lists.ozlabs.org
From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Date: Tue, 04 Feb 2014 01:00:08 +0530
Message-ID: <20140203193000.7790.55563.stgit@deepthi>
In-Reply-To: <20140203192915.7790.20325.stgit@deepthi>
References: <20140203192915.7790.20325.stgit@deepthi>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently some errors/info to be reported use
printk and the rest pr_fmt(). This patch
makes the complete error logging uniform.

Signed-off-by: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/opal-elog.c |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-elog.c b/arch/powerpc/platforms/powernv/opal-elog.c
index 13874b1..d7a3e68 100644
--- a/arch/powerpc/platforms/powernv/opal-elog.c
+++ b/arch/powerpc/platforms/powernv/opal-elog.c
@@ -63,7 +63,7 @@ void opal_elog_ack(uint64_t ack_id)
 	struct opal_err_log *record, *next;
 	bool found = false;
 
-	printk(KERN_INFO "OPAL Log ACK=%llx", ack_id);
+	pr_info("OPAL Log ACK=%llx", ack_id);
 
 	/* once user acknowledge a log delete record from list */
 	spin_lock_irqsave(&opal_elog_lock, flags);
@@ -189,7 +189,7 @@ static void opal_elog_read(void)
 	/* read log size and log ID from OPAL */
 	rc = opal_get_elog_size(&log_id, &elog_size, &elog_type);
 	if (rc != OPAL_SUCCESS) {
-		pr_err("ELOG: Opal log read failed\n");
+		pr_err("Opal log read failed\n");
 		return;
 	}
 	if (elog_size >= OPAL_MAX_ERRLOG_SIZE)
@@ -203,7 +203,7 @@ static void opal_elog_read(void)
 	rc = opal_read_elog(__pa(err_log_data), elog_size, log_id);
 	if (rc != OPAL_SUCCESS) {
 		mutex_unlock(&err_log_data_mutex);
-		pr_err("ELOG: log read failed for log-id=%llx\n", log_id);
+		pr_err("Reading of log failed for log-id=%llx\n", log_id);
 		/* put back the free node. */
 		spin_lock_irqsave(&opal_elog_lock, flags);
 		list_add(&record->link, &elog_ack_list);
@@ -265,7 +265,7 @@ static int init_err_log_buffer(void)
 
 	buf_ptr = vmalloc(sizeof(struct opal_err_log) * MAX_NUM_RECORD);
 	if (!buf_ptr) {
-		printk(KERN_ERR "ELOG: failed to allocate memory.\n");
+		pr_err("Failed to allocate memory for error logging buffers.\n");
 		return -ENOMEM;
 	}
 	memset(buf_ptr, 0, sizeof(struct opal_err_log) * MAX_NUM_RECORD);
@@ -358,15 +358,13 @@ int __init opal_elog_init(void)
 
 	rc = sysfs_create_bin_file(opal_kobj, &opal_elog_attr);
 	if (rc) {
-		printk(KERN_ERR "ELOG: unable to create sysfs file"
-					"opal_elog (%d)\n", rc);
+		pr_err("Unable to create sysfs file opal_elog (%d)\n", rc);
 		return rc;
 	}
 
 	rc = sysfs_create_file(opal_kobj, &opal_elog_ack_attr.attr);
 	if (rc) {
-		printk(KERN_ERR "ELOG: unable to create sysfs file"
-			" opal_elog_ack (%d)\n", rc);
+		pr_err("Unable to create sysfs file opal_elog_ack (%d)\n", rc);
 		return rc;
 	}
 
