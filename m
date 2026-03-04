Return-Path: <linuxppc-dev+bounces-17752-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F801EFCE41
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Mar 2026 19:56:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fR3My0cW7z3cDt;
	Thu, 05 Mar 2026 06:56:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772633851;
	cv=none; b=R4NsmiBqVANmTWnAsgkFyrpFfvdLh8bBOcT4CiUgz4vCVLx41Ku8L3Kj/jneqvrFCBnSQI55MWRRMGeJCzqamtg13M3tTPqZL2AyIsxsVgeoKBkCl1qUVEYuPiU7QdmoGXHZEG9LyX57fmBi9OtXZG+D9l4o7Kq93lYswkqj7mNQpxGHZjGHROB497O6WBRodAeY+/zsA6HUa+EoMN/R2XKwPrBBsrG5w806isfHAXqOqh2iwXe4/xxfi9Bbc0OhezZZSldbKwcIW3bK3lPR3kOu2RbT2+NNwif/nAWliEm9TGr/bnCOELDY5WqmYwBVyam+9irmF0yTuYYtB+86HA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772633851; c=relaxed/relaxed;
	bh=srUiyLQpcPURMgpIQ/orm3Jjpyz5IeQj0sKin7gLX5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WofVNM7jkuomrZ0zCLEYW3y1kMYrRAJMBmxrLolk33s/+CgGVv9+9ocdLWGxVbD2biNEV/dOJyz3hwh+8S919KeGTuIbAWSuP07ZTJH1ygdiKvU8f2rX7IU5rajr2M/OZFUf8fI3x03hzpVhHh450/HF4bIYooqp3X8nQqEVqbbq/hxMpp7eBh7/iQEi/3lEXQtDsd43HK6gMYyVFi3SfTc/mTSoOSKKWkLHij9LI/Zx7OQqH3eiKTcc0vV4r2UmxOA2t7yJqIsBbK6BI3l7irwtAAF9ZdvHcT2CqbFrIkD9VloZaAqzCv0WGSYcxo0NOgRZGUw2HxuGesPM0oMRlA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=ep1bLddY; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com; envelope-from=linux.amoon@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=ep1bLddY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com; envelope-from=linux.amoon@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fQvrV5kJyz3btg
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Mar 2026 01:17:30 +1100 (AEDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-3597fea200dso2821832a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Mar 2026 06:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772633849; x=1773238649; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=srUiyLQpcPURMgpIQ/orm3Jjpyz5IeQj0sKin7gLX5c=;
        b=ep1bLddYGPuRDHbkGXw7LDiLqs80u6nVaemHWwkqeB6Icgvaq4xgYTODpqn0PAOV6D
         x8stkEudVz83588fZlSS21seLVgKUglp6dDvY7FVg7b0hIisy8k9zIz9UEl3Vv1VUlFx
         KGp0vKYVrGzJICzwpPVgxkfigvpV234ml6jzgQOcAdQehQ6fpLwahEYjLbOkyAR4eFKi
         q6jC36u2KwAfykF7VVSqBfj9fy50C2LhVLuuUxxaV+6qLNGIVqwrYvqkefGTNGHoDegz
         PSetFdfaKpwVF3q+e1scJ0vVPmMlKtGfsdLvULMXrX7P7WGzMcq3B750Q+0S8IUNhPC6
         HEnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772633849; x=1773238649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=srUiyLQpcPURMgpIQ/orm3Jjpyz5IeQj0sKin7gLX5c=;
        b=FBSA74I26JsKqCQdzdf0c2t+Mr2fgQmS2sOoVVSLwTM5JV1+waolDns6kQs6wWLVof
         XyZ+hkmM/UE3IlyDX3uSn6cmi6yjhp22AYo1+EYRwJ2S9TdXVi1lWd6x7KdrOzjk3RZa
         9scdMuOgp55oDCLd2hhcAPe96jTuxQ0oxI0wl9t/picacRjLCOVnFkGFewXmrjLu2eRS
         7GXwfdzRa4Vd6gZ4qIZVdonQPA7ghi0sYuCiFpIg9zRgG9ZACH37YcqpoPx16Z4ocLMt
         Ipys30uSnzy6Y6aHcx72pW8bNJrocuareS7eXi963wTxSbKW39NobiZe4h1ncHE5L56A
         aMrw==
X-Forwarded-Encrypted: i=1; AJvYcCU/mvCinHUoL268+b3ARKtlXjdUIVNLPfk1/VqU09t9qU/Wk+C96iHHd+sFuf/pwsCcqX95IHID0GCqfg8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzRLVUoYy24BHh/3TE+/UJtjItQIL4xsYg3hoRf8EdGsKVeBJKT
	tr7vkrlY4WAAblljuM/q0H3M/MXElD4e+5hGtBdb/R+0Tx3TCvTTNi40
X-Gm-Gg: ATEYQzwJDtgH9slZ8hyDfUzCPA0tXWdCjyKuE4akd6RniUbUL8kH+8YNFXkThgYJOdv
	jT4dYERKiul7iJ/1qo98w1qmfF7/2mTogXFPuL+xXIo6jYqrsNw5xeVOmSVshHNmwtV6uahsSop
	4coH8FjQE61f9RTmi+QkZyghwlxTHqAM5pf+LB9Jhgmp9lYmPLkNQLh2ITvFyl+QnzqnpCFOvnN
	Z6A8G2v2I7el7QrEMJvXHxHbLSPKXrqUEPnsoctDRh8VSE6w8thZBdnJLfB+r0WqIs8nALmroK3
	RrD5ij/hxmM3YQqDf9McjV38M+qfTAE0tX5oj4XcUjXTr078T4ctl8ru/cKyaFjW7igyVBOThnO
	QYp2p1TH/pXRfhsG9yOy+vOKgDDpyytgvfbjuovFcWwpABAZpF8yfbIwWYdiMBID3ErRU7z9BK2
	2wRCEyENIopOBVQDDctM0I
X-Received: by 2002:a17:90a:d2ce:b0:359:849a:7357 with SMTP id 98e67ed59e1d1-359a6a3bc3cmr1764561a91.20.1772633849089;
        Wed, 04 Mar 2026 06:17:29 -0800 (PST)
Received: from rockpi-5b ([45.112.0.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599c4c0f80sm6826545a91.16.2026.03.04.06.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 06:17:28 -0800 (PST)
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
	Qianfeng Rong <rongqianfeng@vivo.com>,
	Koichiro Den <den@valinux.co.jp>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Hans Zhang <18255117159@163.com>,
	Sai Krishna Musham <sai.krishna.musham@amd.com>,
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	Frank Li <Frank.Li@nxp.com>,
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
Subject: [RFC v1 17/18] PCI: uniphier: Allow asynchronous probing for background link training
Date: Wed,  4 Mar 2026 19:22:00 +0530
Message-ID: <20260304140329.7089-18-linux.amoon@gmail.com>
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
 drivers/pci/controller/dwc/pcie-uniphier.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-uniphier.c b/drivers/pci/controller/dwc/pcie-uniphier.c
index 297e7a3d9b36..53f3bc9f5ba7 100644
--- a/drivers/pci/controller/dwc/pcie-uniphier.c
+++ b/drivers/pci/controller/dwc/pcie-uniphier.c
@@ -404,6 +404,7 @@ static struct platform_driver uniphier_pcie_driver = {
 	.driver = {
 		.name = "uniphier-pcie",
 		.of_match_table = uniphier_pcie_match,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
 builtin_platform_driver(uniphier_pcie_driver);
-- 
2.50.1


