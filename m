Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 08/63] powerpc/pci: Don't use bitfield for force_32bit_msi
Date: Wed,  7 Aug 2013 02:01:25 +1000
Message-Id: <1375804940-22050-9-git-send-email-anton@samba.org>
In-Reply-To: <1375804940-22050-1-git-send-email-anton@samba.org>
References: <1375804940-22050-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix a sparse warning about force_32bit_msi being a one bit bitfield.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/include/asm/pci-bridge.h | 2 +-
 arch/powerpc/kernel/pci_64.c          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 32d0d20..4ca90a3 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -159,7 +159,7 @@ struct pci_dn {
 
 	int	pci_ext_config_space;	/* for pci devices */
 
-	int	force_32bit_msi:1;
+	bool	force_32bit_msi;
 
 	struct	pci_dev *pcidev;	/* back-pointer to the pci device */
 #ifdef CONFIG_EEH
diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index cdf5aa1..a9e311f 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -272,7 +272,7 @@ static void quirk_radeon_32bit_msi(struct pci_dev *dev)
 	struct pci_dn *pdn = pci_get_pdn(dev);
 
 	if (pdn)
-		pdn->force_32bit_msi = 1;
+		pdn->force_32bit_msi = true;
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x68f2, quirk_radeon_32bit_msi);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0xaa68, quirk_radeon_32bit_msi);
-- 
1.8.1.2
