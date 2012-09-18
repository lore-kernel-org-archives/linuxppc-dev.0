Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DF00A2C0081
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Sep 2012 15:35:16 +1000 (EST)
Subject: Re: [PATCH v2] powerpc/usb: fix bug of CPU hang when missing USB PHY
 clock
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1345630620-32070-1-git-send-email-Shengzhou.Liu@freescale.com>
Date: Tue, 18 Sep 2012 00:35:09 -0500
Message-Id: <6E81CB63-79F1-4C45-87A6-28048351FF84@kernel.crashing.org>
References: <1345630620-32070-1-git-send-email-Shengzhou.Liu@freescale.com>
To: Greg KH <greg@kroah.com>
Cc: linux-usb@vger.kernel.org,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
 Shengzhou Liu <Shengzhou.Liu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 22, 2012, at 5:17 AM, Shengzhou Liu wrote:

> when missing USB PHY clock, kernel booting up will hang during USB
> initialization. We should check USBGP[PHY_CLK_VALID] bit to avoid
> CPU hanging in this case.
>=20
> Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
> ---
> v2 changes: use spin_event_timeout() instead.
>=20
> drivers/usb/host/ehci-fsl.c |   58 =
+++++++++++++++++++++++++++++-------------
> drivers/usb/host/ehci-fsl.h |    1 +
> include/linux/fsl_devices.h |    1 +
> 3 files changed, 42 insertions(+), 18 deletions(-)

Greg,

Any issues picking this fix up for v3.6 inclusion?

- k

>=20
> diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
> index b7451b2..11ff4b4 100644
> --- a/drivers/usb/host/ehci-fsl.c
> +++ b/drivers/usb/host/ehci-fsl.c
> @@ -210,11 +210,11 @@ static void usb_hcd_fsl_remove(struct usb_hcd =
*hcd,
> 	usb_put_hcd(hcd);
> }
>=20
> -static void ehci_fsl_setup_phy(struct usb_hcd *hcd,
> +static int ehci_fsl_setup_phy(struct usb_hcd *hcd,
> 			       enum fsl_usb2_phy_modes phy_mode,
> 			       unsigned int port_offset)
> {
> -	u32 portsc, temp;
> +	u32 portsc;
> 	struct ehci_hcd *ehci =3D hcd_to_ehci(hcd);
> 	void __iomem *non_ehci =3D hcd->regs;
> 	struct device *dev =3D hcd->self.controller;
> @@ -232,9 +232,15 @@ static void ehci_fsl_setup_phy(struct usb_hcd =
*hcd,
> 	case FSL_USB2_PHY_ULPI:
> 		if (pdata->controller_ver) {
> 			/* controller version 1.6 or above */
> -			temp =3D in_be32(non_ehci + FSL_SOC_USB_CTRL);
> -			out_be32(non_ehci + FSL_SOC_USB_CTRL, temp |
> -				USB_CTRL_USB_EN | ULPI_PHY_CLK_SEL);
> +			setbits32(non_ehci + FSL_SOC_USB_CTRL,
> +					ULPI_PHY_CLK_SEL);
> +			/*
> +			 * Due to controller issue of PHY_CLK_VALID in =
ULPI
> +			 * mode, we set USB_CTRL_USB_EN before checking
> +			 * PHY_CLK_VALID, otherwise PHY_CLK_VALID =
doesn't work.
> +			 */
> +			clrsetbits_be32(non_ehci + FSL_SOC_USB_CTRL,
> +					UTMI_PHY_EN, USB_CTRL_USB_EN);
> 		}
> 		portsc |=3D PORT_PTS_ULPI;
> 		break;
> @@ -247,9 +253,7 @@ static void ehci_fsl_setup_phy(struct usb_hcd =
*hcd,
> 	case FSL_USB2_PHY_UTMI:
> 		if (pdata->controller_ver) {
> 			/* controller version 1.6 or above */
> -			temp =3D in_be32(non_ehci + FSL_SOC_USB_CTRL);
> -			out_be32(non_ehci + FSL_SOC_USB_CTRL, temp |
> -				UTMI_PHY_EN | USB_CTRL_USB_EN);
> +			setbits32(non_ehci + FSL_SOC_USB_CTRL, =
UTMI_PHY_EN);
> 			mdelay(FSL_UTMI_PHY_DLY);  /* Delay for UTMI PHY =
CLK to
> 						become stable - 10ms*/
> 		}
> @@ -262,23 +266,34 @@ static void ehci_fsl_setup_phy(struct usb_hcd =
*hcd,
> 	case FSL_USB2_PHY_NONE:
> 		break;
> 	}
> +
> +	if ((pdata->controller_ver) && ((phy_mode =3D=3D =
FSL_USB2_PHY_ULPI) ||
> +			(phy_mode =3D=3D FSL_USB2_PHY_UTMI))) {
> +		/* check PHY_CLK_VALID to get phy clk valid */
> +		if (!spin_event_timeout(in_be32(non_ehci + =
FSL_SOC_USB_CTRL) &
> +				PHY_CLK_VALID, FSL_USB_PHY_CLK_TIMEOUT, =
0)) {
> +			printk(KERN_WARNING "fsl-ehci: USB PHY clock =
invalid\n");
> +			return -EINVAL;
> +		}
> +	}
> +
> 	ehci_writel(ehci, portsc, =
&ehci->regs->port_status[port_offset]);
> +
> +	if (phy_mode !=3D FSL_USB2_PHY_ULPI)
> +		setbits32(non_ehci + FSL_SOC_USB_CTRL, USB_CTRL_USB_EN);
> +
> +	return 0;
> }
>=20
> -static void ehci_fsl_usb_setup(struct ehci_hcd *ehci)
> +static int ehci_fsl_usb_setup(struct ehci_hcd *ehci)
> {
> 	struct usb_hcd *hcd =3D ehci_to_hcd(ehci);
> 	struct fsl_usb2_platform_data *pdata;
> 	void __iomem *non_ehci =3D hcd->regs;
> -	u32 temp;
>=20
> 	pdata =3D hcd->self.controller->platform_data;
>=20
> -	/* Enable PHY interface in the control reg. */
> 	if (pdata->have_sysif_regs) {
> -		temp =3D in_be32(non_ehci + FSL_SOC_USB_CTRL);
> -		out_be32(non_ehci + FSL_SOC_USB_CTRL, temp | =
0x00000004);
> -
> 		/*
> 		* Turn on cache snooping hardware, since some PowerPC =
platforms
> 		* wholly rely on hardware to deal with cache coherent
> @@ -293,7 +308,8 @@ static void ehci_fsl_usb_setup(struct ehci_hcd =
*ehci)
>=20
> 	if ((pdata->operating_mode =3D=3D FSL_USB2_DR_HOST) ||
> 			(pdata->operating_mode =3D=3D FSL_USB2_DR_OTG))
> -		ehci_fsl_setup_phy(hcd, pdata->phy_mode, 0);
> +		if (ehci_fsl_setup_phy(hcd, pdata->phy_mode, 0))
> +			return -EINVAL;
>=20
> 	if (pdata->operating_mode =3D=3D FSL_USB2_MPH_HOST) {
> 		unsigned int chip, rev, svr;
> @@ -307,9 +323,12 @@ static void ehci_fsl_usb_setup(struct ehci_hcd =
*ehci)
> 			ehci->has_fsl_port_bug =3D 1;
>=20
> 		if (pdata->port_enables & FSL_USB2_PORT0_ENABLED)
> -			ehci_fsl_setup_phy(hcd, pdata->phy_mode, 0);
> +			if (ehci_fsl_setup_phy(hcd, pdata->phy_mode, 0))
> +				return -EINVAL;
> +
> 		if (pdata->port_enables & FSL_USB2_PORT1_ENABLED)
> -			ehci_fsl_setup_phy(hcd, pdata->phy_mode, 1);
> +			if (ehci_fsl_setup_phy(hcd, pdata->phy_mode, 1))
> +				return -EINVAL;
> 	}
>=20
> 	if (pdata->have_sysif_regs) {
> @@ -322,12 +341,15 @@ static void ehci_fsl_usb_setup(struct ehci_hcd =
*ehci)
> #endif
> 		out_be32(non_ehci + FSL_SOC_USB_SICTRL, 0x00000001);
> 	}
> +
> +	return 0;
> }
>=20
> /* called after powerup, by probe or system-pm "wakeup" */
> static int ehci_fsl_reinit(struct ehci_hcd *ehci)
> {
> -	ehci_fsl_usb_setup(ehci);
> +	if (ehci_fsl_usb_setup(ehci))
> +		return -EINVAL;
> 	ehci_port_power(ehci, 0);
>=20
> 	return 0;
> diff --git a/drivers/usb/host/ehci-fsl.h b/drivers/usb/host/ehci-fsl.h
> index 8840368..dbd292e 100644
> --- a/drivers/usb/host/ehci-fsl.h
> +++ b/drivers/usb/host/ehci-fsl.h
> @@ -61,4 +61,5 @@
> #define PLL_RESET               (1<<8)
> #define UTMI_PHY_EN             (1<<9)
> #define ULPI_PHY_CLK_SEL        (1<<10)
> +#define PHY_CLK_VALID		(1<<17)
> #endif				/* _EHCI_FSL_H */
> diff --git a/include/linux/fsl_devices.h b/include/linux/fsl_devices.h
> index 15be561..ccfc4bb 100644
> --- a/include/linux/fsl_devices.h
> +++ b/include/linux/fsl_devices.h
> @@ -19,6 +19,7 @@
>=20
> #define FSL_UTMI_PHY_DLY	10	/*As per P1010RM, delay for UTMI
> 				PHY CLK to become stable - 10ms*/
> +#define FSL_USB_PHY_CLK_TIMEOUT	1000	/* uSec */
> #define FSL_USB_VER_OLD		0
> #define FSL_USB_VER_1_6		1
> #define FSL_USB_VER_2_2		2
> --=20
> 1.6.4
>=20
