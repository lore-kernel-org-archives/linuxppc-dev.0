Return-Path: <julie.zhu@xilinx.com>
Received: from SG2EHSOBE004.bigfish.com (sg2ehsobe004.messaging.microsoft.com
	[207.46.51.78]) by ozlabs.org (Postfix) with ESMTP id 8A83CB7B65
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Sep 2009 00:57:33 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Subject: RE: [PATCH] USB: Add support for Xilinx USB host controller
Date: Mon, 21 Sep 2009 08:41:47 -0600
In-Reply-To: <fa686aa40909210714j428aa524qacc7a83f40db411b@mail.gmail.com>
References: <20090915221050.0DA0F2C005E@mail34-va3.bigfish.com>
	<fa686aa40909210714j428aa524qacc7a83f40db411b@mail.gmail.com>
From: Julie Zhu <julie.zhu@xilinx.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Message-ID: <20090921144131.1C1A31078051@mail56-sin.bigfish.com>
Cc: linux-usb@vger.kernel.org, gregkh@suse.de, linuxppc-dev@ozlabs.org,
	John Linn <linnj@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thanks, Grant and Ben,

> > Add bus glue driver for Xilinx USB host controller. The controller can
> be
> > configured as HS only or HS/FS hybrid. The driver uses the device tree
> file
> > to configure the driver according to the setting in the hardware system=
.
> >
> > This driver has been tested with usbtest using the NET2280 PCI card.
> >
> > Signed-off-by: Julie Zhu <julie.zhu@xilinx.com>
> =

> As Ben said, this is nice tight code.  Two comments below.
> =

> > +/**
> > + * ehci_xilinx_port_handed_over - hand the port out if failed to enabl=
e
> it
> > + * @hcd: =A0 =A0 =A0 Pointer to the usb_hcd device to which the host
> controller bound
> > + * @portnum:Port number to which the device is attached.
> > + *
> > + * This function is used as a place to tell the user that the Xilinx
> USB host
> > + * controller does support LS devices. And in an HS only configuration=
,
> it
> > + * does not support FS devices neither. It is hoped that this can help=

> a
> =

> s/neither/either
> =

> [...]
> > +static struct of_device_id ehci_hcd_xilinx_of_match[] =3D {
> > + =A0 =A0 =A0 {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .compatible =3D "usb-ehci",
> > + =A0 =A0 =A0 },
> =

> This looks wrong.  Since this driver only works with Xilinx USB
> controllers,
> it should be binding against "xlnx,xps-usb-host-1.00.a", and the meaning
> of
> that binding needs to be documented in Documentation/powerpc/dts-bindings=
.
> =


I have changed the compatible to "xlnx,xps-usb-host-1.00.a", thanks for cat=
ching this.

Where should I put the binding for Xilinx USB host controller? usb-ehci.txt=
 or xilinx.txt?

Thanks,
Julie.

> Having this driver bind against the generic "usb-ehci" will cause
> conflicts
> with the ehci-ppc-of driver.
> =




> Cheers,
> g.
> =

> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
