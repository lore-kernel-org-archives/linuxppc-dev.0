Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp04.au.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E144DB70DD
	for <linuxppc-dev@ozlabs.org>; Mon,  2 Aug 2010 10:55:38 +1000 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp04.au.ibm.com (8.14.4/8.13.1) with ESMTP id o720pD17016111
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Aug 2010 10:51:13 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o720tcBi1241210
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Aug 2010 10:55:38 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o720tcvs001084
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Aug 2010 10:55:38 +1000
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 06/11] powerpc/nvram: Shuffle code around in
	nvram_create_partition()
Date: Mon,  2 Aug 2010 10:55:17 +1000
Message-Id: <1280710522-6362-7-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1280710522-6362-6-git-send-email-benh@kernel.crashing.org>
References: <1280710522-6362-1-git-send-email-benh@kernel.crashing.org>
	<1280710522-6362-2-git-send-email-benh@kernel.crashing.org>
	<1280710522-6362-3-git-send-email-benh@kernel.crashing.org>
	<1280710522-6362-4-git-send-email-benh@kernel.crashing.org>
	<1280710522-6362-5-git-send-email-benh@kernel.crashing.org>
	<1280710522-6362-6-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This error log stuff is really pseries specific. As a first step we move
the initialization of these variables to the caller of
nvram_create_partition(), which is also slightly reorganized so we
setup the free partition before we clear the new partition, so the
chance of an error during clear leaving us with invalid headers
is lessened.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/nvram_64.c |  107 +++++++++++++++++++++++-----------------
 1 files changed, 62 insertions(+), 45 deletions(-)

diff --git a/arch/powerpc/kernel/nvram_64.c b/arch/powerpc/kernel/nvram_64.c
index 7ddeaa6..10f4b82 100644
--- a/arch/powerpc/kernel/nvram_64.c
+++ b/arch/powerpc/kernel/nvram_64.c
@@ -313,9 +313,15 @@ static int __init nvram_remove_os_partition(void)
  * @sig: signature of the partition to create
  * @req_size: size of data to allocate in bytes
  * @min_size: minimum acceptable size (0 means req_size)
+ *
+ * Returns a negative error code or a positive nvram index
+ * of the beginning of the data area of the newly created
+ * partition. If you provided a min_size smaller than req_size
+ * you need to query for the actual size yourself after the
+ * call using nvram_partition_get_size().
  */
-static int __init nvram_create_partition(const char *name, int sig,
-					 int req_size, int min_size)
+static loff_t __init nvram_create_partition(const char *name, int sig,
+					    int req_size, int min_size)
 {
 	struct nvram_partition *part;
 	struct nvram_partition *new_part;
@@ -334,6 +340,8 @@ static int __init nvram_create_partition(const char *name, int sig,
 	 */
 	if (min_size == 0)
 		min_size = req_size;
+	if (min_size > req_size)
+		return -EINVAL;
 
 	/* Now add one block to each for the header */
 	req_size += 1;
@@ -362,7 +370,7 @@ static int __init nvram_create_partition(const char *name, int sig,
 	/* Create our OS partition */
 	new_part = kmalloc(sizeof(*new_part), GFP_KERNEL);
 	if (!new_part) {
-		printk(KERN_ERR "nvram_create_os_partition: kmalloc failed\n");
+		pr_err("nvram_create_os_partition: kmalloc failed\n");
 		return -ENOMEM;
 	}
 
@@ -374,12 +382,29 @@ static int __init nvram_create_partition(const char *name, int sig,
 
 	rc = nvram_write_header(new_part);
 	if (rc <= 0) {
-		printk(KERN_ERR "nvram_create_os_partition: nvram_write_header "
-				"failed (%d)\n", rc);
+		pr_err("nvram_create_os_partition: nvram_write_header "
+		       "failed (%d)\n", rc);
 		return rc;
 	}
+	list_add_tail(&new_part->partition, &free_part->partition);
 
-	/* Clear the partition */
+	/* Adjust or remove the partition we stole the space from */
+	if (free_part->header.length > size) {
+		free_part->index += size * NVRAM_BLOCK_LEN;
+		free_part->header.length -= size;
+		free_part->header.checksum = nvram_checksum(&free_part->header);
+		rc = nvram_write_header(free_part);
+		if (rc <= 0) {
+			pr_err("nvram_create_os_partition: nvram_write_header "
+			       "failed (%d)\n", rc);
+			return rc;
+		}
+	} else {
+		list_del(&free_part->partition);
+		kfree(free_part);
+	} 
+
+	/* Clear the new partition */
 	for (tmp_index = new_part->index + NVRAM_HEADER_LEN;
 	     tmp_index <  ((size - 1) * NVRAM_BLOCK_LEN);
 	     tmp_index += NVRAM_BLOCK_LEN) {
@@ -390,31 +415,24 @@ static int __init nvram_create_partition(const char *name, int sig,
 		}
 	}
 	
-	nvram_error_log_index = new_part->index + NVRAM_HEADER_LEN;
-	nvram_error_log_size = ((part->header.length - 1) *
-				NVRAM_BLOCK_LEN) - sizeof(struct err_log_info);
-	
-	list_add_tail(&new_part->partition, &free_part->partition);
-
-	if (free_part->header.length <= size) {
-		list_del(&free_part->partition);
-		kfree(free_part);
-		return 0;
-	} 
+	return new_part->index + NVRAM_HEADER_LEN;
+}
 
-	/* Adjust the partition we stole the space from */
-	free_part->index += size * NVRAM_BLOCK_LEN;
-	free_part->header.length -= size;
-	free_part->header.checksum = nvram_checksum(&free_part->header);
+/**
+ * nvram_get_partition_size - Get the data size of an nvram partition
+ * @data_index: This is the offset of the start of the data of
+ *              the partition. The same value that is returned by
+ *              nvram_create_partition().
+ */
+static int nvram_get_partition_size(loff_t data_index)
+{
+	struct nvram_partition *part;
 	
-	rc = nvram_write_header(free_part);
-	if (rc <= 0) {
-		printk(KERN_ERR "nvram_create_os_partition: nvram_write_header "
-		       "failed (%d)\n", rc);
-		return rc;
+	list_for_each_entry(part, &nvram_part->partition, partition) {
+		if (part->index + NVRAM_HEADER_LEN == data_index)
+			return (part->header.length - 1) * NVRAM_BLOCK_LEN;
 	}
-
-	return 0;
+	return -1;
 }
 
 
@@ -469,30 +487,29 @@ static int __init nvram_setup_partition(void)
 	}
 	
 	/* try creating a partition with the free space we have */
-	rc = 	nvram_create_partition("ppc64,linux", NVRAM_SIG_OS,
+	rc = nvram_create_partition("ppc64,linux", NVRAM_SIG_OS,
 				       NVRAM_MIN_REQ, NVRAM_MAX_REQ);
-	if (!rc)
-		return 0;
-		
-	/* need to free up some space */
-	rc = nvram_remove_os_partition();
-	if (rc) {
-		return rc;
+	if (rc < 0) {
+		/* need to free up some space */
+		rc = nvram_remove_os_partition();
+		if (rc)
+			return rc;	
+		/* create a partition in this new space */
+		rc = nvram_create_partition("ppc64,linux", NVRAM_SIG_OS,
+					    NVRAM_MIN_REQ, NVRAM_MAX_REQ);
+		if (rc < 0) {
+			pr_err("nvram_create_partition: Could not find"
+			       " enough space in NVRAM for partition\n");
+			return rc;
+		}
 	}
 	
-	/* create a partition in this new space */
-	rc = 	nvram_create_partition("ppc64,linux", NVRAM_SIG_OS,
-				       NVRAM_MIN_REQ, NVRAM_MAX_REQ);
-	if (rc) {
-		printk(KERN_ERR "nvram_create_partition: Could not find a "
-		       "NVRAM partition large enough\n");
-		return rc;
-	}
+	nvram_error_log_index = rc;	
+	nvram_error_log_size = nvram_get_partition_size(rc) - sizeof(struct err_log_info);
 	
 	return 0;
 }
 
-
 static int __init nvram_scan_partitions(void)
 {
 	loff_t cur_index = 0;
-- 
1.6.3.3
