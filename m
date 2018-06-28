Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41GxNb5mKXzF1PV
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jun 2018 09:50:23 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5SNnQoO042569
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jun 2018 19:50:21 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2jw89eam47-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jun 2018 19:50:21 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Fri, 29 Jun 2018 00:50:19 +0100
Subject: Re: [PATCH v2 05/10] Revert "cxl: Add cxl_check_and_switch_mode() API
 to switch bi-modal cards"
To: Frederic Barrat <fbarrat@linux.ibm.com>, alastair@au1.ibm.com,
 vaibhav@linux.ibm.com, clombard@linux.ibm.com, felix@linux.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Cc: huyn@mellanox.com
References: <20180628100509.17413-1-fbarrat@linux.ibm.com>
 <20180628100509.17413-6-fbarrat@linux.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Fri, 29 Jun 2018 09:50:11 +1000
MIME-Version: 1.0
In-Reply-To: <20180628100509.17413-6-fbarrat@linux.ibm.com>
Message-Id: <79c813cf-0832-1826-555e-5c53350b08e3@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 28/06/18 20:05, Frederic Barrat wrote:
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> Remove abandonned capi support for the Mellanox CX4.
> 
> This reverts commit b0b5e5918ad1babfd1d43d98c7281926a7b57b9f.
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>

I was kinda proud at how dodgy this was and yet how it actually worked...

(Hmm, I should go back and see if there's anything we can rip out of 
pnv_php now...)

Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

> ---
>   drivers/misc/cxl/Kconfig |   8 --
>   drivers/misc/cxl/pci.c   | 236 +++------------------------------------
>   include/misc/cxl.h       |  25 -----
>   3 files changed, 18 insertions(+), 251 deletions(-)
> 
> diff --git a/drivers/misc/cxl/Kconfig b/drivers/misc/cxl/Kconfig
> index 93397cb05b15..3ce933707828 100644
> --- a/drivers/misc/cxl/Kconfig
> +++ b/drivers/misc/cxl/Kconfig
> @@ -33,11 +33,3 @@ config CXL
>   	  CAPI adapters are found in POWER8 based systems.
>   
>   	  If unsure, say N.
> -
> -config CXL_BIMODAL
> -	bool "Support for bi-modal CAPI cards"
> -	depends on HOTPLUG_PCI_POWERNV = y && CXL || HOTPLUG_PCI_POWERNV = m && CXL = m
> -	default y
> -	help
> -	  Select this option to enable support for bi-modal CAPI cards, such as
> -	  the Mellanox CX-4.
> diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
> index 429d6de1dde7..9c5a21fee835 100644
> --- a/drivers/misc/cxl/pci.c
> +++ b/drivers/misc/cxl/pci.c
> @@ -55,8 +55,6 @@
>   	pci_read_config_byte(dev, vsec + 0xa, dest)
>   #define CXL_WRITE_VSEC_MODE_CONTROL(dev, vsec, val) \
>   	pci_write_config_byte(dev, vsec + 0xa, val)
> -#define CXL_WRITE_VSEC_MODE_CONTROL_BUS(bus, devfn, vsec, val) \
> -	pci_bus_write_config_byte(bus, devfn, vsec + 0xa, val)
>   #define CXL_VSEC_PROTOCOL_MASK   0xe0
>   #define CXL_VSEC_PROTOCOL_1024TB 0x80
>   #define CXL_VSEC_PROTOCOL_512TB  0x40
> @@ -800,234 +798,36 @@ static int setup_cxl_bars(struct pci_dev *dev)
>   	return 0;
>   }
>   
> -#ifdef CONFIG_CXL_BIMODAL
> -
> -struct cxl_switch_work {
> -	struct pci_dev *dev;
> -	struct work_struct work;
> -	int vsec;
> -	int mode;
> -};
> -
> -static void switch_card_to_cxl(struct work_struct *work)
> +/* pciex node: ibm,opal-m64-window = <0x3d058 0x0 0x3d058 0x0 0x8 0x0>; */
> +static int switch_card_to_cxl(struct pci_dev *dev)
>   {
> -	struct cxl_switch_work *switch_work =
> -		container_of(work, struct cxl_switch_work, work);
> -	struct pci_dev *dev = switch_work->dev;
> -	struct pci_bus *bus = dev->bus;
> -	struct pci_controller *hose = pci_bus_to_host(bus);
> -	struct pci_dev *bridge;
> -	struct pnv_php_slot *php_slot;
> -	unsigned int devfn;
> +	int vsec;
>   	u8 val;
>   	int rc;
>   
> -	dev_info(&bus->dev, "cxl: Preparing for mode switch...\n");
> -	bridge = list_first_entry_or_null(&hose->bus->devices, struct pci_dev,
> -					  bus_list);
> -	if (!bridge) {
> -		dev_WARN(&bus->dev, "cxl: Couldn't find root port!\n");
> -		goto err_dev_put;
> -	}
> +	dev_info(&dev->dev, "switch card to CXL\n");
>   
> -	php_slot = pnv_php_find_slot(pci_device_to_OF_node(bridge));
> -	if (!php_slot) {
> -		dev_err(&bus->dev, "cxl: Failed to find slot hotplug "
> -			           "information. You may need to upgrade "
> -			           "skiboot. Aborting.\n");
> -		goto err_dev_put;
> -	}
> -
> -	rc = CXL_READ_VSEC_MODE_CONTROL(dev, switch_work->vsec, &val);
> -	if (rc) {
> -		dev_err(&bus->dev, "cxl: Failed to read CAPI mode control: %i\n", rc);
> -		goto err_dev_put;
> -	}
> -	devfn = dev->devfn;
> -
> -	/* Release the reference obtained in cxl_check_and_switch_mode() */
> -	pci_dev_put(dev);
> -
> -	dev_dbg(&bus->dev, "cxl: Removing PCI devices from kernel\n");
> -	pci_lock_rescan_remove();
> -	pci_hp_remove_devices(bridge->subordinate);
> -	pci_unlock_rescan_remove();
> -
> -	/* Switch the CXL protocol on the card */
> -	if (switch_work->mode == CXL_BIMODE_CXL) {
> -		dev_info(&bus->dev, "cxl: Switching card to CXL mode\n");
> -		val &= ~CXL_VSEC_PROTOCOL_MASK;
> -		val |= CXL_VSEC_PROTOCOL_256TB | CXL_VSEC_PROTOCOL_ENABLE;
> -		rc = pnv_cxl_enable_phb_kernel_api(hose, true);
> -		if (rc) {
> -			dev_err(&bus->dev, "cxl: Failed to enable kernel API"
> -				           " on real PHB, aborting\n");
> -			goto err_free_work;
> -		}
> -	} else {
> -		dev_WARN(&bus->dev, "cxl: Switching card to PCI mode not supported!\n");
> -		goto err_free_work;
> -	}
> -
> -	rc = CXL_WRITE_VSEC_MODE_CONTROL_BUS(bus, devfn, switch_work->vsec, val);
> -	if (rc) {
> -		dev_err(&bus->dev, "cxl: Failed to configure CXL protocol: %i\n", rc);
> -		goto err_free_work;
> -	}
> -
> -	/*
> -	 * The CAIA spec (v1.1, Section 10.6 Bi-modal Device Support) states
> -	 * we must wait 100ms after this mode switch before touching PCIe config
> -	 * space.
> -	 */
> -	msleep(100);
> -
> -	/*
> -	 * Hot reset to cause the card to come back in cxl mode. A
> -	 * OPAL_RESET_PCI_LINK would be sufficient, but currently lacks support
> -	 * in skiboot, so we use a hot reset instead.
> -	 *
> -	 * We call pci_set_pcie_reset_state() on the bridge, as a CAPI card is
> -	 * guaranteed to sit directly under the root port, and setting the reset
> -	 * state on a device directly under the root port is equivalent to doing
> -	 * it on the root port iself.
> -	 */
> -	dev_info(&bus->dev, "cxl: Configuration write complete, resetting card\n");
> -	pci_set_pcie_reset_state(bridge, pcie_hot_reset);
> -	pci_set_pcie_reset_state(bridge, pcie_deassert_reset);
> -
> -	dev_dbg(&bus->dev, "cxl: Offlining slot\n");
> -	rc = pnv_php_set_slot_power_state(&php_slot->slot, OPAL_PCI_SLOT_OFFLINE);
> -	if (rc) {
> -		dev_err(&bus->dev, "cxl: OPAL offlining call failed: %i\n", rc);
> -		goto err_free_work;
> -	}
> -
> -	dev_dbg(&bus->dev, "cxl: Onlining and probing slot\n");
> -	rc = pnv_php_set_slot_power_state(&php_slot->slot, OPAL_PCI_SLOT_ONLINE);
> -	if (rc) {
> -		dev_err(&bus->dev, "cxl: OPAL onlining call failed: %i\n", rc);
> -		goto err_free_work;
> -	}
> -
> -	pci_lock_rescan_remove();
> -	pci_hp_add_devices(bridge->subordinate);
> -	pci_unlock_rescan_remove();
> -
> -	dev_info(&bus->dev, "cxl: CAPI mode switch completed\n");
> -	kfree(switch_work);
> -	return;
> -
> -err_dev_put:
> -	/* Release the reference obtained in cxl_check_and_switch_mode() */
> -	pci_dev_put(dev);
> -err_free_work:
> -	kfree(switch_work);
> -}
> -
> -int cxl_check_and_switch_mode(struct pci_dev *dev, int mode, int vsec)
> -{
> -	struct cxl_switch_work *work;
> -	u8 val;
> -	int rc;
> -
> -	if (!cpu_has_feature(CPU_FTR_HVMODE))
> +	if (!(vsec = find_cxl_vsec(dev))) {
> +		dev_err(&dev->dev, "ABORTING: CXL VSEC not found!\n");
>   		return -ENODEV;
> -
> -	if (!vsec) {
> -		vsec = find_cxl_vsec(dev);
> -		if (!vsec) {
> -			dev_info(&dev->dev, "CXL VSEC not found\n");
> -			return -ENODEV;
> -		}
>   	}
>   
> -	rc = CXL_READ_VSEC_MODE_CONTROL(dev, vsec, &val);
> -	if (rc) {
> -		dev_err(&dev->dev, "Failed to read current mode control: %i", rc);
> +	if ((rc = CXL_READ_VSEC_MODE_CONTROL(dev, vsec, &val))) {
> +		dev_err(&dev->dev, "failed to read current mode control: %i", rc);
>   		return rc;
>   	}
> -
> -	if (mode == CXL_BIMODE_PCI) {
> -		if (!(val & CXL_VSEC_PROTOCOL_ENABLE)) {
> -			dev_info(&dev->dev, "Card is already in PCI mode\n");
> -			return 0;
> -		}
> -		/*
> -		 * TODO: Before it's safe to switch the card back to PCI mode
> -		 * we need to disable the CAPP and make sure any cachelines the
> -		 * card holds have been flushed out. Needs skiboot support.
> -		 */
> -		dev_WARN(&dev->dev, "CXL mode switch to PCI unsupported!\n");
> -		return -EIO;
> -	}
> -
> -	if (val & CXL_VSEC_PROTOCOL_ENABLE) {
> -		dev_info(&dev->dev, "Card is already in CXL mode\n");
> -		return 0;
> +	val &= ~CXL_VSEC_PROTOCOL_MASK;
> +	val |= CXL_VSEC_PROTOCOL_256TB | CXL_VSEC_PROTOCOL_ENABLE;
> +	if ((rc = CXL_WRITE_VSEC_MODE_CONTROL(dev, vsec, val))) {
> +		dev_err(&dev->dev, "failed to enable CXL protocol: %i", rc);
> +		return rc;
>   	}
> -
> -	dev_info(&dev->dev, "Card is in PCI mode, scheduling kernel thread "
> -			    "to switch to CXL mode\n");
> -
> -	work = kmalloc(sizeof(struct cxl_switch_work), GFP_KERNEL);
> -	if (!work)
> -		return -ENOMEM;
> -
> -	pci_dev_get(dev);
> -	work->dev = dev;
> -	work->vsec = vsec;
> -	work->mode = mode;
> -	INIT_WORK(&work->work, switch_card_to_cxl);
> -
> -	schedule_work(&work->work);
> -
>   	/*
> -	 * We return a failure now to abort the driver init. Once the
> -	 * link has been cycled and the card is in cxl mode we will
> -	 * come back (possibly using the generic cxl driver), but
> -	 * return success as the card should then be in cxl mode.
> -	 *
> -	 * TODO: What if the card comes back in PCI mode even after
> -	 *       the switch?  Don't want to spin endlessly.
> +	 * The CAIA spec (v0.12 11.6 Bi-modal Device Support) states
> +	 * we must wait 100ms after this mode switch before touching
> +	 * PCIe config space.
>   	 */
> -	return -EBUSY;
> -}
> -EXPORT_SYMBOL_GPL(cxl_check_and_switch_mode);
> -
> -#endif /* CONFIG_CXL_BIMODAL */
> -
> -static int setup_cxl_protocol_area(struct pci_dev *dev)
> -{
> -	u8 val;
> -	int rc;
> -	int vsec = find_cxl_vsec(dev);
> -
> -	if (!vsec) {
> -		dev_info(&dev->dev, "CXL VSEC not found\n");
> -		return -ENODEV;
> -	}
> -
> -	rc = CXL_READ_VSEC_MODE_CONTROL(dev, vsec, &val);
> -	if (rc) {
> -		dev_err(&dev->dev, "Failed to read current mode control: %i\n", rc);
> -		return rc;
> -	}
> -
> -	if (!(val & CXL_VSEC_PROTOCOL_ENABLE)) {
> -		dev_err(&dev->dev, "Card not in CAPI mode!\n");
> -		return -EIO;
> -	}
> -
> -	if ((val & CXL_VSEC_PROTOCOL_MASK) != CXL_VSEC_PROTOCOL_256TB) {
> -		val &= ~CXL_VSEC_PROTOCOL_MASK;
> -		val |= CXL_VSEC_PROTOCOL_256TB;
> -		rc = CXL_WRITE_VSEC_MODE_CONTROL(dev, vsec, val);
> -		if (rc) {
> -			dev_err(&dev->dev, "Failed to set CXL protocol area: %i\n", rc);
> -			return rc;
> -		}
> -	}
> +	msleep(100);
>   
>   	return 0;
>   }
> @@ -1724,7 +1524,7 @@ static int cxl_configure_adapter(struct cxl *adapter, struct pci_dev *dev)
>   	if ((rc = setup_cxl_bars(dev)))
>   		return rc;
>   
> -	if ((rc = setup_cxl_protocol_area(dev)))
> +	if ((rc = switch_card_to_cxl(dev)))
>   		return rc;
>   
>   	if ((rc = cxl_update_image_control(adapter)))
> diff --git a/include/misc/cxl.h b/include/misc/cxl.h
> index 6a3711a2e217..74da2e440763 100644
> --- a/include/misc/cxl.h
> +++ b/include/misc/cxl.h
> @@ -39,31 +39,6 @@
>   bool cxl_slot_is_supported(struct pci_dev *dev, int flags);
>   
>   
> -#define CXL_BIMODE_CXL 1
> -#define CXL_BIMODE_PCI 2
> -
> -/*
> - * Check the mode that the given bi-modal CXL adapter is currently in and
> - * change it if necessary. This does not apply to AFU drivers.
> - *
> - * If the mode matches the requested mode this function will return 0 - if the
> - * driver was expecting the generic CXL driver to have bound to the adapter and
> - * it gets this return value it should fail the probe function to give the CXL
> - * driver a chance to probe it.
> - *
> - * If the mode does not match it will start a background task to unplug the
> - * device from Linux and switch its mode, and will return -EBUSY. At this
> - * point the calling driver should make sure it has released the device and
> - * fail its probe function.
> - *
> - * The offset of the CXL VSEC can be provided to this function. If 0 is passed,
> - * this function will search for a CXL VSEC with ID 0x1280 and return -ENODEV
> - * if it is not found.
> - */
> -#ifdef CONFIG_CXL_BIMODAL
> -int cxl_check_and_switch_mode(struct pci_dev *dev, int mode, int vsec);
> -#endif
> -
>   /* Get the AFU associated with a pci_dev */
>   struct cxl_afu *cxl_pci_to_afu(struct pci_dev *dev);
>   
> 

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
