Return-Path: <dkirjanov@hera.kernel.org>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3D07F1007D4
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jun 2010 01:17:05 +1000 (EST)
Date: Wed, 16 Jun 2010 15:16:59 +0000
From: Denis Kirjanov <dkirjanov@hera.kernel.org>
To: benh@kernel.crashing.org, sfr@canb.auug.org.au
Subject: [PATCH] powerpc/iseries: fix possible null pointer dereference in
	iSeries_pcibios_fixup_resources
Message-ID: <20100616151659.GA17669@hera.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I don't know if this is a right fix for the problem
since of_get_property can return NULL.
Since iseries_device_information is used only for informational purpose,
we can skip this function without valid HvSubBusNumber number.

Signed-off-by: Denis Kirjanov <dkirjanov@kernel.org>
---
arch/powerpc/platforms/iseries/pci.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/iseries/pci.c b/arch/powerpc/platforms/iseries/pci.c
index 3fc2e64..ab3962b 100644
--- a/arch/powerpc/platforms/iseries/pci.c
+++ b/arch/powerpc/platforms/iseries/pci.c
@@ -445,7 +445,11 @@ void __init iSeries_pcibios_fixup_resources(struct pci_dev *pdev)
 	}
 
 	allocate_device_bars(pdev);
-	iseries_device_information(pdev, bus, *sub_bus);
+	if (likely(sub_bus))
+		iseries_device_information(pdev, bus, *sub_bus);
+	else
+		printk(KERN_ERR "PCI: Device node %s has missing or invalid "
+				"linux,subbus property\n", node->full_name);
 }
 
 /*
