Return-Path: <wfp5p@viridian.itc.virginia.edu>
Received: from viridian.itc.virginia.edu (viridian.itc.Virginia.EDU
 [128.143.12.139]) by ozlabs.org (Postfix) with ESMTP id 548B42C008E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Nov 2012 07:59:56 +1100 (EST)
From: Bill Pemberton <wfp5p@virginia.edu>
To: linux-i2c@vger.kernel.org
Subject: [PATCH 05/16] i2c: i2c-cpm: remove __dev* attributes
Date: Tue, 27 Nov 2012 15:59:42 -0500
Message-Id: <1354049993-12718-6-git-send-email-wfp5p@virginia.edu>
In-Reply-To: <1354049993-12718-1-git-send-email-wfp5p@virginia.edu>
References: <1354049993-12718-1-git-send-email-wfp5p@virginia.edu>
Cc: gregkh@linuxfoundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

CONFIG_HOTPLUG is going away as an option.  As result the __dev*
markings will be going away.

Remove use of __devinit, __devexit_p, __devinitdata, __devinitconst,
and __devexit.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Jochen Friedrich <jochen@scram.de>
Cc: linuxppc-dev@lists.ozlabs.org
---
 drivers/i2c/busses/i2c-cpm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cpm.c b/drivers/i2c/busses/i2c-cpm.c
index c1e1096..2e79c10 100644
--- a/drivers/i2c/busses/i2c-cpm.c
+++ b/drivers/i2c/busses/i2c-cpm.c
@@ -426,7 +426,7 @@ static const struct i2c_adapter cpm_ops = {
 	.algo		= &cpm_i2c_algo,
 };
 
-static int __devinit cpm_i2c_setup(struct cpm_i2c *cpm)
+static int cpm_i2c_setup(struct cpm_i2c *cpm)
 {
 	struct platform_device *ofdev = cpm->ofdev;
 	const u32 *data;
@@ -634,7 +634,7 @@ static void cpm_i2c_shutdown(struct cpm_i2c *cpm)
 		cpm_muram_free(cpm->i2c_addr);
 }
 
-static int __devinit cpm_i2c_probe(struct platform_device *ofdev)
+static int cpm_i2c_probe(struct platform_device *ofdev)
 {
 	int result, len;
 	struct cpm_i2c *cpm;
@@ -688,7 +688,7 @@ out_free:
 	return result;
 }
 
-static int __devexit cpm_i2c_remove(struct platform_device *ofdev)
+static int cpm_i2c_remove(struct platform_device *ofdev)
 {
 	struct cpm_i2c *cpm = dev_get_drvdata(&ofdev->dev);
 
@@ -716,7 +716,7 @@ MODULE_DEVICE_TABLE(of, cpm_i2c_match);
 
 static struct platform_driver cpm_i2c_driver = {
 	.probe		= cpm_i2c_probe,
-	.remove		= __devexit_p(cpm_i2c_remove),
+	.remove		= cpm_i2c_remove,
 	.driver = {
 		.name = "fsl-i2c-cpm",
 		.owner = THIS_MODULE,
-- 
1.8.0.1
