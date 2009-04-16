Return-Path: <John.Linn@xilinx.com>
Received: from WA4EHSOBE006.bigfish.com (wa4ehsobe005.messaging.microsoft.com
	[216.32.181.15]) by ozlabs.org (Postfix) with ESMTP id 6B7CBDE171
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Apr 2009 05:53:09 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Subject: RE: [PATCH] [V4] Xilinx : Framebuffer Driver: Add PLB support and
	cleanup DCR
Date: Thu, 16 Apr 2009 13:51:37 -0600
In-Reply-To: <fa686aa40904161201i4c4a59alc68ca0fc75a6b316@mail.gmail.com>
References: <20090416163021.023DC770050@mail77-va3.bigfish.com>
	<fa686aa40904161201i4c4a59alc68ca0fc75a6b316@mail.gmail.com>
From: John Linn <John.Linn@xilinx.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Message-ID: <20090416195304.2050112E804D@mail140-wa4.bigfish.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com,
	Stephen Neuendorffer <stephenn@xilinx.com>,
	Suneel Garapati <suneelg@xilinx.com>, linuxppc-dev@ozlabs.org,
	akonovalov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sounds good, I'll spin it again with those changes.

-- John

> -----Original Message-----
> From: Grant Likely [mailto:grant.likely@secretlab.ca]
> Sent: Thursday, April 16, 2009 1:02 PM
> To: John Linn
> Cc: linuxppc-dev@ozlabs.org; linux-fbdev-devel@lists.sourceforge.net; ako=
novalov@ru.mvista.com;
> adaplas@gmail.com; jwboyer@linux.vnet.ibm.com; Suneel Garapati; Stephen N=
euendorffer
> Subject: Re: [PATCH] [V4] Xilinx : Framebuffer Driver: Add PLB support an=
d cleanup DCR
> =

> On Thu, Apr 16, 2009 at 10:26 AM, John Linn <john.linn@xilinx.com> wrote:=

> > Added support for the new xps tft controller. The new core
> > has PLB interface support in addition to existing DCR interface.
> >
> > Removed platform device support as both MicroBlaze and PowerPC
> > use device tree.
> >
> > Previously, the dcr interface was assumed to be used in mmio mode,
> > and the register space of the dcr interface was precomputed and stuffed=

> > into the device tree. This driver now makes use of the new dcr
> > infrastructure to represent the dcr interface. This enables the dcr
> > interface to be connected directly to a native dcr interface in a clean=

> > way.
> >
> > Added compatibility for ml507 dvi core.
> >
> > Signed-off-by: Suneel <suneelg@xilinx.com>
> > Signed-off-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
> > Signed-off-by: John Linn <john.linn@xilinx.com>
> > ---
> >
> > V2 - cleanup based on review
> > V3 - update to be based on top of tree rather than Xilinx tree, sorry f=
or the
> > =A0confusion with this, update the name of the patch slightly to be mor=
e accurate
> > V4 - update based on Grant's comments to simplify it, the binding wasn'=
t changed
> > =A0as the conversation seemed to verify it's acceptable
> =

> Actually Stephen and I agreed that the driver should *not* go looking
> for the xlnx,dcr-splb-slave-if property.  reg and dcr-reg are
> sufficient.  If a driver has both properties, then either method of
> access will work.
> =

> =

> > @@ -107,12 +112,21 @@ static struct fb_var_screeninfo xilinx_fb_var =3D=
 {
> > =A0 =A0 =A0 =A0.activate =3D =A0 =A0 FB_ACTIVATE_NOW
> > =A0};
> >
> > +
> > +#define PLB_ACCESS_FLAG =A0 =A0 =A0 =A00x1 =A0 =A0 =A0 =A0 =A0 =A0 /* =
1 =3D PLB, 0 =3D DCR */
> > +
> =

> Also, this define is no longer required.
> =

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
