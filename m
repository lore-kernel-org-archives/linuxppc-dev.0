Return-Path: <avorontsov@mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id CA545B6EFF
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jul 2010 04:25:08 +1000 (EST)
Date: Thu, 15 Jul 2010 22:25:07 +0400
From: Anton Vorontsov <avorontsov@mvista.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2] edac: mpc85xx: Add support for new MPCxxx/Pxxxx EDAC
	controllers
Message-ID: <20100715182507.GA3482@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Peter Tyser <ptyser@xes-inc.com>, linux-kernel@vger.kernel.org,
	Dave Jiang <djiang@mvista.com>, linuxppc-dev@ozlabs.org,
	Doug Thompson <dougthompson@xmission.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Simply add proper IDs into the device table.

Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
---

It appears that the driver has two device ID tables. :-)
So, my previous attempt enabled only half of the functionality.

Andrew,

Can you please replace

  edac-mpc85xx-add-support-for-mpc8569-edac-controllers.patch

with this patch? It also adds some more IDs for the newer chips.

Thanks!

 drivers/edac/mpc85xx_edac.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/edac/mpc85xx_edac.c b/drivers/edac/mpc85xx_edac.c
index 52ca09b..3820879 100644
--- a/drivers/edac/mpc85xx_edac.c
+++ b/drivers/edac/mpc85xx_edac.c
@@ -646,8 +646,12 @@ static struct of_device_id mpc85xx_l2_err_of_match[] = {
 	{ .compatible = "fsl,mpc8555-l2-cache-controller", },
 	{ .compatible = "fsl,mpc8560-l2-cache-controller", },
 	{ .compatible = "fsl,mpc8568-l2-cache-controller", },
+	{ .compatible = "fsl,mpc8569-l2-cache-controller", },
 	{ .compatible = "fsl,mpc8572-l2-cache-controller", },
+	{ .compatible = "fsl,p1020-l2-cache-controller", },
+	{ .compatible = "fsl,p1021-l2-cache-controller", },
 	{ .compatible = "fsl,p2020-l2-cache-controller", },
+	{ .compatible = "fsl,p4080-l2-cache-controller", },
 	{},
 };
 
@@ -1120,9 +1124,13 @@ static struct of_device_id mpc85xx_mc_err_of_match[] = {
 	{ .compatible = "fsl,mpc8555-memory-controller", },
 	{ .compatible = "fsl,mpc8560-memory-controller", },
 	{ .compatible = "fsl,mpc8568-memory-controller", },
+	{ .compatible = "fsl,mpc8569-memory-controller", },
 	{ .compatible = "fsl,mpc8572-memory-controller", },
 	{ .compatible = "fsl,mpc8349-memory-controller", },
+	{ .compatible = "fsl,p1020-memory-controller", },
+	{ .compatible = "fsl,p1021-memory-controller", },
 	{ .compatible = "fsl,p2020-memory-controller", },
+	{ .compatible = "fsl,p4080-memory-controller", },
 	{},
 };
 
-- 
1.7.0.5
