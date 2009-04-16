Return-Path: <glikely@secretlab.ca>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.24])
	by ozlabs.org (Postfix) with ESMTP id D2F03DE132
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Apr 2009 05:01:58 +1000 (EST)
Received: by qw-out-2122.google.com with SMTP id 9so519230qwb.15
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Apr 2009 12:01:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090416163021.023DC770050@mail77-va3.bigfish.com>
References: <20090416163021.023DC770050@mail77-va3.bigfish.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 16 Apr 2009 13:01:42 -0600
Message-ID: <fa686aa40904161201i4c4a59alc68ca0fc75a6b316@mail.gmail.com>
Subject: Re: [PATCH] [V4] Xilinx : Framebuffer Driver: Add PLB support and
	cleanup DCR
To: John Linn <john.linn@xilinx.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com,
	Suneel <suneelg@xilinx.com>, linuxppc-dev@ozlabs.org,
	akonovalov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 16, 2009 at 10:26 AM, John Linn <john.linn@xilinx.com> wrote:
> Added support for the new xps tft controller. The new core
> has PLB interface support in addition to existing DCR interface.
>
> Removed platform device support as both MicroBlaze and PowerPC
> use device tree.
>
> Previously, the dcr interface was assumed to be used in mmio mode,
> and the register space of the dcr interface was precomputed and stuffed
> into the device tree. This driver now makes use of the new dcr
> infrastructure to represent the dcr interface. This enables the dcr
> interface to be connected directly to a native dcr interface in a clean
> way.
>
> Added compatibility for ml507 dvi core.
>
> Signed-off-by: Suneel <suneelg@xilinx.com>
> Signed-off-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
> Signed-off-by: John Linn <john.linn@xilinx.com>
> ---
>
> V2 - cleanup based on review
> V3 - update to be based on top of tree rather than Xilinx tree, sorry for=
 the
> =A0confusion with this, update the name of the patch slightly to be more =
accurate
> V4 - update based on Grant's comments to simplify it, the binding wasn't =
changed
> =A0as the conversation seemed to verify it's acceptable

Actually Stephen and I agreed that the driver should *not* go looking
for the xlnx,dcr-splb-slave-if property.  reg and dcr-reg are
sufficient.  If a driver has both properties, then either method of
access will work.


> @@ -107,12 +112,21 @@ static struct fb_var_screeninfo xilinx_fb_var =3D {
> =A0 =A0 =A0 =A0.activate =3D =A0 =A0 FB_ACTIVATE_NOW
> =A0};
>
> +
> +#define PLB_ACCESS_FLAG =A0 =A0 =A0 =A00x1 =A0 =A0 =A0 =A0 =A0 =A0 /* 1 =
=3D PLB, 0 =3D DCR */
> +

Also, this define is no longer required.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
