Return-Path: <balbi@ti.com>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mailhost.ti.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 569C22C00A7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2012 21:33:24 +1100 (EST)
Date: Fri, 19 Oct 2012 13:27:26 +0300
From: Felipe Balbi <balbi@ti.com>
To: Christoph Fritz <chf.fritz@googlemail.com>
Subject: Re: [PATCH 3/7] usb: gadget: fsl_udc: convert to new ulc style
Message-ID: <20121019102726.GD11191@arwen.pp.htv.fi>
References: <1350642156-8034-1-git-send-email-chf.fritz@googlemail.com>
 <1350642285-8145-3-git-send-email-chf.fritz@googlemail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="F8dlzb82+Fcn6AgP"
In-Reply-To: <1350642285-8145-3-git-send-email-chf.fritz@googlemail.com>
Cc: Estevam Fabio-R49496 <r49496@freescale.com>,
 Li Yang-R58472 <r58472@freescale.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Chen Peter-B29397 <B29397@freescale.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, linux-usb@vger.kernel.org,
 Felipe Balbi <balbi@ti.com>, "Hans J. Koch" <hjk@hansjkoch.de>,
 Daniel Mack <daniel@caiaq.de>, Christian Hemp <c.hemp@phytec.de>,
 linuxppc-dev@lists.ozlabs.org, Teresa Gamez <T.Gamez@phytec.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reply-To: balbi@ti.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--F8dlzb82+Fcn6AgP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

typo on Subject. Should be udc, not ulc.

On Fri, Oct 19, 2012 at 12:24:41PM +0200, Christoph Fritz wrote:
> Convert to new UDC style registration and remove
> global 'udc_controller' pointer.
>=20
> Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
> ---
>  drivers/usb/gadget/fsl_udc_core.c |  289 +++++++++++++++++--------------=
------
>  1 files changed, 131 insertions(+), 158 deletions(-)
>=20
> diff --git a/drivers/usb/gadget/fsl_udc_core.c b/drivers/usb/gadget/fsl_u=
dc_core.c
> index 0a0d6a6..d113f39 100644
> --- a/drivers/usb/gadget/fsl_udc_core.c
> +++ b/drivers/usb/gadget/fsl_udc_core.c
> @@ -63,9 +63,6 @@ static struct usb_dr_device *dr_regs;
> =20
>  static struct usb_sys_interface *usb_sys_regs;
> =20
> -/* it is initialized in probe()  */
> -static struct fsl_udc *udc_controller =3D NULL;
> -
>  static const struct usb_endpoint_descriptor
>  fsl_ep0_desc =3D {
>  	.bLength =3D		USB_DT_ENDPOINT_SIZE,
> @@ -783,12 +780,14 @@ static void fsl_queue_td(struct fsl_ep *ep, struct =
fsl_req *req)
>  }
> =20
>  /* Fill in the dTD structure
> + * @udc: driver private data
>   * @req: request that the transfer belongs to
>   * @length: return actually data length of the dTD
>   * @dma: return dma address of the dTD
>   * @is_last: return flag if it is the last dTD of the request
>   * return: pointer to the built dTD */
> -static struct ep_td_struct *fsl_build_dtd(struct fsl_req *req, unsigned =
*length,
> +static struct ep_td_struct *fsl_build_dtd(struct fsl_udc *udc,
> +		struct fsl_req *req, unsigned *length,
>  		dma_addr_t *dma, int *is_last, gfp_t gfp_flags)

I would split this patch a little. First I would patch the missing
arguments to these functions under the excuse that a later patch will
get rid of the udc_controller pointer, then the next patch would do the
conversion to new style.

It will be a lot easier to review ;-)

>  {
>  	u32 swap_temp;
> @@ -798,7 +797,7 @@ static struct ep_td_struct *fsl_build_dtd(struct fsl_=
req *req, unsigned *length,
>  	*length =3D min(req->req.length - req->req.actual,
>  			(unsigned)EP_MAX_LENGTH_TRANSFER);
> =20
> -	dtd =3D dma_pool_alloc(udc_controller->td_pool, gfp_flags, dma);
> +	dtd =3D dma_pool_alloc(udc->td_pool, gfp_flags, dma);
>  	if (dtd =3D=3D NULL)
>  		return dtd;
> =20
> @@ -848,7 +847,8 @@ static struct ep_td_struct *fsl_build_dtd(struct fsl_=
req *req, unsigned *length,
>  }
> =20
>  /* Generate dtd chain for a request */
> -static int fsl_req_to_dtd(struct fsl_req *req, gfp_t gfp_flags)
> +static int fsl_req_to_dtd(struct fsl_udc *udc, struct fsl_req *req,
> +		gfp_t gfp_flags)
>  {
>  	unsigned	count;
>  	int		is_last;
> @@ -857,7 +857,8 @@ static int fsl_req_to_dtd(struct fsl_req *req, gfp_t =
gfp_flags)
>  	dma_addr_t dma;
> =20
>  	do {
> -		dtd =3D fsl_build_dtd(req, &count, &dma, &is_last, gfp_flags);
> +		dtd =3D fsl_build_dtd(udc, req, &count, &dma, &is_last,
> +				gfp_flags);
>  		if (dtd =3D=3D NULL)
>  			return -ENOMEM;
> =20
> @@ -932,7 +933,7 @@ fsl_ep_queue(struct usb_ep *_ep, struct usb_request *=
_req, gfp_t gfp_flags)
>  	req->dtd_count =3D 0;
> =20
>  	/* build dtds and push them to device queue */
> -	if (!fsl_req_to_dtd(req, gfp_flags)) {
> +	if (!fsl_req_to_dtd(udc, req, gfp_flags)) {
>  		spin_lock_irqsave(&udc->lock, flags);
>  		fsl_queue_td(ep, req);
>  	} else {
> @@ -1258,9 +1259,10 @@ static int fsl_pullup(struct usb_gadget *gadget, i=
nt is_on)
>  	return 0;
>  }
> =20
> -static int fsl_start(struct usb_gadget_driver *driver,
> -		int (*bind)(struct usb_gadget *, struct usb_gadget_driver *));
> -static int fsl_stop(struct usb_gadget_driver *driver);
> +static int fsl_udc_start(struct usb_gadget *gadget,
> +		struct usb_gadget_driver *driver);
> +static int fsl_udc_stop(struct usb_gadget *gadget,
> +		struct usb_gadget_driver *driver);
>  /* defined in gadget.h */
>  static struct usb_gadget_ops fsl_gadget_ops =3D {
>  	.get_frame =3D fsl_get_frame,
> @@ -1269,8 +1271,8 @@ static struct usb_gadget_ops fsl_gadget_ops =3D {
>  	.vbus_session =3D fsl_vbus_session,
>  	.vbus_draw =3D fsl_vbus_draw,
>  	.pullup =3D fsl_pullup,
> -	.start =3D fsl_start,
> -	.stop =3D fsl_stop,
> +	.udc_start =3D fsl_udc_start,
> +	.udc_stop =3D fsl_udc_stop,
>  };
> =20
>  /* Set protocol stall on ep0, protocol stall will automatically be clear=
ed
> @@ -1314,7 +1316,7 @@ static int ep0_prime_status(struct fsl_udc *udc, in=
t direction)
>  			ep_is_in(ep) ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
>  	req->mapped =3D 1;
> =20
> -	if (fsl_req_to_dtd(req, GFP_ATOMIC) =3D=3D 0)
> +	if (fsl_req_to_dtd(udc, req, GFP_ATOMIC) =3D=3D 0)
>  		fsl_queue_td(ep, req);
>  	else
>  		return -ENOMEM;
> @@ -1398,7 +1400,7 @@ static void ch9getstatus(struct fsl_udc *udc, u8 re=
quest_type, u16 value,
>  	req->mapped =3D 1;
> =20
>  	/* prime the data phase */
> -	if ((fsl_req_to_dtd(req, GFP_ATOMIC) =3D=3D 0))
> +	if ((fsl_req_to_dtd(udc, req, GFP_ATOMIC) =3D=3D 0))
>  		fsl_queue_td(ep, req);
>  	else			/* no mem */
>  		goto stall;
> @@ -1422,7 +1424,7 @@ static void setup_received_irq(struct fsl_udc *udc,
> =20
>  	udc_reset_ep_queue(udc, 0);
> =20
> -	/* We process some stardard setup requests here */
> +	/* We process some standard setup requests here */
>  	switch (setup->bRequest) {
>  	case USB_REQ_GET_STATUS:
>  		/* Data+Status phase from udc */
> @@ -1954,114 +1956,82 @@ static irqreturn_t fsl_udc_irq(int irq, void *_u=
dc)
>   * Hook to gadget drivers
>   * Called by initialization code of gadget drivers
>  *----------------------------------------------------------------*/
> -static int fsl_start(struct usb_gadget_driver *driver,
> -		int (*bind)(struct usb_gadget *, struct usb_gadget_driver *))
> +static int fsl_udc_start(struct usb_gadget *gadget,
> +	struct usb_gadget_driver *driver)
>  {
> +	struct fsl_udc *udc;
>  	int retval =3D -ENODEV;
> -	unsigned long flags =3D 0;
> +	unsigned long flags;
> =20
> -	if (!udc_controller)
> +	udc =3D container_of(gadget, struct fsl_udc, gadget);
> +	if (!udc)
>  		return -ENODEV;
> =20
>  	if (!driver || driver->max_speed < USB_SPEED_FULL
> -			|| !bind || !driver->disconnect || !driver->setup)
> +			|| !driver->disconnect || !driver->setup)
>  		return -EINVAL;
> =20
> -	if (udc_controller->driver)
> -		return -EBUSY;
> -
>  	/* lock is needed but whether should use this lock or another */
> -	spin_lock_irqsave(&udc_controller->lock, flags);
> +	spin_lock_irqsave(&udc->lock, flags);
> =20
>  	driver->driver.bus =3D NULL;
> -	/* hook up the driver */
> -	udc_controller->driver =3D driver;
> -	udc_controller->gadget.dev.driver =3D &driver->driver;
> -	spin_unlock_irqrestore(&udc_controller->lock, flags);
> -
> -	/* bind udc driver to gadget driver */
> -	retval =3D bind(&udc_controller->gadget, driver);
> -	if (retval) {
> -		VDBG("bind to %s --> %d", driver->driver.name, retval);
> -		udc_controller->gadget.dev.driver =3D NULL;
> -		udc_controller->driver =3D NULL;
> -		goto out;
> -	}
> =20
> -	if (!IS_ERR_OR_NULL(udc_controller->transceiver)) {
> +	if (!IS_ERR_OR_NULL(udc->transceiver)) {
>  		/* Suspend the controller until OTG enable it */
> -		udc_controller->stopped =3D 1;
> +		udc->stopped =3D 1;
>  		printk(KERN_INFO "Suspend udc for OTG auto detect\n");
> =20
>  		/* connect to bus through transceiver */
> -		if (!IS_ERR_OR_NULL(udc_controller->transceiver)) {
> -			retval =3D otg_set_peripheral(
> -					udc_controller->transceiver->otg,
> -						    &udc_controller->gadget);
> +		if (!IS_ERR_OR_NULL(udc->transceiver)) {
> +			retval =3D otg_set_peripheral(udc->transceiver->otg,
> +					&udc->gadget);
>  			if (retval < 0) {
>  				ERR("can't bind to transceiver\n");
> -				driver->unbind(&udc_controller->gadget);
> -				udc_controller->gadget.dev.driver =3D 0;
> -				udc_controller->driver =3D 0;
>  				return retval;
>  			}
>  		}
>  	} else {
> -		/* Enable DR IRQ reg and set USBCMD reg Run bit */
> -		dr_controller_run(udc_controller);
> -		udc_controller->usb_state =3D USB_STATE_ATTACHED;
> -		udc_controller->ep0_state =3D WAIT_FOR_SETUP;
> -		udc_controller->ep0_dir =3D 0;
> +		/* hook up the driver */
> +		udc->driver =3D driver;
> +		udc->gadget.dev.driver =3D &driver->driver;
> +		dr_controller_run(udc);
> +		udc->usb_state =3D USB_STATE_ATTACHED;
> +		udc->ep0_state =3D WAIT_FOR_SETUP;
> +		udc->ep0_dir =3D USB_DIR_OUT;
>  	}
> -	printk(KERN_INFO "%s: bind to driver %s\n",
> -			udc_controller->gadget.name, driver->driver.name);
> +	spin_unlock_irqrestore(&udc->lock, flags);
> =20
> -out:
> -	if (retval)
> -		printk(KERN_WARNING "gadget driver register failed %d\n",
> -		       retval);
> -	return retval;
> +	return 0;
>  }
> =20
>  /* Disconnect from gadget driver */
> -static int fsl_stop(struct usb_gadget_driver *driver)
> +static int fsl_udc_stop(struct usb_gadget *gadget,
> +	struct usb_gadget_driver *driver)
>  {
> +	struct fsl_udc *udc;
>  	struct fsl_ep *loop_ep;
>  	unsigned long flags;
> =20
> -	if (!udc_controller)
> -		return -ENODEV;
> -
> -	if (!driver || driver !=3D udc_controller->driver || !driver->unbind)
> -		return -EINVAL;
> -
> -	if (!IS_ERR_OR_NULL(udc_controller->transceiver))
> -		otg_set_peripheral(udc_controller->transceiver->otg, NULL);
> +	udc =3D container_of(gadget, struct fsl_udc, gadget);
> =20
>  	/* stop DR, disable intr */
> -	dr_controller_stop(udc_controller);
> +	dr_controller_stop(udc);
> =20
>  	/* in fact, no needed */
> -	udc_controller->usb_state =3D USB_STATE_ATTACHED;
> -	udc_controller->ep0_state =3D WAIT_FOR_SETUP;
> -	udc_controller->ep0_dir =3D 0;
> +	udc->usb_state =3D USB_STATE_ATTACHED;
> +	udc->ep0_state =3D WAIT_FOR_SETUP;
> +	udc->ep0_dir =3D USB_DIR_OUT;
> =20
>  	/* stand operation */
> -	spin_lock_irqsave(&udc_controller->lock, flags);
> -	udc_controller->gadget.speed =3D USB_SPEED_UNKNOWN;
> -	nuke(&udc_controller->eps[0], -ESHUTDOWN);
> -	list_for_each_entry(loop_ep, &udc_controller->gadget.ep_list,
> -			ep.ep_list)
> +	spin_lock_irqsave(&udc->lock, flags);
> +	udc->gadget.speed =3D USB_SPEED_UNKNOWN;
> +	nuke(&udc->eps[0], -ESHUTDOWN);
> +	list_for_each_entry(loop_ep, &udc->gadget.ep_list, ep.ep_list)
>  		nuke(loop_ep, -ESHUTDOWN);
> -	spin_unlock_irqrestore(&udc_controller->lock, flags);
> -
> -	/* report disconnect; the controller is already quiesced */
> -	driver->disconnect(&udc_controller->gadget);
> +	spin_unlock_irqrestore(&udc->lock, flags);
> =20
> -	/* unbind gadget and unhook driver. */
> -	driver->unbind(&udc_controller->gadget);
> -	udc_controller->gadget.dev.driver =3D NULL;
> -	udc_controller->driver =3D NULL;
> +	udc->gadget.dev.driver =3D NULL;
> +	udc->driver =3D NULL;
> =20
>  	printk(KERN_WARNING "unregistered gadget driver '%s'\n",
>  	       driver->driver.name);
> @@ -2088,8 +2058,8 @@ static int fsl_proc_read(char *page, char **start, =
off_t off, int count,
>  	u32 tmp_reg;
>  	struct fsl_ep *ep =3D NULL;
>  	struct fsl_req *req;
> +	struct fsl_udc *udc =3D _dev;
> =20
> -	struct fsl_udc *udc =3D udc_controller;
>  	if (off !=3D 0)
>  		return 0;
> =20
> @@ -2318,7 +2288,7 @@ static int fsl_proc_read(char *page, char **start, =
off_t off, int count,
>  }
> =20
>  #define create_proc_file()	create_proc_read_entry(proc_filename, \
> -				0, NULL, fsl_proc_read, NULL)
> +				0, NULL, fsl_proc_read, udc)
> =20
>  #define remove_proc_file()	remove_proc_entry(proc_filename, NULL)
> =20
> @@ -2334,10 +2304,12 @@ static int fsl_proc_read(char *page, char **start=
, off_t off, int count,
>  /* Release udc structures */
>  static void fsl_udc_release(struct device *dev)
>  {
> -	complete(udc_controller->done);
> -	dma_free_coherent(dev->parent, udc_controller->ep_qh_size,
> -			udc_controller->ep_qh, udc_controller->ep_qh_dma);
> -	kfree(udc_controller);
> +	struct fsl_udc *udc =3D container_of(dev, struct fsl_udc, gadget.dev);
> +
> +	complete(udc->done);
> +	dma_free_coherent(dev->parent, udc->ep_qh_size,
> +			udc->ep_qh, udc->ep_qh_dma);
> +	kfree(udc);
>  }
> =20
>  /******************************************************************
> @@ -2436,6 +2408,7 @@ static int __init struct_ep_setup(struct fsl_udc *u=
dc, unsigned char index,
>   */
>  static int __init fsl_udc_probe(struct platform_device *pdev)
>  {
> +	struct fsl_udc *udc;
>  	struct fsl_usb2_platform_data *pdata;
>  	struct resource *res;
>  	int ret =3D -ENODEV;
> @@ -2447,21 +2420,21 @@ static int __init fsl_udc_probe(struct platform_d=
evice *pdev)
>  		return -ENODEV;
>  	}
> =20
> -	udc_controller =3D kzalloc(sizeof(struct fsl_udc), GFP_KERNEL);
> -	if (udc_controller =3D=3D NULL) {
> +	udc =3D kzalloc(sizeof(struct fsl_udc), GFP_KERNEL);
> +	if (udc =3D=3D NULL) {
>  		ERR("malloc udc failed\n");
>  		return -ENOMEM;
>  	}
> =20
>  	pdata =3D pdev->dev.platform_data;
> -	udc_controller->pdata =3D pdata;
> -	spin_lock_init(&udc_controller->lock);
> -	udc_controller->stopped =3D 1;
> +	udc->pdata =3D pdata;
> +	spin_lock_init(&udc->lock);
> +	udc->stopped =3D 1;
> =20
>  #ifdef CONFIG_USB_OTG
>  	if (pdata->operating_mode =3D=3D FSL_USB2_DR_OTG) {
> -		udc_controller->transceiver =3D usb_get_phy(USB_PHY_TYPE_USB2);
> -		if (IS_ERR_OR_NULL(udc_controller->transceiver)) {
> +		udc->transceiver =3D usb_get_phy(USB_PHY_TYPE_USB2);
> +		if (IS_ERR_OR_NULL(udc->transceiver)) {
>  			ERR("Can't find OTG driver!\n");
>  			ret =3D -ENODEV;
>  			goto err_kfree;
> @@ -2522,90 +2495,90 @@ static int __init fsl_udc_probe(struct platform_d=
evice *pdev)
>  	}
>  	/* Get max device endpoints */
>  	/* DEN is bidirectional ep number, max_ep doubles the number */
> -	udc_controller->max_ep =3D (dccparams & DCCPARAMS_DEN_MASK) * 2;
> +	udc->max_ep =3D (dccparams & DCCPARAMS_DEN_MASK) * 2;
> =20
> -	udc_controller->irq =3D platform_get_irq(pdev, 0);
> -	if (!udc_controller->irq) {
> +	udc->irq =3D platform_get_irq(pdev, 0);
> +	if (!udc->irq) {
>  		ret =3D -ENODEV;
>  		goto err_iounmap;
>  	}
> =20
> -	ret =3D request_irq(udc_controller->irq, fsl_udc_irq, IRQF_SHARED,
> -			driver_name, udc_controller);
> +	ret =3D request_irq(udc->irq, fsl_udc_irq, IRQF_SHARED,
> +			driver_name, udc);
>  	if (ret !=3D 0) {
>  		ERR("cannot request irq %d err %d\n",
> -				udc_controller->irq, ret);
> +				udc->irq, ret);
>  		goto err_iounmap;
>  	}
> =20
>  	/* Initialize the udc structure including QH member and other member */
> -	if (struct_udc_setup(udc_controller, pdev)) {
> +	if (struct_udc_setup(udc, pdev)) {
>  		ERR("Can't initialize udc data structure\n");
>  		ret =3D -ENOMEM;
>  		goto err_free_irq;
>  	}
> =20
> -	if (IS_ERR_OR_NULL(udc_controller->transceiver)) {
> +	if (IS_ERR_OR_NULL(udc->transceiver)) {
>  		/* initialize usb hw reg except for regs for EP,
>  		 * leave usbintr reg untouched */
> -		dr_controller_setup(udc_controller);
> +		dr_controller_setup(udc);
>  	}
> =20
>  	fsl_udc_clk_finalize(pdev);
> =20
>  	/* Setup gadget structure */
> -	udc_controller->gadget.ops =3D &fsl_gadget_ops;
> -	udc_controller->gadget.max_speed =3D USB_SPEED_HIGH;
> -	udc_controller->gadget.ep0 =3D &udc_controller->eps[0].ep;
> -	INIT_LIST_HEAD(&udc_controller->gadget.ep_list);
> -	udc_controller->gadget.speed =3D USB_SPEED_UNKNOWN;
> -	udc_controller->gadget.name =3D driver_name;
> +	udc->gadget.ops =3D &fsl_gadget_ops;
> +	udc->gadget.max_speed =3D USB_SPEED_HIGH;
> +	udc->gadget.ep0 =3D &udc->eps[0].ep;
> +	INIT_LIST_HEAD(&udc->gadget.ep_list);
> +	udc->gadget.speed =3D USB_SPEED_UNKNOWN;
> +	udc->gadget.name =3D driver_name;
>  	udc->vbus_active =3D true;
> =20
>  	/* Setup gadget.dev and register with kernel */
> -	dev_set_name(&udc_controller->gadget.dev, "gadget");
> -	udc_controller->gadget.dev.release =3D fsl_udc_release;
> -	udc_controller->gadget.dev.parent =3D &pdev->dev;
> -	udc_controller->gadget.dev.of_node =3D pdev->dev.of_node;
> -	ret =3D device_register(&udc_controller->gadget.dev);
> +	dev_set_name(&udc->gadget.dev, "gadget");
> +	udc->gadget.dev.release =3D fsl_udc_release;
> +	udc->gadget.dev.parent =3D &pdev->dev;
> +	udc->gadget.dev.of_node =3D pdev->dev.of_node;
> +	ret =3D device_register(&udc->gadget.dev);
>  	if (ret < 0)
>  		goto err_free_irq;
> =20
> -	if (!IS_ERR_OR_NULL(udc_controller->transceiver))
> -		udc_controller->gadget.is_otg =3D 1;
> +	if (!IS_ERR_OR_NULL(udc->transceiver))
> +		udc->gadget.is_otg =3D 1;
> =20
>  	/* setup QH and epctrl for ep0 */
> -	ep0_setup(udc_controller);
> +	ep0_setup(udc);
> =20
>  	/* setup udc->eps[] for ep0 */
> -	struct_ep_setup(udc_controller, 0, "ep0", 0);
> +	struct_ep_setup(udc, 0, "ep0", 0);
>  	/* for ep0: the desc defined here;
>  	 * for other eps, gadget layer called ep_enable with defined desc
>  	 */
> -	udc_controller->eps[0].ep.desc =3D &fsl_ep0_desc;
> -	udc_controller->eps[0].ep.maxpacket =3D USB_MAX_CTRL_PAYLOAD;
> +	udc->eps[0].ep.desc =3D &fsl_ep0_desc;
> +	udc->eps[0].ep.maxpacket =3D USB_MAX_CTRL_PAYLOAD;
> =20
>  	/* setup the udc->eps[] for non-control endpoints and link
>  	 * to gadget.ep_list */
> -	for (i =3D 1; i < (int)(udc_controller->max_ep / 2); i++) {
> +	for (i =3D 1; i < (int)(udc->max_ep / 2); i++) {
>  		char name[14];
> =20
>  		sprintf(name, "ep%dout", i);
> -		struct_ep_setup(udc_controller, i * 2, name, 1);
> +		struct_ep_setup(udc, i * 2, name, 1);
>  		sprintf(name, "ep%din", i);
> -		struct_ep_setup(udc_controller, i * 2 + 1, name, 1);
> +		struct_ep_setup(udc, i * 2 + 1, name, 1);
>  	}
> =20
>  	/* use dma_pool for TD management */
> -	udc_controller->td_pool =3D dma_pool_create("udc_td", &pdev->dev,
> +	udc->td_pool =3D dma_pool_create("udc_td", &pdev->dev,
>  			sizeof(struct ep_td_struct),
>  			DTD_ALIGNMENT, UDC_DMA_BOUNDARY);
> -	if (udc_controller->td_pool =3D=3D NULL) {
> +	if (udc->td_pool =3D=3D NULL) {
>  		ret =3D -ENOMEM;
>  		goto err_unregister;
>  	}
> =20
> -	ret =3D usb_add_gadget_udc(&pdev->dev, &udc_controller->gadget);
> +	ret =3D usb_add_gadget_udc(&pdev->dev, &udc->gadget);
>  	if (ret)
>  		goto err_del_udc;
> =20
> @@ -2613,11 +2586,11 @@ static int __init fsl_udc_probe(struct platform_d=
evice *pdev)
>  	return 0;
> =20
>  err_del_udc:
> -	dma_pool_destroy(udc_controller->td_pool);
> +	dma_pool_destroy(udc->td_pool);
>  err_unregister:
> -	device_unregister(&udc_controller->gadget.dev);
> +	device_unregister(&udc->gadget.dev);
>  err_free_irq:
> -	free_irq(udc_controller->irq, udc_controller);
> +	free_irq(udc->irq, udc);
>  err_iounmap:
>  	if (pdata->exit)
>  		pdata->exit(pdev);
> @@ -2628,8 +2601,7 @@ err_release_mem_region:
>  	if (pdata->operating_mode =3D=3D FSL_USB2_DR_DEVICE)
>  		release_mem_region(res->start, resource_size(res));
>  err_kfree:
> -	kfree(udc_controller);
> -	udc_controller =3D NULL;
> +	kfree(udc);
>  	return ret;
>  }
> =20
> @@ -2638,16 +2610,13 @@ err_kfree:
>   */
>  static int __exit fsl_udc_remove(struct platform_device *pdev)
>  {
> +	struct fsl_udc *udc =3D dev_get_drvdata(&pdev->dev);
>  	struct resource *res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	struct fsl_usb2_platform_data *pdata =3D pdev->dev.platform_data;
> -
>  	DECLARE_COMPLETION(done);
> =20
> -	if (!udc_controller)
> -		return -ENODEV;
> -
> -	usb_del_gadget_udc(&udc_controller->gadget);
> -	udc_controller->done =3D &done;
> +	usb_del_gadget_udc(&udc->gadget);
> +	udc->done =3D &done;
> =20
>  	fsl_udc_clk_release();
> =20
> @@ -2655,17 +2624,17 @@ static int __exit fsl_udc_remove(struct platform_=
device *pdev)
>  	remove_proc_file();
> =20
>  	/* Free allocated memory */
> -	kfree(udc_controller->status_req->req.buf);
> -	kfree(udc_controller->status_req);
> -	kfree(udc_controller->eps);
> +	kfree(udc->status_req->req.buf);
> +	kfree(udc->status_req);
> +	kfree(udc->eps);
> =20
> -	dma_pool_destroy(udc_controller->td_pool);
> -	free_irq(udc_controller->irq, udc_controller);
> +	dma_pool_destroy(udc->td_pool);
> +	free_irq(udc->irq, udc);
>  	iounmap(dr_regs);
>  	if (pdata->operating_mode =3D=3D FSL_USB2_DR_DEVICE)
>  		release_mem_region(res->start, resource_size(res));
> =20
> -	device_unregister(&udc_controller->gadget.dev);
> +	device_unregister(&udc->gadget.dev);
>  	/* free udc --wait for the release() finished */
>  	wait_for_completion(&done);
> =20
> @@ -2685,7 +2654,8 @@ static int __exit fsl_udc_remove(struct platform_de=
vice *pdev)
>   -----------------------------------------------------------------*/
>  static int fsl_udc_suspend(struct platform_device *pdev, pm_message_t st=
ate)
>  {
> -	dr_controller_stop(udc_controller);
> +	struct fsl_udc *udc =3D dev_get_drvdata(&pdev->dev);
> +	dr_controller_stop(udc);
>  	return 0;
>  }
> =20
> @@ -2695,20 +2665,21 @@ static int fsl_udc_suspend(struct platform_device=
 *pdev, pm_message_t state)
>   *-----------------------------------------------------------------*/
>  static int fsl_udc_resume(struct platform_device *pdev)
>  {
> +	struct fsl_udc *udc =3D dev_get_drvdata(&pdev->dev);
>  	/* Enable DR irq reg and set controller Run */
> -	if (udc_controller->stopped) {
> -		dr_controller_setup(udc_controller);
> -		dr_controller_run(udc_controller);
> +	if (udc->stopped) {
> +		dr_controller_setup(udc);
> +		dr_controller_run(udc);
>  	}
> -	udc_controller->usb_state =3D USB_STATE_ATTACHED;
> -	udc_controller->ep0_state =3D WAIT_FOR_SETUP;
> -	udc_controller->ep0_dir =3D 0;
> +	udc->usb_state =3D USB_STATE_ATTACHED;
> +	udc->ep0_state =3D WAIT_FOR_SETUP;
> +	udc->ep0_dir =3D USB_DIR_OUT;
>  	return 0;
>  }
> =20
>  static int fsl_udc_otg_suspend(struct device *dev, pm_message_t state)
>  {
> -	struct fsl_udc *udc =3D udc_controller;
> +	struct fsl_udc *udc =3D container_of(dev, struct fsl_udc, gadget.dev);
>  	u32 mode, usbcmd;
> =20
>  	mode =3D fsl_readl(&dr_regs->usbmode) & USB_MODE_CTRL_MODE_MASK;
> @@ -2744,15 +2715,17 @@ static int fsl_udc_otg_suspend(struct device *dev=
, pm_message_t state)
> =20
>  static int fsl_udc_otg_resume(struct device *dev)
>  {
> +	struct fsl_udc *udc =3D container_of(dev, struct fsl_udc, gadget.dev);
> +
>  	pr_debug("%s(): stopped %d  already_stopped %d\n", __func__,
> -		 udc_controller->stopped, udc_controller->already_stopped);
> +		 udc->stopped, udc->already_stopped);
> =20
>  	/*
>  	 * If the controller was stopped at suspend time, then
>  	 * don't resume it now.
>  	 */
> -	if (udc_controller->already_stopped) {
> -		udc_controller->already_stopped =3D 0;
> +	if (udc->already_stopped) {
> +		udc->already_stopped =3D 0;
>  		pr_debug("gadget was already stopped, leaving early\n");
>  		return 0;
>  	}
> --=20
> 1.7.2.5
>=20

--=20
balbi

--F8dlzb82+Fcn6AgP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQgSsOAAoJEIaOsuA1yqREtsAP/1uJ63O3rPkJhGrhd1HsFgf3
B4MIBQbwJjtx9n1CoWnmdZ8Yu/nZLos/4bFedhIkr5BbC6r90x6Eh8YHSQLY7SWM
EE/gHFp+vYDcakPD69JYWHPE83GU2KA8djpz8FaaYhE6iFALtIGWDbAmFO5n237M
rK/QR1KB4ew/Gc1oRNQuKELDLtbytF7pV5tmXDR7ek+uNAnmR0nV5SDxOnhnIiVT
4CSdooXQ36Xbi1t41f67790ITFOwWYjkzHuN0ZDsuD1vqd9CjiQuMWaVlZ8cJaLD
3f8Q+TkHs6Dv6zl6819PTYoRUHjjXeMsitpn3JGADKuxQ/eIAKaslBS5+t+UQ6PD
q7zd6H6h4AEgrMhMlcd4wFBejRh5b0eHL3uBIKgOMa2FV8OpsX89Ft4A0qVpyLhA
WAKOKMJvjzhEftOdQh4TKyhvBdKAjIk9YqRldqmwP0BYB82SORLB6+HJOwOUS+88
nkoGSiWlwIBsnXoFIkeNSXJOKq3qxbO5weImIrVvS7fJa//QgF3Kwg8y9sG0dxQC
yXRwZj0A46LCK3189y492+re8PLQN0vhWj31W/kNLKrYVBm2yjt7hjHJ2ijq9zrE
PQr9WyeXpii8F/R0V1Usx9+yyAt3CqG0bezhSrLTL11h+z2yyQQZcSHcXaSQ8gat
73VPsa/LKVEoryZ2wJ+l
=F76a
-----END PGP SIGNATURE-----

--F8dlzb82+Fcn6AgP--
