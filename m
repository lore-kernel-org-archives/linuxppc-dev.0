Return-Path: <ntl@pobox.com>
Received: from sceptre.pobox.com (sceptre.pobox.com [207.106.133.20])
	by ozlabs.org (Postfix) with ESMTP id 9F3A8DDE29
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Dec 2007 03:04:13 +1100 (EST)
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 2FE672FA
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Dec 2007 11:04:32 -0500 (EST)
Received: from thinkcentre (24-155-246-53.dyn.grandenetworks.net
	[24.155.246.53])
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id F31BB9CCAB
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Dec 2007 11:04:31 -0500 (EST)
From: Nathan Lynch <ntl@pobox.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] lparcfg: remove useless buffer allocation
Date: Tue,  4 Dec 2007 10:03:49 -0600
Message-Id: <1196784229-30575-1-git-send-email-ntl@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The 'data' member of proc_ppc64_lparcfg is unused, but the lparcfg
module's init routine allocates 4K for it.

Remove the code which allocates and frees this buffer.

Signed-off-by: Nathan Lynch <ntl@pobox.com>
---
 arch/powerpc/kernel/lparcfg.c |   12 +-----------
 1 files changed, 1 insertions(+), 11 deletions(-)

Tested with "cat /proc/ppc64/lparcfg" on Power5.

diff --git a/arch/powerpc/kernel/lparcfg.c b/arch/powerpc/kernel/lparcfg.c
index ff781b2..dcb89a8 100644
--- a/arch/powerpc/kernel/lparcfg.c
+++ b/arch/powerpc/kernel/lparcfg.c
@@ -41,7 +41,6 @@
 /* #define LPARCFG_DEBUG */
 
 static struct proc_dir_entry *proc_ppc64_lparcfg;
-#define LPARCFG_BUFF_SIZE 4096
 
 /*
  * Track sum of all purrs across all processors. This is used to further
@@ -595,13 +594,6 @@ int __init lparcfg_init(void)
 	ent = create_proc_entry("ppc64/lparcfg", mode, NULL);
 	if (ent) {
 		ent->proc_fops = &lparcfg_fops;
-		ent->data = kmalloc(LPARCFG_BUFF_SIZE, GFP_KERNEL);
-		if (!ent->data) {
-			printk(KERN_ERR
-			       "Failed to allocate buffer for lparcfg\n");
-			remove_proc_entry("lparcfg", ent->parent);
-			return -ENOMEM;
-		}
 	} else {
 		printk(KERN_ERR "Failed to create ppc64/lparcfg\n");
 		return -EIO;
@@ -613,10 +605,8 @@ int __init lparcfg_init(void)
 
 void __exit lparcfg_cleanup(void)
 {
-	if (proc_ppc64_lparcfg) {
-		kfree(proc_ppc64_lparcfg->data);
+	if (proc_ppc64_lparcfg)
 		remove_proc_entry("lparcfg", proc_ppc64_lparcfg->parent);
-	}
 }
 
 module_init(lparcfg_init);
-- 
1.5.3.4.206.g58ba4
