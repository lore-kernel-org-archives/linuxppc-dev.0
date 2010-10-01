Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id A259FB6F0D
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  2 Oct 2010 06:46:26 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH v2 03/10] RapidIO: Use stored ingress port number instead
	of register read
Date: Fri, 1 Oct 2010 13:46:06 -0700
Message-ID: <0CE8B6BE3C4AD74AB97D9D29BD24E5520137C432@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <4C97C6D8.4010407@neli.hopto.org>
References: <1284476363-1677-1-git-send-email-alexandre.bounine@idt.com><1284476363-1677-4-git-send-email-alexandre.bounine@idt.com>
	<20100914151219.5d92c6f9.akpm@linux-foundation.org>
	<0CE8B6BE3C4AD74AB97D9D29BD24E55201303D0E@CORPEXCH1.na.ads.idt.com>
	<4C97C6D8.4010407@neli.hopto.org>
From: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
To: "Micha Nelissen" <micha@neli.hopto.org>
Cc: linux-kernel@vger.kernel.org, Thomas Moll <thomas.moll@sysgo.com>,
	Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Micha,

Sorry for delayed reply.

Micha Nelissen <micha@neli.hopto.org> wrote:
>=20
> Bounine, Alexandre wrote:
> > struct rio_dev {
> >     struct list_head global_list;
> >     struct list_head net_list;
> >     .....
> >     ..... rest of rio_dev
> >     .....
> >     struct rio_switch switch[0];
> > }
>=20
> It makes sense to let rio_dev structures point to the switch they are
> attached to. That can be useful in various situations, but is not
> possible with this setup.
>=20
> If a rio_dev is a switch then rdev->rswitch->rdev =3D=3D rdev holds.
>

But the switch is a RIO device itself and all other parts of rio_dev
structure
are applicable to it as well. If there is situation when a device=20
needs to hold a pointer to the attached switch that should be a pointer
to the switch rio_dev and not to its switch-specific extension.=20
=20
> > This will remove extra memory allocation, remove overlapping
structure
> > members and clean code sections like one shown below:
> >
> > 	u8 hopcount =3D 0xff;
> > 	u16 destid =3D rdev->destid;
> >
> > 	if (rdev->rswitch) {
> > 		destid =3D rdev->rswitch->destid;
> > 		hopcount =3D rdev->rswitch->hopcount;
> > 	}
>=20
> Note that it is possible for rdev->destid to differ from
> rdev->rswitch->destid even if rswitch->rdev =3D=3D rdev (for non-hosts
i.e.
> agents). rswitch->destid is the destid by which we discovered the
switch
> (and can reach it) but rdev->destid is the actual id given to the
switch.
>=20

My goal is to have one destid storage for device - endpoint or switch.
And destid should be used only for one purpose: to reach corresponding
device.
In your statement above you suggest using rdev->destid instead of
rswitch->switchid.
RIO switches do not have any specific RIO ID that can be assigned to the
switch.
In this case the rswitch->switchid should work well for logical
identification
of the switch.

I think if (for switch) we load rdev->destid with some function
different
from its routing role this may bring unnecessary confusion.

I also will move rswitch->hopcount to rdev->hopcount. For endpoint it
will be set
to 0xff during rio_dev initialization.

Alex.
      =20
