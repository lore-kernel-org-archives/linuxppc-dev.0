Return-Path: <linuxppc-dev+bounces-17737-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AD55EFCE37
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Mar 2026 19:54:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fR3Kb5vk1z3c40;
	Thu, 05 Mar 2026 06:54:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::532"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772633125;
	cv=none; b=R5PUBWx8Gm0YwSGi5is3X1uDhvaMpFSN7wxu48Fdfr4OMN7KJ6pWGimsZJtHIIv7SL9vkjoxisZhZ1OYGtEw/4TAtXsfzrcFsgHZ6lFfsLPJ2u8Kx6b4PFYRQPMAP89h3y7D9c5DXBWGLRmn/XNSGi84TAV1fFC9iFx3kdxBeIchqVI20I5rXFBIOUjA3HqYtfpdVC+bs43z7OG8z0e3/WnjNtniJ7ShRD6cvY776KywAVsgYODzwKSrJ33FyJy3drDdpKDMvX2P3qM3qvlNgd0soVjqDSv83Yf6g+xYScLAlg0ezCB7gUnjt6EBe5yE589CbEwj7pyyR95VaOfgrw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772633125; c=relaxed/relaxed;
	bh=stXnR5qjp5uF3thkM7E5eM57o30r+czgE7QYCN26U3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cfroFzjvLDVMhORP9t2jPJNTQOsaVhBtCB3L0DxniIlEVDONvFSpozFXytaRi2O4O3Fk6D8WPoVxcVIemi94LyX60r6s5jI7vz7jSLwoQiL8UgM9QcHK6MzTZ+6hodXHJ4Q2Vmht5628bHIOlych6BRo2eWJvTypq793LPkfzjR+rk+F47A+GXOujtQtl2m8zcdIr9WUaSEUsCuKUIHMgm23PGeuWYLncX6blOn8AgJcJdEX/Dh/FLqIqnA0SxADWFbSKEpkwAN2gc3vHjb7NucIDXDHrw37/je/ozevCeA3kjWC1oZgaUzoVVmyhrBYXqPA3FftUXP1vsyDbAXr3A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=kYJ9HcNW; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::532; helo=mail-pg1-x532.google.com; envelope-from=linux.amoon@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=kYJ9HcNW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::532; helo=mail-pg1-x532.google.com; envelope-from=linux.amoon@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fQvZX1krdz3btg
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Mar 2026 01:05:24 +1100 (AEDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-c7377119453so327712a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Mar 2026 06:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772633122; x=1773237922; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=stXnR5qjp5uF3thkM7E5eM57o30r+czgE7QYCN26U3c=;
        b=kYJ9HcNWK9kieuM9L11ofFI/NB9Wu6tiWYPNPNiA5vigGMyjQ3NvmVucV9pVKR6HIH
         ui6ObZd8U6esvYgARQG4nn/hjFQ3gnQjEVMKR6GkXIayGHkknbC9m5cMyBvr/okUmRBO
         VjI/epB1yuf0jAadmTMVyk+u6GKfKoCqyfKnJQHHL9+tT3qG0srTOfBHxUZb6VyZm89p
         RX4j1cIt04dHXnVHZ3fgMk0HURaR46leQucHNpni6cpQgirCWR9ru1bYYosmUU9U42+S
         hZIA+jBbVEwEP6Uh7p3xSUjU7PzCvSuwSKfm4la0ooxhDCiJ9P96znqUpB7mut4gEJkI
         zjvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772633122; x=1773237922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=stXnR5qjp5uF3thkM7E5eM57o30r+czgE7QYCN26U3c=;
        b=bgcxoxo/94McQn15TuN/60j6+qGuErKNUnPAUXxRjJdpQ2PFicuPuzCzgPMVKFTulo
         J+FEBIYMYKGe6SR7GHE/PSSeaoovFCDXMR0X4WwIWRdo+ZhMSzu2oj+Dvp10Z/b/U5WK
         5KwfmYpYaYGeCKbmYDbLnucg6fdi07V6K15w3ptlkIebI7ZTnQk9At6vJue7WklR+JSa
         MPSzBIE6n7tUuOQaXy7dFpTAfIeLYcBmBFL0Yt/JHRoeUuuD+3MuLlk8PUOD+dyLIUWo
         SOYQJYoboDMRqhtPjloCusI1fDWzg7rcWI46wLbtS8/x4L+spZW/RXjrh108pU9ircna
         v+/g==
X-Forwarded-Encrypted: i=1; AJvYcCW7efuUCNbrF22O9ER94LFytPpN3ghnfIWWbOxx8s/C9sZwBAubrLLUFmbdJxPSz2fs7jsSGFZHPkMOEis=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzeGV10bzi3+A9ElgwplO0J+QuUI48SQeyUvJN4UcLsxtsl4tPc
	rVToB6l4V3KYJlxXmmwPaypBDIaPDyPAfJgHznLubwmb9XteJMLC2SjP
X-Gm-Gg: ATEYQzzbK+Xt+5SA5j9kOdk2p3Vhbu5EIWZspoqUTDKAokS5HNOhzs2U166pROqqwAf
	0cpIqxuAQyY1kF1yoSNeC6FiYLD8K/KTdCGulGETHrCLrt19a+zqy8bgEN8HGkNiY+h26G1WWWE
	bBH2akZcF270Y3qI1dZXNNo7pJdlfVSDAMm0CI5MJsZOSctbiZxCUTlx1i3cRz5/CT2V8q7NC2I
	7saIHTd5IALiU8xtcdGj91OVlDp0al7SUwo6ABt/GCusfYoekrTYzaetBvQpU3uL9xJ7x0s43QZ
	KgMcxvhrKc2RR7C3hYRZPXsrtH048qtCAme0yXWiOB+/qrJRKqQSr2dXU/3oL9VULH2cxOgJ//H
	lQ5d31w8gbe/KAcZI+Y4vuUg5foaMZBkpRgjXqrYPaxep22lmwb2Wuh6RFxuVsrm2c1DXHbzhcR
	9AyeiDeutsrEzmcYpVU0q0vlezaskiB24=
X-Received: by 2002:a17:90a:d405:b0:359:8f4b:6ed5 with SMTP id 98e67ed59e1d1-359a69d424cmr1769092a91.15.1772633122198;
        Wed, 04 Mar 2026 06:05:22 -0800 (PST)
Received: from rockpi-5b ([45.112.0.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599c4c0f80sm6826545a91.16.2026.03.04.06.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 06:05:21 -0800 (PST)
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
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Hans Zhang <18255117159@163.com>,
	Sai Krishna Musham <sai.krishna.musham@amd.com>,
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
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
Subject: [RFC v1 02/18] PCI: amd-mdb: Allow asynchronous probing for background link training
Date: Wed,  4 Mar 2026 19:21:45 +0530
Message-ID: <20260304140329.7089-3-linux.amoon@gmail.com>
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
 drivers/pci/controller/dwc/pcie-amd-mdb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-amd-mdb.c b/drivers/pci/controller/dwc/pcie-amd-mdb.c
index 3c6e837465bb..3da5ceac9b6a 100644
--- a/drivers/pci/controller/dwc/pcie-amd-mdb.c
+++ b/drivers/pci/controller/dwc/pcie-amd-mdb.c
@@ -519,6 +519,7 @@ static struct platform_driver amd_mdb_pcie_driver = {
 		.name	= "amd-mdb-pcie",
 		.of_match_table = amd_mdb_pcie_of_match,
 		.suppress_bind_attrs = true,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe = amd_mdb_pcie_probe,
 };
-- 
2.50.1


