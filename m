Return-Path: <grant.likely@secretlab.ca>
Received: from mail-pz0-f201.google.com (mail-pz0-f201.google.com
	[209.85.222.201]) by ozlabs.org (Postfix) with ESMTP id 79D70100870
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Mar 2010 05:23:19 +1100 (EST)
Received: by mail-pz0-f201.google.com with SMTP id 39so178248pzk.15
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Mar 2010 10:23:19 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 16/27] drivers/scsi/of: don't use deprecated field in
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
Date: Thu, 11 Mar 2010 11:23:16 -0700
Message-ID: <20100311182316.13103.87138.stgit@angua>
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

 drivers/scsi/qlogicpti.c |    7 +++++--
 drivers/scsi/sun_esp.c   |    7 +++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/qlogicpti.c b/drivers/scsi/qlogicpti.c
index 7374fbe..16dc12e 100644
--- a/drivers/scsi/qlogicpti.c
+++ b/drivers/scsi/qlogicpti.c
@@ -1456,8 +1456,11 @@ static const struct of_device_id qpti_match[] = {
 MODULE_DEVICE_TABLE(of, qpti_match);
 
 static struct of_platform_driver qpti_sbus_driver = {
-	.name		= "qpti",
-	.match_table	= qpti_match,
+	.driver = {
+		.name = "qpti",
+		.owner = THIS_MODULE,
+		.of_match_table = qpti_match,
+	},
 	.probe		= qpti_sbus_probe,
 	.remove		= __devexit_p(qpti_sbus_remove),
 };
diff --git a/drivers/scsi/sun_esp.c b/drivers/scsi/sun_esp.c
index 4369b76..10ba30a 100644
--- a/drivers/scsi/sun_esp.c
+++ b/drivers/scsi/sun_esp.c
@@ -632,8 +632,11 @@ static const struct of_device_id esp_match[] = {
 MODULE_DEVICE_TABLE(of, esp_match);
 
 static struct of_platform_driver esp_sbus_driver = {
-	.name		= "esp",
-	.match_table	= esp_match,
+	.driver = {
+		.name = "esp",
+		.owner = THIS_MODULE,
+		.of_match_table = esp_match,
+	},
 	.probe		= esp_sbus_probe,
 	.remove		= __devexit_p(esp_sbus_remove),
 };
