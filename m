Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id AC7D0B7D48
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Apr 2010 06:28:03 +1000 (EST)
Date: Wed, 28 Apr 2010 22:28:05 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 3/3] powerpc/mpc5121: shared DIU framebuffer support
Message-ID: <20100428222805.0a1bab5d@wker>
In-Reply-To: <fa686aa41002272250j64b2d691vb41f73e1eb335c8a@mail.gmail.com>
References: <fa686aa41002161006l3b301febt94fe990df4bddfe9@mail.gmail.com>
	<1267307902-31939-4-git-send-email-agust@denx.de>
	<fa686aa41002272250j64b2d691vb41f73e1eb335c8a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, linux-fbdev@vger.kernel.org, yorksun@freescale.com,
	dzu@denx.de, wd@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Grant,

Thanks for review and comments. I'm back to this now and hope
to address your comments soon.

On Sat, 27 Feb 2010 23:50:09 -0700
Grant Likely <grant.likely@secretlab.ca> wrote:

> On Sat, Feb 27, 2010 at 2:58 PM, Anatolij Gustschin <agust@denx.de> wrote:
> > MPC5121 DIU configuration/setup as initialized by the boot
> > loader currently will get lost while booting Linux. As a
> > result displaying the boot splash is not possible through
> > the boot process.
> >
> > To prevent this we reserve configured DIU frame buffer
> > address range while booting and preserve AOI descriptor
> > and gamma table so that DIU continues displaying through
> > the whole boot process. On first open from user space
> > DIU frame buffer driver releases the reserved frame
> > buffer area and continues to operate as usual.
> >
> > The patch also moves drivers/video/fsl-diu-fb.h file to
> > include/linux as we use some DIU structures in platform
> > code.
> >
> > 'diu_ops' callbacks in platform code borrowed from John's
> > DIU code.
> >
> > Signed-off-by: John Rigby <jrigby@gmail.com>
> > Signed-off-by: Anatolij Gustschin <agust@denx.de>
> > Cc: Grant Likely <grant.likely@secretlab.ca>
>=20
> On quick glance this patch seems mostly okay, but this patch should
> probably be broken up a bit to simplify review and dissociate
> unrelated changes.  For example, the move of fsl-diu-fb.h is a
> discrete change that should be split off.  Some more comments
> below....

I will split off fsl-diu-fb.h move to separate patch.

...
> > diff --git a/arch/powerpc/platforms/512x/mpc5121_generic.c b/arch/power=
pc/platforms/512x/mpc5121_generic.c
> > index a6c0e3a..3aaa281 100644
> > --- a/arch/powerpc/platforms/512x/mpc5121_generic.c
> > +++ b/arch/powerpc/platforms/512x/mpc5121_generic.c
> > @@ -28,6 +28,7 @@
> > =C2=A0*/
> > =C2=A0static char *board[] __initdata =3D {
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0"prt,prtlvt",
> > + =C2=A0 =C2=A0 =C2=A0 "ifm,pdm360ng",
>=20
> You're adding a new board here.  This is completely unrelated.

Yes, it is unrelated. This hunk sneaked in by accident, will drop it.

...
> > diff --git a/arch/powerpc/platforms/512x/mpc512x.h b/arch/powerpc/platf=
orms/512x/mpc512x.h
> > index d72b2c7..1cfe9d5 100644
> > --- a/arch/powerpc/platforms/512x/mpc512x.h
> > +++ b/arch/powerpc/platforms/512x/mpc512x.h
> > @@ -17,4 +17,7 @@ extern int __init mpc5121_clk_init(void);
> > =C2=A0void __init mpc512x_declare_of_platform_devices(void);
> > =C2=A0extern void mpc512x_restart(char *cmd);
> > =C2=A0extern void __init mpc5121_usb_init(void);
> > +extern void __init mpc512x_init_diu(void);
> > +extern void __init mpc512x_setup_diu(void);
>=20
> __init annotations do not belong in header files.

Ok, I will remove them.

> > +extern struct fsl_diu_shared_fb diu_shared_fb;
>=20
> Hmmmm.  I'm not fond of the global data structure.  Especially
> considering that the struct fsl_diu_shared_fb is defined in
> mpc512x_shared.c, so nothing outside of that .c file can do anything
> with the structure.

This is a remainder from early debugging code, will remove it.

> > =C2=A0#endif =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* __MPC512X_H__ */
> > diff --git a/arch/powerpc/platforms/512x/mpc512x_shared.c b/arch/powerp=
c/platforms/512x/mpc512x_shared.c
> > index fbdf65f..a8c50a6 100644
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
> > @@ -53,6 +57,284 @@ void mpc512x_restart(char *cmd)
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0;
> > =C2=A0}
> >
> > +struct fsl_diu_shared_fb {
> > + =C2=A0 =C2=A0 =C2=A0 char =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ga=
mma[0x300]; =C2=A0 /* 32-bit aligned! */
> > + =C2=A0 =C2=A0 =C2=A0 struct diu_ad =C2=A0 ad0; =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0/* 32-bit aligned! */
> > + =C2=A0 =C2=A0 =C2=A0 phys_addr_t =C2=A0 =C2=A0 fb_phys;
> > + =C2=A0 =C2=A0 =C2=A0 size_t =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fb_len;
> > + =C2=A0 =C2=A0 =C2=A0 bool =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0in=
_use;
> > +};
> > +
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
> > +
> > +void mpc512x_set_gamma_table(int monitor_port, char *gamma_table_base)
> > +{
> > +}
> > +
> > +void mpc512x_set_monitor_port(int monitor_port)
> > +{
> > +}
> > +
> > +#define CCM_SCFR1 =C2=A0 =C2=A0 =C2=A00x0000000c
> > +#define DIU_DIV_MASK =C2=A0 0x000000ff
> > +void mpc512x_set_pixel_clock(unsigned int pixclock)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 unsigned long bestval, bestfreq, speed_ccb, busf=
req;
> > + =C2=A0 =C2=A0 =C2=A0 unsigned long minpixclock, maxpixclock, pixval;
> > + =C2=A0 =C2=A0 =C2=A0 struct device_node *np;
> > + =C2=A0 =C2=A0 =C2=A0 void __iomem *ccm;
> > + =C2=A0 =C2=A0 =C2=A0 u32 temp;
> > + =C2=A0 =C2=A0 =C2=A0 long err;
> > + =C2=A0 =C2=A0 =C2=A0 int i;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 np =3D of_find_compatible_node(NULL, NULL, "fsl,=
mpc5121-clock");
> > + =C2=A0 =C2=A0 =C2=A0 if (!np) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_err("Can't find c=
lock control module.\n");
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> > + =C2=A0 =C2=A0 =C2=A0 }
> > +
> > + =C2=A0 =C2=A0 =C2=A0 ccm =3D of_iomap(np, 0);
> > + =C2=A0 =C2=A0 =C2=A0 if (!ccm) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_err("Can't map cl=
ock control module reg.\n");
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 of_node_put(np);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> > + =C2=A0 =C2=A0 =C2=A0 }
> > + =C2=A0 =C2=A0 =C2=A0 of_node_put(np);
> > +
> > + =C2=A0 =C2=A0 =C2=A0 busfreq =3D 200000000;
>=20
> Instead of some hard coding some bogus defalt busfreq, you should
> error out if the real frequency cannot be determined.  Force users to
> supply a valid tree.

Ok, will fix.

...
> > +
> > + =C2=A0 =C2=A0 =C2=A0 /* Calculate the pixel clock with the smallest e=
rror */
> > + =C2=A0 =C2=A0 =C2=A0 /* calculate the following in steps to avoid ove=
rflow */
> > + =C2=A0 =C2=A0 =C2=A0 pr_debug("DIU pixclock in ps - %d\n", pixclock);
> > + =C2=A0 =C2=A0 =C2=A0 temp =3D 1;
> > + =C2=A0 =C2=A0 =C2=A0 temp *=3D 1000000000;
> > + =C2=A0 =C2=A0 =C2=A0 temp /=3D pixclock;
> > + =C2=A0 =C2=A0 =C2=A0 temp *=3D 1000;
> > + =C2=A0 =C2=A0 =C2=A0 pixclock =3D temp;
>=20
> Really?  I think you can simplify this.

Yes, will do it in the next patch.

...
> > diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
> > index 19ca1da..263f7da 100644
> > --- a/drivers/video/fsl-diu-fb.c
> > +++ b/drivers/video/fsl-diu-fb.c
> > @@ -34,7 +34,7 @@
> > =C2=A0#include <linux/of_platform.h>
> >
> > =C2=A0#include <sysdev/fsl_soc.h>
> > -#include "fsl-diu-fb.h"
> > +#include <linux/fsl-diu-fb.h>
> >
> > =C2=A0#include "ofmode.h"
> >
> > @@ -331,8 +331,11 @@ static int fsl_diu_enable_panel(struct fb_info *in=
fo)
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0if (mfbi->type !=3D MFB_TYPE_OFF) {
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0switch (mfbi->in=
dex) {
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case 0: =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 /* plane 0 */
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 if (hw->desc[0] !=3D ad->paddr)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 if (in_be32(&hw->desc[0]) !=3D ad->paddr) {
>=20
> Unrelated bugfix?  If so, please split into separate patch.
>=20
>=20
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 out_be32(&dr.diu_reg->diu_mode, 0);
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0out_be32(&hw->desc[0], ad->paddr);
>=20
> This line also looks like it needs fixing.

Will re-check it an fix.

>=20
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 out_be32(&dr.diu_reg->diu_mode, 1);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 }
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0break;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case 1: =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 /* plane 1 AOI 0 */
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0cmfbi =3D machine_data->fsl_diu_info[2]->par;
> > @@ -391,7 +394,7 @@ static int fsl_diu_disable_panel(struct fb_info *in=
fo)
> >
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0switch (mfbi->index) {
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0case 0: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 /* plane 0 */
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (hw->desc[0] !=3D=
 machine_data->dummy_ad->paddr)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (in_be32(&hw->des=
c[0]) !=3D machine_data->dummy_ad->paddr)
>=20
> Same bugfix?

Will re-check it, too.

>=20
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0out_be32(&hw->desc[0],
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0machine_data->dummy_ad->paddr);
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;
> > @@ -1102,6 +1105,10 @@ static int fsl_diu_open(struct fb_info *info, in=
t user)
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0struct mfb_info *mfbi =3D info->par;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0int res =3D 0;
> >
> > + =C2=A0 =C2=A0 =C2=A0 /* free boot splash memory on first /dev/fb0 ope=
n */
> > + =C2=A0 =C2=A0 =C2=A0 if (!mfbi->index && diu_ops.release_bootmem)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diu_ops.release_boot=
mem();
> > +
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock(&diu_lock);
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0mfbi->count++;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0if (mfbi->count =3D=3D 1) {
> > @@ -1436,6 +1443,7 @@ static int __devinit fsl_diu_probe(struct of_devi=
ce *ofdev,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0int ret, i, error =3D 0;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0struct resource res;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0struct fsl_diu_data *machine_data;
> > + =C2=A0 =C2=A0 =C2=A0 int diu_mode;
> >
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0machine_data =3D kzalloc(sizeof(struct fsl_d=
iu_data), GFP_KERNEL);
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!machine_data)
> > @@ -1472,7 +1480,9 @@ static int __devinit fsl_diu_probe(struct of_devi=
ce *ofdev,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto error2;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> >
> > - =C2=A0 =C2=A0 =C2=A0 out_be32(&dr.diu_reg->diu_mode, 0); =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* disable DIU anyway*/
> > + =C2=A0 =C2=A0 =C2=A0 diu_mode =3D in_be32(&dr.diu_reg->diu_mode);
> > + =C2=A0 =C2=A0 =C2=A0 if (diu_mode !=3D MFB_MODE1)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 out_be32(&dr.diu_reg=
->diu_mode, 0); =C2=A0 =C2=A0 /* disable DIU */
>=20
> Is this the best approach?  Would it be better to make this decision
> based on a property in the device tree?

I don't think it is worth it. The driver disables the DIU
regardless of it is enabled or not and enables it later
using a dummy descriptor. We just prevent this disabling
if the DIU is pre-initialized and already displaying.

> >
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Get the IRQ of the DIU */
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0machine_data->irq =3D irq_of_parse_and_map(n=
p, 0);
> > @@ -1520,7 +1530,12 @@ static int __devinit fsl_diu_probe(struct of_dev=
ice *ofdev,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0machine_data->dummy_ad->offset_xyd =3D 0;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0machine_data->dummy_ad->next_ad =3D 0;
> >
> > - =C2=A0 =C2=A0 =C2=A0 out_be32(&dr.diu_reg->desc[0], machine_data->dum=
my_ad->paddr);
> > + =C2=A0 =C2=A0 =C2=A0 /* Let DIU display splash screen if it was pre-i=
nitialized
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0* by the bootloader, set dummy area descri=
ptor otherwise.
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> > + =C2=A0 =C2=A0 =C2=A0 if (diu_mode !=3D MFB_MODE1)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 out_be32(&dr.diu_reg=
->desc[0], machine_data->dummy_ad->paddr);
> > +
>=20
> Same as above.
>=20
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0out_be32(&dr.diu_reg->desc[1], machine_data-=
>dummy_ad->paddr);
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0out_be32(&dr.diu_reg->desc[2], machine_data-=
>dummy_ad->paddr);
> >
>=20
>=20
>=20

Thanks,
Anatolij
