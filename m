Return-Path: <cascardo@linux.vnet.ibm.com>
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e24smtp05.br.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4B62A2C00D8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Dec 2012 06:09:14 +1100 (EST)
Received: from /spool/local
 by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cascardo@linux.vnet.ibm.com>;
 Fri, 28 Dec 2012 17:09:05 -0200
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 6A2281DC0052
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Dec 2012 14:09:03 -0500 (EST)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay02.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 qBSJ8ea135323916
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Dec 2012 17:08:40 -0200
Received: from d24av05.br.ibm.com (loopback [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 qBSJ929x030482
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Dec 2012 17:09:02 -0200
From: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] ppc/iommu: use find_first_bit to look up entries in the
 iommu table
Date: Fri, 28 Dec 2012 17:08:52 -0200
Message-Id: <1356721732-24556-2-git-send-email-cascardo@linux.vnet.ibm.com>
In-Reply-To: <20121228165504.GC21831@oc0268524204.ibm.com>
References: <20121228165504.GC21831@oc0268524204.ibm.com>
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
 arch/powerpc/kernel/iommu.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index 6d48ff8..91e2b99 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
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
