Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CE3606A330
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2026 21:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20260707.gappssmtp.com header.i=@thegoodpenguin-co-uk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=tizt1p6X
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZY763dxmz3bjb;
	Thu, 26 Nov 2026 08:42:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::329"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795624142;
	cv=none; b=Y0u4N3XUETlYzC6HFU9GijU/CvWufGFJ0o+OcWzc9v1TejLq50VNgjjT+Hdr0dGXXK6FCO+yFDngy8fgrt6JMKJt2f6OZt6RSDytK9havqOTalclraHTO3EehOCnEwhpj+Pqn+nhvgNquOOvdoDzWwsY+lI7OSgoHd3la+51jnXE4dJTfpbnMehhNIGoPHJmtrKl2n+uKZg9zZZux3hp7d4jBvLFerErMKabt6tfPt8ebbnuAB8W2FgY2/R4STcJ9EkdfxJxVlF1q+ZqJFxU0m46ffghmxvksVUA9VqYEI8KiC8c2ZAxSUN5hisgBNNUMCbWwCY0BUVYpHz/Aw2sEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795624142; c=relaxed/relaxed;
	bh=usivc3aw+SwZhFpcmlLANBBx5LV9rhkWEtYn4/TGjV4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lf44yiKKgjWbT+0XHVs7195Q87Rnf5WuplFgaI3o6wo99v0cUhLlohZti/i5gdt1NbicK/NLZ9I1TFt5RQ918rWrTrufkkDPFmDVOctzXz/qMVcfgfqkQedbLXHFeMah3eMlaNF8EhFExarwFX4qDF3/ZPOMQTw3Ym6GmQCUZzyIR38ACsarGgiA97h8qpixhBCegTfoKmYPren6gFa/AERANWLTSynLzL3tKMIa1ouBNSFvRLB3nmSR7ZQImwOr3zOPIZNLvkHoyr2zbF5byATmKipT8VHD5l2ayH/rP1n0ZpgFNABoFhUmScIL9CFVDXxo/hMreLUvB8jjHljBGw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; dkim=pass (2048-bit key; unprotected) header.d=thegoodpenguin-co-uk.20260707.gappssmtp.com header.i=@thegoodpenguin-co-uk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=tizt1p6X; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com; envelope-from=pzalewski@thegoodpenguin.co.uk; receiver=lists.ozlabs.org) smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=thegoodpenguin-co-uk.20260707.gappssmtp.com header.i=@thegoodpenguin-co-uk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=tizt1p6X;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=thegoodpenguin.co.uk (client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com; envelope-from=pzalewski@thegoodpenguin.co.uk; receiver=lists.ozlabs.org)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZQ9T1fbtz2xLg
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 03:29:01 +1100 (AEDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4bb64ef5a00so48210525e9.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2026 08:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20260707.gappssmtp.com; s=20260707; t=1795624138; x=1796228938; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=usivc3aw+SwZhFpcmlLANBBx5LV9rhkWEtYn4/TGjV4=;
        b=tizt1p6XvsyKptvijTUVck3LUFKFvZHEBuDc/fI/7qQyKSu4t2HoefofBqDeHuNy2+
         ttwLsp2EhHVfHB88s80i7k0SadNHxEONSqSgKzzii9SS96EB6vU6SA640SGUqo59zFZp
         DoHo8V8VmkN7yspTW6G5WWoL6VMi1wAm1PCtwz+cfPTqzUaZgchyn0yvivz1vydNtEIc
         fy+lc8GwCeZlgkVIfE7+B/Y2HV0wwukq4XNFQ3sUkh9YEc9BVkaknJffjG+vjuT3tK8z
         p4/fKtrOzz9Sts76q93YWIB9p3CNLEPUYz4StQuUAA+dw6TCtX0xXmRfbb9jbt3eboi/
         dIYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795624138; x=1796228938;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=usivc3aw+SwZhFpcmlLANBBx5LV9rhkWEtYn4/TGjV4=;
        b=y5gw0Ww3RwkfdXhCnTJDK5++dNYYfDEzhq+1rQbnIJshz2IRe4LF8uIvXdrXXO6yEA
         WZ5LdlGgn+mPx0kJi7ZrV6IvjxG9M3q5eiGkUynec9OgfLywUICEbN7nm4tPCrkxlmen
         NpFKgu2nukuxKUPpxGDrn/tcuZ4oy1sAjXHIxlVMKKn7UWoruirmcb8Y/G9y4sy8NtL6
         pACvWnda0ouu1PD9/e3tgYHWTqr78sb4Rz2wNCWM/GlWpeWowxOzEumJly9AanSUAJpc
         +DCsre7ZN0bZqX8i/ftwLwCLQP/KpYVTZ1S+v20cqvBz9eb+GPDBru5qYkTERvHNntmq
         3Tcw==
X-Forwarded-Encrypted: i=1; AL+hErHCXYsExmZcHnAwYXD545UHsehjAno5xw4oaI7DGBUxEHqsjNR9q9Euvav2kVccqFBfKw9S4jP8Gs/vaiA=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+5kpu47Vj7mcfFzFLNrmQhlOEPPac6IyOqFf4h0/anIYk2hAdC
	s8f8NEMu3dJIyxXWs2p81iHtKHpN36b1ljyeFSfSV4f+O+M2jkbeoZaNPVAAoggykMU=
X-Gm-Gg: AZFdTZfJHCJAzozCdgPP/JjizybZ9BziJG/BugO85l5YTRvWMnKHp0fhq8RJo1MC19/
	Cv14DY6c9RYPWFNIRf+o45xPvWp8CXi+0GrEM+mon4iJuXWHNCTRhcTIOZvLEhBqQ1o12tefzck
	FjJ6GXHLKRblu+YUB9tZB4cJGxYElQkG1fbeQLZXF0EkpLCMle8AeMDK6aN4PV0lDlbJWX4e/2o
	a2eUz9wsnwq1w/PrPvCS+0jw6VzZtz+QZS1pP9o7ssuNCekeiCzxJUhRAtGFySpw93vhnc1bWIg
	uXEGnqELj3G0PYPDxAm39TukC7++ForqIUPPruXFbdYMyyFSN43NZMnkACatq+H69HonOq/kekG
	Zvi+P13E84L/P2YPcXhu1/f5la+0jyw2wLopUi2PZKnwlo3Nn0np+qVABITvu6tabG32eXAtCRr
	MI5JRH89kY9CD7B9ODCaAduTAo2hDEHJ2xnYZYaHqFgE9SWbeMiIEsPnoGG939j4Am8JwGE1z91
	CoIboairyabRIv/1H3CPVIIKzMJsSuQ+NiJe/z/k/bwIEMJjwvgA+y2/B+q38+UrfFjN9RkK52l
	yN76NbcH7VrVN31aG8BtVA4x5Y9xzj7/Apr/YTwEPFTEGA==
X-Received: by 2002:a05:600c:6708:b0:4ba:7e6:53d6 with SMTP id 5b1f17b1804b1-4bb88940848mr326163005e9.33.1795624138113;
        Wed, 25 Nov 2026 08:28:58 -0800 (PST)
Received: from [10.42.0.1] ([2a00:23c7:1d1a:9c01:f716:ba19:8aaa:f1c2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853368d3sm527336375e9.1.2026.11.25.08.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 08:28:57 -0800 (PST)
From: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
Date: Wed, 25 Nov 2026 16:28:35 +0000
Subject: [PATCH 09/10] mtd: nand: Unify list terminator for *_device_id
 lists
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-acpi-mtd-v1-9-42ad2f645bee@thegoodpenguin.co.uk>
References: <20261125-acpi-mtd-v1-0-42ad2f645bee@thegoodpenguin.co.uk>
In-Reply-To: <20261125-acpi-mtd-v1-0-42ad2f645bee@thegoodpenguin.co.uk>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Takahiro Kuwano <takahiro.kuwano@infineon.com>, 
 Vladimir Zapolskiy <vz@mleia.com>, Robert Jarzmik <robert.jarzmik@free.fr>, 
 Alexander Usyskin <alexander.usyskin@intel.com>, 
 Joern Engel <joern@lazybastard.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 Shrikanth Hegde <sshegde@linux.ibm.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Brian Norris <computersforpeace@gmail.com>, 
 Kamal Dasu <kamal.dasu@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 William Zhang <william.zhang@broadcom.com>, 
 Anand Gore <anand.gore@broadcom.com>, 
 Kursad Oney <kursad.oney@broadcom.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Han Xu <han.xu@nxp.com>, Paul Cercueil <paul@crapouillou.net>, 
 Harvey Hunt <harveyhuntnexus@gmail.com>, 
 Keguang Zhang <keguang.zhang@gmail.com>, 
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>, 
 Liang Yang <liang.yang@amlogic.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Stefan Agner <stefan@agner.ch>, 
 Lucas Stach <dev@lynxeye.de>, Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Jacky Huang <ychuang3@nuvoton.com>, 
 Shan-Chun Hung <schung@nuvoton.com>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Linus Walleij <linusw@kernel.org>, 
 Kyungmin Park <kyungmin.park@samsung.com>
Cc: linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linuxppc-dev@lists.ozlabs.org, imx@lists.linux.dev, 
 linux-mips@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, linux-sunxi@lists.linux.dev, 
 linux-tegra@vger.kernel.org, 
 Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795624113; l=3557;
 i=pzalewski@thegoodpenguin.co.uk; s=20260430; h=from:subject:message-id;
 bh=9ka96uW8uhmroEA/0ZZ34Gp8KmZZTisL0Zd9lgRMCU8=;
 b=yB/JEeg0v8nqIyAE1Ke9wfd7YSoLKw89W0zAl6SaarFMyVewyRV7wv5K6GuML97H9SyfICVK7
 YkN/iHx9aUKBHks9vSsfAxGp+5LM/eiSvtDjgwuVeS/5BBkSfzY+erw
X-Developer-Key: i=pzalewski@thegoodpenguin.co.uk; a=ed25519;
 pk=vHq4n9IonORH2GTzLv8r6CWAFHzgfBuNkQPXA8NSly0=
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Unify the list terminator to have a single space between the brackets and
no trailing comma. This change doesn't introduce any diffs between
pre/post to the compiled binaries of the modified drivers and just aligns
these to the common style with other *_device_id arrays.

Signed-off-by: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
---
 drivers/mtd/nand/ecc-mtk.c                 | 2 +-
 drivers/mtd/nand/ecc-mxic.c                | 2 +-
 drivers/mtd/nand/ecc-realtek.c             | 2 +-
 drivers/mtd/nand/onenand/onenand_omap2.c   | 2 +-
 drivers/mtd/nand/onenand/onenand_samsung.c | 3 ++-
 drivers/mtd/nand/spi/core.c                | 4 ++--
 6 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/nand/ecc-mtk.c b/drivers/mtd/nand/ecc-mtk.c
index a3a285170fcd..854f513c4952 100644
--- a/drivers/mtd/nand/ecc-mtk.c
+++ b/drivers/mtd/nand/ecc-mtk.c
@@ -530,7 +530,7 @@ static const struct of_device_id mtk_ecc_dt_match[] = {
 		.compatible = "mediatek,mt7986-ecc",
 		.data = &mtk_ecc_caps_mt7986,
 	},
-	{},
+	{ }
 };
 
 static int mtk_ecc_probe(struct platform_device *pdev)
diff --git a/drivers/mtd/nand/ecc-mxic.c b/drivers/mtd/nand/ecc-mxic.c
index 41ee49419798..30434ec8f6a0 100644
--- a/drivers/mtd/nand/ecc-mxic.c
+++ b/drivers/mtd/nand/ecc-mxic.c
@@ -859,7 +859,7 @@ static const struct of_device_id mxic_ecc_of_ids[] = {
 	{
 		.compatible = "mxicy,nand-ecc-engine-rev3",
 	},
-	{ /* sentinel */ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, mxic_ecc_of_ids);
 
diff --git a/drivers/mtd/nand/ecc-realtek.c b/drivers/mtd/nand/ecc-realtek.c
index fb573c7f2280..a59b6ecbdd19 100644
--- a/drivers/mtd/nand/ecc-realtek.c
+++ b/drivers/mtd/nand/ecc-realtek.c
@@ -448,7 +448,7 @@ static const struct of_device_id rtl_ecc_of_ids[] = {
 	{
 		.compatible = "realtek,rtl9301-ecc",
 	},
-	{ /* sentinel */ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, rtl_ecc_of_ids);
 
diff --git a/drivers/mtd/nand/onenand/onenand_omap2.c b/drivers/mtd/nand/onenand/onenand_omap2.c
index 4c1379343fbd..9efde604e0eb 100644
--- a/drivers/mtd/nand/onenand/onenand_omap2.c
+++ b/drivers/mtd/nand/onenand/onenand_omap2.c
@@ -587,7 +587,7 @@ static void omap2_onenand_remove(struct platform_device *pdev)
 
 static const struct of_device_id omap2_onenand_id_table[] = {
 	{ .compatible = "ti,omap2-onenand", },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, omap2_onenand_id_table);
 
diff --git a/drivers/mtd/nand/onenand/onenand_samsung.c b/drivers/mtd/nand/onenand/onenand_samsung.c
index 8c2d3866a6d6..bf516130130e 100644
--- a/drivers/mtd/nand/onenand/onenand_samsung.c
+++ b/drivers/mtd/nand/onenand/onenand_samsung.c
@@ -984,7 +984,8 @@ static const struct platform_device_id s3c_onenand_driver_ids[] = {
 	}, {
 		.name		= "s5pc110-onenand",
 		.driver_data	= TYPE_S5PC110,
-	}, { },
+	},
+	{ }
 };
 MODULE_DEVICE_TABLE(platform, s3c_onenand_driver_ids);
 
diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 22756832eacf..75a012770f63 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -2104,14 +2104,14 @@ static int spinand_remove(struct spi_mem *mem)
 
 static const struct spi_device_id spinand_ids[] = {
 	{ .name = "spi-nand" },
-	{ /* sentinel */ },
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, spinand_ids);
 
 #ifdef CONFIG_OF
 static const struct of_device_id spinand_of_ids[] = {
 	{ .compatible = "spi-nand" },
-	{ /* sentinel */ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, spinand_of_ids);
 #endif

-- 
2.53.0


