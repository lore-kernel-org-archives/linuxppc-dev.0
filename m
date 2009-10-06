Return-Path: <julie.zhu@xilinx.com>
Received: from SG2EHSOBE002.bigfish.com (sg2ehsobe002.messaging.microsoft.com
	[207.46.51.76]) by ozlabs.org (Postfix) with ESMTP id 790A1B7C9B
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Oct 2009 04:11:46 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: [PATCH] [V2] USB: Add support for Xilinx USB host controller
Date: Tue, 6 Oct 2009 11:07:32 -0600
In-Reply-To: <689CB232690D8D4E97DA6C76DA098E6C08A73362@XCO-EXCHVS1.xlnx.xilinx.com>
References: <689CB232690D8D4E97DA6C76DA098E6C08A73362@XCO-EXCHVS1.xlnx.xilinx.com>
From: Julie Zhu <julie.zhu@xilinx.com>
To: "John Linn" <linnj@xilinx.com>, <jwboyer@linux.vnet.ibm.com>,
	<greg@kroah.com>, <linuxppc-dev@ozlabs.org>, <linux-usb@vger.kernel.org>,
	<grant.likely@secretlab.ca>, <benh@kernel.crashing.org>
Message-ID: <24d11f7b-3f0d-4489-9eca-1d74c400504e@SG2EHSMHS006.ehs.local>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi, Greg K-H,

I think we have put in all the suggested changes. Are you planning to
put it into your tree? Or is there something we need to do?

Thank you,
Julie.
> > -----Original Message-----
> > From: Julie Zhu [mailto:julie.zhu@xilinx.com]
> > Sent: Monday, September 21, 2009 4:08 PM
> > To: John Linn; jwboyer@linux.vnet.ibm.com; greg@kroah.com; linuxppc-
> dev@ozlabs.org; linux-
> > usb@vger.kernel.org; grant.likely@secretlab.ca;
benh@kernel.crashing.org
> > Cc: Julie Zhu
> > Subject: [PATCH] [V2] USB: Add support for Xilinx USB host
controller
> >
> > Add bus glue driver for Xilinx USB host controller. The controller
can
> be
> > configured as HS only or HS/FS hybrid. The driver uses the device
tree
> file
> > to configure the driver according to the setting in the hardware
system.
> >
> > This driver has been tested with usbtest using the NET2280 PCI card.
> >
> > Signed-off-by: Julie Zhu <julie.zhu@xilinx.com>
> > Signed-off-by: John Linn <john.linn@xilinx.com>
> > Acked-by: Grant Likely <grant.likely@secretlab.ca>
> >
> > ---
> >
> > V1 - Updated per comments from Benjamin Herrenschmidt
> >      <benh@kernel.crashing.org> and Grant Likely
> <grant.likely@secretlab.ca>
> > V2 - Updated per comments from Benjamin Herrenschmidt and Grant
Likely:
> >      removed repetitive compatible lists, and removed
> irq_dispose_mapping call
> >      upon failure.
> > ---
> >  Documentation/powerpc/dts-bindings/xilinx.txt |   11 +
> >  drivers/usb/host/Kconfig                      |   15 +-
> >  drivers/usb/host/ehci-hcd.c                   |    5 +
> >  drivers/usb/host/ehci-xilinx-of.c             |  300
> +++++++++++++++++++++++++
> >  4 files changed, 329 insertions(+), 2 deletions(-)
> >  create mode 100644 drivers/usb/host/ehci-xilinx-of.c
> >
> > diff --git a/Documentation/powerpc/dts-bindings/xilinx.txt
> b/Documentation/powerpc/dts-
> > bindings/xilinx.txt
> > index 80339fe..ea68046 100644
> > --- a/Documentation/powerpc/dts-bindings/xilinx.txt
> > +++ b/Documentation/powerpc/dts-bindings/xilinx.txt
> > @@ -292,4 +292,15 @@
> >         - reg-offset : A value of 3 is required
> >         - reg-shift : A value of 2 is required
> >
> > +      vii) Xilinx USB Host controller
> > +
> > +      The Xilinx USB host controller is EHCI compatible but with a
> different
> > +      base address for the EHCI registers, and it is always a big-
> endian
> > +      USB Host controller. The hardware can be configured as high
speed
> only,
> > +      or high speed/full speed hybrid.
> > +
> > +      Required properties:
> > +      - xlnx,support-usb-fs: A value 0 means the core is built as
high
> speed
> > +                             only. A value 1 means the core also
> supports
> > +                             full speed devices.
> >
> > diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> > index 1a920c7..95e4689 100644
> > --- a/drivers/usb/host/Kconfig
> > +++ b/drivers/usb/host/Kconfig
> > @@ -90,14 +90,25 @@ config USB_EHCI_TT_NEWSCHED
> >
> >  config USB_EHCI_BIG_ENDIAN_MMIO
> >  	bool
> > -	depends on USB_EHCI_HCD && (PPC_CELLEB || PPC_PS3 || 440EPX ||
> ARCH_IXP4XX)
> > +	depends on USB_EHCI_HCD && (PPC_CELLEB || PPC_PS3 || 440EPX ||
> ARCH_IXP4XX ||
> > XPS_USB_HCD_XILINX)
> >  	default y
> >
> >  config USB_EHCI_BIG_ENDIAN_DESC
> >  	bool
> > -	depends on USB_EHCI_HCD && (440EPX || ARCH_IXP4XX)
> > +	depends on USB_EHCI_HCD && (440EPX || ARCH_IXP4XX ||
> XPS_USB_HCD_XILINX)
> >  	default y
> >
> > +config XPS_USB_HCD_XILINX
> > +	bool "Use Xilinx usb host EHCI controller core"
> > +	depends on USB_EHCI_HCD && (PPC32 || MICROBLAZE)
> > +	select USB_EHCI_BIG_ENDIAN_DESC
> > +	select USB_EHCI_BIG_ENDIAN_MMIO
> > +	---help---
> > +		Xilinx xps USB host controller core is EHCI compilant
and has
> > +		transaction translator built-in. It can be configured to
> either
> > +		support both high speed and full speed devices, or high
speed
> > +		devices only.
> > +
> >  config USB_EHCI_FSL
> >  	bool "Support for Freescale on-chip EHCI USB controller"
> >  	depends on USB_EHCI_HCD && FSL_SOC
> > diff --git a/drivers/usb/host/ehci-hcd.c
b/drivers/usb/host/ehci-hcd.c
> > index 11c627c..7672624 100644
> > --- a/drivers/usb/host/ehci-hcd.c
> > +++ b/drivers/usb/host/ehci-hcd.c
> > @@ -1107,6 +1107,11 @@ MODULE_LICENSE ("GPL");
> >  #define OF_PLATFORM_DRIVER	ehci_hcd_ppc_of_driver
> >  #endif
> >
> > +#ifdef CONFIG_XPS_USB_HCD_XILINX
> > +#include "ehci-xilinx-of.c"
> > +#define OF_PLATFORM_DRIVER	ehci_hcd_xilinx_of_driver
> > +#endif
> > +
> >  #ifdef CONFIG_PLAT_ORION
> >  #include "ehci-orion.c"
> >  #define	PLATFORM_DRIVER		ehci_orion_driver
> > diff --git a/drivers/usb/host/ehci-xilinx-of.c
b/drivers/usb/host/ehci-
> xilinx-of.c
> > new file mode 100644
> > index 0000000..a586153
> > --- /dev/null
> > +++ b/drivers/usb/host/ehci-xilinx-of.c
> > @@ -0,0 +1,300 @@
> > +/*
> > + * EHCI HCD (Host Controller Driver) for USB.
> > + *
> > + * Bus Glue for Xilinx EHCI core on the of_platform bus
> > + *
> > + * Copyright (c) 2009 Xilinx, Inc.
> > + *
> > + * Based on "ehci-ppc-of.c" by Valentine Barshak
> <vbarshak@ru.mvista.com>
> > + * and "ehci-ppc-soc.c" by Stefan Roese <sr@denx.de>
> > + * and "ohci-ppc-of.c" by Sylvain Munaut <tnt@246tNt.com>
> > + *
> > + * This program is free software; you can redistribute it and/or
modify
> it
> > + * under the terms of the GNU General Public License as published
by
> the
> > + * Free Software Foundation; either version 2 of the License, or
(at
> your
> > + * option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
but
> > + * WITHOUT ANY WARRANTY; without even the implied warranty of
> MERCHANTABILITY
> > + * or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
> License
> > + * for more details.
> > + *
> > + * You should have received a copy of the GNU General Public
License
> > + * along with this program; if not, write to the Free Software
> Foundation,
> > + * Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> > + *
> > + */
> > +
> > +#include <linux/signal.h>
> > +
> > +#include <linux/of.h>
> > +#include <linux/of_platform.h>
> > +
> > +/**
> > + * ehci_xilinx_of_setup - Initialize the device for ehci_reset()
> > + * @hcd:	Pointer to the usb_hcd device to which the host
controller
> bound
> > + *
> > + * called during probe() after chip reset completes.
> > + */
> > +static int ehci_xilinx_of_setup(struct usb_hcd *hcd)
> > +{
> > +	struct ehci_hcd	*ehci =3D hcd_to_ehci(hcd);
> > +	int		retval;
> > +
> > +	retval =3D ehci_halt(ehci);
> > +	if (retval)
> > +		return retval;
> > +
> > +	retval =3D ehci_init(hcd);
> > +	if (retval)
> > +		return retval;
> > +
> > +	ehci->sbrn =3D 0x20;
> > +
> > +	return ehci_reset(ehci);
> > +}
> > +
> > +/**
> > + * ehci_xilinx_port_handed_over - hand the port out if failed to
enable
> it
> > + * @hcd:	Pointer to the usb_hcd device to which the host
controller
> bound
> > + * @portnum:Port number to which the device is attached.
> > + *
> > + * This function is used as a place to tell the user that the
Xilinx
> USB host
> > + * controller does support LS devices. And in an HS only
configuration,
> it
> > + * does not support FS devices either. It is hoped that this can
help a
> > + * confused user.
> > + *
> > + * There are cases when the host controller fails to enable the
port
> due to,
> > + * for example, insufficient power that can be supplied to the
device
> from
> > + * the USB bus. In those cases, the messages printed here are not
> helpful.
> > + */
> > +static int ehci_xilinx_port_handed_over(struct usb_hcd *hcd, int
> portnum)
> > +{
> > +	dev_warn(hcd->self.controller, "port %d cannot be enabled\n",
> portnum);
> > +	if (hcd->has_tt) {
> > +		dev_warn(hcd->self.controller,
> > +			"Maybe you have connected a low speed
device?\n");
> > +
> > +		dev_warn(hcd->self.controller,
> > +			"We do not support low speed devices\n");
> > +	} else {
> > +		dev_warn(hcd->self.controller,
> > +			"Maybe your device is not a high speed
device?\n");
> > +		dev_warn(hcd->self.controller,
> > +			"The USB host controller does not support full
speed "
> > +			"nor low speed devices\n");
> > +		dev_warn(hcd->self.controller,
> > +			"You can reconfigure the host controller to have
"
> > +			"full speed support\n");
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +
> > +static const struct hc_driver ehci_xilinx_of_hc_driver =3D {
> > +	.description		=3D hcd_name,
> > +	.product_desc		=3D "OF EHCI",
> > +	.hcd_priv_size		=3D sizeof(struct ehci_hcd),
> > +
> > +	/*
> > +	 * generic hardware linkage
> > +	 */
> > +	.irq			=3D ehci_irq,
> > +	.flags			=3D HCD_MEMORY | HCD_USB2,
> > +
> > +	/*
> > +	 * basic lifecycle operations
> > +	 */
> > +	.reset			=3D ehci_xilinx_of_setup,
> > +	.start			=3D ehci_run,
> > +	.stop			=3D ehci_stop,
> > +	.shutdown		=3D ehci_shutdown,
> > +
> > +	/*
> > +	 * managing i/o requests and associated device resources
> > +	 */
> > +	.urb_enqueue		=3D ehci_urb_enqueue,
> > +	.urb_dequeue		=3D ehci_urb_dequeue,
> > +	.endpoint_disable	=3D ehci_endpoint_disable,
> > +
> > +	/*
> > +	 * scheduling support
> > +	 */
> > +	.get_frame_number	=3D ehci_get_frame,
> > +
> > +	/*
> > +	 * root hub support
> > +	 */
> > +	.hub_status_data	=3D ehci_hub_status_data,
> > +	.hub_control		=3D ehci_hub_control,
> > +#ifdef	CONFIG_PM
> > +	.bus_suspend		=3D ehci_bus_suspend,
> > +	.bus_resume		=3D ehci_bus_resume,
> > +#endif
> > +	.relinquish_port	=3D NULL,
> > +	.port_handed_over	=3D ehci_xilinx_port_handed_over,
> > +
> > +	.clear_tt_buffer_complete =3D ehci_clear_tt_buffer_complete,
> > +};
> > +
> > +/**
> > + * ehci_hcd_xilinx_of_probe - Probe method for the USB host
controller
> > + * @op:		pointer to the of_device to which the host
controller
> bound
> > + * @match:	pointer to of_device_id structure, not used
> > + *
> > + * This function requests resources and sets up appropriate
properties
> for the
> > + * host controller. Because the Xilinx USB host controller can be
> configured
> > + * as HS only or HS/FS only, it checks the configuration in the
device
> tree
> > + * entry, and sets an appropriate value for hcd->has_tt.
> > + */
> > +static int __devinit
> > +ehci_hcd_xilinx_of_probe(struct of_device *op, const struct
> of_device_id *match)
> > +{
> > +	struct device_node *dn =3D op->node;
> > +	struct usb_hcd *hcd;
> > +	struct ehci_hcd	*ehci;
> > +	struct resource res;
> > +	int irq;
> > +	int rv;
> > +	int *value;
> > +
> > +	if (usb_disabled())
> > +		return -ENODEV;
> > +
> > +	dev_dbg(&op->dev, "initializing XILINX-OF USB Controller\n");
> > +
> > +	rv =3D of_address_to_resource(dn, 0, &res);
> > +	if (rv)
> > +		return rv;
> > +
> > +	hcd =3D usb_create_hcd(&ehci_xilinx_of_hc_driver, &op->dev,
> > +				"XILINX-OF USB");
> > +	if (!hcd)
> > +		return -ENOMEM;
> > +
> > +	hcd->rsrc_start =3D res.start;
> > +	hcd->rsrc_len =3D res.end - res.start + 1;
> > +
> > +	if (!request_mem_region(hcd->rsrc_start, hcd->rsrc_len,
hcd_name)) {
> > +		printk(KERN_ERR __FILE__ ": request_mem_region
failed\n");
> > +		rv =3D -EBUSY;
> > +		goto err_rmr;
> > +	}
> > +
> > +	irq =3D irq_of_parse_and_map(dn, 0);
> > +	if (irq =3D=3D NO_IRQ) {
> > +		printk(KERN_ERR __FILE__ ": irq_of_parse_and_map
failed\n");
> > +		rv =3D -EBUSY;
> > +		goto err_irq;
> > +	}
> > +
> > +	hcd->regs =3D ioremap(hcd->rsrc_start, hcd->rsrc_len);
> > +	if (!hcd->regs) {
> > +		printk(KERN_ERR __FILE__ ": ioremap failed\n");
> > +		rv =3D -ENOMEM;
> > +		goto err_ioremap;
> > +	}
> > +
> > +	ehci =3D hcd_to_ehci(hcd);
> > +
> > +	/* This core always has big-endian register interface and uses
> > +	 * big-endian memory descriptors.
> > +	 */
> > +	ehci->big_endian_mmio =3D 1;
> > +	ehci->big_endian_desc =3D 1;
> > +
> > +	/* Check whether the FS support option is selected in the
hardware.
> > +	 */
> > +	value =3D (int *)of_get_property(dn, "xlnx,support-usb-fs", NULL);
> > +	if (value && (*value =3D=3D 1)) {
> > +		ehci_dbg(ehci, "USB host controller supports FS
devices\n");
> > +		hcd->has_tt =3D 1;
> > +	} else {
> > +		ehci_dbg(ehci,
> > +			"USB host controller is HS only\n");
> > +		hcd->has_tt =3D 0;
> > +	}
> > +
> > +	/* Debug registers are at the first 0x100 region
> > +	 */
> > +	ehci->caps =3D hcd->regs + 0x100;
> > +	ehci->regs =3D hcd->regs + 0x100 +
> > +			HC_LENGTH(ehci_readl(ehci,
&ehci->caps->hc_capbase));
> > +
> > +	/* cache this readonly data; minimize chip reads */
> > +	ehci->hcs_params =3D ehci_readl(ehci, &ehci->caps->hcs_params);
> > +
> > +	rv =3D usb_add_hcd(hcd, irq, 0);
> > +	if (rv =3D=3D 0)
> > +		return 0;
> > +
> > +	iounmap(hcd->regs);
> > +
> > +err_ioremap:
> > +err_irq:
> > +	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
> > +err_rmr:
> > +	usb_put_hcd(hcd);
> > +
> > +	return rv;
> > +}
> > +
> > +/**
> > + * ehci_hcd_xilinx_of_remove - shutdown hcd and release resources
> > + * @op:		pointer to of_device structure that is to be
removed
> > + *
> > + * Remove the hcd structure, and release resources that has been
> requested
> > + * during probe.
> > + */
> > +static int ehci_hcd_xilinx_of_remove(struct of_device *op)
> > +{
> > +	struct usb_hcd *hcd =3D dev_get_drvdata(&op->dev);
> > +	dev_set_drvdata(&op->dev, NULL);
> > +
> > +	dev_dbg(&op->dev, "stopping XILINX-OF USB Controller\n");
> > +
> > +	usb_remove_hcd(hcd);
> > +
> > +	iounmap(hcd->regs);
> > +	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
> > +
> > +	usb_put_hcd(hcd);
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * ehci_hcd_xilinx_of_shutdown - shutdown the hcd
> > + * @op:		pointer to of_device structure that is to be
removed
> > + *
> > + * Properly shutdown the hcd, call driver's shutdown routine.
> > + */
> > +static int ehci_hcd_xilinx_of_shutdown(struct of_device *op)
> > +{
> > +	struct usb_hcd *hcd =3D dev_get_drvdata(&op->dev);
> > +
> > +	if (hcd->driver->shutdown)
> > +		hcd->driver->shutdown(hcd);
> > +
> > +	return 0;
> > +}
> > +
> > +
> > +static struct of_device_id ehci_hcd_xilinx_of_match[] =3D {
> > +		{.compatible =3D "xlnx,xps-usb-host-1.00.a",},
> > +	{},
> > +};
> > +MODULE_DEVICE_TABLE(of, ehci_hcd_xilinx_of_match);
> > +
> > +static struct of_platform_driver ehci_hcd_xilinx_of_driver =3D {
> > +	.name		=3D "xilinx-of-ehci",
> > +	.match_table	=3D ehci_hcd_xilinx_of_match,
> > +	.probe		=3D ehci_hcd_xilinx_of_probe,
> > +	.remove		=3D ehci_hcd_xilinx_of_remove,
> > +	.shutdown	=3D ehci_hcd_xilinx_of_shutdown,
> > +	.driver		=3D {
> > +		.name	=3D "xilinx-of-ehci",
> > +		.owner	=3D THIS_MODULE,
> > +	},
> > +};
> > --
> > 1.5.6.6
> >


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
