Return-Path: <michael@ozlabs.org>
To: linux-pci@atrey.karlin.mff.cuni.cz
From: Michael Ellerman <michael@ellerman.id.au>
Date: Thu, 25 Jan 2007 19:34:13 +1100
Subject: [RFC/PATCH 10/16] Add a pci_irq_fixup for MSI via RTAS
In-Reply-To: <1169714047.65693.647693675533.qpush@cradle>
Message-Id: <20070125083414.EE60ADE304@ozlabs.org>
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

When RTAS is managing MSIs for us, it will/may enable MSI on devices that
support it by default. This is contrary to the Linux model where a device
is in LSI mode until the driver requests MSIs.

To remedy this we add a pci_irq_fixup call, which disables MSI if they've
been assigned by firmware and the device also supports LSI.

At the moment there is no pci_irq_fixup on pSeries, so we can just set it
unconditionally. If other platforms use the RTAS MSI backend they'll need
to check that still holds.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 drivers/pci/msi/rtas.c |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

Index: msi/drivers/pci/msi/rtas.c
===================================================================
--- msi.orig/drivers/pci/msi/rtas.c
+++ msi/drivers/pci/msi/rtas.c
@@ -238,6 +238,24 @@ static int msi_rtas_alloc(struct pci_dev
 	return -1;
 }
 
+static void msi_rtas_pci_irq_fixup(struct pci_dev *pdev)
+{
+	/* No LSI -> leave MSIs (if any) configured */
+	if (pdev->irq == NO_IRQ) {
+		msi_debug("no LSI on %s, nothing to do.\n", pci_name(pdev));
+		return;
+	}
+
+	/* No MSI -> MSIs can't have been assigned by fw, leave LSI */
+	if (check_req_msi(pdev)) {
+		msi_debug("no req#msi on %s, nothing to do.\n", pci_name(pdev));
+		return;
+	}
+
+	msi_debug("disabling existing MSI on %s\n", pci_name(pdev));
+	rtas_disable_msi(pdev);
+}
+
 static struct msi_ops rtas_msi_ops = {
 	.check = msi_rtas_check,
 	.alloc = msi_rtas_alloc,
@@ -264,5 +282,8 @@ int msi_rtas_init(void)
 
 	ppc_md.get_msi_ops = rtas_get_msi_ops;
 
+	WARN_ON(ppc_md.pci_irq_fixup);
+	ppc_md.pci_irq_fixup = msi_rtas_pci_irq_fixup;
+
 	return 0;
 }
