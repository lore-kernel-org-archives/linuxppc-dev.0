Return-Path: <linuxppc-dev+bounces-20653-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CD8CCD343F
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 May 2026 13:56:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gCSFc43Bwz2xnK;
	Sat, 09 May 2026 23:56:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=117.135.210.4
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778334980;
	cv=none; b=YKLCoDXtRJOrJbZP3bi5uRwUpZwLfCXVa5VPpV7GV4uYTgRHRzAl+WUTueMZK9aDuZF6VI3aRVH+SGZ5sQQ4HNTSv1SoZ3z9AxD+dOxpBhBYdRZWe13GUeIDVdzrEdr+gQPgvXzo5UERsbJtvdOh04jVzW5CcPduEOvwmuh1efg8oasyfPiYiV58tl6oFTP9KfaHphLehfaYEMS0e4M49eC9IfI0k0f5NjhN+ZE04GL3GZs7W6qpdLg3XJJS3BwRRtJsuouR4BAyD6JQDR4XJpgE4hPo5xsW8OVJ+h8aWTnxNF5bVrZX9NxmuIZbekVmxWYCK+1Gz5mIcPmh1b0tXw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778334980; c=relaxed/relaxed;
	bh=mIOPut41WSK0wYvb6vxdmeoEPL8RRyCrJZJUvtEZxAE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mt5JSP8qiETj56XWUalWGIs+YOOkOMwLgv/kEJ5Bx0JrXoN5Z4NTnBdGNlK0eKAg/f3TEQAZ1F/JwT2M++RCJpyoQZSOjGj4Z7zbfm6+90l7SST+S/EUtsfv+mjJSDqh76OiHil3tKmWXXtON3iT6e/7IYsXgeW4AuclVFOyFIwc+vVVKp56ZmhOAJj0v2xR3oHiOiB5V9LwnXIn4mWAj1vK0Cv1xfO8LQYM6AWhMmAGvTEBfcmnKR0IAvBqA6jJgGaX2+pCyRLxOECs75LUXz0zr1+8M6hqdXDLFM8UJI+qLLMI7D1c+NYqO9MsofLmzYnZ/DKG71Uq52+jiWzuvw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=XC8ZlNs3; dkim-atps=neutral; spf=pass (client-ip=117.135.210.4; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=XC8ZlNs3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=117.135.210.4; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gCSFW3dDGz2xqv
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 09 May 2026 23:56:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=mI
	OPut41WSK0wYvb6vxdmeoEPL8RRyCrJZJUvtEZxAE=; b=XC8ZlNs3NhGX18IY9t
	j6I6UhqXs73kv2pIp/r9Gt5lUsDCkK0iccAYOOx8W7o1m7VhAxFqoode05hmjDj/
	cpYcpOSUU/AFOqZfeipmG2LaOlBLEi/vLumvaHFGT7P+0sPXLINCJd5ShbVRSCEG
	M2yZDdph28Cc/jCHv0gpHkUyM=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDXLzL8O_9p486jAQ--.37610S2;
	Sat, 09 May 2026 21:51:57 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	jingoohan1@gmail.com
Cc: mx@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-amlogic@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH 0/3] PCI: dwc: Cache PCIe capability offset and simplify drivers
Date: Sat,  9 May 2026 21:51:49 +0800
Message-Id: <20260509135152.2241235-1-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:_____wDXLzL8O_9p486jAQ--.37610S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw1kuFy3ZryfAw4ruFWxWFg_yoW8CF1rpa
	y5tFWIyF1rtF4avF4Yy3WDuF13t3Z7AFWDK39xW3WSvFyaka1UXr1rtryrtr9rtrWIqr13
	Kr1Uta47GF4fJFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziO6pDUUUUU=
X-Originating-IP: [140.206.53.66]
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCwx1oDGn-O-395gAA3x

The DWC PCIe core and its many platform drivers repeatedly call
dw_pcie_find_capability(pci, PCI_CAP_ID_EXP) to obtain the offset of the
PCI Express Capability structure. This is wasteful and makes the code
verbose. And some even search for the PCI_CAP_ID_EXP offset value within
the suspend/resume functions.

Add a cached pcie_cap field in struct dw_pcie and a helper
dw_pcie_get_pcie_cap() to initialize it once at probe time. Then replace
all explicit capability searches with the cached value across the
entire dwc subtree.

Hans Zhang (3):
  PCI: dwc: Add pcie_cap field and helper in designware header
  PCI: dwc: Use cached PCIe capability offset in core
  PCI: dwc: Simplify platform drivers using cached capability offset

 drivers/pci/controller/dwc/pci-imx6.c         |  6 +--
 .../pci/controller/dwc/pci-layerscape-ep.c    |  4 +-
 drivers/pci/controller/dwc/pci-meson.c        |  4 +-
 .../pci/controller/dwc/pcie-designware-ep.c   |  4 +-
 .../pci/controller/dwc/pcie-designware-host.c |  4 +-
 drivers/pci/controller/dwc/pcie-designware.c  | 16 +++---
 drivers/pci/controller/dwc/pcie-designware.h  | 17 +++++++
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 15 +++---
 drivers/pci/controller/dwc/pcie-eswin.c       |  3 +-
 drivers/pci/controller/dwc/pcie-fu740.c       |  2 +-
 drivers/pci/controller/dwc/pcie-intel-gw.c    |  2 +-
 drivers/pci/controller/dwc/pcie-qcom-ep.c     | 11 ++--
 drivers/pci/controller/dwc/pcie-qcom.c        | 24 ++++-----
 drivers/pci/controller/dwc/pcie-sophgo.c      |  8 ++-
 drivers/pci/controller/dwc/pcie-spacemit-k1.c |  5 +-
 drivers/pci/controller/dwc/pcie-spear13xx.c   |  6 +--
 drivers/pci/controller/dwc/pcie-tegra194.c    | 51 +++++++------------
 17 files changed, 85 insertions(+), 97 deletions(-)


base-commit: 70390501d1944d4e5b8f7352be180fceb3a44132
-- 
2.34.1


