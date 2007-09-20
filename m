Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <19ac8b97e98274582fe5bde914883c3585f20082.1190270165.git.michael@ellerman.id.au>
In-Reply-To: <3034ec8fd939bd5cfcdb7ac65206ae2771dc9b2c.1190270165.git.michael@ellerman.id.au>
References: <3034ec8fd939bd5cfcdb7ac65206ae2771dc9b2c.1190270165.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 4/4] Inline u3msi_compose_msi_msg()
Date: Thu, 20 Sep 2007 16:36:51 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In the MPIC U3 MSI code, we call u3msi_compose_msi_msg() once for each MSI.
This is overkill, as the address is per pci device, not per MSI. So setup
the address once, and just set the data per MSI.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/sysdev/mpic_u3msi.c |   24 +++++++++---------------
 1 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/sysdev/mpic_u3msi.c b/arch/powerpc/sysdev/mpic_u3msi.c
index 4e50d1c..027fe01 100644
--- a/arch/powerpc/sysdev/mpic_u3msi.c
+++ b/arch/powerpc/sysdev/mpic_u3msi.c
@@ -107,26 +107,17 @@ static void u3msi_teardown_msi_irqs(struct pci_dev *pdev)
 	return;
 }
 
-static void u3msi_compose_msi_msg(struct pci_dev *pdev, int virq,
-				  struct msi_msg *msg)
-{
-	u64 addr;
-
-	addr = find_ht_magic_addr(pdev);
-	msg->address_lo = addr & 0xFFFFFFFF;
-	msg->address_hi = addr >> 32;
-	msg->data = virq_to_hw(virq);
-
-	pr_debug("u3msi: allocated virq 0x%x (hw 0x%lx) at address 0x%lx\n",
-		 virq, virq_to_hw(virq), addr);
-}
-
 static int u3msi_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 {
 	irq_hw_number_t hwirq;
 	unsigned int virq;
 	struct msi_desc *entry;
 	struct msi_msg msg;
+	u64 addr;
+
+	addr = find_ht_magic_addr(pdev);
+	msg.address_lo = addr & 0xFFFFFFFF;
+	msg.address_hi = addr >> 32;
 
 	list_for_each_entry(entry, &pdev->msi_list, list) {
 		hwirq = mpic_msi_alloc_hwirqs(msi_mpic, 1);
@@ -146,7 +137,10 @@ static int u3msi_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 		set_irq_chip(virq, &mpic_u3msi_chip);
 		set_irq_type(virq, IRQ_TYPE_EDGE_RISING);
 
-		u3msi_compose_msi_msg(pdev, virq, &msg);
+		pr_debug("u3msi: allocated virq 0x%x (hw 0x%lx) addr 0x%lx\n",
+			  virq, hwirq, addr);
+
+		msg.data = hwirq;
 		write_msi_msg(virq, &msg);
 
 		hwirq++;
-- 
1.5.1.3.g7a33b
