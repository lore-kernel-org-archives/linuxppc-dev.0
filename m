Return-Path: <linuxppc-dev+bounces-16919-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBDB6E9A03B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Feb 2026 21:27:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fFt5r1tSfz2xGF;
	Wed, 18 Feb 2026 08:27:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771363664;
	cv=none; b=SeHSZnsCBYXcvB7Cei3Z47ZtQDLYugT4wJOHI6jwi822BNGKMLv0fn5LmMN/ORsUngHXjRtd024+R6ZwUZJPf2MYIqA3PpMbKdICIvBKlbHLRHSc87aoT+hnJVrVCfhoEwYhmsEODm20tkJWOuM14qCuCQActmWGu+q72She8kB3x2ovnhvrxm8vXI8IBmwOXR8x6vCJPAziNzpMy3J8eX4ptlYEgjqYkes6frVhFODp/y9rRkhkBLf15ZX+GK0Cklp5dJvKEqzkLQNNlMKBgQg4PjpvytAHwU6MH2qLlAWvsfM7LaO/DAkpf+PdQx90GkU5tkpUHMifB34DWYbdJw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771363664; c=relaxed/relaxed;
	bh=9UVwh5LX1ne7K870kYuzu1a0ArOy+98xg4U/ptRNkE0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zmj+Xxz9cWk7lGERHqNSurWhkzVEhVbKyzcPZmIJGftfyLpW+3ubNCKvrY+gWrKtcvunNiNfAkJDhdfrlYGlQgkY6WFlnbS4jEPR1q5w14THf8OvuihFtdpje1xJkUjA48XWYaefWEgOKa9ntEc7QLMUvNwIltdYiONMbXt/UAKwXAyaasSwXsLPlm6zKq43VsBrAT5fvhFlwJvsMapZHoxdSSaD8he2HGjBtAAbzo+9w9moLEBhAw2Bv6urdHZI3X/IhaXw8H9CuJ7BGXoPCKwmg52N0xkGNivneBrhYL6Bgz5j1/NRprBJozW1cWGMT/A/LZsiD+WYFFFJcMkuvg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=HZ+UvMiP; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=cassel@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=HZ+UvMiP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=cassel@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fFt5q2GHHz2x99
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Feb 2026 08:27:43 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 048B761850;
	Tue, 17 Feb 2026 21:27:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 434F1C19425;
	Tue, 17 Feb 2026 21:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771363659;
	bh=qNdMPHb96ahPcc/FeBg2GRFGtCGsjvYyDufUCB6E5Ho=;
	h=From:To:Cc:Subject:Date:From;
	b=HZ+UvMiPz7y6Wfbsg5SRIDmn+CDWDBq3WDUKPIFYPfrmgDfHjQ7tHHZYvBxWMJPsB
	 c/PD0XktfttvuKxs+WJlENDTRUP8uJUYdvpCSgzgXvAFzPfb1B0rOK7s3NAuWfL7OM
	 PDp3ZyEtU/CFNB0WzAkeTuWX12cuXeEN250jg2mphb4+0a1UOP9URjezN/AWag41Q0
	 roA2SWQuJbNqVoB7NWp23sapC1Dm1S393B1Qqcg98UxhXC9rBuSiwP8ArfAEkppYLo
	 6sj4h5uEjhL1y9XxP5IphJD17zDcGD3gK+k+4gZR6DYzXHK6BRPDR/D2adYfFq7DLA
	 JcoQPGf6g5NxA==
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
Subject: [PATCH 0/9] PCI: endpoint differentiate between disabled and reserved BARs
Date: Tue, 17 Feb 2026 22:27:06 +0100
Message-ID: <20260217212707.2450423-11-cassel@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4061; i=cassel@kernel.org; h=from:subject; bh=qNdMPHb96ahPcc/FeBg2GRFGtCGsjvYyDufUCB6E5Ho=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDKn3NV+yyX95M1+T1HDqxGLE9Ks+cRk7p+2exh8+ZCxj pjCijkGHaUsDGJcDLJiiiy+P1z2F3e7TzmueMcGZg4rE8gQBi5OAZhI+E5GhguPHi2/Xb/y3DHB AIf6hAuN+VPmNN0usdy7vDq+avG27bYM/5S3MBlKbLy8vGB/jfcrobctfIebJrjrnqw9slP/atc TAw4A
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Hello all,

This series is written in response to the patch series from
Manikanta Maddireddy that was posted here:
https://lore.kernel.org/linux-pci/291dab65-3fa6-4fc8-90a2-4ad608ca015c@nvidia.com/T/#t

The reasons why I decided to post this a new series was because the series
above:

1) Adds PCI device and vendor specific code to
drivers/misc/pci_endpoint_test.c. We've worked hard to make sure that
device specific quirks/limitations are communicated via the Capabilities
register, so let's do the same for reserved BARs.

2) My review comment which suggested to convert all uses of BAR_RESERVED
to BAR_DISABLED (except for pci-keystone.c) was ignored.

3) Koichiro has posted a series that allows an EPC driver to define exactly
which hardware backed resources are provided in a BAR_RESERVED BAR. Yet,
this nice improvement was not incorporated. (While Mankata was part of the
discussion, he was not CC:d on the patches that actually implemented this.)

4) The selftests should return skip instead of silent success for a
reserved BAR.

5) As Mankata points out, but did not address, BAR_RESERVED is quite
ambiguous, so it is better to introduce a new BAR_64BIT_UPPER to more
clearly mark the upper part of a 64-bit BAR as this, rather than reuse
BAR_RESERVED.

6) It is possible to remove all the dw_pcie_ep_reset_bar() calls in the
DWC based glue drivers and move it to DWC common code.


Because of all of the above, I thought it was just easier to post a series
with all of the above addressed, as it seemed easier to just show what I
meant rather than to try to explain things with words.

The thing that is missing is to add a patch for pcie-tegra194.c which
converts the BARs to BAR_RESERVED.
Please see patch "PCI: dw-rockchip: Describe RK3588 BAR4 DMA ctrl window"
and do something similar to pcie-tegra194.c.

If we are missing some resources (right now we only have
PCI_EPC_BAR_RSVD_DMA_CTRL_MMIO), then I think we should simple add that
(e.g. PCI_EPC_BAR_RSVD_MSIX).

Mankata, it would be nice if you could test this series, and if you could
provide a pcie-tegra194.c patch that adds the sizes of the eDMA regs +
MSI-X table in BAR_2 and BAR_4.


Kind regards,
Niklas


Koichiro Den (2):
  PCI: endpoint: Describe reserved subregions within BARs
  PCI: dw-rockchip: Describe RK3588 BAR4 DMA ctrl window

Niklas Cassel (7):
  PCI: endpoint: Introduce pci_epc_bar_type BAR_64BIT_UPPER
  PCI: endpoint: Introduce pci_epc_bar_type BAR_DISABLED
  PCI: dwc: Replace BAR_RESERVED with BAR_DISABLED in glue drivers
  PCI: dwc: Disable BARs in common code instead of in each glue driver
  PCI: endpoint: pci-epf-test: Advertise reserved BARs
  misc: pci_endpoint_test: Give reserved BARs a distinct error code
  selftests: pci_endpoint: Skip reserved BARs

 drivers/misc/pci_endpoint_test.c              | 32 ++++++++++++-
 drivers/pci/controller/dwc/pci-dra7xx.c       |  4 --
 drivers/pci/controller/dwc/pci-imx6.c         | 22 +++------
 .../pci/controller/dwc/pci-layerscape-ep.c    |  8 +---
 drivers/pci/controller/dwc/pcie-artpec6.c     |  4 --
 .../pci/controller/dwc/pcie-designware-ep.c   | 24 ++++++++++
 .../pci/controller/dwc/pcie-designware-plat.c | 10 -----
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 19 +++++---
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
 19 files changed, 173 insertions(+), 125 deletions(-)

-- 
2.53.0


