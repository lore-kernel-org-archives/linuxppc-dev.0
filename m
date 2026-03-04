Return-Path: <linuxppc-dev+bounces-17738-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B910EFCE37
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Mar 2026 19:54:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fR3Kq6Z5Fz3c8x;
	Thu, 05 Mar 2026 06:54:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1031"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772633173;
	cv=none; b=Eya6l2zNLBTqP7LnRpnYghhotnCTJwZcBdA7IcfjzHUIrdVlebUkMcmJhtGJ8RKDDaychXglx+qaxM+pKsdGDP+EK1XmWQj5MhH1lm+wfGt7NMWHvTIvy8UhmAKBY1TyUs0kY2HhoGKM1Et8tlIr4GIgOA+PPsOpVLybg5+cUcC/J0FCkwpYhr8Egw32Amp2dfG70c68mHiBQA+7Mb06PlxWInKut/LidJkcNWM4ZnMVwT9yoV+FsS/q6z5tdlaqsBHC7i6TTF62HUJD0f5J6T3EzbT2kvcMEF4y1Gmo3nETRXOl7uNGCAevQibb5enPW/Tseu3jhojbEgeehrNrkg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772633173; c=relaxed/relaxed;
	bh=Z0IbpkKbOUqAD3sb0v/7e7VSuY+QqYVSN65hjbLO7Ig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J2iNmoFj2z3EJbNcmmMrOjersj0GzB5lbJU/UEIAOJ14eCYMx9iaONcGfUv5iiBmNKMVGQjroRDnLx0V8i94OudckUcNEsltRAKfG5ZvQ50idC9w67PHVHpGqxiLi0s5qXiggAc0VXJFn4wOfE1OCPXuYbsDIOJbkzjRh7PgAMFEfTIo+Tr1MhHLKmMMdqdh9WOr8HZkOAJnU/Edo81mKta9a6Tt1GAtVBMiNVpkBFhU/q8q9xCF3Q0sOZT3YLoq8NJjmc71b0NmBL+g/3PiNtL4RHeN6Jb8/1iL6Htq8dADKdl45NMVclOxl8yXkiSN9TWzrRb1K7AFtKzhxGgokA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=WMtzGlBI; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=linux.amoon@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=WMtzGlBI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=linux.amoon@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fQvbT1D9Jz3btg
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Mar 2026 01:06:13 +1100 (AEDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-359863611faso1496698a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Mar 2026 06:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772633171; x=1773237971; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z0IbpkKbOUqAD3sb0v/7e7VSuY+QqYVSN65hjbLO7Ig=;
        b=WMtzGlBIQKnd40R2TSp6H6yNK/EpFIQ2qi41iKID+my+xJOq7DMpZmrzdbTZuQ2k3C
         USeSnNHL/Q7B/AZp1Jv96E7sJHf7yPQn0i5SJNqTf/nPnQts8TFoSryvIvdWpUQO2b5e
         0F9uxeJB4pMAhIZxr1iEZqCr/uAqJB9PlqNJv7d6z5S/NHi7r1uDchrlgyhEVDXAanET
         GrbES7jsN2Gf9HBeoBI+e+VFi3turDmYkR9pCXoDSglNEKeQK3Z9lIkXfmoK9DKoOwM4
         mge0TEIItOBRvMl71BLanth3YxqRyfN+9z3ee5bAGDVzeLRdri8QMQavQcqN9AWKDSxw
         TPVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772633171; x=1773237971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z0IbpkKbOUqAD3sb0v/7e7VSuY+QqYVSN65hjbLO7Ig=;
        b=pHOH+9FTMKqzNf1rTvW3l7A/MSaf7vREb25xGMHWnS3MtNYvx8NdN4Qi//+PHBF5iY
         Ktreq85jI8WjiRgBS/I/AGTqsc/OVFW2NvBe7mkCxVAbaOTmS85/cZatnmHRM7DuWj1O
         GYYmUVtQiPyzT6aUi6hqzamJcxrmBYbAjgu7jdZLLpgtMgJFOxrHLFv9kXrHciDZGfcq
         38iAnem75lYfLeUcYL/YGjm7OmfpKii7CsQ9l8VkxyDILo5pNoLycFYFgigg3MVFYgWo
         fuxB4PWcIoQZ02FR6cgMGgVacMvGQiZfrrMsxB9DioV9PaArCccWIm+M3+mvFIh8pJXq
         csOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKCOhHH95IRL9BsEujt7qOoxyIFHM5g0IRizv7bje85Xd7Z6nTIitbwNibf1hLn6x0UrwkiBFDKzSgyeE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyaJEhqoa1tTv34MQp6cpNVOMC11uIWnedmJJEqL64Xz/QHgXtK
	l1UaikTbGJnZt00fdZJvu/nXAh8kxEc+P0jEbuEPcsqLHQ7UgWI6eFEJ
X-Gm-Gg: ATEYQzwHZ9p1+523depK4yulayNz7+p2h3G4+TN2QiPUCsDGbLWE3Ljp8KY2lyMQM+A
	CMtKlhAjUL0gtWS+uAxyulieRuL8S1hgGJ9xePzlBGjSpQ54KPguvZNJqJfjAZpy9BpO2qQRsjN
	+GHerjUs23VV21FfxWYI15uTwQFQIUumq+wHLLXhOYkcDpqN/GGSO94qff//lQ48jk9AZIWsDDE
	Kj+fIAwYUxYU04LhYFiC0FlPhtPySNVWcZNeVAnTp+qYzJRXtu+xcUdl/RiAcyQUV8aMFpCsqNz
	x8pwyByCs4EM4qMw8LHkueywR2pepmDN+/xXFm5Y6/gP7Q6OxMOkv4U0LzxBJXwK2SXIZ+mbHC9
	c+GwTZjg7oXP/bk16W1G7M1aLNMyXot2MREaJ6M7VUB5LNgx5G8M/QbkzBd+mbmW8QDXYjsZgl+
	x2FCDTo9wNugKYgvEDTkn/HpyiYUEGPP0=
X-Received: by 2002:a17:90b:2888:b0:359:7906:d996 with SMTP id 98e67ed59e1d1-359a6a66a94mr2076415a91.23.1772633171145;
        Wed, 04 Mar 2026 06:06:11 -0800 (PST)
Received: from rockpi-5b ([45.112.0.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599c4c0f80sm6826545a91.16.2026.03.04.06.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 06:06:09 -0800 (PST)
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
	Hans Zhang <18255117159@163.com>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	Sai Krishna Musham <sai.krishna.musham@amd.com>,
	Koichiro Den <den@valinux.co.jp>,
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
Subject: [RFC v1 03/18] PCI: armada8x: Allow asynchronous probing for background link training
Date: Wed,  4 Mar 2026 19:21:46 +0530
Message-ID: <20260304140329.7089-4-linux.amoon@gmail.com>
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
 drivers/pci/controller/dwc/pcie-armada8k.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-armada8k.c b/drivers/pci/controller/dwc/pcie-armada8k.c
index c2650fd0d458..ffb5554a2a8d 100644
--- a/drivers/pci/controller/dwc/pcie-armada8k.c
+++ b/drivers/pci/controller/dwc/pcie-armada8k.c
@@ -344,6 +344,7 @@ static struct platform_driver armada8k_pcie_driver = {
 		.name	= "armada8k-pcie",
 		.of_match_table = armada8k_pcie_of_match,
 		.suppress_bind_attrs = true,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
 builtin_platform_driver(armada8k_pcie_driver);
-- 
2.50.1


