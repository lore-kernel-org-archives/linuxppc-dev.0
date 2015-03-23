Return-Path: <alex.williamson@redhat.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 15EF11A2B89
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2015 15:06:13 +1100 (AEDT)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3FCEF140134
 for <linuxppc-dev@ozlabs.org>; Mon, 23 Mar 2015 15:06:11 +1100 (AEDT)
Message-ID: <1427083561.3643.551.camel@redhat.com>
Subject: Re: [PATCH v3 1/2] PCI: One more parameter to
 pci_set_pcie_reset_state()
From: Alex Williamson <alex.williamson@redhat.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Date: Sun, 22 Mar 2015 22:06:01 -0600
In-Reply-To: <20150323035656.GA27802@shangw>
References: <1427079771-18472-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1427081673.3643.547.camel@redhat.com> <20150323035656.GA27802@shangw>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-pci@vger.kernel.org, linuxppc-dev@ozlabs.org,
 Brian King <brking@us.ibm.com>, cascardo@linux.vnet.ibm.com,
 bhelgaas@google.com, Frank Haverkamp <haver@linux.vnet.ibm.com>,
 Ian Munsie <imunsie@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-03-23 at 14:56 +1100, Gavin Shan wrote:
> On Sun, Mar 22, 2015 at 09:34:33PM -0600, Alex Williamson wrote:
> >On Mon, 2015-03-23 at 14:02 +1100, Gavin Shan wrote:
> >> The patch adds one more parameter ("probe") to pci_set_pcie_reset_state(),
> >> which allows to check if one particular PCI device can be resetted by the
> >> function. The function will be reused to support PCI device specific methods
> >> maintained in pci_dev_reset_methods[] in subsequent patch.
> >> 
> >> Cc: Brian King <brking@us.ibm.com>
> >> Cc: Frank Haverkamp <haver@linux.vnet.ibm.com>
> >> Cc: Ian Munsie <imunsie@au1.ibm.com>
> >> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> >> ---
> >> v3: Fix arguments of pci_set_pcie_reset_state() in cxl driver
> >> v2: Reimplemented based on pci_set_pcie_reset_state()
> >> ---
> >>  arch/powerpc/kernel/eeh.c       | 14 ++++++++++----
> >>  drivers/misc/cxl/pci.c          |  2 +-
> >>  drivers/misc/genwqe/card_base.c |  9 +++++++--
> >>  drivers/pci/pci.c               | 15 +++++++++------
> >>  drivers/scsi/ipr.c              |  5 +++--
> >>  include/linux/pci.h             |  5 +++--
> >>  6 files changed, 33 insertions(+), 17 deletions(-)
> >
> >
> >Argh, you're trying to make pci_set_pcie_reset_state() compatible with
> >pci_dev_specific_reset(), so it can be called via pci_reset_function(),
> >but the whole point of the pci_reset_function() interface is to reset a
> >*single* function without disturbing anything else.  These patches make
> >no effort at all to limit the set of affected devices to a single
> >function and take great liberties using PCI_ANY_ID for vendors.  My take
> >on the powerpc version of pcibios_set_pcie_reset_state() is that it's
> >effectively a slot reset, so why not hook into the
> >pci_reset_hotplug_slot() via the hotplug slot ops?  Please also use
> >cover letters.  Thanks,
> >
> 
> Yep, that's the point and intention of the patches. pcibios_set_pcie_reset_state()
> isn't equal to pci_reset_hotplug_slot(). The later one depends on PCI slot, which
> wasn't populated on PowerNV platform yet, but pcibios_set_pcie_reseet_state() doesn't.
> 
> The patchset depends on improved pcibios_set_pcie_reset_state(), which can be seen
> from following linked. With it, we don't affect any PCI devices as the config space
> is saved/restored accordingly before/after reset:
> 
> https://patchwork.ozlabs.org/patch/438598/

Sorry, that's wrong.  pci_reset_function() can be called while other
devices in the same multifunction package are actively in use.  It
doesn't matter that you're saving and restoring the external state of
the device, the internal state is lost and operation of the device is
interrupted.  That is not how pci_reset_function() is supposed to work.
Thanks,

Alex

> >> diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
> >> index daa68a1..cd85c18 100644
> >> --- a/arch/powerpc/kernel/eeh.c
> >> +++ b/arch/powerpc/kernel/eeh.c
> >> @@ -726,11 +726,14 @@ static void *eeh_restore_dev_state(void *data, void *userdata)
> >>   * pcibios_set_pcie_slot_reset - Set PCI-E reset state
> >>   * @dev: pci device struct
> >>   * @state: reset state to enter
> >> + * @probe: check if the device can take the reset
> >>   *
> >>   * Return value:
> >>   * 	0 if success
> >>   */
> >> -int pcibios_set_pcie_reset_state(struct pci_dev *dev, enum pcie_reset_state state)
> >> +int pcibios_set_pcie_reset_state(struct pci_dev *dev,
> >> +				 enum pcie_reset_state state,
> >> +				 int probe)
> >>  {
> >>  	struct eeh_dev *edev = pci_dev_to_eeh_dev(dev);
> >>  	struct eeh_pe *pe = eeh_dev_to_pe(edev);
> >> @@ -738,9 +741,12 @@ int pcibios_set_pcie_reset_state(struct pci_dev *dev, enum pcie_reset_state stat
> >>  	if (!pe) {
> >>  		pr_err("%s: No PE found on PCI device %s\n",
> >>  			__func__, pci_name(dev));
> >> -		return -EINVAL;
> >> +		return -ENOTTY;
> >>  	}
> >>  
> >> +	if (probe)
> >> +		return 0;
> >> +
> >>  	switch (state) {
> >>  	case pcie_deassert_reset:
> >>  		eeh_ops->reset(pe, EEH_RESET_DEACTIVATE);
> >> @@ -762,8 +768,8 @@ int pcibios_set_pcie_reset_state(struct pci_dev *dev, enum pcie_reset_state stat
> >>  		break;
> >>  	default:
> >>  		eeh_pe_state_clear(pe, EEH_PE_CFG_BLOCKED);
> >> -		return -EINVAL;
> >> -	};
> >> +		return -ENOTTY;
> >> +	}
> >>  
> >>  	return 0;
> >>  }
> >> diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
> >> index 1ef0164..3a87bfc 100644
> >> --- a/drivers/misc/cxl/pci.c
> >> +++ b/drivers/misc/cxl/pci.c
> >> @@ -789,7 +789,7 @@ int cxl_reset(struct cxl *adapter)
> >>  	/* pcie_warm_reset requests a fundamental pci reset which includes a
> >>  	 * PERST assert/deassert.  PERST triggers a loading of the image
> >>  	 * if "user" or "factory" is selected in sysfs */
> >> -	if ((rc = pci_set_pcie_reset_state(dev, pcie_warm_reset))) {
> >> +	if ((rc = pci_set_pcie_reset_state(dev, pcie_warm_reset, 0))) {
> >>  		dev_err(&dev->dev, "cxl: pcie_warm_reset failed\n");
> >>  		return rc;
> >>  	}
> >> diff --git a/drivers/misc/genwqe/card_base.c b/drivers/misc/genwqe/card_base.c
> >> index 4cf8f82..4871f69 100644
> >> --- a/drivers/misc/genwqe/card_base.c
> >> +++ b/drivers/misc/genwqe/card_base.c
> >> @@ -782,17 +782,22 @@ static int genwqe_pci_fundamental_reset(struct pci_dev *pci_dev)
> >>  {
> >>  	int rc;
> >>  
> >> +	/* Probe if the device can take the reset */
> >> +	rc = pci_set_pcie_reset_state(pci_dev, pcie_warm_reset, 1);
> >> +	if (rc)
> >> +		return rc;
> >> +
> >>  	/*
> >>  	 * lock pci config space access from userspace,
> >>  	 * save state and issue PCIe fundamental reset
> >>  	 */
> >>  	pci_cfg_access_lock(pci_dev);
> >>  	pci_save_state(pci_dev);
> >> -	rc = pci_set_pcie_reset_state(pci_dev, pcie_warm_reset);
> >> +	rc = pci_set_pcie_reset_state(pci_dev, pcie_warm_reset, 0);
> >>  	if (!rc) {
> >>  		/* keep PCIe reset asserted for 250ms */
> >>  		msleep(250);
> >> -		pci_set_pcie_reset_state(pci_dev, pcie_deassert_reset);
> >> +		pci_set_pcie_reset_state(pci_dev, pcie_deassert_reset, 0);
> >>  		/* Wait for 2s to reload flash and train the link */
> >>  		msleep(2000);
> >>  	}
> >> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> >> index 81f06e8..8581a5f 100644
> >> --- a/drivers/pci/pci.c
> >> +++ b/drivers/pci/pci.c
> >> @@ -1558,28 +1558,31 @@ EXPORT_SYMBOL(pci_disable_device);
> >>   * pcibios_set_pcie_reset_state - set reset state for device dev
> >>   * @dev: the PCIe device reset
> >>   * @state: Reset state to enter into
> >> - *
> >> + * @probe: Check if the device can take the reset
> >>   *
> >>   * Sets the PCIe reset state for the device. This is the default
> >>   * implementation. Architecture implementations can override this.
> >>   */
> >>  int __weak pcibios_set_pcie_reset_state(struct pci_dev *dev,
> >> -					enum pcie_reset_state state)
> >> +					enum pcie_reset_state state,
> >> +					int probe)
> >>  {
> >> -	return -EINVAL;
> >> +	return -ENOTTY;
> >>  }
> >>  
> >>  /**
> >>   * pci_set_pcie_reset_state - set reset state for device dev
> >>   * @dev: the PCIe device reset
> >>   * @state: Reset state to enter into
> >> - *
> >> + * @probe: Check if the device can take the reset
> >>   *
> >>   * Sets the PCI reset state for the device.
> >>   */
> >> -int pci_set_pcie_reset_state(struct pci_dev *dev, enum pcie_reset_state state)
> >> +int pci_set_pcie_reset_state(struct pci_dev *dev,
> >> +			     enum pcie_reset_state state,
> >> +			     int probe)
> >>  {
> >> -	return pcibios_set_pcie_reset_state(dev, state);
> >> +	return pcibios_set_pcie_reset_state(dev, state, probe);
> >>  }
> >>  EXPORT_SYMBOL_GPL(pci_set_pcie_reset_state);
> >>  
> >> diff --git a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
> >> index 9219953..89026f4 100644
> >> --- a/drivers/scsi/ipr.c
> >> +++ b/drivers/scsi/ipr.c
> >> @@ -8317,7 +8317,8 @@ static int ipr_reset_start_bist(struct ipr_cmnd *ipr_cmd)
> >>  static int ipr_reset_slot_reset_done(struct ipr_cmnd *ipr_cmd)
> >>  {
> >>  	ENTER;
> >> -	pci_set_pcie_reset_state(ipr_cmd->ioa_cfg->pdev, pcie_deassert_reset);
> >> +	pci_set_pcie_reset_state(ipr_cmd->ioa_cfg->pdev,
> >> +				 pcie_deassert_reset, 0);
> >>  	ipr_cmd->job_step = ipr_reset_bist_done;
> >>  	ipr_reset_start_timer(ipr_cmd, IPR_WAIT_FOR_BIST_TIMEOUT);
> >>  	LEAVE;
> >> @@ -8339,7 +8340,7 @@ static int ipr_reset_slot_reset(struct ipr_cmnd *ipr_cmd)
> >>  	struct pci_dev *pdev = ioa_cfg->pdev;
> >>  
> >>  	ENTER;
> >> -	pci_set_pcie_reset_state(pdev, pcie_warm_reset);
> >> +	pci_set_pcie_reset_state(pdev, pcie_warm_reset, 0);
> >>  	ipr_cmd->job_step = ipr_reset_slot_reset_done;
> >>  	ipr_reset_start_timer(ipr_cmd, IPR_PCI_RESET_TIMEOUT);
> >>  	LEAVE;
> >> diff --git a/include/linux/pci.h b/include/linux/pci.h
> >> index 4e1f17d..052ac63 100644
> >> --- a/include/linux/pci.h
> >> +++ b/include/linux/pci.h
> >> @@ -960,7 +960,8 @@ extern unsigned int pcibios_max_latency;
> >>  void pci_set_master(struct pci_dev *dev);
> >>  void pci_clear_master(struct pci_dev *dev);
> >>  
> >> -int pci_set_pcie_reset_state(struct pci_dev *dev, enum pcie_reset_state state);
> >> +int pci_set_pcie_reset_state(struct pci_dev *dev,
> >> +			     enum pcie_reset_state state, int probe);
> >>  int pci_set_cacheline_size(struct pci_dev *dev);
> >>  #define HAVE_PCI_SET_MWI
> >>  int __must_check pci_set_mwi(struct pci_dev *dev);
> >> @@ -1648,7 +1649,7 @@ extern unsigned long pci_hotplug_mem_size;
> >>  void pcibios_disable_device(struct pci_dev *dev);
> >>  void pcibios_set_master(struct pci_dev *dev);
> >>  int pcibios_set_pcie_reset_state(struct pci_dev *dev,
> >> -				 enum pcie_reset_state state);
> >> +				 enum pcie_reset_state state, int probe);
> >>  int pcibios_add_device(struct pci_dev *dev);
> >>  void pcibios_release_device(struct pci_dev *dev);
> >>  void pcibios_penalize_isa_irq(int irq, int active);
> >
> >
> >
> 
