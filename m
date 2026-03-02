Return-Path: <linuxppc-dev+bounces-17505-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E77EE9B351
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Mar 2026 10:00:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fPZDQ2lzTz2xc8;
	Mon, 02 Mar 2026 21:00:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772445606;
	cv=none; b=Xam9pqXUq3Q2K21amJ6huvW8C/l2ICZl3xPhn3ng6MAjdRc7lL6j3ibfNtYCHox0HYPbylp1pZe0ujST2doTe0lIHAofK0do6jzv6ap1bbNzbltXz2ndwfkh4iPREcoQd47CJcGvBEYg87Zxl8dgUwP7mliV8R3beW/dXboxW1AK3TiCwlaUFK9EFLmo1zlSFfbhzDmXlMnGkIiQHb4bucCY3+A9gBSjNFErp/u6OeXhUPtU/S/qwAkA33KQyXTlg7d7D3zDjwdy4ESKD/6QFo++EBKGEMeJH5axpWIhr2auultj84v+jjXGYqWADGE0M6Uy6CMJ1H/KEHEmRkrPLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772445606; c=relaxed/relaxed;
	bh=yFim4gKlHgwwfiJQM/d+SctKMi+WgvNr+X9u6HYHBjc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F3jQIUS01SUXnN+qzvQAaUdugjZzgxCBqN4DsYdNsgEmNIjzYhcNlnloX/UU5k1YFLiigSR47k0+puEriXZIfqTENVaHpYnNW/JfSfxp9M+9++Y2e/LiVOe/9JqN5fegwRtzC702kEKZ5jyimyWWqwPsa08Jh6IW1FsJ/dA9BuWf5fYjPNXZJjukY1FpXDGstts2vITUcTzAWyIPT02Hen92VZsPK7LxwAMA3PiFAbd25flLaZquPggDNeRfEXogF2n7kgaZ6yNY6+1RqIE/jo5nBD4I10Kv4Q2J2+fWwHbm28+C6mEY8RKbUtMaq7jYXv+0k7bfii62dHUWTRfnjQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=c+MpGq1d; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=cassel@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=c+MpGq1d;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=cassel@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fPZDP1k8Gz2xGF
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Mar 2026 21:00:05 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8664143FE1;
	Mon,  2 Mar 2026 10:00:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1A15C19423;
	Mon,  2 Mar 2026 09:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772445602;
	bh=IoPwRnzhcjgMfGxBVDJ5aughrS0y6ra32/Xy0hY7TLw=;
	h=From:To:Cc:Subject:Date:From;
	b=c+MpGq1dnuTjUI7f0FrIbg04S4ve5/201mDbKqansVCUw6ROye6c/d1QelKslSjbF
	 nba0cVLK3eHGlu7U4FA/t8bBHPJoMpo73cDxG0l8/SCtcSRTaEkNqbuzWgwdMpTYRZ
	 Lg/THWXWHObfMlWayI3hhx+JkkDlWbVyNZyrBMWUSnXauUHohb7Y878keSZs/kSMUM
	 48PxGoCsSYXBKycQxMj0s4ihGAHFiYZxyv2Ki8nhknqS7avD0DtBgGwMAJOw7zi0tC
	 8vlwUS9HXOWiK1eYWUSuxV1u1QJgKxdXP1R9e4c0vILJtRJUDRweH2sW7Q7QOaigUI
	 4V9PxzbbkBD/Q==
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Minghuan Lian <minghuan.Lian@nxp.com>,
	Mingkai Hu <mingkai.hu@nxp.com>,
	Roy Zang <roy.zang@nxp.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Srikanth Thokala <srikanth.thokala@intel.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Christian Bruel <christian.bruel@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	Koichiro Den <den@valinux.co.jp>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@axis.com,
	linux-rockchip@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-tegra@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 0/9] PCI: endpoint: Differentiate between disabled and reserved BARs
Date: Mon,  2 Mar 2026 10:59:12 +0100
Message-ID: <20260302095913.48155-11-cassel@kernel.org>
X-Mailer: git-send-email 2.53.0
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2516; i=cassel@kernel.org; h=from:subject; bh=IoPwRnzhcjgMfGxBVDJ5aughrS0y6ra32/Xy0hY7TLw=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDKXxheqFho7TVV4vZNPP2u59rS1LzakLTaM+X7/asqxv n3T7iV86yhlYRDjYpAVU2Tx/eGyv7jbfcpxxTs2MHNYmUCGMHBxCsBElIMYGd7tY5/em1zZdO3m KzvfZ+eOlx/NEF/1eubppbbZQi1PLHgY/mmxcaU+WXH5k4/jHZ8DVSILb83YIv9r9unVb5p6300 KuckHAA==
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Hello all,

This series was originally written in response to the patch series from
Manikanta Maddireddy that was posted here:
https://lore.kernel.org/linux-pci/291dab65-3fa6-4fc8-90a2-4ad608ca015c@nvidia.com/T/#t

Manikanta has reviewed V1 and will send a small series on top of this one.


Changes since v2:
-Picked up tags from Frank and Koichiro (thank you)
-Fixed a comment in pcie-dw-rockchip.c to no longer reflect the old
 definition of BAR_RESERVED.

Link to v2:
https://lore.kernel.org/linux-pci/20260225170324.4033466-11-cassel@kernel.org/


Koichiro Den (2):
  PCI: endpoint: Describe reserved subregions within BARs
  PCI: dw-rockchip: Describe RK3588 BAR4 DMA ctrl window

Niklas Cassel (7):
  PCI: endpoint: Introduce pci_epc_bar_type BAR_64BIT_UPPER
  PCI: endpoint: Introduce pci_epc_bar_type BAR_DISABLED
  PCI: dwc: Replace certain BAR_RESERVED with BAR_DISABLED in glue
    drivers
  PCI: dwc: Disable BARs in common code instead of in each glue driver
  PCI: endpoint: pci-epf-test: Advertise reserved BARs
  misc: pci_endpoint_test: Give reserved BARs a distinct error code
  selftests: pci_endpoint: Skip reserved BARs

 drivers/misc/pci_endpoint_test.c              | 21 ++++++++-
 drivers/pci/controller/dwc/pci-dra7xx.c       |  4 --
 drivers/pci/controller/dwc/pci-imx6.c         | 22 +++------
 drivers/pci/controller/dwc/pci-keystone.c     | 12 +++++
 .../pci/controller/dwc/pci-layerscape-ep.c    |  8 +---
 drivers/pci/controller/dwc/pcie-artpec6.c     |  4 --
 .../pci/controller/dwc/pcie-designware-ep.c   | 24 ++++++++++
 .../pci/controller/dwc/pcie-designware-plat.c | 10 -----
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 23 ++++++----
 drivers/pci/controller/dwc/pcie-keembay.c     |  6 +--
 drivers/pci/controller/dwc/pcie-qcom-ep.c     | 14 +-----
 drivers/pci/controller/dwc/pcie-rcar-gen4.c   | 16 ++-----
 drivers/pci/controller/dwc/pcie-stm32-ep.c    | 10 -----
 drivers/pci/controller/dwc/pcie-tegra194.c    | 20 +++------
 drivers/pci/controller/dwc/pcie-uniphier-ep.c | 24 +++-------
 drivers/pci/controller/pcie-rcar-ep.c         |  6 +--
 drivers/pci/endpoint/functions/pci-epf-test.c | 24 ++++++++++
 drivers/pci/endpoint/pci-epc-core.c           |  6 ++-
 include/linux/pci-epc.h                       | 45 +++++++++++++++++--
 .../pci_endpoint/pci_endpoint_test.c          |  4 ++
 20 files changed, 175 insertions(+), 128 deletions(-)


base-commit: 36bfc3642b19a98f1302aed4437c331df9b481f0
-- 
2.53.0


