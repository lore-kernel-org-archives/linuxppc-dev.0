Return-Path: <linuxppc-dev+bounces-17741-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCD30EFCE37
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Mar 2026 19:55:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fR3LK1T6Zz3cBG;
	Thu, 05 Mar 2026 06:55:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::533"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772633319;
	cv=none; b=U2yWXO9ZE/NU7Fpdhks2hfvVP2sn2GquWNkr0XNYvIKmyj6K2QUm+lExKxUVO/efca9ROrxXXO5AlaOuRvs/9HB5jKyTOK806xAw2sQ9Qt3xcim0E4ppkbFa5oumgrnPDmY4VsLRmnN1A8AYBI23hoDD8Tv7pO8qZN0tWBmppBksJjDZh1xyfnVlZGGCaHTmzoohQiDpUBkExjEhITwBzghgYiFtTHjNlHhdb9BuSzo6RB8yscF7RkAutt5FgtjUYJnSRs0OKZe8pnYirnWVT2fvGcO5cpLm6eBOgc08Vab/pJPjgpJpI3Y8euA0y1iEH9kZi2KhkdQjd68WoS0RPw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772633319; c=relaxed/relaxed;
	bh=6zjKUEALhh3sKzrRVkbw1XSt9/jPsMcJZY5h9AuldV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TP2RrnpfcV6WbiyqbyuMGG9B6fMv1BdlpLdFu4P4GRELrxcChZHJniSDiLcYtS7Ieb3vIZDCHSmkP9EPGTzDoVhXnyrZyUqU2Jb+5+5sNcHUOjLVPH9nxuiOoOkwAmHd6gCB1DeBvuyf4pjK5u8bTIcb9rsObk0iSrA2f197KitE1Ns2BCdv7G891gPiGw42G4eIkihf0X/1Jb5fPZ0LWVZorQUdX4GcKRoWAagEco6AuKSn9kyj645m3PulezqDuHQrxNxRsvNLe17KTX5RfVqdkoYwFNKccy6HAtboLgjGzvSkneDXVOQ3gb49Hhf2xCrFbnMxptwhNwlTedx3SQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=l4Zgkymp; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::533; helo=mail-pg1-x533.google.com; envelope-from=linux.amoon@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=l4Zgkymp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::533; helo=mail-pg1-x533.google.com; envelope-from=linux.amoon@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fQvfH0MFQz3btg
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Mar 2026 01:08:38 +1100 (AEDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-c6e1e748dc1so2220091a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Mar 2026 06:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772633317; x=1773238117; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6zjKUEALhh3sKzrRVkbw1XSt9/jPsMcJZY5h9AuldV0=;
        b=l4ZgkympL1/ZrMhX/OVmy/jr1RTxb/7EtIbv8e8+fKt24FszUNxSAUDCkfVk4QrbVn
         sNnn4CJSqXqbaumkF/AfHLdi3LtnyspUK8NsTrdZZuKUnud8YnVgwNy6t3TkZzP7c3Vz
         1lmEJz8xwj3O78eDL4tUZdGJQLpsz18jkvlzmsqX9JWQHOmS1i5tTfE6HdxDhVqwnW80
         PTg9CCtY5EVolbAxEO2Yd0ZsQzInLWWCNQ4e28HSqUjJunkt5py//BIYIHHL4twk0Xv8
         72EHHiT9dAfkbAL7kYVXFnE2xc5g2EwVMdzigz6ylDsoo/aueVPu42oYKYSUf8T0Ljir
         LU8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772633317; x=1773238117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6zjKUEALhh3sKzrRVkbw1XSt9/jPsMcJZY5h9AuldV0=;
        b=O+Yx03RcTlAatbVWeDs5/3vCttpMKcrbOR05JhHU5lLaDehfNNsPG7mX+Mix5h9ue7
         VcoVMyb6SmXdB7aGrasxM4Qxx5KQMQmneGdyvHFt4PRAXqGaHxvhNRKxA43haDzbqao1
         1S/qm1xbdkPWdt3XuNcZlVI/RPYs3yuOQ43jnB0tQFf+DfoiTn9XDmMsncA6jTDARONg
         zkxGxCyH1fWAAfhBf3vMh4ZQAkDy2sl08A9bIHp9qUqdwxheJgN8tYaNx9nPnkfdtEey
         +TMFb1lcivWfht36rDZaCZOn5/f7d7g1uIdlLoKn4tptxXbe02lFkzlwpEm1vPrITghT
         Gjww==
X-Forwarded-Encrypted: i=1; AJvYcCUKyD5gxLKTSrNaq0NyClkUZa9YfUoR505iFUaMew9fJ0ujbVX3ByOKqB9vnRgQicoQ/rPLMqb0RQBPRO8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwLSHkJbdfMfnNxNhsZ9tZ/3XtYlFhHDjA/SqqxAUD+S3lJPane
	anUk8vkU24aW8ppSAuQp5VLD0UTIicVU80kVNEYEo9wiqDlFhraGkfZF
X-Gm-Gg: ATEYQzwNYA33aaQ4syBisC9+DqJMp0hI8uK/1TjTyVJNQ3AJtR+1xfpuqSwsLa6oNx6
	FexbqMIEO3Wwij/voZcY6agZg1vDX5zKQY1W4VW+YdFHS/hFZcCzDp9TIkLeNCmLloASyVQQfOP
	+fUpxr4GJPZT+fsS/1DnCMP3pQuO0tfT1BIrSr85rHFfznKQMEM4z1SkKkzqAyrIELwIPG7Ru7F
	EnMWDbyYLBLzwOrsc2armvyAm8Zj/lOftiuAHuvGkUI+RQGNkxrsOx0pvWZWGOopi6ObMPYp8U2
	2ngP+PCLnrSZ5a34usr7IJUo7/yzfIiMYq8Avkuw4s52sdi9VBexoNAewJ7ih8WyIYmm0FwUUAO
	TbJ+c3JATrWDR86kJlohXIm0kppCri//JwzW67m9gUAxKyzKvGH/f76MvR7h2H0fam5k8tm0lr3
	kuhc0xyHayhItWPGlm7yQv
X-Received: by 2002:a17:90b:2d8f:b0:359:8df1:8553 with SMTP id 98e67ed59e1d1-359a6d8521amr1962255a91.9.1772633317107;
        Wed, 04 Mar 2026 06:08:37 -0800 (PST)
Received: from rockpi-5b ([45.112.0.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599c4c0f80sm6826545a91.16.2026.03.04.06.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 06:08:35 -0800 (PST)
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
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	Sai Krishna Musham <sai.krishna.musham@amd.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
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
Subject: [RFC v1 06/18] PCI: dra7xx: Allow asynchronous probing for background link training
Date: Wed,  4 Mar 2026 19:21:49 +0530
Message-ID: <20260304140329.7089-7-linux.amoon@gmail.com>
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
 drivers/pci/controller/dwc/pci-dra7xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index d5d26229063f..be470d54b2ee 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -951,6 +951,7 @@ static struct platform_driver dra7xx_pcie_driver = {
 		.of_match_table = of_dra7xx_pcie_match,
 		.suppress_bind_attrs = true,
 		.pm	= &dra7xx_pcie_pm_ops,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.shutdown = dra7xx_pcie_shutdown,
 };
-- 
2.50.1


