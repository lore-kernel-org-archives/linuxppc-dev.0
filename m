Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38793C4332F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Nov 2023 01:38:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4STBsZ6MWbz3cHf
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Nov 2023 12:38:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=renesas.com (client-ip=210.160.252.172; helo=relmlie6.idc.renesas.com; envelope-from=yoshihiro.shimoda.uh@renesas.com; receiver=lists.ozlabs.org)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4STBs00YTmz3c1J
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Nov 2023 12:38:11 +1100 (AEDT)
X-IronPort-AV: E=Sophos;i="6.03,298,1694703600"; 
   d="scan'208";a="186494700"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 13 Nov 2023 10:33:02 +0900
Received: from localhost.localdomain (unknown [10.166.13.99])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 60B8740031CF;
	Mon, 13 Nov 2023 10:33:02 +0900 (JST)
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	jingoohan1@gmail.com,
	gustavo.pimentel@synopsys.com,
	mani@kernel.org,
	minghuan.Lian@nxp.com,
	mingkai.hu@nxp.com,
	roy.zang@nxp.com
Subject: [PATCH 0/3] PCI: dwc: Improve code readability
Date: Mon, 13 Nov 2023 10:32:57 +0900
Message-Id: <20231113013300.2132152-1-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-renesas-soc@vger.kernel.org, linux-pci@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linuxppc-dev@lists.ozlabs.org, marek.vasut+renesas@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This patch series is based on the latest pci.git / next branch.
The patch 1/3 is related to the "note" in the commit [1]
The patches [23]/3 are related to the "Note" which in the commit [2].

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9baa8a18e31b7167885c11c38841ce92bbe20f4f

[2]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7873b49b41b92edb3395bff9a528eaf89da5e41c

Yoshihiro Shimoda (3):
  PCI: dwc: Rename to .init in struct dw_pcie_ep_ops
  PCI: dwc: Rename to .get_dbi_offset in struct dw_pcie_ep_ops
  PCI: dwc: Add dw_pcie_ep_{read,write}_dbi[2] helpers

 drivers/pci/controller/dwc/pci-dra7xx.c       |   2 +-
 drivers/pci/controller/dwc/pci-imx6.c         |   2 +-
 drivers/pci/controller/dwc/pci-keystone.c     |   2 +-
 .../pci/controller/dwc/pci-layerscape-ep.c    |   7 +-
 drivers/pci/controller/dwc/pcie-artpec6.c     |   2 +-
 .../pci/controller/dwc/pcie-designware-ep.c   | 248 ++++++++++--------
 .../pci/controller/dwc/pcie-designware-plat.c |   2 +-
 drivers/pci/controller/dwc/pcie-designware.h  |   4 +-
 drivers/pci/controller/dwc/pcie-keembay.c     |   2 +-
 drivers/pci/controller/dwc/pcie-qcom-ep.c     |   2 +-
 drivers/pci/controller/dwc/pcie-rcar-gen4.c   |   6 +-
 drivers/pci/controller/dwc/pcie-uniphier-ep.c |   2 +-
 12 files changed, 154 insertions(+), 127 deletions(-)

-- 
2.34.1

