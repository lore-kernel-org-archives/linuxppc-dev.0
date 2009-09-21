Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f203.google.com (mail-yw0-f203.google.com
	[209.85.211.203]) by ozlabs.org (Postfix) with ESMTP id 4F346B7BB3
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Sep 2009 00:14:41 +1000 (EST)
Received: by ywh41 with SMTP id 41so3908533ywh.1
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Sep 2009 07:14:39 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20090915221050.0DA0F2C005E@mail34-va3.bigfish.com>
References: <20090915221050.0DA0F2C005E@mail34-va3.bigfish.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 21 Sep 2009 07:14:18 -0700
Message-ID: <fa686aa40909210714j428aa524qacc7a83f40db411b@mail.gmail.com>
Subject: Re: [PATCH] USB: Add support for Xilinx USB host controller
To: Julie Zhu <julie.zhu@xilinx.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-usb@vger.kernel.org, gregkh@suse.de, juliez@xilinx.com,
	linuxppc-dev@ozlabs.org, john.linn@xilinx.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 15, 2009 at 3:10 PM, Julie Zhu <julie.zhu@xilinx.com> wrote:
> Add bus glue driver for Xilinx USB host controller. The controller can be
> configured as HS only or HS/FS hybrid. The driver uses the device tree fi=
le
> to configure the driver according to the setting in the hardware system.
>
> This driver has been tested with usbtest using the NET2280 PCI card.
>
> Signed-off-by: Julie Zhu <julie.zhu@xilinx.com>

As Ben said, this is nice tight code.  Two comments below.

> +/**
> + * ehci_xilinx_port_handed_over - hand the port out if failed to enable =
it
> + * @hcd: =A0 =A0 =A0 Pointer to the usb_hcd device to which the host con=
troller bound
> + * @portnum:Port number to which the device is attached.
> + *
> + * This function is used as a place to tell the user that the Xilinx USB=
 host
> + * controller does support LS devices. And in an HS only configuration, =
it
> + * does not support FS devices neither. It is hoped that this can help a

s/neither/either

[...]
> +static struct of_device_id ehci_hcd_xilinx_of_match[] =3D {
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .compatible =3D "usb-ehci",
> + =A0 =A0 =A0 },

This looks wrong.  Since this driver only works with Xilinx USB controllers=
,
it should be binding against "xlnx,xps-usb-host-1.00.a", and the meaning of
that binding needs to be documented in Documentation/powerpc/dts-bindings.

Having this driver bind against the generic "usb-ehci" will cause conflicts
with the ehci-ppc-of driver.

Cheers,
g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
