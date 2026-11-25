Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70F1606A31E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2026 21:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20260707.gappssmtp.com header.i=@thegoodpenguin-co-uk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=j/hfeUFE
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZY6T2sphz3bTj;
	Thu, 26 Nov 2026 08:41:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::329"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795624133;
	cv=none; b=d8PurvL8vJI6RwxSJaFN8H1k9qfa/x3dQUzX5Rbun0WGI7MfdplVUhI1gdtJFJeXXmcnGjR0c8iPXWy46EA1UjDYNIOzAPPVlWzsrtSh8K7FV1BeqlUShbLDoIhywocc4+tSb/sn9pQNeCjjCkN598hpbuIdy19dfHEFfjzYgFTtGDEetf5mhPv055i5J5xVXFMhqbm2fQfGgn0bawwfyra9f3nqn3ZqVwo0Eo5fGpL21rlBUvY70Yx3d4OoUz8mFTytILklVacGrGlmoYSARNQWOqto1q+CLJjqPjLlv7zPlSjVam7qfP/08meENCokRq1pI0S4FeIq8U1uaZ/bOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795624133; c=relaxed/relaxed;
	bh=Jkpq3Qrv0SgVfFgdH0HjFFR4TiuDoTsfQLCdgkzvL4U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=enBP0fpySrmi0nnxyCF2wsJK11hy0oawCXJOvIvuVXjWqDeBrr7x8AkDTqdAifHliDFE180rXLSOITHsHIafN9TWRIMfvVAHAYK9ubV7w9eh6mHoiRuTx1PatCF2XCkecoDu5kE9WPY7NcaGpTg64+gNw6kEpcXNOb18819t2NFmNSGLbVjcSBtw2pUS6BVmsBz9kbwRv84WEkjh+4OgVu8itXhgVc3v1xGvJqg/OtNM/oS6YdAoe//4st98xpe9M9RJxRqWrzJRyPy8Z7xZAEhaSc/YNrJXib5plbkYLBNC4YYKvV52PghgHFCHPF5oRCYr16NuLjJjEAVpjAVOAw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; dkim=pass (2048-bit key; unprotected) header.d=thegoodpenguin-co-uk.20260707.gappssmtp.com header.i=@thegoodpenguin-co-uk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=j/hfeUFE; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com; envelope-from=pzalewski@thegoodpenguin.co.uk; receiver=lists.ozlabs.org) smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=thegoodpenguin-co-uk.20260707.gappssmtp.com header.i=@thegoodpenguin-co-uk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=j/hfeUFE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=thegoodpenguin.co.uk (client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com; envelope-from=pzalewski@thegoodpenguin.co.uk; receiver=lists.ozlabs.org)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZQ9J0NWXz2xLg
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 03:28:52 +1100 (AEDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4bb64ef5a00so48207185e9.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2026 08:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20260707.gappssmtp.com; s=20260707; t=1795624129; x=1796228929; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jkpq3Qrv0SgVfFgdH0HjFFR4TiuDoTsfQLCdgkzvL4U=;
        b=j/hfeUFECKbTgKnMDMMXvBdBiF728nsE85G4stqRnrO52mdG9xCbFYk6TIXUDBWiO+
         NBh8Bz4ax5jThmRc9KQANsNv4Mkw/N+tgY2xfFhDoWrK4w69M4SBx9+dnuzcG7Yxa0ym
         NUEAF3Db0iP+NwVjQh8tRmAf9IyF4fHYRe5eBHCJeoZtcO3JFEPwSFbGUyFCDLJEpQoQ
         lIGGl3o6SfcGkOZP3ADsrsG7LPcP+5QMlS67kTWx6kEXEoMuTcwkQvTtxd2bs1kpDKsJ
         HE0dGOp0DwcegS/urNE5XSeoztw+ylmDf9vnLCKdrAsliwdNYzvTBJ31lNqk8DMyLYpU
         tWqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795624129; x=1796228929;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jkpq3Qrv0SgVfFgdH0HjFFR4TiuDoTsfQLCdgkzvL4U=;
        b=Om8f3aBsaDJ1OhjJAPGHcvaN4HXwgsMQ5YR8Vjyklq4dl8vZm2dj0681TtjII3ET1a
         8qKTsZz2eGmwXlRmWvzS+V67GgCotURZFkgqUoOC3B98PlVap7dcKPnwG6KU1BqOgq2Z
         vB/24d3GF0eTf9rH9fpLhuVlnPM6elyTes+WQqi1nfJ/nRb4O7esTHnKf+st3QZrVuHJ
         L9fLAd2/suJ8PlItVLnl4zuf/QgDo2OyU8nLci752yFRw10sEigkzCg7UVlFGXC6qg1G
         a+e/d/LX5EQl3KeWSzEvqOOR7YnaaR0zQZoV2KlxFXeYc0Tbx1TSbk+aPMrJVf8JFrEC
         KiFw==
X-Forwarded-Encrypted: i=1; AL+hErHlAHaFYodmfdRKjpCWoSqZ3HafgVC2SQNSFrhjPj9H3kIni6OPebRgWMQ8wI55QikS8SB34FVGd8iIZhU=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9wHcKJ9WZaSJlzLU5XlV0s7XnESvdcmg/nkHamGfBtsVVSmKsc
	K8FDKCUYxCKaBF4JQBlFMfPPy+VO3nf1dSYpS50N3JnmihwcICbCStKsr6N0lklhJhc=
X-Gm-Gg: AZFdTZd/wHsSZf77almUzt2cGq45b3HKrbWies3FXkYwAoqN4gi6/sFGE5rGz2oLwYO
	EWHKsEhXOa2dace5beG1Q3MMyrLMEFd8Lgfh2vaKw84isK/0KvJJjXGTcfUfC4oBYb36EXYi4h8
	PFJU0LfB12x6V0GNXE/DURtN7PaOR7uBPzEEHkyXC+z0gS21UWahGfAXesRtHQOqVUgOr8fiHYs
	KncnlBZuTIcnYMxe/UXlRsloTetMtbYCA7HYPoOXH0ehZ9l4S9HcTbxLZeXRDLYhg0DDnSXlcNj
	gI2PsO70wsCZHsPOFZ3EEU4CUJPgAm1GhC9tVutCsUy540TdI24kdi20dTfQYMKMykotsFgcLcw
	HRng80LtTlqUHTQXBNRYiUdOM1IkGr5JV5XfA/QoSxB0OxkHf+h7omlIyODaZxz1JxvRBCs1rMJ
	fNrtiFE1QEAIi1BfO3DzvmlEfd9yDOE5T/ns0YdDH44HwRrXuPXyHhapZUuK1Ki6ka2waRlkPVv
	gVScIlWktmoCYZE4NNZJQykQKuiuyJwxgN+tRMPL0DxW2Mi4yDBAPDSvfG8l30OmbK0W6tsfoW2
	uikXwDyAiigLp5d+OeQWkVx8S4ouZv9hSXfQJMgU1SEjYg==
X-Received: by 2002:a05:600c:8b11:b0:4a2:a9:ed5a with SMTP id 5b1f17b1804b1-4bb88826835mr369069605e9.8.1795624128871;
        Wed, 25 Nov 2026 08:28:48 -0800 (PST)
Received: from [10.42.0.1] ([2a00:23c7:1d1a:9c01:f716:ba19:8aaa:f1c2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853368d3sm527336375e9.1.2026.11.25.08.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 08:28:48 -0800 (PST)
From: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
Date: Wed, 25 Nov 2026 16:28:31 +0000
Subject: [PATCH 05/10] mtd: devices: Unify *_device_id list terminator.
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
Message-Id: <20261125-acpi-mtd-v1-5-42ad2f645bee@thegoodpenguin.co.uk>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795624113; l=5688;
 i=pzalewski@thegoodpenguin.co.uk; s=20260430; h=from:subject:message-id;
 bh=e38PNjVjjK9fQET0Z5RSjQeQUR9n82Nx3ix8ylWZkAc=;
 b=UmynCOwoYM4GS77+J2oETnIgPnWornuOiaAN1UaN6yWzj88g2jweJvGkqkw5pwk01i9dDTzKw
 jhi+aPV+h/XAaOKJSEM/GC0voUs+NMNtgllLP1rD+cGxum6pU8i9x47
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
 drivers/mtd/devices/docg3.c         | 2 +-
 drivers/mtd/devices/mchp23k256.c    | 4 ++--
 drivers/mtd/devices/mchp48l640.c    | 4 ++--
 drivers/mtd/devices/mtd_dataflash.c | 8 ++++----
 drivers/mtd/devices/mtd_intel_dg.c  | 4 +---
 drivers/mtd/devices/phram.c         | 2 +-
 drivers/mtd/devices/powernv_flash.c | 2 +-
 drivers/mtd/devices/spear_smi.c     | 2 +-
 drivers/mtd/devices/st_spi_fsm.c    | 2 +-
 9 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/mtd/devices/docg3.c b/drivers/mtd/devices/docg3.c
index a8a77de1c6f0..1f0b1b0f4a83 100644
--- a/drivers/mtd/devices/docg3.c
+++ b/drivers/mtd/devices/docg3.c
@@ -2051,7 +2051,7 @@ static void docg3_release(struct platform_device *pdev)
 #ifdef CONFIG_OF
 static const struct of_device_id docg3_dt_ids[] = {
 	{ .compatible = "m-systems,diskonchip-g3" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, docg3_dt_ids);
 #endif
diff --git a/drivers/mtd/devices/mchp23k256.c b/drivers/mtd/devices/mchp23k256.c
index 05a4ebe21e4b..31c0f414f449 100644
--- a/drivers/mtd/devices/mchp23k256.c
+++ b/drivers/mtd/devices/mchp23k256.c
@@ -225,7 +225,7 @@ static const struct of_device_id mchp23k256_of_table[] = {
 		.compatible = "microchip,mchp23lcv1024",
 		.data = &mchp23lcv1024_caps,
 	},
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, mchp23k256_of_table);
 
@@ -238,7 +238,7 @@ static const struct spi_device_id mchp23k256_spi_ids[] = {
 		.name = "mchp23lcv1024",
 		.driver_data = (kernel_ulong_t)&mchp23lcv1024_caps,
 	},
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, mchp23k256_spi_ids);
 
diff --git a/drivers/mtd/devices/mchp48l640.c b/drivers/mtd/devices/mchp48l640.c
index c6e83775638d..60dfe0980557 100644
--- a/drivers/mtd/devices/mchp48l640.c
+++ b/drivers/mtd/devices/mchp48l640.c
@@ -372,7 +372,7 @@ static const struct of_device_id mchp48l640_of_table[] = {
 		.compatible = "fujitsu,mb85rs128ty",
 		.data = &mb85rs128ty_caps,
 	},
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, mchp48l640_of_table);
 
@@ -385,7 +385,7 @@ static const struct spi_device_id mchp48l640_spi_ids[] = {
 		.name = "mb85rs128ty",
 		.driver_data = (kernel_ulong_t)&mb85rs128ty_caps,
 	},
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, mchp48l640_spi_ids);
 
diff --git a/drivers/mtd/devices/mtd_dataflash.c b/drivers/mtd/devices/mtd_dataflash.c
index e766258d76f7..607c5cbd2a83 100644
--- a/drivers/mtd/devices/mtd_dataflash.c
+++ b/drivers/mtd/devices/mtd_dataflash.c
@@ -99,15 +99,15 @@ struct dataflash {
 static const struct of_device_id dataflash_dt_ids[] = {
 	{ .compatible = "atmel,at45", },
 	{ .compatible = "atmel,dataflash", },
-	{ /* sentinel */ }
+	{ }
 };
 MODULE_DEVICE_TABLE(of, dataflash_dt_ids);
 #endif
 
 static const struct spi_device_id dataflash_spi_ids[] = {
-	{ .name = "at45", },
-	{ .name = "dataflash", },
-	{ /* sentinel */ }
+	{ .name = "at45" },
+	{ .name = "dataflash" },
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, dataflash_spi_ids);
 
diff --git a/drivers/mtd/devices/mtd_intel_dg.c b/drivers/mtd/devices/mtd_intel_dg.c
index 55a945c1a67a..63685615a02d 100644
--- a/drivers/mtd/devices/mtd_intel_dg.c
+++ b/drivers/mtd/devices/mtd_intel_dg.c
@@ -863,9 +863,7 @@ static const struct auxiliary_device_id intel_dg_mtd_id_table[] = {
 	{
 		.name = "xe.nvm",
 	},
-	{
-		/* sentinel */
-	}
+	{ }
 };
 MODULE_DEVICE_TABLE(auxiliary, intel_dg_mtd_id_table);
 
diff --git a/drivers/mtd/devices/phram.c b/drivers/mtd/devices/phram.c
index b42cadcd76b1..7c6b2852916c 100644
--- a/drivers/mtd/devices/phram.c
+++ b/drivers/mtd/devices/phram.c
@@ -371,7 +371,7 @@ MODULE_PARM_DESC(phram, "Memory region to map. \"phram=<name>,<start>,<length>[,
 #ifdef CONFIG_OF
 static const struct of_device_id phram_of_match[] = {
 	{ .compatible = "phram" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, phram_of_match);
 #endif
diff --git a/drivers/mtd/devices/powernv_flash.c b/drivers/mtd/devices/powernv_flash.c
index 4bd7b41a03b7..596d592a8ede 100644
--- a/drivers/mtd/devices/powernv_flash.c
+++ b/drivers/mtd/devices/powernv_flash.c
@@ -278,7 +278,7 @@ static void powernv_flash_release(struct platform_device *pdev)
 
 static const struct of_device_id powernv_flash_match[] = {
 	{ .compatible = "ibm,opal-flash" },
-	{}
+	{ }
 };
 
 static struct platform_driver powernv_flash_driver = {
diff --git a/drivers/mtd/devices/spear_smi.c b/drivers/mtd/devices/spear_smi.c
index dc66ed852d80..947d82bebe4a 100644
--- a/drivers/mtd/devices/spear_smi.c
+++ b/drivers/mtd/devices/spear_smi.c
@@ -1079,7 +1079,7 @@ static SIMPLE_DEV_PM_OPS(spear_smi_pm_ops, spear_smi_suspend, spear_smi_resume);
 #ifdef CONFIG_OF
 static const struct of_device_id spear_smi_id_table[] = {
 	{ .compatible = "st,spear600-smi" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, spear_smi_id_table);
 #endif
diff --git a/drivers/mtd/devices/st_spi_fsm.c b/drivers/mtd/devices/st_spi_fsm.c
index 94872e03a04d..abdcef3c91b0 100644
--- a/drivers/mtd/devices/st_spi_fsm.c
+++ b/drivers/mtd/devices/st_spi_fsm.c
@@ -2124,7 +2124,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(stfsm_pm_ops, stfsmfsm_suspend, stfsmfsm_resume)
 
 static const struct of_device_id stfsm_match[] = {
 	{ .compatible = "st,spi-fsm", },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, stfsm_match);
 

-- 
2.53.0


