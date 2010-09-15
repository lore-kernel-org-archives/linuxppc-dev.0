Return-Path: <nacc@us.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C3B6CB6F11
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Sep 2010 04:06:42 +1000 (EST)
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e34.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o8FHvNBK021390
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Sep 2010 11:57:23 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o8FI6Z0F027924
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Sep 2010 12:06:35 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o8FI6YO2005171
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Sep 2010 12:06:35 -0600
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: nacc@us.ibm.com
Subject: [PATCH 05/15] viobus: free TCE table on device release
Date: Wed, 15 Sep 2010 11:05:48 -0700
Message-Id: <1284573958-8397-6-git-send-email-nacc@us.ibm.com>
In-Reply-To: <1284573958-8397-1-git-send-email-nacc@us.ibm.com>
References: <1284573958-8397-1-git-send-email-nacc@us.ibm.com>
Cc: Milton Miller <miltonm@bga.com>, Paul Mackerras <paulus@samba.org>,
	Brian King <brking@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Release the TCE table as the XXX suggests, except on FW_FEATURE_ISERIES,
where the tables are allocated globally and reused.

Signed-off-by: Milton Miller <miltonm@bga.com>
Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
---
 arch/powerpc/kernel/vio.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/kernel/vio.c
index 72db4b0..d692989 100644
--- a/arch/powerpc/kernel/vio.c
+++ b/arch/powerpc/kernel/vio.c
@@ -1184,7 +1184,12 @@ EXPORT_SYMBOL(vio_unregister_driver);
 /* vio_dev refcount hit 0 */
 static void __devinit vio_dev_release(struct device *dev)
 {
-	/* XXX should free TCE table */
+	struct iommu_table *tbl = get_iommu_table_base(dev);
+
+	/* iSeries uses a common table for all vio devices */
+	if (!firmware_has_feature(FW_FEATURE_ISERIES) && tbl)
+		iommu_free_table(tbl, dev->of_node ?
+			dev->of_node->full_name : dev_name(dev));
 	of_node_put(dev->of_node);
 	kfree(to_vio_dev(dev));
 }
-- 
1.7.0.4
