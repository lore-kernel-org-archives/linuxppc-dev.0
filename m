Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp09.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 16EA31007D6
	for <linuxppc-dev@ozlabs.org>; Mon,  2 Aug 2010 10:55:39 +1000 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp09.au.ibm.com (8.14.4/8.13.1) with ESMTP id o720tcKr018024
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Aug 2010 10:55:38 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o720tcA41720560
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Aug 2010 10:55:38 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o720tcmc022515
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Aug 2010 10:55:38 +1000
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 09/11] powerpc/nvram: Change nvram_setup_partition() to use
	new helper
Date: Mon,  2 Aug 2010 10:55:20 +1000
Message-Id: <1280710522-6362-10-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1280710522-6362-9-git-send-email-benh@kernel.crashing.org>
References: <1280710522-6362-1-git-send-email-benh@kernel.crashing.org>
	<1280710522-6362-2-git-send-email-benh@kernel.crashing.org>
	<1280710522-6362-3-git-send-email-benh@kernel.crashing.org>
	<1280710522-6362-4-git-send-email-benh@kernel.crashing.org>
	<1280710522-6362-5-git-send-email-benh@kernel.crashing.org>
	<1280710522-6362-6-git-send-email-benh@kernel.crashing.org>
	<1280710522-6362-7-git-send-email-benh@kernel.crashing.org>
	<1280710522-6362-8-git-send-email-benh@kernel.crashing.org>
	<1280710522-6362-9-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This changes the function to use nvram_find_partition() instead
of doing the lookup "by hand". It also makes some of the logic
clearer and prints out more useful diagnostic information.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/nvram_64.c |   72 ++++++++++++++++++----------------------
 1 files changed, 32 insertions(+), 40 deletions(-)

diff --git a/arch/powerpc/kernel/nvram_64.c b/arch/powerpc/kernel/nvram_64.c
index fd0d12d..ddc94cf 100644
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
@@ -481,48 +480,41 @@ static int __init nvram_setup_partition(void)
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
-				       NVRAM_MIN_REQ, NVRAM_MAX_REQ);
-	if (rc < 0) {
-		/* need to free up some space, remove any "OS" partition */
-		nvram_remove_partition(NULL, NVRAM_SIG_OS);
-	
-		/* Try again */
-		rc = nvram_create_partition("ppc64,linux", NVRAM_SIG_OS,
-					    NVRAM_MIN_REQ, NVRAM_MAX_REQ);
-		if (rc < 0) {
-			pr_err("nvram_create_partition: Could not find"
-			       " enough space in NVRAM for partition\n");
-			return rc;
+
+	/* Create one if we didn't find */
+	if (!p) {
+		p = nvram_create_partition("ppc64,linux", NVRAM_SIG_OS,
+					   NVRAM_MIN_REQ, NVRAM_MAX_REQ);
+		/* No room for it, try to get rid of any OS partition
+		 * and try again
+		 */
+		if (p == -ENOSPC) {
+			pr_info("nvram: No room to create ppc64,linux"
+				" partition, deleting all OS partitions...");
+			nvram_remove_partition(NULL, NVRAM_SIG_OS);
+			p = nvram_create_partition("ppc64,linux", NVRAM_SIG_OS,
+						   NVRAM_MIN_REQ, NVRAM_MAX_REQ);
 		}
 	}
-	
-	nvram_error_log_index = rc;	
-	nvram_error_log_size = nvram_get_partition_size(rc) - sizeof(struct err_log_info);
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
 	
 	return 0;
 }
-- 
1.6.3.3
