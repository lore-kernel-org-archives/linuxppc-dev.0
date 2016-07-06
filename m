Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rl8xP0fTDzDr2j
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jul 2016 04:51:52 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u66Imd3N034581
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jul 2016 14:51:50 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2415xkkx62-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Jul 2016 14:51:49 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Wed, 6 Jul 2016 19:51:48 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id B1A152190056
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jul 2016 19:51:13 +0100 (BST)
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com
 [9.149.37.252])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u66IpiA858654826
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jul 2016 18:51:44 GMT
Received: from d06av11.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av11.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u66Iph00011834
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jul 2016 12:51:44 -0600
Subject: Re: [PATCH 14/14] cxl: Add cxl_check_and_switch_mode() API to switch
 bi-modal cards
To: Ian Munsie <imunsie@au1.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Michael Neuling <mikey@neuling.org>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Huy Nguyen <huyn@mellanox.com>
References: <1467638532-9250-1-git-send-email-imunsie@au.ibm.com>
 <1467638532-9250-15-git-send-email-imunsie@au.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Wed, 6 Jul 2016 20:51:42 +0200
MIME-Version: 1.0
In-Reply-To: <1467638532-9250-15-git-send-email-imunsie@au.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <577D533E.4030605@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 04/07/2016 15:22, Ian Munsie a écrit :
> From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
>
> Add a new API, cxl_check_and_switch_mode() to allow for switching of
> bi-modal CAPI cards, such as the Mellanox CX-4 network card.
>
> When a driver requests to switch a card to CAPI mode, use PCI hotplug
> infrastructure to remove all PCI devices underneath the slot. We then write
> an updated mode control register to the CAPI VSEC, hot reset the card, and
> reprobe the card.
>
> As the card may present a different set of PCI devices after the mode
> switch, use the infrastructure provided by the pnv_php driver and the OPAL
> PCI slot management facilities to ensure that:
>
>    * the old devices are removed from both the OPAL and Linux device trees
>    * the new devices are probed by OPAL and added to the OPAL device tree
>    * the new devices are added to the Linux device tree and probed through
>      the regular PCI device probe path
>
> As such, introduce a new option, CONFIG_CXL_BIMODAL, with a dependency on
> the pnv_php driver.
>
> Refactor existing code that touches the mode control register in the
> regular single mode case into a new function, setup_cxl_protocol_area().
>
> Co-authored-by: Ian Munsie <imunsie@au1.ibm.com>
> Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
>   drivers/misc/cxl/Kconfig |   8 ++
>   drivers/misc/cxl/pci.c   | 234 +++++++++++++++++++++++++++++++++++++++++++----
>   include/misc/cxl.h       |  25 +++++
>   3 files changed, 249 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/misc/cxl/Kconfig b/drivers/misc/cxl/Kconfig
> index 560412c..6859723 100644
> --- a/drivers/misc/cxl/Kconfig
> +++ b/drivers/misc/cxl/Kconfig
> @@ -38,3 +38,11 @@ config CXL
>   	  CAPI adapters are found in POWER8 based systems.
>
>   	  If unsure, say N.
> +
> +config CXL_BIMODAL
> +	bool "Support for bi-modal CAPI cards"
> +	depends on HOTPLUG_PCI_POWERNV = y && CXL || HOTPLUG_PCI_POWERNV = m && CXL = m
> +	default y
> +	help
> +	  Select this option to enable support for bi-modal CAPI cards, such as
> +	  the Mellanox CX-4.
> \ No newline at end of file
> diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
> index 090eee8..63abd26 100644
> --- a/drivers/misc/cxl/pci.c
> +++ b/drivers/misc/cxl/pci.c
> @@ -55,6 +55,8 @@
>   	pci_read_config_byte(dev, vsec + 0xa, dest)
>   #define CXL_WRITE_VSEC_MODE_CONTROL(dev, vsec, val) \
>   	pci_write_config_byte(dev, vsec + 0xa, val)
> +#define CXL_WRITE_VSEC_MODE_CONTROL_BUS(bus, devfn, vsec, val) \
> +	pci_bus_write_config_byte(bus, devfn, vsec + 0xa, val)
>   #define CXL_VSEC_PROTOCOL_MASK   0xe0
>   #define CXL_VSEC_PROTOCOL_1024TB 0x80
>   #define CXL_VSEC_PROTOCOL_512TB  0x40
> @@ -614,36 +616,232 @@ static int setup_cxl_bars(struct pci_dev *dev)
>   	return 0;
>   }
>
> -/* pciex node: ibm,opal-m64-window = <0x3d058 0x0 0x3d058 0x0 0x8 0x0>; */
> -static int switch_card_to_cxl(struct pci_dev *dev)
> -{
> +#ifdef CONFIG_CXL_BIMODAL
> +
> +struct cxl_switch_work {
> +	struct pci_dev *dev;
> +	struct work_struct work;
>   	int vsec;
> +	int mode;
> +};
> +
> +static void switch_card_to_cxl(struct work_struct *work)
> +{
> +	struct cxl_switch_work *switch_work =
> +		container_of(work, struct cxl_switch_work, work);
> +	struct pci_dev *dev = switch_work->dev;
> +	struct pci_bus *bus = dev->bus;
> +	struct pci_controller *hose = pci_bus_to_host(bus);
> +	struct pci_dev *bridge;
> +	struct pnv_php_slot *php_slot;
> +	unsigned int devfn;
>   	u8 val;
>   	int rc;
>
> -	dev_info(&dev->dev, "switch card to CXL\n");
> +	dev_info(&bus->dev, "cxl: Preparing for mode switch...\n");
> +	bridge = list_first_entry_or_null(&hose->bus->devices, struct pci_dev,
> +					  bus_list);
> +	if (!bridge) {
> +		dev_WARN(&bus->dev, "cxl: Couldn't find root port!\n");
> +		goto err_free_work;
> +	}
>
> -	if (!(vsec = find_cxl_vsec(dev))) {
> -		dev_err(&dev->dev, "ABORTING: CXL VSEC not found!\n");
> +	php_slot = pnv_php_find_slot(pci_device_to_OF_node(bridge));
> +	if (!php_slot) {
> +		dev_err(&bus->dev, "cxl: Failed to find slot hotplug "
> +			           "information. You may need to upgrade "
> +			           "skiboot. Aborting.\n");
> +		pci_dev_put(dev);
> +		goto err_free_work;
> +	}
> +
> +	rc = CXL_READ_VSEC_MODE_CONTROL(dev, switch_work->vsec, &val);
> +	if (rc) {
> +		dev_err(&bus->dev, "cxl: Failed to read CAPI mode control: %i\n", rc);
> +		pci_dev_put(dev);
> +		goto err_free_work;
> +	}
> +	devfn = dev->devfn;
> +	pci_dev_put(dev);

This is to balance the 'get' done in cxl_check_and_switch_mode(), right? 
A comment wouldn't hurt. I think we're missing the 'put' on the first 
error path above (!bridge).

I was half-expecting to see a new entry in the cxl_pci_tbl pci ID table 
for the Mellanox entry, but no such thing. By what magic is cxl_probe() 
called after the switch? Because of the device class?

Out of curiosity, could you tell me what the 3rd pci function looks like 
(vendor ID, device ID, ....)?
Thanks!

   Fred
