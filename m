Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 80033DE046
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Aug 2008 01:04:48 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] usb: add Freescale QE/CPM USB peripheral controller driver
Date: Thu, 28 Aug 2008 17:04:20 +0200
References: <1219916613-28827-1-git-send-email-leoli@freescale.com>
In-Reply-To: <1219916613-28827-1-git-send-email-leoli@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808281704.20999.arnd@arndb.de>
Cc: greg@kroah.com, Li Yang <leoli@freescale.com>, linux-usb@vger.kernel.org,
	dbrownell@users.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 28 August 2008, Li Yang wrote:
> Some of Freescale SoC chips have a QE or CPM co-processor which
> supports full speed USB.  The driver adds device mode support
> of both QE and CPM USB controller to Linux USB gadget.  The
> driver is tested with MPC8360 and MPC8272, and should work with
> other models having QE/CPM given minor tweaks.

Looks pretty good, just a few comments on the driver:
  
> +config USB_GADGET_FSL_QE
> +	boolean "Freescale QE/CPM USB Device Controller"
> +	depends on FSL_SOC && (QUICC_ENGINE || CPM)
> +	help
> +	   Some of Freescale PowerPC processors have a Full Speed
> +	   QE/CPM2 USB controller, which support device mode with 4
> +	   programmable endpoints. This driver supports the
> +	   controller in the MPC8360 and MPC8272, and should work with
> +	   controllers having QE or CPM2, given minor tweaks.
> +
> +	   Say "y" to link the driver statically, or "m" to build a
> +	   dynamically linked module called "fsl_qe_udc" and force all
> +	   gadget drivers to also be dynamically linked.
> +
> +config USB_FSL_QE
> +	tristate
> +	depends on USB_GADGET_FSL_QE
> +	default USB_GADGET
> +	select USB_GADGET_SELECTED


Why do you need the two config options, not just one?

> +#ifdef CONFIG_CPM2
> +#include <asm/cpm.h>
> +
> +#define qe_muram_addr cpm_muram_addr
> +#define qe_muram_offset cpm_muram_offset
> +#define qe_muram_alloc cpm_muram_alloc
> +#define qe_muram_free cpm_muram_free
> +#endif
...
> +static int qe_ep_cmd_restarttx(struct qe_ep *ep)
> +{
> +	u8 ep_num;
> +#ifdef CONFIG_CPM2
> +	u32 command;
> +	u8 opcode;
> +
> +	ep_num = ep->epnum << CPM_USB_EP_SHIFT;
> +	command = CPM_USB_RESTART_TX | (u32)ep_num;
> +	opcode = CPM_USB_RESTART_TX_OPCODE;
> +	cpm_command(command, opcode);
> +#else
> +	ep_num = ep->epnum;
> +	qe_issue_cmd(QE_USB_RESTART_TX, QE_CR_SUBBLOCK_USB, ep_num, 0);
> +#endif
> +	return 0;
> +}

This part doesn't look good, you should try to avoid hardcoding
the specific type of chip (QE or CPM2) here. AFAICT, you can build
a multiplatform kernel that supports both QE and CPM2, but your code
here would be broken in that case if you try to run it on QE.

> +static void setup_received_handle(struct qe_udc *udc,
> +					struct usb_ctrlrequest *setup);
> +static int qe_ep_rxframe_handle(struct qe_ep *ep);
> +static void ep0_req_complete(struct qe_udc *udc, struct qe_req *req);

Better try to avoid static forward declarations by reordering your
functions in call order. That is the common coding style and makes
drivers easier to read when you're used to it.

> +
> +	tasklet_schedule(&udc->rx_tasklet);

Not a problem, but an observation: Most new code uses work queues instead
of tasklets these days, which gives you more predictable real time
latencies.
If you don't have a specific reason to prefer a tasklet, just use
a workqueue here.

> +/*-------------------------------------------------------------------------
> +	Gadget driver register and unregister.
> + --------------------------------------------------------------------------*/
> +int usb_gadget_register_driver(struct usb_gadget_driver *driver)
> +EXPORT_SYMBOL(usb_gadget_register_driver);
> +
> +int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
> +EXPORT_SYMBOL(usb_gadget_unregister_driver);

Not addressing this driver in particular, but the USB gadget layer in
general: This is a horrible interface, since every gadget driver exports
the same symbols, you can never build a kernel that includes more than
one gadget driver. Even if the drivers are all built as modules, simply
loading one of them prevents loading another one.

> +	udc->dev = &ofdev->dev;
> +
> +	/* use the default address for the usb parameter */
> +	prop = of_get_property(np, "reg", &nsize);
> +	offset = of_read_number(prop + 2, 1);
> +	size = of_read_number(prop + 3, 1);

You should not assume a specific layout of the reg property but
rather use the simpler of_iomap function to get the registers,
independent of the bus mapping.

> +/*-------------------------------------------------------------------------*/
> +static struct of_device_id qe_udc_match[] = {
> +	{
> +		.compatible = "fsl,mpc8360-qe-usb",
> +	},
> +	{
> +		.compatible = "fsl,mpc8272-cpm-usb",
> +	},
> +	{},
> +};

Since they are evidently different implementations, you should
fill out the data field in the device id as the easiest way
to identify the two (and possible future) versions of the hardware.

> +#ifdef DEBUG
> +#define VDBG(fmt, args...)	printk(KERN_DEBUG "[%s]  " fmt "\n", \
> +				__func__, ## args)
> +#else
> +#define VDBG(fmt, args...)       do {} while (0)
> +#endif

please use the standard dev_debug and pr_debug macros instead of defining
your own.

	Arnd <><
