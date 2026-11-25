Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB22606A31E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2026 21:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20260707.gappssmtp.com header.i=@thegoodpenguin-co-uk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Afbq5r26
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZY5z6RL1z2yDD;
	Thu, 26 Nov 2026 08:41:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::335"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795624125;
	cv=none; b=FVnH4WebrGSEnUMng4amUkWTVVzjAQGZsTStdLjR6oduKY2+ar9S0FMX+SAwaNFxS0aHLfC2//lQ/nxreMD8APKUStiAXsh6r02htLxzC7fYvLedSgqIvKnCdkrXsY4bpX+C3df0fDZKTQqCooC4e6Fey244B+8l3ddjxHciurVuWAucBFbidoEVHWonM7WDkhq1do1R854gb451ZJGGSbmCOMllEOVPTIoizUB9RLLKfG9ObsZqS4s6XJ9EdcDsL2rKzRj0HrJLG9R733uUcMO9bvjiqa5O45ZlJhNxMCDIBagPLH39J6bO+JU9og5OfIVPVofLbsGVCZ+b5R6WlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795624125; c=relaxed/relaxed;
	bh=E/Paw5QZ9QxbXxzyBtlunqj4eITAuJB1YG4IYSSOnm4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UTUcNylZ7bL1VbWxkPlte61HY2i8SMOUGQG63dGNqWSkKmOEpN5fvw28ODYV/eIn7Uo8zHu+J7HtFR8oQxK6slIYpzincdtMglphmdRmloCBfxzQ1kqF4UMYjprPr/0UaGwDvkF3PXPEF955VVgVeU6U4DUa5fLCsMWkK+yu5VIjFnuVUJRVyhXtO/EE5SVqkUAI193/D7G88cXAlUGACryK08WnOCi7EeQagy3MyqSt5WwaRxjWVQpWLwnvybNOGhcsuiy72Xhi9RrSxMMFUwn4o/bZUmb0nuhiaJefAI6oanxcqinZOil5s6hUumXOjT83xFQnbcmFmfuVjQqiKQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; dkim=pass (2048-bit key; unprotected) header.d=thegoodpenguin-co-uk.20260707.gappssmtp.com header.i=@thegoodpenguin-co-uk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Afbq5r26; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com; envelope-from=pzalewski@thegoodpenguin.co.uk; receiver=lists.ozlabs.org) smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=thegoodpenguin-co-uk.20260707.gappssmtp.com header.i=@thegoodpenguin-co-uk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Afbq5r26;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=thegoodpenguin.co.uk (client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com; envelope-from=pzalewski@thegoodpenguin.co.uk; receiver=lists.ozlabs.org)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZQ986CJZz2xLg
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 03:28:44 +1100 (AEDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-4b467581b98so58633555e9.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2026 08:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20260707.gappssmtp.com; s=20260707; t=1795624122; x=1796228922; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E/Paw5QZ9QxbXxzyBtlunqj4eITAuJB1YG4IYSSOnm4=;
        b=Afbq5r26h9MRI5VsaOhY+RPZorc7R6LMGdnEKjVaieKzUPqtnMT/hOdVuuxpVBjgsw
         Wd1C7vgO3gZdWHhdBqoFjf69mAYybF9cpyJcmK+NgIjaJ27NadlGNlFj9Pcnn4qULRYu
         W/ZQ7SUWulo8Ay5clsohSv7SVZs5m/PuX6D8qqOzcfZbGBUrEHTl1AmFG0+MzIWQb5Xq
         S6bPH0Sl/5xfRZG4OMo0DMnWC2hudNIGE2w0Dl3M63zl+DYcBI4X5NyrrrZ9VP/8mNut
         kZHPDKomMc0KiboNR8UMUma7rzSYarVB1b21TrXSJHBGWKEQHGDwa9birJTGUqYAgGJg
         n6Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795624122; x=1796228922;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E/Paw5QZ9QxbXxzyBtlunqj4eITAuJB1YG4IYSSOnm4=;
        b=nrisy6C0pMxVJYzZdMnfYTesdDqLo62TZUobSUFllb6BoXx2J2K1y6Y4+98YMQMpRs
         Oo1UR7mYH01bYY61gwyemze7fwk3YE3IREjK0JTkMPumP2dZHOMGwMgJkk3f/lEtIi58
         te4wwrFkx+58P0xWC0pdORq8Q3UARdabl8LYIP7YDuTUqCfk0mIUGkp99QGB1hcftlEf
         8WvOws/xygHFQCsg/3UyLHh69+AZIqKNj6td5exnbXo42XxRl1pOsfEf+E0DSrKDo1Kl
         OGZhBNVIkHVtdTY4JbQ2mey+IUnkVeRbRk/bFuzvtzMDU0fBDOXwL7SvZyqNfqts6ZXA
         Jyag==
X-Forwarded-Encrypted: i=1; AL+hErGoZhiArLBB12UlsmEPwrN8s2PRajNDlPZaWLpb1RcPdiIWQgu9C2CntlIdyGZb0QK64ORIzaKs4Qn8W/I=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8dttx2R5OzlD0YzDv1YFRpjLrKXN1TbMqGJH2ZpZZ3zn+yZS8/
	2A13ACNUW//eYCdaJsWh5E9RDMy0Iqtx8qbRxVccUsgGVuyjzPCYWLaeVYRm6GFlG+w=
X-Gm-Gg: AZFdTZfdYxZxRHxGcdNNyvYbO1Jlvp13G84byidyXe2ktywriDOiF8Ydc79RoFOYekg
	YX2xbPvWhVUEiEYKHT4ZjoyUnUyWGqNG0n6feJF7kK9o6RwpUUAMmzk65vYGlShKRDyxUZsACAB
	SzPf7tuXpaCT4xnrLLrscy8sTwu67uY78mntDqbe32sQps2EHr8wLZK31DnC56+LAWa8FQGJrA1
	o7UkQn+nz8A84tl0xud9w/Xc4vmhrIZN9PeuMIUAm+Hi/L/0SSAUv+t7qjsw7jhJQPjOkp3zC/w
	1rZvUW2+T11qOCwf9GR+4Hw/DAox9YkzekjiEqw/rn+ugm4onAX/nOIIkihmD8+mRJCkrus6SYI
	kwfTN2tK8fduRiXDQqHmBFs4Kv79kSgZtH98aUfybUjvkxjI9SlZ0SRmtK4EqQPnlpCwSsw8WTT
	KzlUGcQKIcp2n2uBoNGvP/kDna7GhdsDid06PYaasp2cemRO7DpGyS0Tdz8OmHmeUf+WMvXagbj
	3X4C3bGEnwqO+7ZjJCY6lbrcaeJRojmYULjVuVXvMedn7O+xI61RtleTH/4RJDh523FVohTtNjB
	zX3vXQ6Jc6pQBo9UZV69E1bV9mb2kYbpAOTZhNdnVD7ztw==
X-Received: by 2002:a05:600c:3b8a:b0:4a3:59c9:a754 with SMTP id 5b1f17b1804b1-4bb8892da25mr367205855e9.22.1795624121613;
        Wed, 25 Nov 2026 08:28:41 -0800 (PST)
Received: from [10.42.0.1] ([2a00:23c7:1d1a:9c01:f716:ba19:8aaa:f1c2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853368d3sm527336375e9.1.2026.11.25.08.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 08:28:41 -0800 (PST)
From: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
Date: Wed, 25 Nov 2026 16:28:28 +0000
Subject: [PATCH 02/10] mtd: spi-nor: Use named initializers for
 spi_device_id
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
Message-Id: <20261125-acpi-mtd-v1-2-42ad2f645bee@thegoodpenguin.co.uk>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795624113; l=4183;
 i=pzalewski@thegoodpenguin.co.uk; s=20260430; h=from:subject:message-id;
 bh=oSYQ7Bs6TY9Bq0it7ME4AMa1HN8RgNqdeSRr8O3thOM=;
 b=ZzYcsPDU1eT9Urm3wkVmXrHRSn8lYS47jYwodaBWVXhHbdUtk3xdzrjUw2pFBpCbVfZ0+gfNR
 dIrCrr0zs9uAk13TU8rgxCJLHxUgZjH9xPYqCVfddGmUaS8ISdiG+oY
X-Developer-Key: i=pzalewski@thegoodpenguin.co.uk; a=ed25519;
 pk=vHq4n9IonORH2GTzLv8r6CWAFHzgfBuNkQPXA8NSly0=
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Use a designated initializer for the spi_device_id fields which makes the
code more readable and consistent with how lists are initialized in the
rest of the kernel code base.

Put every list item on a new line and unify the list terminator to have
a single space between the brackets and no trailing comma.

Signed-off-by: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
---
 drivers/mtd/spi-nor/core.c | 77 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 55 insertions(+), 22 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index a04d22d2e2e1..a76c669000d8 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -3662,42 +3662,75 @@ static const struct spi_device_id spi_nor_dev_ids[] = {
 	 * hack around the fact that the SPI core does not provide uevent
 	 * matching for .of_match_table
 	 */
-	{"spi-nor"},
+	{ .name = "spi-nor" },
 
 	/*
 	 * Entries not used in DTs that should be safe to drop after replacing
 	 * them with "spi-nor" in platform data.
 	 */
-	{"s25sl064a"},	{"w25x16"},	{"m25p10"},	{"m25px64"},
+	{ .name = "s25sl064a" },
+	{ .name = "w25x16" },
+	{ .name = "m25p10" },
+	{ .name = "m25px64" },
 
 	/*
 	 * Entries that were used in DTs without "jedec,spi-nor" fallback and
 	 * should be kept for backward compatibility.
 	 */
-	{"at25df321a"},	{"at25df641"},	{"at26df081a"},
-	{"mx25l4005a"},	{"mx25l1606e"},	{"mx25l6405d"},	{"mx25l12805d"},
-	{"mx25l25635e"},{"mx66l51235l"},
-	{"n25q064"},	{"n25q128a11"},	{"n25q128a13"},	{"n25q512a"},
-	{"s25fl256s1"},	{"s25fl512s"},	{"s25sl12801"},	{"s25fl008k"},
-	{"s25fl064k"},
-	{"sst25vf040b"},{"sst25vf016b"},{"sst25vf032b"},{"sst25wf040"},
-	{"m25p40"},	{"m25p80"},	{"m25p16"},	{"m25p32"},
-	{"m25p64"},	{"m25p128"},
-	{"w25x80"},	{"w25x32"},	{"w25q32"},	{"w25q32dw"},
-	{"w25q80bl"},	{"w25q128"},	{"w25q256"},
+	{ .name = "at25df321a" },
+	{ .name = "at25df641" },
+	{ .name = "at26df081a" },
+	{ .name = "mx25l4005a" },
+	{ .name = "mx25l1606e" },
+	{ .name = "mx25l6405d" },
+	{ .name = "mx25l12805d" },
+	{ .name = "mx25l25635e" },
+	{ .name = "mx66l51235l" },
+	{ .name = "n25q064" },
+	{ .name = "n25q128a11" },
+	{ .name = "n25q128a13" },
+	{ .name = "n25q512a" },
+	{ .name = "s25fl256s1" },
+	{ .name = "s25fl512s" },
+	{ .name = "s25sl12801" },
+	{ .name = "s25fl008k" },
+	{ .name = "s25fl064k" },
+	{ .name = "sst25vf040b" },
+	{ .name = "sst25vf016b" },
+	{ .name = "sst25vf032b" },
+	{ .name = "sst25wf040" },
+	{ .name = "m25p40" },
+	{ .name = "m25p80" },
+	{ .name = "m25p16" },
+	{ .name = "m25p32" },
+	{ .name = "m25p64" },
+	{ .name = "m25p128" },
+	{ .name = "w25x80" },
+	{ .name = "w25x32" },
+	{ .name = "w25q32" },
+	{ .name = "w25q32dw" },
+	{ .name = "w25q80bl" },
+	{ .name = "w25q128" },
+	{ .name = "w25q256" },
 
 	/* Flashes that can't be detected using JEDEC */
-	{"m25p05-nonjedec"},	{"m25p10-nonjedec"},	{"m25p20-nonjedec"},
-	{"m25p40-nonjedec"},	{"m25p80-nonjedec"},	{"m25p16-nonjedec"},
-	{"m25p32-nonjedec"},	{"m25p64-nonjedec"},	{"m25p128-nonjedec"},
+	{ .name = "m25p05-nonjedec" },
+	{ .name = "m25p10-nonjedec" },
+	{ .name = "m25p20-nonjedec" },
+	{ .name = "m25p40-nonjedec" },
+	{ .name = "m25p80-nonjedec" },
+	{ .name = "m25p16-nonjedec" },
+	{ .name = "m25p32-nonjedec" },
+	{ .name = "m25p64-nonjedec" },
+	{ .name = "m25p128-nonjedec" },
 
 	/* Everspin MRAMs (non-JEDEC) */
-	{ "mr25h128" }, /* 128 Kib, 40 MHz */
-	{ "mr25h256" }, /* 256 Kib, 40 MHz */
-	{ "mr25h10" },  /*   1 Mib, 40 MHz */
-	{ "mr25h40" },  /*   4 Mib, 40 MHz */
+	{ .name = "mr25h128" }, /* 128 Kib, 40 MHz */
+	{ .name = "mr25h256" }, /* 256 Kib, 40 MHz */
+	{ .name = "mr25h10" },  /*   1 Mib, 40 MHz */
+	{ .name = "mr25h40" },  /*   4 Mib, 40 MHz */
 
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, spi_nor_dev_ids);
 
@@ -3707,7 +3740,7 @@ static const struct of_device_id spi_nor_of_table[] = {
 	 * JEDEC READ ID opcode (0x9F). Use this, if possible.
 	 */
 	{ .compatible = "jedec,spi-nor" },
-	{ /* sentinel */ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, spi_nor_of_table);
 

-- 
2.53.0


