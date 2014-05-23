Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8D35D1A0085
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 May 2014 10:17:33 +1000 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 23 May 2014 10:17:32 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id E147F3578052
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 May 2014 10:17:29 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4N0HEus3408318
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 May 2014 10:17:14 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4N0HTDx009333
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 May 2014 10:17:29 +1000
Date: Fri, 23 May 2014 10:17:30 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH v6 2/3] drivers/vfio: EEH support for VFIO PCI device
Message-ID: <20140523001730.GA12584@shangw>
References: <1400747034-15045-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1400747034-15045-3-git-send-email-gwshan@linux.vnet.ibm.com>
 <537DC991.9010401@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <537DC991.9010401@suse.de>
Cc: aik@ozlabs.ru, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 kvm-ppc@vger.kernel.org, alex.williamson@redhat.com,
 qiudayu@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 22, 2014 at 11:55:29AM +0200, Alexander Graf wrote:
>
>On 22.05.14 10:23, Gavin Shan wrote:
>>The patch adds new IOCTL commands for VFIO PCI device to support
>>EEH functionality for PCI devices, which have been passed through
>>from host to somebody else via VFIO.
>>
>>Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>
>This already looks a *lot* more sane than the previous versions.
>We're slowly getting there I think ;).
>
>Ben, could you please check through the exported EEH interface itself
>and verify whether it does all the lockings correctly, uses the API
>properly and doesn't allow for a user space program to blow up the
>system?
>
>
>>---
>>  Documentation/vfio.txt         |  88 ++++++++++-
>>  arch/powerpc/include/asm/eeh.h |  17 +++
>>  arch/powerpc/kernel/eeh.c      | 321 +++++++++++++++++++++++++++++++++++++++++
>>  drivers/vfio/pci/vfio_pci.c    | 131 ++++++++++++++++-
>>  include/uapi/linux/vfio.h      |  53 +++++++
>>  5 files changed, 603 insertions(+), 7 deletions(-)
>>
>>diff --git a/Documentation/vfio.txt b/Documentation/vfio.txt
>>index b9ca023..dd13db6 100644
>>--- a/Documentation/vfio.txt
>>+++ b/Documentation/vfio.txt
>>@@ -305,7 +305,10 @@ faster, the map/unmap handling has been implemented in real mode which provides
>>  an excellent performance which has limitations such as inability to do
>>  locked pages accounting in real time.
>>-So 3 additional ioctls have been added:
>>+4) PPC64 guests detect PCI errors and recover from them via EEH RTAS services,
>>+which works on the basis of additional ioctl commands.
>>+
>>+So 8 additional ioctls have been added:
>>  	VFIO_IOMMU_SPAPR_TCE_GET_INFO - returns the size and the start
>>  		of the DMA window on the PCI bus.
>>@@ -316,6 +319,20 @@ So 3 additional ioctls have been added:
>>  	VFIO_IOMMU_DISABLE - disables the container.
>>+	VFIO_EEH_PE_SET_OPTION - enables or disables EEH functinality on the
>
>functionality
>

Typo. Will fix in next revision.

>>+		specified device. Also, it can be used to remove IO or DMA
>>+		stopped state on the frozen PE.
>>+
>>+	VFIO_EEH_PE_GET_ADDR - retrieve the unique address of the specified
>>+		PE or query PE sharing mode.
>
>What is PE?
>

will add description about that to Documentation/vfio.txt.

>>+
>>+	VFIO_EEH_PE_GET_STATE - retrieve PE's state: frozen or normal state.
>>+
>>+	VFIO_EEH_PE_RESET - do PE reset, which is one of the major steps for
>>+		error recovering.
>>+
>>+	VFIO_EEH_PE_CONFIGURE - configure the PCI bridges after PE reset. It's
>>+		one of the major steps for error recoverying.
>>  The code flow from the example above should be slightly changed:
>>@@ -346,6 +363,75 @@ The code flow from the example above should be slightly changed:
>>  	ioctl(container, VFIO_IOMMU_MAP_DMA, &dma_map);
>>  	.....
>>+Based on the initial example we have, the following piece of code could be
>>+reference for EEH setup and error handling:
>>+
>>+	struct vfio_eeh_pe_set_option option = { .argsz = sizeof(option) };
>>+	struct vfio_eeh_pe_get_addr addr = { .argsz = sizeof(addr) };
>>+	struct vfio_eeh_pe_get_state state = { .argsz = sizeof(state) };
>>+	struct vfio_eeh_pe_reset reset = { .argsz = sizeof(reset) };
>>+	struct vfio_eeh_pe_configure config = { .argsz = sizeof(config) };
>>+
>>+	....
>>+
>>+	/* Get a file descriptor for the device */
>>+	device = ioctl(group, VFIO_GROUP_GET_DEVICE_FD, "0000:06:0d.0");
>>+
>>+	/* Enable the EEH functionality on the device */
>>+	option.option = EEH_OPT_ENABLE;
>>+	ioctl(device, VFIO_EEH_PE_SET_OPTION, &option);
>>+
>>+	/* Retrieve PE address and create and maintain PE by yourself */
>>+	addr.option = EEH_OPT_GET_PE_ADDR;
>>+	ioctl(device, VFIO_EEH_PE_GET_ADDR, &addr);
>>+
>>+	/* Assure EEH is supported on the PE and make PE functional */
>>+	ioctl(device, VFIO_EEH_PE_GET_STATE, &state);
>>+
>>+	/* Save device's state. pci_save_state() would be good enough
>>+	 * as an example.
>>+	 */
>>+
>>+	/* Test and setup the device */
>>+	ioctl(device, VFIO_DEVICE_GET_INFO, &device_info);
>>+
>>+	....
>>+
>>+	/* When 0xFF's returned from reading PCI config space or IO BARs
>>+	 * of the PCI device. Check the PE state to see if that has been
>>+	 * frozen.
>>+	 */
>>+	ioctl(device, VFIO_EEH_PE_GET_STATE, &state);
>>+
>>+	/* Waiting for pending PCI transactions to be completed and don't
>>+	 * produce any more PCI traffic from/to the affected PE until
>>+	 * recovery is finished.
>>+	 */
>>+
>>+	/* Enable IO for the affected PE and collect logs. Usually, the
>>+	 * standard part of PCI config space, AER registers are dumped
>>+	 * as logs for further analysis.
>>+	 */
>>+	option.option = EEH_OPT_THAW_MMIO;
>>+	ioctl(device, VFIO_EEH_PE_SET_OPTION, &option);
>>+
>>+	/* Issue PE reset */
>>+	reset.option = EEH_RESET_HOT;
>>+	ioctl(device, VFIO_EEH_PE_RESET, &reset);
>>+
>>+	/* Configure the PCI bridges for the affected PE */
>>+	ioctl(device, VFIO_EEH_PE_CONFIGURE, NULL);
>>+
>>+	/* Restored state we saved at initialization time. pci_restore_state()
>>+	 * is good enough as an example.
>>+	 */
>>+
>>+	/* Hopefully, error is recovered successfully. Now, you can resume to
>>+	 * start PCI traffic to/from the affected PE.
>>+	 */
>>+
>>+	....
>>+
>>  -------------------------------------------------------------------------------
>>  [1] VFIO was originally an acronym for "Virtual Function I/O" in its
>>diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
>>index 34a2d83..dd5f1cf 100644
>>--- a/arch/powerpc/include/asm/eeh.h
>>+++ b/arch/powerpc/include/asm/eeh.h
>>@@ -191,6 +191,11 @@ enum {
>>  #define EEH_OPT_ENABLE		1	/* EEH enable	*/
>>  #define EEH_OPT_THAW_MMIO	2	/* MMIO enable	*/
>>  #define EEH_OPT_THAW_DMA	3	/* DMA enable	*/
>>+#define EEH_OPT_GET_PE_ADDR	0	/* Get PE addr	*/
>>+#define EEH_OPT_GET_PE_MODE	1	/* Get PE mode	*/
>>+#define EEH_PE_MODE_NONE	0	/* Invalid mode	*/
>>+#define EEH_PE_MODE_NOT_SHARED	1	/* Not shared	*/
>>+#define EEH_PE_MODE_SHARED	2	/* Shared mode	*/
>>  #define EEH_STATE_UNAVAILABLE	(1 << 0)	/* State unavailable	*/
>>  #define EEH_STATE_NOT_SUPPORT	(1 << 1)	/* EEH not supported	*/
>>  #define EEH_STATE_RESET_ACTIVE	(1 << 2)	/* Active reset		*/
>>@@ -198,6 +203,11 @@ enum {
>>  #define EEH_STATE_DMA_ACTIVE	(1 << 4)	/* Active DMA		*/
>>  #define EEH_STATE_MMIO_ENABLED	(1 << 5)	/* MMIO enabled		*/
>>  #define EEH_STATE_DMA_ENABLED	(1 << 6)	/* DMA enabled		*/
>>+#define EEH_PE_STATE_NORMAL		0	/* Normal state		*/
>>+#define EEH_PE_STATE_RESET		1		/* PE reset	*/
>>+#define EEH_PE_STATE_STOPPED_IO_DMA	2		/* Stopped	*/
>>+#define EEH_PE_STATE_STOPPED_DMA	4		/* Stopped DMA	*/
>>+#define EEH_PE_STATE_UNAVAIL		5		/* Unavailable	*/
>>  #define EEH_RESET_DEACTIVATE	0	/* Deactivate the PE reset	*/
>>  #define EEH_RESET_HOT		1	/* Hot reset			*/
>>  #define EEH_RESET_FUNDAMENTAL	3	/* Fundamental reset		*/
>>@@ -305,6 +315,13 @@ void eeh_add_device_late(struct pci_dev *);
>>  void eeh_add_device_tree_late(struct pci_bus *);
>>  void eeh_add_sysfs_files(struct pci_bus *);
>>  void eeh_remove_device(struct pci_dev *);
>>+int eeh_dev_open(struct pci_dev *pdev);
>>+void eeh_dev_release(struct pci_dev *pdev);
>>+int eeh_pe_set_option(struct pci_dev *pdev, int option);
>>+int eeh_pe_get_addr(struct pci_dev *pdev, int option);
>>+int eeh_pe_get_state(struct pci_dev *pdev);
>>+int eeh_pe_reset(struct pci_dev *pdev, int option);
>>+int eeh_pe_configure(struct pci_dev *pdev);
>>  /**
>>   * EEH_POSSIBLE_ERROR() -- test for possible MMIO failure.
>>diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
>>index 9c6b899..b90a474 100644
>>--- a/arch/powerpc/kernel/eeh.c
>>+++ b/arch/powerpc/kernel/eeh.c
>>@@ -108,6 +108,9 @@ struct eeh_ops *eeh_ops = NULL;
>>  /* Lock to avoid races due to multiple reports of an error */
>>  DEFINE_RAW_SPINLOCK(confirm_error_lock);
>>+/* Lock to protect passed flags */
>>+static DEFINE_MUTEX(eeh_dev_mutex);
>>+
>>  /* Buffer for reporting pci register dumps. Its here in BSS, and
>>   * not dynamically alloced, so that it ends up in RMO where RTAS
>>   * can access it.
>>@@ -1098,6 +1101,324 @@ void eeh_remove_device(struct pci_dev *dev)
>>  	edev->mode &= ~EEH_DEV_SYSFS;
>>  }
>>+/**
>>+ * eeh_dev_open - Mark EEH device and PE as passed through
>>+ * @pdev: PCI device
>>+ *
>>+ * Mark the indicated EEH device and PE as passed through.
>>+ * In the result, the EEH errors detected on the PE won't be
>>+ * reported. The owner of the device will be responsible for
>>+ * detection and recovery.
>>+ */
>>+int eeh_dev_open(struct pci_dev *pdev)
>>+{
>>+	struct eeh_dev *edev;
>>+
>>+	mutex_lock(&eeh_dev_mutex);
>>+
>>+	/* No PCI device ? */
>>+	if (!pdev) {
>>+		mutex_unlock(&eeh_dev_mutex);
>>+		return -ENODEV;
>>+	}
>>+
>>+	/* No EEH device ? */
>>+	edev = pci_dev_to_eeh_dev(pdev);
>>+	if (!edev || !edev->pe) {
>>+		mutex_unlock(&eeh_dev_mutex);
>>+		return -ENODEV;
>>+	}
>>+
>>+	eeh_dev_set_passed(edev, true);
>>+	eeh_pe_set_passed(edev->pe, true);
>>+	mutex_unlock(&eeh_dev_mutex);
>>+
>>+	return 0;
>>+}
>>+EXPORT_SYMBOL_GPL(eeh_dev_open);
>>+
>>+/**
>>+ * eeh_dev_release - Reclaim the ownership of EEH device
>>+ * @pdev: PCI device
>>+ *
>>+ * Reclaim ownership of EEH device, potentially the corresponding
>>+ * PE. In the result, the EEH errors detected on the PE will be
>>+ * reported and handled as usual.
>>+ */
>>+void eeh_dev_release(struct pci_dev *pdev)
>>+{
>>+	bool release_pe = true;
>>+	struct eeh_pe *pe = NULL;
>>+	struct eeh_dev *tmp, *edev;
>>+
>>+	mutex_lock(&eeh_dev_mutex);
>>+
>>+	/* No PCI device ? */
>>+	if (!pdev) {
>>+		mutex_unlock(&eeh_dev_mutex);
>>+		return;
>>+	}
>>+
>>+	/* No EEH device ? */
>>+	edev = pci_dev_to_eeh_dev(pdev);
>>+	if (!edev || !eeh_dev_passed(edev) ||
>>+	    !edev->pe || !eeh_pe_passed(pe)) {
>>+		mutex_unlock(&eeh_dev_mutex);
>>+		return;
>>+	}
>>+
>>+	/* Release device */
>>+	pe = edev->pe;
>>+	eeh_dev_set_passed(edev, false);
>>+
>>+	/* Release PE */
>>+	eeh_pe_for_each_dev(pe, edev, tmp) {
>>+		if (eeh_dev_passed(edev)) {
>>+			release_pe = false;
>>+			break;
>>+		}
>>+	}
>>+
>>+	if (release_pe)
>>+		eeh_pe_set_passed(pe, false);
>>+
>>+	mutex_unlock(&eeh_dev_mutex);
>>+}
>>+EXPORT_SYMBOL(eeh_dev_release);
>>+
>>+static int eeh_dev_check(struct pci_dev *pdev,
>>+			 struct eeh_dev **pedev,
>>+			 struct eeh_pe **ppe)
>>+{
>>+	struct eeh_dev *edev;
>>+
>>+	/* No device ? */
>>+	if (!pdev)
>>+		return -ENODEV;
>>+
>>+	edev = pci_dev_to_eeh_dev(pdev);
>>+	if (!edev || !eeh_dev_passed(edev) ||
>>+	    !edev->pe || !eeh_pe_passed(edev->pe))
>>+		return -ENODEV;
>>+
>>+	if (pedev)
>>+		*pedev = edev;
>>+	if (ppe)
>>+		*ppe = edev->pe;
>>+
>>+	return 0;
>>+}
>>+
>>+/**
>>+ * eeh_pe_set_option - Set options for the indicated PE
>>+ * @pdev: PCI device
>>+ * @option: requested option
>>+ *
>>+ * The routine is called to enable or disable EEH functionality
>>+ * on the indicated PE, to enable IO or DMA for the frozen PE.
>>+ */
>>+int eeh_pe_set_option(struct pci_dev *pdev, int option)
>>+{
>>+	struct eeh_dev *edev;
>>+	struct eeh_pe *pe;
>>+	int ret = 0;
>>+
>>+	/* Device existing ? */
>>+	ret = eeh_dev_check(pdev, &edev, &pe);
>>+	if (ret)
>>+		return ret;
>>+
>>+	switch (option) {
>>+	case EEH_OPT_DISABLE:
>>+	case EEH_OPT_ENABLE:
>
>This deserves a comment
>

Yep. will add it, thanks.

>>+		break;
>>+	case EEH_OPT_THAW_MMIO:
>>+	case EEH_OPT_THAW_DMA:
>>+		if (!eeh_ops || !eeh_ops->set_option) {
>>+			ret = -ENOENT;
>>+			break;
>>+		}
>>+
>>+		ret = eeh_ops->set_option(pe, option);
>>+		break;
>>+	default:
>>+		pr_debug("%s: Option %d out of range (%d, %d)\n",
>>+			__func__, option, EEH_OPT_DISABLE, EEH_OPT_THAW_DMA);
>>+		ret = -EINVAL;
>>+	}
>>+
>>+	return ret;
>>+}
>>+EXPORT_SYMBOL_GPL(eeh_pe_set_option);
>>+
>>+/**
>>+ * eeh_pe_get_addr - Retrieve the PE address or sharing mode
>>+ * @pdev: PCI device
>>+ * @option: option
>>+ *
>>+ * Retrieve the PE address or sharing mode.
>>+ */
>>+int eeh_pe_get_addr(struct pci_dev *pdev, int option)
>>+{
>>+	struct pci_bus *bus;
>>+	struct eeh_dev *edev;
>>+	struct eeh_pe *pe;
>>+	int ret = 0;
>>+
>>+	/* Device existing ? */
>>+	ret = eeh_dev_check(pdev, &edev, &pe);
>>+	if (ret)
>
>Probably safer to write this as ret < 0. Positive return values are
>success now.
>

Ok. Will fix it.

>>+		return ret;
>>+
>>+	switch (option) {
>>+	case EEH_OPT_GET_PE_ADDR:
>>+		bus = eeh_pe_bus_get(pe);
>>+		if (!bus) {
>>+			ret = -ENODEV;
>>+			break;
>>+		}
>>+
>>+		/* PE address has format "00BBSS00" */
>>+		ret = bus->number << 16;
>>+		break;
>>+	case EEH_OPT_GET_PE_MODE:
>>+		/* Wa always have shared PE */
>
>Wa?
>

Basically, PE could have one single PCI device (function), or a PCI bus
(including subordinate PCI devices). we always have the later case currently.
And it's called PE in "shared mode" and I called it as "shared PE" :-)

>>+		ret = EEH_PE_MODE_SHARED;
>>+		break;
>>+	default:
>>+		pr_debug("%s: option %d out of range (0, 1)\n",
>>+			__func__, option);
>>+		ret = -EINVAL;
>>+	}
>>+
>>+	return ret;
>>+}
>>+EXPORT_SYMBOL_GPL(eeh_pe_get_addr);
>>+
>>+/**
>>+ * eeh_pe_get_state - Retrieve PE's state
>>+ * @pdev: PCI device
>>+ *
>>+ * Retrieve the PE's state, which includes 3 aspects: enabled
>>+ * DMA, enabled IO and asserted reset.
>>+ */
>>+int eeh_pe_get_state(struct pci_dev *pdev)
>>+{
>>+	struct eeh_dev *edev;
>>+	struct eeh_pe *pe;
>>+	int result, ret = 0;
>>+
>>+	/* Device existing ? */
>>+	ret = eeh_dev_check(pdev, &edev, &pe);
>>+	if (ret)
>>+		return ret;
>>+
>>+	if (!eeh_ops || !eeh_ops->get_state)
>>+		return -ENOENT;
>>+
>>+	result = eeh_ops->get_state(pe, NULL);
>>+	if (!(result & EEH_STATE_RESET_ACTIVE) &&
>>+	     (result & EEH_STATE_DMA_ENABLED) &&
>>+	     (result & EEH_STATE_MMIO_ENABLED))
>>+		ret = EEH_PE_STATE_NORMAL;
>>+	else if (result & EEH_STATE_RESET_ACTIVE)
>>+		ret = EEH_PE_STATE_RESET;
>>+	else if (!(result & EEH_STATE_RESET_ACTIVE) &&
>>+		 !(result & EEH_STATE_DMA_ENABLED) &&
>>+		 !(result & EEH_STATE_MMIO_ENABLED))
>>+		ret = EEH_PE_STATE_STOPPED_IO_DMA;
>>+	else if (!(result & EEH_STATE_RESET_ACTIVE) &&
>>+		 (result & EEH_STATE_DMA_ENABLED) &&
>>+		 !(result & EEH_STATE_MMIO_ENABLED))
>>+		ret = EEH_PE_STATE_STOPPED_DMA;
>>+	else
>>+		ret = EEH_PE_STATE_UNAVAIL;
>>+
>>+	return ret;
>>+}
>>+EXPORT_SYMBOL_GPL(eeh_pe_get_state);
>>+
>>+/**
>>+ * eeh_pe_reset - Issue PE reset according to specified type
>>+ * @pdev: PCI device
>>+ * @option: reset type
>>+ *
>>+ * The routine is called to reset the specified PE with the
>>+ * indicated type, either fundamental reset or hot reset.
>>+ * PE reset is the most important part for error recovery.
>>+ */
>>+int eeh_pe_reset(struct pci_dev *pdev, int option)
>>+{
>>+	struct eeh_dev *edev;
>>+	struct eeh_pe *pe;
>>+	int ret = 0;
>>+
>>+	/* Device existing ? */
>>+	ret = eeh_dev_check(pdev, &edev, &pe);
>>+	if (ret)
>>+		return ret;
>>+
>>+	if (!eeh_ops || !eeh_ops->set_option || !eeh_ops->reset)
>>+		return -ENOENT;
>>+
>>+	switch (option) {
>>+	case EEH_RESET_DEACTIVATE:
>>+		ret = eeh_ops->reset(pe, option);
>>+		if (ret)
>>+			break;
>>+
>>+		/*
>>+		 * The PE is still in frozen state and we need clear
>
>to
>

Will fix, thanks.

>>+		 * that. It's good to clear frozen state after deassert
>>+		 * to avoid messy IO access during reset, which might
>>+		 * cause recursive frozen PE.
>>+		 */
>>+		ret = eeh_ops->set_option(pe, EEH_OPT_THAW_MMIO);
>>+		if (!ret)
>>+			ret = eeh_ops->set_option(pe, EEH_OPT_THAW_DMA);
>>+		if (!ret)
>>+			eeh_pe_state_clear(pe, EEH_PE_ISOLATED);
>>+		break;
>>+	case EEH_RESET_HOT:
>>+	case EEH_RESET_FUNDAMENTAL:
>>+		ret = eeh_ops->reset(pe, option);
>>+		break;
>>+	default:
>>+		pr_debug("%s: Unsupported option %d\n",
>>+			__func__, option);
>>+		ret = -EINVAL;
>>+	}
>>+
>>+	return ret;
>>+}
>>+EXPORT_SYMBOL_GPL(eeh_pe_reset);
>>+
>>+/**
>>+ * eeh_pe_configure - Configure PCI bridges after PE reset
>>+ * @pdev: PCI device
>>+ *
>>+ * The routine is called to restore the PCI config space for
>>+ * those PCI devices, especially PCI bridges affected by PE
>>+ * reset issued previously.
>
>So would it make sense to combine this with the reset call?
>

I hope to keep it as it's one of the major steps to do error
recovery. Lets keep it.

>>+ */
>>+int eeh_pe_configure(struct pci_dev *pdev)
>>+{
>>+	struct eeh_dev *edev;
>>+	struct eeh_pe *pe;
>>+	int ret = 0;
>>+
>>+	/* Device existing ? */
>>+	ret = eeh_dev_check(pdev, &edev, &pe);
>>+	if (ret)
>>+		return ret;
>>+
>>+	/* Restore config space for the affected devices */
>>+	eeh_pe_restore_bars(pe);
>>+
>>+	return ret;
>>+}
>>+EXPORT_SYMBOL_GPL(eeh_pe_configure);
>>+
>>  static int proc_eeh_show(struct seq_file *m, void *v)
>>  {
>>  	if (!eeh_enabled()) {
>>diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
>>index 7ba0424..301ac18 100644
>>--- a/drivers/vfio/pci/vfio_pci.c
>>+++ b/drivers/vfio/pci/vfio_pci.c
>>@@ -25,6 +25,9 @@
>>  #include <linux/types.h>
>>  #include <linux/uaccess.h>
>>  #include <linux/vfio.h>
>>+#ifdef CONFIG_EEH
>>+#include <asm/eeh.h>
>>+#endif
>>  #include "vfio_pci_private.h"
>>@@ -152,32 +155,57 @@ static void vfio_pci_disable(struct vfio_pci_device *vdev)
>>  	pci_restore_state(pdev);
>>  }
>>+static void vfio_eeh_pci_release(struct pci_dev *pdev)
>>+{
>>+#ifdef CONFIG_EEH
>>+	eeh_dev_release(pdev);
>>+#endif
>>+}
>>+
>>  static void vfio_pci_release(void *device_data)
>>  {
>>  	struct vfio_pci_device *vdev = device_data;
>>-	if (atomic_dec_and_test(&vdev->refcnt))
>>+	if (atomic_dec_and_test(&vdev->refcnt)) {
>>+		vfio_eeh_pci_release(vdev->pdev);
>>  		vfio_pci_disable(vdev);
>>+	}
>>  	module_put(THIS_MODULE);
>>  }
>>+static int vfio_eeh_pci_open(struct pci_dev *pdev)
>>+{
>>+	int ret = 0;
>>+
>>+#ifdef CONFIG_EEH
>>+	ret = eeh_dev_open(pdev);
>>+#endif
>>+	return ret;
>>+}
>>+
>>  static int vfio_pci_open(void *device_data)
>>  {
>>  	struct vfio_pci_device *vdev = device_data;
>>+	int ret;
>>  	if (!try_module_get(THIS_MODULE))
>>  		return -ENODEV;
>>  	if (atomic_inc_return(&vdev->refcnt) == 1) {
>>-		int ret = vfio_pci_enable(vdev);
>>-		if (ret) {
>>-			module_put(THIS_MODULE);
>>-			return ret;
>>-		}
>>+		ret = vfio_pci_enable(vdev);
>>+		if (ret)
>>+			goto error;
>>+
>>+		ret = vfio_eeh_pci_open(vdev->pdev);
>>+		if (ret)
>>+			goto error;
>>  	}
>>  	return 0;
>>+error:
>>+	module_put(THIS_MODULE);
>>+	return ret;
>>  }
>>  static int vfio_pci_get_irq_count(struct vfio_pci_device *vdev, int irq_type)
>>@@ -321,6 +349,91 @@ static int vfio_pci_for_each_slot_or_bus(struct pci_dev *pdev,
>>  	return walk.ret;
>>  }
>>+static int vfio_eeh_pci_ioctl(struct pci_dev *pdev,
>>+			      unsigned int cmd,
>>+			      unsigned long arg)
>>+{
>>+	unsigned long minsz;
>>+	int ret = 0;
>>+
>>+#ifdef CONFIG_EEH
>>+	switch (cmd) {
>>+	case VFIO_EEH_PE_SET_OPTION: {
>>+		struct vfio_eeh_pe_set_option option;
>>+
>>+		minsz = offsetofend(struct vfio_eeh_pe_set_option, option);
>>+		if (copy_from_user(&option, (void __user *)arg, minsz))
>>+			return -EFAULT;
>>+		if (option.argsz < minsz)
>>+			return -EINVAL;
>>+
>>+		ret = eeh_pe_set_option(pdev, option.option);
>>+		break;
>>+	}
>>+	case VFIO_EEH_PE_GET_ADDR: {
>>+		struct vfio_eeh_pe_get_addr addr;
>>+
>>+		minsz = offsetofend(struct vfio_eeh_pe_get_addr, info);
>>+		if (copy_from_user(&addr, (void __user *)arg, minsz))
>>+			return -EFAULT;
>>+		if (addr.argsz < minsz)
>>+			return -EINVAL;
>>+
>>+		ret = eeh_pe_get_addr(pdev, addr.option);
>>+		if (ret >= 0) {
>>+			addr.info = ret;
>>+			if (copy_to_user((void __user *)arg, &addr, minsz))
>>+				return -EFAULT;
>>+			ret = 0;
>>+		}
>>+
>>+		break;
>>+	}
>>+	case VFIO_EEH_PE_GET_STATE: {
>>+		struct vfio_eeh_pe_get_state state;
>>+
>>+		minsz = offsetofend(struct vfio_eeh_pe_get_state, state);
>>+		if (copy_from_user(&state, (void __user *)arg, minsz))
>>+			return -EFAULT;
>>+		if (state.argsz < minsz)
>>+			return -EINVAL;
>>+
>>+		ret = eeh_pe_get_state(pdev);
>>+		if (ret >= 0) {
>>+			state.state = ret;
>>+			if (copy_to_user((void __user *)arg, &state, minsz))
>>+				return -EFAULT;
>>+			ret = 0;
>>+		}
>>+		break;
>>+	}
>>+	case VFIO_EEH_PE_RESET: {
>>+		struct vfio_eeh_pe_reset reset;
>>+
>>+		minsz = offsetofend(struct vfio_eeh_pe_reset, option);
>>+		if (copy_from_user(&reset, (void __user *)arg, minsz))
>>+			return -EFAULT;
>>+		if (reset.argsz < minsz)
>>+			return -EINVAL;
>>+
>>+		ret = eeh_pe_reset(pdev, reset.option);
>>+		break;
>>+	}
>>+	case VFIO_EEH_PE_CONFIGURE:
>>+		ret = eeh_pe_configure(pdev);
>>+		break;
>>+	default:
>>+		ret = -EINVAL;
>>+		pr_debug("%s: Cannot handle command %d\n",
>>+			__func__, cmd);
>>+	}
>>+#else
>>+	ret = -ENOENT;
>>+#endif
>>+
>>+	return ret;
>>+}
>>+
>>  static long vfio_pci_ioctl(void *device_data,
>>  			   unsigned int cmd, unsigned long arg)
>>  {
>>@@ -682,6 +795,12 @@ hot_reset_release:
>>  		kfree(groups);
>>  		return ret;
>>+	} else if (cmd == VFIO_EEH_PE_SET_OPTION ||
>>+		   cmd == VFIO_EEH_PE_GET_ADDR ||
>>+		   cmd == VFIO_EEH_PE_GET_STATE ||
>>+		   cmd == VFIO_EEH_PE_RESET ||
>>+		   cmd == VFIO_EEH_PE_CONFIGURE) {
>>+			return vfio_eeh_pci_ioctl(vdev->pdev, cmd, arg);
>>  	}
>>  	return -ENOTTY;
>>diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
>>index cb9023d..ef55682 100644
>>--- a/include/uapi/linux/vfio.h
>>+++ b/include/uapi/linux/vfio.h
>>@@ -455,6 +455,59 @@ struct vfio_iommu_spapr_tce_info {
>>  #define VFIO_IOMMU_SPAPR_TCE_GET_INFO	_IO(VFIO_TYPE, VFIO_BASE + 12)
>>+/*
>>+ * EEH functionality can be enabled or disabled on one specific device.
>>+ * Also, the DMA or IO frozen state can be removed from the frozen PE
>>+ * if required.
>>+ */
>>+struct vfio_eeh_pe_set_option {
>>+	__u32 argsz;
>
>What is this argsz thing? Is this your way of maintaining backwards
>compatibility when we introduce new fields? A new field will change
>the ioctl number, so I don't think that makes a lot of sense :).
>
>Just make the ioctl have a u32 as incoming argument. No fancy
>structs, no complicated code.
>
>The same applies for a number of structs below.
>

ok. Will do in next revision.

>>+	__u32 option;
>>+};
>>+
>>+#define VFIO_EEH_PE_SET_OPTION		_IO(VFIO_TYPE, VFIO_BASE + 21)
>>+
>>+/*
>>+ * Each EEH PE should have unique address to be identified. The command
>>+ * helps to retrieve the address and the sharing mode of the PE.
>>+ */
>>+struct vfio_eeh_pe_get_addr {
>>+	__u32 argsz;
>>+	__u32 option;
>>+	__u32 info;
>
>Any particular reason you need the info field? Can't the return value
>of the ioctl hold this? Then you only have a single u32 argument left
>to the ioctl again.
>

ok. Will do in next revision.

>>+};
>>+
>>+#define VFIO_EEH_PE_GET_ADDR		_IO(VFIO_TYPE, VFIO_BASE + 22)
>>+
>>+/*
>>+ * EEH PE might have been frozen because of PCI errors. Also, it might
>>+ * be experiencing reset for error revoery. The following command helps
>>+ * to get the state.
>>+ */
>>+struct vfio_eeh_pe_get_state {
>>+	__u32 argsz;
>>+	__u32 state;
>>+};
>>+
>>+#define VFIO_EEH_PE_GET_STATE		_IO(VFIO_TYPE, VFIO_BASE + 23)
>>+
>>+/*
>>+ * Reset is the major step to recover problematic PE. The following
>>+ * command helps on that.
>>+ */
>>+struct vfio_eeh_pe_reset {
>>+	__u32 argsz;
>>+	__u32 option;
>>+};
>>+
>>+#define VFIO_EEH_PE_RESET		_IO(VFIO_TYPE, VFIO_BASE + 24)
>>+
>>+/*
>>+ * One of the steps for recovery after PE reset is to configure the
>>+ * PCI bridges affected by the PE reset.
>>+ */
>>+#define VFIO_EEH_PE_CONFIGURE		_IO(VFIO_TYPE, VFIO_BASE + 25)
>>+
>>  /* ***************************************************************** */
>>  #endif /* _UAPIVFIO_H */

Thanks,
Gavin
