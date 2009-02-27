Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.243])
	by ozlabs.org (Postfix) with ESMTP id 40052DDDA0
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Feb 2009 17:20:23 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id d14so689914and.39
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Feb 2009 22:20:21 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] powerpc/5200: Add 'simple-bus' to the of_platform probe list.
To: linuxppc-dev@ozlabs.org
Date: Thu, 26 Feb 2009 23:20:16 -0700
Message-ID: <20090227062016.12483.57969.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

To better match the ePAPR specification, device nodes which claim
"simple-bus" compatibility should be probed by default.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/powerpc/platforms/52xx/mpc52xx_common.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)


diff --git a/arch/powerpc/platforms/52xx/mpc52xx_common.c b/arch/powerpc/platforms/52xx/mpc52xx_common.c
index 98367a0..e9d2cf6 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_common.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_common.c
@@ -28,9 +28,10 @@ static struct of_device_id mpc52xx_xlb_ids[] __initdata = {
 static struct of_device_id mpc52xx_bus_ids[] __initdata = {
 	{ .compatible = "fsl,mpc5200-immr", },
 	{ .compatible = "fsl,mpc5200b-immr", },
-	{ .compatible = "fsl,lpb", },
+	{ .compatible = "simple-bus", },
 
 	/* depreciated matches; shouldn't be used in new device trees */
+	{ .compatible = "fsl,lpb", },
 	{ .type = "builtin", .compatible = "mpc5200", }, /* efika */
 	{ .type = "soc", .compatible = "mpc5200", }, /* lite5200 */
 	{}
