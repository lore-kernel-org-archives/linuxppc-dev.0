Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 7B4EB679FB
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 17:22:03 +1000 (EST)
Date: Thu, 18 May 2006 17:21:26 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] powerpc: the iSeries vio lan driver changed device type
Message-Id: <20060518172126.01b9d977.sfr@canb.auug.org.au>
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

So the IOMMU table building code needs to match.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---

 arch/powerpc/kernel/vio.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

This patch is relative to the four iSeries vio patches I sent on Moday.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

af5dbd2219106b6ce52b075485fca3c2a08cec58
diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/kernel/vio.c
index ac5c7bf..b559cbd 100644
--- a/arch/powerpc/kernel/vio.c
+++ b/arch/powerpc/kernel/vio.c
@@ -71,7 +71,7 @@ static struct iommu_table *vio_build_iom
 {
 #ifdef CONFIG_PPC_ISERIES
 	if (firmware_has_feature(FW_FEATURE_ISERIES)) {
-		if (strcmp(dev->type, "vlan") == 0)
+		if (strcmp(dev->type, "network") == 0)
 			return &veth_iommu_table;
 		return &vio_iommu_table;
 	} else
-- 
1.3.1.ge923
