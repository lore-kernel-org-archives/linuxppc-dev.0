Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp08.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6DCD51008C2
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Nov 2010 16:47:54 +1100 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp08.au.ibm.com (8.14.4/8.13.1) with ESMTP id oAU5lqva028601
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Nov 2010 16:47:52 +1100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	oAU5lppb1749204
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Nov 2010 16:47:51 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	oAU5lp4A027204
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Nov 2010 16:47:51 +1100
From: benh@kernel.crashing.org
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 08/13] powerpc/nvram: Add nvram_find_partition()
Date: Tue, 30 Nov 2010 16:47:38 +1100
Message-Id: <1291096063-14386-8-git-send-email-benh@kernel.crashing.org>
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

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/nvram_64.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/nvram_64.c b/arch/powerpc/kernel/nvram_64.c
index 6dd2700..01e6844 100644
--- a/arch/powerpc/kernel/nvram_64.c
+++ b/arch/powerpc/kernel/nvram_64.c
@@ -429,6 +429,28 @@ static int nvram_get_partition_size(loff_t data_index)
 }
 
 
+/**
+ * nvram_find_partition - Find an nvram partition by signature and name
+ * @name: Name of the partition or NULL for any name
+ * @sig: Signature to test against
+ * @out_size: if non-NULL, returns the size of the data part of the partition
+ */
+loff_t nvram_find_partition(const char *name, int sig, int *out_size)
+{
+	struct nvram_partition *p;
+
+	list_for_each_entry(p, &nvram_part->partition, partition) {
+		if (p->header.signature == sig &&
+		    (!name || !strncmp(p->header.name, name, 12))) {
+			if (out_size)
+				*out_size = (p->header.length - 1) *
+					NVRAM_BLOCK_LEN;
+			return p->index + NVRAM_HEADER_LEN;
+		}
+	}
+	return 0;
+}
+
 /* nvram_setup_partition
  *
  * This will setup the partition we need for buffering the
-- 
1.7.1
