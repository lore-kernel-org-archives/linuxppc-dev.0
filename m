Return-Path: <bhelgaas@google.com>
Received: from mail-ie0-x232.google.com (mail-ie0-x232.google.com
 [IPv6:2607:f8b0:4001:c03::232])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1F05F2C00E8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 May 2013 09:19:14 +1000 (EST)
Received: by mail-ie0-f178.google.com with SMTP id b11so14618870iee.23
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 May 2013 16:19:11 -0700 (PDT)
Subject: [PATCH 1/2] powerpc/PCI: Use PCI_UNKNOWN for unknown power state
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, "David S. Miller" <davem@davemloft.net>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 20 May 2013 17:19:09 -0600
Message-ID: <20130520231909.32416.81752.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: sparclinux@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>,
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Previously we initialized dev->current_state to 4 (PCI_D3cold), but I think
we wanted PCI_UNKNOWN (5) here based on the comment and the fact that the
generic version of this code, pci_setup_device(), uses PCI_UNKNOWN.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/powerpc/kernel/pci_of_scan.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/pci_of_scan.c b/arch/powerpc/kernel/pci_of_scan.c
index 2a67e9b..d2d407d 100644
--- a/arch/powerpc/kernel/pci_of_scan.c
+++ b/arch/powerpc/kernel/pci_of_scan.c
@@ -165,7 +165,7 @@ struct pci_dev *of_create_pci_dev(struct device_node *node,
 	pr_debug("    class: 0x%x\n", dev->class);
 	pr_debug("    revision: 0x%x\n", dev->revision);
 
-	dev->current_state = 4;		/* unknown power state */
+	dev->current_state = PCI_UNKNOWN;	/* unknown power state */
 	dev->error_state = pci_channel_io_normal;
 	dev->dma_mask = 0xffffffff;
 
