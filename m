Return-Path: <B25806@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 26A37B6F7B
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Aug 2011 19:23:32 +1000 (EST)
From: Chunhe Lan <Chunhe.Lan@freescale.com>
To: <linux-mtd@lists.infradead.org>
Subject: [PATCH] mtd/physmap_of: Don't add disabled flash devices
Date: Tue, 16 Aug 2011 17:25:50 +0800
Message-ID: <1313486750-15211-1-git-send-email-Chunhe.Lan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: kumar.gala@freescale.com, linuxppc-dev@ozlabs.org, scottwood@freescale.com,
	akpm@linux-foundation.org, dwmw2@infradead.org,
	Chunhe Lan <Chunhe.Lan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Flash(cfi-flash, jedec-flash, and so on) nodes with the
property status="disabled" are not usable and so avoid
adding "disabled" flash devices with the system.

Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
---
 drivers/mtd/maps/physmap_of.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/mtd/maps/physmap_of.c b/drivers/mtd/maps/physmap_of.c
index d251d1d..812e6dc 100644
--- a/drivers/mtd/maps/physmap_of.c
+++ b/drivers/mtd/maps/physmap_of.c
@@ -219,6 +219,9 @@ static int __devinit of_flash_probe(struct platform_device *dev)
 	struct mtd_info **mtd_list = NULL;
 	resource_size_t res_size;
 
+	if (!of_device_is_available(dp))
+		return -ENODEV;
+
 	match = of_match_device(of_flash_match, &dev->dev);
 	if (!match)
 		return -EINVAL;
-- 
1.5.6.5
