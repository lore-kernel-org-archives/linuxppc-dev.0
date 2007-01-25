Return-Path: <gregkh@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 02106DE4D2
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 09:34:22 +1100 (EST)
Subject: patch msi-replace-pci_msi_quirk-with-calls-to-pci_no_msi.patch added
	to gregkh-2.6 tree
To: michael@ellerman.id.au, brice@myri.com, davem@davemloft.net,
	ebiederm@xmission.com, greg@kroah.com, gregkh@suse.de,
	kyle@parisc-linux.org, linuxppc-dev@ozlabs.org, shaohua.li@intel.com
From: <gregkh@suse.de>
Date: Thu, 25 Jan 2007 14:33:25 -0800
In-Reply-To: <20070125083408.DC5BEDE24D@ozlabs.org>
Message-Id: <20070125223416.8348BB77C51@imap.suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This is a note to let you know that I've just added the patch titled

     Subject: MSI: Replace pci_msi_quirk with calls to pci_no_msi()

to my gregkh-2.6 tree.  Its filename is

     msi-replace-pci_msi_quirk-with-calls-to-pci_no_msi.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/


>From michael@ozlabs.org  Thu Jan 25 14:12:24 2007
From: Michael Ellerman <michael@ellerman.id.au>
Date: Thu, 25 Jan 2007 19:34:07 +1100
Subject: MSI: Replace pci_msi_quirk with calls to pci_no_msi()
To: linux-pci@atrey.karlin.mff.cuni.cz
Cc: Greg Kroah-Hartman <greg@kroah.com>, Eric W. Biederman <ebiederm@xmission.com>, David S. Miller <davem@davemloft.net>, Kyle McMartin <kyle@parisc-linux.org>, <linuxppc-dev@ozlabs.org>, Brice Goglin <brice@myri.com>, <shaohua.li@intel.com>
Message-ID: <20070125083408.DC5BEDE24D@ozlabs.org>


I don't see any reason why we need pci_msi_quirk, quirk code can just
call pci_no_msi() instead.

Remove the check of pci_msi_quirk in msi_init(). This is safe as all
calls to msi_init() are protected by calls to pci_msi_supported(),
which checks pci_msi_enable, which is disabled by pci_no_msi().

The pci_disable_msi routines didn't check pci_msi_quirk, only
pci_msi_enable, but as far as I can see that was a bug not a feature.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/net/bnx2.c   |    3 +--
 drivers/pci/msi.c    |    7 -------
 drivers/pci/pci.h    |    6 +-----
 drivers/pci/quirks.c |    7 ++-----
 4 files changed, 4 insertions(+), 19 deletions(-)

--- gregkh-2.6.orig/drivers/net/bnx2.c
+++ gregkh-2.6/drivers/net/bnx2.c
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
--- gregkh-2.6.orig/drivers/pci/msi.c
+++ gregkh-2.6/drivers/pci/msi.c
@@ -170,13 +170,6 @@ static int msi_init(void)
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
--- gregkh-2.6.orig/drivers/pci/pci.h
+++ gregkh-2.6/drivers/pci/pci.h
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
--- gregkh-2.6.orig/drivers/pci/quirks.c
+++ gregkh-2.6/drivers/pci/quirks.c
@@ -1692,9 +1692,6 @@ DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_N
 			quirk_nvidia_ck804_pcie_aer_ext_cap);
 
 #ifdef CONFIG_PCI_MSI
-/* To disable MSI globally */
-int pci_msi_quirk;
-
 /* The Serverworks PCI-X chipset does not support MSI. We cannot easily rely
  * on setting PCI_BUS_FLAGS_NO_MSI in its bus flags because there are actually
  * some other busses controlled by the chipset even if Linux is not aware of it.
@@ -1703,8 +1700,8 @@ int pci_msi_quirk;
  */
 static void __init quirk_svw_msi(struct pci_dev *dev)
 {
-	pci_msi_quirk = 1;
-	printk(KERN_WARNING "PCI: MSI quirk detected. pci_msi_quirk set.\n");
+	pci_no_msi();
+	printk(KERN_WARNING "PCI: MSI quirk detected. MSI deactivated.\n");
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_GCNB_LE, quirk_svw_msi);
 


Patches currently in gregkh-2.6 which might be from michael@ellerman.id.au are
