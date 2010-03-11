Return-Path: <grant.likely@secretlab.ca>
Received: from mail-pv0-f170.google.com (mail-pv0-f170.google.com
	[74.125.83.170]) by ozlabs.org (Postfix) with ESMTP id 91379B83D8
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Mar 2010 05:22:41 +1100 (EST)
Received: by pvg11 with SMTP id 11so131458pvg.15
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Mar 2010 10:22:40 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 08/27] drivers/crypto/of: don't use deprecated field in
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
Date: Thu, 11 Mar 2010 11:22:32 -0700
Message-ID: <20100311182231.13103.47091.stgit@angua>
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

 drivers/crypto/amcc/crypto4xx_core.c |    7 +++++--
 drivers/crypto/talitos.c             |    7 +++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/amcc/crypto4xx_core.c b/drivers/crypto/amcc/crypto4xx_core.c
index 1c3849f..36b5fb1 100644
--- a/drivers/crypto/amcc/crypto4xx_core.c
+++ b/drivers/crypto/amcc/crypto4xx_core.c
@@ -1280,8 +1280,11 @@ static const struct of_device_id crypto4xx_match[] = {
 };
 
 static struct of_platform_driver crypto4xx_driver = {
-	.name		= "crypto4xx",
-	.match_table	= crypto4xx_match,
+	.driver = {
+		.name = "crypto4xx",
+		.owner = THIS_MODULE,
+		.of_match_table = crypto4xx_match,
+	},
 	.probe		= crypto4xx_probe,
 	.remove		= crypto4xx_remove,
 };
diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
index fd529d6..917faf7 100644
--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -1967,8 +1967,11 @@ static const struct of_device_id talitos_match[] = {
 MODULE_DEVICE_TABLE(of, talitos_match);
 
 static struct of_platform_driver talitos_driver = {
-	.name = "talitos",
-	.match_table = talitos_match,
+	.driver = {
+		.name = "talitos",
+		.owner = THIS_MODULE,
+		.of_match_table = talitos_match,
+	},
 	.probe = talitos_probe,
 	.remove = talitos_remove,
 };
