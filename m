Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f178.google.com (mail-yx0-f178.google.com
	[209.85.210.178]) by ozlabs.org (Postfix) with ESMTP id 78DB1B7B69
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Sep 2009 06:47:46 +1000 (EST)
Received: by yxe8 with SMTP id 8so4207188yxe.17
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Sep 2009 13:47:45 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20090921193821.CB9DF1620046@mail78-sin.bigfish.com>
References: <20090921193821.CB9DF1620046@mail78-sin.bigfish.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 21 Sep 2009 13:47:25 -0700
Message-ID: <fa686aa40909211347q3ce9bd74s58734ae3a55f5f80@mail.gmail.com>
Subject: Re: [PATCH] [V1] USB: Add support for Xilinx USB host controller
To: Julie Zhu <julie.zhu@xilinx.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: greg@kroah.com, linux-usb@vger.kernel.org, linuxppc-dev@ozlabs.org,
	john.linn@xilinx.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 21, 2009 at 12:38 PM, Julie Zhu <julie.zhu@xilinx.com> wrote:
> Add bus glue driver for Xilinx USB host controller. The controller can be
> configured as HS only or HS/FS hybrid. The driver uses the device tree fi=
le
> to configure the driver according to the setting in the hardware system.

Looks good, one minor nit....

> +static struct of_device_id ehci_hcd_xilinx_of_match[] =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 {.compatible =3D "xlnx,xps-usb-host-1.00.a"=
,},
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 {.compatible =3D "xlnx,xps-usb-host-1.01.a"=
,},
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 {.compatible =3D "xlnx,xps-usb-host-1.02.a"=
,},
> + =A0 =A0 =A0 {},
> +};

Ideally, 1.01 and 1.02 device tree nodes would also claim
compatibility with the original 1.00.a version (assuming of course
that it really is register level compatible) making the 2nd and 3rd
lines redundant, but that's just a minor nit and this doesn't hurt
anything.  Do what you prefer.

Acked-by: Grant Likely <grant.likely@secretlab.ca>

Cheers,
g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
