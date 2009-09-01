Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 2E5A3B70B3
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  1 Sep 2009 12:05:11 +1000 (EST)
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 12D2CDDD01
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Sep 2009 12:05:11 +1000 (EST)
Date: Tue, 1 Sep 2009 12:05:02 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: linux-next: manual merge of the pci tree with the powerpc tree
Message-Id: <20090901120502.2b40b3b1.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	linux-next@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	Richard Lary <rlary@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Jesse,

Today's linux-next merge of the pci tree got a conflict in
arch/powerpc/kernel/pci_64.c between commit
fbe65447197789a3ccccc27755956f6a4c445089 ("powerpc/pci: move pci_64.c
device tree scanning code into pci-common.c") from the powerpc tree and
commit ced66a36d35607c60d18bb531527acd2083c0523 ("PCI/powerpc: support
PCIe fundamental reset") from the pci tree.

The former moved the code that is modified by the latter into another
file.  I fixed it up (see below) and can carry the fix as necessary.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/kernel/pci_of_scan.c b/arch/powerpc/kernel/pci_of_scan.c
index 72c31bc..7311fdf 100644
--- a/arch/powerpc/kernel/pci_of_scan.c
+++ b/arch/powerpc/kernel/pci_of_scan.c
@@ -139,6 +139,7 @@ struct pci_dev *of_create_pci_dev(struct device_node *node,
 	dev->dev.bus = &pci_bus_type;
 	dev->devfn = devfn;
 	dev->multifunction = 0;		/* maybe a lie? */
+	dev->needs_freset = 0;		/* pcie fundamental reset required */
 
 	dev->vendor = get_int_prop(node, "vendor-id", 0xffff);
 	dev->device = get_int_prop(node, "device-id", 0xffff);
