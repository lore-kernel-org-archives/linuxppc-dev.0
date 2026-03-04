Return-Path: <linuxppc-dev+bounces-17749-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9C59EFCE41
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Mar 2026 19:56:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fR3MY6VGTz3cDS;
	Thu, 05 Mar 2026 06:56:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1029"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772633708;
	cv=none; b=b/gmjhW+5yTJJmuX5Z7+OzPO4zTA0aP8eSPTZEI5QWxFkXIquO+sDTLyQVoaMoUROJK4PznUHxvmaYxKNlbRHoKfq/C0z5qesu6JboRtvbGRATPF9RV7Aq8KCo5fW5gHEvvBD7J8b+Zj7DTv3zdLgGtiM8K2iLB6fq5z0Xa8mgKOs6Smz/rfkik/pLk2hUgJVHARcBpu6FMkf/dJKNVlidg1nD95PtuM+h7spXqchLeHdfV6q6OpG4WwfIT9tXsqOpDiADoSBGXkWKt87tHREhVPL78WFmgOlHDomPbxe6hQUe6sKQ/IZu9WCV4kN7yXhKnOvq5w5UPF+G1lgOJI8g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772633708; c=relaxed/relaxed;
	bh=9OBV1g9f6o6sz6h2YLW6cb0WqXaVph12Op+HL554xjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lKgjVCb3gITClZPh86oehnVuqLl7ERaSLLzavW5FF93C8Z2/DgVnrfXelx35q8h68ZnjMIp3l3VBdx4xkuZYbbeesH7UUdq3dQugY1j+jYyt6MUuA2oSpMYk9a2nTB+Qq/ISGrHqXt5aSLESYy5aer/4gRrlysHhsP+3jzl2aObiHdJi2ZLZGroaYO7FP9TjEVNvkFLEH9n2TSf5InW9P5u27AHT1KGc+odTm6AAj0wbK54O5uq2d4R4ej2OCA9vilNPv9ceTzUEXd0WhbvkhvwWNIjW0lXKg3ZHX/S0/TiV9fmJRog81uVRv9njgg20F3q3nxvfAGsFLupen8wlJA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Ow75zy4s; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=linux.amoon@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Ow75zy4s;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=linux.amoon@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fQvnl3Bqrz3btg
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Mar 2026 01:15:06 +1100 (AEDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-3591cc98871so3035060a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Mar 2026 06:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772633705; x=1773238505; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9OBV1g9f6o6sz6h2YLW6cb0WqXaVph12Op+HL554xjY=;
        b=Ow75zy4s9l8rmh3qofbhISxz7hRj5PO/8+TDlGeC3naNZM7QiuVwRXRoWXXjEHFKu/
         jBEFeglFreglcR3KSSFiQb4aCd0NV7AT0znGEJujxSx+ggLJBT6fYN2oiX6tToa10W3H
         QlCq+5LecA3MPJjdyuABz8Y2Hz/SEe/O+sesU8c77pW2AFwqJTszk040lO+1MF18Inx8
         y4BL4HDfvghu7qZ/7ukefx1GMn5V4rUPgBSUeWXJWRHgH24D+x65tvQDhtG99dL33xfD
         hw7mYlWDETBinbv5iOQceBCV15k2vRQZxylIObQvAm8n8ygK2yAjWcRSYEBWax96uuE0
         XS6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772633705; x=1773238505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9OBV1g9f6o6sz6h2YLW6cb0WqXaVph12Op+HL554xjY=;
        b=fZfFqnI8O9+AG45Sw/WEoimu3CZFkVz4pASPnbgg7b309eTU77p/dUMNX8cbE9gsr/
         hRNldHGf0MszEnUqjQQ5pimbTFstxCao3gjDe/JYVt3eN8isGBSIs/ylLROKJlXqoxYn
         JViTPhW98saCe58J3+LCAp01zea6QOAwagr5dY2tJLEDju0qMs3PND/rht5UjP7ig2Kb
         CafjPkDkxS8rLbWSpalenvUOW7xVYhqZOyK0vSYmsF0PmCh5S4Fm1Z8f8r1D/SS+ZZDX
         FT4bB7tABouxMw9psHqI7jEzPxem8jzN01/wcdw0txEnQyLX3fVkO+FoRHcJR5qgHFA1
         Zl5w==
X-Forwarded-Encrypted: i=1; AJvYcCWGCnMaLeIJY2T7Ie2nRgbEgQvZAVJosCkIZQibs6b+kbZO+Lb+M4enxtSeWKp4RNFP+KCk0dvnEkUbD9U=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yyci6OhnIJ6s0gxpHsOnfnQq+SBzuE+wrqWWkd/IUL+AYJnsLF7
	idMCTko705Jnz4TXN5BCdzofXwG3dsVbb8uU86fqAuhIbIxETdJ0N4va
X-Gm-Gg: ATEYQzzOHakrnDZomu7TKnIcor64eX1gaFHeksnHDi5YugIx9LjPBSzfALrUBcyM1aG
	FI66rIjg5TH7Sk8gi3qZ+g9F5YwS/PhfbfaYyuyE09Y9FBMdCJRwZvacdtjTw1EZnX+IxUoJVdq
	WPOK9d2iuf9tUH0RG2S1y42kWLUsQVvJAsldQBq4pj3cKyeqpqN5Dt4WEZk63appzGMWjLdAbMZ
	gH1Jn9o81e/6i6QnmRGw8GV6jXrSqX9+Fu458wVXXHOoIz/QvqZyTaNmh0r/HzFka72Cek8qq3o
	Up+biofhAqURhISDCWSa3reE92lbVWSNl16UAZ23sVvxOTHf9JQVKnmdge9InEmp+tGEUwinJo0
	/mMv6SRDXIVs5g0gFyvKpQYW7hR/65MAN2c4BM4Ut1aOkkq8OUFhFy+eGJ7+53VM5FZX4lkSSu9
	oMNBhGOqrBGg1RqnRJSzGE
X-Received: by 2002:a17:90b:164d:b0:359:964f:491b with SMTP id 98e67ed59e1d1-359a69c8cb6mr1870621a91.9.1772633704630;
        Wed, 04 Mar 2026 06:15:04 -0800 (PST)
Received: from rockpi-5b ([45.112.0.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599c4c0f80sm6826545a91.16.2026.03.04.06.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 06:15:03 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Minghuan Lian <minghuan.Lian@nxp.com>,
	Mingkai Hu <mingkai.hu@nxp.com>,
	Roy Zang <roy.zang@nxp.com>,
	Yue Wang <yue.wang@Amlogic.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Jonathan Chocron <jonnyc@amazon.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Paul Walmsley <pjw@kernel.org>,
	Greentime Hu <greentime.hu@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Chuanhua Lei <lchuanhua@maxlinear.com>,
	Srikanth Thokala <srikanth.thokala@intel.com>,
	Xiaowei Song <songxiaowei@hisilicon.com>,
	Binghui Wang <wangbinghui@hisilicon.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Niklas Cassel <cassel@kernel.org>,
	Koichiro Den <den@valinux.co.jp>,
	Hans Zhang <18255117159@163.com>,
	Qianfeng Rong <rongqianfeng@vivo.com>,
	Sai Krishna Musham <sai.krishna.musham@amd.com>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Nagarjuna Kristam <nkristam@nvidia.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	linux-omap@vger.kernel.org (open list:PCI DRIVER FOR TI DRA7XX/J721E),
	linux-pci@vger.kernel.org (open list:PCI DRIVER FOR TI DRA7XX/J721E),
	linux-arm-kernel@lists.infradead.org (moderated list:PCI DRIVER FOR TI DRA7XX/J721E),
	linux-kernel@vger.kernel.org (open list),
	linux-samsung-soc@vger.kernel.org (open list:PCI DRIVER FOR SAMSUNG EXYNOS),
	linuxppc-dev@lists.ozlabs.org (open list:PCI DRIVER FOR FREESCALE LAYERSCAPE),
	imx@lists.linux.dev (open list:PCI DRIVER FOR FREESCALE LAYERSCAPE),
	linux-amlogic@lists.infradead.org (open list:PCIE DRIVER FOR AMLOGIC MESON),
	linux-arm-kernel@axis.com (open list:PCIE DRIVER FOR AXIS ARTPEC),
	sophgo@lists.linux.dev (open list:SOPHGO DEVICETREES and DRIVERS),
	linux-tegra@vger.kernel.org (open list:TEGRA ARCHITECTURE SUPPORT),
	linux-riscv@lists.infradead.org (open list:SIFIVE DRIVERS:Keyword:fu[57]40)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [RFC v1 14/18] PCI: meson: Allow asynchronous probing for background link training
Date: Wed,  4 Mar 2026 19:21:57 +0530
Message-ID: <20260304140329.7089-15-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260304140329.7089-1-linux.amoon@gmail.com>
References: <20260304140329.7089-1-linux.amoon@gmail.com>
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Establishing a PCIe link can take a while, allow asynchronous probing so
that link establishment can happen in the background while other devices
are being probed.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/pci/controller/dwc/pci-meson.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
index 0694084f612b..280146f7b783 100644
--- a/drivers/pci/controller/dwc/pci-meson.c
+++ b/drivers/pci/controller/dwc/pci-meson.c
@@ -467,6 +467,7 @@ static struct platform_driver meson_pcie_driver = {
 	.driver = {
 		.name = "meson-pcie",
 		.of_match_table = meson_pcie_of_match,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
 
-- 
2.50.1


