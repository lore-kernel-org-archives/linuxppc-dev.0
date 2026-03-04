Return-Path: <linuxppc-dev+bounces-17739-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33CC9EFCE37
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Mar 2026 19:55:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fR3Ky55wXz3c2k;
	Thu, 05 Mar 2026 06:55:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1029"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772633221;
	cv=none; b=iJZxXWV7xUyZwxcEemh6ta4jn6exHs7cXaxXYnqKkQGD1hC3G9R4JMla+MNpHtvrmmepDZgraun2d1o8GfWD9K5KTk6Oce+wYmDsZAI8IlWzr+54OCbOLRrssWNZsV4qVc9MWDmSQ9XXg62TREVkvJq6fcPqU9zBdVDd5POJS+gQ8+U9nZNf162T8KIWNT2kgSHy+XaPx+8NLsB9+d17mY6fV5cvtG+SKAxyRs66vNTSX1bQWMFSKJ4rLPwO6aW2L4ohhhTj6hrnPa82NbA1myC9w2kqE95B4hbsg55xpFDXdz9Lg+RGqGLxikOTUkuunyMp4WQ4OSmWQZwjOMdYbA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772633221; c=relaxed/relaxed;
	bh=9GDiK7aQGiQOGUD0oRaiplszyhTYrKMycTga1oNn5ks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S7M+pMHjwXFOVxJNR8X7HZF+WKtnJKlaA1zKMu+G2t+KJWjNk1axxDHt02RVHVrmlBiGb94NdVuPSZbWbLOP9doLUgStrJNVYHd5tjtUpa0A770RoH2jmoLxEueCW8iJJ73GuPxe9gOUk/br1THeO0/+e6xpj8bWy6LtMJyh4q871p/GMFZ5Z9tfdJYUgcbloIqUFA7wtEXGD/FgyPqqWUNV7DAh0W+ZrPvKBXv6N0bhXOfqRnPyDfShI5qdwY4XKlFp8O4EHcavmkNbi1oGnQJdXG/wpoSPXoMa5bdSOH5oSpRtP9gYhOJZXCG52qb7lw0PQ21+ZMMABQ5c3oM7zQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=P/oSBXCj; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=linux.amoon@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=P/oSBXCj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=linux.amoon@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fQvcP0rjFz3btg
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Mar 2026 01:07:01 +1100 (AEDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-3597fea200dso2808163a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Mar 2026 06:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772633219; x=1773238019; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9GDiK7aQGiQOGUD0oRaiplszyhTYrKMycTga1oNn5ks=;
        b=P/oSBXCjHcxiTy/O1A6IsC/ut6qJie+427tkbuGhnJ+DaPbRGprSHAiDEJCAOoTAUz
         S8wWHp0kRNS9M5luDyBbP58RMvK17krmfsGL9ekQdjIgXIfTCwHoq5EaaXha7qSxz6D2
         Qg8FtxnDh+RfPNhMebZGjcBGZ30qzm8soLJHAiBT+Ro/3O0cKEtiPO0D4qyq6pewW742
         4KKfF4FwHcaq144ohtigerCMwr7HclPfQsexJOua6qpgkkZAduk69w/eH6SHkGrKISEB
         NyFhX67VugWj5d4OtKiW2eE8Ebdy1EPKv4lnJkSvlSHPNgupjbQhJcgi2v11k+7PGQPD
         2arA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772633219; x=1773238019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9GDiK7aQGiQOGUD0oRaiplszyhTYrKMycTga1oNn5ks=;
        b=EqaoBYxWBAuxlLz/T6i1a6H9RL7Jrdymv0TQWHy5sB5DNk8uukWhOftqv6bwQQ/JfU
         glq0/kcu+2J3B8V1/GrTfAs6FFNYCP+dKckkLbC5RcPmVgyG930d0bH0DvtidBNyGOsG
         ELhu9jiszcSka5evOed7GYxVB+mm+o1WCz0bvvesBlKPX90Pxm6rsZcZzd5v2F86jWWG
         1R7BwSxnK2HugwRCOAemmteuYNeMB0+8xAB/dTROli5A0ucWMMy10Cr5r2AU4ojQ2J1w
         T4MODc6zkE7L5syZPfgRCqRbcffSQVrRxCs1Dt9yz1aVuXxWwusd+oI22WqDFJgwq9hp
         /ABg==
X-Forwarded-Encrypted: i=1; AJvYcCVqTWrj0WytpVMloWp21Akr8LVDwSbWDWJJSAXvRpXUGF1zhdtJWiFENPXhnTmFioHrtvNSHPDhoaKHnc4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzMjj9NrpP+IGruATT/o2USUhjC3nTcNi1dPWuPjeG0TpQnJF/c
	tZxRPLSx8cfGNdtaIeLJcErgVGiPj4Ctczk0v6294top97GdIBVq6zh7
X-Gm-Gg: ATEYQzxbPOXcfbRV2ayqe+KypMeCSD+3sjfRY2drTzD6SsnV+WjgozaFaLHPxq9OqKf
	qr47Jt3AdDJkuoz5T94C//Q1FGaD2vAyygjjosm/OBQ4fnVXvyxbtW1Eg077uX5uQYftNIjw5JE
	YN2hE+AErHyoYrhU7RqSGzIGMYIPV1YtPuma38ff/4gdgL1RQ0TW2+O7qmy7taDffuYQetyDbxS
	wfNR3lRwBa6/9qzElXnaNnf32lGzpQ51tHtAI5RcTS4C4wYlgDNKItmRNOb9YRvXi07VEoIyM6U
	z4Ix3cYEvonzavEso7WBOWzyjfOr+++4qEEcvi04AlfwNLL6jKQdinNnbA86eSepxEnFLm5lp8F
	rQmQgmfuupAx2sejv/oy7yp/PuGgLIR733bnyMXurrBZwFCcOQI16mrafclH0ZfOyBj9TwpO/A2
	27Cr92DVbmdf+Oo/9XJbeB
X-Received: by 2002:a17:90b:5547:b0:359:7c55:c166 with SMTP id 98e67ed59e1d1-359a69a94e9mr1892448a91.7.1772633219172;
        Wed, 04 Mar 2026 06:06:59 -0800 (PST)
Received: from rockpi-5b ([45.112.0.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599c4c0f80sm6826545a91.16.2026.03.04.06.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 06:06:58 -0800 (PST)
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
Subject: [RFC v1 04/18] PCI: artpec6: Allow asynchronous probing for background link training
Date: Wed,  4 Mar 2026 19:21:47 +0530
Message-ID: <20260304140329.7089-5-linux.amoon@gmail.com>
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
 drivers/pci/controller/dwc/pcie-artpec6.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-artpec6.c b/drivers/pci/controller/dwc/pcie-artpec6.c
index e994b75986c3..d8b827926b85 100644
--- a/drivers/pci/controller/dwc/pcie-artpec6.c
+++ b/drivers/pci/controller/dwc/pcie-artpec6.c
@@ -520,6 +520,7 @@ static struct platform_driver artpec6_pcie_driver = {
 		.name	= "artpec6-pcie",
 		.of_match_table = artpec6_pcie_of_match,
 		.suppress_bind_attrs = true,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
 builtin_platform_driver(artpec6_pcie_driver);
-- 
2.50.1


