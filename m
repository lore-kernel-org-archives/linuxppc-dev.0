Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 163E4B7D45
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Apr 2010 20:19:51 +1000 (EST)
Date: Fri, 30 Apr 2010 12:19:47 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Timur Tabi <timur.tabi@gmail.com>
Subject: Re: [PATCH 3/5] powerpc/mpc5121: shared DIU framebuffer support
Message-ID: <20100430121947.1d265ca6@wker>
In-Reply-To: <s2ted82fe3e1004291905mf562f0cbi24054bb973aa2dbb@mail.gmail.com>
References: <1272584978-19063-1-git-send-email-agust@denx.de>
	<1272584978-19063-4-git-send-email-agust@denx.de>
	<s2ted82fe3e1004291905mf562f0cbi24054bb973aa2dbb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-fbdev@vger.kernel.org, wd@denx.de, dzu@denx.de,
	John Rigby <jrigby@gmail.com>,
	devicetree-discuss@lists.ozlabs.org, linuxppc-dev@ozlabs.org,
	yorksun@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 29 Apr 2010 21:05:26 -0500
Timur Tabi <timur.tabi@gmail.com> wrote:

> On Thu, Apr 29, 2010 at 6:49 PM, Anatolij Gustschin <agust@denx.de> wrote:
>=20
>=20
> > +void __init mpc5121_ads_init_early(void)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 mpc512x_init_diu();
> > +}
> > +
> > =C2=A0define_machine(mpc5121_ads) {
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0.name =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =3D "MPC5121 ADS",
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0.probe =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D mpc5121_ads_probe,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0.setup_arch =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =3D mpc5121_ads_setup_arch,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0.init =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =3D mpc512x_init,
> > + =C2=A0 =C2=A0 =C2=A0 .init_early =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =3D mpc5121_ads_init_early,
>=20
> How about just doing this?
>=20
> .init_early             =3D mpc512x_init_diu,

I thought it should be prepared for adding other code here.
mpc5121_ads_init_early() is generic and could contain other
things as well. I would vote for current version.

> > +void __init mpc512x_generic_init_early(void)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 mpc512x_init_diu();
> > +}
> > +
> > +void __init mpc512x_generic_setup_arch(void)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 mpc512x_setup_diu();
> > +}
> > +
> > =C2=A0define_machine(mpc5121_generic) {
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0.name =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =3D "MPC5121 generic",
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0.probe =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D mpc5121_generic_probe,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0.init =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =3D mpc512x_init,
> > + =C2=A0 =C2=A0 =C2=A0 .init_early =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =3D mpc512x_generic_init_early,
> > + =C2=A0 =C2=A0 =C2=A0 .setup_arch =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =3D mpc512x_generic_setup_arch,
>=20
> And a similar change here.

Same here.

...
> > diff --git a/arch/powerpc/platforms/512x/mpc512x_shared.c b/arch/powerp=
c/platforms/512x/mpc512x_shared.c
> > index b7f518a..8e297fa 100644
> > --- a/arch/powerpc/platforms/512x/mpc512x_shared.c
> > +++ b/arch/powerpc/platforms/512x/mpc512x_shared.c
> > @@ -16,7 +16,11 @@
> > =C2=A0#include <linux/io.h>
> > =C2=A0#include <linux/irq.h>
> > =C2=A0#include <linux/of_platform.h>
> > +#include <linux/fsl-diu-fb.h>
> > +#include <linux/bootmem.h>
> > +#include <sysdev/fsl_soc.h>
> >
> > +#include <asm/cacheflush.h>
> > =C2=A0#include <asm/machdep.h>
> > =C2=A0#include <asm/ipic.h>
> > =C2=A0#include <asm/prom.h>
> > @@ -53,6 +57,286 @@ void mpc512x_restart(char *cmd)
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0;
> > =C2=A0}
> >
> > +struct fsl_diu_shared_fb {
> > + =C2=A0 =C2=A0 =C2=A0 char =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ga=
mma[0x300]; =C2=A0 /* 32-bit aligned! */
>=20
> char or u8?

Will use u8.

> > + =C2=A0 =C2=A0 =C2=A0 struct diu_ad =C2=A0 ad0; =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0/* 32-bit aligned! */
> > + =C2=A0 =C2=A0 =C2=A0 phys_addr_t =C2=A0 =C2=A0 fb_phys;
> > + =C2=A0 =C2=A0 =C2=A0 size_t =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fb_len;
> > + =C2=A0 =C2=A0 =C2=A0 bool =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0in=
_use;
> > +};
>=20
> Where did "bool" come from?  Use "int" instead.

It is common practise to use "bool" type, grep in drivers dir.

> > +unsigned int mpc512x_get_pixel_format(unsigned int bits_per_pixel,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int monitor_port)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 unsigned int pix_fmt;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 switch (bits_per_pixel) {
> > + =C2=A0 =C2=A0 =C2=A0 case 32:
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pix_fmt =3D 0x888833=
16;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> > + =C2=A0 =C2=A0 =C2=A0 case 24:
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pix_fmt =3D 0x880822=
19;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> > + =C2=A0 =C2=A0 =C2=A0 case 16:
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pix_fmt =3D 0x650531=
18;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> > + =C2=A0 =C2=A0 =C2=A0 default:
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pix_fmt =3D 0x000004=
00;
> > + =C2=A0 =C2=A0 =C2=A0 }
> > + =C2=A0 =C2=A0 =C2=A0 return pix_fmt;
> > +}
>=20
> This is simpler:
>=20
>        switch (bits_per_pixel) {
>        case 32:
>                return 0x88883316;
>        case 24:
>                return 0x88082219;
>        case 16:
>                return =3D 0x65053118;
>       }
>=20
>       return 0x00000400;
> }

Will simplify as suggested, thanks!

> > + =C2=A0 =C2=A0 =C2=A0 ccm =3D of_iomap(np, 0);
> > + =C2=A0 =C2=A0 =C2=A0 if (!ccm) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_err("Can't map cl=
ock control module reg.\n");
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 of_node_put(np);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> > + =C2=A0 =C2=A0 =C2=A0 }
> > + =C2=A0 =C2=A0 =C2=A0 of_node_put(np);
>=20
> This is simpler:
>=20
>        ccm =3D of_iomap(np, 0);
>        of_node_put(np);
>        if (!ccm) {
>                pr_err("Can't map clock control module reg.\n");
>                return;
>        }

OK, will fix, thanks.

>=20
> > + =C2=A0 =C2=A0 =C2=A0 np =3D of_find_node_by_type(NULL, "cpu");
> > + =C2=A0 =C2=A0 =C2=A0 if (np) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int size;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const unsigned int *=
prop =3D
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 of_get_property(np, "bus-frequency", &size);
>=20
> Since you don't use 'size', you can skip it:
>=20
>               const unsigned int *prop =3D
>                       of_get_property(np, "bus-frequency", NULL);
>=20
> > + =C2=A0 =C2=A0 =C2=A0 } else {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_err("Can't find \=
"cpu\" node.\n");
>=20
> 'cpu' is simpler than \"cpu\"

Will simplify, too.

> > + =C2=A0 =C2=A0 =C2=A0 /* Calculate the pixel clock with the smallest e=
rror */
> > + =C2=A0 =C2=A0 =C2=A0 /* calculate the following in steps to avoid ove=
rflow */
> > + =C2=A0 =C2=A0 =C2=A0 pr_debug("DIU pixclock in ps - %d\n", pixclock);
> > + =C2=A0 =C2=A0 =C2=A0 temp =3D (1000000000 / pixclock) * 1000;
>=20
> I'm pretty sure the compiler will optimize this to:
>=20
>     temp =3D (1000000000000UL / pixclock);
>=20
> so you may as well do it that way.

??
1000000000000 is _not_ UL, but UUL.

>=20
> > + =C2=A0 =C2=A0 =C2=A0 pixclock =3D temp;
> > + =C2=A0 =C2=A0 =C2=A0 pr_debug("DIU pixclock freq - %u\n", pixclock);
> > +
> > + =C2=A0 =C2=A0 =C2=A0 temp =3D (temp * 5) / 100; /* pixclock * 0.05 */
>=20
> The compiler will optimize this to:
>=20
>     temp /=3D 20;

Can do it, too. Thanks.

> > + =C2=A0 =C2=A0 =C2=A0 pr_debug("deviation =3D %d\n", temp);
> > + =C2=A0 =C2=A0 =C2=A0 minpixclock =3D pixclock - temp;
> > + =C2=A0 =C2=A0 =C2=A0 maxpixclock =3D pixclock + temp;
> > + =C2=A0 =C2=A0 =C2=A0 pr_debug("DIU minpixclock - %lu\n", minpixclock);
> > + =C2=A0 =C2=A0 =C2=A0 pr_debug("DIU maxpixclock - %lu\n", maxpixclock);
> > + =C2=A0 =C2=A0 =C2=A0 pixval =3D speed_ccb/pixclock;
> > + =C2=A0 =C2=A0 =C2=A0 pr_debug("DIU pixval =3D %lu\n", pixval);
> > +
> > + =C2=A0 =C2=A0 =C2=A0 err =3D 100000000;
>=20
> Why do you assign err to this arbitrary value?

Dunno. It is Freescale's code and I do not have time to check
and understand each bit of it and to explain it.

> > + =C2=A0 =C2=A0 =C2=A0 bestval =3D pixval;
> > + =C2=A0 =C2=A0 =C2=A0 pr_debug("DIU bestval =3D %lu\n", bestval);
> > +
> > + =C2=A0 =C2=A0 =C2=A0 bestfreq =3D 0;
> > + =C2=A0 =C2=A0 =C2=A0 for (i =3D -1; i <=3D 1; i++) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 temp =3D speed_ccb /=
 (pixval+i);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_debug("DIU test p=
ixval i=3D%d, pixval=3D%lu, temp freq. =3D %u\n",
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 i, pixval, temp);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((temp < minpixcl=
ock) || (temp > maxpixclock))
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 pr_debug("DIU exceeds monitor range (%lu to %lu)\n",
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 minpixclock, maxpixclock);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (abs(temp - =
pixclock) < err) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 pr_debug("Entered the else if block %d\n", i);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 err =3D abs(temp - pixclock);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 bestval =3D pixval + i;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 bestfreq =3D temp;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> > + =C2=A0 =C2=A0 =C2=A0 }
> > +
> > + =C2=A0 =C2=A0 =C2=A0 pr_debug("DIU chose =3D %lx\n", bestval);
> > + =C2=A0 =C2=A0 =C2=A0 pr_debug("DIU error =3D %ld\n NomPixClk ", err);
> > + =C2=A0 =C2=A0 =C2=A0 pr_debug("DIU: Best Freq =3D %lx\n", bestfreq);
> > + =C2=A0 =C2=A0 =C2=A0 /* Modify DIU_DIV in CCM SCFR1 */
> > + =C2=A0 =C2=A0 =C2=A0 temp =3D in_be32(ccm + CCM_SCFR1);
>=20
> Don't use offsets like + CCM_SCFR1.  Create a structure and use that inst=
ead.

Done in next patch version.

> > + =C2=A0 =C2=A0 =C2=A0 pr_debug("DIU: Current value of SCFR1: 0x%08x\n"=
, temp);
> > + =C2=A0 =C2=A0 =C2=A0 temp &=3D ~DIU_DIV_MASK;
> > + =C2=A0 =C2=A0 =C2=A0 temp |=3D (bestval & DIU_DIV_MASK);
> > + =C2=A0 =C2=A0 =C2=A0 out_be32(ccm + CCM_SCFR1, temp);
> > + =C2=A0 =C2=A0 =C2=A0 pr_debug("DIU: Modified value of SCFR1: 0x%08x\n=
", temp);
> > + =C2=A0 =C2=A0 =C2=A0 iounmap(ccm);
> > +}
> > +
> > +ssize_t mpc512x_show_monitor_port(int monitor_port, char *buf)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 return snprintf(buf, PAGE_SIZE, "0 - 5121 LCD\n"=
);
>=20
> There's no point in using snprintf since you're printing a string
> literal.  You can use sprintf.

Will do, thanks.

> > +}
> > +
> > +int mpc512x_set_sysfs_monitor_port(int val)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 return 0;
> > +}
> > +
> > +static struct fsl_diu_shared_fb __attribute__ ((__aligned__(8))) diu_s=
hared_fb;
> > +
> > +#if defined(CONFIG_FB_FSL_DIU) || \
> > + =C2=A0 =C2=A0defined(CONFIG_FB_FSL_DIU_MODULE)
> > +static inline void mpc512x_free_bootmem(struct page *page)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 __ClearPageReserved(page);
> > + =C2=A0 =C2=A0 =C2=A0 BUG_ON(PageTail(page));
> > + =C2=A0 =C2=A0 =C2=A0 BUG_ON(atomic_read(&page->_count) > 1);
> > + =C2=A0 =C2=A0 =C2=A0 atomic_set(&page->_count, 1);
> > + =C2=A0 =C2=A0 =C2=A0 __free_page(page);
> > + =C2=A0 =C2=A0 =C2=A0 totalram_pages++;
> > +}
> > +
> > +void mpc512x_release_bootmem(void)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 unsigned long addr =3D diu_shared_fb.fb_phys & P=
AGE_MASK;
> > + =C2=A0 =C2=A0 =C2=A0 unsigned long size =3D diu_shared_fb.fb_len;
> > + =C2=A0 =C2=A0 =C2=A0 unsigned long start, end;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 if (diu_shared_fb.in_use) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 start =3D PFN_UP(add=
r);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 end =3D PFN_DOWN(add=
r + size);
> > +
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (; start < end; =
start++)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 mpc512x_free_bootmem(pfn_to_page(start));
> > +
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diu_shared_fb.in_use=
 =3D false;
> > + =C2=A0 =C2=A0 =C2=A0 }
> > + =C2=A0 =C2=A0 =C2=A0 diu_ops.release_bootmem =3D NULL;
> > +}
> > +#endif
>=20
> Do you really need to use reserve_bootmem?  Have you tried kmalloc or
> alloc_pages_exact()?

Yes. No, it is too early to use them here.

> > +
> > +/*
> > + * Check if DIU was pre-initialized. If so, perform steps
> > + * needed to continue displaying through the whole boot process.
> > + * Move area descriptor and gamma table elsewhere, they are
> > + * destroyed by bootmem allocator otherwise. The frame buffer
> > + * address range will be reserved in setup_arch() after bootmem
> > + * allocator is up.
> > + */
> > +void __init mpc512x_init_diu(void)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 struct device_node *np;
> > + =C2=A0 =C2=A0 =C2=A0 void __iomem *diu_reg;
> > + =C2=A0 =C2=A0 =C2=A0 phys_addr_t desc;
> > + =C2=A0 =C2=A0 =C2=A0 void __iomem *vaddr;
> > + =C2=A0 =C2=A0 =C2=A0 unsigned long mode, pix_fmt, res, bpp;
> > + =C2=A0 =C2=A0 =C2=A0 unsigned long dst;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 np =3D of_find_compatible_node(NULL, NULL, "fsl,=
mpc5121-diu");
> > + =C2=A0 =C2=A0 =C2=A0 if (!np) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_err("No DIU node\=
n");
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> > + =C2=A0 =C2=A0 =C2=A0 }
>=20
> Shouldn't you be probing as an OF driver instead of manually searching
> for the DIU node?

No, not here.

> > +
> > + =C2=A0 =C2=A0 =C2=A0 diu_reg =3D of_iomap(np, 0);
> > + =C2=A0 =C2=A0 =C2=A0 of_node_put(np);
> > + =C2=A0 =C2=A0 =C2=A0 if (!diu_reg) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_err("Can't map DI=
U\n");
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> > + =C2=A0 =C2=A0 =C2=A0 }
> > +
> > + =C2=A0 =C2=A0 =C2=A0 mode =3D in_be32(diu_reg + 0x1c);
> > + =C2=A0 =C2=A0 =C2=A0 if (mode !=3D 1) {
>=20
> How can in_be32() return a -1?

It is a 1, not -1. I will use appropriate macro here and also
change to use a struct instead of adding offset to register base.

Thanks for your review and comments!
Anatolij
