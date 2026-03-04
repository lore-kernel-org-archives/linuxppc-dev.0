Return-Path: <linuxppc-dev+bounces-17747-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFDF0EFCE37
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Mar 2026 19:56:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fR3MM0rDPz3cCn;
	Thu, 05 Mar 2026 06:56:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1034"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772633609;
	cv=none; b=OihKAVBSI1HdNHi77JPWw+i9sJRRXQX5Q2Xg+CSn1lKvp/dA+4KxunMiO8GtFT95eynIVeRjnvxJ3ega8mX3VP6C/RGh3RZaiyfHdo2tCO1R6n1RhsLc43Tp8xUNBAMaWMUJEQ1mCm16rqmV/MVKchZJ8dR+45AcDk/xJTe8UW7Ka1qGzLc97dhgWMJk1upWhMZ2zV7CulBZbhWTe6ovvRfy5zakcRy8qjsGa7Rq9ITumSMDhXpQYJaOJnOIu36hmr8/odHyZdVA6ivo/gTNj1P8A1T0Nu8slbiPX3DkxvFwH5XAQ/BlBPLZ+xmGVafCV7Xer7tz1ZsjQnvnBKlrWg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772633609; c=relaxed/relaxed;
	bh=zDFd5knNMvGZs41+mG0JwsLcBevtPF3DeTcjycQtFwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TNyCqwwzE2U5GitamN6x+/R7I6tyFWqDwMB/ET4X9mJazUkOXbkqQnFSWRT+nod+WpNk1VJsO9zgssPnFRwu8lNAlmVvfo6zb2EQjC8gh6tA6VmHS8UEWR0Xa2ItSqXJi1RWa4e4RmuquodkVBP+Z8WLiabBOm0HP0M4nrbnn9EeDZNPZZMI+7lafmc0GxzcBit9rtdWt64ybWc2bKX3ykVaHENkjhGUzKqb20ePJGERO94mkPkBNEUtux6/6SnRobrbQomfFXo5tIaSlnYBd6noYIx89E2OGJn9wzcd9GFUKAD8qmKX/HD1+AkbWIm2zmEKvTLudYgCF3XE4m7U7g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=gTJMKi4M; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=linux.amoon@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=gTJMKi4M;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=linux.amoon@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fQvlr6V1Gz3btg
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Mar 2026 01:13:28 +1100 (AEDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-3598cab697eso2002428a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Mar 2026 06:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772633607; x=1773238407; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zDFd5knNMvGZs41+mG0JwsLcBevtPF3DeTcjycQtFwY=;
        b=gTJMKi4Mc9eCYpwOlf6B07ZWSK7G937Vn5FmjJpZ0Y5/90B+MIGLgiUmzW+sx9K/VD
         eagDq5nfIYuH+FgzQWSNpfJj1l3Rrm13hbaiAKRWMaXvITBDD2hWzyUE8hAS0vO0et+5
         0MQjxPCSfxArgh6uD/kJiKz5v2DiI2hp/HYAwUe2BsSLnE8zWaBbkM1Ypg/BwA9xjvH6
         y0TcRRI2TLIiR9ZOmss0l1aUGTTijR4tK/0jYFK2J5k87cw0KKlWsAmcOV6TuEwB8fcv
         /9YjA0QG30sNIFF7Iv0VMQS0V1K/iXHfCEs4lDn3S78JOQTjMZegk8pIDpmDiS3+NTDq
         fzmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772633607; x=1773238407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zDFd5knNMvGZs41+mG0JwsLcBevtPF3DeTcjycQtFwY=;
        b=ehniAxjqt9CHsQfRXxAy5ShNXe7L4w1pMawa8aE7BV4Ca71gjUaL6GKOa4h2q5xxo2
         sf0iqIazD0vqCHYIhT7ExY6WuazRBEDSsIhBTvT/B2Wnoxwa2ohLRJhEUXApjGBvZ5GU
         rDIzyQVSkwwDOa25qunvl8hMIVDzFH/fundaWf3idmmH2rM88HSideROkxyiOJhCbRMj
         B46ARgQTGoPcRxBJQtGzsnFlicIIiThoTwoKpnsenIr1ZZ3MzGFV4IEfdO8lBtR7KNJS
         vm7g3T/cQOr+vVLyNoJ76C98/Glnl9d3UKwSgl5zsFjFWF62c8EYCTFIQKaAeOkfQR00
         qYeg==
X-Forwarded-Encrypted: i=1; AJvYcCU3LgKpAvMKnYozpZQaHpqPqh8ngnkikqEHzoOaS00YzVx3wqhtGzARCFlOlSfGb0J8q0ITJ8fLwYQDuQs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyLxUhsdjXYybyNMfhlasIPc6uIK+QsIXjobsnuCAph6+9cu3X0
	twDZyMA0Emunhio8rRSRgpMwiAM0K8tqbUtkZoFxWwRrOVW5/0+mEj+v
X-Gm-Gg: ATEYQzyv6xao1gen89RCBTxGdIN+bfZIxGT8IfA4xocIMWoaiktu7mfOg3AVYVeFg6x
	plY2klClH1w+hSwjh9UF36TaK0pcefLDlg2Qd4XhuPb2cYlFdyn4OKZ124OEBolynR6LQxFwTUT
	UaSrxOv+O3nJExjU0gCbQkxS3VIr05/lMjAVW78OIx7IzJEY4tJhfJVcGMvNvyyob6j/OTzGRxs
	EuU/0dL2lKvEl0QFcZadMV+h9DbmCqduhG7+e3OH0TQKqRtArH0lTXXxG4SKGjgSSbOmrmMTgg2
	hQkF87msT/Xeta1poi8en6Ksx4H6GezD2SIyI8damH2sVYRoPwocq4wK6e+ONaoOxxMnhJ3DJNL
	95nlQu2/ADZWn/JTKLemq1Lez8WxekIn9O1rF9uw5IQHIrnh38mQVL7qQFYhjcdA2cJkkBtgrNd
	v8RLPwrV8aDc/Nw/s7Tnhc
X-Received: by 2002:a17:90b:5286:b0:359:83a3:584d with SMTP id 98e67ed59e1d1-3599ce32dabmr5222786a91.6.1772633607253;
        Wed, 04 Mar 2026 06:13:27 -0800 (PST)
Received: from rockpi-5b ([45.112.0.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599c4c0f80sm6826545a91.16.2026.03.04.06.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 06:13:26 -0800 (PST)
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
	Qianfeng Rong <rongqianfeng@vivo.com>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
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
Subject: [RFC v1 12/18] PCI: kirin: Allow asynchronous probing for background link training
Date: Wed,  4 Mar 2026 19:21:55 +0530
Message-ID: <20260304140329.7089-13-linux.amoon@gmail.com>
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

Establishing a PCIe link can take a while; allow asynchronous probing so
that link establishment can happen in the background while other devices
are being probed.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/pci/controller/dwc/pcie-kirin.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index 91559c8b1866..bc905056a9d7 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -757,6 +757,7 @@ static struct platform_driver kirin_pcie_driver = {
 		.name			= "kirin-pcie",
 		.of_match_table		= kirin_pcie_match,
 		.suppress_bind_attrs	= true,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
 module_platform_driver(kirin_pcie_driver);
-- 
2.50.1


