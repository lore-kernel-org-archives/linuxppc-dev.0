Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A0E606A321
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2026 21:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20260707.gappssmtp.com header.i=@thegoodpenguin-co-uk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Sf9nqQRJ
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZY676wSzz2ySV;
	Thu, 26 Nov 2026 08:41:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::436"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795624128;
	cv=none; b=LFpls4TQwHgpOGI1T/KEpB0BeGZUdsjPwIhxONOe+mFkrpfSp8QjoCI0THl/LkcvzxYO07B6A/xfJ8QZn+cB1Zu4XYsNAVd0S7cz3beGriIGJ67mWw3SwfWeJOEaElO+mEPyGBxsB0rP0U6ixKYjV4CO8JuYXFIM6PbV9fGsrP0N1ugF9CkoJgdDapWeCwQNgH5icZUfegNqd87JtbhvzPa35kJWvsQOKBpKbe2QOdv34lhtUDCK7TQTQRJb3w3wbzfLqkxnidbKJbhUTggJ3y/TEB+JcAltK7UHshj/+X0iOYd57+bNWehPsUy4Kg2THydr/H3YXXd9mOMtRg3YbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795624128; c=relaxed/relaxed;
	bh=+9nhx36rv66fiz/y7GxdJ9BH6dutjbJDQmWR3T0evLU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KxqiMAkbUv3IKLKWuUC/NbDspT28nIU6F2mfeJgEH3iQrWQchq4bcOyuKQXImum6NSKfxLV7d7+Nhuq89nDOXQ9lF3Ey2yc8fJzY9Y2YBiqq6+9vCyK/CJGs55XC/WE1tBU7lYIGwF42aESWKtEzL9IduxKOdBNda9JVu4HDPGsUpYnkUqgnmYjqwBGcdb+iyGVyZ8uMr4ngs7Z3Qt0HD9T3sY+bcAa7xWJQ5Lb5OmwhJBFe5RZI9kDhjpm9h7/oaMYkh/fYl0skAO3D8RIK72fzP06JJvKVce3bZf3irQgN1RISUCappX6jBLdUKU/c5rSceQ2xIbi1qGQSLADe6Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; dkim=pass (2048-bit key; unprotected) header.d=thegoodpenguin-co-uk.20260707.gappssmtp.com header.i=@thegoodpenguin-co-uk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Sf9nqQRJ; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::436; helo=mail-wr1-x436.google.com; envelope-from=pzalewski@thegoodpenguin.co.uk; receiver=lists.ozlabs.org) smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=thegoodpenguin-co-uk.20260707.gappssmtp.com header.i=@thegoodpenguin-co-uk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Sf9nqQRJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=thegoodpenguin.co.uk (client-ip=2a00:1450:4864:20::436; helo=mail-wr1-x436.google.com; envelope-from=pzalewski@thegoodpenguin.co.uk; receiver=lists.ozlabs.org)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZQ9C2KRLz2xLg
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 03:28:47 +1100 (AEDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-48e09aa5264so3475677f8f.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2026 08:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20260707.gappssmtp.com; s=20260707; t=1795624124; x=1796228924; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+9nhx36rv66fiz/y7GxdJ9BH6dutjbJDQmWR3T0evLU=;
        b=Sf9nqQRJIscVVePAkGbKFo/B1uXrBItxQvrRIOnPPdz19rAY3sgj8A4EgPFDkb+vxu
         o+Ak/vu5FA03ERGP9YUp/DGpWKROI2K3BGjNq9+nvlEErUTKhLVgOHFozXaXhmTdlG1o
         egxoqiNP81n93uBQ6qC34NSzCilmQwSM/qdx6wXPMFh+XeF+O4MV5VDcyc/eR8gZFILB
         RqNY6se5xmxyj29hPUaVzF4LrGb7cMtaw5rkKXQ0/vn/acqlxXCI/hokkpX8OSfJJWhD
         AfiSvpmTXURO2lFK0EknKH9ktiWnstbzJAoMrcrR30WFCo2/jkZ8UfNBTB0f5c9C8oJ1
         7ULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795624124; x=1796228924;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+9nhx36rv66fiz/y7GxdJ9BH6dutjbJDQmWR3T0evLU=;
        b=lR47UCj+6rUiWrMGDxCsf3HvEpk88Lx8lxDW8kSRaB4H8NU3Yx44yxItHe9ZeR8RjW
         ARsxkl3hz4IXekBHShpPxyJEaF24IkDbuOjXiPA3iRjxXVaKfpFKV1Yk99wJJUF2lMvA
         ypwWR78NBjEe/PRfNWeyVkDFhPxKkfHRKS0Uop4Z6gn0ncgZHAbVZip9swZPY+ghrzYk
         13ordFR09BN8FhckvN2UEf+STQqMCMyW+Gvlz5i7EXNPrOOvMym99x4Z8iXqIZl1favN
         s6GqHp6DUYwLd1eb0CmInnCR1MSpgrh8xtxiJt0J3VR7Y5X0UhTng4MRCbmS5fF6c+Xh
         hTKA==
X-Forwarded-Encrypted: i=1; AL+hErF6HY/84weR6wdTeiSjHK5xWJepcWwQQtA9LoRbhOiH5RvP//XquDVEAGWgqzSVu+3cJ4iQ9nnPCRrzKGk=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9cQeVt8NleF57uoi+gdaWrmC4LmgmdPjXIk/xhcTjWfvu6+OGy
	DvVwfoeVQG8O560QeSC5jyTziQDBo9RhsU/oRWc0EBpVlYWLIF6OayhymZvpaoiQI2Y=
X-Gm-Gg: AZFdTZcJaK5GT3wlbjts349XDDgBfEGegObS3IMppiqn0j+Gp5LL0p6YEZSBNgUE+fc
	vvI8vq9iNlPlC1L4slH8CTyP2QuN+1GvvU461fZC4Jm5qiHjzdUFFaTDxO1HIPmDSIkSeaerzyd
	zeC1dNDcvafjMDf6eGpV8Z/vyNzO/4xYetDhTagzvSVv2NxncX3c8vtMx63OOVcv4HKGr6ANGXk
	WZ9p+zJiGQfY6QNz8e1MeWhmvXLCKpa6CFTSvu7cnKMVDj+PgCdwrEydfy3yHR6hTyQzaUr6/h9
	5vUxdrzLW4A5EePdcanE6xscTaduhVh7mJY+GYiE+LUAeoPXJwo8lrJ9PkfX/Q7eOXM2+revskl
	Ozi1eAcW9EMFY8h1ewutq6ycBaDM5Cl8X27bH81gs+wbom+iEt6H94ASwgjT3oncIxdOAQzcs3A
	ECS20OMD8OGH5iX3g/ip/ByacLPc5QqTHFRVNFwMJqaGo9kCVX8Fxdf53kyZQXMgwwxHxW/hfqv
	2hE9b2Qwv5C3/buR1a9g9dhYbvGqDGu4dDuDN5LLtQ04IPhi9n4hytMZWr8K+dll7eJBev7NM2w
	CnClaSs7+PLHJ2dXutKuVtP52nn3sCiEpccZYCs5ukd09A==
X-Received: by 2002:a05:600c:848d:b0:4a5:1cf1:b7bd with SMTP id 5b1f17b1804b1-4bb88810b2dmr361648545e9.16.1795624123960;
        Wed, 25 Nov 2026 08:28:43 -0800 (PST)
Received: from [10.42.0.1] ([2a00:23c7:1d1a:9c01:f716:ba19:8aaa:f1c2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853368d3sm527336375e9.1.2026.11.25.08.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 08:28:43 -0800 (PST)
From: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
Date: Wed, 25 Nov 2026 16:28:29 +0000
Subject: [PATCH 03/10] mtd: maps: int0800: Use named initializers for
 acpi_device_id
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
Message-Id: <20261125-acpi-mtd-v1-3-42ad2f645bee@thegoodpenguin.co.uk>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795624113; l=833;
 i=pzalewski@thegoodpenguin.co.uk; s=20260430; h=from:subject:message-id;
 bh=blggJzzi34PPFng5frzDjV1f6bR0P7BZrevZFLsW314=;
 b=ZHZnM3Lf8DzUboiERoH/ypcNIiAQvRVlt4l5CMlhz7vJ+CymRE50z5L8UPm9qLmBzcXPpEYvV
 3V+SKJgc8HhAzjwEkWT9COXnLzIMM7NmIiKpGWF+rOcWTSAb6lbGtOg
X-Developer-Key: i=pzalewski@thegoodpenguin.co.uk; a=ed25519;
 pk=vHq4n9IonORH2GTzLv8r6CWAFHzgfBuNkQPXA8NSly0=
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Use a designated initializer for the acpi_device_id fields which makes the
code more readable and consistent with how lists are initialized in the
rest of the kernel code base. Also drop explicitly setting fields to 0
where it is redundant.

Signed-off-by: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
---
 drivers/mtd/maps/int0800.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/maps/int0800.c b/drivers/mtd/maps/int0800.c
index 1f5a7c4936dd..feb721908989 100644
--- a/drivers/mtd/maps/int0800.c
+++ b/drivers/mtd/maps/int0800.c
@@ -88,7 +88,7 @@ static void int0800_remove(struct platform_device *pdev)
 }
 
 static const struct acpi_device_id int0800_ids[] = {
-	{ "INT0800", 0 },
+	{ .id = "INT0800" },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, int0800_ids);

-- 
2.53.0


