Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp05.au.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4F4781007DA
	for <linuxppc-dev@ozlabs.org>; Mon,  2 Aug 2010 10:55:39 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp05.au.ibm.com (8.14.4/8.13.1) with ESMTP id o720pIm6000471
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Aug 2010 10:51:18 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o720tciX1855500
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Aug 2010 10:55:38 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o720tc97022576
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Aug 2010 10:55:38 +1000
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 11/11] powerpc/nvram: Rename ppc64, linux partition to ibm,
	rtas-log
Date: Mon,  2 Aug 2010 10:55:22 +1000
Message-Id: <1280710522-6362-12-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1280710522-6362-11-git-send-email-benh@kernel.crashing.org>
References: <1280710522-6362-1-git-send-email-benh@kernel.crashing.org>
	<1280710522-6362-2-git-send-email-benh@kernel.crashing.org>
	<1280710522-6362-3-git-send-email-benh@kernel.crashing.org>
	<1280710522-6362-4-git-send-email-benh@kernel.crashing.org>
	<1280710522-6362-5-git-send-email-benh@kernel.crashing.org>
	<1280710522-6362-6-git-send-email-benh@kernel.crashing.org>
	<1280710522-6362-7-git-send-email-benh@kernel.crashing.org>
	<1280710522-6362-8-git-send-email-benh@kernel.crashing.org>
	<1280710522-6362-9-git-send-email-benh@kernel.crashing.org>
	<1280710522-6362-10-git-send-email-benh@kernel.crashing.org>
	<1280710522-6362-11-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I'm not aware of any userspace tool accessing it by its name anyways,
it's read back by the kernel itself on the next boot to get back
older log entries

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/platforms/pseries/nvram.c |   23 +++++++++++++----------
 1 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/nvram.c b/arch/powerpc/platforms/pseries/nvram.c
index c8b3f0f..e3acb0b 100644
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
@@ -277,34 +279,35 @@ static int __init pseries_nvram_init_log_partition(void)
 	loff_t p;
 	int size;
 
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
 					   NVRAM_MIN_REQ, NVRAM_MAX_REQ);
 		/* No room for it, try to get rid of any OS partition
 		 * and try again
 		 */
 		if (p == -ENOSPC) {
-			pr_info("nvram: No room to create ppc64,linux"
+			pr_info("nvram: No room to create "NVRAM_LOG_PART_NAME
 				" partition, deleting all OS partitions...");
 			nvram_remove_partition(NULL, NVRAM_SIG_OS);
-			p = nvram_create_partition("ppc64,linux", NVRAM_SIG_OS,
-						   NVRAM_MIN_REQ, NVRAM_MAX_REQ);
+			p = nvram_create_partition(NVRAM_LOG_PART_NAME,
+						   NVRAM_SIG_OS, NVRAM_MIN_REQ,
+						   NVRAM_MAX_REQ);
 		}
 	}
 
 	if (p <= 0) {
-		pr_err("nvram: Failed to find or create ppc64,linux"
+		pr_err("nvram: Failed to find or create "NVRAM_LOG_PART_NAME
 		       " partition, err %d\n", (int)p);
 		return 0;
 	}
-- 
1.6.3.3
