Return-Path: <linuxppc-dev+bounces-17748-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A74CCEFCE41
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Mar 2026 19:56:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fR3MR5QJGz3cNN;
	Thu, 05 Mar 2026 06:56:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772633658;
	cv=none; b=MJTEUFCs+w9oeCb9gZaMXJlt3+7bb8ktxvw1HwQL3pSOE+FKV5dzfD+HQxBLX+f6dyiE3OzJBG+XTxZOiIlKoihiVnJcOEtWccGtbhu9tmjGgNwMwaYYuxG47hg+yxE5nJcF2bTwgHJOJkZnY1tfVMqkp6W78jCrLbXufsvrDA3vlJtJtZ1zqycHYALhC16CUXSlcTYusZmHzFzXD80fafSjls1ur4JcemVU1Gq0nAgZ/+jUiY2zD8REVnOTGuYypgQurwfUYSJmIyFELyF2PETkEwOiEpWsxZ5lfXrNFm104nd0wLuERXNurzNnCid+dcKpmCE5TjA59fXex+JKdA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772633658; c=relaxed/relaxed;
	bh=/iMM5LSmFDPAj9DIWsk4fCcz5M6Z1n4D1h8BmNreiQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lyXClwv1uO3P4q3DZfdbyhCx3kZPLigls7o2G6nUew64A8XXowukrMxCTNNXJFNELbbJC+7FYN5APb0ZlR7pPqm8hBt7c1vftwaP4d9y0P+Ti4NugWCXla4NR+xDZOqlP1DnoEkaKXiNWmvPU45niRYGs+7PANkJARPW/VpC9i4okUUYWTxGyAYx+bAOFxLvSzoobA/VUgxTq1QIs6n6tWRnKXghRMsCfDJA+qIWeSh3BcKJN2z37yK69bK47U6fr+0oKZLGmY1PhwobTaqNbYZanbLxKCG7h8KPh9PERzmRWoa5OghhS6qXNomJ2l51yUQkLWhCAvibKKVn9Xb4EA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=LtKNiKUI; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com; envelope-from=linux.amoon@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=LtKNiKUI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com; envelope-from=linux.amoon@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fQvmn5f3Mz3btg
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Mar 2026 01:14:17 +1100 (AEDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-3590042fa8eso4154029a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Mar 2026 06:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772633656; x=1773238456; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/iMM5LSmFDPAj9DIWsk4fCcz5M6Z1n4D1h8BmNreiQQ=;
        b=LtKNiKUIJypZ1a6DoZHQJwRTvBSttcIAaRis7M0vkasNKxmOP2wOgW2gEv7JRYZgAN
         f3HUL+9Uhxb9kI4UQ0WCDgi0thoU0iardiLCgmxe2TRCFE3S8ist+Ay+SoAtNTgA5Lg8
         MVT+zpZEMy8qNzAPMoclzUyoWhu0mwWHWE6ODNNzm/37QNULIJsHvBj1NZghjsJK/WBc
         QISaupS+ggMwCwCkJFQoQwtRlt5NTboNQP8afx/XzGfEQ/0ZnbEBkl8iPjoAL0Xcl8kN
         EivHrhvbbejyEYQN2z5L00N+ytveYnEy4bYVhndXwpEf83MoPO1Qr0S9C13+XR39GsPo
         6lew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772633656; x=1773238456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/iMM5LSmFDPAj9DIWsk4fCcz5M6Z1n4D1h8BmNreiQQ=;
        b=RPE8Bc7dhDQYrW7UyHLr39FIFSO4tBlxgNIA/RN6cXj+rWUepoYDw39kWppDoX/h/A
         T0UhomPJ9hvzXYwbO5mvt4kuISqqJcJuWO2Dl5kcgGQIsKvgzgjqcRVU5cUA1qnyN9/c
         YBuUL+0eNHBoxCWfBbezHX0fuWAg2dCH16Vwi32l6cCBQYAw3dE7hIuzPl6l5oZMrVcj
         YPgjx0bITNtkVn9U9cYsmbOQUd8eW0aJEHPc4VO2pTRLlp4x6Gmnadq53mlK6RoN9Sr+
         8GEmacLU7H8WEzlTcw686MlaBzsfebFrunGnl+woKf8r/eTO24c5N8bPKn5vk6ohVxBC
         5TMw==
X-Forwarded-Encrypted: i=1; AJvYcCXg/HKtxYqPfqG/XVuRV16MWpj7jXWQRJ22Xd+oFIeAQNXDyajyNrx9h5curbuHYeIpOz6ZXyO2l8u2/Ho=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzyKmzoVaHXLARY6pZ+CkWM8YR40wtnCMk+i15pKQn+tXBoagAg
	/tDj2CVGDIg14jsmplPgTCG5GPPKjJJ2E82omVKaqQo5U99EBq83SUfS
X-Gm-Gg: ATEYQzyrhTvmTq35scOYY+cWmGHH3MtXpMi+8vBOd1H9LFvh2jjXOp3682Q+1JdpZj+
	00AB3JTlz++fIF0QanvJ9q9GQTuaKyKzQjG4W1MP0fh2QvcRlfFGCzCB5Cvn77g27LXKlhBEBZJ
	SlhlI+Y7VVK282xX6EdAatvG7eofa6u4MDRBAC83ckpTHfW/6rTUMf1XPga7N4nqIuTs2JPO6VX
	1fhYZI6aOJeVOCo1TFPeO6jxzEveRggASKN2cQaoBe2z4Ak3aDWxWVpu42U9jgvs1VrCUx3N3eT
	RuQBe4AIj5j1AGwTV+HrrdYyOA7zsaPD4c/b6q7gQI8QSM3R8ZEnnwEq8euse0Ikmd+FjuIbI8K
	Ebm9ILHxIAxm0IobSDNJo6vkRYI6u5Ut0HMnRadZAscbc21pR8HECw+XLRcez+6DBbRA9VFRKMz
	EbIWQYSb/BM05URsrfLU8v
X-Received: by 2002:a17:90b:278e:b0:359:8632:5e39 with SMTP id 98e67ed59e1d1-359a69adc3dmr1844903a91.5.1772633655971;
        Wed, 04 Mar 2026 06:14:15 -0800 (PST)
Received: from rockpi-5b ([45.112.0.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599c4c0f80sm6826545a91.16.2026.03.04.06.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 06:14:15 -0800 (PST)
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
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Koichiro Den <den@valinux.co.jp>,
	Hans Zhang <18255117159@163.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	Sai Krishna Musham <sai.krishna.musham@amd.com>,
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
Subject: [RFC v1 13/18] PCI: layerscape: Allow asynchronous probing for background link training
Date: Wed,  4 Mar 2026 19:21:56 +0530
Message-ID: <20260304140329.7089-14-linux.amoon@gmail.com>
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
 drivers/pci/controller/dwc/pci-layerscape.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
index a44b5c256d6e..43a28d9ea7b0 100644
--- a/drivers/pci/controller/dwc/pci-layerscape.c
+++ b/drivers/pci/controller/dwc/pci-layerscape.c
@@ -410,6 +410,7 @@ static struct platform_driver ls_pcie_driver = {
 		.of_match_table = ls_pcie_of_match,
 		.suppress_bind_attrs = true,
 		.pm = &ls_pcie_pm_ops,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
 builtin_platform_driver(ls_pcie_driver);
-- 
2.50.1


