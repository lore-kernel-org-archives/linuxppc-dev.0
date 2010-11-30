Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp05.au.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EF81910080D
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Nov 2010 16:47:52 +1100 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp05.au.ibm.com (8.14.4/8.13.1) with ESMTP id oAU5goPo021508
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Nov 2010 16:42:50 +1100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	oAU5lqiN1613964
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Nov 2010 16:47:52 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	oAU5lpC0027217
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Nov 2010 16:47:52 +1100
From: benh@kernel.crashing.org
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 09/13] powerpc/nvram: Change nvram_setup_partition() to use
	new helper
Date: Tue, 30 Nov 2010 16:47:39 +1100
Message-Id: <1291096063-14386-9-git-send-email-benh@kernel.crashing.org>
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

This changes the function to use nvram_find_partition() instead
of doing the lookup "by hand". It also makes some of the logic
clearer and prints out more useful diagnostic information.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/nvram_64.c |   71 ++++++++++++++++++----------------------
 1 files changed, 32 insertions(+), 39 deletions(-)

diff --git a/arch/powerpc/kernel/nvram_64.c b/arch/powerpc/kernel/nvram_64.c
index 01e6844..76f546b 100644
--- a/arch/powerpc/kernel/nvram_64.c
+++ b/arch/powerpc/kernel/nvram_64.c
@@ -469,9 +469,8 @@ loff_t nvram_find_partition(const char *name, int sig, int *out_size)
  */
 static int __init nvram_setup_partition(void)
 {
-	struct list_head * p;
-	struct nvram_partition * part;
-	int rc;
+	loff_t p;
+	int size;
 
 	/* For now, we don't do any of this on pmac, until I
 	 * have figured out if it's worth killing some unused stuffs
@@ -481,48 +480,42 @@ static int __init nvram_setup_partition(void)
 	if (machine_is(powermac))
 		return -ENOSPC;
 
-	/* see if we have an OS partition that meets our needs.
-	   will try getting the max we need.  If not we'll delete
-	   partitions and try again. */
-	list_for_each(p, &nvram_part->partition) {
-		part = list_entry(p, struct nvram_partition, partition);
-		if (part->header.signature != NVRAM_SIG_OS)
-			continue;
-
-		if (strcmp(part->header.name, "ppc64,linux"))
-			continue;
-
-		if ((part->header.length - 1) * NVRAM_BLOCK_LEN >= NVRAM_MIN_REQ) {
-			/* found our partition */
-			nvram_error_log_index = part->index + NVRAM_HEADER_LEN;
-			nvram_error_log_size = ((part->header.length - 1) *
-						NVRAM_BLOCK_LEN) - sizeof(struct err_log_info);
-			return 0;
-		}
+	p = nvram_find_partition("ppc64,linux", NVRAM_SIG_OS, &size);
 
-		/* Found one but it's too small, remove it */
+	/* Found one but too small, remove it */
+	if (p && size < NVRAM_MIN_REQ) {
+		pr_info("nvram: Found too small ppc64,linux partition"
+			",removing it...");
 		nvram_remove_partition("ppc64,linux", NVRAM_SIG_OS);
+		p = 0;
 	}
-	
-	/* try creating a partition with the free space we have */
-	rc = nvram_create_partition("ppc64,linux", NVRAM_SIG_OS,
-				       NVRAM_MAX_REQ, NVRAM_MIN_REQ);
-	if (rc < 0) {
-		/* need to free up some space, remove any "OS" partition */
-		nvram_remove_partition(NULL, NVRAM_SIG_OS);
-	
-		/* Try again */
-		rc = nvram_create_partition("ppc64,linux", NVRAM_SIG_OS,
-					    NVRAM_MAX_REQ, NVRAM_MIN_REQ);
-		if (rc < 0) {
-			pr_err("nvram_create_partition: Could not find"
-			       " enough space in NVRAM for partition\n");
-			return rc;
+
+	/* Create one if we didn't find */
+	if (!p) {
+		p = nvram_create_partition("ppc64,linux", NVRAM_SIG_OS,
+					   NVRAM_MAX_REQ, NVRAM_MIN_REQ);
+		/* No room for it, try to get rid of any OS partition
+		 * and try again
+		 */
+		if (p == -ENOSPC) {
+			pr_info("nvram: No room to create ppc64,linux"
+				" partition, deleting all OS partitions...");
+			nvram_remove_partition(NULL, NVRAM_SIG_OS);
+			p = nvram_create_partition("ppc64,linux", NVRAM_SIG_OS,
+						   NVRAM_MAX_REQ, NVRAM_MIN_REQ);
 		}
 	}
+
+	if (p <= 0) {
+		pr_err("nvram: Failed to find or create ppc64,linux"
+		       " partition, err %d\n", (int)p);
+		return 0;
+	}
+
+	nvram_error_log_index = p;
+	nvram_error_log_size = nvram_get_partition_size(p) -
+		sizeof(struct err_log_info);
 	
-	nvram_error_log_index = rc;	
-	nvram_error_log_size = nvram_get_partition_size(rc) - sizeof(struct err_log_info);	
 	return 0;
 }
 
-- 
1.7.1
