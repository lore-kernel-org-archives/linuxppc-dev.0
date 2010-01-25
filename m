Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 14F4D1007E0
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Jan 2010 04:00:27 +1100 (EST)
Date: Mon, 25 Jan 2010 18:00:24 +0100
From: Anatolij Gustschin <agust@denx.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 08/11] powerpc/mpc5121: add USB host support
Message-ID: <20100125180024.1a850578@wker>
In-Reply-To: <fa686aa41001210943i3739f693uecf0c05ef0a81c1@mail.gmail.com>
References: <1263932653-3634-1-git-send-email-agust@denx.de>
	<1263932653-3634-9-git-send-email-agust@denx.de>
	<fa686aa41001210943i3739f693uecf0c05ef0a81c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org,
	devicetree-discuss <devicetree-discuss@lists.ozlabs.org>,
	linux-usb@vger.kernel.org, wd@denx.de, dzu@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 21 Jan 2010 10:43:34 -0700
Grant Likely <grant.likely@secretlab.ca> wrote:

> > diff --git a/Documentation/powerpc/dts-bindings/fsl/usb.txt b/Documenta=
tion/powerpc/dts-bindings/fsl/usb.txt
> > index b001524..9050154 100644
> > --- a/Documentation/powerpc/dts-bindings/fsl/usb.txt
> > +++ b/Documentation/powerpc/dts-bindings/fsl/usb.txt
> > @@ -33,6 +33,14 @@ Recommended properties :
> > =C2=A0- interrupt-parent : the phandle for the interrupt controller that
> > =C2=A0 =C2=A0services interrupts for this device.
> >
> > +Optional properties :
>=20
> > + - big-endian-regs : boolean; if defined, indicates the USB host
> > + =C2=A0 controller registers format is big endian.
>=20
> Rather than testing for this explicitly, add fsl,mpc5121-usb2-dr to
> the match table and use the .data pointer for setting device specific
> quirks.

There is no match table. fsl_usb_of_init() is an arch_initcall and
tests other properties using the same approach.

> > + - invert-drvvbus : boolean; for MPC5121 only. Indicates the port
> > + =C2=A0 power polarity of internal PHY signal DRVVBUS is inverted.
> > + - invert-pwr-fault : boolean; for MPC5121 only. Indicates the
> > + =C2=A0 PWR_FAULT signal polarity is inverted.
>=20
> These are also characteristics of the chip, not the board, right?  If
> so then these also can be determined implicitly by the compatible
> value.

No, these are characteristics of the board. The internal USB PHY doesn't
provide supply voltage. Some boards use MIC2025 switches which require acti=
ve
high DRVVBUS and active low PWR_FAULT. Some boards could use MIC2026 or
MAX1838 which require other polarities.

> Finally, these are all freescale specific properties.  If you still
> need them, then prefix the property names with 'fsl,'

OK.

> > ...
> > +
> > +config USB_FSL_BIG_ENDIAN_MMIO
> > + =C2=A0 =C2=A0 =C2=A0 bool
>=20
> What's this for?

This is currently unused (will be used later), I will remove it for now.

> > ...
> > @@ -77,14 +77,13 @@ static int usb_hcd_fsl_probe(const struct hc_driver=
 *driver,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENODEV;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> >
> > - =C2=A0 =C2=A0 =C2=A0 res =3D platform_get_resource(pdev, IORESOURCE_I=
RQ, 0);
> > - =C2=A0 =C2=A0 =C2=A0 if (!res) {
> > + =C2=A0 =C2=A0 =C2=A0 irq =3D platform_get_irq(pdev, 0);
> > + =C2=A0 =C2=A0 =C2=A0 if (irq < 0) {
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(&pdev->d=
ev,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0"Found HC with no IRQ. Check %s setup!\n",
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0dev_name(&pdev->dev));
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENODEV;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> > - =C2=A0 =C2=A0 =C2=A0 irq =3D res->start;
>=20
> Put this hunk in a separate patch.

OK.

> > ...
> > + =C2=A0 =C2=A0 =C2=A0 if (pdata->have_sysif_regs) {
> > =C2=A0#ifdef CONFIG_PPC_85xx
> > - =C2=A0 =C2=A0 =C2=A0 out_be32(non_ehci + FSL_SOC_USB_PRICTRL, 0x00000=
008);
> > - =C2=A0 =C2=A0 =C2=A0 out_be32(non_ehci + FSL_SOC_USB_AGECNTTHRSH, 0x0=
0000080);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 out_be32(non_ehci + =
FSL_SOC_USB_PRICTRL, 0x00000008);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 out_be32(non_ehci + =
FSL_SOC_USB_AGECNTTHRSH, 0x00000080);
> > =C2=A0#else
> > - =C2=A0 =C2=A0 =C2=A0 out_be32(non_ehci + FSL_SOC_USB_PRICTRL, 0x00000=
00c);
> > - =C2=A0 =C2=A0 =C2=A0 out_be32(non_ehci + FSL_SOC_USB_AGECNTTHRSH, 0x0=
0000040);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 out_be32(non_ehci + =
FSL_SOC_USB_PRICTRL, 0x0000000c);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 out_be32(non_ehci + =
FSL_SOC_USB_AGECNTTHRSH, 0x00000040);
> > =C2=A0#endif
> > - =C2=A0 =C2=A0 =C2=A0 out_be32(non_ehci + FSL_SOC_USB_SICTRL, 0x000000=
01);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 out_be32(non_ehci + =
FSL_SOC_USB_SICTRL, 0x00000001);
> > + =C2=A0 =C2=A0 =C2=A0 }
> > =C2=A0}
>=20
> Unrelated whitespace changes.  Put in separate patch.

OK.

Thanks,

Anatolij
