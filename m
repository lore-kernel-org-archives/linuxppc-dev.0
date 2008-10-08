Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7D1B6DDF03
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Oct 2008 23:22:23 +1100 (EST)
Date: Wed, 8 Oct 2008 07:22:18 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: norsk5@yahoo.com
Subject: [PATCH] edac: mpc85xx: Add support for new compatible types, mpc8536
	and mpc8560
Message-ID: <Pine.LNX.4.64.0810080721120.4673@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, bluesmoke-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

All other compatibles that are uniquely identifying the processor use
a prefix of the form fsl,mpc85...'.  We add support for it so we
can deprecate the older 'fsl,85...' that was inproperly used here.

Additionally added mpc8536 & mpc8560 to the compatible lists.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---

This patch is based on Nate's 8572 patch.

 drivers/edac/mpc85xx_edac.c |   74 ++++++++++++++++++------------------------
 1 files changed, 32 insertions(+), 42 deletions(-)

diff --git a/drivers/edac/mpc85xx_edac.c b/drivers/edac/mpc85xx_edac.c
index 63bdc47..184799a 100644
--- a/drivers/edac/mpc85xx_edac.c
+++ b/drivers/edac/mpc85xx_edac.c
@@ -630,27 +630,22 @@ static int mpc85xx_l2_err_remove(struct of_device *op)
 }

 static struct of_device_id mpc85xx_l2_err_of_match[] = {
-	{
-	 .compatible = "fsl,8540-l2-cache-controller",
-	 },
-	{
-	 .compatible = "fsl,8541-l2-cache-controller",
-	 },
-	{
-	 .compatible = "fsl,8544-l2-cache-controller",
-	 },
-	{
-	 .compatible = "fsl,8548-l2-cache-controller",
-	 },
-	{
-	 .compatible = "fsl,8555-l2-cache-controller",
-	 },
-	{
-	 .compatible = "fsl,8568-l2-cache-controller",
-	 },
-	{
-	 .compatible = "fsl,mpc8572-l2-cache-controller",
-	 },
+/* deprecate the fsl,85.. forms in the future, 2.6.30? */
+	{ .compatible = "fsl,8540-l2-cache-controller", },
+	{ .compatible = "fsl,8541-l2-cache-controller", },
+	{ .compatible = "fsl,8544-l2-cache-controller", },
+	{ .compatible = "fsl,8548-l2-cache-controller", },
+	{ .compatible = "fsl,8555-l2-cache-controller", },
+	{ .compatible = "fsl,8568-l2-cache-controller", },
+	{ .compatible = "fsl,mpc8536-l2-cache-controller", },
+	{ .compatible = "fsl,mpc8540-l2-cache-controller", },
+	{ .compatible = "fsl,mpc8541-l2-cache-controller", },
+	{ .compatible = "fsl,mpc8544-l2-cache-controller", },
+	{ .compatible = "fsl,mpc8548-l2-cache-controller", },
+	{ .compatible = "fsl,mpc8555-l2-cache-controller", },
+	{ .compatible = "fsl,mpc8560-l2-cache-controller", },
+	{ .compatible = "fsl,mpc8568-l2-cache-controller", },
+	{ .compatible = "fsl,mpc8572-l2-cache-controller", },
 	{},
 };

@@ -967,27 +962,22 @@ static int mpc85xx_mc_err_remove(struct of_device *op)
 }

 static struct of_device_id mpc85xx_mc_err_of_match[] = {
-	{
-	 .compatible = "fsl,8540-memory-controller",
-	 },
-	{
-	 .compatible = "fsl,8541-memory-controller",
-	 },
-	{
-	 .compatible = "fsl,8544-memory-controller",
-	 },
-	{
-	 .compatible = "fsl,8548-memory-controller",
-	 },
-	{
-	 .compatible = "fsl,8555-memory-controller",
-	 },
-	{
-	 .compatible = "fsl,8568-memory-controller",
-	 },
-	{
-	 .compatible = "fsl,mpc8572-memory-controller",
-	 },
+/* deprecate the fsl,85.. forms in the future, 2.6.30? */
+	{ .compatible = "fsl,8540-memory-controller", },
+	{ .compatible = "fsl,8541-memory-controller", },
+	{ .compatible = "fsl,8544-memory-controller", },
+	{ .compatible = "fsl,8548-memory-controller", },
+	{ .compatible = "fsl,8555-memory-controller", },
+	{ .compatible = "fsl,8568-memory-controller", },
+	{ .compatible = "fsl,mpc8536-memory-controller", },
+	{ .compatible = "fsl,mpc8540-memory-controller", },
+	{ .compatible = "fsl,mpc8541-memory-controller", },
+	{ .compatible = "fsl,mpc8544-memory-controller", },
+	{ .compatible = "fsl,mpc8548-memory-controller", },
+	{ .compatible = "fsl,mpc8555-memory-controller", },
+	{ .compatible = "fsl,mpc8560-memory-controller", },
+	{ .compatible = "fsl,mpc8568-memory-controller", },
+	{ .compatible = "fsl,mpc8572-memory-controller", },
 	{},
 };

-- 
1.5.5.1
