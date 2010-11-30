Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp07.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C10F910087B
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Nov 2010 16:47:53 +1100 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp07.au.ibm.com (8.14.4/8.13.1) with ESMTP id oAU5lrhu004851
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Nov 2010 16:47:53 +1100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	oAU5lr271618008
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Nov 2010 16:47:53 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	oAU5lqfp001216
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Nov 2010 16:47:53 +1100
From: benh@kernel.crashing.org
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 13/13] powerpc/nvram: Handle partition names >= 12 chars
Date: Tue, 30 Nov 2010 16:47:43 +1100
Message-Id: <1291096063-14386-13-git-send-email-benh@kernel.crashing.org>
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

The name field in the nvram_header can be < 12 chars, null-terminated,
or 12 chars without the null.  Handle this safely.

Signed-off-by: Jim Keniston <jkenisto@us.ibm.com>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/nvram_64.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/nvram_64.c b/arch/powerpc/kernel/nvram_64.c
index b8a50fa..bb12b32 100644
--- a/arch/powerpc/kernel/nvram_64.c
+++ b/arch/powerpc/kernel/nvram_64.c
@@ -42,6 +42,7 @@ struct nvram_header {
 	unsigned char signature;
 	unsigned char checksum;
 	unsigned short length;
+	/* Terminating null required only for names < 12 chars. */
 	char name[12];
 };
 
@@ -201,7 +202,7 @@ static void __init nvram_print_partitions(char * label)
 	printk(KERN_WARNING "--------%s---------\n", label);
 	printk(KERN_WARNING "indx\t\tsig\tchks\tlen\tname\n");
 	list_for_each_entry(tmp_part, &nvram_partitions, partition) {
-		printk(KERN_WARNING "%4d    \t%02x\t%02x\t%d\t%s\n",
+		printk(KERN_WARNING "%4d    \t%02x\t%02x\t%d\t%12s\n",
 		       tmp_part->index, tmp_part->header.signature,
 		       tmp_part->header.checksum, tmp_part->header.length,
 		       tmp_part->header.name);
@@ -256,7 +257,7 @@ int __init nvram_remove_partition(const char *name, int sig)
 
 		/* Make partition a free partition */
 		part->header.signature = NVRAM_SIG_FREE;
-		sprintf(part->header.name, "wwwwwwwwwwww");
+		strncpy(part->header.name, "wwwwwwwwwwww", 12);
 		part->header.checksum = nvram_checksum(&part->header);
 		rc = nvram_write_header(part);
 		if (rc <= 0) {
-- 
1.7.1
