Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF624606A31E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2026 21:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20260707.gappssmtp.com header.i=@thegoodpenguin-co-uk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=iTRBCWZq
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZY6q46RPz3bf8;
	Thu, 26 Nov 2026 08:42:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795624138;
	cv=none; b=Qj+rQtZ1FeeHxRNCQBOT9sfcahOayL2076ojvnaLIVPpS39fQt5JZphX0Kl/NXDWLy7ft/O52eKdyWGbWt2JyAP1b9B9fC/wxOt7zNxtkYdZBtT1ECCOnCGhpps3bd1/PLC0GodWHHdsN1VX6ui1D/MhMF3i9bCFowbz49WOOUHVzLH/8vubkFbFPwbrCQdHjYBkjO4ThAGy2zjUy5FtjKFjtTMtwskW81jWCS82yZYy7wWgUgeV2xMHby0VcWgTXup4p2/gBxXC6FRgpwBMH+Hul58FCL+4qWq4v99hmWTU8nq0ShhuiFUMCU9tz1y386VViwIBoZs70S54LXHWkA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795624138; c=relaxed/relaxed;
	bh=/coGxf+TvCt6CYyWE3tU4VBa2tGsxrO7OX/byIc4o4c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P8QbyHfD1R38WN0JBF+7eZ3OOfoVP4jifpotoaxbATicEhxZbtN7z1Zwa1i0JH0SZSL2Ft1poOUlLZ2JlJa0jzJiYVfg0kA2Q9LWY6ZPqTz8tbqUzQYYp19XwyDbpkF55ygoXIjTrLUkwdOsPEvdNC2sOakJ6ba3BhqOQ67Aqd8YHyVGkCcWrbJyu8FqeJIcs6A0dWMg1kxcm4ZgfscfBWdT12J9BFq5rTQr225ENb3ErUXh2N+fyfrQgPK2ZhecH/T8Y5r201mqOl5ZyDC8C/tUio+Dp0BHBfjlIp94vusumUybCq0xm+s2G6CxzX76jCm6uRZ29HBjQnHTscQFJg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; dkim=pass (2048-bit key; unprotected) header.d=thegoodpenguin-co-uk.20260707.gappssmtp.com header.i=@thegoodpenguin-co-uk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=iTRBCWZq; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com; envelope-from=pzalewski@thegoodpenguin.co.uk; receiver=lists.ozlabs.org) smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=thegoodpenguin-co-uk.20260707.gappssmtp.com header.i=@thegoodpenguin-co-uk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=iTRBCWZq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=thegoodpenguin.co.uk (client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com; envelope-from=pzalewski@thegoodpenguin.co.uk; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZQ9N5hVnz2xLg
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 03:28:56 +1100 (AEDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-4b467581b98so58636535e9.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2026 08:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20260707.gappssmtp.com; s=20260707; t=1795624133; x=1796228933; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/coGxf+TvCt6CYyWE3tU4VBa2tGsxrO7OX/byIc4o4c=;
        b=iTRBCWZqf/a2iTGCLaWuuaifdlzbDPPBHzLIaEI2t5bTkgyZ2mCy2m0Hw0jQqXhIp+
         ondEQU+BDYAZmQ9SSdafLoNkoXzTTbxi9G8Mmds3X0LvBpu/PrIzX5Ciwr2Jsb4wEWMn
         NFV/mjFMT7lhGWdICjCnIrs7zufnGNN0yIbqv+GMW/aM7+sPEkTUz+L3pUY07oBg/+n0
         /AvRfOkQkhx3RBtzGwkuC3thWET+mQ/fvNqhhWF8+21swbFHjjq5LUQrEVd9QN4kkY+A
         gkPfXcKoIEqSU8ENMwV8NzXyelg+6hKvBG/e9kc9hIuylfUnI06dtQLOq6zLDXqP29oh
         08ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795624133; x=1796228933;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/coGxf+TvCt6CYyWE3tU4VBa2tGsxrO7OX/byIc4o4c=;
        b=VZ53/WjfsUVDLoVJ1f1DwJM9FMiOF7SuVvNEooAPrwIKS02GWFIBD7Q105Vty+LiU0
         cCxwTdi/2zl8YeAZUe207u8rLfxhAM3CjcLqQu57FpJ/1aWxsAQ5j88G29kupeUDJN9D
         a1B2L3S0DVZG0O2cgc5rXbRidyBXcf3WsFuUB8xC1g8hpeKxyFEw1CefOHlI72jkmRNp
         YXX1AMk0uAwiZhUtfovC4kjQgUVAHubLGPetvP7IepmQ+na4OvMI3heyumIuJxnKSoZ1
         lY9FGGH7lqmjKKIZ0z9k2w60d2zwoo/0nkACwlHV7rYv35h4pnT6/J8tbagEVBu8YTWk
         9jpQ==
X-Forwarded-Encrypted: i=1; AL+hErEhOXWsKWAxRODhbfzeLUAxgBHf/q+iQGbTunMxMB7wYrdFPPB38+HPq20uKSE7xD6FQPBL3vGCT6ef8IM=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8YroE3DaD3goS3Z0j580yNQ0fmEev5ve7Rt9jonDMnKoxaJulb
	ytMZF8Pu9u6s8p6DbAFLp0Od0zq8s49I/Bua1BabmXWOTtrM6VQp3QOsp/4BhyqLkdc=
X-Gm-Gg: AZFdTZfZm6a9YZ+r7x+k9th6nC66urzH/pe+P/zthVGkqvHquJA6VNHR1m+AiMJP6aE
	itzRKxtYhDyfMtEghnyrWArWxAKN7CZVtbKBUKOz05iy49g/djhhWx6dELvEMz+1Vammvv8nkMv
	PSI3z8oZPsIkvDU+FePDcm1O5hhR7o7ioiXg9rHeD6zY/G4RrwpbHdk7O7UdVa0ORgdJAW2N6hZ
	HxjmKy+vGM/wHJnX3sbM5JyeaqtG7hZRoaivVOGGv6baSfL1k4qjLKnKUST9Q/zDfkRUf/txmCK
	tnJV1ui7ZdfDyzLOQFFq8uOp4o6fi16S9XrVC0q9+v6PixpvhCclKn+VA4m3nNFPib0zd5XG1EJ
	1IViBJ2GwALwcqwP1/Bk4ZZSZ+4EzxnnOYQBmAEhtVBHB/T0M1grfp6cXVy9ePqB7fEUfQ1GvbH
	wCCEKupMO2H4XCc6//o9Tycj0vZtk/g0HMGK+z4xpwf1RY4tBefJk2RrdtLsiKgEg/SKK2SPUvr
	dFdI+I5uCZoz2P3QCrNqzFYqEs4daqmd7gQ2lfIMl51lCFo4EIMVyMu3RIREW/MfwM+5o+WWJA2
	2tqLXF/gjbuNlJpCgETMODs/n6UdyQ/jCS3mCDEUs01yIg==
X-Received: by 2002:a05:600c:3b8a:b0:4a3:59c9:a754 with SMTP id 5b1f17b1804b1-4bb8892da25mr367217635e9.22.1795624133592;
        Wed, 25 Nov 2026 08:28:53 -0800 (PST)
Received: from [10.42.0.1] ([2a00:23c7:1d1a:9c01:f716:ba19:8aaa:f1c2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853368d3sm527336375e9.1.2026.11.25.08.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 08:28:53 -0800 (PST)
From: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
Date: Wed, 25 Nov 2026 16:28:33 +0000
Subject: [PATCH 07/10] mtd: hyperbus: Unify list terminator for *_device_id
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
Message-Id: <20261125-acpi-mtd-v1-7-42ad2f645bee@thegoodpenguin.co.uk>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795624113; l=1400;
 i=pzalewski@thegoodpenguin.co.uk; s=20260430; h=from:subject:message-id;
 bh=MqS4iZQmtSnMUE+1CE4BRTfcmZv4r/EuEiyu/lunNWQ=;
 b=RjOJCajFiP9KV73PmMUa7M74MYmvCY+UYchwJ0DItvXMOOEvWaLyZVGGPGplnX/bvY7hOn58V
 ubNzVDoXbvxCV3x0jZyFUwCc4fN8Q5ycQmLU63Q+/GExIGSiHODobkY
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
 drivers/mtd/hyperbus/hbmc-am654.c | 2 +-
 drivers/mtd/hyperbus/rpc-if.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/hyperbus/hbmc-am654.c b/drivers/mtd/hyperbus/hbmc-am654.c
index acbcc3b55d86..bac24d9ca02b 100644
--- a/drivers/mtd/hyperbus/hbmc-am654.c
+++ b/drivers/mtd/hyperbus/hbmc-am654.c
@@ -255,7 +255,7 @@ static const struct of_device_id am654_hbmc_dt_ids[] = {
 	{
 		.compatible = "ti,am654-hbmc",
 	},
-	{ /* end of table */ }
+	{ }
 };
 
 MODULE_DEVICE_TABLE(of, am654_hbmc_dt_ids);
diff --git a/drivers/mtd/hyperbus/rpc-if.c b/drivers/mtd/hyperbus/rpc-if.c
index 9eacc9ec7382..a0917f407d7a 100644
--- a/drivers/mtd/hyperbus/rpc-if.c
+++ b/drivers/mtd/hyperbus/rpc-if.c
@@ -165,7 +165,7 @@ static void rpcif_hb_remove(struct platform_device *pdev)
 
 static const struct platform_device_id rpc_if_hyperflash_id_table[] = {
 	{ .name = "rpc-if-hyperflash" },
-	{ /* sentinel */ }
+	{ }
 };
 MODULE_DEVICE_TABLE(platform, rpc_if_hyperflash_id_table);
 

-- 
2.53.0


