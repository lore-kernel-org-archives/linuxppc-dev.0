Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp01.au.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A4DF41007DE
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Nov 2010 16:47:52 +1100 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp01.au.ibm.com (8.14.4/8.13.1) with ESMTP id oAU5iX4l023432
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Nov 2010 16:44:33 +1100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	oAU5lpx52109506
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Nov 2010 16:47:51 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	oAU5lpp4013248
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Nov 2010 16:47:51 +1100
From: benh@kernel.crashing.org
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 07/13] powerpc/nvram: Improve partition removal
Date: Tue, 30 Nov 2010 16:47:37 +1100
Message-Id: <1291096063-14386-7-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1291096063-14386-1-git-send-email-benh@kernel.crashing.org>
References: <1291096063-14386-1-git-send-email-benh@kernel.crashing.org>
Cc: jkensito@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Existing code is nasty, has bugs etc... rewrite the function
more simply, and make it take the signature and optional
name of the partitions to remove as arguments, thus making
it a more generic utility.

We also try to remove a log partition that we find and is too
small rather than creating a duplicate.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/nvram_64.c |   91 +++++++++++++++++++---------------------
 1 files changed, 43 insertions(+), 48 deletions(-)

diff --git a/arch/powerpc/kernel/nvram_64.c b/arch/powerpc/kernel/nvram_64.c
index eabee7c..6dd2700 100644
--- a/arch/powerpc/kernel/nvram_64.c
+++ b/arch/powerpc/kernel/nvram_64.c
@@ -247,61 +247,54 @@ static unsigned char __init nvram_checksum(struct nvram_header *p)
 	return c_sum;
 }
 
-static int __init nvram_remove_os_partition(void)
+/**
+ * nvram_remove_partition - Remove one or more partitions in nvram
+ * @name: name of the partition to remove, or NULL for a
+ *        signature only match
+ * @sig: signature of the partition(s) to remove
+ */
+
+static int __init nvram_remove_partition(const char *name, int sig)
 {
-	struct list_head *i;
-	struct list_head *j;
-	struct nvram_partition * part;
-	struct nvram_partition * cur_part;
+	struct nvram_partition *part, *prev, *tmp;
 	int rc;
 
-	list_for_each(i, &nvram_part->partition) {
-		part = list_entry(i, struct nvram_partition, partition);
-		if (part->header.signature != NVRAM_SIG_OS)
+	list_for_each_entry(part, &nvram_part->partition, partition) {
+		if (part->header.signature != sig)
 			continue;
-		
-		/* Make os partition a free partition */
+		if (name && strncmp(name, part->header.name, 12))
+			continue;
+
+		/* Make partition a free partition */
 		part->header.signature = NVRAM_SIG_FREE;
 		sprintf(part->header.name, "wwwwwwwwwwww");
 		part->header.checksum = nvram_checksum(&part->header);
-
-		/* Merge contiguous free partitions backwards */
-		list_for_each_prev(j, &part->partition) {
-			cur_part = list_entry(j, struct nvram_partition, partition);
-			if (cur_part == nvram_part || cur_part->header.signature != NVRAM_SIG_FREE) {
-				break;
-			}
-			
-			part->header.length += cur_part->header.length;
-			part->header.checksum = nvram_checksum(&part->header);
-			part->index = cur_part->index;
-
-			list_del(&cur_part->partition);
-			kfree(cur_part);
-			j = &part->partition; /* fixup our loop */
-		}
-		
-		/* Merge contiguous free partitions forwards */
-		list_for_each(j, &part->partition) {
-			cur_part = list_entry(j, struct nvram_partition, partition);
-			if (cur_part == nvram_part || cur_part->header.signature != NVRAM_SIG_FREE) {
-				break;
-			}
-
-			part->header.length += cur_part->header.length;
-			part->header.checksum = nvram_checksum(&part->header);
-
-			list_del(&cur_part->partition);
-			kfree(cur_part);
-			j = &part->partition; /* fixup our loop */
-		}
-		
 		rc = nvram_write_header(part);
 		if (rc <= 0) {
-			printk(KERN_ERR "nvram_remove_os_partition: nvram_write failed (%d)\n", rc);
+			printk(KERN_ERR "nvram_remove_partition: nvram_write failed (%d)\n", rc);
 			return rc;
 		}
+	}
 
+	/* Merge contiguous ones */
+	prev = NULL;
+	list_for_each_entry_safe(part, tmp, &nvram_part->partition, partition) {
+		if (part->header.signature != NVRAM_SIG_FREE) {
+			prev = NULL;
+			continue;
+		}
+		if (prev) {
+			prev->header.length += part->header.length;
+			prev->header.checksum = nvram_checksum(&part->header);
+			rc = nvram_write_header(part);
+			if (rc <= 0) {
+				printk(KERN_ERR "nvram_remove_partition: nvram_write failed (%d)\n", rc);
+				return rc;
+			}
+			list_del(&part->partition);
+			kfree(part);
+		} else
+			prev = part;
 	}
 	
 	return 0;
@@ -484,17 +477,19 @@ static int __init nvram_setup_partition(void)
 						NVRAM_BLOCK_LEN) - sizeof(struct err_log_info);
 			return 0;
 		}
+
+		/* Found one but it's too small, remove it */
+		nvram_remove_partition("ppc64,linux", NVRAM_SIG_OS);
 	}
 	
 	/* try creating a partition with the free space we have */
 	rc = nvram_create_partition("ppc64,linux", NVRAM_SIG_OS,
 				       NVRAM_MAX_REQ, NVRAM_MIN_REQ);
 	if (rc < 0) {
-		/* need to free up some space */
-		rc = nvram_remove_os_partition();
-		if (rc)
-			return rc;	
-		/* create a partition in this new space */
+		/* need to free up some space, remove any "OS" partition */
+		nvram_remove_partition(NULL, NVRAM_SIG_OS);
+	
+		/* Try again */
 		rc = nvram_create_partition("ppc64,linux", NVRAM_SIG_OS,
 					    NVRAM_MAX_REQ, NVRAM_MIN_REQ);
 		if (rc < 0) {
-- 
1.7.1
