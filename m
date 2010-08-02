Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B0E48B70DF
	for <linuxppc-dev@ozlabs.org>; Mon,  2 Aug 2010 10:55:38 +1000 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp06.au.ibm.com (8.14.4/8.13.1) with ESMTP id o720tWXE026377
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Aug 2010 10:55:32 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o720tcc11745092
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Aug 2010 10:55:38 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o720tboN001078
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Aug 2010 10:55:38 +1000
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 05/11] powerpc/nvram: Completely clear a new partition
Date: Mon,  2 Aug 2010 10:55:16 +1000
Message-Id: <1280710522-6362-6-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1280710522-6362-5-git-send-email-benh@kernel.crashing.org>
References: <1280710522-6362-1-git-send-email-benh@kernel.crashing.org>
	<1280710522-6362-2-git-send-email-benh@kernel.crashing.org>
	<1280710522-6362-3-git-send-email-benh@kernel.crashing.org>
	<1280710522-6362-4-git-send-email-benh@kernel.crashing.org>
	<1280710522-6362-5-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When creating a partition, we clear it entirely rather than
just the first two words since the previous code was rather
specific to the pseries log partition format.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/nvram_64.c |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/nvram_64.c b/arch/powerpc/kernel/nvram_64.c
index dd18a5a..7ddeaa6 100644
--- a/arch/powerpc/kernel/nvram_64.c
+++ b/arch/powerpc/kernel/nvram_64.c
@@ -320,7 +320,7 @@ static int __init nvram_create_partition(const char *name, int sig,
 	struct nvram_partition *part;
 	struct nvram_partition *new_part;
 	struct nvram_partition *free_part = NULL;
-	int seq_init[2] = { 0, 0 };
+	static char nv_init_vals[16];
 	loff_t tmp_index;
 	long size = 0;
 	int rc;
@@ -379,14 +379,15 @@ static int __init nvram_create_partition(const char *name, int sig,
 		return rc;
 	}
 
-	/* make sure and initialize to zero the sequence number and the error
-	   type logged */
-	tmp_index = new_part->index + NVRAM_HEADER_LEN;
-	rc = ppc_md.nvram_write((char *)&seq_init, sizeof(seq_init), &tmp_index);
-	if (rc <= 0) {
-		printk(KERN_ERR "nvram_create_os_partition: nvram_write "
-		       "failed (%d)\n", rc);
-		return rc;
+	/* Clear the partition */
+	for (tmp_index = new_part->index + NVRAM_HEADER_LEN;
+	     tmp_index <  ((size - 1) * NVRAM_BLOCK_LEN);
+	     tmp_index += NVRAM_BLOCK_LEN) {
+		rc = ppc_md.nvram_write(nv_init_vals, NVRAM_BLOCK_LEN, &tmp_index);
+		if (rc <= 0) {
+			pr_err("nvram_create_partition: nvram_write failed (%d)\n", rc);
+			return rc;
+		}
 	}
 	
 	nvram_error_log_index = new_part->index + NVRAM_HEADER_LEN;
-- 
1.6.3.3
