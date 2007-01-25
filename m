Return-Path: <michael@ozlabs.org>
To: linux-pci@atrey.karlin.mff.cuni.cz
From: Michael Ellerman <michael@ellerman.id.au>
Date: Thu, 25 Jan 2007 19:34:07 +1100
Subject: [RFC/PATCH 1/16] Replace pci_msi_quirk with calls to pci_no_msi()
In-Reply-To: <1169714047.65693.647693675533.qpush@cradle>
Message-Id: <20070125083408.DC5BEDE24D@ozlabs.org>
Cc: Greg Kroah-Hartman <greg@kroah.com>, Kyle McMartin <kyle@parisc-linux.org>,
	linuxppc-dev@ozlabs.org, Brice Goglin <brice@myri.com>,
	shaohua.li@intel.com, "David S. Miller" <davem@davemloft.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I don't see any reason why we need pci_msi_quirk, quirk code can just
call pci_no_msi() instead.

Remove the check of pci_msi_quirk in msi_init(). This is safe as all
calls to msi_init() are protected by calls to pci_msi_supported(),
which checks pci_msi_enable, which is disabled by pci_no_msi().

The pci_disable_msi routines didn't check pci_msi_quirk, only
pci_msi_enable, but as far as I can see that was a bug not a feature.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 drivers/net/bnx2.c   |    3 +--
 drivers/pci/msi.c    |    7 -------
 drivers/pci/pci.h    |    6 +-----
 drivers/pci/quirks.c |    7 ++-----
 4 files changed, 4 insertions(+), 19 deletions(-)

Index: msi/drivers/net/bnx2.c
===================================================================
--- msi.orig/drivers/net/bnx2.c
+++ msi/drivers/net/bnx2.c
@@ -5942,8 +5942,7 @@ bnx2_init_board(struct pci_dev *pdev, st
 	 * responding after a while.
 	 *
 	 * AMD believes this incompatibility is unique to the 5706, and
-	 * prefers to locally disable MSI rather than globally disabling it
-	 * using pci_msi_quirk.
+	 * prefers to locally disable MSI rather than globally disabling it.
 	 */
 	if (CHIP_NUM(bp) == CHIP_NUM_5706 && disable_msi == 0) {
 		struct pci_dev *amd_8132 = NULL;
Index: msi/drivers/pci/msi.c
===================================================================
--- msi.orig/drivers/pci/msi.c
+++ msi/drivers/pci/msi.c
@@ -169,13 +169,6 @@ static int msi_init(void)
 	if (!status)
 		return status;
 
-	if (pci_msi_quirk) {
-		pci_msi_enable = 0;
-		printk(KERN_WARNING "PCI: MSI quirk detected. MSI disabled.\n");
-		status = -EINVAL;
-		return status;
-	}
-
 	status = msi_cache_init();
 	if (status < 0) {
 		pci_msi_enable = 0;
Index: msi/drivers/pci/pci.h
===================================================================
--- msi.orig/drivers/pci/pci.h
+++ msi/drivers/pci/pci.h
@@ -43,12 +43,8 @@ extern void pci_remove_legacy_files(stru
 /* Lock for read/write access to pci device and bus lists */
 extern struct rw_semaphore pci_bus_sem;
 
-#ifdef CONFIG_PCI_MSI
-extern int pci_msi_quirk;
-#else
-#define pci_msi_quirk 0
-#endif
 extern unsigned int pci_pm_d3_delay;
+
 #ifdef CONFIG_PCI_MSI
 void disable_msi_mode(struct pci_dev *dev, int pos, int type);
 void pci_no_msi(void);
Index: msi/drivers/pci/quirks.c
===================================================================
--- msi.orig/drivers/pci/quirks.c
+++ msi/drivers/pci/quirks.c
@@ -1682,9 +1682,6 @@ DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_N
 			quirk_nvidia_ck804_pcie_aer_ext_cap);
 
 #ifdef CONFIG_PCI_MSI
-/* To disable MSI globally */
-int pci_msi_quirk;
-
 /* The Serverworks PCI-X chipset does not support MSI. We cannot easily rely
  * on setting PCI_BUS_FLAGS_NO_MSI in its bus flags because there are actually
  * some other busses controlled by the chipset even if Linux is not aware of it.
@@ -1693,8 +1690,8 @@ int pci_msi_quirk;
  */
 static void __init quirk_svw_msi(struct pci_dev *dev)
 {
-	pci_msi_quirk = 1;
-	printk(KERN_WARNING "PCI: MSI quirk detected. pci_msi_quirk set.\n");
+	pci_no_msi();
+	printk(KERN_WARNING "PCI: MSI quirk detected. MSI deactivated.\n");
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_GCNB_LE, quirk_svw_msi);
 
