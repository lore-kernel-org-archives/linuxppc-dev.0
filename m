Return-Path: <linas@austin.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8015467BC0
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Sep 2006 09:55:21 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k8MNtHNo010948
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Sep 2006 19:55:17 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k8MNtHwU083658
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Sep 2006 17:55:17 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k8MNtG87025709
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Sep 2006 17:55:16 -0600
Date: Fri, 22 Sep 2006 18:55:16 -0500
To: matthew@wil.cx
Subject: [PATCH]: (revised 2) PCI Error Recovery: Symbios SCSI device driver
Message-ID: <20060922235516.GE14213@austin.ibm.com>
References: <20060921231314.GW29167@austin.ibm.com>
	<20060922220629.GA4600@dreamland.darkstar.lan>
	<20060922233235.GB14213@austin.ibm.com>
	<20060922163929.bb870ee1.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060922163929.bb870ee1.rdunlap@xenotime.net>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: Luca <kronos.it@gmail.com>, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	"Randy.Dunlap" <rdunlap@xenotime.net>, linux-pci@atrey.karlin.mff.cuni.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Matthew, 

Second revised patch, based on comments from Luca and Randy.Dunlap
Please review, apply and forward upstream.

--linas

Various PCI bus errors can be signaled by newer PCI controllers.  
This patch adds the PCI error recovery callbacks to the Symbios 
SCSI device driver.  The patch has been tested, and appears to 
work well.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

--
 drivers/scsi/sym53c8xx_2/sym_glue.c |   99 ++++++++++++++++++++++++++++++++++++
 drivers/scsi/sym53c8xx_2/sym_glue.h |    4 +
 drivers/scsi/sym53c8xx_2/sym_hipd.c |   10 +++
 3 files changed, 113 insertions(+)

Index: linux-2.6.18-rc7-git1/drivers/scsi/sym53c8xx_2/sym_glue.c
===================================================================
--- linux-2.6.18-rc7-git1.orig/drivers/scsi/sym53c8xx_2/sym_glue.c	2006-09-22 18:33:06.000000000 -0500
+++ linux-2.6.18-rc7-git1/drivers/scsi/sym53c8xx_2/sym_glue.c	2006-09-22 18:50:31.000000000 -0500
@@ -659,6 +659,11 @@ static irqreturn_t sym53c8xx_intr(int ir
 
 	if (DEBUG_FLAGS & DEBUG_TINY) printf_debug ("[");
 
+	/* Avoid spinloop trying to handle interrupts on frozen device */
+	if ((np->s.device->error_state != pci_channel_io_normal) &&
+	    (np->s.device->error_state != 0))
+		return IRQ_HANDLED;
+
 	spin_lock_irqsave(np->s.host->host_lock, flags);
 	sym_interrupt(np);
 	spin_unlock_irqrestore(np->s.host->host_lock, flags);
@@ -726,6 +731,19 @@ static int sym_eh_handler(int op, char *
 
 	dev_warn(&cmd->device->sdev_gendev, "%s operation started.\n", opname);
 
+	/* We may be in an error condition because the PCI bus
+	 * went down. In this case, we need to wait until the
+	 * PCI bus is reset, the card is reset, and only then
+	 * proceed with the scsi error recovery.  There's no
+	 * point in hurrying; take a leisurely wait.
+	 */
+#define WAIT_FOR_PCI_RECOVERY	35
+	if ((np->s.device->error_state != pci_channel_io_normal) &&
+	    (np->s.device->error_state != 0) &&
+		 (wait_for_completion_timeout(&np->s.io_reset_wait,
+		                                 WAIT_FOR_PCI_RECOVERY*HZ) == 0))
+			return SCSI_FAILED;
+
 	spin_lock_irq(host->host_lock);
 	/* This one is queued in some place -> to wait for completion */
 	FOR_EACH_QUEUED_ELEMENT(&np->busy_ccbq, qp) {
@@ -1510,6 +1528,7 @@ static struct Scsi_Host * __devinit sym_
 	np->maxoffs	= dev->chip.offset_max;
 	np->maxburst	= dev->chip.burst_max;
 	np->myaddr	= dev->host_id;
+	init_completion(&np->s.io_reset_wait);
 
 	/*
 	 *  Edit its name.
@@ -1948,6 +1967,79 @@ static void __devexit sym2_remove(struct
 	attach_count--;
 }
 
+/**
+ * sym2_io_error_detected() -- called when PCI error is detected
+ * @pdev: pointer to PCI device
+ * @state: current state of the PCI slot
+ */
+static pci_ers_result_t sym2_io_error_detected (struct pci_dev *pdev,
+                                         enum pci_channel_state state)
+{
+	struct sym_hcb *np = pci_get_drvdata(pdev);
+
+	/* If slot is permanently frozen, turn everything off */
+	if (state == pci_channel_io_perm_failure) {
+		sym2_remove(pdev);
+		return PCI_ERS_RESULT_DISCONNECT;
+	}
+
+	init_completion(&np->s.io_reset_wait);
+	disable_irq(pdev->irq);
+	pci_disable_device(pdev);
+
+	/* Request a slot reset. */
+	return PCI_ERS_RESULT_NEED_RESET;
+}
+
+/**
+ * sym2_io_slot_reset() -- called when the pci bus has been reset.
+ * @pdev: pointer to PCI device
+ *
+ * Restart the card from scratch.
+ */
+static pci_ers_result_t sym2_io_slot_reset (struct pci_dev *pdev)
+{
+	struct sym_hcb *np = pci_get_drvdata(pdev);
+
+	printk(KERN_INFO "%s: recovering from a PCI slot reset\n",
+	    sym_name(np));
+
+	if (pci_enable_device(pdev)) {
+		printk(KERN_ERR "%s: device setup failed most egregiously\n",
+			    sym_name(np));
+		return PCI_ERS_RESULT_DISCONNECT;
+	}
+
+	pci_set_master(pdev);
+	enable_irq(pdev->irq);
+
+	/* Perform host reset only on one instance of the card */
+	if (PCI_FUNC (pdev->devfn) == 0) {
+		if (sym_reset_scsi_bus(np, 0)) {
+		   printk(KERN_ERR "%s: Unable to reset scsi host controller\n",
+					          sym_name(np));
+			return PCI_ERS_RESULT_DISCONNECT;
+		}
+		sym_start_up(np, 1);
+	}
+
+	return PCI_ERS_RESULT_RECOVERED;
+}
+
+/**
+ * sym2_io_resume() -- resume normal ops after PCI reset
+ * @pdev: pointer to PCI device
+ *
+ * Called when the error recovery driver tells us that its
+ * OK to resume normal operation. Use completion to allow
+ * halted scsi ops to resume.
+ */
+static void sym2_io_resume (struct pci_dev *pdev)
+{
+	struct sym_hcb *np = pci_get_drvdata(pdev);
+	complete_all(&np->s.io_reset_wait);
+}
+
 static void sym2_get_signalling(struct Scsi_Host *shost)
 {
 	struct sym_hcb *np = sym_get_hcb(shost);
@@ -2110,11 +2202,18 @@ static struct pci_device_id sym2_id_tabl
 
 MODULE_DEVICE_TABLE(pci, sym2_id_table);
 
+static struct pci_error_handlers sym2_err_handler = {
+	.error_detected = sym2_io_error_detected,
+	.slot_reset = sym2_io_slot_reset,
+	.resume = sym2_io_resume,
+};
+
 static struct pci_driver sym2_driver = {
 	.name		= NAME53C8XX,
 	.id_table	= sym2_id_table,
 	.probe		= sym2_probe,
 	.remove		= __devexit_p(sym2_remove),
+	.err_handler = &sym2_err_handler,
 };
 
 static int __init sym2_init(void)
Index: linux-2.6.18-rc7-git1/drivers/scsi/sym53c8xx_2/sym_glue.h
===================================================================
--- linux-2.6.18-rc7-git1.orig/drivers/scsi/sym53c8xx_2/sym_glue.h	2006-09-22 18:33:06.000000000 -0500
+++ linux-2.6.18-rc7-git1/drivers/scsi/sym53c8xx_2/sym_glue.h	2006-09-22 18:33:26.000000000 -0500
@@ -40,6 +40,7 @@
 #ifndef SYM_GLUE_H
 #define SYM_GLUE_H
 
+#include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/ioport.h>
 #include <linux/pci.h>
@@ -179,6 +180,9 @@ struct sym_shcb {
 	char		chip_name[8];
 	struct pci_dev	*device;
 
+	/* Waiter for clearing of frozen PCI bus */
+	struct completion io_reset_wait;
+
 	struct Scsi_Host *host;
 
 	void __iomem *	ioaddr;		/* MMIO kernel io address	*/
Index: linux-2.6.18-rc7-git1/drivers/scsi/sym53c8xx_2/sym_hipd.c
===================================================================
--- linux-2.6.18-rc7-git1.orig/drivers/scsi/sym53c8xx_2/sym_hipd.c	2006-09-22 18:33:06.000000000 -0500
+++ linux-2.6.18-rc7-git1/drivers/scsi/sym53c8xx_2/sym_hipd.c	2006-09-22 18:51:48.000000000 -0500
@@ -2761,6 +2761,7 @@ void sym_interrupt (struct sym_hcb *np)
 	u_char	istat, istatc;
 	u_char	dstat;
 	u_short	sist;
+	u_int    icnt;
 
 	/*
 	 *  interrupt on the fly ?
@@ -2802,6 +2803,7 @@ void sym_interrupt (struct sym_hcb *np)
 	sist	= 0;
 	dstat	= 0;
 	istatc	= istat;
+	icnt = 0;
 	do {
 		if (istatc & SIP)
 			sist  |= INW(np, nc_sist);
@@ -2809,6 +2811,14 @@ void sym_interrupt (struct sym_hcb *np)
 			dstat |= INB(np, nc_dstat);
 		istatc = INB(np, nc_istat);
 		istat |= istatc;
+
+		/* Prevent deadlock waiting on a condition that may never clear. */
+		icnt ++;
+		if (icnt > 100) {
+			if ((np->s.device->error_state != pci_channel_io_normal)
+			   && (np->s.device->error_state != 0))
+				return;
+		}
 	} while (istatc & (SIP|DIP));
 
 	if (DEBUG_FLAGS & DEBUG_TINY)
