Return-Path: <avorontsov@mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id B7364100A45
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jul 2010 04:40:47 +1000 (EST)
Date: Thu, 15 Jul 2010 22:40:45 +0400
From: Anton Vorontsov <avorontsov@mvista.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] edac: mpc85xx: Fix coldplug/hotplug module autoloading
Message-ID: <20100715184045.GA10275@oksana.dev.rtsoft.ru>
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

MPC85xx EDAC driver is missing module device aliases, so the driver
won't load automatically on boot. This patch fixes the issue by
adding proper MODULE_DEVICE_TABLE() macros.

Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
---
 drivers/edac/mpc85xx_edac.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/edac/mpc85xx_edac.c b/drivers/edac/mpc85xx_edac.c
index 3820879..cfa86f7 100644
--- a/drivers/edac/mpc85xx_edac.c
+++ b/drivers/edac/mpc85xx_edac.c
@@ -336,6 +336,7 @@ static struct of_device_id mpc85xx_pci_err_of_match[] = {
 	},
 	{},
 };
+MODULE_DEVICE_TABLE(of, mpc85xx_pci_err_of_match);
 
 static struct of_platform_driver mpc85xx_pci_err_driver = {
 	.probe = mpc85xx_pci_err_probe,
@@ -654,6 +655,7 @@ static struct of_device_id mpc85xx_l2_err_of_match[] = {
 	{ .compatible = "fsl,p4080-l2-cache-controller", },
 	{},
 };
+MODULE_DEVICE_TABLE(of, mpc85xx_l2_err_of_match);
 
 static struct of_platform_driver mpc85xx_l2_err_driver = {
 	.probe = mpc85xx_l2_err_probe,
@@ -1133,6 +1135,7 @@ static struct of_device_id mpc85xx_mc_err_of_match[] = {
 	{ .compatible = "fsl,p4080-memory-controller", },
 	{},
 };
+MODULE_DEVICE_TABLE(of, mpc85xx_mc_err_of_match);
 
 static struct of_platform_driver mpc85xx_mc_err_driver = {
 	.probe = mpc85xx_mc_err_probe,
-- 
1.7.0.5
