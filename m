Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D8F211A0279
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2015 11:19:32 +1100 (AEDT)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id DB5DF140083
 for <linuxppc-dev@ozlabs.org>; Tue, 24 Mar 2015 11:19:31 +1100 (AEDT)
Message-ID: <1427156351.4770.286.camel@kernel.crashing.org>
Subject: Re: [PATCH v3 1/2] PCI: One more parameter to
 pci_set_pcie_reset_state()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: cascardo@linux.vnet.ibm.com
Date: Tue, 24 Mar 2015 11:19:11 +1100
In-Reply-To: <20150323200729.GB1368@oc0812247204.ltc.br.ibm.com>
References: <1427079771-18472-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1427081673.3643.547.camel@redhat.com> <20150323035656.GA27802@shangw>
 <1427083561.3643.551.camel@redhat.com> <20150323044033.GA1874@shangw>
 <1427114434.3643.554.camel@redhat.com>
 <20150323200729.GB1368@oc0812247204.ltc.br.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-pci@vger.kernel.org, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 linuxppc-dev@ozlabs.org, Alex Williamson <alex.williamson@redhat.com>,
 Brian King <brking@us.ibm.com>, Ian Munsie <imunsie@au1.ibm.com>,
 bhelgaas@google.com, Frank Haverkamp <haver@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-03-23 at 17:07 -0300, cascardo@linux.vnet.ibm.com wrote:
> 
> I agree with you here. I think the bigger issue is that we are not
> making sure VFIO is secure, allowing functions to be assigned
> separately to different guests, even when we cannot guarantee we can
> safely reset a single function, and also ignoring the possibility of
> internal communication between functions. This second problem is real,
> since some adapters will allow firmware to be loaded or reset, which
> will affect other functions.

We do ... on power. We don't create per-function PEs for that specific
reason. Yes it does prevent individual ports of network adapters from
being assigned to different guests but the HW cannot be trusted. We
might add ways to "relax" this for cases where the user somewhat knows
what he is doing, but the problem of the reset will remain.

> We need to either have in written that this is acceptable and that
> higher layers should take care of these possibilities, if they care
> about them, or we need to fix this, by making VFIO only accept a whole
> group of functions to be assigned to a guest, which will allow the
> problem described by Gavin to be properly handled, by using slot reset
> functions, or another way of grouping devices that may be specific to
> the platform.
> Does it make sense?
> 
> Cascardo.
> 
> > > >> >> diff --git a/arch/powerpc/kernel/eeh.c
> b/arch/powerpc/kernel/eeh.c
> > > >> >> index daa68a1..cd85c18 100644
> > > >> >> --- a/arch/powerpc/kernel/eeh.c
> > > >> >> +++ b/arch/powerpc/kernel/eeh.c
> > > >> >> @@ -726,11 +726,14 @@ static void
> *eeh_restore_dev_state(void *data, void *userdata)
> > > >> >>   * pcibios_set_pcie_slot_reset - Set PCI-E reset state
> > > >> >>   * @dev: pci device struct
> > > >> >>   * @state: reset state to enter
> > > >> >> + * @probe: check if the device can take the reset
> > > >> >>   *
> > > >> >>   * Return value:
> > > >> >>   *   0 if success
> > > >> >>   */
> > > >> >> -int pcibios_set_pcie_reset_state(struct pci_dev *dev, enum
> pcie_reset_state state)
> > > >> >> +int pcibios_set_pcie_reset_state(struct pci_dev *dev,
> > > >> >> +                              enum pcie_reset_state state,
> > > >> >> +                              int probe)
> > > >> >>  {
> > > >> >>       struct eeh_dev *edev = pci_dev_to_eeh_dev(dev);
> > > >> >>       struct eeh_pe *pe = eeh_dev_to_pe(edev);
> > > >> >> @@ -738,9 +741,12 @@ int pcibios_set_pcie_reset_state(struct
> pci_dev *dev, enum pcie_reset_state stat
> > > >> >>       if (!pe) {
> > > >> >>               pr_err("%s: No PE found on PCI device %s\n",
> > > >> >>                       __func__, pci_name(dev));
> > > >> >> -             return -EINVAL;
> > > >> >> +             return -ENOTTY;
> > > >> >>       }
> > > >> >>  
> > > >> >> +     if (probe)
> > > >> >> +             return 0;
> > > >> >> +
> > > >> >>       switch (state) {
> > > >> >>       case pcie_deassert_reset:
> > > >> >>               eeh_ops->reset(pe, EEH_RESET_DEACTIVATE);
> > > >> >> @@ -762,8 +768,8 @@ int pcibios_set_pcie_reset_state(struct
> pci_dev *dev, enum pcie_reset_state stat
> > > >> >>               break;
> > > >> >>       default:
> > > >> >>               eeh_pe_state_clear(pe, EEH_PE_CFG_BLOCKED);
> > > >> >> -             return -EINVAL;
> > > >> >> -     };
> > > >> >> +             return -ENOTTY;
> > > >> >> +     }
> > > >> >>  
> > > >> >>       return 0;
> > > >> >>  }
> > > >> >> diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
> > > >> >> index 1ef0164..3a87bfc 100644
> > > >> >> --- a/drivers/misc/cxl/pci.c
> > > >> >> +++ b/drivers/misc/cxl/pci.c
> > > >> >> @@ -789,7 +789,7 @@ int cxl_reset(struct cxl *adapter)
> > > >> >>       /* pcie_warm_reset requests a fundamental pci reset
> which includes a
> > > >> >>        * PERST assert/deassert.  PERST triggers a loading of
> the image
> > > >> >>        * if "user" or "factory" is selected in sysfs */
> > > >> >> -     if ((rc = pci_set_pcie_reset_state(dev,
> pcie_warm_reset))) {
> > > >> >> +     if ((rc = pci_set_pcie_reset_state(dev,
> pcie_warm_reset, 0))) {
> > > >> >>               dev_err(&dev->dev, "cxl: pcie_warm_reset
> failed\n");
> > > >> >>               return rc;
> > > >> >>       }
> > > >> >> diff --git a/drivers/misc/genwqe/card_base.c
> b/drivers/misc/genwqe/card_base.c
> > > >> >> index 4cf8f82..4871f69 100644
> > > >> >> --- a/drivers/misc/genwqe/card_base.c
> > > >> >> +++ b/drivers/misc/genwqe/card_base.c
> > > >> >> @@ -782,17 +782,22 @@ static int
> genwqe_pci_fundamental_reset(struct pci_dev *pci_dev)
> > > >> >>  {
> > > >> >>       int rc;
> > > >> >>  
> > > >> >> +     /* Probe if the device can take the reset */
> > > >> >> +     rc = pci_set_pcie_reset_state(pci_dev,
> pcie_warm_reset, 1);
> > > >> >> +     if (rc)
> > > >> >> +             return rc;
> > > >> >> +
> > > >> >>       /*
> > > >> >>        * lock pci config space access from userspace,
> > > >> >>        * save state and issue PCIe fundamental reset
> > > >> >>        */
> > > >> >>       pci_cfg_access_lock(pci_dev);
> > > >> >>       pci_save_state(pci_dev);
> > > >> >> -     rc = pci_set_pcie_reset_state(pci_dev,
> pcie_warm_reset);
> > > >> >> +     rc = pci_set_pcie_reset_state(pci_dev,
> pcie_warm_reset, 0);
> > > >> >>       if (!rc) {
> > > >> >>               /* keep PCIe reset asserted for 250ms */
> > > >> >>               msleep(250);
> > > >> >> -             pci_set_pcie_reset_state(pci_dev,
> pcie_deassert_reset);
> > > >> >> +             pci_set_pcie_reset_state(pci_dev,
> pcie_deassert_reset, 0);
> > > >> >>               /* Wait for 2s to reload flash and train the
> link */
> > > >> >>               msleep(2000);
> > > >> >>       }
> > > >> >> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > >> >> index 81f06e8..8581a5f 100644
> > > >> >> --- a/drivers/pci/pci.c
> > > >> >> +++ b/drivers/pci/pci.c
> > > >> >> @@ -1558,28 +1558,31 @@ EXPORT_SYMBOL(pci_disable_device);
> > > >> >>   * pcibios_set_pcie_reset_state - set reset state for
> device dev
> > > >> >>   * @dev: the PCIe device reset
> > > >> >>   * @state: Reset state to enter into
> > > >> >> - *
> > > >> >> + * @probe: Check if the device can take the reset
> > > >> >>   *
> > > >> >>   * Sets the PCIe reset state for the device. This is the
> default
> > > >> >>   * implementation. Architecture implementations can
> override this.
> > > >> >>   */
> > > >> >>  int __weak pcibios_set_pcie_reset_state(struct pci_dev
> *dev,
> > > >> >> -                                     enum pcie_reset_state
> state)
> > > >> >> +                                     enum pcie_reset_state
> state,
> > > >> >> +                                     int probe)
> > > >> >>  {
> > > >> >> -     return -EINVAL;
> > > >> >> +     return -ENOTTY;
> > > >> >>  }
> > > >> >>  
> > > >> >>  /**
> > > >> >>   * pci_set_pcie_reset_state - set reset state for device
> dev
> > > >> >>   * @dev: the PCIe device reset
> > > >> >>   * @state: Reset state to enter into
> > > >> >> - *
> > > >> >> + * @probe: Check if the device can take the reset
> > > >> >>   *
> > > >> >>   * Sets the PCI reset state for the device.
> > > >> >>   */
> > > >> >> -int pci_set_pcie_reset_state(struct pci_dev *dev, enum
> pcie_reset_state state)
> > > >> >> +int pci_set_pcie_reset_state(struct pci_dev *dev,
> > > >> >> +                          enum pcie_reset_state state,
> > > >> >> +                          int probe)
> > > >> >>  {
> > > >> >> -     return pcibios_set_pcie_reset_state(dev, state);
> > > >> >> +     return pcibios_set_pcie_reset_state(dev, state,
> probe);
> > > >> >>  }
> > > >> >>  EXPORT_SYMBOL_GPL(pci_set_pcie_reset_state);
> > > >> >>  
> > > >> >> diff --git a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
> > > >> >> index 9219953..89026f4 100644
> > > >> >> --- a/drivers/scsi/ipr.c
> > > >> >> +++ b/drivers/scsi/ipr.c
> > > >> >> @@ -8317,7 +8317,8 @@ static int ipr_reset_start_bist(struct
> ipr_cmnd *ipr_cmd)
> > > >> >>  static int ipr_reset_slot_reset_done(struct ipr_cmnd
> *ipr_cmd)
> > > >> >>  {
> > > >> >>       ENTER;
> > > >> >> -     pci_set_pcie_reset_state(ipr_cmd->ioa_cfg->pdev,
> pcie_deassert_reset);
> > > >> >> +     pci_set_pcie_reset_state(ipr_cmd->ioa_cfg->pdev,
> > > >> >> +                              pcie_deassert_reset, 0);
> > > >> >>       ipr_cmd->job_step = ipr_reset_bist_done;
> > > >> >>       ipr_reset_start_timer(ipr_cmd,
> IPR_WAIT_FOR_BIST_TIMEOUT);
> > > >> >>       LEAVE;
> > > >> >> @@ -8339,7 +8340,7 @@ static int ipr_reset_slot_reset(struct
> ipr_cmnd *ipr_cmd)
> > > >> >>       struct pci_dev *pdev = ioa_cfg->pdev;
> > > >> >>  
> > > >> >>       ENTER;
> > > >> >> -     pci_set_pcie_reset_state(pdev, pcie_warm_reset);
> > > >> >> +     pci_set_pcie_reset_state(pdev, pcie_warm_reset, 0);
> > > >> >>       ipr_cmd->job_step = ipr_reset_slot_reset_done;
> > > >> >>       ipr_reset_start_timer(ipr_cmd, IPR_PCI_RESET_TIMEOUT);
> > > >> >>       LEAVE;
> > > >> >> diff --git a/include/linux/pci.h b/include/linux/pci.h
> > > >> >> index 4e1f17d..052ac63 100644
> > > >> >> --- a/include/linux/pci.h
> > > >> >> +++ b/include/linux/pci.h
> > > >> >> @@ -960,7 +960,8 @@ extern unsigned int pcibios_max_latency;
> > > >> >>  void pci_set_master(struct pci_dev *dev);
> > > >> >>  void pci_clear_master(struct pci_dev *dev);
> > > >> >>  
> > > >> >> -int pci_set_pcie_reset_state(struct pci_dev *dev, enum
> pcie_reset_state state);
> > > >> >> +int pci_set_pcie_reset_state(struct pci_dev *dev,
> > > >> >> +                          enum pcie_reset_state state, int
> probe);
> > > >> >>  int pci_set_cacheline_size(struct pci_dev *dev);
> > > >> >>  #define HAVE_PCI_SET_MWI
> > > >> >>  int __must_check pci_set_mwi(struct pci_dev *dev);
> > > >> >> @@ -1648,7 +1649,7 @@ extern unsigned long
> pci_hotplug_mem_size;
> > > >> >>  void pcibios_disable_device(struct pci_dev *dev);
> > > >> >>  void pcibios_set_master(struct pci_dev *dev);
> > > >> >>  int pcibios_set_pcie_reset_state(struct pci_dev *dev,
> > > >> >> -                              enum pcie_reset_state state);
> > > >> >> +                              enum pcie_reset_state state,
> int probe);
> > > >> >>  int pcibios_add_device(struct pci_dev *dev);
> > > >> >>  void pcibios_release_device(struct pci_dev *dev);
> > > >> >>  void pcibios_penalize_isa_irq(int irq, int active);
> > > >> >
> > > >> >
> > > >> >
> > > >> 
> > > >
> > > >
> > > >
> > > 
> > 
> > 
> > 
