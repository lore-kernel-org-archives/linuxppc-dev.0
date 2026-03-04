Return-Path: <linuxppc-dev+bounces-17743-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FBC5EFCE41
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Mar 2026 19:55:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fR3Lb73HXz3c40;
	Thu, 05 Mar 2026 06:55:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1033"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772633417;
	cv=none; b=looSE/2R2lJJY6PDChyrrJiUJ20Ql0Lfv9bo8P/DE3NX8MOENx/efQRvXQtgMweabs3LmqYXUaNrnyYz8pFQ6Ydj6aBpfIuUwDqq4nJt0bUHzZ6gT2jfDUAAtlgBPqXQDXMb/iIXI8RJpJ3te6MQW4Ip/vnugpv1EAOQa6BMtQeIzHpybIBU2NPzztWWbS3KGEmtN1VSwu3iZSvH4GaKKouC/VzH10ba1vrjlhNvZnBt2BmxOJlLtsYWEVOhIr71YGcCcSfXzooQJZTCdUH927M/i4h5wLk7iYZv4fN/1G/VNM60NUitXeU3pkA/6DrcCs6dShCH2cyzTJKWBqA5kw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772633417; c=relaxed/relaxed;
	bh=X1R3QVXR/Ozn+9r0kdO5H35rDS/3I0+kFqEdmlZYJAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JZTnbXatm4sshVipP581yKKNTf8ffWvpin9uwOasbTtef/h5fPe9RDEnDD2zrJJL26t7Ayq5IDg2EHZsymjU+L3FbIJruRb+xKF6UiVAHFcc3lpyhVZSfqvIwICohvrkfnFnxGKTONV2/4uyFCTCBzvSdBYcRxlo57f4R3VNIcnhsnVvtH/c1ueN03aYmYlx1XYxlbbBee4QFNuLBC3oUslmDw9TYTwthr5pqNLcTG1qQQLDzt/fN3lwDllQeX1REKm48L0JwGDDP0OGJj9W0NfjbRRpHtrofTkNOydOA7IMcxoCHjD9s+vKqX44VuZ9244PzliWr9FHhlNPsQb9uQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=h55l6P/y; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=linux.amoon@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=h55l6P/y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=linux.amoon@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fQvh84MrLz3btg
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Mar 2026 01:10:16 +1100 (AEDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-358d80f60ccso3190409a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Mar 2026 06:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772633415; x=1773238215; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X1R3QVXR/Ozn+9r0kdO5H35rDS/3I0+kFqEdmlZYJAU=;
        b=h55l6P/yv3Q1vDAvQY6il8ltD+PQj98vW7mS4nILXSg2+F1sFN/mZrSe0sswIUGYyV
         c0VrMTmcSzvsQlMz/eQDhDINDa/gMsrh3fVFvJRZJoCaKzvNucBU1zV29cyjt+w+xgcd
         gxC/9qBLhQHwrpSLgPquNhp8Azul/AJATO2tND1fPqXIFm8zMZvudVTsA932nWDZmb5/
         Y7ec2TJcF3Li3p45NzFTf6jwYIDewQeKqGZ7EFXf4i9SKd19o53nH0iKiseCzUVjMrwe
         p9Ye4ZuzEIjfK3vWnFKatoYlyvH1oe58OErVu2qADrPLBrmiBML+av9OIBDdpdRZ+dUb
         x5Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772633415; x=1773238215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X1R3QVXR/Ozn+9r0kdO5H35rDS/3I0+kFqEdmlZYJAU=;
        b=HWM39is2GtKrdf7rNBPTtUD5kCtFv/Arg/HXwVrWIvpFCbtmG2NyhW5iZ4JS+NeLpF
         ywyufOKdtbmR1BAZ/5JyWr+H2e6CgI0i4MHipv9Zf5REIV2fM8ihFQN2Jo+H3fkDxhWp
         3zKfQgGXwAgxPkPCpNBrtYfyYHcN//HLIhJmAU4UV0pumJkN4GvtZI9LdSQi07D8d77u
         rsym3jacC25ZFpIx4Pi7QtCiZRnjd8zIsc9CyYz7FFnivSUn9AU+l/FN1KcKcfiinIRc
         wJ3SlOdhbvvqivgUKaD6DzWaZcNOL5on+t4pGXb93mv8xQeUZEnqiRomXEmxBhUKP6T1
         zJxw==
X-Forwarded-Encrypted: i=1; AJvYcCW03tQSXveDByjmQW49W+7GivHdiRRVj3SnQ/wEnRCMg5cEsIX6Mc9j3R/vmNScGENflYCzTPvKEe/4uhg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwYkBLQiWC73U0sglDums6WNfdCy3v4l9lKTDGATK8ouD1Bn8wu
	W/kP+coeuC2J96C9m+i/ZDUl3Xl8yDqDlga3fs5Mv0fEIVQCpOke2Z6fcRfu88cF
X-Gm-Gg: ATEYQzxfKTOY3A17aJmrYnnsii8+Thu/hCUx6o+3X/V1z29Pchn/FExY3JfJLd7Dx1O
	E7n8PjcSUzAzOet572mU9HGvA2fdvoWFGERYEOBEknSDd4iIZQ+irNMOdN1kZGpUZPwUKKlGmEW
	fERyLxPSzIha9+qQfK/h0MkR6T07QZemypYNavReMvT9kTGoULYXaGaSIXB3A3i3f4GeIZMkf80
	O8X+RqymsOLbAymEMFBMruBgfguNXJvtz5tsm4jlxVVWUqV4XGCBb1rv5dza0sCxfYCTSjfgKis
	Y2THXnhl7zw1PTPMn2YQEnJzLNOiA0FmmskrpYUdWg5mq41wN4fAmgARGhxWv3rERQPx9w+AvEO
	cA6DMprV7PWCK0levpbnhiXEZSvMvD0IjYi3pKYwyovz7MawkTiF9IRykHPNQzw20oC6K14Vs1+
	dWHxeC4yJYR6ERh3Tn3Mjp
X-Received: by 2002:a17:90b:2e8c:b0:359:8c89:96e5 with SMTP id 98e67ed59e1d1-359a69caab4mr1729374a91.12.1772633414915;
        Wed, 04 Mar 2026 06:10:14 -0800 (PST)
Received: from rockpi-5b ([45.112.0.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599c4c0f80sm6826545a91.16.2026.03.04.06.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 06:10:14 -0800 (PST)
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
Subject: [RFC v1 08/18] PCI: fu740: Allow asynchronous probing for background link training
Date: Wed,  4 Mar 2026 19:21:51 +0530
Message-ID: <20260304140329.7089-9-linux.amoon@gmail.com>
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

Fix the identation of the callback functions.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/pci/controller/dwc/pcie-fu740.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-fu740.c b/drivers/pci/controller/dwc/pcie-fu740.c
index 66367252032b..aa6a15baf3fd 100644
--- a/drivers/pci/controller/dwc/pcie-fu740.c
+++ b/drivers/pci/controller/dwc/pcie-fu740.c
@@ -346,9 +346,10 @@ static const struct of_device_id fu740_pcie_of_match[] = {
 
 static struct platform_driver fu740_pcie_driver = {
 	.driver = {
-		   .name = "fu740-pcie",
-		   .of_match_table = fu740_pcie_of_match,
-		   .suppress_bind_attrs = true,
+		.name = "fu740-pcie",
+		.of_match_table = fu740_pcie_of_match,
+		.suppress_bind_attrs = true,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe = fu740_pcie_probe,
 	.shutdown = fu740_pcie_shutdown,
-- 
2.50.1


