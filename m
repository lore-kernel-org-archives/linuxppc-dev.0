Return-Path: <cascardo@linux.vnet.ibm.com>
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e24smtp02.br.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 83B362C00BF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2013 06:34:00 +1100 (EST)
Received: from /spool/local
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cascardo@linux.vnet.ibm.com>;
 Thu, 10 Jan 2013 17:33:55 -0200
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 6A75F1DC005A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2013 14:33:52 -0500 (EST)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
 by d24relay01.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r0AJWevw2117702
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2013 17:32:41 -0200
Received: from d24av01.br.ibm.com (loopback [127.0.0.1])
 by d24av01.br.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r0AJXpq5019678
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2013 17:33:51 -0200
From: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] ppc/iommu: use find_first_bit to look up entries in the
 iommu table
Date: Thu, 10 Jan 2013 17:33:39 -0200
Message-Id: <1357846419-13515-1-git-send-email-cascardo@linux.vnet.ibm.com>
Cc: paulus@samba.org, shangw@linux.vnet.ibm.com,
 Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
---
v2:
Remove the unneeded extra variable i, which caused build failure.
---
 arch/powerpc/kernel/iommu.c |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index 6d48ff8..0fc44d2 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -708,7 +708,7 @@ struct iommu_table *iommu_init_table(struct iommu_table *tbl, int nid)
 
 void iommu_free_table(struct iommu_table *tbl, const char *node_name)
 {
-	unsigned long bitmap_sz, i;
+	unsigned long bitmap_sz;
 	unsigned int order;
 
 	if (!tbl || !tbl->it_map) {
@@ -725,14 +725,9 @@ void iommu_free_table(struct iommu_table *tbl, const char *node_name)
 		clear_bit(0, tbl->it_map);
 
 	/* verify that table contains no entries */
-	/* it_size is in entries, and we're examining 64 at a time */
-	for (i = 0; i < (tbl->it_size/64); i++) {
-		if (tbl->it_map[i] != 0) {
+	if (find_first_bit(tbl->it_map, tbl->it_size) < tbl->it_size)
 			printk(KERN_WARNING "%s: Unexpected TCEs for %s\n",
 				__func__, node_name);
-			break;
-		}
-	}
 
 	/* calculate bitmap size in bytes */
 	bitmap_sz = (tbl->it_size + 7) / 8;
-- 
1.7.1
