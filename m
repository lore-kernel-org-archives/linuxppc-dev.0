Return-Path: <grant.likely@secretlab.ca>
Received: from mail-px0-f202.google.com (mail-px0-f202.google.com
	[209.85.216.202]) by ozlabs.org (Postfix) with ESMTP id 207441052D0
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Mar 2010 05:23:30 +1100 (EST)
Received: by pxi40 with SMTP id 40so3970pxi.9
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Mar 2010 10:23:30 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 18/27] drivers/parport/of: don't use deprecated field in
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
Date: Thu, 11 Mar 2010 11:23:27 -0700
Message-ID: <20100311182327.13103.91141.stgit@angua>
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

 drivers/parport/parport_sunbpp.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/parport/parport_sunbpp.c b/drivers/parport/parport_sunbpp.c
index 065f229..9a5b4b8 100644
--- a/drivers/parport/parport_sunbpp.c
+++ b/drivers/parport/parport_sunbpp.c
@@ -382,8 +382,11 @@ static const struct of_device_id bpp_match[] = {
 MODULE_DEVICE_TABLE(of, bpp_match);
 
 static struct of_platform_driver bpp_sbus_driver = {
-	.name		= "bpp",
-	.match_table	= bpp_match,
+	.driver = {
+		.name = "bpp",
+		.owner = THIS_MODULE,
+		.of_match_table = bpp_match,
+	},
 	.probe		= bpp_probe,
 	.remove		= __devexit_p(bpp_remove),
 };
