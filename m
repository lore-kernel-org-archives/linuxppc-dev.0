Return-Path: <glikely@secretlab.ca>
Received: from mail-gw0-f42.google.com (mail-gw0-f42.google.com [74.125.83.42])
	by ozlabs.org (Postfix) with ESMTP id 09C8CB6F0E
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jul 2010 18:22:40 +1000 (EST)
Received: by gwj15 with SMTP id 15so1322956gwj.15
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jul 2010 01:22:39 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1279815922-27198-4-git-send-email-agust@denx.de>
References: <1279815922-27198-1-git-send-email-agust@denx.de>
	<1279815922-27198-4-git-send-email-agust@denx.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 28 Jul 2010 02:22:19 -0600
Message-ID: <AANLkTind3aC6-G17d0h5cpffXwPAqzDXpoa20G3kzxsY@mail.gmail.com>
Subject: Re: [PATCH 3/3] USB: add USB EHCI support for MPC5121 SoC
To: Anatolij Gustschin <agust@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Wolfgang Denk <wd@denx.de>,
	Detlev Zundel <dzu@denx.de>, linux-usb@vger.kernel.org,
	linuxppc-dev@ozlabs.org, David Brownell <dbrownell@users.sourceforge.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 22, 2010 at 10:25 AM, Anatolij Gustschin <agust@denx.de> wrote:
> Extends FSL EHCI platform driver glue layer to support
> MPC5121 USB controllers. MPC5121 Rev 2.0 silicon EHCI
> registers are in big endian format. The appropriate flags
> are set using the information in the platform data structure.
> MPC83xx system interface registers are not available on
> MPC512x, so the access to these registers is isolated in
> MPC512x case. Furthermore the USB controller clocks
> must be enabled before 512x register accesses which is
> done by providing platform specific init callback.
>
> The MPC512x internal USB PHY doesn't provide supply voltage.
> For boards using different power switches allow specifying
> DRVVBUS and PWR_FAULT signal polarity of the MPC5121 internal
> PHY using "fsl,invert-drvvbus" and "fsl,invert-pwr-fault"
> properties in the device tree USB nodes. Adds documentation
> for this new device tree bindings.
>
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> Cc: Grant Likely <grant.likely@secretlab.ca>

On brief review, looks pretty good to me.

g.

> ---
> =A0Documentation/powerpc/dts-bindings/fsl/usb.txt | =A0 22 +++++
> =A0drivers/usb/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| =A0 =A01 +
> =A0drivers/usb/host/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |=
 =A0 =A06 +-
> =A0drivers/usb/host/ehci-fsl.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0107 +++++++++++++++++------
> =A0drivers/usb/host/ehci-fsl.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 19 ++++-
> =A0drivers/usb/host/ehci-mem.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 =A02 +-
> =A0drivers/usb/host/fsl-mph-dr-of.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 89 =
++++++++++++++++++++
> =A0include/linux/fsl_devices.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 15 ++++
> =A08 files changed, 229 insertions(+), 32 deletions(-)
>
> diff --git a/Documentation/powerpc/dts-bindings/fsl/usb.txt b/Documentati=
on/powerpc/dts-bindings/fsl/usb.txt
> index b001524..bd5723f 100644
> --- a/Documentation/powerpc/dts-bindings/fsl/usb.txt
> +++ b/Documentation/powerpc/dts-bindings/fsl/usb.txt
> @@ -8,6 +8,7 @@ and additions :
> =A0Required properties :
> =A0- compatible : Should be "fsl-usb2-mph" for multi port host USB
> =A0 =A0controllers, or "fsl-usb2-dr" for dual role USB controllers
> + =A0 or "fsl,mpc5121-usb2-dr" for dual role USB controllers of MPC5121
> =A0- phy_type : For multi port host USB controllers, should be one of
> =A0 =A0"ulpi", or "serial". For dual role USB controllers, should be
> =A0 =A0one of "ulpi", "utmi", "utmi_wide", or "serial".
> @@ -33,6 +34,12 @@ Recommended properties :
> =A0- interrupt-parent : the phandle for the interrupt controller that
> =A0 =A0services interrupts for this device.
>
> +Optional properties :
> + - fsl,invert-drvvbus : boolean; for MPC5121 USB0 only. Indicates the
> + =A0 port power polarity of internal PHY signal DRVVBUS is inverted.
> + - fsl,invert-pwr-fault : boolean; for MPC5121 USB0 only. Indicates
> + =A0 the PWR_FAULT signal polarity is inverted.
> +
> =A0Example multi port host USB controller device node :
> =A0 =A0 =A0 =A0usb@22000 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "fsl-usb2-mph";
> @@ -57,3 +64,18 @@ Example dual role USB controller device node :
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dr_mode =3D "otg";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0phy =3D "ulpi";
> =A0 =A0 =A0 =A0};
> +
> +Example dual role USB controller device node for MPC5121ADS:
> +
> + =A0 =A0 =A0 usb@4000 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5121-usb2-dr";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x4000 0x1000>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <0>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D < &ipic >;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <44 0x8>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dr_mode =3D "otg";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 phy_type =3D "utmi_wide";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fsl,invert-drvvbus;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fsl,invert-pwr-fault;
> + =A0 =A0 =A0 };
> diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
> index 6a58cb1..6e547b5 100644
> --- a/drivers/usb/Kconfig
> +++ b/drivers/usb/Kconfig
> @@ -58,6 +58,7 @@ config USB_ARCH_HAS_OHCI
> =A0config USB_ARCH_HAS_EHCI
> =A0 =A0 =A0 =A0boolean
> =A0 =A0 =A0 =A0default y if PPC_83xx
> + =A0 =A0 =A0 default y if PPC_MPC512x
> =A0 =A0 =A0 =A0default y if SOC_AU1200
> =A0 =A0 =A0 =A0default y if ARCH_IXP4XX
> =A0 =A0 =A0 =A0default y if ARCH_W90X900
> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index 6687523..90e50f0 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -93,12 +93,14 @@ config USB_EHCI_TT_NEWSCHED
>
> =A0config USB_EHCI_BIG_ENDIAN_MMIO
> =A0 =A0 =A0 =A0bool
> - =A0 =A0 =A0 depends on USB_EHCI_HCD && (PPC_CELLEB || PPC_PS3 || 440EPX=
 || ARCH_IXP4XX || XPS_USB_HCD_XILINX)
> + =A0 =A0 =A0 depends on USB_EHCI_HCD && (PPC_CELLEB || PPC_PS3 || 440EPX=
 || ARCH_IXP4XX || \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 XPS=
_USB_HCD_XILINX || PPC_MPC512x)
> =A0 =A0 =A0 =A0default y
>
> =A0config USB_EHCI_BIG_ENDIAN_DESC
> =A0 =A0 =A0 =A0bool
> - =A0 =A0 =A0 depends on USB_EHCI_HCD && (440EPX || ARCH_IXP4XX || XPS_US=
B_HCD_XILINX)
> + =A0 =A0 =A0 depends on USB_EHCI_HCD && (440EPX || ARCH_IXP4XX || XPS_US=
B_HCD_XILINX || \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 PPC=
_MPC512x)
> =A0 =A0 =A0 =A0default y
>
> =A0config XPS_USB_HCD_XILINX
> diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
> index a416421..ff50f5c 100644
> --- a/drivers/usb/host/ehci-fsl.c
> +++ b/drivers/usb/host/ehci-fsl.c
> @@ -116,13 +116,39 @@ static int usb_hcd_fsl_probe(const struct hc_driver=
 *driver,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err3;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 /* Enable USB controller */
> - =A0 =A0 =A0 temp =3D in_be32(hcd->regs + 0x500);
> - =A0 =A0 =A0 out_be32(hcd->regs + 0x500, temp | 0x4);
> + =A0 =A0 =A0 pdata->regs =3D hcd->regs;
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* do platform specific init: check the clock, grab/confi=
g pins, etc.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (pdata->init && pdata->init(pdev)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D -ENODEV;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err3;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Check if it is MPC5121 SoC, otherwise set pdata->have_=
sysif_regs
> + =A0 =A0 =A0 =A0* flag for 83xx or 8536 system interface registers.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (pdata->big_endian_mmio)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp =3D in_be32(hcd->regs + FSL_SOC_USB_ID=
);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp =3D in_le32(hcd->regs + FSL_SOC_USB_ID=
);
> +
> + =A0 =A0 =A0 if ((temp & ID_MSK) !=3D (~((temp & NID_MSK) >> 8) & ID_MSK=
))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->have_sysif_regs =3D 1;
> +
> + =A0 =A0 =A0 /* Enable USB controller, 83xx or 8536 */
> + =A0 =A0 =A0 if (pdata->have_sysif_regs)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 setbits32(hcd->regs + FSL_SOC_USB_CTRL, 0x4=
);
>
> =A0 =A0 =A0 =A0/* Set to Host mode */
> - =A0 =A0 =A0 temp =3D in_le32(hcd->regs + 0x1a8);
> - =A0 =A0 =A0 out_le32(hcd->regs + 0x1a8, temp | 0x3);
> + =A0 =A0 =A0 if (pdata->big_endian_mmio) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 setbits32(hcd->regs + FSL_SOC_USB_USBMODE, =
USBMODE_CM_HOST);
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clrsetbits_le32(hcd->regs + FSL_SOC_USB_USB=
MODE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 USBMODE_CM_=
MASK, USBMODE_CM_HOST);
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0retval =3D usb_add_hcd(hcd, irq, IRQF_DISABLED | IRQF_SHAR=
ED);
> =A0 =A0 =A0 =A0if (retval !=3D 0)
> @@ -137,6 +163,8 @@ static int usb_hcd_fsl_probe(const struct hc_driver *=
driver,
> =A0 =A0 =A0 =A0usb_put_hcd(hcd);
> =A0 =A0 =A0 err1:
> =A0 =A0 =A0 =A0dev_err(&pdev->dev, "init %s fail, %d\n", dev_name(&pdev->=
dev), retval);
> + =A0 =A0 =A0 if (pdata->exit)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->exit(pdev);
> =A0 =A0 =A0 =A0return retval;
> =A0}
>
> @@ -154,17 +182,30 @@ static int usb_hcd_fsl_probe(const struct hc_driver=
 *driver,
> =A0static void usb_hcd_fsl_remove(struct usb_hcd *hcd,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct platfo=
rm_device *pdev)
> =A0{
> + =A0 =A0 =A0 struct fsl_usb2_platform_data *pdata =3D pdev->dev.platform=
_data;
> +
> =A0 =A0 =A0 =A0usb_remove_hcd(hcd);
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* do platform specific un-initialization:
> + =A0 =A0 =A0 =A0* release iomux pins, disable clock, etc.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (pdata->exit)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->exit(pdev);
> =A0 =A0 =A0 =A0iounmap(hcd->regs);
> =A0 =A0 =A0 =A0release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
> =A0 =A0 =A0 =A0usb_put_hcd(hcd);
> =A0}
>
> -static void mpc83xx_setup_phy(struct ehci_hcd *ehci,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 enum fsl_usb2_p=
hy_modes phy_mode,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int po=
rt_offset)
> +static void ehci_fsl_setup_phy(struct ehci_hcd *ehci,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0enum fsl_usb=
2_phy_modes phy_mode,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned int=
 port_offset)
> =A0{
> - =A0 =A0 =A0 u32 portsc =3D 0;
> + =A0 =A0 =A0 u32 portsc;
> +
> + =A0 =A0 =A0 portsc =3D ehci_readl(ehci, &ehci->regs->port_status[port_o=
ffset]);
> + =A0 =A0 =A0 portsc &=3D ~(PORT_PTS_MSK | PORT_PTS_PTW);
> +
> =A0 =A0 =A0 =A0switch (phy_mode) {
> =A0 =A0 =A0 =A0case FSL_USB2_PHY_ULPI:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0portsc |=3D PORT_PTS_ULPI;
> @@ -184,20 +225,21 @@ static void mpc83xx_setup_phy(struct ehci_hcd *ehci=
,
> =A0 =A0 =A0 =A0ehci_writel(ehci, portsc, &ehci->regs->port_status[port_of=
fset]);
> =A0}
>
> -static void mpc83xx_usb_setup(struct usb_hcd *hcd)
> +static void ehci_fsl_usb_setup(struct ehci_hcd *ehci)
> =A0{
> - =A0 =A0 =A0 struct ehci_hcd *ehci =3D hcd_to_ehci(hcd);
> + =A0 =A0 =A0 struct usb_hcd *hcd =3D ehci_to_hcd(ehci);
> =A0 =A0 =A0 =A0struct fsl_usb2_platform_data *pdata;
> =A0 =A0 =A0 =A0void __iomem *non_ehci =3D hcd->regs;
> =A0 =A0 =A0 =A0u32 temp;
>
> - =A0 =A0 =A0 pdata =3D
> - =A0 =A0 =A0 =A0 =A0 (struct fsl_usb2_platform_data *)hcd->self.controll=
er->
> - =A0 =A0 =A0 =A0 =A0 platform_data;
> + =A0 =A0 =A0 pdata =3D hcd->self.controller->platform_data;
> +
> =A0 =A0 =A0 =A0/* Enable PHY interface in the control reg. */
> - =A0 =A0 =A0 temp =3D in_be32(non_ehci + FSL_SOC_USB_CTRL);
> - =A0 =A0 =A0 out_be32(non_ehci + FSL_SOC_USB_CTRL, temp | 0x00000004);
> - =A0 =A0 =A0 out_be32(non_ehci + FSL_SOC_USB_SNOOP1, 0x0000001b);
> + =A0 =A0 =A0 if (pdata->have_sysif_regs) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp =3D in_be32(non_ehci + FSL_SOC_USB_CTR=
L);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(non_ehci + FSL_SOC_USB_CTRL, temp =
| 0x00000004);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(non_ehci + FSL_SOC_USB_SNOOP1, 0x0=
000001b);
> + =A0 =A0 =A0 }
>
> =A0#if defined(CONFIG_PPC32) && !defined(CONFIG_NOT_COHERENT_CACHE)
> =A0 =A0 =A0 =A0/*
> @@ -214,7 +256,7 @@ static void mpc83xx_usb_setup(struct usb_hcd *hcd)
>
> =A0 =A0 =A0 =A0if ((pdata->operating_mode =3D=3D FSL_USB2_DR_HOST) ||
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(pdata->operating_mode =3D=
=3D FSL_USB2_DR_OTG))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc83xx_setup_phy(ehci, pdata->phy_mode, 0)=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ehci_fsl_setup_phy(ehci, pdata->phy_mode, 0=
);
>
> =A0 =A0 =A0 =A0if (pdata->operating_mode =3D=3D FSL_USB2_MPH_HOST) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned int chip, rev, svr;
> @@ -228,27 +270,31 @@ static void mpc83xx_usb_setup(struct usb_hcd *hcd)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ehci->has_fsl_port_bug =3D=
 1;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (pdata->port_enables & FSL_USB2_PORT0_E=
NABLED)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc83xx_setup_phy(ehci, pda=
ta->phy_mode, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ehci_fsl_setup_phy(ehci, pd=
ata->phy_mode, 0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (pdata->port_enables & FSL_USB2_PORT1_E=
NABLED)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc83xx_setup_phy(ehci, pda=
ta->phy_mode, 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ehci_fsl_setup_phy(ehci, pd=
ata->phy_mode, 1);
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0/* put controller in host mode. */
> - =A0 =A0 =A0 ehci_writel(ehci, 0x00000003, non_ehci + FSL_SOC_USB_USBMOD=
E);
> + =A0 =A0 =A0 temp =3D USBMODE_CM_HOST | (pdata->es ? USBMODE_ES : 0);
> + =A0 =A0 =A0 ehci_writel(ehci, temp, non_ehci + FSL_SOC_USB_USBMODE);
> +
> + =A0 =A0 =A0 if (pdata->have_sysif_regs) {
> =A0#ifdef CONFIG_PPC_85xx
> - =A0 =A0 =A0 out_be32(non_ehci + FSL_SOC_USB_PRICTRL, 0x00000008);
> - =A0 =A0 =A0 out_be32(non_ehci + FSL_SOC_USB_AGECNTTHRSH, 0x00000080);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(non_ehci + FSL_SOC_USB_PRICTRL, 0x=
00000008);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(non_ehci + FSL_SOC_USB_AGECNTTHRSH=
, 0x00000080);
> =A0#else
> - =A0 =A0 =A0 out_be32(non_ehci + FSL_SOC_USB_PRICTRL, 0x0000000c);
> - =A0 =A0 =A0 out_be32(non_ehci + FSL_SOC_USB_AGECNTTHRSH, 0x00000040);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(non_ehci + FSL_SOC_USB_PRICTRL, 0x=
0000000c);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(non_ehci + FSL_SOC_USB_AGECNTTHRSH=
, 0x00000040);
> =A0#endif
> - =A0 =A0 =A0 out_be32(non_ehci + FSL_SOC_USB_SICTRL, 0x00000001);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(non_ehci + FSL_SOC_USB_SICTRL, 0x0=
0000001);
> + =A0 =A0 =A0 }
> =A0}
>
> =A0/* called after powerup, by probe or system-pm "wakeup" */
> =A0static int ehci_fsl_reinit(struct ehci_hcd *ehci)
> =A0{
> - =A0 =A0 =A0 mpc83xx_usb_setup(ehci_to_hcd(ehci));
> + =A0 =A0 =A0 ehci_fsl_usb_setup(ehci);
> =A0 =A0 =A0 =A0ehci_port_power(ehci, 0);
>
> =A0 =A0 =A0 =A0return 0;
> @@ -259,6 +305,11 @@ static int ehci_fsl_setup(struct usb_hcd *hcd)
> =A0{
> =A0 =A0 =A0 =A0struct ehci_hcd *ehci =3D hcd_to_ehci(hcd);
> =A0 =A0 =A0 =A0int retval;
> + =A0 =A0 =A0 struct fsl_usb2_platform_data *pdata;
> +
> + =A0 =A0 =A0 pdata =3D hcd->self.controller->platform_data;
> + =A0 =A0 =A0 ehci->big_endian_desc =3D pdata->big_endian_desc;
> + =A0 =A0 =A0 ehci->big_endian_mmio =3D pdata->big_endian_mmio;
>
> =A0 =A0 =A0 =A0/* EHCI registers start at offset 0x100 */
> =A0 =A0 =A0 =A0ehci->caps =3D hcd->regs + 0x100;
> @@ -372,7 +423,7 @@ static const struct hc_driver ehci_fsl_hc_driver =3D =
{
> =A0 =A0 =A0 =A0 * generic hardware linkage
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0.irq =3D ehci_irq,
> - =A0 =A0 =A0 .flags =3D HCD_USB2,
> + =A0 =A0 =A0 .flags =3D HCD_USB2 | HCD_MEMORY,
>
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * basic lifecycle operations
> diff --git a/drivers/usb/host/ehci-fsl.h b/drivers/usb/host/ehci-fsl.h
> index b5e59db..e56be7b 100644
> --- a/drivers/usb/host/ehci-fsl.h
> +++ b/drivers/usb/host/ehci-fsl.h
> @@ -1,4 +1,4 @@
> -/* Copyright (c) 2005 freescale semiconductor
> +/* Copyright (C) 2005-2010 Freescale Semiconductor, Inc.
> =A0* Copyright (c) 2005 MontaVista Software
> =A0*
> =A0* This program is free software; you can redistribute =A0it and/or mod=
ify it
> @@ -19,6 +19,11 @@
> =A0#define _EHCI_FSL_H
>
> =A0/* offsets for the non-ehci registers in the FSL SOC USB controller */
> +#define FSL_SOC_USB_ID =A0 =A0 =A0 =A0 0x0
> +#define ID_MSK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x3f
> +#define NID_MSK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x3f00
> +#define FSL_SOC_USB_SBUSCFG =A0 =A00x90
> +#define FSL_SOC_USB_BURSTSIZE =A00x160
> =A0#define FSL_SOC_USB_ULPIVP =A0 =A0 0x170
> =A0#define FSL_SOC_USB_PORTSC1 =A0 =A00x184
> =A0#define PORT_PTS_MSK =A0 =A0 =A0 =A0 =A0 (3<<30)
> @@ -26,8 +31,20 @@
> =A0#define PORT_PTS_ULPI =A0 =A0 =A0 =A0 =A0(2<<30)
> =A0#define =A0 =A0 =A0 =A0PORT_PTS_SERIAL =A0 =A0 =A0 =A0 (3<<30)
> =A0#define PORT_PTS_PTW =A0 =A0 =A0 =A0 =A0 (1<<28)
> +#define PORT_PTS_PHCD =A0 =A0 =A0 =A0 =A0(1<<23)
> =A0#define FSL_SOC_USB_PORTSC2 =A0 =A00x188
> =A0#define FSL_SOC_USB_USBMODE =A0 =A00x1a8
> +#define USBMODE_CM_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(3 << 0) =A0 =A0 =
=A0 =A0/* controller mode mask */
> +#define USBMODE_CM_HOST =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(3 << 0) =A0 =A0 =
=A0 =A0/* controller mode: host */
> +#define USBMODE_ES =A0 =A0 =A0 =A0 =A0 =A0 (1 << 2) =A0 =A0 =A0 =A0/* (B=
ig) Endian Select */
> +
> +#define FSL_SOC_USB_USBGENCTRL 0x200
> +#define USBGENCTRL_PPP =A0 =A0 =A0 =A0 (1 << 3)
> +#define USBGENCTRL_PFP =A0 =A0 =A0 =A0 (1 << 2)
> +#define FSL_SOC_USB_ISIPHYCTRL 0x204
> +#define ISIPHYCTRL_PXE =A0 =A0 =A0 =A0 (1)
> +#define ISIPHYCTRL_PHYE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 4)
> +
> =A0#define FSL_SOC_USB_SNOOP1 =A0 =A0 0x400 =A0 /* NOTE: big-endian */
> =A0#define FSL_SOC_USB_SNOOP2 =A0 =A0 0x404 =A0 /* NOTE: big-endian */
> =A0#define FSL_SOC_USB_AGECNTTHRSH =A0 =A0 =A0 =A00x408 =A0 /* NOTE: big-=
endian */
> diff --git a/drivers/usb/host/ehci-mem.c b/drivers/usb/host/ehci-mem.c
> index 1f3f01e..d36e4e7 100644
> --- a/drivers/usb/host/ehci-mem.c
> +++ b/drivers/usb/host/ehci-mem.c
> @@ -40,7 +40,7 @@ static inline void ehci_qtd_init(struct ehci_hcd *ehci,=
 struct ehci_qtd *qtd,
> =A0{
> =A0 =A0 =A0 =A0memset (qtd, 0, sizeof *qtd);
> =A0 =A0 =A0 =A0qtd->qtd_dma =3D dma;
> - =A0 =A0 =A0 qtd->hw_token =3D cpu_to_le32 (QTD_STS_HALT);
> + =A0 =A0 =A0 qtd->hw_token =3D cpu_to_hc32(ehci, QTD_STS_HALT);
> =A0 =A0 =A0 =A0qtd->hw_next =3D EHCI_LIST_END(ehci);
> =A0 =A0 =A0 =A0qtd->hw_alt_next =3D EHCI_LIST_END(ehci);
> =A0 =A0 =A0 =A0INIT_LIST_HEAD (&qtd->qtd_list);
> diff --git a/drivers/usb/host/fsl-mph-dr-of.c b/drivers/usb/host/fsl-mph-=
dr-of.c
> index 020a939..0ced9fc 100644
> --- a/drivers/usb/host/fsl-mph-dr-of.c
> +++ b/drivers/usb/host/fsl-mph-dr-of.c
> @@ -14,6 +14,7 @@
> =A0#include <linux/fsl_devices.h>
> =A0#include <linux/io.h>
> =A0#include <linux/of_platform.h>
> +#include <linux/clk.h>
>
> =A0struct fsl_usb2_dev_data {
> =A0 =A0 =A0 =A0char *dr_mode; =A0 =A0 =A0 =A0 =A0/* controller mode */
> @@ -146,6 +147,12 @@ static int __devinit fsl_usb2_mph_dr_of_probe(struct=
 of_device *ofdev,
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pdata->operating_mode =3D FSL_USB2_MPH_HOS=
T;
> =A0 =A0 =A0 =A0} else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (of_get_property(np, "fsl,invert-drvvbus=
", NULL))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->invert_drvvbus =3D 1=
;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (of_get_property(np, "fsl,invert-pwr-fau=
lt", NULL))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->invert_pwr_fault =3D=
 1;
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* setup mode selected in the device tree =
*/
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pdata->operating_mode =3D dev_data->op_mod=
e;
> =A0 =A0 =A0 =A0}
> @@ -167,9 +174,91 @@ static int __devinit fsl_usb2_mph_dr_of_probe(struct=
 of_device *ofdev,
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> +#ifdef CONFIG_PPC_MPC512x
> +
> +#define USBGENCTRL =A0 =A0 =A0 =A0 =A0 =A0 0x200 =A0 =A0 =A0 =A0 =A0 /* =
NOTE: big endian */
> +#define GC_WU_INT_CLR =A0 =A0 =A0 =A0 =A0(1 << 5) =A0 =A0 =A0 =A0/* Wake=
up int clear */
> +#define GC_ULPI_SEL =A0 =A0 =A0 =A0 =A0 =A0(1 << 4) =A0 =A0 =A0 =A0/* UL=
PI i/f select (usb0 only)*/
> +#define GC_PPP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 3) =A0 =A0 =A0 =A0/=
* Inv. Port Power Polarity */
> +#define GC_PFP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 2) =A0 =A0 =A0 =A0/=
* Inv. Power Fault Polarity */
> +#define GC_WU_ULPI_EN =A0 =A0 =A0 =A0 =A0(1 << 1) =A0 =A0 =A0 =A0/* Wake=
up on ULPI event */
> +#define GC_WU_IE =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 1) =A0 =A0 =A0 =A0/* =
Wakeup interrupt enable */
> +
> +#define ISIPHYCTRL =A0 =A0 =A0 =A0 =A0 =A0 0x204 =A0 =A0 =A0 =A0 =A0 /* =
NOTE: big endian */
> +#define PHYCTRL_PHYE =A0 =A0 =A0 =A0 =A0 (1 << 4) =A0 =A0 =A0 =A0/* On-c=
hip UTMI PHY enable */
> +#define PHYCTRL_BSENH =A0 =A0 =A0 =A0 =A0(1 << 3) =A0 =A0 =A0 =A0/* Bit =
Stuff Enable High */
> +#define PHYCTRL_BSEN =A0 =A0 =A0 =A0 =A0 (1 << 2) =A0 =A0 =A0 =A0/* Bit =
Stuff Enable */
> +#define PHYCTRL_LSFE =A0 =A0 =A0 =A0 =A0 (1 << 1) =A0 =A0 =A0 =A0/* Line=
 State Filter Enable */
> +#define PHYCTRL_PXE =A0 =A0 =A0 =A0 =A0 =A0(1 << 0) =A0 =A0 =A0 =A0/* PH=
Y oscillator enable */
> +
> +int fsl_usb2_mpc5121_init(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 struct fsl_usb2_platform_data *pdata =3D pdev->dev.platform=
_data;
> + =A0 =A0 =A0 struct clk *clk;
> + =A0 =A0 =A0 char clk_name[10];
> + =A0 =A0 =A0 int base, clk_num;
> +
> + =A0 =A0 =A0 base =3D pdev->resource->start & 0xf000;
> + =A0 =A0 =A0 if (base =3D=3D 0x3000)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_num =3D 1;
> + =A0 =A0 =A0 else if (base =3D=3D 0x4000)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_num =3D 2;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> +
> + =A0 =A0 =A0 snprintf(clk_name, sizeof(clk_name), "usb%d_clk", clk_num);
> + =A0 =A0 =A0 clk =3D clk_get(&pdev->dev, clk_name);
> + =A0 =A0 =A0 if (IS_ERR(clk)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to get clk\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PTR_ERR(clk);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 clk_enable(clk);
> + =A0 =A0 =A0 pdata->clk =3D clk;
> +
> + =A0 =A0 =A0 if (pdata->phy_mode =3D=3D FSL_USB2_PHY_UTMI_WIDE) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 reg =3D 0;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pdata->invert_drvvbus)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D GC_PPP;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pdata->invert_pwr_fault)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D GC_PFP;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(pdata->regs + ISIPHYCTRL, PHYCTRL_=
PHYE | PHYCTRL_PXE);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(pdata->regs + USBGENCTRL, reg);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static void fsl_usb2_mpc5121_exit(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 struct fsl_usb2_platform_data *pdata =3D pdev->dev.platform=
_data;
> +
> + =A0 =A0 =A0 pdata->regs =3D NULL;
> +
> + =A0 =A0 =A0 if (pdata->clk) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_disable(pdata->clk);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_put(pdata->clk);
> + =A0 =A0 =A0 }
> +}
> +
> +struct fsl_usb2_platform_data fsl_usb2_mpc5121_pd =3D {
> + =A0 =A0 =A0 .big_endian_desc =3D 1,
> + =A0 =A0 =A0 .big_endian_mmio =3D 1,
> + =A0 =A0 =A0 .es =3D 1,
> + =A0 =A0 =A0 .le_setup_buf =3D 1,
> + =A0 =A0 =A0 .init =3D fsl_usb2_mpc5121_init,
> + =A0 =A0 =A0 .exit =3D fsl_usb2_mpc5121_exit,
> +};
> +#endif /* CONFIG_PPC_MPC512x */
> +
> =A0static const struct of_device_id fsl_usb2_mph_dr_of_match[] =3D {
> =A0 =A0 =A0 =A0{ .compatible =3D "fsl-usb2-mph", },
> =A0 =A0 =A0 =A0{ .compatible =3D "fsl-usb2-dr", },
> +#ifdef CONFIG_PPC_MPC512x
> + =A0 =A0 =A0 { .compatible =3D "fsl,mpc5121-usb2-dr", .data =3D &fsl_usb=
2_mpc5121_pd, },
> +#endif
> =A0 =A0 =A0 =A0{},
> =A0};
>
> diff --git a/include/linux/fsl_devices.h b/include/linux/fsl_devices.h
> index 28e33fe..d5f9a74 100644
> --- a/include/linux/fsl_devices.h
> +++ b/include/linux/fsl_devices.h
> @@ -58,11 +58,26 @@ enum fsl_usb2_phy_modes {
> =A0 =A0 =A0 =A0FSL_USB2_PHY_SERIAL,
> =A0};
>
> +struct clk;
> +struct platform_device;
> +
> =A0struct fsl_usb2_platform_data {
> =A0 =A0 =A0 =A0/* board specific information */
> =A0 =A0 =A0 =A0enum fsl_usb2_operating_modes =A0 operating_mode;
> =A0 =A0 =A0 =A0enum fsl_usb2_phy_modes =A0 =A0 =A0 =A0 phy_mode;
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0port_e=
nables;
> +
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 (*init)(struct platform_device =
*);
> + =A0 =A0 =A0 void =A0 =A0 =A0 =A0 =A0 =A0(*exit)(struct platform_device =
*);
> + =A0 =A0 =A0 void __iomem =A0 =A0*regs; =A0 =A0 =A0 =A0 =A0/* ioremap'd =
register base */
> + =A0 =A0 =A0 struct clk =A0 =A0 =A0*clk;
> + =A0 =A0 =A0 unsigned =A0 =A0 =A0 =A0big_endian_mmio:1;
> + =A0 =A0 =A0 unsigned =A0 =A0 =A0 =A0big_endian_desc:1;
> + =A0 =A0 =A0 unsigned =A0 =A0 =A0 =A0es:1; =A0 =A0 =A0 =A0 =A0 /* need U=
SBMODE:ES */
> + =A0 =A0 =A0 unsigned =A0 =A0 =A0 =A0le_setup_buf:1;
> + =A0 =A0 =A0 unsigned =A0 =A0 =A0 =A0have_sysif_regs:1;
> + =A0 =A0 =A0 unsigned =A0 =A0 =A0 =A0invert_drvvbus:1;
> + =A0 =A0 =A0 unsigned =A0 =A0 =A0 =A0invert_pwr_fault:1;
> =A0};
>
> =A0/* Flags in fsl_usb2_mph_platform_data */
> --
> 1.7.0.4
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
