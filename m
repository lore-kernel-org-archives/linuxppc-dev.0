Return-Path: <balbi@ti.com>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mailhost.ti.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6B5B62C0091
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2012 21:35:07 +1100 (EST)
Date: Fri, 19 Oct 2012 13:29:07 +0300
From: Felipe Balbi <balbi@ti.com>
To: Christoph Fritz <chf.fritz@googlemail.com>
Subject: Re: [PATCH 4/7] usb: gadget: fsl_udc: drop ARCH dependency
Message-ID: <20121019102907.GE11191@arwen.pp.htv.fi>
References: <1350642156-8034-1-git-send-email-chf.fritz@googlemail.com>
 <1350642285-8145-4-git-send-email-chf.fritz@googlemail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="UnaWdueM1EBWVRzC"
In-Reply-To: <1350642285-8145-4-git-send-email-chf.fritz@googlemail.com>
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

--UnaWdueM1EBWVRzC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 19, 2012 at 12:24:42PM +0200, Christoph Fritz wrote:
> Drop the big-/little-endian helpers and make use of generic
> writel()/readl() routines.
>=20
> Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
> ---
>  drivers/usb/gadget/fsl_udc_core.c |  331 +++++++++++++------------------=
------
>  1 files changed, 118 insertions(+), 213 deletions(-)
>=20
> diff --git a/drivers/usb/gadget/fsl_udc_core.c b/drivers/usb/gadget/fsl_u=
dc_core.c
> index d113f39..53df9c0 100644
> --- a/drivers/usb/gadget/fsl_udc_core.c
> +++ b/drivers/usb/gadget/fsl_udc_core.c
> @@ -20,32 +20,14 @@
>  #undef VERBOSE
> =20
>  #include <linux/module.h>
> -#include <linux/kernel.h>
> -#include <linux/ioport.h>
> -#include <linux/types.h>
> -#include <linux/errno.h>
> -#include <linux/err.h>
> -#include <linux/slab.h>
> -#include <linux/init.h>
> -#include <linux/list.h>

you don't mention removal of these registers anywhere. Why are you
doing this ? Are those really unnecessary or are you now depending on
indirect inclusion of the headers ?

Also, $SUBJECT is a bit misleading since you don't touch Kconfig to
actually drop the ARCH dependency. Maybe rephrase $SUBJECT a little ?

>  #include <linux/interrupt.h>
>  #include <linux/proc_fs.h>
> -#include <linux/mm.h>
> -#include <linux/moduleparam.h>
> -#include <linux/device.h>
> -#include <linux/usb/ch9.h>
>  #include <linux/usb/gadget.h>
>  #include <linux/usb/otg.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/platform_device.h>
>  #include <linux/fsl_devices.h>
>  #include <linux/dmapool.h>
> -#include <linux/delay.h>
> -
> -#include <asm/byteorder.h>
> -#include <asm/io.h>
> -#include <asm/unaligned.h>
> -#include <asm/dma.h>
> =20
>  #include "fsl_usb2_udc.h"
> =20
> @@ -74,78 +56,6 @@ fsl_ep0_desc =3D {
> =20
>  static void fsl_ep_fifo_flush(struct usb_ep *_ep);
> =20
> -#ifdef CONFIG_PPC32
> -/*
> - * On some SoCs, the USB controller registers can be big or little endia=
n,
> - * depending on the version of the chip. In order to be able to run the
> - * same kernel binary on 2 different versions of an SoC, the BE/LE decis=
ion
> - * must be made at run time. _fsl_readl and fsl_writel are pointers to t=
he
> - * BE or LE readl() and writel() functions, and fsl_readl() and fsl_writ=
el()
> - * call through those pointers. Platform code for SoCs that have BE USB
> - * registers should set pdata->big_endian_mmio flag.
> - *
> - * This also applies to controller-to-cpu accessors for the USB descript=
ors,
> - * since their endianness is also SoC dependant. Platform code for SoCs =
that
> - * have BE USB descriptors should set pdata->big_endian_desc flag.
> - */
> -static u32 _fsl_readl_be(const unsigned __iomem *p)
> -{
> -	return in_be32(p);
> -}
> -
> -static u32 _fsl_readl_le(const unsigned __iomem *p)
> -{
> -	return in_le32(p);
> -}
> -
> -static void _fsl_writel_be(u32 v, unsigned __iomem *p)
> -{
> -	out_be32(p, v);
> -}
> -
> -static void _fsl_writel_le(u32 v, unsigned __iomem *p)
> -{
> -	out_le32(p, v);
> -}
> -
> -static u32 (*_fsl_readl)(const unsigned __iomem *p);
> -static void (*_fsl_writel)(u32 v, unsigned __iomem *p);
> -
> -#define fsl_readl(p)		(*_fsl_readl)((p))
> -#define fsl_writel(v, p)	(*_fsl_writel)((v), (p))
> -
> -static inline void fsl_set_accessors(struct fsl_usb2_platform_data *pdat=
a)
> -{
> -	if (pdata->big_endian_mmio) {
> -		_fsl_readl =3D _fsl_readl_be;
> -		_fsl_writel =3D _fsl_writel_be;
> -	} else {
> -		_fsl_readl =3D _fsl_readl_le;
> -		_fsl_writel =3D _fsl_writel_le;
> -	}
> -}
> -
> -static inline u32 cpu_to_hc32(const u32 x)
> -{
> -	return udc_controller->pdata->big_endian_desc
> -		? (__force u32)cpu_to_be32(x)
> -		: (__force u32)cpu_to_le32(x);
> -}
> -
> -static inline u32 hc32_to_cpu(const u32 x)
> -{
> -	return udc_controller->pdata->big_endian_desc
> -		? be32_to_cpu((__force __be32)x)
> -		: le32_to_cpu((__force __le32)x);
> -}
> -#else /* !CONFIG_PPC32 */
> -static inline void fsl_set_accessors(struct fsl_usb2_platform_data *pdat=
a) {}
> -
> -#define fsl_readl(addr)		readl(addr)
> -#define fsl_writel(val32, addr) writel(val32, addr)
> -#define cpu_to_hc32(x)		cpu_to_le32(x)
> -#define hc32_to_cpu(x)		le32_to_cpu(x)
> -#endif /* CONFIG_PPC32 */
> =20
>  /********************************************************************
>   *	Internal Used Function
> @@ -248,7 +158,7 @@ static int dr_controller_setup(struct fsl_udc *udc)
>  #define FSL_UDC_RESET_TIMEOUT 1000
> =20
>  	/* Config PHY interface */
> -	portctrl =3D fsl_readl(&dr_regs->portsc1);
> +	portctrl =3D readl(&dr_regs->portsc1);
>  	portctrl &=3D ~(PORTSCX_PHY_TYPE_SEL | PORTSCX_PORT_WIDTH);
>  	switch (udc->phy_mode) {
>  	case FSL_USB2_PHY_ULPI:
> @@ -286,20 +196,20 @@ static int dr_controller_setup(struct fsl_udc *udc)
>  	default:
>  		return -EINVAL;
>  	}
> -	fsl_writel(portctrl, &dr_regs->portsc1);
> +	writel(portctrl, &dr_regs->portsc1);
> =20
>  	/* Stop and reset the usb controller */
> -	tmp =3D fsl_readl(&dr_regs->usbcmd);
> +	tmp =3D readl(&dr_regs->usbcmd);
>  	tmp &=3D ~USB_CMD_RUN_STOP;
> -	fsl_writel(tmp, &dr_regs->usbcmd);
> +	writel(tmp, &dr_regs->usbcmd);
> =20
> -	tmp =3D fsl_readl(&dr_regs->usbcmd);
> +	tmp =3D readl(&dr_regs->usbcmd);
>  	tmp |=3D USB_CMD_CTRL_RESET;
> -	fsl_writel(tmp, &dr_regs->usbcmd);
> +	writel(tmp, &dr_regs->usbcmd);
> =20
>  	/* Wait for reset to complete */
>  	timeout =3D jiffies + FSL_UDC_RESET_TIMEOUT;
> -	while (fsl_readl(&dr_regs->usbcmd) & USB_CMD_CTRL_RESET) {
> +	while (readl(&dr_regs->usbcmd) & USB_CMD_CTRL_RESET) {
>  		if (time_after(jiffies, timeout)) {
>  			ERR("udc reset timeout!\n");
>  			return -ETIMEDOUT;
> @@ -308,33 +218,33 @@ static int dr_controller_setup(struct fsl_udc *udc)
>  	}
> =20
>  	/* Set the controller as device mode */
> -	tmp =3D fsl_readl(&dr_regs->usbmode);
> +	tmp =3D readl(&dr_regs->usbmode);
>  	tmp &=3D ~USB_MODE_CTRL_MODE_MASK;	/* clear mode bits */
>  	tmp |=3D USB_MODE_CTRL_MODE_DEVICE;
>  	/* Disable Setup Lockout */
>  	tmp |=3D USB_MODE_SETUP_LOCK_OFF;
>  	if (udc->pdata->es)
>  		tmp |=3D USB_MODE_ES;
> -	fsl_writel(tmp, &dr_regs->usbmode);
> +	writel(tmp, &dr_regs->usbmode);
> =20
>  	/* Clear the setup status */
> -	fsl_writel(0, &dr_regs->usbsts);
> +	writel(0, &dr_regs->usbsts);
> =20
>  	tmp =3D udc->ep_qh_dma;
>  	tmp &=3D USB_EP_LIST_ADDRESS_MASK;
> -	fsl_writel(tmp, &dr_regs->endpointlistaddr);
> +	writel(tmp, &dr_regs->endpointlistaddr);
> =20
>  	VDBG("vir[qh_base] is %p phy[qh_base] is 0x%8x reg is 0x%8x",
>  		udc->ep_qh, (int)tmp,
> -		fsl_readl(&dr_regs->endpointlistaddr));
> +		readl(&dr_regs->endpointlistaddr));
> =20
> -	max_no_of_ep =3D (0x0000001F & fsl_readl(&dr_regs->dccparams));
> +	max_no_of_ep =3D (0x0000001F & readl(&dr_regs->dccparams));
>  	for (ep_num =3D 1; ep_num < max_no_of_ep; ep_num++) {
> -		tmp =3D fsl_readl(&dr_regs->endptctrl[ep_num]);
> +		tmp =3D readl(&dr_regs->endptctrl[ep_num]);
>  		tmp &=3D ~(EPCTRL_TX_TYPE | EPCTRL_RX_TYPE);
>  		tmp |=3D (EPCTRL_EP_TYPE_BULK << EPCTRL_TX_EP_TYPE_SHIFT)
>  		| (EPCTRL_EP_TYPE_BULK << EPCTRL_RX_EP_TYPE_SHIFT);
> -		fsl_writel(tmp, &dr_regs->endptctrl[ep_num]);
> +		writel(tmp, &dr_regs->endptctrl[ep_num]);
>  	}
>  	/* Config control enable i/o output, cpu endian register */
>  #ifndef CONFIG_ARCH_MXC
> @@ -371,20 +281,20 @@ static void dr_controller_run(struct fsl_udc *udc)
>  		| USB_INTR_PTC_DETECT_EN | USB_INTR_RESET_EN
>  		| USB_INTR_DEVICE_SUSPEND | USB_INTR_SYS_ERR_EN;
> =20
> -	fsl_writel(temp, &dr_regs->usbintr);
> +	writel(temp, &dr_regs->usbintr);
> =20
>  	/* Clear stopped bit */
>  	udc->stopped =3D 0;
> =20
>  	/* Set the controller as device mode */
> -	temp =3D fsl_readl(&dr_regs->usbmode);
> +	temp =3D readl(&dr_regs->usbmode);
>  	temp |=3D USB_MODE_CTRL_MODE_DEVICE;
> -	fsl_writel(temp, &dr_regs->usbmode);
> +	writel(temp, &dr_regs->usbmode);
> =20
>  	/* Set controller to Run */
> -	temp =3D fsl_readl(&dr_regs->usbcmd);
> +	temp =3D readl(&dr_regs->usbcmd);
>  	temp |=3D USB_CMD_RUN_STOP;
> -	fsl_writel(temp, &dr_regs->usbcmd);
> +	writel(temp, &dr_regs->usbcmd);
>  }
> =20
>  static void dr_controller_stop(struct fsl_udc *udc)
> @@ -398,14 +308,14 @@ static void dr_controller_stop(struct fsl_udc *udc)
>  	 * ehci driver
>  	 */
>  	if (udc->gadget.is_otg) {
> -		if (!(fsl_readl(&dr_regs->otgsc) & OTGSC_STS_USB_ID)) {
> +		if (!(readl(&dr_regs->otgsc) & OTGSC_STS_USB_ID)) {
>  			pr_debug("udc: Leaving early\n");
>  			return;
>  		}
>  	}
> =20
>  	/* disable all INTR */
> -	fsl_writel(0, &dr_regs->usbintr);
> +	writel(0, &dr_regs->usbintr);
> =20
>  	/* Set stopped bit for isr */
>  	udc->stopped =3D 1;
> @@ -414,9 +324,9 @@ static void dr_controller_stop(struct fsl_udc *udc)
>  /*	usb_sys_regs->control =3D 0; */
> =20
>  	/* set controller to Stop */
> -	tmp =3D fsl_readl(&dr_regs->usbcmd);
> +	tmp =3D readl(&dr_regs->usbcmd);
>  	tmp &=3D ~USB_CMD_RUN_STOP;
> -	fsl_writel(tmp, &dr_regs->usbcmd);
> +	writel(tmp, &dr_regs->usbcmd);
>  }
> =20
>  static void dr_ep_setup(unsigned char ep_num, unsigned char dir,
> @@ -424,7 +334,7 @@ static void dr_ep_setup(unsigned char ep_num, unsigne=
d char dir,
>  {
>  	unsigned int tmp_epctrl =3D 0;
> =20
> -	tmp_epctrl =3D fsl_readl(&dr_regs->endptctrl[ep_num]);
> +	tmp_epctrl =3D readl(&dr_regs->endptctrl[ep_num]);
>  	if (dir) {
>  		if (ep_num)
>  			tmp_epctrl |=3D EPCTRL_TX_DATA_TOGGLE_RST;
> @@ -441,7 +351,7 @@ static void dr_ep_setup(unsigned char ep_num, unsigne=
d char dir,
>  				<< EPCTRL_RX_EP_TYPE_SHIFT);
>  	}
> =20
> -	fsl_writel(tmp_epctrl, &dr_regs->endptctrl[ep_num]);
> +	writel(tmp_epctrl, &dr_regs->endptctrl[ep_num]);
>  }
> =20
>  static void
> @@ -449,7 +359,7 @@ dr_ep_change_stall(unsigned char ep_num, unsigned cha=
r dir, int value)
>  {
>  	u32 tmp_epctrl =3D 0;
> =20
> -	tmp_epctrl =3D fsl_readl(&dr_regs->endptctrl[ep_num]);
> +	tmp_epctrl =3D readl(&dr_regs->endptctrl[ep_num]);
> =20
>  	if (value) {
>  		/* set the stall bit */
> @@ -467,7 +377,7 @@ dr_ep_change_stall(unsigned char ep_num, unsigned cha=
r dir, int value)
>  			tmp_epctrl |=3D EPCTRL_RX_DATA_TOGGLE_RST;
>  		}
>  	}
> -	fsl_writel(tmp_epctrl, &dr_regs->endptctrl[ep_num]);
> +	writel(tmp_epctrl, &dr_regs->endptctrl[ep_num]);
>  }
> =20
>  /* Get stall status of a specific ep
> @@ -476,7 +386,7 @@ static int dr_ep_get_stall(unsigned char ep_num, unsi=
gned char dir)
>  {
>  	u32 epctrl;
> =20
> -	epctrl =3D fsl_readl(&dr_regs->endptctrl[ep_num]);
> +	epctrl =3D readl(&dr_regs->endptctrl[ep_num]);
>  	if (dir)
>  		return (epctrl & EPCTRL_TX_EP_STALL) ? 1 : 0;
>  	else
> @@ -522,7 +432,7 @@ static void struct_ep_qh_setup(struct fsl_udc *udc, u=
nsigned char ep_num,
>  	if (zlt)
>  		tmp |=3D EP_QUEUE_HEAD_ZLT_SEL;
> =20
> -	p_QH->max_pkt_length =3D cpu_to_hc32(tmp);
> +	p_QH->max_pkt_length =3D cpu_to_le32(tmp);
>  	p_QH->next_dtd_ptr =3D 1;
>  	p_QH->size_ioc_int_sts =3D 0;
>  }
> @@ -658,7 +568,7 @@ static int fsl_ep_disable(struct usb_ep *_ep)
> =20
>  	/* disable ep on controller */
>  	ep_num =3D ep_index(ep);
> -	epctrl =3D fsl_readl(&dr_regs->endptctrl[ep_num]);
> +	epctrl =3D readl(&dr_regs->endptctrl[ep_num]);
>  	if (ep_is_in(ep)) {
>  		epctrl &=3D ~(EPCTRL_TX_ENABLE | EPCTRL_TX_TYPE);
>  		epctrl |=3D EPCTRL_EP_TYPE_BULK << EPCTRL_TX_EP_TYPE_SHIFT;
> @@ -666,7 +576,7 @@ static int fsl_ep_disable(struct usb_ep *_ep)
>  		epctrl &=3D ~(EPCTRL_RX_ENABLE | EPCTRL_TX_TYPE);
>  		epctrl |=3D EPCTRL_EP_TYPE_BULK << EPCTRL_RX_EP_TYPE_SHIFT;
>  	}
> -	fsl_writel(epctrl, &dr_regs->endptctrl[ep_num]);
> +	writel(epctrl, &dr_regs->endptctrl[ep_num]);
> =20
>  	udc =3D (struct fsl_udc *)ep->udc;
>  	spin_lock_irqsave(&udc->lock, flags);
> @@ -718,18 +628,18 @@ static void fsl_prime_ep(struct fsl_ep *ep, struct =
ep_td_struct *td)
>  	struct ep_queue_head *qh =3D get_qh_by_ep(ep);
> =20
>  	/* Write dQH next pointer and terminate bit to 0 */
> -	qh->next_dtd_ptr =3D cpu_to_hc32(td->td_dma
> +	qh->next_dtd_ptr =3D cpu_to_le32(td->td_dma
>  			& EP_QUEUE_HEAD_NEXT_POINTER_MASK);
> =20
>  	/* Clear active and halt bit */
> -	qh->size_ioc_int_sts &=3D cpu_to_hc32(~(EP_QUEUE_HEAD_STATUS_ACTIVE
> +	qh->size_ioc_int_sts &=3D cpu_to_le32(~(EP_QUEUE_HEAD_STATUS_ACTIVE
>  					| EP_QUEUE_HEAD_STATUS_HALT));
> =20
>  	/* Ensure that updates to the QH will occur before priming. */
>  	wmb();
> =20
>  	/* Prime endpoint by writing correct bit to ENDPTPRIME */
> -	fsl_writel(ep_is_in(ep) ? (1 << (ep_index(ep) + 16))
> +	writel(ep_is_in(ep) ? (1 << (ep_index(ep) + 16))
>  			: (1 << (ep_index(ep))), &dr_regs->endpointprime);
>  }
> =20
> @@ -751,26 +661,26 @@ static void fsl_queue_td(struct fsl_ep *ep, struct =
fsl_req *req)
>  		struct fsl_req *lastreq;
>  		lastreq =3D list_entry(ep->queue.prev, struct fsl_req, queue);
>  		lastreq->tail->next_td_ptr =3D
> -			cpu_to_hc32(req->head->td_dma & DTD_ADDR_MASK);
> +			cpu_to_le32(req->head->td_dma & DTD_ADDR_MASK);
>  		/* Ensure dTD's next dtd pointer to be updated */
>  		wmb();
>  		/* Read prime bit, if 1 goto done */
> -		if (fsl_readl(&dr_regs->endpointprime) & bitmask)
> +		if (readl(&dr_regs->endpointprime) & bitmask)
>  			return;
> =20
>  		do {
>  			/* Set ATDTW bit in USBCMD */
> -			temp =3D fsl_readl(&dr_regs->usbcmd);
> -			fsl_writel(temp | USB_CMD_ATDTW, &dr_regs->usbcmd);
> +			temp =3D readl(&dr_regs->usbcmd);
> +			writel(temp | USB_CMD_ATDTW, &dr_regs->usbcmd);
> =20
>  			/* Read correct status bit */
> -			tmp_stat =3D fsl_readl(&dr_regs->endptstatus) & bitmask;
> +			tmp_stat =3D readl(&dr_regs->endptstatus) & bitmask;
> =20
> -		} while (!(fsl_readl(&dr_regs->usbcmd) & USB_CMD_ATDTW));
> +		} while (!(readl(&dr_regs->usbcmd) & USB_CMD_ATDTW));
> =20
>  		/* Write ATDTW bit to 0 */
> -		temp =3D fsl_readl(&dr_regs->usbcmd);
> -		fsl_writel(temp & ~USB_CMD_ATDTW, &dr_regs->usbcmd);
> +		temp =3D readl(&dr_regs->usbcmd);
> +		writel(temp & ~USB_CMD_ATDTW, &dr_regs->usbcmd);
> =20
>  		if (tmp_stat)
>  			return;
> @@ -803,17 +713,17 @@ static struct ep_td_struct *fsl_build_dtd(struct fs=
l_udc *udc,
> =20
>  	dtd->td_dma =3D *dma;
>  	/* Clear reserved field */
> -	swap_temp =3D hc32_to_cpu(dtd->size_ioc_sts);
> +	swap_temp =3D dtd->size_ioc_sts;
>  	swap_temp &=3D ~DTD_RESERVED_FIELDS;
> -	dtd->size_ioc_sts =3D cpu_to_hc32(swap_temp);
> +	dtd->size_ioc_sts =3D cpu_to_le32(swap_temp);
> =20
>  	/* Init all of buffer page pointers */
>  	swap_temp =3D (u32) (req->req.dma + req->req.actual);
> -	dtd->buff_ptr0 =3D cpu_to_hc32(swap_temp);
> -	dtd->buff_ptr1 =3D cpu_to_hc32(swap_temp + 0x1000);
> -	dtd->buff_ptr2 =3D cpu_to_hc32(swap_temp + 0x2000);
> -	dtd->buff_ptr3 =3D cpu_to_hc32(swap_temp + 0x3000);
> -	dtd->buff_ptr4 =3D cpu_to_hc32(swap_temp + 0x4000);
> +	dtd->buff_ptr0 =3D cpu_to_le32(swap_temp);
> +	dtd->buff_ptr1 =3D cpu_to_le32(swap_temp + 0x1000);
> +	dtd->buff_ptr2 =3D cpu_to_le32(swap_temp + 0x2000);
> +	dtd->buff_ptr3 =3D cpu_to_le32(swap_temp + 0x3000);
> +	dtd->buff_ptr4 =3D cpu_to_le32(swap_temp + 0x4000);
> =20
>  	req->req.actual +=3D *length;
> =20
> @@ -837,7 +747,7 @@ static struct ep_td_struct *fsl_build_dtd(struct fsl_=
udc *udc,
>  	if (*is_last && !req->req.no_interrupt)
>  		swap_temp |=3D DTD_IOC;
> =20
> -	dtd->size_ioc_sts =3D cpu_to_hc32(swap_temp);
> +	dtd->size_ioc_sts =3D cpu_to_le32(swap_temp);
> =20
>  	mb();
> =20
> @@ -866,7 +776,7 @@ static int fsl_req_to_dtd(struct fsl_udc *udc, struct=
 fsl_req *req,
>  			is_first =3D 0;
>  			req->head =3D dtd;
>  		} else {
> -			last_dtd->next_td_ptr =3D cpu_to_hc32(dma);
> +			last_dtd->next_td_ptr =3D cpu_to_le32(dma);
>  			last_dtd->next_td_virt =3D dtd;
>  		}
>  		last_dtd =3D dtd;
> @@ -874,7 +784,7 @@ static int fsl_req_to_dtd(struct fsl_udc *udc, struct=
 fsl_req *req,
>  		req->dtd_count++;
>  	} while (!is_last);
> =20
> -	dtd->next_td_ptr =3D cpu_to_hc32(DTD_NEXT_TERMINATE);
> +	dtd->next_td_ptr =3D cpu_to_le32(DTD_NEXT_TERMINATE);
> =20
>  	req->tail =3D dtd;
> =20
> @@ -966,12 +876,12 @@ static int fsl_ep_dequeue(struct usb_ep *_ep, struc=
t usb_request *_req)
>  	/* Stop the ep before we deal with the queue */
>  	ep->stopped =3D 1;
>  	ep_num =3D ep_index(ep);
> -	epctrl =3D fsl_readl(&dr_regs->endptctrl[ep_num]);
> +	epctrl =3D readl(&dr_regs->endptctrl[ep_num]);
>  	if (ep_is_in(ep))
>  		epctrl &=3D ~EPCTRL_TX_ENABLE;
>  	else
>  		epctrl &=3D ~EPCTRL_RX_ENABLE;
> -	fsl_writel(epctrl, &dr_regs->endptctrl[ep_num]);
> +	writel(epctrl, &dr_regs->endptctrl[ep_num]);
> =20
>  	/* make sure it's actually queued on this endpoint */
>  	list_for_each_entry(req, &ep->queue, queue) {
> @@ -1009,12 +919,12 @@ static int fsl_ep_dequeue(struct usb_ep *_ep, stru=
ct usb_request *_req)
>  	done(ep, req, -ECONNRESET);
> =20
>  	/* Enable EP */
> -out:	epctrl =3D fsl_readl(&dr_regs->endptctrl[ep_num]);
> +out:	epctrl =3D readl(&dr_regs->endptctrl[ep_num]);
>  	if (ep_is_in(ep))
>  		epctrl |=3D EPCTRL_TX_ENABLE;
>  	else
>  		epctrl |=3D EPCTRL_RX_ENABLE;
> -	fsl_writel(epctrl, &dr_regs->endptctrl[ep_num]);
> +	writel(epctrl, &dr_regs->endptctrl[ep_num]);
>  	ep->stopped =3D stopped;
> =20
>  	spin_unlock_irqrestore(&ep->udc->lock, flags);
> @@ -1096,7 +1006,7 @@ static int fsl_ep_fifo_status(struct usb_ep *_ep)
>  	bitmask =3D (ep_is_in(ep)) ? (1 << (ep_index(ep) + 16)) :
>  	    (1 << (ep_index(ep)));
> =20
> -	if (fsl_readl(&dr_regs->endptstatus) & bitmask)
> +	if (readl(&dr_regs->endptstatus) & bitmask)
>  		size =3D (qh->size_ioc_int_sts & DTD_PACKET_SIZE)
>  		    >> DTD_LENGTH_BIT_POS;
> =20
> @@ -1131,10 +1041,10 @@ static void fsl_ep_fifo_flush(struct usb_ep *_ep)
> =20
>  	timeout =3D jiffies + FSL_UDC_FLUSH_TIMEOUT;
>  	do {
> -		fsl_writel(bits, &dr_regs->endptflush);
> +		writel(bits, &dr_regs->endptflush);
> =20
>  		/* Wait until flush complete */
> -		while (fsl_readl(&dr_regs->endptflush)) {
> +		while (readl(&dr_regs->endptflush)) {
>  			if (time_after(jiffies, timeout)) {
>  				ERR("ep flush timeout\n");
>  				return;
> @@ -1142,7 +1052,7 @@ static void fsl_ep_fifo_flush(struct usb_ep *_ep)
>  			cpu_relax();
>  		}
>  		/* See if we need to flush again */
> -	} while (fsl_readl(&dr_regs->endptstatus) & bits);
> +	} while (readl(&dr_regs->endptstatus) & bits);
>  }
> =20
>  static struct usb_ep_ops fsl_ep_ops =3D {
> @@ -1169,7 +1079,7 @@ static struct usb_ep_ops fsl_ep_ops =3D {
>   *----------------------------------------------------------------------=
*/
>  static int fsl_get_frame(struct usb_gadget *gadget)
>  {
> -	return (int)(fsl_readl(&dr_regs->frindex) & USB_FRINDEX_MASKS);
> +	return (int)(readl(&dr_regs->frindex) & USB_FRINDEX_MASKS);
>  }
> =20
>  /*-----------------------------------------------------------------------
> @@ -1184,13 +1094,13 @@ static int fsl_wakeup(struct usb_gadget *gadget)
>  	if (!udc->remote_wakeup)
>  		return -ENOTSUPP;
> =20
> -	portsc =3D fsl_readl(&dr_regs->portsc1);
> +	portsc =3D readl(&dr_regs->portsc1);
>  	/* not suspended? */
>  	if (!(portsc & PORTSCX_PORT_SUSPEND))
>  		return 0;
>  	/* trigger force resume */
>  	portsc |=3D PORTSCX_PORT_FORCE_RESUME;
> -	fsl_writel(portsc, &dr_regs->portsc1);
> +	writel(portsc, &dr_regs->portsc1);
>  	return 0;
>  }
> =20
> @@ -1211,10 +1121,10 @@ static int fsl_vbus_session(struct usb_gadget *ga=
dget, int is_active)
>  	VDBG("VBUS %s", is_active ? "on" : "off");
>  	udc->vbus_active =3D (is_active !=3D 0);
>  	if (can_pullup(udc))
> -		fsl_writel((fsl_readl(&dr_regs->usbcmd) | USB_CMD_RUN_STOP),
> +		writel((readl(&dr_regs->usbcmd) | USB_CMD_RUN_STOP),
>  				&dr_regs->usbcmd);
>  	else
> -		fsl_writel((fsl_readl(&dr_regs->usbcmd) & ~USB_CMD_RUN_STOP),
> +		writel((readl(&dr_regs->usbcmd) & ~USB_CMD_RUN_STOP),
>  				&dr_regs->usbcmd);
>  	spin_unlock_irqrestore(&udc->lock, flags);
>  	return 0;
> @@ -1249,10 +1159,10 @@ static int fsl_pullup(struct usb_gadget *gadget, =
int is_on)
>  	spin_lock_irqsave(&udc->lock, flags);
>  	udc->softconnect =3D (is_on !=3D 0);
>  	if (can_pullup(udc))
> -		fsl_writel((fsl_readl(&dr_regs->usbcmd) | USB_CMD_RUN_STOP),
> +		writel((readl(&dr_regs->usbcmd) | USB_CMD_RUN_STOP),
>  				&dr_regs->usbcmd);
>  	else
> -		fsl_writel((fsl_readl(&dr_regs->usbcmd) & ~USB_CMD_RUN_STOP),
> +		writel((readl(&dr_regs->usbcmd) & ~USB_CMD_RUN_STOP),
>  				&dr_regs->usbcmd);
>  	spin_unlock_irqrestore(&udc->lock, flags);
> =20
> @@ -1282,9 +1192,9 @@ static void ep0stall(struct fsl_udc *udc)
>  	u32 tmp;
> =20
>  	/* must set tx and rx to stall at the same time */
> -	tmp =3D fsl_readl(&dr_regs->endptctrl[0]);
> +	tmp =3D readl(&dr_regs->endptctrl[0]);
>  	tmp |=3D EPCTRL_TX_EP_STALL | EPCTRL_RX_EP_STALL;
> -	fsl_writel(tmp, &dr_regs->endptctrl[0]);
> +	writel(tmp, &dr_regs->endptctrl[0]);
>  	udc->ep0_state =3D WAIT_FOR_SETUP;
>  	udc->ep0_dir =3D 0;
>  }
> @@ -1494,8 +1404,8 @@ static void setup_received_irq(struct fsl_udc *udc,
>  			u32 tmp;
> =20
>  			mdelay(10);
> -			tmp =3D fsl_readl(&dr_regs->portsc1) | (ptc << 16);
> -			fsl_writel(tmp, &dr_regs->portsc1);
> +			tmp =3D readl(&dr_regs->portsc1) | (ptc << 16);
> +			writel(tmp, &dr_regs->portsc1);
>  			printk(KERN_INFO "udc: switch to test mode %d.\n", ptc);
>  		}
> =20
> @@ -1546,7 +1456,7 @@ static void ep0_req_complete(struct fsl_udc *udc, s=
truct fsl_ep *ep0,
>  	if (udc->usb_state =3D=3D USB_STATE_ADDRESS) {
>  		/* Set the new address */
>  		u32 new_address =3D (u32) udc->device_address;
> -		fsl_writel(new_address << USB_DEVICE_ADDRESS_BIT_POS,
> +		writel(new_address << USB_DEVICE_ADDRESS_BIT_POS,
>  				&dr_regs->deviceaddr);
>  	}
> =20
> @@ -1585,14 +1495,14 @@ static void tripwire_handler(struct fsl_udc *udc,=
 u8 ep_num, u8 *buffer_ptr)
>  	qh =3D &udc->ep_qh[ep_num * 2 + EP_DIR_OUT];
> =20
>  	/* Clear bit in ENDPTSETUPSTAT */
> -	temp =3D fsl_readl(&dr_regs->endptsetupstat);
> -	fsl_writel(temp | (1 << ep_num), &dr_regs->endptsetupstat);
> +	temp =3D readl(&dr_regs->endptsetupstat);
> +	writel(temp | (1 << ep_num), &dr_regs->endptsetupstat);
> =20
>  	/* while a hazard exists when setup package arrives */
>  	do {
>  		/* Set Setup Tripwire */
> -		temp =3D fsl_readl(&dr_regs->usbcmd);
> -		fsl_writel(temp | USB_CMD_SUTW, &dr_regs->usbcmd);
> +		temp =3D readl(&dr_regs->usbcmd);
> +		writel(temp | USB_CMD_SUTW, &dr_regs->usbcmd);
> =20
>  		/* Copy the setup packet to local buffer */
>  		if (pdata->le_setup_buf) {
> @@ -1605,11 +1515,11 @@ static void tripwire_handler(struct fsl_udc *udc,=
 u8 ep_num, u8 *buffer_ptr)
>  		} else {
>  			memcpy(buffer_ptr, (u8 *) qh->setup_buffer, 8);
>  		}
> -	} while (!(fsl_readl(&dr_regs->usbcmd) & USB_CMD_SUTW));
> +	} while (!(readl(&dr_regs->usbcmd) & USB_CMD_SUTW));
> =20
>  	/* Clear Setup Tripwire */
> -	temp =3D fsl_readl(&dr_regs->usbcmd);
> -	fsl_writel(temp & ~USB_CMD_SUTW, &dr_regs->usbcmd);
> +	temp =3D readl(&dr_regs->usbcmd);
> +	writel(temp & ~USB_CMD_SUTW, &dr_regs->usbcmd);
>  }
> =20
>  /* process-ep_req(): free the completed Tds for this req */
> @@ -1628,19 +1538,18 @@ static int process_ep_req(struct fsl_udc *udc, in=
t pipe,
>  	actual =3D curr_req->req.length;
> =20
>  	for (j =3D 0; j < curr_req->dtd_count; j++) {
> -		remaining_length =3D (hc32_to_cpu(curr_td->size_ioc_sts)
> -					& DTD_PACKET_SIZE)
> +		remaining_length =3D (curr_td->size_ioc_sts & DTD_PACKET_SIZE)
>  				>> DTD_LENGTH_BIT_POS;
>  		actual -=3D remaining_length;
> =20
> -		errors =3D hc32_to_cpu(curr_td->size_ioc_sts);
> +		errors =3D curr_td->size_ioc_sts;
>  		if (errors & DTD_ERROR_MASK) {
>  			if (errors & DTD_STATUS_HALTED) {
>  				ERR("dTD error %08x QH=3D%d\n", errors, pipe);
>  				/* Clear the errors and Halt condition */
> -				tmp =3D hc32_to_cpu(curr_qh->size_ioc_int_sts);
> +				tmp =3D curr_qh->size_ioc_int_sts;
>  				tmp &=3D ~errors;
> -				curr_qh->size_ioc_int_sts =3D cpu_to_hc32(tmp);
> +				curr_qh->size_ioc_int_sts =3D cpu_to_le32(tmp);
>  				status =3D -EPIPE;
>  				/* FIXME: continue with next queued TD? */
> =20
> @@ -1658,8 +1567,7 @@ static int process_ep_req(struct fsl_udc *udc, int =
pipe,
>  				ERR("Unknown error has occurred (0x%x)!\n",
>  					errors);
> =20
> -		} else if (hc32_to_cpu(curr_td->size_ioc_sts)
> -				& DTD_STATUS_ACTIVE) {
> +		} else if (curr_td->size_ioc_sts & DTD_STATUS_ACTIVE) {
>  			VDBG("Request not complete");
>  			status =3D REQ_UNCOMPLETE;
>  			return status;
> @@ -1698,8 +1606,8 @@ static void dtd_complete_irq(struct fsl_udc *udc)
>  	struct fsl_req *curr_req, *temp_req;
> =20
>  	/* Clear the bits in the register */
> -	bit_pos =3D fsl_readl(&dr_regs->endptcomplete);
> -	fsl_writel(bit_pos, &dr_regs->endptcomplete);
> +	bit_pos =3D readl(&dr_regs->endptcomplete);
> +	writel(bit_pos, &dr_regs->endptcomplete);
> =20
>  	if (!bit_pos)
>  		return;
> @@ -1763,10 +1671,10 @@ static void port_change_irq(struct fsl_udc *udc)
>  		udc->bus_reset =3D 0;
> =20
>  	/* Bus resetting is finished */
> -	if (!(fsl_readl(&dr_regs->portsc1) & PORTSCX_PORT_RESET))
> +	if (!(readl(&dr_regs->portsc1) & PORTSCX_PORT_RESET))
>  		/* Get the speed */
>  		udc->gadget.speed =3D
> -			portscx_device_speed(fsl_readl(&dr_regs->portsc1));
> +			portscx_device_speed(readl(&dr_regs->portsc1));
> =20
>  	/* Update USB state */
>  	if (!udc->resume_state)
> @@ -1817,8 +1725,8 @@ static void reset_irq(struct fsl_udc *udc)
>  	unsigned long timeout;
> =20
>  	/* Clear the device address */
> -	temp =3D fsl_readl(&dr_regs->deviceaddr);
> -	fsl_writel(temp & ~USB_DEVICE_ADDRESS_MASK, &dr_regs->deviceaddr);
> +	temp =3D readl(&dr_regs->deviceaddr);
> +	writel(temp & ~USB_DEVICE_ADDRESS_MASK, &dr_regs->deviceaddr);
> =20
>  	udc->device_address =3D 0;
> =20
> @@ -1832,15 +1740,15 @@ static void reset_irq(struct fsl_udc *udc)
>  	udc->gadget.a_alt_hnp_support =3D 0;
> =20
>  	/* Clear all the setup token semaphores */
> -	temp =3D fsl_readl(&dr_regs->endptsetupstat);
> -	fsl_writel(temp, &dr_regs->endptsetupstat);
> +	temp =3D readl(&dr_regs->endptsetupstat);
> +	writel(temp, &dr_regs->endptsetupstat);
> =20
>  	/* Clear all the endpoint complete status bits */
> -	temp =3D fsl_readl(&dr_regs->endptcomplete);
> -	fsl_writel(temp, &dr_regs->endptcomplete);
> +	temp =3D readl(&dr_regs->endptcomplete);
> +	writel(temp, &dr_regs->endptcomplete);
> =20
>  	timeout =3D jiffies + 100;
> -	while (fsl_readl(&dr_regs->endpointprime)) {
> +	while (readl(&dr_regs->endpointprime)) {
>  		/* Wait until all endptprime bits cleared */
>  		if (time_after(jiffies, timeout)) {
>  			ERR("Timeout for reset\n");
> @@ -1850,9 +1758,9 @@ static void reset_irq(struct fsl_udc *udc)
>  	}
> =20
>  	/* Write 1s to the flush register */
> -	fsl_writel(0xffffffff, &dr_regs->endptflush);
> +	writel(0xffffffff, &dr_regs->endptflush);
> =20
> -	if (fsl_readl(&dr_regs->portsc1) & PORTSCX_PORT_RESET) {
> +	if (readl(&dr_regs->portsc1) & PORTSCX_PORT_RESET) {
>  		VDBG("Bus reset");
>  		/* Bus is reseting */
>  		udc->bus_reset =3D 1;
> @@ -1891,22 +1799,22 @@ static irqreturn_t fsl_udc_irq(int irq, void *_ud=
c)
>  	if (udc->stopped)
>  		return IRQ_NONE;
>  	spin_lock_irqsave(&udc->lock, flags);
> -	irq_src =3D fsl_readl(&dr_regs->usbsts) & fsl_readl(&dr_regs->usbintr);
> +	irq_src =3D readl(&dr_regs->usbsts) & readl(&dr_regs->usbintr);
>  	/* Clear notification bits */
> -	fsl_writel(irq_src, &dr_regs->usbsts);
> +	writel(irq_src, &dr_regs->usbsts);
> =20
>  	/* VDBG("irq_src [0x%8x]", irq_src); */
> =20
>  	/* Need to resume? */
>  	if (udc->usb_state =3D=3D USB_STATE_SUSPENDED)
> -		if ((fsl_readl(&dr_regs->portsc1) & PORTSCX_PORT_SUSPEND) =3D=3D 0)
> +		if ((readl(&dr_regs->portsc1) & PORTSCX_PORT_SUSPEND) =3D=3D 0)
>  			bus_resume(udc);
> =20
>  	/* USB Interrupt */
>  	if (irq_src & USB_STS_INT) {
>  		VDBG("Packet int");
>  		/* Setup package, we only support ep0 as control ep */
> -		if (fsl_readl(&dr_regs->endptsetupstat) & EP_SETUP_STATUS_EP0) {
> +		if (readl(&dr_regs->endptsetupstat) & EP_SETUP_STATUS_EP0) {
>  			tripwire_handler(udc, 0,
>  					(u8 *) (&udc->local_setup_buff));
>  			setup_received_irq(udc, &udc->local_setup_buff);
> @@ -1914,7 +1822,7 @@ static irqreturn_t fsl_udc_irq(int irq, void *_udc)
>  		}
> =20
>  		/* completion of dtd */
> -		if (fsl_readl(&dr_regs->endptcomplete)) {
> +		if (readl(&dr_regs->endptcomplete)) {
>  			dtd_complete_irq(udc);
>  			status =3D IRQ_HANDLED;
>  		}
> @@ -2076,7 +1984,7 @@ static int fsl_proc_read(char *page, char **start, =
off_t off, int count,
>  	next +=3D t;
> =20
>  	/* ------ DR Registers ----- */
> -	tmp_reg =3D fsl_readl(&dr_regs->usbcmd);
> +	tmp_reg =3D readl(&dr_regs->usbcmd);
>  	t =3D scnprintf(next, size,
>  			"USBCMD reg:\n"
>  			"SetupTW: %d\n"
> @@ -2086,7 +1994,7 @@ static int fsl_proc_read(char *page, char **start, =
off_t off, int count,
>  	size -=3D t;
>  	next +=3D t;
> =20
> -	tmp_reg =3D fsl_readl(&dr_regs->usbsts);
> +	tmp_reg =3D readl(&dr_regs->usbsts);
>  	t =3D scnprintf(next, size,
>  			"USB Status Reg:\n"
>  			"Dr Suspend: %d Reset Received: %d System Error: %s "
> @@ -2098,7 +2006,7 @@ static int fsl_proc_read(char *page, char **start, =
off_t off, int count,
>  	size -=3D t;
>  	next +=3D t;
> =20
> -	tmp_reg =3D fsl_readl(&dr_regs->usbintr);
> +	tmp_reg =3D readl(&dr_regs->usbintr);
>  	t =3D scnprintf(next, size,
>  			"USB Intrrupt Enable Reg:\n"
>  			"Sleep Enable: %d SOF Received Enable: %d "
> @@ -2116,21 +2024,21 @@ static int fsl_proc_read(char *page, char **start=
, off_t off, int count,
>  	size -=3D t;
>  	next +=3D t;
> =20
> -	tmp_reg =3D fsl_readl(&dr_regs->frindex);
> +	tmp_reg =3D readl(&dr_regs->frindex);
>  	t =3D scnprintf(next, size,
>  			"USB Frame Index Reg: Frame Number is 0x%x\n\n",
>  			(tmp_reg & USB_FRINDEX_MASKS));
>  	size -=3D t;
>  	next +=3D t;
> =20
> -	tmp_reg =3D fsl_readl(&dr_regs->deviceaddr);
> +	tmp_reg =3D readl(&dr_regs->deviceaddr);
>  	t =3D scnprintf(next, size,
>  			"USB Device Address Reg: Device Addr is 0x%x\n\n",
>  			(tmp_reg & USB_DEVICE_ADDRESS_MASK));
>  	size -=3D t;
>  	next +=3D t;
> =20
> -	tmp_reg =3D fsl_readl(&dr_regs->endpointlistaddr);
> +	tmp_reg =3D readl(&dr_regs->endpointlistaddr);
>  	t =3D scnprintf(next, size,
>  			"USB Endpoint List Address Reg: "
>  			"Device Addr is 0x%x\n\n",
> @@ -2138,7 +2046,7 @@ static int fsl_proc_read(char *page, char **start, =
off_t off, int count,
>  	size -=3D t;
>  	next +=3D t;
> =20
> -	tmp_reg =3D fsl_readl(&dr_regs->portsc1);
> +	tmp_reg =3D readl(&dr_regs->portsc1);
>  	t =3D scnprintf(next, size,
>  		"USB Port Status&Control Reg:\n"
>  		"Port Transceiver Type : %s Port Speed: %s\n"
> @@ -2177,7 +2085,7 @@ static int fsl_proc_read(char *page, char **start, =
off_t off, int count,
>  	size -=3D t;
>  	next +=3D t;
> =20
> -	tmp_reg =3D fsl_readl(&dr_regs->usbmode);
> +	tmp_reg =3D readl(&dr_regs->usbmode);
>  	t =3D scnprintf(next, size,
>  			"USB Mode Reg: Controller Mode is: %s\n\n", ( {
>  				char *s;
> @@ -2196,7 +2104,7 @@ static int fsl_proc_read(char *page, char **start, =
off_t off, int count,
>  	size -=3D t;
>  	next +=3D t;
> =20
> -	tmp_reg =3D fsl_readl(&dr_regs->endptsetupstat);
> +	tmp_reg =3D readl(&dr_regs->endptsetupstat);
>  	t =3D scnprintf(next, size,
>  			"Endpoint Setup Status Reg: SETUP on ep 0x%x\n\n",
>  			(tmp_reg & EP_SETUP_STATUS_MASK));
> @@ -2204,13 +2112,13 @@ static int fsl_proc_read(char *page, char **start=
, off_t off, int count,
>  	next +=3D t;
> =20
>  	for (i =3D 0; i < udc->max_ep / 2; i++) {
> -		tmp_reg =3D fsl_readl(&dr_regs->endptctrl[i]);
> +		tmp_reg =3D readl(&dr_regs->endptctrl[i]);
>  		t =3D scnprintf(next, size, "EP Ctrl Reg [0x%x]: =3D [0x%x]\n",
>  				i, tmp_reg);
>  		size -=3D t;
>  		next +=3D t;
>  	}
> -	tmp_reg =3D fsl_readl(&dr_regs->endpointprime);
> +	tmp_reg =3D readl(&dr_regs->endpointprime);
>  	t =3D scnprintf(next, size, "EP Prime Reg =3D [0x%x]\n\n", tmp_reg);
>  	size -=3D t;
>  	next +=3D t;
> @@ -2473,9 +2381,6 @@ static int __init fsl_udc_probe(struct platform_dev=
ice *pdev)
>  		goto err_iounmap_noclk;
>  	}
> =20
> -	/* Set accessors only after pdata->init() ! */
> -	fsl_set_accessors(pdata);
> -
>  #ifndef CONFIG_ARCH_MXC
>  	if (pdata->have_sysif_regs)
>  		usb_sys_regs =3D (void *)dr_regs + USB_DR_SYS_OFFSET;
> @@ -2487,7 +2392,7 @@ static int __init fsl_udc_probe(struct platform_dev=
ice *pdev)
>  		goto err_iounmap_noclk;
> =20
>  	/* Read Device Controller Capability Parameters register */
> -	dccparams =3D fsl_readl(&dr_regs->dccparams);
> +	dccparams =3D readl(&dr_regs->dccparams);
>  	if (!(dccparams & DCCPARAMS_DC)) {
>  		ERR("This SOC doesn't support device role\n");
>  		ret =3D -ENODEV;
> @@ -2682,7 +2587,7 @@ static int fsl_udc_otg_suspend(struct device *dev, =
pm_message_t state)
>  	struct fsl_udc *udc =3D container_of(dev, struct fsl_udc, gadget.dev);
>  	u32 mode, usbcmd;
> =20
> -	mode =3D fsl_readl(&dr_regs->usbmode) & USB_MODE_CTRL_MODE_MASK;
> +	mode =3D readl(&dr_regs->usbmode) & USB_MODE_CTRL_MODE_MASK;
> =20
>  	pr_debug("%s(): mode 0x%x stopped %d\n", __func__, mode, udc->stopped);
> =20
> @@ -2703,8 +2608,8 @@ static int fsl_udc_otg_suspend(struct device *dev, =
pm_message_t state)
>  	}
> =20
>  	/* stop the controller */
> -	usbcmd =3D fsl_readl(&dr_regs->usbcmd) & ~USB_CMD_RUN_STOP;
> -	fsl_writel(usbcmd, &dr_regs->usbcmd);
> +	usbcmd =3D readl(&dr_regs->usbcmd) & ~USB_CMD_RUN_STOP;
> +	writel(usbcmd, &dr_regs->usbcmd);
> =20
>  	udc->stopped =3D 1;
> =20
> --=20
> 1.7.2.5
>=20

--=20
balbi

--UnaWdueM1EBWVRzC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQgStzAAoJEIaOsuA1yqREPhUP/2rtPs6RH5ndP1Mk/bfna6bC
CWqF0ekIt24FLA8GaShOVUhMLRH0x1hu7ZLOl+pfZaoRkt53jq1Pj2O57yYzwnUW
b5Z8N4suHWYKlArIkPnJBzPUY+yCLbpXvpKxgCuPFSCF4TfQW1kt4QmaER+Nkcho
Amvfb9/uJGxVq4qW4p3cgC9CaJH2suGdHIy3/VeuB/TmpjJfW2PzZ66IkMhQiiEh
5IecrOpIOyhGEVmr+DLFlb8hZ+ljWHy/qrJn4LyP/FR1SBP8f6RFSHe/DlmUDq/U
Vpk7g+ELM0x/k61ghePEKva5EXNxV1gMc1wW8bgOqRduLN+L0orgPwzVYX077k5c
csMy16xrvWE7dnXCFH9bcjliFXcBDfXJ5D7fh9PdU8Gj8YkOdAC8tShDzdUzkaCi
EyUimZnyaeJ4QC9bnkkk252K+LCW81C4UsBX5vvMvRufPl1YO3I2sRuiUfpPsIJQ
sZPyA3D7uI+24kzNcmfkvLIGdc1293CkH45wZgS4yjJxVMJfRmaaD3+o5FtWtQ/8
j5FqHQdvNNjxA8zuFxoiBwmQUPq/JIYHLwqAGWWAe4KNopseOn4FUUftl2AU3j7C
YUxENbkKxdulZys6el3vgdVepHNcV0Xd75cNEhOatGlL7USR11UKAFJS2l/EmAwC
K7jvykYSluZoaPlNgUBH
=VMcB
-----END PGP SIGNATURE-----

--UnaWdueM1EBWVRzC--
