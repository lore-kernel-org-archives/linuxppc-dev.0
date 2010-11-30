Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp02.au.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 20228100815
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Nov 2010 16:47:53 +1100 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp02.au.ibm.com (8.14.4/8.13.1) with ESMTP id oAU5h8vt013549
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Nov 2010 16:43:08 +1100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	oAU5lqT92240528
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Nov 2010 16:47:52 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	oAU5lpxM013262
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Nov 2010 16:47:52 +1100
From: benh@kernel.crashing.org
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 11/13] powerpc/nvram: Rename ppc64, linux partition to ibm,
	rtas-log
Date: Tue, 30 Nov 2010 16:47:41 +1100
Message-Id: <1291096063-14386-11-git-send-email-benh@kernel.crashing.org>
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

I'm not aware of any userspace tool accessing it by its name anyways,
it's read back by the kernel itself on the next boot to get back
older log entries

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/platforms/pseries/nvram.c |   23 +++++++++++++----------
 1 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/nvram.c b/arch/powerpc/platforms/pseries/nvram.c
index 55a7141..7e828ba 100644
--- a/arch/powerpc/platforms/pseries/nvram.c
+++ b/arch/powerpc/platforms/pseries/nvram.c
@@ -40,6 +40,8 @@ struct err_log_info {
 #define NVRAM_MAX_REQ		2079
 #define NVRAM_MIN_REQ		1055
 
+#define NVRAM_LOG_PART_NAME	"ibm,rtas-log"
+
 static ssize_t pSeries_nvram_read(char *buf, size_t count, loff_t *index)
 {
 	unsigned int i;
@@ -262,8 +264,8 @@ int nvram_clear_error_log(void)
  * error logs and cleanup partitions if needed.
  *
  * The general strategy is the following:
- * 1.) If there is ppc64,linux partition large enough then use it.
- * 2.) If there is not a ppc64,linux partition large enough, search
+ * 1.) If there is log partition large enough then use it.
+ * 2.) If there is none large enough, search
  * for a free partition that is large enough.
  * 3.) If there is not a free partition large enough remove 
  * _all_ OS partitions and consolidate the space.
@@ -281,34 +283,35 @@ static int __init pseries_nvram_init_log_partition(void)
 	nvram_scan_partitions();
 
 	/* Lookg for ours */
-	p = nvram_find_partition("ppc64,linux", NVRAM_SIG_OS, &size);
+	p = nvram_find_partition(NVRAM_LOG_PART_NAME, NVRAM_SIG_OS, &size);
 
 	/* Found one but too small, remove it */
 	if (p && size < NVRAM_MIN_REQ) {
-		pr_info("nvram: Found too small ppc64,linux partition"
+		pr_info("nvram: Found too small "NVRAM_LOG_PART_NAME" partition"
 			",removing it...");
-		nvram_remove_partition("ppc64,linux", NVRAM_SIG_OS);
+		nvram_remove_partition(NVRAM_LOG_PART_NAME, NVRAM_SIG_OS);
 		p = 0;
 	}
 
 	/* Create one if we didn't find */
 	if (!p) {
-		p = nvram_create_partition("ppc64,linux", NVRAM_SIG_OS,
+		p = nvram_create_partition(NVRAM_LOG_PART_NAME, NVRAM_SIG_OS,
 					   NVRAM_MAX_REQ, NVRAM_MIN_REQ);
 		/* No room for it, try to get rid of any OS partition
 		 * and try again
 		 */
 		if (p == -ENOSPC) {
-			pr_info("nvram: No room to create ppc64,linux"
+			pr_info("nvram: No room to create "NVRAM_LOG_PART_NAME
 				" partition, deleting all OS partitions...");
 			nvram_remove_partition(NULL, NVRAM_SIG_OS);
-			p = nvram_create_partition("ppc64,linux", NVRAM_SIG_OS,
-						   NVRAM_MAX_REQ, NVRAM_MIN_REQ);
+			p = nvram_create_partition(NVRAM_LOG_PART_NAME,
+						   NVRAM_SIG_OS, NVRAM_MAX_REQ,
+						   NVRAM_MIN_REQ);
 		}
 	}
 
 	if (p <= 0) {
-		pr_err("nvram: Failed to find or create ppc64,linux"
+		pr_err("nvram: Failed to find or create "NVRAM_LOG_PART_NAME
 		       " partition, err %d\n", (int)p);
 		return 0;
 	}
-- 
1.7.1
