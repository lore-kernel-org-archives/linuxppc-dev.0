Return-Path: <linuxppc-dev+bounces-17745-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44136EFCE37
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Mar 2026 19:55:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fR3M15knFz3cC6;
	Thu, 05 Mar 2026 06:55:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::536"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772633513;
	cv=none; b=Dq6/e9r0OvzAk7jNHarsNcUccUYs+dfihgbHX0UP3IOnxmdU0FFHuEkL8xxAs01/MTA74Uz2FBjL+6wX7gpMJjyntrRB2EOfbuQHwoa4BM088wScFlaxn6fOnktsxaZN8q5skMLNMDll7FGDgxgAF2UcQRDedpYMnmTpL+PO7aG+a2EAf/jeP1Jw8yk5FC4LL1p0e4deplyVXtrotAbapkjMtHqVKD8WEJ5e0k5S5fNAoEtGurSOEt+wsfJrSYQEyYeS03HA7BiJtBZ0voGzGkwVd0hwmtkLENvAoLxVImP7Y0AlcUmu9eevOFg824q0FKbbRm1KXqMBFTK+mC5Y+A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772633513; c=relaxed/relaxed;
	bh=aROfauUNCfk0cLD7hgwZVAJeImYUlQkQwfOgm/TavYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f5JPamTcxvK14iEj9EV6GRTEO62PldKJFPd2My8G6mup0C5sQzfjhIlS86OlNdokxVTyt3rN7QrgE/Zb5nUqxwmTr82CN5ZpnBY2vxLJKcfeIejn9XhmijngOeXe4c7PlXXr+5tdJ6NE/Ej4TXJXARs5NXpqA1kZtG2gGfmwlg+jz1mJBJrHAYVJAaY/gZt7w+xvvYVTZufzdayDYeWzFEGcqblXXifQH8Z+849lTDAK3Ru/Gva1kfA+hLSbo8r3DFd5G0aKHO5Vp2DuKN6HAmPTRTBC/0T/zb4moyN4EtimVmihN7R0pWGL6begxBBx6ZYN9NfZ1ekfOnRlpMEYpw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=lfYNyoQi; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::536; helo=mail-pg1-x536.google.com; envelope-from=linux.amoon@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=lfYNyoQi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::536; helo=mail-pg1-x536.google.com; envelope-from=linux.amoon@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fQvk103YVz3btg
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Mar 2026 01:11:52 +1100 (AEDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-c6e1dc5c5edso2626676a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Mar 2026 06:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772633511; x=1773238311; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aROfauUNCfk0cLD7hgwZVAJeImYUlQkQwfOgm/TavYo=;
        b=lfYNyoQihKA8hLryLDp8cE02Z0h84wOX30AHVavXCPsmobEHxoN1pWxgAimmxRxiFM
         bYOiNEPTncYA4/Nbm1HdyrGa4gT6V2yut+Eu796ZOR9V31yz8imBEh/XnovVlri++Ems
         r2P+RCsswN1pYv+EAB+hweMndZhLzekxVzWkw7Th3QxoRe3Eos5ItMmqeAscTovOJXV5
         0GwDkTijCzlkerigaDx7MnbUZqxdlNiqbzGjQ7xE8NUZCVNUWBBcfK1lTOCtnn54iE53
         lnVsbcAlTq5KC02zZLCLGnOyQTdSXugGBzgxOg1Qz1BAJbRo+Y065t4eOocQqmojKeOk
         6Wtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772633511; x=1773238311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aROfauUNCfk0cLD7hgwZVAJeImYUlQkQwfOgm/TavYo=;
        b=XwQ0Hoj/j9cr9GOa8P48uKGkwmR/nFDItwWui3T/BTPYAqPVf2JQ7Nl6kW1POgH6Bv
         fHN9f60/LJ+B7WhQe1KsoFrQfLYY3SICzFVOWsn6+SAMHNyfo1CnHrMJcOmY0WuoqizC
         cdCSg88wyYOxZR4UG2fKaOkQRqZJkPMBNIAAoIRtLkO5t0Mcp3iDKago2fLdW7/9gq5E
         6uz6CV6gNR20Z1aOAamivq0EwSpjv9SW7Ia4RjFsM7frU2kao2/EvX0S10AK8zfX3P5Y
         ALrloOSyS2k44n8RUOwkTFnjo7UQCU+EHhvSec7ZkQt/IgkCNjHQsJjxN9SHsDLiv0hD
         BQZA==
X-Forwarded-Encrypted: i=1; AJvYcCWAhps0b1U9FdhRT5Gyzo+OhLHzAcWyKlY7hflIJEN2wEEo9WFCfo4wCpznR0qQMIeGGdmxwUK0FL/7YoU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YywNKzdsfkNWjBYDg9zr3L/ZZ8Vdr1giaiVm6ZMUtZ1zWKpKiM4
	g5NUzxW2jH/KsgrCrytn4I7luSOYKq3oGEVEJ94lGCQEjwMXdA8U+2ke
X-Gm-Gg: ATEYQzxM8mkfh28x+5+DR8ttGlR9WHyFAJBLs4bTbOQZhQ+qjC2d6iEwY4EEXE0DFFf
	KT3DwPjsqG8kYii/Ph4ntTksTxJp0w60Tt8I7q6PqrTzxyx7a2b+T4nms041p5aT0BikJQrfAe0
	zIK/pRX93pSUzJU1TZtmhs/3FE5DRk9FiVhjkfeXVsgjzTUVoG1KBlnN30q458ZlA+IrW3jZlnI
	fNYRfNsb+Pa4mv3+p1p0PZhdpBlRZuTxwbFeVg8oPHDs6A2r/fyZBsEWqK13zFZvvxoM3PfQJ/o
	tJ8ert2fm8/36aAkL+gKaGUimAk14Y9NKrrpf4x/6JuCk/Y1t3BNquuICA3KuPqQNwbelaraAFz
	AnFeMJmmlrPmSSDzXIR+IhOWeSY3Pa28mNUZRrs/RsHqEq2O7wcPrbaIdVcMHjG3tXiLMl0iKxb
	pLvVf1WGNiw/Wr5AVuOjTRNIBx1Mus+98=
X-Received: by 2002:a17:90b:4e84:b0:359:7eb:d91d with SMTP id 98e67ed59e1d1-359a6a575e7mr2125758a91.26.1772633510992;
        Wed, 04 Mar 2026 06:11:50 -0800 (PST)
Received: from rockpi-5b ([45.112.0.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599c4c0f80sm6826545a91.16.2026.03.04.06.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 06:11:50 -0800 (PST)
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
	Sai Krishna Musham <sai.krishna.musham@amd.com>,
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
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
Subject: [RFC v1 10/18] PCI: keystone: Allow asynchronous probing for background link training
Date: Wed,  4 Mar 2026 19:21:53 +0530
Message-ID: <20260304140329.7089-11-linux.amoon@gmail.com>
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
 drivers/pci/controller/dwc/pci-keystone.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 20fa4dadb82a..b5c0c690593e 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -1351,6 +1351,7 @@ static struct platform_driver ks_pcie_driver = {
 	.driver = {
 		.name	= "keystone-pcie",
 		.of_match_table = ks_pcie_of_match,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
 
-- 
2.50.1


