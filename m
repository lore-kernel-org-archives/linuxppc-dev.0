Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3srFgV416TzDrSN
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Oct 2016 03:42:46 +1100 (AEDT)
Subject: [PATCH 7/7] PCI: layerscape: Remove unused ls_add_pcie_port()
 platform_device arg
To: Minghuan Lian <minghuan.Lian@freescale.com>,
 Mingkai Hu <mingkai.hu@freescale.com>, Roy Zang <tie-fei.zang@freescale.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Fri, 07 Oct 2016 11:42:41 -0500
Message-ID: <20161007164241.26341.32027.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007164149.26341.87049.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007164149.26341.87049.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

ls_add_pcie_port() doesn't use the platform_device pointer passed to it, so
remove it.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-layerscape.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pci-layerscape.c b/drivers/pci/host/pci-layerscape.c
index 9b74485..1694202 100644
--- a/drivers/pci/host/pci-layerscape.c
+++ b/drivers/pci/host/pci-layerscape.c
@@ -212,8 +212,7 @@ static const struct of_device_id ls_pcie_of_match[] = {
 	{ },
 };
 
-static int __init ls_add_pcie_port(struct ls_pcie *ls,
-				   struct platform_device *pdev)
+static int __init ls_add_pcie_port(struct ls_pcie *ls)
 {
 	struct pcie_port *pp = &ls->pp;
 	int ret;
@@ -262,7 +261,7 @@ static int __init ls_pcie_probe(struct platform_device *pdev)
 	if (!ls_pcie_is_bridge(ls))
 		return -ENODEV;
 
-	ret = ls_add_pcie_port(ls, pdev);
+	ret = ls_add_pcie_port(ls);
 	if (ret < 0)
 		return ret;
 
