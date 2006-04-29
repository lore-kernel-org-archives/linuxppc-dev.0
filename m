Return-Path: <yanmin.zhang@intel.com>
Received: from azsmga101-1.ch.intel.com (mga03.intel.com [143.182.124.21])
	by ozlabs.org (Postfix) with ESMTP id 1921D679EF
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Apr 2006 13:37:00 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Subject: RE: [PATCH] PCI Error Recovery: e1000 network device driver
Date: Sat, 29 Apr 2006 11:26:50 +0800
Message-ID: <117E3EB5059E4E48ADFF2822933287A4A1EF47@pdsmsx404>
From: "Zhang, Yanmin" <yanmin.zhang@intel.com>
To: "Linas Vepstas" <linas@austin.ibm.com>,
	"Greg KH" <greg@kroah.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Brandeburg,
	Jesse" <jesse.brandeburg@intel.com>, linuxppc-dev@ozlabs.org,
	"Ronciak, John" <john.ronciak@intel.com>, "Kirsher,
	Jeffrey T" <jeffrey.t.kirsher@intel.com>,
	linux-pci@atrey.karlin.mff.cuni.cz, Jeff Garzik <jgarzik@pobox.com>,
	Linux NICS <linuxnics@mailbox.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>-----Original Message-----
>>From: linux-kernel-owner@vger.kernel.org =
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Linas Vepstas
>>Sent: 2006=C4=EA3=D4=C225=C8=D5 11:22
>>To: Greg KH
>>Cc: Jeff Garzik; Ronciak, John; Brandeburg, Jesse; Kirsher, Jeffrey T; =
linux-kernel@vger.kernel.org; netdev@vger.kernel.org;
>>linux-pci@atrey.karlin.mff.cuni.cz; linuxppc-dev@ozlabs.org; Linux =
NICS
>>Subject: Re: [PATCH] PCI Error Recovery: e1000 network device driver
>>
>>On Fri, Mar 24, 2006 at 06:22:06PM -0800, Greg KH wrote:
>>> ... a bit
>>> different from the traditional kernel coding style.
>>
>>Sorry, this is due to inattention on my part; I get cross-eyed
>>after staring at the same code for too long. The patch below should
>>fix things.
>>
>>--linas
>>
>>
>>[PATCH] PCI Error Recovery: e1000 network device driver
>>
>>Various PCI bus errors can be signaled by newer PCI controllers.  This
>>patch adds the PCI error recovery callbacks to the intel gigabit
>>ethernet e1000 device driver. The patch has been tested, and appears
>>to work well.
>>
>>Signed-off-by: Linas Vepstas <linas@linas.org>
>>Acked-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
>>
>>----
>>
>> drivers/net/e1000/e1000_main.c |  114 =
++++++++++++++++++++++++++++++++++++++++-
>> 1 files changed, 113 insertions(+), 1 deletion(-)
>>
>>Index: linux-2.6.16-git6/drivers/net/e1000/e1000_main.c
>>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>--- linux-2.6.16-git6.orig/drivers/net/e1000/e1000_main.c	2006-03-23 =
15:48:01.000000000 -0600
>>+++ linux-2.6.16-git6/drivers/net/e1000/e1000_main.c	2006-03-24 =
15:14:40.431371705 -0600
>>@@ -226,6 +226,16 @@ static int e1000_resume(struct pci_dev *
>>+/**
>>+ * e1000_io_error_detected - called when PCI error is detected
>>+ * @pdev: Pointer to PCI device
>>+ * @state: The current pci conneection state
>>+ *
>>+ * This function is called after a PCI bus error affecting
>>+ * this device has been detected.
>>+ */
>>+static pci_ers_result_t e1000_io_error_detected(struct pci_dev *pdev, =
pci_channel_state_t state)
>>+{
>>+	struct net_device *netdev =3D pci_get_drvdata(pdev);
>>+	struct e1000_adapter *adapter =3D netdev->priv;
>>+
>>+	netif_device_detach(netdev);
>>+
>>+	if (netif_running(netdev))
>>+		e1000_down(adapter);
[YM] e1000_down will do device IO. So it's not appropriate to do so =
here.


>>+
>>+	/* Request a slot slot reset. */
>>+	return PCI_ERS_RESULT_NEED_RESET;
>>+}
>>+
>>+/**
>>+ * e1000_io_slot_reset - called after the pci bus has been reset.
>>+ * @pdev: Pointer to PCI device
>>+ *
>>+ * Restart the card from scratch, as if from a cold-boot. =
Implementation
>>+ * resembles the first-half of the e1000_resume routine.
>>+ */
>>+static pci_ers_result_t e1000_io_slot_reset(struct pci_dev *pdev)
>>+{
>>+	struct net_device *netdev =3D pci_get_drvdata(pdev);
>>+	struct e1000_adapter *adapter =3D netdev->priv;
>>+
>>+	if (pci_enable_device(pdev)) {
>>+		printk(KERN_ERR "e1000: Cannot re-enable PCI device after =
reset.\n");
>>+		return PCI_ERS_RESULT_DISCONNECT;
>>+	}
>>+	pci_set_master(pdev);
>>+
>>+	pci_enable_wake(pdev, 3, 0);
>>+	pci_enable_wake(pdev, 4, 0); /* 4 =3D=3D D3 cold */
[YM] Suggest using PCI_D3hot and PCI_D3cold instead of hard-coded =
numbers.
