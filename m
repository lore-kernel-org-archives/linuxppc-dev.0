Return-Path: <deepthi@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5D1732C04D7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jan 2014 13:43:41 +1100 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <deepthi@linux.vnet.ibm.com>;
 Sat, 18 Jan 2014 12:43:41 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 4060D3578052
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jan 2014 13:43:38 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0I2OV9f2031880
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jan 2014 13:24:31 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0I2hbME019305
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jan 2014 13:43:38 +1100
Subject: [PATCH V3 3/3] powernv: Have uniform logging of errors in opal-elog.c
To: benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Date: Sat, 18 Jan 2014 08:13:47 +0530
Message-ID: <20140118024324.13537.25236.stgit@deepthi>
In-Reply-To: <20140118024150.13537.11381.stgit@deepthi>
References: <20140118024150.13537.11381.stgit@deepthi>
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
makes the complete error/event logging uniform.

Signed-off-by: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/opal-elog.c |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-elog.c b/arch/powerpc/platforms/powernv/opal-elog.c
index 0f67faa..78d3828 100644
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
@@ -359,15 +359,13 @@ int __init opal_elog_init(void)
 
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
 
