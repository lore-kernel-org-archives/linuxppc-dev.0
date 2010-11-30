Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EDEFD1007D1
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Nov 2010 16:47:51 +1100 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp06.au.ibm.com (8.14.4/8.13.1) with ESMTP id oAU5liWo026924
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Nov 2010 16:47:44 +1100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	oAU5lpI4671886
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Nov 2010 16:47:51 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	oAU5lpQL027181
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Nov 2010 16:47:51 +1100
From: benh@kernel.crashing.org
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 02/13] powerpc/nvram: More flexible nvram_create_partition()
Date: Tue, 30 Nov 2010 16:47:32 +1100
Message-Id: <1291096063-14386-2-git-send-email-benh@kernel.crashing.org>
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

Replace nvram_create_os_partition() with a variant that takes
the partition name, signature and size as arguments.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/nvram_64.c         |   46 +++++++++++++++++++------------
 arch/powerpc/platforms/pseries/nvram.c |    6 ++--
 2 files changed, 31 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/kernel/nvram_64.c b/arch/powerpc/kernel/nvram_64.c
index a8154f1..9e13335 100644
--- a/arch/powerpc/kernel/nvram_64.c
+++ b/arch/powerpc/kernel/nvram_64.c
@@ -307,13 +307,15 @@ static int __init nvram_remove_os_partition(void)
 	return 0;
 }
 
-/* nvram_create_os_partition
- *
- * Create a OS linux partition to buffer error logs.
- * Will create a partition starting at the first free
- * space found if space has enough room.
+/**
+ * nvram_create_partition - Create a partition in nvram
+ * @name: name of the partition to create
+ * @sig: signature of the partition to create
+ * @req_size: size to allocate preferrably
+ * @min_size: minimum acceptable size (0 means req_size)
  */
-static int __init nvram_create_os_partition(void)
+static int __init nvram_create_partition(const char *name, int sig,
+					 int req_size, int min_size)
 {
 	struct nvram_partition *part;
 	struct nvram_partition *new_part;
@@ -322,20 +324,27 @@ static int __init nvram_create_os_partition(void)
 	loff_t tmp_index;
 	long size = 0;
 	int rc;
-	
+
+	/* If no minimum size specified, make it the same as the
+	 * requested size
+	 */
+	if (min_size == 0)
+		min_size = req_size;
+
 	/* Find a free partition that will give us the maximum needed size 
 	   If can't find one that will give us the minimum size needed */
 	list_for_each_entry(part, &nvram_part->partition, partition) {
 		if (part->header.signature != NVRAM_SIG_FREE)
 			continue;
 
-		if (part->header.length >= NVRAM_MAX_REQ) {
-			size = NVRAM_MAX_REQ;
+		if (part->header.length >= req_size) {
+			size = req_size;
 			free_part = part;
 			break;
 		}
-		if (!size && part->header.length >= NVRAM_MIN_REQ) {
-			size = NVRAM_MIN_REQ;
+		if (part->header.length > size &&
+		    part->header.length >= min_size) {
+			size = part->header.length;
 			free_part = part;
 		}
 	}
@@ -350,9 +359,9 @@ static int __init nvram_create_os_partition(void)
 	}
 
 	new_part->index = free_part->index;
-	new_part->header.signature = NVRAM_SIG_OS;
+	new_part->header.signature = sig;
 	new_part->header.length = size;
-	strcpy(new_part->header.name, "ppc64,linux");
+	strncpy(new_part->header.name, name, 12);
 	new_part->header.checksum = nvram_checksum(&new_part->header);
 
 	rc = nvram_write_header(new_part);
@@ -451,10 +460,10 @@ static int __init nvram_setup_partition(void)
 	}
 	
 	/* try creating a partition with the free space we have */
-	rc = nvram_create_partition("ppc64,linux", );
-	if (!rc) {
+	rc = 	nvram_create_partition("ppc64,linux", NVRAM_SIG_OS,
+				       NVRAM_MAX_REQ, NVRAM_MIN_REQ);
+	if (!rc)
 		return 0;
-	}
 		
 	/* need to free up some space */
 	rc = nvram_remove_os_partition();
@@ -463,9 +472,10 @@ static int __init nvram_setup_partition(void)
 	}
 	
 	/* create a partition in this new space */
-	rc = nvram_create_os_partition();
+	rc = 	nvram_create_partition("ppc64,linux", NVRAM_SIG_OS,
+				       NVRAM_MAX_REQ, NVRAM_MIN_REQ);
 	if (rc) {
-		printk(KERN_ERR "nvram_create_os_partition: Could not find a "
+		printk(KERN_ERR "nvram_create_partition: Could not find a "
 		       "NVRAM partition large enough\n");
 		return rc;
 	}
diff --git a/arch/powerpc/platforms/pseries/nvram.c b/arch/powerpc/platforms/pseries/nvram.c
index f4e4c06..2a1ef5c 100644
--- a/arch/powerpc/platforms/pseries/nvram.c
+++ b/arch/powerpc/platforms/pseries/nvram.c
@@ -22,14 +22,14 @@
 #include <asm/prom.h>
 #include <asm/machdep.h>
 
+/* Max bytes to read/write in one go */
+#define NVRW_CNT 0x20
+
 static unsigned int nvram_size;
 static int nvram_fetch, nvram_store;
 static char nvram_buf[NVRW_CNT];	/* assume this is in the first 4GB */
 static DEFINE_SPINLOCK(nvram_lock);
 
-/* Max bytes to read/write in one go */
-#define NVRW_CNT 0x20
-
 static ssize_t pSeries_nvram_read(char *buf, size_t count, loff_t *index)
 {
 	unsigned int i;
-- 
1.7.1
