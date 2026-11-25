Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5A5606A31E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2026 21:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20260707.gappssmtp.com header.i=@thegoodpenguin-co-uk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=CsVhppKS
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZY6K31wyz30W5;
	Thu, 26 Nov 2026 08:41:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::335"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795624130;
	cv=none; b=J1JM8qkt9mcukJA6pi2h0skk/RwEGKBnoA87gSWuu9Np/fX0T9KLeljYViq1q2tO8MDFvQFPecHJoNqPse1tN07sM+BrdIQjI7ZF9hLSraiSDrmaOve2T2ikO7PBniwiT5SraDY/pxEGaV8UJglfOw7F+LGHXts4HdbQApn2pL7Fc+3ifv5s1AWK4qEVgCVoEj6anW3auoTQUf8aoijMKta+MuGNC3rJgpL0HjHMuwlG25fRrj5COHjzoGM3eekJ+iwAu7M27W+4W2/UtbHduTfDxJE7TW4eUCXQyYLGY3Y3yNaZ5PZpkWUjiVhFtdWgRYIrjHOxmGk92KfAy2Ql5A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795624130; c=relaxed/relaxed;
	bh=OnNdjklB4uWYTn3msQzxTr6Lo2LMKVqTjQIZzgFKEJ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WGsjquzmug1kyi8gt4tK9084hYBsLWKkBAF3J6Lh+cLwVrn6Fr5mFioG0gicB9/bKfB4uV4cTkVd+Lwr42CBGFK+YdVhFJrBzDaYUjMxSx0OumgRAUuNsCm2pHqNONb+SJhO3+IbJ9P+fAebwYXlEMqB8pmZIvkbCHeeU/ji1fIT41mLC3esUGNTZPNlm9fyVtL/vsnAAFTvZrHG6yvkb7w5cBLrutEvZKwoX/oSVG+DiPiWyZxKbzbrxMpxs2bU6MznHlcE75e7DXv7Q4OoKuwER1g+/HC3g4WU53T1Iyt1G9YSPlKseUsj9Sp+afd8nNa40hY49xgJrya9tourlg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; dkim=pass (2048-bit key; unprotected) header.d=thegoodpenguin-co-uk.20260707.gappssmtp.com header.i=@thegoodpenguin-co-uk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=CsVhppKS; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com; envelope-from=pzalewski@thegoodpenguin.co.uk; receiver=lists.ozlabs.org) smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=thegoodpenguin-co-uk.20260707.gappssmtp.com header.i=@thegoodpenguin-co-uk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=CsVhppKS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=thegoodpenguin.co.uk (client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com; envelope-from=pzalewski@thegoodpenguin.co.uk; receiver=lists.ozlabs.org)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZQ9F3Jxzz2xLg
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 03:28:49 +1100 (AEDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-4bb6c7b6dbdso55702755e9.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2026 08:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20260707.gappssmtp.com; s=20260707; t=1795624126; x=1796228926; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OnNdjklB4uWYTn3msQzxTr6Lo2LMKVqTjQIZzgFKEJ4=;
        b=CsVhppKSnXPuCRsPlsY/UhCblSJxVc4ZQFhr8lTpS39L2pVVFGorlbSDozkb58IT35
         sofBl87itdCmIsXeafDpJowq9yRt6dinbhY0K3RvrBX+JSx6ua+rhdLo1/Gb6KYES/gl
         XCZ3haCufU6ZwIez7cCf99tjq5OcT1tkgt0CyAGcDSrj2NT1CeWNkdCQtXp6dcDi9tan
         MyFYorHs6gM9rsPguCa90JnOqUie1/yjRQlvTAAp0iPv121gdTC72ABD+G9OH2qSyGKt
         d+EsKvPitZzGfcB113EWS0t3SJW6uLJ7YzeqmvTwIxW3Zq2oUOA6SVZXAYutnfeeHONM
         Ozqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795624126; x=1796228926;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OnNdjklB4uWYTn3msQzxTr6Lo2LMKVqTjQIZzgFKEJ4=;
        b=YEyIi/eEpEoE8CCefnZ9QbwOEQ3lwZR/bwE8vXthovGf+fwknEhjI+enJPvXOo0jvT
         D0AbNrF5jBLK2Rdx40E6mZMMJ73xIbGVqCjMm9KyPiaVqJ5I9+pIe1DmpYYDtP1Qbe/E
         0ChfvQkHjORfiRPiQD/WYADcszN0AoUsc8YAP+14mPL2Sw7zQhgxgstXx9NWIJeMxS6J
         3qCcT8LL0O/n/hJA+P4XEMqiTNUUDNliosDNYte14DqCy8R5dyPtkdW1C5aSjGkWl4qY
         D6BI7PBLKbmgCaB/YROhN/ZN/z/g6ki70z3ZtroJOHCf5iYrAQsqi5bCRQur3Nq0JhRH
         XmCQ==
X-Forwarded-Encrypted: i=1; AL+hErGpZ2QUjqEu/xBLKC2h1KXRQyIBaISKlMe2IzbgZ0/PblLCzG5UZfeodK4sQj2+9YO7Bdq+knACD7cMk0U=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+F8D1u61xFcEZL9lAgHQgJm/opgjcDMSr+ePi5XObddbGtZnQ6
	I0OxXCqz+e0CQfw7UwpR7NKf5CuxhviPBke4YDn+yw9wPlbOWa1YQxEKcsARBydp+0w=
X-Gm-Gg: AZFdTZcvwUFs7cRmPDLA20oY8Z+xi77mz0hhjhXiB3a+YBbfPpZNpf4+L36r1Hvd0Yq
	G2z9SP4uvpH5PeVaZmlp+QXAK2jVVRkhGD14cEC3qslVdCw9zPqaRlVc2FbBQm8fC9tmqycjMlN
	Yqh0gIHQPvICZUjkWbGj6K4CGLygTjDWEBRl3P+dCzzGRX82NgtiYI40KLZ/UYQyMNYV9WnowFP
	gMHE9NodQ2/YnKqokRGClBU71QUz29vSRhnpCDpxVd47kfE5jyd38FBmO39GP2ewbPKCopr/FHK
	cwnMKweTZIVWwaIVjvcCosrb42ja+KW4FmovzfOdx2h+ASEgi0fD+NLan8esYQyTxXhQNG8zKmn
	yBrEu8dRWdBijZhHEazvTHP+OnoV1MAofGrMx3AF1orNztcsjK7hyY2D6BYXel74rhbwrLDaZRM
	6JjBCazBeS+s+uuIbg7FRqAY1IPd4EHXFmTpSkI4KX42SNE7b4zkjtSjupVOJdhnqOYRK7ZVyWO
	S9k5kMlGb7Qk7s6kRAaK84ALDlrh1MFz2oG14k3QHc1HeY4gaWGz01nLzt5wVlZMGKu/MzSSt2X
	Xw8YZkM63ikUCZsKl96LB3nxxzEFE2MTg9oUMeu+3pj5xg==
X-Received: by 2002:a05:600c:34c9:b0:4a3:5d64:df91 with SMTP id 5b1f17b1804b1-4bb88810d28mr405948895e9.18.1795624126434;
        Wed, 25 Nov 2026 08:28:46 -0800 (PST)
Received: from [10.42.0.1] ([2a00:23c7:1d1a:9c01:f716:ba19:8aaa:f1c2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853368d3sm527336375e9.1.2026.11.25.08.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 08:28:46 -0800 (PST)
From: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
Date: Wed, 25 Nov 2026 16:28:30 +0000
Subject: [PATCH 04/10] mtd: spi-nor: Unify of_device_id list terminator
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
Message-Id: <20261125-acpi-mtd-v1-4-42ad2f645bee@thegoodpenguin.co.uk>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795624113; l=1549;
 i=pzalewski@thegoodpenguin.co.uk; s=20260430; h=from:subject:message-id;
 bh=pw1yVugjZoJ1sYzSavbjoh9EtNi40KpLFcyq3KxCgNo=;
 b=kcHPBXNDukNV21LLTOphkMkZzHhEUE3GVm5MT4GkuuM2LkB9EPUAINUu71xJWBBbyUPxGyGvR
 NyJA9ZKxwfTBYz6TriU3QIhP5Egb+QnpqA24EfhtbypOZI53FKPwK0u
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
 drivers/mtd/spi-nor/controllers/hisi-sfc.c  | 2 +-
 drivers/mtd/spi-nor/controllers/nxp-spifi.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/controllers/hisi-sfc.c b/drivers/mtd/spi-nor/controllers/hisi-sfc.c
index 4f6631950a5b..01048ca46a60 100644
--- a/drivers/mtd/spi-nor/controllers/hisi-sfc.c
+++ b/drivers/mtd/spi-nor/controllers/hisi-sfc.c
@@ -474,7 +474,7 @@ static void hisi_spi_nor_remove(struct platform_device *pdev)
 
 static const struct of_device_id hisi_spi_nor_dt_ids[] = {
 	{ .compatible = "hisilicon,fmc-spi-nor"},
-	{ /* sentinel */ }
+	{ }
 };
 MODULE_DEVICE_TABLE(of, hisi_spi_nor_dt_ids);
 
diff --git a/drivers/mtd/spi-nor/controllers/nxp-spifi.c b/drivers/mtd/spi-nor/controllers/nxp-spifi.c
index 30fe2d414f07..71ee50eb1a71 100644
--- a/drivers/mtd/spi-nor/controllers/nxp-spifi.c
+++ b/drivers/mtd/spi-nor/controllers/nxp-spifi.c
@@ -440,7 +440,7 @@ static void nxp_spifi_remove(struct platform_device *pdev)
 
 static const struct of_device_id nxp_spifi_match[] = {
 	{.compatible = "nxp,lpc1773-spifi"},
-	{ /* sentinel */ }
+	{ }
 };
 MODULE_DEVICE_TABLE(of, nxp_spifi_match);
 

-- 
2.53.0


