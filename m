Return-Path: <olof@lixom.net>
Date: Wed, 20 Feb 2008 20:34:43 -0600
From: Olof Johansson <olof@lixom.net>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] pasemi: remove warning in mpic_pasemi_msi.c
Message-ID: <20080221023443.GA3160@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, pasemi-linux@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Remove warning:

arch/powerpc/sysdev/mpic_pasemi_msi.c: In function 'pasemi_msi_setup_msi_irqs':
arch/powerpc/sysdev/mpic_pasemi_msi.c:135: warning: 'addr' is used uninitialized in this function

Turns out addr wasn't even used, it's a leftover from the u3msi code.

Signed-off-by: Olof Johansson <olof@lixom.net>


diff --git a/arch/powerpc/sysdev/mpic_pasemi_msi.c b/arch/powerpc/sysdev/mpic_pasemi_msi.c
index d6bfda3..33cbfb2 100644
--- a/arch/powerpc/sysdev/mpic_pasemi_msi.c
+++ b/arch/powerpc/sysdev/mpic_pasemi_msi.c
@@ -95,7 +95,6 @@ static int pasemi_msi_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 	unsigned int virq;
 	struct msi_desc *entry;
 	struct msi_msg msg;
-	u64 addr;
 
 	pr_debug("pasemi_msi_setup_msi_irqs, pdev %p nvec %d type %d\n",
 		 pdev, nvec, type);
@@ -132,8 +131,8 @@ static int pasemi_msi_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 		set_irq_chip(virq, &mpic_pasemi_msi_chip);
 		set_irq_type(virq, IRQ_TYPE_EDGE_RISING);
 
-		pr_debug("pasemi_msi: allocated virq 0x%x (hw 0x%lx) addr 0x%lx\n",
-			  virq, hwirq, addr);
+		pr_debug("pasemi_msi: allocated virq 0x%x (hw 0x%lx) addr 0x%x\n",
+			  virq, hwirq, msg.address_lo);
 
 		/* Likewise, the device writes [0...511] into the target
 		 * register to generate MSI [512...1023]
