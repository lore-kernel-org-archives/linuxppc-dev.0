Return-Path: <grant.likely@secretlab.ca>
Received: from mail-px0-f202.google.com (mail-px0-f202.google.com
	[209.85.216.202]) by ozlabs.org (Postfix) with ESMTP id 2FDFE10489A
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Mar 2010 05:22:23 +1100 (EST)
Received: by mail-px0-f202.google.com with SMTP id 40so3280pxi.9
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Mar 2010 10:22:23 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 06/27] drivers/block/of: don't use deprecated field in
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
Date: Thu, 11 Mar 2010 11:22:21 -0700
Message-ID: <20100311182220.13103.76284.stgit@angua>
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

 drivers/ata/pata_of_platform.c |    7 +++++--
 drivers/ata/sata_fsl.c         |    7 +++++--
 drivers/block/xsysace.c        |    5 ++---
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/pata_of_platform.c b/drivers/ata/pata_of_platform.c
index 19da29f..5a1b82c 100644
--- a/drivers/ata/pata_of_platform.c
+++ b/drivers/ata/pata_of_platform.c
@@ -91,8 +91,11 @@ static struct of_device_id pata_of_platform_match[] = {
 MODULE_DEVICE_TABLE(of, pata_of_platform_match);
 
 static struct of_platform_driver pata_of_platform_driver = {
-	.name		= "pata_of_platform",
-	.match_table	= pata_of_platform_match,
+	.driver = {
+		.name = "pata_of_platform",
+		.owner = THIS_MODULE,
+		.of_match_table = pata_of_platform_match,
+	},
 	.probe		= pata_of_platform_probe,
 	.remove		= __devexit_p(pata_of_platform_remove),
 };
diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index ce4136e..463fb9c 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -1426,8 +1426,11 @@ static struct of_device_id fsl_sata_match[] = {
 MODULE_DEVICE_TABLE(of, fsl_sata_match);
 
 static struct of_platform_driver fsl_sata_driver = {
-	.name		= "fsl-sata",
-	.match_table	= fsl_sata_match,
+	.driver = {
+		.name = "fsl-sata",
+		.owner = THIS_MODULE,
+		.of_match_table = fsl_sata_match,
+	},
 	.probe		= sata_fsl_probe,
 	.remove		= sata_fsl_remove,
 #ifdef CONFIG_PM
diff --git a/drivers/block/xsysace.c b/drivers/block/xsysace.c
index e1c95e2..cffcd71 100644
--- a/drivers/block/xsysace.c
+++ b/drivers/block/xsysace.c
@@ -1237,13 +1237,12 @@ static const struct of_device_id ace_of_match[] __devinitconst = {
 MODULE_DEVICE_TABLE(of, ace_of_match);
 
 static struct of_platform_driver ace_of_driver = {
-	.owner = THIS_MODULE,
-	.name = "xsysace",
-	.match_table = ace_of_match,
 	.probe = ace_of_probe,
 	.remove = __devexit_p(ace_of_remove),
 	.driver = {
 		.name = "xsysace",
+		.owner = THIS_MODULE,
+		.of_match_table = ace_of_match,
 	},
 };
 
