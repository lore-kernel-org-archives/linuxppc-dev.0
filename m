Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp07.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6F1511007D5
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Nov 2010 16:47:52 +1100 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp07.au.ibm.com (8.14.4/8.13.1) with ESMTP id oAU5lqSG004767
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Nov 2010 16:47:52 +1100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	oAU5lpC22515028
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Nov 2010 16:47:51 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	oAU5lpBI027193
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Nov 2010 16:47:51 +1100
From: benh@kernel.crashing.org
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 05/13] powerpc/nvram: Completely clear a new partition
Date: Tue, 30 Nov 2010 16:47:35 +1100
Message-Id: <1291096063-14386-5-git-send-email-benh@kernel.crashing.org>
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

When creating a partition, we clear it entirely rather than
just the first two words since the previous code was rather
specific to the pseries log partition format.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/nvram_64.c |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/nvram_64.c b/arch/powerpc/kernel/nvram_64.c
index f753882..02737e6 100644
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
1.7.1
