Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 973B0C77B7A
	for <linuxppc-dev@archiver.kernel.org>; Sun, 11 Jun 2023 17:25:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QfMCY293Mz2xH6
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Jun 2023 03:25:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=orcam.me.uk (client-ip=2001:4190:8020::34; helo=angie.orcam.me.uk; envelope-from=macro@orcam.me.uk; receiver=lists.ozlabs.org)
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QfM5H5VN6z301c
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Jun 2023 03:20:03 +1000 (AEST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 529979200C9; Sun, 11 Jun 2023 19:20:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 4E1479200C0;
	Sun, 11 Jun 2023 18:20:02 +0100 (BST)
Date: Sun, 11 Jun 2023 18:20:02 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Bjorn Helgaas <bhelgaas@google.com>, 
    Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
    Oliver O'Halloran <oohall@gmail.com>, 
    Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
    Christophe Leroy <christophe.leroy@csgroup.eu>, 
    Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH v9 12/14] PCI: Provide stub failed link recovery for device
 probing and hot plug
In-Reply-To: <alpine.DEB.2.21.2305310024400.59226@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2306111619570.64925@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2305310024400.59226@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Cc: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, David Abdurachmanov <david.abdurachmanov@gmail.com>, linux-rdma@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>, Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org, Stefan Roese <sr@denx.de>, Jim Wilson <wilson@tuliptree.org>, netdev@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This now fails unconditionally and will be always optimised away, but 
provides for quirks to implement recovery for failed links detected in 
device probing and device hot plug events.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
New change in v9, factored out from 7/7:

- Rename `pcie_downstream_link_retrain' to `pcie_failed_link_retrain'.

- Add stub implementation in "pci.h".
---
 drivers/pci/pci.c   |    2 ++
 drivers/pci/pci.h   |    4 ++++
 drivers/pci/probe.c |    2 ++
 3 files changed, 8 insertions(+)

linux-pcie-failed-link-retrain.diff
Index: linux-macro/drivers/pci/pci.c
===================================================================
--- linux-macro.orig/drivers/pci/pci.c
+++ linux-macro/drivers/pci/pci.c
@@ -4912,6 +4912,8 @@ static bool pcie_wait_for_link_delay(str
 	if (active)
 		msleep(20);
 	ret = pcie_wait_for_link_status(pdev, false, active);
+	if (active && !ret)
+		ret = pcie_failed_link_retrain(pdev);
 	if (active && ret)
 		msleep(delay);
 
Index: linux-macro/drivers/pci/pci.h
===================================================================
--- linux-macro.orig/drivers/pci/pci.h
+++ linux-macro/drivers/pci/pci.h
@@ -554,6 +554,10 @@ static inline int pci_dev_specific_disab
 	return -ENOTTY;
 }
 #endif
+static inline bool pcie_failed_link_retrain(struct pci_dev *dev)
+{
+	return false;
+}
 
 /* PCI error reporting and recovery */
 pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
Index: linux-macro/drivers/pci/probe.c
===================================================================
--- linux-macro.orig/drivers/pci/probe.c
+++ linux-macro/drivers/pci/probe.c
@@ -2549,6 +2549,8 @@ void pci_device_add(struct pci_dev *dev,
 	dma_set_max_seg_size(&dev->dev, 65536);
 	dma_set_seg_boundary(&dev->dev, 0xffffffff);
 
+	pcie_failed_link_retrain(dev);
+
 	/* Fix up broken headers */
 	pci_fixup_device(pci_fixup_header, dev);
 
