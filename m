Return-Path: <jkenisto@us.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C275BB7174
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Nov 2010 15:54:39 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id oAC4gq3j021576
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Nov 2010 21:42:52 -0700
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	oAC4sMQi256566
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Nov 2010 21:54:24 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id oAC4sMfk013724
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Nov 2010 21:54:22 -0700
Received: from localhost.localdomain (w-jimk.beaverton.ibm.com [9.47.28.66])
	by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
	oAC4sMiZ013712
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Nov 2010 21:54:22 -0700
From: Jim Keniston <jkenisto@us.ibm.com>
Subject: [PATCH 3/4] Fix NVRAM partition list setup
To: linuxppc-dev@lists.ozlabs.org
Date: Thu, 11 Nov 2010 20:54:22 -0800
Message-ID: <20101112045421.4290.65339.stgit@localhost.localdomain>
In-Reply-To: <20101112045346.4290.43739.stgit@localhost.localdomain>
References: <20101112045346.4290.43739.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Simplify creation and use of the NVRAM partition list.

Signed-off-by: Jim Keniston <jkenisto@us.ibm.com>
---

 arch/powerpc/kernel/nvram_64.c |   26 ++++++++------------------
 1 files changed, 8 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/kernel/nvram_64.c b/arch/powerpc/kernel/nvram_64.c
index d467f8c..19122d4 100644
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
@@ -499,7 +497,7 @@ static int __init nvram_scan_partitions(void)
 		
 		memcpy(&tmp_part->header, &phead, NVRAM_HEADER_LEN);
 		tmp_part->index = cur_index;
-		list_add_tail(&tmp_part->partition, &nvram_part->partition);
+		list_add_tail(&tmp_part->partition, &nvram_partitions);
 		
 		cur_index += phead.length * NVRAM_BLOCK_LEN;
 	}
@@ -526,14 +524,6 @@ static int __init nvram_init(void)
 		return rc;
 	}
   	
-  	/* initialize our anchor for the nvram partition list */
-  	nvram_part = kmalloc(sizeof(struct nvram_partition), GFP_KERNEL);
-  	if (!nvram_part) {
-  		printk(KERN_ERR "nvram_init: Failed kmalloc\n");
-  		return -ENOMEM;
-  	}
-  	INIT_LIST_HEAD(&nvram_part->partition);
-  
   	/* Get all the NVRAM partitions */
   	error = nvram_scan_partitions();
   	if (error) {
