Return-Path: <balbi@ti.com>
Received: from na3sys009aog110.obsmtp.com (na3sys009aog110.obsmtp.com
	[74.125.149.203])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B460CB6F9C
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  4 Apr 2011 22:26:34 +1000 (EST)
Received: by mail-ew0-f43.google.com with SMTP id 20so2831447ewy.30
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 04 Apr 2011 05:26:30 -0700 (PDT)
Date: Mon, 4 Apr 2011 15:19:52 +0300
From: Felipe Balbi <balbi@ti.com>
To: tmarri@apm.com
Subject: Re: [PATCH v13 02/10] USB/ppc4xx: Add Synopsys DWC OTG driver
	framework
Message-ID: <20110404121951.GL2461@legolas.emea.dhcp.ti.com>
References: <1301872610-2785-1-git-send-email-tmarri@apm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1301872610-2785-1-git-send-email-tmarri@apm.com>
Cc: Mark Miesfeld <mmiesfeld@apm.com>, greg@kroah.com,
	linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Fushen Chen <fchen@apm.com>
Reply-To: balbi@ti.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Apr 03, 2011 at 04:16:50PM -0700, tmarri@apm.com wrote:
> From: Tirumala Marri <tmarri@apm.com>
> 
> Platform probing is in dwc_otg_apmppc.c.
> Driver parameter and parameter checking are in dwc_otg_param.c.
> 
> Signed-off-by: Tirumala R Marri <tmarri@apm.com>
> Signed-off-by: Fushen Chen <fchen@apm.com>
> Signed-off-by: Mark Miesfeld <mmiesfeld@apm.com>
> ---
>  drivers/usb/dwc/apmppc.c |  414 ++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/usb/dwc/driver.h |   76 +++++++++
>  drivers/usb/dwc/param.c  |  180 ++++++++++++++++++++
>  3 files changed, 670 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/usb/dwc/apmppc.c
>  create mode 100644 drivers/usb/dwc/driver.h
>  create mode 100644 drivers/usb/dwc/param.c
> 
> diff --git a/drivers/usb/dwc/apmppc.c b/drivers/usb/dwc/apmppc.c
> new file mode 100644
> index 0000000..ffbe6dd
> --- /dev/null
> +++ b/drivers/usb/dwc/apmppc.c
> @@ -0,0 +1,414 @@
> +/*
> + * DesignWare HS OTG controller driver
> + * Copyright (C) 2006 Synopsys, Inc.
> + * Portions Copyright (C) 2010 Applied Micro Circuits Corporation.
> + *
> + * This program is free software: you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License version 2 for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see http://www.gnu.org/licenses
> + * or write to the Free Software Foundation, Inc., 51 Franklin Street,
> + * Suite 500, Boston, MA 02110-1335 USA.
> + *
> + * Based on Synopsys driver version 2.60a
> + * Modified by Mark Miesfeld <mmiesfeld@apm.com>
> + * Modified by Stefan Roese <sr@denx.de>, DENX Software Engineering
> + *
> + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
> + * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING BUT NOT LIMITED TO THE
> + * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
> + * ARE DISCLAIMED. IN NO EVENT SHALL SYNOPSYS, INC. BE LIABLE FOR ANY DIRECT,
> + * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY OR CONSEQUENTIAL DAMAGES
> + * (INCLUDING BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
> + * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
> + * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY OR TORT
> + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
> + * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + *
> + */
> +
> +/*
> + * The dwc_otg module provides the initialization and cleanup entry
> + * points for the dwcotg driver. This module will be dynamically installed
> + * after Linux is booted using the insmod command. When the module is
> + * installed, the dwc_otg_driver_init function is called. When the module is
> + * removed (using rmmod), the dwc_otg_driver_cleanup function is called.
> + *
> + * This module also defines a data structure for the dwc_otg driver, which is
> + * used in conjunction with the standard device structure. These
> + * structures allow the OTG driver to comply with the standard Linux driver
> + * model in which devices and drivers are registered with a bus driver. This
> + * has the benefit that Linux can expose attributes of the driver and device
> + * in its special sysfs file system. Users can then read or write files in
> + * this file system to perform diagnostics on the driver components or the
> + * device.
> + */
> +
> +#include <linux/of_platform.h>
> +
> +#include "driver.h"
> +
> +#define DWC_DRIVER_VERSION		"1.05"
> +#define DWC_DRIVER_DESC			"HS OTG USB Controller driver"
> +static const char dwc_driver_name[] = "dwc_otg";
> +
> +/**
> + * This function is the top level interrupt handler for the Common
> + * (Device and host modes) interrupts.
> + */
> +static irqreturn_t dwc_otg_common_irq(int _irq, void *dev)
> +{
> +	struct dwc_otg_device *dwc_dev = dev;
> +	int retval;
> +
> +	retval = dwc_otg_handle_common_intr(dwc_dev->core_if);

no lock needed ? What if you get another IRQ while you're calling
dwc_otg_handle_common_intr() ??

> +	return IRQ_RETVAL(retval);
> +}
> +
> +/**
> + * This function is the interrupt handler for the OverCurrent condition
> + * from the external charge pump (if enabled)
> + */

this comment is completely unnecessary. Same goes for most all other
functions. The ones which would be nice to keep, should be converted to
kerneldoc so we can extract documentation from source code if we
need/want.

> +static irqreturn_t dwc_otg_externalchgpump_irq(int _irq, void *dev)
> +{
> +	struct dwc_otg_device *dwc_dev = dev;
> +
> +	if (dwc_otg_is_host_mode(dwc_dev->core_if)) {
> +		struct dwc_hcd *dwc_hcd;
> +		u32 hprt0 = 0;
> +
> +		dwc_hcd = dwc_dev->hcd;
> +		spin_lock(&dwc_hcd->lock);
> +		dwc_hcd->flags.b.port_over_current_change = 1;
> +
> +		hprt0 = DWC_HPRT0_PRT_PWR_RW(hprt0, 0);
> +		dwc_write32(dwc_dev->core_if->host_if->hprt0, hprt0);
> +		spin_unlock(&dwc_hcd->lock);
> +	} else {
> +		/* Device mode - This int is n/a for device mode */
> +		dev_dbg(dev, "DeviceMode: OTG OverCurrent Detected\n");
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/**
> + * This function is called when a device is unregistered with the
> + * dwc_otg_driver. This happens, for example, when the rmmod command is
> + * executed. The device may or may not be electrically present. If it is
> + * present, the driver stops device processing. Any resources used on behalf
> + * of this device are freed.
> + */
> +static int __devexit dwc_otg_driver_remove(struct platform_device *ofdev)
> +{
> +	struct device *dev = &ofdev->dev;
> +	struct dwc_otg_device *dwc_dev = dev_get_drvdata(dev);
> +
> +	/* Memory allocation for dwc_otg_device may have failed. */
> +	if (!dwc_dev)
> +		return 0;

this should never happen. Remove this check. If memory allocation
failed, you didn't probe() anyway.

> +	/* Free the IRQ */
> +	if (dwc_dev->common_irq_installed)
> +		free_irq(dwc_dev->irq, dwc_dev);

you know you allocate the IRQ on probe()

> +	if (!dwc_has_feature(dwc_dev->core_if, DWC_DEVICE_ONLY)) {
> +		if (dwc_dev->hcd) {
> +			if (dwc_dev->hcd->cp_irq_installed)
> +				free_irq(dwc_dev->hcd->cp_irq, dwc_dev);
> +			dwc_otg_hcd_remove(dev);
> +		}
> +	}

the feature check could probably be dropped. I'm sure you only
initialize hcd to something other than NULL if DWC_DEVICE_ONLY is false.
Also, you know that IRQ will be requested, so drop the cp_irq_installed
flag and check.

> +	if (!dwc_has_feature(dwc_dev->core_if, DWC_HOST_ONLY)) {
> +		if (dwc_dev->pcd)
> +			dwc_otg_pcd_remove(dev);
> +	}

same here.

> +	if (dwc_dev->core_if)
> +		dwc_otg_cil_remove(dwc_dev->core_if);
> +
> +	/* Return the memory. */
> +	if (dwc_dev->base)
> +		iounmap(dwc_dev->base);

this should be valid pointer otherwise your driver doesn't work, right ?
Drop the check and ensure base is valid.

> +	if (dwc_dev->phys_addr)
> +		release_mem_region(dwc_dev->phys_addr, dwc_dev->base_len);

same here.

> +	if (dwc_dev->core_if->xceiv) {
> +		otg_put_transceiver(dwc_dev->core_if->xceiv);
> +		dwc_dev->core_if->xceiv = NULL;
> +		usb_nop_xceiv_unregister();
> +	}
> +
> +	kfree(dwc_dev);
> +
> +	/* Clear the drvdata pointer. */
> +	dev_set_drvdata(dev, NULL);
> +	return 0;
> +}
> +
> +/**
> + * This function is called when an device is bound to a
> + * dwc_otg_driver. It creates the driver components required to
> + * control the device (CIL, HCD, and PCD) and it initializes the
> + * device. The driver components are stored in a dwc_otg_device
> + * structure. A reference to the dwc_otg_device is saved in the
> + * device. This allows the driver to access the dwc_otg_device
> + * structure on subsequent calls to driver methods for this device.
> + */
> +static int __devinit dwc_otg_driver_probe(struct platform_device *ofdev)
> +{
> +	int retval;
> +	struct dwc_otg_device *dwc_dev;
> +	struct device *dev = &ofdev->dev;
> +	struct resource res;
> +	ulong gusbcfg_addr;
> +	u32 usbcfg = 0;
> +
> +	dev_dbg(dev, "dwc_otg_driver_probe(%p)\n", dev);

not needed. Either dropo or move to dev_vdbg().

> +	dwc_dev = kzalloc(sizeof(*dwc_dev), GFP_KERNEL);
> +	if (!dwc_dev) {
> +		dev_err(dev, "kmalloc of dwc_otg_device failed\n");
> +		retval = -ENOMEM;
> +		goto fail_dwc_dev;
> +	}
> +
> +	/* Retrieve the memory and IRQ resources. */
> +	dwc_dev->irq = irq_of_parse_and_map(ofdev->dev.of_node, 0);
> +	if (dwc_dev->irq == NO_IRQ) {
> +		dev_err(dev, "no device irq\n");
> +		retval = -ENODEV;
> +		goto fail_of_irq;
> +	}
> +	dev_dbg(dev, "OTG - device irq: %d\n", dwc_dev->irq);

unneeded print.

> +	if (of_address_to_resource(ofdev->dev.of_node, 0, &res)) {
> +		dev_err(dev, "%s: Can't get USB-OTG register address\n",
> +			__func__);
> +		retval = -ENOMEM;
> +		goto fail_of_irq;
> +	}
> +	dev_dbg(dev, "OTG - ioresource_mem start0x%llx: end:0x%llx\n",
> +		(unsigned long long)res.start, (unsigned long long)res.end);

unneeded print.

> +	dwc_dev->phys_addr = res.start;
> +	dwc_dev->base_len = res.end - res.start + 1;
> +	if (!request_mem_region(dwc_dev->phys_addr,
> +				dwc_dev->base_len, dwc_driver_name)) {
> +		dev_err(dev, "request_mem_region failed\n");
> +		retval = -EBUSY;
> +		goto fail_of_irq;
> +	}
> +
> +	/* Map the DWC_otg Core memory into virtual address space. */
> +	dwc_dev->base = ioremap(dwc_dev->phys_addr, dwc_dev->base_len);
> +	if (!dwc_dev->base) {
> +		dev_err(dev, "ioremap() failed\n");
> +		retval = -ENOMEM;
> +		goto fail_ioremap;
> +	}
> +	dev_dbg(dev, "mapped base=0x%08x\n", (__force u32)dwc_dev->base);

unneeded print.

> +	/*
> +	 * Initialize driver data to point to the global DWC_otg
> +	 * Device structure.
> +	 */
> +	dev_set_drvdata(dev, dwc_dev);
> +
> +	dwc_dev->core_if =
> +	    dwc_otg_cil_init(dwc_dev->base, &dwc_otg_module_params);
> +	if (!dwc_dev->core_if) {
> +		dev_err(dev, "CIL initialization failed!\n");
> +		retval = -ENOMEM;
> +		goto fail_cil_init;
> +	}
> +
> +	/*
> +	 * Validate parameter values after dwc_otg_cil_init.
> +	 */
> +	if (check_parameters(dwc_dev->core_if)) {
> +		retval = -EINVAL;
> +		goto fail_check_param;
> +	}
> +
> +	usb_nop_xceiv_register();

not here. Other boards might use a different transceiver, and you simply
can't couple this driver to the nop xceiv.

> +	dwc_dev->core_if->xceiv = otg_get_transceiver();
> +	if (!dwc_dev->core_if->xceiv) {
> +		retval = -ENODEV;
> +		goto fail_xceiv;
> +	}
> +	dwc_set_feature(dwc_dev->core_if);
> +
> +	/* Initialize the DWC_otg core. */
> +	dwc_otg_core_init(dwc_dev->core_if);
> +
> +	/*
> +	 * Disable the global interrupt until all the interrupt
> +	 * handlers are installed.
> +	 */
> +	dwc_otg_disable_global_interrupts(dwc_dev->core_if);
> +
> +	/*
> +	 * Install the interrupt handler for the common interrupts before
> +	 * enabling common interrupts in core_init below.
> +	 */
> +	retval = request_irq(dwc_dev->irq, dwc_otg_common_irq,
> +			     IRQF_SHARED, "dwc_otg", dwc_dev);

do you always want shared ? What about other boards which don't want
shared ? How will they re-use this driver ?

> +	if (retval) {
> +		dev_err(dev, "request of irq%d failed retval: %d\n",
> +			dwc_dev->irq, retval);
> +		retval = -EBUSY;
> +		goto fail_req_irq;
> +	} else {
> +		dwc_dev->common_irq_installed = 1;

drop this flag.

> +	}
> +
> +	if (!dwc_has_feature(dwc_dev->core_if, DWC_HOST_ONLY)) {

I don't like the inversion of the features here. Why didn't you make:

if (dwc_has_feature(dwc_dev->core_if, DWC_FEATURE_DEVICE) {
	....

the way you did is always inverted.

> +		/* Initialize the PCD */
> +		retval = dwc_otg_pcd_init(dev);
> +		if (retval) {
> +			dev_err(dev, "dwc_otg_pcd_init failed\n");
> +			dwc_dev->pcd = NULL;
> +			goto fail_req_irq;
> +		}
> +	}
> +
> +	gusbcfg_addr = (ulong) (dwc_dev->core_if->core_global_regs)
> +		+ DWC_GUSBCFG;

why didn't you use void __iomem * ??

> +	if (!dwc_has_feature(dwc_dev->core_if, DWC_DEVICE_ONLY)) {
> +		/* Initialize the HCD and force_host_mode */
> +		usbcfg = dwc_read32(gusbcfg_addr);

the way this is generally handled is to pass two parameters to
dwc_read32(), the base and the offset...

> +		usbcfg |= DWC_USBCFG_FRC_HST_MODE;
> +		dwc_write32(gusbcfg_addr, usbcfg);

... and three parameters here: base, offset and value to write.

> +		retval = dwc_otg_hcd_init(dev, dwc_dev);
> +		if (retval) {
> +			dev_err(dev, "dwc_otg_hcd_init failed\n");
> +			dwc_dev->hcd = NULL;
> +			goto fail_hcd;
> +		}
> +		/* configure chargepump interrupt */
> +		dwc_dev->hcd->cp_irq = irq_of_parse_and_map(ofdev->dev.of_node,
> +							    3);
> +		if (dwc_dev->hcd->cp_irq) {
> +			retval = request_irq(dwc_dev->hcd->cp_irq,
> +					     dwc_otg_externalchgpump_irq,
> +					     IRQF_SHARED,
> +					     "dwc_otg_ext_chg_pump", dwc_dev);
> +			if (retval) {
> +				dev_err(dev,
> +					"request of irq failed retval: %d\n",
> +					retval);
> +				retval = -EBUSY;
> +				goto fail_hcd;
> +			} else {
> +				dev_dbg(dev, "%s: ExtChgPump Detection "
> +					"IRQ registered\n", dwc_driver_name);

unneded print.

> +				dwc_dev->hcd->cp_irq_installed = 1;

unneeded flag.

> +			}
> +		}
> +	}
> +	/*
> +	 * Enable the global interrupt after all the interrupt
> +	 * handlers are installed.
> +	 */
> +	dwc_otg_enable_global_interrupts(dwc_dev->core_if);
> +
> +	usbcfg = dwc_read32(gusbcfg_addr);
> +	usbcfg &= ~DWC_USBCFG_FRC_HST_MODE;
> +	dwc_write32(gusbcfg_addr, usbcfg);
> +
> +	return 0;
> +fail_hcd:
> +	free_irq(dwc_dev->irq, dwc_dev);
> +	if (!dwc_has_feature(dwc_dev->core_if, DWC_HOST_ONLY)) {
> +		if (dwc_dev->pcd)
> +			dwc_otg_pcd_remove(dev);
> +	}
> +fail_req_irq:
> +	otg_put_transceiver(dwc_dev->core_if->xceiv);
> +fail_xceiv:
> +	usb_nop_xceiv_unregister();
> +fail_check_param:
> +	dwc_otg_cil_remove(dwc_dev->core_if);
> +fail_cil_init:
> +	dev_set_drvdata(dev, NULL);
> +	iounmap(dwc_dev->base);
> +fail_ioremap:
> +	release_mem_region(dwc_dev->phys_addr, dwc_dev->base_len);
> +fail_of_irq:
> +	kfree(dwc_dev);
> +fail_dwc_dev:
> +	return retval;
> +}
> +
> +/*
> + * This structure defines the methods to be called by a bus driver
> + * during the lifecycle of a device on that bus. Both drivers and
> + * devices are registered with a bus driver. The bus driver matches
> + * devices to drivers based on information in the device and driver
> + * structures.
> + *
> + * The probe function is called when the bus driver matches a device
> + * to this driver. The remove function is called when a device is
> + * unregistered with the bus driver.
> + */

unneeded comment.

> +static const struct of_device_id dwc_otg_match[] = {
> +	{.compatible = "amcc,dwc-otg",},
> +	{}
> +};
> +
> +MODULE_DEVICE_TABLE(of, dwc_otg_match);
> +
> +static struct platform_driver dwc_otg_driver = {
> +	.probe = dwc_otg_driver_probe,
> +	.remove = __devexit_p(dwc_otg_driver_remove),
> +	.driver = {
> +		   .name = "dwc_otg",
> +		   .owner = THIS_MODULE,
> +		   .of_match_table = dwc_otg_match,
> +		   },

wrong indentation.

> +};
> +
> +/**
> + * This function is called when the dwc_otg_driver is installed with the
> + * insmod command. It registers the dwc_otg_driver structure with the
> + * appropriate bus driver. This will cause the dwc_otg_driver_probe function
> + * to be called. In addition, the bus driver will automatically expose
> + * attributes defined for the device and driver in the special sysfs file
> + * system.
> + */
> +static int __init dwc_otg_driver_init(void)
> +{
> +
> +	pr_info("%s: version %s\n", dwc_driver_name, DWC_DRIVER_VERSION);

drop this pr_info(), it just makes things noisier.

-- 
balbi
