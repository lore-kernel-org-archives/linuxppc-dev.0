Return-Path: <grant.likely@secretlab.ca>
Received: from mail-pw0-f42.google.com (mail-pw0-f42.google.com
	[209.85.160.42]) by ozlabs.org (Postfix) with ESMTP id 271DFB82E2
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Mar 2010 05:23:57 +1100 (EST)
Received: by mail-pw0-f42.google.com with SMTP id 10so179618pwi.15
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Mar 2010 10:23:57 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 23/27] drivers/infiniband/of: don't use deprecated fields in
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
Date: Thu, 11 Mar 2010 11:23:55 -0700
Message-ID: <20100311182354.13103.40771.stgit@angua>
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

 drivers/infiniband/hw/ehca/ehca_main.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_main.c b/drivers/infiniband/hw/ehca/ehca_main.c
index 2639185..252489e 100644
--- a/drivers/infiniband/hw/ehca/ehca_main.c
+++ b/drivers/infiniband/hw/ehca/ehca_main.c
@@ -937,12 +937,13 @@ static struct of_device_id ehca_device_table[] =
 MODULE_DEVICE_TABLE(of, ehca_device_table);
 
 static struct of_platform_driver ehca_driver = {
-	.name        = "ehca",
-	.match_table = ehca_device_table,
 	.probe       = ehca_probe,
 	.remove      = ehca_remove,
-	.driver	     = {
+	.driver = {
+		.name = "ehca",
+		.owner = THIS_MODULE,
 		.groups = ehca_drv_attr_groups,
+		.of_match_table = ehca_device_table,
 	},
 };
 
