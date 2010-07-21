Return-Path: <brad@bradleyehughes.com>
Received: from mail-yw0-f42.google.com (mail-yw0-f42.google.com
	[209.85.213.42]) by ozlabs.org (Postfix) with ESMTP id 9AB95100A2F
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jul 2010 08:04:34 +1000 (EST)
Received: by ywi6 with SMTP id 6so904482ywi.15
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jul 2010 15:04:32 -0700 (PDT)
MIME-Version: 1.0
Sender: brad@bradleyehughes.com
From: Bradley Hughes <bhughes@silicontkx.com>
Date: Wed, 21 Jul 2010 18:04:10 -0400
Message-ID: <AANLkTinRf_s2gC_O3D_Fh7qJjPEMltMxIaDfin-rOV5m@mail.gmail.com>
Subject: [PATCH v2 2/2] EDAC: Remove deprecated bindings for MPC85xx
To: Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The "fsl,85..." style bindings for the l2-cache-controller
and memory-controller were intended to be deprected as of 2.6.30
per comment in drivers/edac/mpc85xx_edac.c.  Previous patch in this
series updates all DTS to use the "fsl,mpc85..." style binding
for these two nodes, allowing us to finally deprecate said
notation.

Signed-off-by: Bradley Hughes <bhughes@silicontkx.com>
---
 drivers/edac/mpc85xx_edac.c |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/drivers/edac/mpc85xx_edac.c b/drivers/edac/mpc85xx_edac.c
index 52ca09b..50b319e 100644
--- a/drivers/edac/mpc85xx_edac.c
+++ b/drivers/edac/mpc85xx_edac.c
@@ -631,13 +631,6 @@ static int mpc85xx_l2_err_remove(struct of_device *op)
 }

 static struct of_device_id mpc85xx_l2_err_of_match[] = {
-/* deprecate the fsl,85.. forms in the future, 2.6.30? */
-	{ .compatible = "fsl,8540-l2-cache-controller", },
-	{ .compatible = "fsl,8541-l2-cache-controller", },
-	{ .compatible = "fsl,8544-l2-cache-controller", },
-	{ .compatible = "fsl,8548-l2-cache-controller", },
-	{ .compatible = "fsl,8555-l2-cache-controller", },
-	{ .compatible = "fsl,8568-l2-cache-controller", },
 	{ .compatible = "fsl,mpc8536-l2-cache-controller", },
 	{ .compatible = "fsl,mpc8540-l2-cache-controller", },
 	{ .compatible = "fsl,mpc8541-l2-cache-controller", },
-- 
1.7.0.4
