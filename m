Return-Path: <bhelgaas@google.com>
Received: from mail-pa0-x230.google.com (mail-pa0-x230.google.com
 [IPv6:2607:f8b0:400e:c03::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DC18D1A0FDE
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2015 19:34:16 +1100 (AEDT)
Received: by pabkq14 with SMTP id kq14so34434249pab.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2015 00:34:15 -0800 (PST)
Subject: [PATCH v12 11/21] powerpc/pci: Don't unset PCI resources for VFs
To: Wei Yang <weiyang@linux.vnet.ibm.com>, benh@au1.ibm.com,
 gwshan@linux.vnet.ibm.com
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 24 Feb 2015 02:34:13 -0600
Message-ID: <20150224083413.32124.11968.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150224082939.32124.45744.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150224082939.32124.45744.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Wei Yang <weiyang@linux.vnet.ibm.com>

If we're going to reassign resources with flag PCI_REASSIGN_ALL_RSRC, all
resources will be cleaned out during device header fixup time and then get
reassigned by PCI core.  However, the VF resources won't be reassigned and
thus, we shouldn't clean them out.

If the pci_dev is a VF, skip the resource unset process.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/powerpc/kernel/pci-common.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 2a525c938158..82031011522f 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -788,6 +788,10 @@ static void pcibios_fixup_resources(struct pci_dev *dev)
 		       pci_name(dev));
 		return;
 	}
+
+	if (dev->is_virtfn)
+		return;
+
 	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
 		struct resource *res = dev->resource + i;
 		struct pci_bus_region reg;
