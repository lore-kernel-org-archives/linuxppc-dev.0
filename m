Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wr0-x244.google.com (mail-wr0-x244.google.com
 [IPv6:2a00:1450:400c:c0c::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 406dN5195TzF203
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 07:20:53 +1100 (AEDT)
Received: by mail-wr0-x244.google.com with SMTP id p53so2474973wrc.10
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 13:20:52 -0700 (PDT)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: [PATCH 07/19] powerpc/powermac: Make some functions static
Date: Thu, 22 Mar 2018 21:19:53 +0100
Message-Id: <20180322202007.23088-8-malat@debian.org>
In-Reply-To: <20180322202007.23088-1-malat@debian.org>
References: <20180322202007.23088-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These functions can all be static, make it so. Fix warnings treated as
errors with W=1:

  arch/powerpc/platforms/powermac/pci.c:1022:6: error: no previous prototype for ‘pmac_pci_fixup_ohci’ [-Werror=missing-prototypes]
  arch/powerpc/platforms/powermac/pci.c:1057:6: error: no previous prototype for ‘pmac_pci_fixup_cardbus’ [-Werror=missing-prototypes]
  arch/powerpc/platforms/powermac/pci.c:1094:6: error: no previous prototype for ‘pmac_pci_fixup_pciata’ [-Werror=missing-prototypes]

Also add gcc attribute unused to fix a warning treated as error with W=1:

  arch/powerpc/platforms/powermac/pci.c:784:19: error: variable ‘has_address’ set but not used [-Werror=unused-but-set-variable]
  arch/powerpc/platforms/powermac/pci.c:907:22: error: variable ‘ht’ set but not used [-Werror=unused-but-set-variable]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/platforms/powermac/pci.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/pci.c b/arch/powerpc/platforms/powermac/pci.c
index 0b8174a79993..d3b9818dd880 100644
--- a/arch/powerpc/platforms/powermac/pci.c
+++ b/arch/powerpc/platforms/powermac/pci.c
@@ -781,7 +781,7 @@ static int __init pmac_add_bridge(struct device_node *dev)
 	struct resource rsrc;
 	char *disp_name;
 	const int *bus_range;
-	int primary = 1, has_address = 0;
+	int primary = 1, has_address __maybe_unused = 0;
 
 	DBG("Adding PCI host bridge %pOF\n", dev);
 
@@ -904,7 +904,7 @@ static int pmac_pci_root_bridge_prepare(struct pci_host_bridge *bridge)
 void __init pmac_pci_init(void)
 {
 	struct device_node *np, *root;
-	struct device_node *ht = NULL;
+	struct device_node *ht __maybe_unused = NULL;
 
 	pci_set_flags(PCI_CAN_SKIP_ISA_ALIGN);
 
@@ -1019,7 +1019,7 @@ static bool pmac_pci_enable_device_hook(struct pci_dev *dev)
 	return true;
 }
 
-void pmac_pci_fixup_ohci(struct pci_dev *dev)
+static void pmac_pci_fixup_ohci(struct pci_dev *dev)
 {
 	struct device_node *node = pci_device_to_OF_node(dev);
 
@@ -1054,7 +1054,7 @@ void __init pmac_pcibios_after_init(void)
 	}
 }
 
-void pmac_pci_fixup_cardbus(struct pci_dev* dev)
+static void pmac_pci_fixup_cardbus(struct pci_dev *dev)
 {
 	if (!machine_is(powermac))
 		return;
@@ -1091,7 +1091,7 @@ void pmac_pci_fixup_cardbus(struct pci_dev* dev)
 
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_TI, PCI_ANY_ID, pmac_pci_fixup_cardbus);
 
-void pmac_pci_fixup_pciata(struct pci_dev* dev)
+static void pmac_pci_fixup_pciata(struct pci_dev *dev)
 {
        u8 progif = 0;
 
-- 
2.11.0
