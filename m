Return-Path: <grant.likely@secretlab.ca>
Received: from mail-px0-f202.google.com (mail-px0-f202.google.com
	[209.85.216.202]) by ozlabs.org (Postfix) with ESMTP id 87366B8BC1
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Mar 2010 05:22:09 +1100 (EST)
Received: by pxi40 with SMTP id 40so3280pxi.9
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Mar 2010 10:22:08 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 03/27] drivers/watchdog/of: don't use deprecated .name and
	.owner in of_platform_driver
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
Date: Thu, 11 Mar 2010 11:22:04 -0700
Message-ID: <20100311182204.13103.79395.stgit@angua>
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

 drivers/watchdog/cpwd.c        |    7 +++++--
 drivers/watchdog/gef_wdt.c     |    8 +++++---
 drivers/watchdog/mpc8xxx_wdt.c |    8 ++++----
 drivers/watchdog/riowd.c       |    7 +++++--
 4 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/watchdog/cpwd.c b/drivers/watchdog/cpwd.c
index 89da14f..4215b5d 100644
--- a/drivers/watchdog/cpwd.c
+++ b/drivers/watchdog/cpwd.c
@@ -676,8 +676,11 @@ static const struct of_device_id cpwd_match[] = {
 MODULE_DEVICE_TABLE(of, cpwd_match);
 
 static struct of_platform_driver cpwd_driver = {
-	.name		= DRIVER_NAME,
-	.match_table	= cpwd_match,
+	.driver = {
+		.name = DRIVER_NAME,
+		.owner = THIS_MODULE,
+		.of_match_table = cpwd_match,
+	},
 	.probe		= cpwd_probe,
 	.remove		= __devexit_p(cpwd_remove),
 };
diff --git a/drivers/watchdog/gef_wdt.c b/drivers/watchdog/gef_wdt.c
index abdbad0..ca0f4c6 100644
--- a/drivers/watchdog/gef_wdt.c
+++ b/drivers/watchdog/gef_wdt.c
@@ -303,9 +303,11 @@ static const struct of_device_id gef_wdt_ids[] = {
 };
 
 static struct of_platform_driver gef_wdt_driver = {
-	.owner		= THIS_MODULE,
-	.name		= "gef_wdt",
-	.match_table	= gef_wdt_ids,
+	.driver = {
+		.name = "gef_wdt",
+		.owner = THIS_MODULE,
+		.of_match_table = gef_wdt_ids,
+	},
 	.probe		= gef_wdt_probe,
 };
 
diff --git a/drivers/watchdog/mpc8xxx_wdt.c b/drivers/watchdog/mpc8xxx_wdt.c
index 4e3941c..7b55974 100644
--- a/drivers/watchdog/mpc8xxx_wdt.c
+++ b/drivers/watchdog/mpc8xxx_wdt.c
@@ -273,12 +273,12 @@ static const struct of_device_id mpc8xxx_wdt_match[] = {
 MODULE_DEVICE_TABLE(of, mpc8xxx_wdt_match);
 
 static struct of_platform_driver mpc8xxx_wdt_driver = {
-	.match_table	= mpc8xxx_wdt_match,
 	.probe		= mpc8xxx_wdt_probe,
 	.remove		= __devexit_p(mpc8xxx_wdt_remove),
-	.driver		= {
-		.name	= "mpc8xxx_wdt",
-		.owner	= THIS_MODULE,
+	.driver = {
+		.name = "mpc8xxx_wdt",
+		.owner = THIS_MODULE,
+		.of_match_table = mpc8xxx_wdt_match,
 	},
 };
 
diff --git a/drivers/watchdog/riowd.c b/drivers/watchdog/riowd.c
index ae57bf9..e7973bf 100644
--- a/drivers/watchdog/riowd.c
+++ b/drivers/watchdog/riowd.c
@@ -238,8 +238,11 @@ static const struct of_device_id riowd_match[] = {
 MODULE_DEVICE_TABLE(of, riowd_match);
 
 static struct of_platform_driver riowd_driver = {
-	.name		= DRIVER_NAME,
-	.match_table	= riowd_match,
+	.driver = {
+		.name = DRIVER_NAME,
+		.owner = THIS_MODULE,
+		.of_match_table = riowd_match,
+	},
 	.probe		= riowd_probe,
 	.remove		= __devexit_p(riowd_remove),
 };
