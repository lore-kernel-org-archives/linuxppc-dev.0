Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp01.au.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6C8381007D2
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Nov 2010 16:47:52 +1100 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp01.au.ibm.com (8.14.4/8.13.1) with ESMTP id oAU5iXqX023418
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Nov 2010 16:44:33 +1100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	oAU5lpTo1450132
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Nov 2010 16:47:51 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	oAU5lpul027185
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Nov 2010 16:47:51 +1100
From: benh@kernel.crashing.org
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 03/13] powerpc/nvram: nvram_create_partitions() now uses bytes
Date: Tue, 30 Nov 2010 16:47:33 +1100
Message-Id: <1291096063-14386-3-git-send-email-benh@kernel.crashing.org>
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

This converts nvram_create_partition() to use a size in bytes
rather than blocks. It does the appropriate alignment internally

The size passed is also the data size (ie. doesn't include the
header anymore).

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/nvram_64.c |   20 ++++++++++++++------
 1 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/nvram_64.c b/arch/powerpc/kernel/nvram_64.c
index 9e13335..a5a5587 100644
--- a/arch/powerpc/kernel/nvram_64.c
+++ b/arch/powerpc/kernel/nvram_64.c
@@ -34,10 +34,10 @@
 
 #undef DEBUG_NVRAM
 
-#define NVRAM_HEADER_LEN 16 /* sizeof(struct nvram_header) */
-#define NVRAM_BLOCK_LEN 16
-#define NVRAM_MAX_REQ (2080/NVRAM_BLOCK_LEN)
-#define NVRAM_MIN_REQ (1056/NVRAM_BLOCK_LEN)
+#define NVRAM_HEADER_LEN	sizeof(struct nvram_header)
+#define NVRAM_BLOCK_LEN		NVRAM_HEADER_LEN
+#define NVRAM_MAX_REQ		2079
+#define NVRAM_MIN_REQ		1055
 
 /* If change this size, then change the size of NVNAME_LEN */
 struct nvram_header {
@@ -311,7 +311,7 @@ static int __init nvram_remove_os_partition(void)
  * nvram_create_partition - Create a partition in nvram
  * @name: name of the partition to create
  * @sig: signature of the partition to create
- * @req_size: size to allocate preferrably
+ * @req_size: size of data to allocate in bytes
  * @min_size: minimum acceptable size (0 means req_size)
  */
 static int __init nvram_create_partition(const char *name, int sig,
@@ -325,12 +325,20 @@ static int __init nvram_create_partition(const char *name, int sig,
 	long size = 0;
 	int rc;
 
+	/* Convert sizes from bytes to blocks */
+	req_size = _ALIGN_UP(req_size, NVRAM_BLOCK_LEN) / NVRAM_BLOCK_LEN;
+	min_size = _ALIGN_UP(min_size, NVRAM_BLOCK_LEN) / NVRAM_BLOCK_LEN;
+
 	/* If no minimum size specified, make it the same as the
 	 * requested size
 	 */
 	if (min_size == 0)
 		min_size = req_size;
 
+	/* Now add one block to each for the header */
+	req_size += 1;
+	min_size += 1;
+
 	/* Find a free partition that will give us the maximum needed size 
 	   If can't find one that will give us the minimum size needed */
 	list_for_each_entry(part, &nvram_part->partition, partition) {
@@ -450,7 +458,7 @@ static int __init nvram_setup_partition(void)
 		if (strcmp(part->header.name, "ppc64,linux"))
 			continue;
 
-		if (part->header.length >= NVRAM_MIN_REQ) {
+		if ((part->header.length - 1) * NVRAM_BLOCK_LEN >= NVRAM_MIN_REQ) {
 			/* found our partition */
 			nvram_error_log_index = part->index + NVRAM_HEADER_LEN;
 			nvram_error_log_size = ((part->header.length - 1) *
-- 
1.7.1
