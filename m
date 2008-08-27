Return-Path: <stern+48acf28e@rowland.harvard.edu>
Received: from iolanthe.rowland.org (iolanthe.rowland.org [192.131.102.54])
	by ozlabs.org (Postfix) with SMTP id 7E28EDDF3D
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Aug 2008 00:43:02 +1000 (EST)
Date: Wed, 27 Aug 2008 10:36:20 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: Re: [RFC][USB] powerpc: Workaround for the PPC440EPX USBH_23 errata
In-Reply-To: <20080827022351.67e8a9b2@vitb-lp>
Message-ID: <Pine.LNX.4.44L0.0808271024420.2498-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Stefan Roese <sr@denx.de>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	linux-usb@vger.kernel.org, Mark Miesfeld <mmiesfeld@amcc.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 27 Aug 2008, Vitaly Bordug wrote:

> A published errata for ppc440epx states, that when running Linux with both
> EHCI and OHCI modules loaded, the EHCI module experiences a fatal error 
> when a high-speed device is connected to the USB2.0, and functions normally
> if OHCI module is not loaded. 
> 
> Quote from original descriprion:
> 
> The 440EPx USB 2.0 Host controller is an EHCI compliant controller.  In USB
> 2.0 Host controllers, each EHCI controller has one or more companion
> controllers, which may be OHCI or UHCI.  An USB 2.0 Host controller will
> contain one or more ports.  For each port, only one of the controllers is
> connected at any one time. In the 440EPx, there is only one OHCI companion controller, 
> and only one USB 2.0 Host port.
> All ports on an USB 2.0 controller default to the companion controller.  If
> you load only an ohci driver, it will have control of the ports and any
> deviceplugged in will operate, although high speed devices will be forced to
> operate at full speed.  When an ehci driver is loaded, it explicitly takes control
> of the ports.  If there is a device connected, and / or every time there is a
> new device connected, the ehci driver determines if the device is high speed or
> not.  If it is high speed, the driver retains control of the port.  If it
> is not, the driver explicitly gives the companion controller control of the
> port.

This doesn't explain why the fatal error occurs.

> The is a software workaround that uses 
> Initial version of the software workaround was posted to linux-usb-devel:
> 
> http://www.mail-archive.com/linux-usb-devel@lists.sourceforge.net/msg54019.html
> 
> and later available from amcc.com:
> http://www.amcc.com/Embedded/Downloads/download.html?cat=1&family=15&ins=2
> 
> The patch below is generally based on the latter, but reworked to
> powerpc/of_device USB drivers, and uses a few devicetree inquiries to get
> rid of all the hardcoded defines and CONFIG_* stuff, in favor to
> defining specific quirk. The latter required to add more accurate
> description into compatible field of USB node for 'sequioia' board. 

I have some doubts about parts of this patch.

> --- a/drivers/usb/host/ehci-ppc-of.c
> +++ b/drivers/usb/host/ehci-ppc-of.c
> @@ -107,16 +107,17 @@ ehci_hcd_ppc_of_probe(struct of_device *op, const struct of_device_id *match)
>  {
>  	struct device_node *dn = op->node;
>  	struct usb_hcd *hcd;
> -	struct ehci_hcd	*ehci;
> +	struct ehci_hcd	*ehci = NULL;
>  	struct resource res;
>  	int irq;
>  	int rv;
>  
> +	struct device_node *np;
> +
>  	if (usb_disabled())
>  		return -ENODEV;
>  
>  	dev_dbg(&op->dev, "initializing PPC-OF USB Controller\n");
> -
>  	rv = of_address_to_resource(dn, 0, &res);
>  	if (rv)
>  		return rv;
> @@ -125,6 +126,7 @@ ehci_hcd_ppc_of_probe(struct of_device *op, const struct of_device_id *match)
>  	if (!hcd)
>  		return -ENOMEM;
>  
> +

Is there any reason for these apparently gratuitous whitespace changes?

>  	hcd->rsrc_start = res.start;
>  	hcd->rsrc_len = res.end - res.start + 1;
>  
> @@ -172,6 +174,21 @@ ehci_hcd_ppc_of_probe(struct of_device *op, const struct of_device_id *match)
>  				rv ? "NOT ": "");
>  	}
>  
> +	np = of_find_compatible_node(NULL, NULL, "ibm,usb-ohci-440epx");
> +	if (np != NULL) {
> +	/* claim we really affected by usb23 erratum */
> +		ehci->has_amcc_usb23 = 1;
> +		if (!of_address_to_resource(np, 0, &res))
> +			ehci->ohci_hcctrl_reg = ioremap(res.start +
> +					OHCI_HCCTRL_OFFSET, OHCI_HCCTRL_LEN);
> +		else
> +			pr_debug(__FILE__ ": no ohci offset in fdt\n");
> +		if (!ehci->ohci_hcctrl_reg) {
> +			pr_debug(__FILE__ ": ioremap for ohci hcctrl failed\n");
> +			return -ENOMEM;

This is a memory leak.

> --- a/drivers/usb/host/ehci.h
> +++ b/drivers/usb/host/ehci.h
> @@ -809,6 +819,20 @@ static inline u32 hc32_to_cpup (const struct ehci_hcd *ehci, const __hc32 *x)
>  		le32_to_cpup((__force __le32 *)x);
>  }
>  
> +static inline void set_ohci_hcfs(struct ehci_hcd *ehci, int operational)
> +{
> +	u32 hc_control;
> +
> +	hc_control = (readl_be(ehci->ohci_hcctrl_reg) & ~OHCI_CTRL_HCFS);
> +	if (operational)
> +		hc_control |= OHCI_USB_OPER;
> +	else
> +		hc_control |= OHCI_USB_SUSPEND;
> +
> +	writel_be(hc_control, ehci->ohci_hcctrl_reg);
> +	(void) readl_be(ehci->ohci_hcctrl_reg);
> +}
> +

This should be protected by a preprocessor test so that the code 
doesn't get compiled on architectures that don't need it.

> --- a/drivers/usb/host/ohci-ppc-of.c
> +++ b/drivers/usb/host/ohci-ppc-of.c
> @@ -148,6 +148,31 @@ ohci_hcd_ppc_of_probe(struct of_device *op, const struct of_device_id *match)
>  	if (rv == 0)
>  		return 0;
>  
> +	/* by now, 440epx is known to show usb_23 erratum */
> +	np = of_find_compatible_node(NULL, NULL, "ibm,usb-ehci-440epx");
> +
> +	/* Work around - At this point ohci_run has executed, the
> +	* controller is running, everything, the root ports, etc., is
> +	* set up.  If the ehci driver is loaded, put the ohci core in
> +	* the suspended state.  The ehci driver will bring it out of
> +	* suspended state when / if a non-high speed USB device is
> +	* attached to the USB Host port.  If the ehci driver is not
> +	* loaded, do nothing. request_mem_region is used to test if
> +	* the ehci driver is loaded.
> +	*/
> +	if (np !=  NULL) {
> +		ohci->flags |= OHCI_QUIRK_AMCC_USB23;
> +		if (!of_address_to_resource(np, 0, &res))
> +			if (!request_mem_region(res.start, 0x4, hcd_name)) {
> +				writel_be((readl_be(&ohci->regs->control) |
> +				    OHCI_USB_SUSPEND), &ohci->regs->control);
> +				    (void) readl_be(&ohci->regs->control);

Wrong indentation level.

> +			} else  {
> +				release_mem_region(res.start, 0x4);
> +			}
> +		else
> +		    pr_debug(__FILE__ ": cannot get ehci offset from fdt\n");

Wrong indentation amount.

> +	}
>  	iounmap(hcd->regs);
>  err_ioremap:
>  	irq_dispose_mapping(irq);

I doubt this will interact properly with usbcore and the rest of
ohci-hcd.  They do not expect the root hub to be suspended unless they
know about it.

Alan Stern
