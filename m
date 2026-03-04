Return-Path: <linuxppc-dev+bounces-17753-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A18C8EFCE37
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Mar 2026 19:56:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fR3N56Sggz3cF6;
	Thu, 05 Mar 2026 06:56:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1030"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772633900;
	cv=none; b=fpgo/ITnJChC/HWHpPLUOUX0f6AdDzydqEpai+hUGbtqBQ8M3XCp4O15BeseRt3SpniqxpkjbVXa8T1xAHUqCSXLUpocfjtTmR7ErrVGyAVTJqSrta+mCun98qpojVkpaoewmI+7dOZj2WkvGx8jRTt6frd5nBdLYb4OlQMNke0DoOSTQ4h6JwLfbt/J5Q5UIWkbSL6/uzVa2vK977mAbRW8txIzH5VSoOV1yWcwHT0fhU87hDgOU4knE3jzJZ1vqWL68CBftQya3mGNQDtalPvgpnbhxg63YCzwnYQj7Alr1BDFK9VO6IXcL2/nmGAIFVbRMQmfphfjTQaFYyI59g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772633900; c=relaxed/relaxed;
	bh=gOqiu9rk3pfbNQbzbq46fMvxLJFiDFeJ6tCyKh6dPNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dKI413eEAC7TpSXKK+Hx/OJz6dARlIHkamz91t8g0iQO5VJFJQ6f9BucofJIjmRhtbgUOaYxJ7Gvy6Wcap1cOf4es3mUeESV+EFR5y1J7gP8A8+PCSv8Wi/54eQLLdnGZsHCJw0qAxbcdueE/aCxyjjfGBlfvNdWgTX5aVi7cJJBkIC0WMWIuQ1+RGXpveT36DmN3uDaoE3XDwwJAbV7A66Pkasc5LUz00hnN3s8ZUhk90mkK8c+7j7EyxrwYETxB96QD6t8EVVCDAVu3N9Qo2m/ZSA1bZkX6xhAdkjD8sf9xE7Mo7o6++aaUWYIcV/W9xaBHbpnQj53dd7rnzJzxQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=eDkcQm5J; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com; envelope-from=linux.amoon@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=eDkcQm5J;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com; envelope-from=linux.amoon@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fQvsR15rVz3btg
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Mar 2026 01:18:19 +1100 (AEDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-3598b2318c2so2008805a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Mar 2026 06:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772633897; x=1773238697; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gOqiu9rk3pfbNQbzbq46fMvxLJFiDFeJ6tCyKh6dPNk=;
        b=eDkcQm5JpRFh6XIDg345AlIlvNrzfKmmaWvOKbV/VG4PkbraTCTFAI00bg2BEg9H3F
         x9JUUSHCsx9ZhvOlpP9FnWFMu6QTamvodcYLB4JEKBGPCnBq+EfE7KnxagdKYv2fc3qp
         8fdK6Ax2gHslX4Bcbjz6I9T0fiRpGmVfX2bSAtEMILPTLjm/m+/DxcWEMeDO74ej56o3
         cyYI61ZRGOb2l1Ivo3C+CFG+laOK8oonaj4f6HXbjeW4nQoCYtIr9GuiKmiIkX5beNuu
         X/3VHMQ+HWYoktzsnGkp/Ogr7pXf8fm05uBAnKZG+GEWSqP8BmaD2N4VN80xEyc2sYl3
         QBdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772633897; x=1773238697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gOqiu9rk3pfbNQbzbq46fMvxLJFiDFeJ6tCyKh6dPNk=;
        b=DD+PIa/ATVIxuy83EyD3JVlXcX4btlKtymR6nzG+2LKz36Ulq0FdZMpEDtLfmAgbd2
         8dCPYXmZXN1JChq2yhqWgywGpDg8YkDy0U9JLgXT7zdlQb5jVIlrChPy0+OE6DKADnva
         luSwbf73W0NUbcnTLg2DlE7MhAQ3upKyCS9dU+WNaiVoo6ktT3VTOVzSewjuFnzfS8cC
         tT7+JxMdKSxV0p/dGt/tCmPynFJzDP0F0PTdwDtg5tbXnDJWq9AzUGaEfO96xwjIEo8q
         SEsCr6JBEYlqlBIPtD9Ztsm+tF2lOYgueFZ/W1VEbuWwWKXfAG5/B2Wp8zWkiw5ldx2A
         e5lw==
X-Forwarded-Encrypted: i=1; AJvYcCUtgT8Zg2lii0uHBSxRv4GyEtADIri13g+8uh4K5u7Ba7oOVz+t/JDZ720FxzggPlTQPjnfq+7YUlZB7HA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yzrt1qGv8xYOi2LFh31h43ayUt+fM7xJHN+eX//467kXtaNxSef
	pmmKZFfuI/63Wne6cqsKbFbxpMbxFxUO6JrL4k+hliKaXfR8Y0rvWPph
X-Gm-Gg: ATEYQzwxM83OJ1B7Y8GpY4YZRE8gTITLF8hkGt+x7FFT1+7nUpdBBNunL9/+SdCNQUF
	plO+lApVVshyEgUPv+IQkAsKahWGviXBwsnaecE5E7eJarX/1nM2xhJ5N2LOeKnPw5IGLHwAgce
	9EPXvifc6Nk6ZzWPu5sfcW+e9dm4gFcgZUfDukHv+h39X1u8q9Jncb9f93TKA6PSpT/obirN7Dx
	Pi3v+2pR/ik0U8y5N3rRea6PTvV48tZXLTpKiQ0RJ0c52QHIavhhCq6DZGKBOCnWkNFeCS4g2pL
	NbTCI7x74iDQWjBN9m5f0EhRG3qZkn/0hjP9s0FslwJhCMcE5OQqympDWRfsOAuWodCadtPKRx4
	efckP6gzVMQZLuZDzlircwG9/kzlDClG0m0sjYdj9zHvg6bBJveoK3BIhaLFPUGHA9nymdXCyOj
	RsV9AhfsqjStEUY9VIsd6wS6T2QxMhyto=
X-Received: by 2002:a17:90b:4a87:b0:352:bdcd:118a with SMTP id 98e67ed59e1d1-359a6a21675mr2061241a91.21.1772633897136;
        Wed, 04 Mar 2026 06:18:17 -0800 (PST)
Received: from rockpi-5b ([45.112.0.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599c4c0f80sm6826545a91.16.2026.03.04.06.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 06:18:16 -0800 (PST)
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
	Qianfeng Rong <rongqianfeng@vivo.com>,
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
Subject: [RFC v1 18/18] PCI: visconti: Allow asynchronous probing for background link training
Date: Wed,  4 Mar 2026 19:22:01 +0530
Message-ID: <20260304140329.7089-19-linux.amoon@gmail.com>
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
 drivers/pci/controller/dwc/pcie-visconti.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-visconti.c b/drivers/pci/controller/dwc/pcie-visconti.c
index cdeac6177143..f21cc95fe89f 100644
--- a/drivers/pci/controller/dwc/pcie-visconti.c
+++ b/drivers/pci/controller/dwc/pcie-visconti.c
@@ -324,6 +324,7 @@ static struct platform_driver visconti_pcie_driver = {
 		.name = "visconti-pcie",
 		.of_match_table = visconti_pcie_match,
 		.suppress_bind_attrs = true,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
 builtin_platform_driver(visconti_pcie_driver);
-- 
2.50.1


