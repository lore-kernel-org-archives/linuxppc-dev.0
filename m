Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-quonix.sasl.smtp.pobox.com
	[208.72.237.25]) by ozlabs.org (Postfix) with ESMTP id E874ADDE09
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Mar 2008 09:51:56 +1100 (EST)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 722DC2174
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Mar 2008 18:51:51 -0400 (EDT)
Received: from thinkcentre (24-155-246-53.dyn.grandenetworks.net
	[24.155.246.53]) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
	ESMTP id
	0D8EB2173 for <linuxppc-dev@ozlabs.org>; Sun, 23 Mar 2008 18:51:50 -0400
	(EDT)
Date: Sun, 23 Mar 2008 17:51:45 -0500
From: Nathan Lynch <ntl@pobox.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] scanlog_init cleanup, minor fixes
Message-ID: <20080323225144.GA7137@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

scanlog_init() could use some love.

* properly return -ENODEV if this system doesn't support scan-log-dump
* don't printk if scan-log-dump not present; only older systems have it
* convert from create_proc_entry() to preferred proc_create()
* allocate zeroed data buffer
* fix potential memory leak of ent->data on failed create_proc_entry()
* simplify control flow

Signed-off-by: Nathan Lynch <ntl@pobox.com>
---

(not urgent, please consider for 2.6.26)

 arch/powerpc/platforms/pseries/scanlog.c |   37 ++++++++++++++---------------
 1 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/scanlog.c b/arch/powerpc/platforms/pseries/scanlog.c
index 8e1ef16..e5b0ea8 100644
--- a/arch/powerpc/platforms/pseries/scanlog.c
+++ b/arch/powerpc/platforms/pseries/scanlog.c
@@ -195,31 +195,30 @@ const struct file_operations scanlog_fops = {
 static int __init scanlog_init(void)
 {
 	struct proc_dir_entry *ent;
+	void *data;
+	int err = -ENOMEM;
 
 	ibm_scan_log_dump = rtas_token("ibm,scan-log-dump");
-	if (ibm_scan_log_dump == RTAS_UNKNOWN_SERVICE) {
-		printk(KERN_ERR "scan-log-dump not implemented on this system\n");
-		return -EIO;
-	}
+	if (ibm_scan_log_dump == RTAS_UNKNOWN_SERVICE)
+		return -ENODEV;
 
-        ent = create_proc_entry("ppc64/rtas/scan-log-dump",  S_IRUSR, NULL);
-	if (ent) {
-		ent->proc_fops = &scanlog_fops;
-		/* Ideally we could allocate a buffer < 4G */
-		ent->data = kmalloc(RTAS_DATA_BUF_SIZE, GFP_KERNEL);
-		if (!ent->data) {
-			printk(KERN_ERR "Failed to allocate a buffer\n");
-			remove_proc_entry("scan-log-dump", ent->parent);
-			return -ENOMEM;
-		}
-		((unsigned int *)ent->data)[0] = 0;
-	} else {
-		printk(KERN_ERR "Failed to create ppc64/scan-log-dump proc entry\n");
-		return -EIO;
-	}
+	/* Ideally we could allocate a buffer < 4G */
+	data = kzalloc(RTAS_DATA_BUF_SIZE, GFP_KERNEL);
+	if (!data)
+		goto err;
+
+	ent = proc_create("ppc64/rtas/scan-log-dump", S_IRUSR, NULL,
+			  &scanlog_fops);
+	if (!ent)
+		goto err;
+
+	ent->data = data;
 	proc_ppc64_scan_log_dump = ent;
 
 	return 0;
+err:
+	kfree(data);
+	return err;
 }
 
 static void __exit scanlog_cleanup(void)
-- 
1.5.4.rc5
