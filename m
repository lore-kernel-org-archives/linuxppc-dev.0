Return-Path: <grant.likely@secretlab.ca>
Received: from mail-pv0-f170.google.com (mail-pv0-f170.google.com
	[74.125.83.170]) by ozlabs.org (Postfix) with ESMTP id 176F4101AC0
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Mar 2010 05:23:52 +1100 (EST)
Received: by pvg11 with SMTP id 11so131850pvg.15
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Mar 2010 10:23:52 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 22/27] drivers/i2c/of: don't use deprecated field in
	of_platform_driver
To: monstr@monstr.eu, gregkh@suse.de, benh@kernel.crashing.org,
	akpm@linux-foundation.org, davem@davemloft.net,
	sfr@canb.auug.org.au, jgarzik@pobox.com, ben-linux@fluff.org,
	dwmw2@infradead.org, jeremy.kerr@canonical.com,
	James.Bottomley@suse.de, broonie@opensource.wolfsonmicro.com,
	microblaze-uclinux@itee.uq.edu.au, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, sparclinux@vger.kernel.org,
	linux-ide@vger.kernel.org, netdev@vger.kernel.org,
	linux-i2c@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	linux-scsi@vger.kernel.org, alsa-devel@alsa-project.org
Date: Thu, 11 Mar 2010 11:23:49 -0700
Message-ID: <20100311182349.13103.39322.stgit@angua>
In-Reply-To: <20100311181604.13103.30088.stgit@angua>
References: <20100311181604.13103.30088.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

.name, .match_table and .owner are duplicated in both of_platform_driver
and device_driver, so the of_platform_driver copies will be removed soon.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 drivers/i2c/busses/i2c-cpm.c     |   10 +++++-----
 drivers/i2c/busses/i2c-ibm_iic.c |    7 +++++--
 drivers/i2c/busses/i2c-mpc.c     |    8 ++++----
 3 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cpm.c b/drivers/i2c/busses/i2c-cpm.c
index 9c2e100..47994d2 100644
--- a/drivers/i2c/busses/i2c-cpm.c
+++ b/drivers/i2c/busses/i2c-cpm.c
@@ -718,13 +718,13 @@ static const struct of_device_id cpm_i2c_match[] = {
 MODULE_DEVICE_TABLE(of, cpm_i2c_match);
 
 static struct of_platform_driver cpm_i2c_driver = {
-	.match_table	= cpm_i2c_match,
 	.probe		= cpm_i2c_probe,
 	.remove		= __devexit_p(cpm_i2c_remove),
-	.driver		= {
-		.name	= "fsl-i2c-cpm",
-		.owner	= THIS_MODULE,
-	}
+	.driver = {
+		.name = "fsl-i2c-cpm",
+		.owner = THIS_MODULE,
+		.of_match_table = cpm_i2c_match,
+	},
 };
 
 static int __init cpm_i2c_init(void)
diff --git a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
index b1bc6e2..21dba9d 100644
--- a/drivers/i2c/busses/i2c-ibm_iic.c
+++ b/drivers/i2c/busses/i2c-ibm_iic.c
@@ -807,8 +807,11 @@ static const struct of_device_id ibm_iic_match[] = {
 };
 
 static struct of_platform_driver ibm_iic_driver = {
-	.name	= "ibm-iic",
-	.match_table = ibm_iic_match,
+	.driver = {
+		.name = "ibm-iic",
+		.owner = THIS_MODULE,
+		.of_match_table = ibm_iic_match,
+	},
 	.probe	= iic_probe,
 	.remove	= __devexit_p(iic_remove),
 };
diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index 0123a6e..6063dc3 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -674,12 +674,12 @@ MODULE_DEVICE_TABLE(of, mpc_i2c_of_match);
 
 /* Structure for a device driver */
 static struct of_platform_driver mpc_i2c_driver = {
-	.match_table	= mpc_i2c_of_match,
 	.probe		= fsl_i2c_probe,
 	.remove		= __devexit_p(fsl_i2c_remove),
-	.driver		= {
-		.owner	= THIS_MODULE,
-		.name	= DRV_NAME,
+	.driver = {
+		.owner = THIS_MODULE,
+		.name = DRV_NAME,
+		.of_match_table = mpc_i2c_of_match,
 	},
 };
 
