Return-Path: <glikely@secretlab.ca>
Received: from mail-pv0-f170.google.com (mail-pv0-f170.google.com
	[74.125.83.170]) by ozlabs.org (Postfix) with ESMTP id CEC07B7DE0
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Apr 2010 03:13:01 +1000 (EST)
Received: by pvg6 with SMTP id 6so1641749pvg.15
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Apr 2010 10:13:00 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1272384698-4359-3-git-send-email-agust@denx.de>
References: <1272384698-4359-1-git-send-email-agust@denx.de>
	<1272384698-4359-3-git-send-email-agust@denx.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 27 Apr 2010 11:12:39 -0600
Message-ID: <x2rfa686aa41004271012g1d1e4bacw6808da96e1ad2210@mail.gmail.com>
Subject: Re: [PATCH 2/4] powerpc/mpc5121: add USB host support
To: Anatolij Gustschin <agust@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Wolfgang Denk <wd@denx.de>,
	Detlev Zundel <dzu@denx.de>, devicetree-discuss@lists.ozlabs.org,
	linux-usb@vger.kernel.org, linuxppc-dev@ozlabs.org,
	David Brownell <dbrownell@users.sourceforge.net>,
	Bruce Schmid <duck@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 27, 2010 at 10:11 AM, Anatolij Gustschin <agust@denx.de> wrote:
> Platform specific code for MPC5121 USB Host support.
>
> The patch also contains changes to FSL EHCI platform driver
> needed to support MPC5121 USB controllers. MPC5121 Rev 2.0
> silicon EHCI registers are in big endian format. The
> appropriate flags are set using the information in the
> platform data structure. 83xx system interface registers
> are not available on 512x, so the access to these registers
> is isolated for 512x. Furthermore the USB controller clock
> must be enabled before 512x register access which is done
> by providing platform specific init callback.
>
> The 512x internal USB PHY doesn't provide supply voltage.
> For boards using different power switches allow specifying
> DRVVBUS and PWR_FAULT signal polarity of the MPC5121 internal
> PHY using "fsl,invert-drvvbus" and "fsl,invert-pwr-fault"
> properties in the device tree USB node.
>
> Signed-off-by: Bruce Schmid <duck@freescale.com>
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> Cc: David Brownell <dbrownell@users.sourceforge.net>
> Cc: Greg Kroah-Hartman <gregkh@suse.de>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Kumar Gala <galak@kernel.crashing.org>
> Cc: devicetree-discuss@lists.ozlabs.org
> ---
> =A0Documentation/powerpc/dts-bindings/fsl/usb.txt | =A0 22 ++++
> =A0arch/powerpc/platforms/512x/Kconfig =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A03 =
+
> =A0arch/powerpc/platforms/512x/Makefile =A0 =A0 =A0 =A0 =A0 | =A0 =A02 +-
> =A0arch/powerpc/platforms/512x/mpc5121_usb.c =A0 =A0 =A0| =A0131 ++++++++=
++++++++++++++++
> =A0arch/powerpc/platforms/512x/mpc512x.h =A0 =A0 =A0 =A0 =A0| =A0 =A01 +
> =A0arch/powerpc/platforms/512x/mpc512x_shared.c =A0 | =A0 =A01 +
> =A0arch/powerpc/sysdev/fsl_soc.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 20 ++++
> =A0arch/powerpc/sysdev/fsl_soc.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 =A09 ++
> =A0drivers/usb/host/ehci-fsl.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0111 +++++++++++++++------
> =A0drivers/usb/host/ehci-fsl.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 19 ++++-
> =A0drivers/usb/host/ehci-mem.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 =A02 +-
> =A0include/linux/fsl_devices.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 13 +++
> =A012 files changed, 301 insertions(+), 33 deletions(-)
> =A0create mode 100644 arch/powerpc/platforms/512x/mpc5121_usb.c
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

This modification to the device binding looks fine to me.

Cheers,
g.
