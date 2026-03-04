Return-Path: <linuxppc-dev+bounces-17742-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4FECEFCE41
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Mar 2026 19:55:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fR3LT0sCXz3cBT;
	Thu, 05 Mar 2026 06:55:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::429"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772633369;
	cv=none; b=jhgLDAZera9Bzb4Jae07E2bev/re4/rn4p8crv6Us1j/oD6cOxjJNVwHZVI15xgjjMlLeKceQQjtConDDm40p6L6k85xhW7eDIoPA9yFYc6XnyP4XEzkZzk0otxxfydJlKbq0hOjPPbNrmz+hKfuK2MxoQ+owXS8NfnIRcvNUcMACi1ROaS67hvhUOdYTFwZwEFx3LBZY7WwuaXWGmYORgh/9UaI4HTvSBA5aF0ut+nIMCWnxSBz+86D3sGck6f3H/Ipc/utFQfBMZ/5mUU0tPqCkUiaQlFfm1dTuIBhFjvhHg6wwMsQ9nd8nOhJwB3jEYMd3c4EqSVGP5aRsVLwFg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772633369; c=relaxed/relaxed;
	bh=mrS7ZIa0rilgM/jlzfLJJeKLRZ0Q0OYSRBkIhGwwFqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YuVEQNGYa5RsWFQR7SXBKwZUzT0oBJuJEdZUjd6GU7d2wEMlebfTM6duPjjQ7i/nieLu1utq05y3T2OGokWvu26Dn1GpHa/FlIMo3GsWgsFrm1rpWHXUJUKAj3o/cDM9DRfIDLbf90AEJRvaFU+cueBgTsdWNl/JfVykK192+4bXqwNjdCHP0usHo8AYa4lMudGmINeb200McsL2a4S4hdUGRa39Fz/Acxclv3iHkiz56TOrvs9VOCez06I/r9MWBYS9LcO7D7OlQUjTf/f5xVpSQLZ0Gm3PmNyWgptH79Hh/5STmb7uMUhbu1x+UZ588C2gcO7qmdEDDZ/gALqrhA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=PFTwv8Eg; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=linux.amoon@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=PFTwv8Eg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=linux.amoon@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fQvgD6lY3z3btg
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Mar 2026 01:09:28 +1100 (AEDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-82747396358so3571652b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Mar 2026 06:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772633366; x=1773238166; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mrS7ZIa0rilgM/jlzfLJJeKLRZ0Q0OYSRBkIhGwwFqw=;
        b=PFTwv8EgFaD5xfaK7nY6ClyzyOMuT66/K9/8gAwVPAY8BHrJWjNUzmX9UyM1C4DnHo
         C0CfiwdkWUnPeUF8TfRYSDcnj4PEB/9jwzZ0VKaE0aSBfomCU8M70rXR0h/u/xPznwuf
         pEdCcWwQ6BlhcH4tkUb8tB6mx0b4pk9up/TLvzTyKPWYcQUfUOiSba98hEfSPtIZCmfn
         MK9vQfaN4QfEJBAQ8nPjGxXo2RzuI7/NKyoiWujM2yRhsOGUn+dQZmtlvZ+/mQxabOyd
         ergIkAbiRJCqJg8KzrSq4p3ePIkH/6ijFfi26iOHY/NjgE2UFJaFDPEDHtdDFT1a9NOr
         nzDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772633366; x=1773238166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mrS7ZIa0rilgM/jlzfLJJeKLRZ0Q0OYSRBkIhGwwFqw=;
        b=GMv6tUhi3kR7WEA6UV6BUgWJslFmQZHZ3QzAKzS97ni2san51JzXfPzuTqX/x1OrCG
         kITB3jeKb94DcHQI+kied55UBprqIWm76cqjBysndtCEIrjRh03HQdjHp66CbZfFM5NF
         MXZB/D2AEqjaeFbndNXc/MKBj08rW4cjFPzzZlNYvw+RrP8Bf7zGOiQDnTLuBWIOnijt
         oUbA32B88qchAtfvzu1zADQ9GVegnaG6hI765lwhfsyFJbReDD229rUB0NMYy19AaYMh
         2rFwMcOm1wqHErRiozaBG5jNH3IYgQsxVqmNqXwI5qGzhiX2Fq9nuCGinXhdjOi1dwM6
         MNwA==
X-Forwarded-Encrypted: i=1; AJvYcCWKh+etSqBwVGE51RHgnuy3qN7bYD15sKhL/KQqP0DnW3aHgqzB6+x91zYHfnQXKei4i3TIKaN7MMRBgZ0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyDmS881lx/l6im2NNIdjWsbr96ls6aTDscJJBej8N/7TWHFyl1
	TVb+1mNExuQtMfaK4q0IVy3Iwaio6iY1XhCW0uO/KGOU5cxVdCvzXqeO
X-Gm-Gg: ATEYQzz0Skn7vk8WYZMD0WkEF1Uzih8ZJD2Hg/It3yY+1hAUrpxzv98PGdQsuGamlM7
	BeDj1u1TQI33mDax79dn/QUQ1kCy2bafp9xUAWQyncn1kDU2w8wfFKNv7KeGyk9GnA9W6hLv5Gf
	pfS4vwZEIAdTF1PwP9qy1+e+18rGc5flIFwmYNAeXDnLEX6AUCHKKwLTfZJempjHhdd6VKzmc2i
	oszrF0XgpOR1Y+ajZzVwH9ypRn3yHK91G6ItachHDaCyZZFW9w41tszt4W2Mq4Lm1Nx7BcAYime
	iGDch8iaYQfToFQrTXi6d4AGQCyPg0+RgmA0Kw7xSVKZPHHzRUg1xKnDpdlBFxpHg+Uq+ke4lZr
	VTThFarmkLKrdzj+COuocViPxLqzkfAB83cDuDoEpbSG2J8hv0lO0uf9YEQORKpK6JS+016cV62
	Ba5F3DHwx5dwbRMN0WjT76
X-Received: by 2002:a17:90a:d00b:b0:34c:9cec:dd83 with SMTP id 98e67ed59e1d1-359a6a7a0a3mr1687183a91.27.1772633366451;
        Wed, 04 Mar 2026 06:09:26 -0800 (PST)
Received: from rockpi-5b ([45.112.0.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599c4c0f80sm6826545a91.16.2026.03.04.06.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 06:09:25 -0800 (PST)
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
	Koichiro Den <den@valinux.co.jp>,
	Qianfeng Rong <rongqianfeng@vivo.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Sai Krishna Musham <sai.krishna.musham@amd.com>,
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
Subject: [RFC v1 07/18] PCI: exynos: Allow asynchronous probing for background link training
Date: Wed,  4 Mar 2026 19:21:50 +0530
Message-ID: <20260304140329.7089-8-linux.amoon@gmail.com>
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
 drivers/pci/controller/dwc/pci-exynos.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
index 0bb7d4f5d784..ee2423e16b58 100644
--- a/drivers/pci/controller/dwc/pci-exynos.c
+++ b/drivers/pci/controller/dwc/pci-exynos.c
@@ -388,6 +388,7 @@ static struct platform_driver exynos_pcie_driver = {
 		.name	= "exynos-pcie",
 		.of_match_table = exynos_pcie_of_match,
 		.pm		= &exynos_pcie_pm_ops,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
 module_platform_driver(exynos_pcie_driver);
-- 
2.50.1


