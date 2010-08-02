Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp04.au.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E783FB70DF
	for <linuxppc-dev@ozlabs.org>; Mon,  2 Aug 2010 10:55:38 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp04.au.ibm.com (8.14.4/8.13.1) with ESMTP id o720pDDA016112
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Aug 2010 10:51:13 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o720tcc91658914
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Aug 2010 10:55:38 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o720tcVY019693
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Aug 2010 10:55:38 +1000
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 08/11] powerpc/nvram: Add nvram_find_partition()
Date: Mon,  2 Aug 2010 10:55:19 +1000
Message-Id: <1280710522-6362-9-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1280710522-6362-8-git-send-email-benh@kernel.crashing.org>
References: <1280710522-6362-1-git-send-email-benh@kernel.crashing.org>
	<1280710522-6362-2-git-send-email-benh@kernel.crashing.org>
	<1280710522-6362-3-git-send-email-benh@kernel.crashing.org>
	<1280710522-6362-4-git-send-email-benh@kernel.crashing.org>
	<1280710522-6362-5-git-send-email-benh@kernel.crashing.org>
	<1280710522-6362-6-git-send-email-benh@kernel.crashing.org>
	<1280710522-6362-7-git-send-email-benh@kernel.crashing.org>
	<1280710522-6362-8-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/nvram_64.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/nvram_64.c b/arch/powerpc/kernel/nvram_64.c
index c934b5a..fd0d12d 100644
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
1.6.3.3
