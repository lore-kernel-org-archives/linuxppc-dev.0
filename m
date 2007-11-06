Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 9EC6FDDE08
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Nov 2007 17:26:39 +1100 (EST)
Date: Tue, 6 Nov 2007 17:26:42 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] iSeries: fix ref counting in vio setup.
Message-Id: <20071106172642.c794f5cd.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/platforms/iseries/vio.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/platforms/iseries/vio.c b/arch/powerpc/platforms/iseries/vio.c
index d6435b0..be06cfd 100644
--- a/arch/powerpc/platforms/iseries/vio.c
+++ b/arch/powerpc/platforms/iseries/vio.c
@@ -523,15 +523,16 @@ static void __init get_viotape_info(struct device_node *vio_root)
 static int __init iseries_vio_init(void)
 {
 	struct device_node *vio_root;
+	int ret = -ENODEV;
 
 	if (!firmware_has_feature(FW_FEATURE_ISERIES))
-		return -ENODEV;
+		goto out;
 
 	iommu_vio_init();
 
 	vio_root = of_find_node_by_path("/vdevice");
 	if (!vio_root)
-		return -ENODEV;
+		goto out;
 
 	if (viopath_hostLp == HvLpIndexInvalid) {
 		vio_set_hostlp();
@@ -544,10 +545,11 @@ static int __init iseries_vio_init(void)
 	get_viocd_info(vio_root);
 	get_viotape_info(vio_root);
 
-	return 0;
+	ret = 0;
 
  put_node:
 	of_node_put(vio_root);
-	return -ENODEV;
+ out:
+	return ret;
 }
 arch_initcall(iseries_vio_init);
-- 
1.5.3.5
