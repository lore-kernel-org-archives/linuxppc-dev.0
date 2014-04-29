Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0142.outbound.protection.outlook.com [207.46.163.142])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 09ADD1400E2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Apr 2014 11:31:59 +1000 (EST)
From: Scott Wood <scottwood@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/fsl-rio: Fix fsl_rio_setup error paths and
 use-after-unmap
Date: Mon, 28 Apr 2014 20:31:43 -0500
Message-ID: <1398735103-16513-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>, Liu Gang <Gang.Liu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Several of the error paths from fsl_rio_setup are missing error
messages.

Worse, fsl_rio_setup initializes several global pointers and does not
NULL them out after freeing/unmapping on error.  This caused
fsl_rio_mcheck_exception() to crash when accessing rio_regs_win which
was non-NULL but had been unmapped.

Signed-off-by: Scott Wood <scottwood@freescale.com>
Cc: Liu Gang <Gang.Liu@freescale.com>
---
Liu Gang, are you sure all of these error conditions are fatal?  Why
does the rio driver fail if rmu is not present (e.g.  on t4240)?
---
 arch/powerpc/sysdev/fsl_rio.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/fsl_rio.c b/arch/powerpc/sysdev/fsl_rio.c
index cf2b084..c04b718 100644
--- a/arch/powerpc/sysdev/fsl_rio.c
+++ b/arch/powerpc/sysdev/fsl_rio.c
@@ -391,8 +391,10 @@ int fsl_rio_setup(struct platform_device *dev)
 	ops->get_inb_message = fsl_get_inb_message;
 
 	rmu_node = of_parse_phandle(dev->dev.of_node, "fsl,srio-rmu-handle", 0);
-	if (!rmu_node)
+	if (!rmu_node) {
+		dev_err(&dev->dev, "No valid fsl,srio-rmu-handle property\n");
 		goto err_rmu;
+	}
 	rc = of_address_to_resource(rmu_node, 0, &rmu_regs);
 	if (rc) {
 		dev_err(&dev->dev, "Can't get %s property 'reg'\n",
@@ -413,6 +415,7 @@ int fsl_rio_setup(struct platform_device *dev)
 	/*set up doobell node*/
 	np = of_find_compatible_node(NULL, NULL, "fsl,srio-dbell-unit");
 	if (!np) {
+		dev_err(&dev->dev, "No fsl,srio-dbell-unit node\n");
 		rc = -ENODEV;
 		goto err_dbell;
 	}
@@ -441,6 +444,7 @@ int fsl_rio_setup(struct platform_device *dev)
 	/*set up port write node*/
 	np = of_find_compatible_node(NULL, NULL, "fsl,srio-port-write-unit");
 	if (!np) {
+		dev_err(&dev->dev, "No fsl,srio-port-write-unit node\n");
 		rc = -ENODEV;
 		goto err_pw;
 	}
@@ -633,14 +637,18 @@ int fsl_rio_setup(struct platform_device *dev)
 	return 0;
 err:
 	kfree(pw);
+	pw = NULL;
 err_pw:
 	kfree(dbell);
+	dbell = NULL;
 err_dbell:
 	iounmap(rmu_regs_win);
+	rmu_regs_win = NULL;
 err_rmu:
 	kfree(ops);
 err_ops:
 	iounmap(rio_regs_win);
+	rio_regs_win = NULL;
 err_rio_regs:
 	return rc;
 }
-- 
1.9.1
