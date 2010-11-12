Return-Path: <jkenisto@us.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 86387B76F0
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Nov 2010 15:54:43 +1100 (EST)
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e33.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id oAC4mvqM013174
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Nov 2010 21:48:57 -0700
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	oAC4sSN4141014
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Nov 2010 21:54:28 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id oAC4sSUG018876
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Nov 2010 21:54:28 -0700
Received: from localhost.localdomain (w-jimk.beaverton.ibm.com [9.47.28.66])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
	oAC4sRFJ018855
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Nov 2010 21:54:28 -0700
From: Jim Keniston <jkenisto@us.ibm.com>
Subject: [PATCH 4/4] Handle partition names >= 12 chars
To: linuxppc-dev@lists.ozlabs.org
Date: Thu, 11 Nov 2010 20:54:27 -0800
Message-ID: <20101112045427.4290.42180.stgit@localhost.localdomain>
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

The name field in the nvram_header can be < 12 chars, null-terminated,
or 12 chars without the null.  Handle this safely.

Signed-off-by: Jim Keniston <jkenisto@us.ibm.com>
---

 arch/powerpc/kernel/nvram_64.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/nvram_64.c b/arch/powerpc/kernel/nvram_64.c
index 19122d4..cda7c3f 100644
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
