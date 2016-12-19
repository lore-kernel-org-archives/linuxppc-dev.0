Return-Path: <madalin.bucur@nxp.com>
Received: from NAM01-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam01on0080.outbound.protection.outlook.com [104.47.34.80])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tjCY04mHLzDxRl
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 07:43:00 +1100 (AEDT)
From: Madalin Bucur <madalin.bucur@nxp.com>
To: <netdev@vger.kernel.org>
CC: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <davem@davemloft.net>, <scott.wood@nxp.com>, <mpe@ellerman.id.au>
Subject: [PATCH net v4 2/4] powerpc: fsl/fman: remove fsl,
 fman from of_device_ids[]
Date: Mon, 19 Dec 2016 22:42:44 +0200
Message-ID: <1482180166-10677-3-git-send-email-madalin.bucur@nxp.com>
In-Reply-To: <1482180166-10677-1-git-send-email-madalin.bucur@nxp.com>
References: <1482180166-10677-1-git-send-email-madalin.bucur@nxp.com>
Reply-To: <madalin.bucur@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The fsl/fman drivers will use of_platform_populate() on all
supported platforms. Call of_platform_populate() to probe the
FMan sub-nodes.

Signed-off-by: Igal Liberman <igal.liberman@freescale.com>
Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
Acked-by: Scott Wood <oss@buserror.net>
---
 arch/powerpc/platforms/85xx/corenet_generic.c | 3 ---
 drivers/net/ethernet/freescale/fman/fman.c    | 7 +++++++
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc/platforms/85xx/corenet_generic.c
index 1179115..824b7f1 100644
--- a/arch/powerpc/platforms/85xx/corenet_generic.c
+++ b/arch/powerpc/platforms/85xx/corenet_generic.c
@@ -117,9 +117,6 @@ static const struct of_device_id of_device_ids[] = {
 	{
 		.compatible	= "fsl,qe",
 	},
-	{
-		.compatible    = "fsl,fman",
-	},
 	/* The following two are for the Freescale hypervisor */
 	{
 		.name		= "hypervisor",
diff --git a/drivers/net/ethernet/freescale/fman/fman.c b/drivers/net/ethernet/freescale/fman/fman.c
index dafd9e1..4b83263 100644
--- a/drivers/net/ethernet/freescale/fman/fman.c
+++ b/drivers/net/ethernet/freescale/fman/fman.c
@@ -2868,6 +2868,13 @@ static struct fman *read_dts_node(struct platform_device *of_dev)
 
 	fman->dev = &of_dev->dev;
 
+	err = of_platform_populate(fm_node, NULL, NULL, &of_dev->dev);
+	if (err) {
+		dev_err(&of_dev->dev, "%s: of_platform_populate() failed\n",
+			__func__);
+		goto fman_free;
+	}
+
 	return fman;
 
 fman_node_put:
-- 
2.1.0
