Return-Path: <linuxppc-dev+bounces-28661-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA040CA5FD2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Oct 2026 15:34:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hwbYY6lfSz2yYf;
	Fri, 02 Oct 2026 01:34:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790868849;
	cv=none; b=JjBwLa2H8BpAzFKqMA2pVRb7GGy068O9g4rnQQlcm2qlX4M+dn6+shrCqKKZMBCADj3Ma7TtrBEl0Ekp56Al1/U+u9GoprC8GREG+eRN0oNGn8a+tdMn3YUXw4J/7L39fcfyUECEeQyqs6ACN/C9X6vibWAg234jcYlJeGeN8mSeWzrqTlhwFMVyYHt/ybTDZMd7gLb6xqvt4dZE0z+sgk4R7YB9jkIDjyR6jrUgBmgNImweS807p/EGtL3xEKNMrv2BkhxJexwRbK8xDpv2yNAh+jKvJYpmZbp6IXDW7km0VYppsyId705edao/qJRuq8/DamVl5bfTtgbbEORVvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790868849; c=relaxed/relaxed;
	bh=Gl19LhtWLKjfcWFniW5fiNkolXSpsFJsnrsmyFVH1q0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QUbeWJzDiUo/1acdsWcrr0VtLxo8zGBq3AGNR5cFMf28sUr/7cZgeRJg/PxAlJ+jW+Cu3c22XRFR2uZ8cjxRBJ0qsUkhqdbjgGMJpZx6WFWG/KrjdTiWpa/TQ2/Nq07ojBLDsLVXa2Vg/TcCoMKhBIC6Z+dbfA36SuYFtoIXQU8jsEILkzPY/Qg2i/t8EGk+yIwJNuvhxafT4J6rdVrknwA/GPjDMdqCV7nKmv6nhAGlSoDKLRC/nICRCNh+XsDIjJswxSm3i2uoXgosuZ8122F9MBiYekhZoom1hzhnOjSjBrN1NDCjybUk1nru6OC0VNJCeDvP4CPEOiYnI6J2bg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; dkim=pass (1024-bit key; unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=cZ/hamC8; dkim-atps=neutral; spf=pass (client-ip=13.77.154.182; helo=linux.microsoft.com; envelope-from=jeffbarnes@linux.microsoft.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.microsoft.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=cZ/hamC8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.microsoft.com (client-ip=13.77.154.182; helo=linux.microsoft.com; envelope-from=jeffbarnes@linux.microsoft.com; receiver=lists.ozlabs.org)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hwbYX4t6Jz2yMn
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 01:34:08 +1000 (AEST)
Received: from jeffbarnes-ThinkPad-P14s-Gen-2i.corp.microsoft.com (unknown [52.167.112.163])
	by linux.microsoft.com (Postfix) with ESMTPSA id E37D820B7168;
	Thu,  1 Oct 2026 08:32:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E37D820B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790868763;
	bh=Gl19LhtWLKjfcWFniW5fiNkolXSpsFJsnrsmyFVH1q0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cZ/hamC8umn0spRY/J9y8JezNfPCWT31hurpmlA7bpJhXsB7rbEtlOczIJ9IgD5ki
	 DQUFZKgNroCLsA4WmmLh72Pahbh2xOp5hYRpsBSEzyBn678LaUGN6qOlSNWu5hDGQ3
	 tiMpxWpqtJFgt/naaUNw8msDURvZcdOGerzo/ekw=
From: Jeff Barnes <jeffbarnes@linux.microsoft.com>
To: linux-pci@vger.kernel.org
Cc: Frank.li@oss.nxp.com,
	minghuan.Lian@nxp.com,
	mingkai.hu@nxp.com,
	roy.zang@nxp.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	Zhiqiang.Hou@nxp.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] Revert "PCI: layerscape: Change default error response behavior"
Date: Thu,  1 Oct 2026 11:33:23 -0400
Message-ID: <20261001153323.1965074-1-jeffbarnes@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0FEA6868-5A7C-4955-9FBB-BE9A1AE8D3F7@getmailspring.com>
References: <0FEA6868-5A7C-4955-9FBB-BE9A1AE8D3F7@getmailspring.com>
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

This reverts commit 84d897d69938
("PCI: layerscape: Change default error response behavior").

The Layerscape PCIe driver programs the DesignWare
AMBA_ERROR_RESPONSE_DEFAULT register at offset 0x8d0 with 0x9401.

For AXI, the documented default with AMBA_ERROR_RESPONSE_GLOBAL cleared
returns OKAY with all-ones data for errors on non-posted requests.
Setting AMBA_ERROR_RESPONSE_GLOBAL causes an AXI error response instead,
with AMBA_ERROR_RESPONSE_MAP selecting SLVERR or DECERR for individual
PCIe completion errors.

The value 0x9401 sets AMBA_ERROR_RESPONSE_GLOBAL and maps Unsupported
Request, Completer Abort, and Completion Timeout to SLVERR.

A PCI configuration access can race with the link going down after
dw_pcie_other_conf_map_bus() checks the link but before
pci_generic_config_read() performs the MMIO access. If the transaction
results in a Completion Timeout, the Layerscape error response setting
propagates it to AXI as SLVERR, resulting in an asynchronous SError and
kernel panic.

Reproduce the race by obtaining the configuration-space mapping while
the link is up, then disabling the link from another CPU immediately
before performing the MMIO configuration read.

With the error response override enabled, the overlapping configuration
read results in an asynchronous SError and kernel panic. With the
DesignWare default behavior restored, the same test returns 0xffffffff.
AER reports a non-fatal Completion Timeout, and no SError or kernel
panic occurs.

Restore the documented DesignWare default error response behavior so a
failed non-posted PCIe transaction does not become a fatal AXI error.

Fixes: 84d897d69938 ("PCI: layerscape: Change default error response behavior")
Cc: stable@vger.kernel.org
Signed-off-by: Jeff Barnes <jeffbarnes@linux.microsoft.com>

Changes in v2:
- Change the subject to identify this as a revert, as requested by
  Frank Li.
- Document the DesignWare AMBA_ERROR_RESPONSE_DEFAULT behavior and
  decode the 0x9401 setting used by Layerscape.
- Clarify that the setting propagates Completion Timeout as AXI SLVERR
  rather than causing the underlying PCIe transaction failure.

---
 drivers/pci/controller/dwc/pci-layerscape.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
index 14d6ac4fc53f..d333f1ae8a41 100644
--- a/drivers/pci/controller/dwc/pci-layerscape.c
+++ b/drivers/pci/controller/dwc/pci-layerscape.c
@@ -28,8 +28,6 @@
 
 /* PEX Internal Configuration Registers */
 #define PCIE_STRFMR1		0x71c /* Symbol Timer & Filter Mask Register1 */
-#define PCIE_ABSERR		0x8d0 /* Bridge Slave Error Response Register */
-#define PCIE_ABSERR_SETTING	0x9401 /* Forward error of non-posted request */
 
 /* PF Message Command Register */
 #define LS_PCIE_PF_MCR		0x2c
@@ -103,14 +101,6 @@ static void ls_pcie_drop_msg_tlp(struct ls_pcie *pcie)
 	iowrite32(val, pci->dbi_base + PCIE_STRFMR1);
 }
 
-/* Forward error response of outbound non-posted requests */
-static void ls_pcie_fix_error_response(struct ls_pcie *pcie)
-{
-	struct dw_pcie *pci = pcie->pci;
-
-	iowrite32(PCIE_ABSERR_SETTING, pci->dbi_base + PCIE_ABSERR);
-}
-
 static u32 ls_pcie_pf_lut_readl(struct ls_pcie *pcie, u32 off)
 {
 	if (pcie->big_endian)
@@ -180,8 +170,6 @@ static int ls_pcie_host_init(struct dw_pcie_rp *pp)
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct ls_pcie *pcie = to_ls_pcie(pci);
 
-	ls_pcie_fix_error_response(pcie);
-
 	dw_pcie_dbi_ro_wr_en(pci);
 	ls_pcie_clear_multifunction(pcie);
 	dw_pcie_dbi_ro_wr_dis(pci);
-- 
2.43.0


