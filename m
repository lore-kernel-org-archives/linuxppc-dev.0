Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 11CADDE169
	for <linuxppc-dev@ozlabs.org>; Sat,  3 May 2008 06:41:53 +1000 (EST)
Message-Id: <200805022034.m42KY5u5013270@imap1.linux-foundation.org>
Subject: [patch 5/5] powerpc: assign PDE->data before gluing PDE into /proc
	tree
To: paulus@samba.org
From: akpm@linux-foundation.org
Date: Fri, 02 May 2008 13:34:05 -0700
Cc: adobriyan@openvz.org, paulus@au.ibm.com, linuxppc-dev@ozlabs.org,
	ebiederm@xmission.com, den@openvz.org, akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: "Denis V. Lunev" <den@openvz.org>

Simply replace proc_create and further data assigned with proc_create_data. 
No need to check for data!=NULL after that.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Cc: Alexey Dobriyan <adobriyan@openvz.org>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Paul Mackerras <paulus@au.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/powerpc/platforms/pseries/scanlog.c |   19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff -puN arch/powerpc/platforms/pseries/scanlog.c~powerpc-assign-pde-data-before-gluing-pde-into-proc-tree arch/powerpc/platforms/pseries/scanlog.c
--- a/arch/powerpc/platforms/pseries/scanlog.c~powerpc-assign-pde-data-before-gluing-pde-into-proc-tree
+++ a/arch/powerpc/platforms/pseries/scanlog.c
@@ -55,11 +55,6 @@ static ssize_t scanlog_read(struct file 
         dp = PDE(inode);
  	data = (unsigned int *)dp->data;
 
-	if (!data) {
-		printk(KERN_ERR "scanlog: read failed no data\n");
-		return -EIO;
-	}
-
 	if (count > RTAS_DATA_BUF_SIZE)
 		count = RTAS_DATA_BUF_SIZE;
 
@@ -146,11 +141,6 @@ static int scanlog_open(struct inode * i
 	struct proc_dir_entry *dp = PDE(inode);
 	unsigned int *data = (unsigned int *)dp->data;
 
-	if (!data) {
-		printk(KERN_ERR "scanlog: open failed no data\n");
-		return -EIO;
-	}
-
 	if (data[0] != 0) {
 		/* This imperfect test stops a second copy of the
 		 * data (or a reset while data is being copied)
@@ -168,10 +158,6 @@ static int scanlog_release(struct inode 
 	struct proc_dir_entry *dp = PDE(inode);
 	unsigned int *data = (unsigned int *)dp->data;
 
-	if (!data) {
-		printk(KERN_ERR "scanlog: release failed no data\n");
-		return -EIO;
-	}
 	data[0] = 0;
 
 	return 0;
@@ -200,12 +186,11 @@ static int __init scanlog_init(void)
 	if (!data)
 		goto err;
 
-	ent = proc_create("ppc64/rtas/scan-log-dump", S_IRUSR, NULL,
-			  &scanlog_fops);
+	ent = proc_create_data("ppc64/rtas/scan-log-dump", S_IRUSR, NULL,
+			       &scanlog_fops, data);
 	if (!ent)
 		goto err;
 
-	ent->data = data;
 	proc_ppc64_scan_log_dump = ent;
 
 	return 0;
_
