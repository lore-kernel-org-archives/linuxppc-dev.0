Return-Path: <SRS0=Sqku=EL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79839C55178
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2020 21:17:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9865620724
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2020 21:17:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9865620724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CRxDw1f6czDrB3
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Nov 2020 08:17:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=209.85.210.65; helo=mail-ot1-f65.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com
 [209.85.210.65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CRx6h0ZLCzDr48
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Nov 2020 08:12:11 +1100 (AEDT)
Received: by mail-ot1-f65.google.com with SMTP id i18so2807895ots.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2020 13:12:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6joTqsvyj5X+/mMckRYOhYHQCTeXTFX8sI/b999CKSE=;
 b=MLB2LO4uv8DVcJ4KX4flcwL6Z00unEndJ3wX6LcGGl/Svukm+G2dHbbqnL+Xv/TAM+
 AJlcS7g9UJ2kJdksUIYsBm3eG3feu7cuvB4stWmeqcvBb++hbsJJPPHxwDkiMKeb6LTc
 OAemDDoNVw0TvQyo4Bhhzzb8Jrbof+b6kMSHWLOkoZ+d0S8qA0GgVMQhcf46kvqccj3I
 a6NL4PLWr3C9B99/fDIQ5J5Vurpb9dWQdKMWCm/s2x/I6euBB+jGNdrMJhkpdJF1jDUv
 ShZlRHHcrhZURheNSn0IUZXPCYfjChFsJ8oWcsJMQm5f1b8LgivAXjfjZiMrAdDWcMA/
 O14A==
X-Gm-Message-State: AOAM5318/ptD6vcnTGYQkySpA1MeiYRgFS4WiU+kgzANZXOQHgHHtm5Q
 qsNd4pNrJlP5Z6/PyO06nw==
X-Google-Smtp-Source: ABdhPJy703tWPiNw+Qqc8ucrmYgfKgqd7wtzHksUUpAdBdq/hY3pvYUxigfqVa2L2+navOGrdkxvaw==
X-Received: by 2002:a9d:550a:: with SMTP id l10mr2713270oth.357.1604610729465; 
 Thu, 05 Nov 2020 13:12:09 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id z19sm622549ooi.32.2020.11.05.13.12.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 13:12:08 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: 
Subject: [PATCH v2 05/16] PCI: dwc: Ensure all outbound ATU windows are reset
Date: Thu,  5 Nov 2020 15:11:48 -0600
Message-Id: <20201105211159.1814485-6-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201105211159.1814485-1-robh@kernel.org>
References: <20201105211159.1814485-1-robh@kernel.org>
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
Cc: Roy Zang <roy.zang@nxp.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 linux-pci@vger.kernel.org, Minghuan Lian <minghuan.Lian@nxp.com>,
 linux-arm-kernel@lists.infradead.org, Jingoo Han <jingoohan1@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
 linuxppc-dev@lists.ozlabs.org, Mingkai Hu <mingkai.hu@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The Layerscape driver clears the ATU registers which may have been
configured by the bootloader. Any driver could have the same issue
and doing it for all drivers doesn't hurt, so let's move it into the
common DWC code.

Cc: Minghuan Lian <minghuan.Lian@nxp.com>
Cc: Mingkai Hu <mingkai.hu@nxp.com>
Cc: Roy Zang <roy.zang@nxp.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: linuxppc-dev@lists.ozlabs.org
Acked-by: Jingoo Han <jingoohan1@gmail.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pci-layerscape.c       | 14 --------------
 drivers/pci/controller/dwc/pcie-designware-host.c |  5 +++++
 2 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
index f24f79a70d9a..53e56d54c482 100644
--- a/drivers/pci/controller/dwc/pci-layerscape.c
+++ b/drivers/pci/controller/dwc/pci-layerscape.c
@@ -83,14 +83,6 @@ static void ls_pcie_drop_msg_tlp(struct ls_pcie *pcie)
 	iowrite32(val, pci->dbi_base + PCIE_STRFMR1);
 }
 
-static void ls_pcie_disable_outbound_atus(struct ls_pcie *pcie)
-{
-	int i;
-
-	for (i = 0; i < PCIE_IATU_NUM; i++)
-		dw_pcie_disable_atu(pcie->pci, i, DW_PCIE_REGION_OUTBOUND);
-}
-
 static int ls1021_pcie_link_up(struct dw_pcie *pci)
 {
 	u32 state;
@@ -136,12 +128,6 @@ static int ls_pcie_host_init(struct pcie_port *pp)
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct ls_pcie *pcie = to_ls_pcie(pci);
 
-	/*
-	 * Disable outbound windows configured by the bootloader to avoid
-	 * one transaction hitting multiple outbound windows.
-	 * dw_pcie_setup_rc() will reconfigure the outbound windows.
-	 */
-	ls_pcie_disable_outbound_atus(pcie);
 	ls_pcie_fix_error_response(pcie);
 
 	dw_pcie_dbi_ro_wr_en(pci);
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index cde45b2076ee..265a48f1a0ae 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -534,6 +534,7 @@ static struct pci_ops dw_pcie_ops = {
 
 void dw_pcie_setup_rc(struct pcie_port *pp)
 {
+	int i;
 	u32 val, ctrl, num_ctrls;
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 
@@ -583,6 +584,10 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 		PCI_COMMAND_MASTER | PCI_COMMAND_SERR;
 	dw_pcie_writel_dbi(pci, PCI_COMMAND, val);
 
+	/* Ensure all outbound windows are disabled so there are multiple matches */
+	for (i = 0; i < pci->num_viewport; i++)
+		dw_pcie_disable_atu(pci, i, DW_PCIE_REGION_OUTBOUND);
+
 	/*
 	 * If the platform provides its own child bus config accesses, it means
 	 * the platform uses its own address translation component rather than
-- 
2.25.1

