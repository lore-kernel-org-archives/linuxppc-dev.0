Return-Path: <jwboyer@gmail.com>
Received: from mail-yx0-f197.google.com (mail-yx0-f197.google.com
	[209.85.210.197]) by ozlabs.org (Postfix) with ESMTP id 806E7B7CEF
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  6 Feb 2010 00:55:56 +1100 (EST)
Received: by yxe35 with SMTP id 35so3747929yxe.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 05 Feb 2010 05:55:54 -0800 (PST)
Date: Fri, 5 Feb 2010 08:55:46 -0500
From: Josh Boyer <jwboyer@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 4/4] Fix iMac iSight PCI bridge setup
Message-ID: <20100205135546.GJ12001@hansolo.jdub.homelinux.org>
References: <20100205133552.GF12001@hansolo.jdub.homelinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100205133552.GF12001@hansolo.jdub.homelinux.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This works around the PCIe bridge setup on the iMac iSight boxen.

---

--- linux/arch/powerpc/platforms/powermac/pci.c~	2008-03-22 19:08:07.000000000 +0000
+++ linux/arch/powerpc/platforms/powermac/pci.c	2008-03-23 09:10:46.000000000 +0000
@@ -1271,6 +1271,12 @@ void pmac_pci_fixup_pciata(struct pci_de
 	}
 }
 DECLARE_PCI_FIXUP_EARLY(PCI_ANY_ID, PCI_ANY_ID, pmac_pci_fixup_pciata);
+#else /* CONFIG_PPC64 */
+static void __devinit imac_transparent_bridge(struct pci_dev *dev)
+{
+	dev->transparent = 1;
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_APPLE, 0x005b, imac_transparent_bridge);
 #endif /* CONFIG_PPC32 */
 
 /*
