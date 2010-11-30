Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp08.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1D75A100821
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Nov 2010 16:47:53 +1100 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp08.au.ibm.com (8.14.4/8.13.1) with ESMTP id oAU5lqEG028720
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Nov 2010 16:47:52 +1100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	oAU5lqL82240530
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Nov 2010 16:47:52 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	oAU5lqft026251
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Nov 2010 16:47:52 +1100
From: benh@kernel.crashing.org
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 12/13] powerpc/nvram: Fix NVRAM partition list setup
Date: Tue, 30 Nov 2010 16:47:42 +1100
Message-Id: <1291096063-14386-12-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1291096063-14386-1-git-send-email-benh@kernel.crashing.org>
References: <1291096063-14386-1-git-send-email-benh@kernel.crashing.org>
Cc: Jim Keniston <jkenisto@us.ibm.com>, jkensito@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Jim Keniston <jkenisto@us.ibm.com>

Simplify creation and use of the NVRAM partition list.

Signed-off-by: Jim Keniston <jkenisto@us.ibm.com>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/nvram_64.c |   26 ++++++++------------------
 1 files changed, 8 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/kernel/nvram_64.c b/arch/powerpc/kernel/nvram_64.c
index 125d86c..b8a50fa 100644
--- a/arch/powerpc/kernel/nvram_64.c
+++ b/arch/powerpc/kernel/nvram_64.c
@@ -51,7 +51,7 @@ struct nvram_partition {
 	unsigned int index;
 };
 
-static struct nvram_partition * nvram_part;
+static LIST_HEAD(nvram_partitions);
 
 static loff_t dev_nvram_llseek(struct file *file, loff_t offset, int origin)
 {
@@ -196,13 +196,11 @@ static struct miscdevice nvram_dev = {
 #ifdef DEBUG_NVRAM
 static void __init nvram_print_partitions(char * label)
 {
-	struct list_head * p;
 	struct nvram_partition * tmp_part;
 	
 	printk(KERN_WARNING "--------%s---------\n", label);
 	printk(KERN_WARNING "indx\t\tsig\tchks\tlen\tname\n");
-	list_for_each(p, &nvram_part->partition) {
-		tmp_part = list_entry(p, struct nvram_partition, partition);
+	list_for_each_entry(tmp_part, &nvram_partitions, partition) {
 		printk(KERN_WARNING "%4d    \t%02x\t%02x\t%d\t%s\n",
 		       tmp_part->index, tmp_part->header.signature,
 		       tmp_part->header.checksum, tmp_part->header.length,
@@ -250,7 +248,7 @@ int __init nvram_remove_partition(const char *name, int sig)
 	struct nvram_partition *part, *prev, *tmp;
 	int rc;
 
-	list_for_each_entry(part, &nvram_part->partition, partition) {
+	list_for_each_entry(part, &nvram_partitions, partition) {
 		if (part->header.signature != sig)
 			continue;
 		if (name && strncmp(name, part->header.name, 12))
@@ -269,7 +267,7 @@ int __init nvram_remove_partition(const char *name, int sig)
 
 	/* Merge contiguous ones */
 	prev = NULL;
-	list_for_each_entry_safe(part, tmp, &nvram_part->partition, partition) {
+	list_for_each_entry_safe(part, tmp, &nvram_partitions, partition) {
 		if (part->header.signature != NVRAM_SIG_FREE) {
 			prev = NULL;
 			continue;
@@ -333,7 +331,7 @@ loff_t __init nvram_create_partition(const char *name, int sig,
 
 	/* Find a free partition that will give us the maximum needed size 
 	   If can't find one that will give us the minimum size needed */
-	list_for_each_entry(part, &nvram_part->partition, partition) {
+	list_for_each_entry(part, &nvram_partitions, partition) {
 		if (part->header.signature != NVRAM_SIG_FREE)
 			continue;
 
@@ -412,7 +410,7 @@ int nvram_get_partition_size(loff_t data_index)
 {
 	struct nvram_partition *part;
 	
-	list_for_each_entry(part, &nvram_part->partition, partition) {
+	list_for_each_entry(part, &nvram_partitions, partition) {
 		if (part->index + NVRAM_HEADER_LEN == data_index)
 			return (part->header.length - 1) * NVRAM_BLOCK_LEN;
 	}
@@ -430,7 +428,7 @@ loff_t nvram_find_partition(const char *name, int sig, int *out_size)
 {
 	struct nvram_partition *p;
 
-	list_for_each_entry(p, &nvram_part->partition, partition) {
+	list_for_each_entry(p, &nvram_partitions, partition) {
 		if (p->header.signature == sig &&
 		    (!name || !strncmp(p->header.name, name, 12))) {
 			if (out_size)
@@ -452,14 +450,6 @@ int __init nvram_scan_partitions(void)
 	int total_size;
 	int err;
 
-  	/* Initialize our anchor for the nvram partition list */
-  	nvram_part = kmalloc(sizeof(struct nvram_partition), GFP_KERNEL);
-  	if (!nvram_part) {
-  		printk(KERN_ERR "nvram_init: Failed kmalloc\n");
-  		return -ENOMEM;
-  	}
-  	INIT_LIST_HEAD(&nvram_part->partition);
-  
 	if (ppc_md.nvram_size == NULL || ppc_md.nvram_size() <= 0)
 		return -ENODEV;
 	total_size = ppc_md.nvram_size();
@@ -507,7 +497,7 @@ int __init nvram_scan_partitions(void)
 		
 		memcpy(&tmp_part->header, &phead, NVRAM_HEADER_LEN);
 		tmp_part->index = cur_index;
-		list_add_tail(&tmp_part->partition, &nvram_part->partition);
+		list_add_tail(&tmp_part->partition, &nvram_partitions);
 		
 		cur_index += phead.length * NVRAM_BLOCK_LEN;
 	}
-- 
1.7.1
