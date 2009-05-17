Return-Path: <krzysztof.h1@poczta.fm>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239]) by ozlabs.org (Postfix) with ESMTP id 136C2DE057
	for <linuxppc-dev@ozlabs.org>; Sun, 17 May 2009 20:20:51 +1000 (EST)
Date: Sun, 17 May 2009 12:26:44 +0200
From: Krzysztof Helt <krzysztof.h1@poczta.fm>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [Linux-fbdev-devel] [PATCH] fbdev: Add PLB support and cleanup
	DCR in xilinxfb driver.
Message-Id: <20090517122644.f537f500.krzysztof.h1@poczta.fm>
In-Reply-To: <10f740e80905170125ie1c1aew441de30874e6a72f@mail.gmail.com>
References: <20090515181237.22961.64270.stgit@localhost.localdomain>
	<20090517100643.9d00e980.krzysztof.h1@poczta.fm>
	<10f740e80905170125ie1c1aew441de30874e6a72f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-fbdev-devel@lists.sourceforge.net,
	Antonino Daplas <adaplas@gmail.com>, Suneel <suneelg@xilinx.com>,
	linuxppc-dev@ozlabs.org, John Linn <john.linn@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 17 May 2009 10:25:31 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> On Sun, May 17, 2009 at 10:06, Krzysztof Helt <krzysztof.h1@poczta.fm> wr=
ote:
> > On Fri, 15 May 2009 12:19:17 -0600 Grant Likely <grant.likely@secretlab=
.ca> wrote:
> >> diff --git a/drivers/video/xilinxfb.c b/drivers/video/xilinxfb.c
> >> index 40a3a2a..7a868bd 100644
> >> --- a/drivers/video/xilinxfb.c
> >> +++ b/drivers/video/xilinxfb.c
> >> @@ -107,17 +111,28 @@ static struct fb_var_screeninfo xilinx_fb_var =
=3D {
> >> =A0 =A0 =A0 .activate =3D =A0 =A0 FB_ACTIVATE_NOW
> >> =A0};
> >>
> >> +
> >> +#define PLB_ACCESS_FLAG =A0 =A0 =A00x1 =A0 =A0 =A0 =A0 =A0 =A0 /* 1 =
=3D PLB, 0 =3D DCR */
> >> +
> >> =A0struct xilinxfb_drvdata {
> >>
> >> =A0 =A0 =A0 struct fb_info =A0info; =A0 =A0 =A0 =A0 =A0 /* FB driver i=
nfo record */
> >>
> >> - =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 regs_phys; =A0 =A0 =A0/* phys. a=
ddress of the control registers */
> >> - =A0 =A0 u32 __iomem =A0 =A0 *regs; =A0 =A0 =A0 =A0 =A0/* virt. addre=
ss of the control registers */
> >> + =A0 =A0 phys_addr_t =A0 =A0 regs_phys; =A0 =A0 =A0/* phys. address o=
f the control
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 registers */
> >
> > There are fields fb_info.fix.mmio_start and fb_info.fix.mmio_len for
> > physical IO range used by framebuffer. There is no field for
> > virtual IO address so the "regs" below must stay.
>=20
> If I'm not mistaken, this driver is used on ppc44x, where phys_addr_t is =
64-bit,
> so the 32-bit unsigned long fb_info.fix.mmio_start is not large enough
> to hold the
> physical address.
>=20

If so please ignore my comment.

Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>

Regards,
Krzysztof

----------------------------------------------------------------------
Dzwonki na komorkê!
Sprawdz >> http://link.interia.pl/f2161
