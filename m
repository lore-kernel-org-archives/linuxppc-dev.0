Return-Path: <glikely@secretlab.ca>
Received: from mail-gw0-f42.google.com (mail-gw0-f42.google.com [74.125.83.42])
	by ozlabs.org (Postfix) with ESMTP id 09AEFB7D24
	for <linuxppc-dev@ozlabs.org>; Sun, 28 Feb 2010 17:50:30 +1100 (EST)
Received: by gwj20 with SMTP id 20so747015gwj.15
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Feb 2010 22:50:29 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1267307902-31939-4-git-send-email-agust@denx.de>
References: <fa686aa41002161006l3b301febt94fe990df4bddfe9@mail.gmail.com>
	<1267307902-31939-4-git-send-email-agust@denx.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sat, 27 Feb 2010 23:50:09 -0700
Message-ID: <fa686aa41002272250j64b2d691vb41f73e1eb335c8a@mail.gmail.com>
Subject: Re: [PATCH 3/3] powerpc/mpc5121: shared DIU framebuffer support
To: Anatolij Gustschin <agust@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-fbdev@vger.kernel.org, wd@denx.de, dzu@denx.de, jrigby@gmail.com,
	linuxppc-dev@ozlabs.org, yorksun@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Feb 27, 2010 at 2:58 PM, Anatolij Gustschin <agust@denx.de> wrote:
> MPC5121 DIU configuration/setup as initialized by the boot
> loader currently will get lost while booting Linux. As a
> result displaying the boot splash is not possible through
> the boot process.
>
> To prevent this we reserve configured DIU frame buffer
> address range while booting and preserve AOI descriptor
> and gamma table so that DIU continues displaying through
> the whole boot process. On first open from user space
> DIU frame buffer driver releases the reserved frame
> buffer area and continues to operate as usual.
>
> The patch also moves drivers/video/fsl-diu-fb.h file to
> include/linux as we use some DIU structures in platform
> code.
>
> 'diu_ops' callbacks in platform code borrowed from John's
> DIU code.
>
> Signed-off-by: John Rigby <jrigby@gmail.com>
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> Cc: Grant Likely <grant.likely@secretlab.ca>

On quick glance this patch seems mostly okay, but this patch should
probably be broken up a bit to simplify review and dissociate
unrelated changes.  For example, the move of fsl-diu-fb.h is a
discrete change that should be split off.  Some more comments
below....

> ---
> =A0arch/powerpc/platforms/512x/mpc5121_ads.c =A0 =A0 | =A0 =A07 +
> =A0arch/powerpc/platforms/512x/mpc5121_generic.c | =A0 13 ++
> =A0arch/powerpc/platforms/512x/mpc512x.h =A0 =A0 =A0 =A0 | =A0 =A03 +
> =A0arch/powerpc/platforms/512x/mpc512x_shared.c =A0| =A0282 +++++++++++++=
++++++++++++
> =A0arch/powerpc/sysdev/fsl_soc.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =
=A01 +
> =A0drivers/video/fsl-diu-fb.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 25 ++-
> =A0drivers/video/fsl-diu-fb.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0223 -------------------
> =A0include/linux/fsl-diu-fb.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0223 +++++++++++++++++++
> =A08 files changed, 549 insertions(+), 228 deletions(-)
> =A0delete mode 100644 drivers/video/fsl-diu-fb.h
> =A0create mode 100644 include/linux/fsl-diu-fb.h
>
> diff --git a/arch/powerpc/platforms/512x/mpc5121_ads.c b/arch/powerpc/pla=
tforms/512x/mpc5121_ads.c
> index ee6ae12..aa4d5a8 100644
> --- a/arch/powerpc/platforms/512x/mpc5121_ads.c
> +++ b/arch/powerpc/platforms/512x/mpc5121_ads.c
> @@ -42,6 +42,7 @@ static void __init mpc5121_ads_setup_arch(void)
> =A0 =A0 =A0 =A0for_each_compatible_node(np, "pci", "fsl,mpc5121-pci")
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mpc83xx_add_bridge(np);
> =A0#endif
> + =A0 =A0 =A0 mpc512x_setup_diu();
> =A0}
>
> =A0static void __init mpc5121_ads_init_IRQ(void)
> @@ -60,11 +61,17 @@ static int __init mpc5121_ads_probe(void)
> =A0 =A0 =A0 =A0return of_flat_dt_is_compatible(root, "fsl,mpc5121ads");
> =A0}
>
> +void __init mpc5121_ads_init_early(void)
> +{
> + =A0 =A0 =A0 mpc512x_init_diu();
> +}
> +
> =A0define_machine(mpc5121_ads) {
> =A0 =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D "MPC5121 ADS=
",
> =A0 =A0 =A0 =A0.probe =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D mpc5121_ads_=
probe,
> =A0 =A0 =A0 =A0.setup_arch =A0 =A0 =A0 =A0 =A0 =A0 =3D mpc5121_ads_setup_=
arch,
> =A0 =A0 =A0 =A0.init =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D mpc512x_init=
,
> + =A0 =A0 =A0 .init_early =A0 =A0 =A0 =A0 =A0 =A0 =3D mpc5121_ads_init_ea=
rly,
> =A0 =A0 =A0 =A0.init_IRQ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D mpc5121_ads_init=
_IRQ,
> =A0 =A0 =A0 =A0.get_irq =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D ipic_get_irq,
> =A0 =A0 =A0 =A0.calibrate_decr =A0 =A0 =A0 =A0 =3D generic_calibrate_decr=
,
> diff --git a/arch/powerpc/platforms/512x/mpc5121_generic.c b/arch/powerpc=
/platforms/512x/mpc5121_generic.c
> index a6c0e3a..3aaa281 100644
> --- a/arch/powerpc/platforms/512x/mpc5121_generic.c
> +++ b/arch/powerpc/platforms/512x/mpc5121_generic.c
> @@ -28,6 +28,7 @@
> =A0*/
> =A0static char *board[] __initdata =3D {
> =A0 =A0 =A0 =A0"prt,prtlvt",
> + =A0 =A0 =A0 "ifm,pdm360ng",

You're adding a new board here.  This is completely unrelated.

> =A0 =A0 =A0 =A0NULL
> =A0};
>
> @@ -48,10 +49,22 @@ static int __init mpc5121_generic_probe(void)
> =A0 =A0 =A0 =A0return board[i] !=3D NULL;
> =A0}
>
> +void __init mpc512x_generic_init_early(void)
> +{
> + =A0 =A0 =A0 mpc512x_init_diu();
> +}
> +
> +void __init mpc512x_generic_setup_arch(void)
> +{
> + =A0 =A0 =A0 mpc512x_setup_diu();
> +}
> +
> =A0define_machine(mpc5121_generic) {
> =A0 =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D "MPC5121 gen=
eric",
> =A0 =A0 =A0 =A0.probe =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D mpc5121_gene=
ric_probe,
> =A0 =A0 =A0 =A0.init =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D mpc512x_init=
,
> + =A0 =A0 =A0 .init_early =A0 =A0 =A0 =A0 =A0 =A0 =3D mpc512x_generic_ini=
t_early,
> + =A0 =A0 =A0 .setup_arch =A0 =A0 =A0 =A0 =A0 =A0 =3D mpc512x_generic_set=
up_arch,
> =A0 =A0 =A0 =A0.init_IRQ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D mpc512x_init_IRQ=
,
> =A0 =A0 =A0 =A0.get_irq =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D ipic_get_irq,
> =A0 =A0 =A0 =A0.calibrate_decr =A0 =A0 =A0 =A0 =3D generic_calibrate_decr=
,
> diff --git a/arch/powerpc/platforms/512x/mpc512x.h b/arch/powerpc/platfor=
ms/512x/mpc512x.h
> index d72b2c7..1cfe9d5 100644
> --- a/arch/powerpc/platforms/512x/mpc512x.h
> +++ b/arch/powerpc/platforms/512x/mpc512x.h
> @@ -17,4 +17,7 @@ extern int __init mpc5121_clk_init(void);
> =A0void __init mpc512x_declare_of_platform_devices(void);
> =A0extern void mpc512x_restart(char *cmd);
> =A0extern void __init mpc5121_usb_init(void);
> +extern void __init mpc512x_init_diu(void);
> +extern void __init mpc512x_setup_diu(void);

__init annotations do not belong in header files.

> +extern struct fsl_diu_shared_fb diu_shared_fb;

Hmmmm.  I'm not fond of the global data structure.  Especially
considering that the struct fsl_diu_shared_fb is defined in
mpc512x_shared.c, so nothing outside of that .c file can do anything
with the structure.

> =A0#endif =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* __MPC512X_H_=
_ */
> diff --git a/arch/powerpc/platforms/512x/mpc512x_shared.c b/arch/powerpc/=
platforms/512x/mpc512x_shared.c
> index fbdf65f..a8c50a6 100644
> --- a/arch/powerpc/platforms/512x/mpc512x_shared.c
> +++ b/arch/powerpc/platforms/512x/mpc512x_shared.c
> @@ -16,7 +16,11 @@
> =A0#include <linux/io.h>
> =A0#include <linux/irq.h>
> =A0#include <linux/of_platform.h>
> +#include <linux/fsl-diu-fb.h>
> +#include <linux/bootmem.h>
> +#include <sysdev/fsl_soc.h>
>
> +#include <asm/cacheflush.h>
> =A0#include <asm/machdep.h>
> =A0#include <asm/ipic.h>
> =A0#include <asm/prom.h>
> @@ -53,6 +57,284 @@ void mpc512x_restart(char *cmd)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0;
> =A0}
>
> +struct fsl_diu_shared_fb {
> + =A0 =A0 =A0 char =A0 =A0 =A0 =A0 =A0 =A0gamma[0x300]; =A0 /* 32-bit ali=
gned! */
> + =A0 =A0 =A0 struct diu_ad =A0 ad0; =A0 =A0 =A0 =A0 =A0 =A0/* 32-bit ali=
gned! */
> + =A0 =A0 =A0 phys_addr_t =A0 =A0 fb_phys;
> + =A0 =A0 =A0 size_t =A0 =A0 =A0 =A0 =A0fb_len;
> + =A0 =A0 =A0 bool =A0 =A0 =A0 =A0 =A0 =A0in_use;
> +};
> +
> +unsigned int mpc512x_get_pixel_format(unsigned int bits_per_pixel,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 int monitor_port)
> +{
> + =A0 =A0 =A0 unsigned int pix_fmt;
> +
> + =A0 =A0 =A0 switch (bits_per_pixel) {
> + =A0 =A0 =A0 case 32:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pix_fmt =3D 0x88883316;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case 24:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pix_fmt =3D 0x88082219;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case 16:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pix_fmt =3D 0x65053118;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pix_fmt =3D 0x00000400;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return pix_fmt;
> +}
> +
> +void mpc512x_set_gamma_table(int monitor_port, char *gamma_table_base)
> +{
> +}
> +
> +void mpc512x_set_monitor_port(int monitor_port)
> +{
> +}
> +
> +#define CCM_SCFR1 =A0 =A0 =A00x0000000c
> +#define DIU_DIV_MASK =A0 0x000000ff
> +void mpc512x_set_pixel_clock(unsigned int pixclock)
> +{
> + =A0 =A0 =A0 unsigned long bestval, bestfreq, speed_ccb, busfreq;
> + =A0 =A0 =A0 unsigned long minpixclock, maxpixclock, pixval;
> + =A0 =A0 =A0 struct device_node *np;
> + =A0 =A0 =A0 void __iomem *ccm;
> + =A0 =A0 =A0 u32 temp;
> + =A0 =A0 =A0 long err;
> + =A0 =A0 =A0 int i;
> +
> + =A0 =A0 =A0 np =3D of_find_compatible_node(NULL, NULL, "fsl,mpc5121-clo=
ck");
> + =A0 =A0 =A0 if (!np) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("Can't find clock control module.\n"=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 ccm =3D of_iomap(np, 0);
> + =A0 =A0 =A0 if (!ccm) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("Can't map clock control module reg.=
\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_node_put(np);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 of_node_put(np);
> +
> + =A0 =A0 =A0 busfreq =3D 200000000;

Instead of some hard coding some bogus defalt busfreq, you should
error out if the real frequency cannot be determined.  Force users to
supply a valid tree.

> + =A0 =A0 =A0 np =3D of_find_node_by_type(NULL, "cpu");
> + =A0 =A0 =A0 if (np) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int size;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 const unsigned int *prop =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_get_property(np, "bus-fr=
equency", &size);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (prop)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 busfreq =3D *prop;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_node_put(np);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Pixel Clock configuration */
> + =A0 =A0 =A0 pr_debug("DIU: Bus Frequency =3D %lu\n", busfreq);
> + =A0 =A0 =A0 speed_ccb =3D busfreq * 4;
> +
> + =A0 =A0 =A0 /* Calculate the pixel clock with the smallest error */
> + =A0 =A0 =A0 /* calculate the following in steps to avoid overflow */
> + =A0 =A0 =A0 pr_debug("DIU pixclock in ps - %d\n", pixclock);
> + =A0 =A0 =A0 temp =3D 1;
> + =A0 =A0 =A0 temp *=3D 1000000000;
> + =A0 =A0 =A0 temp /=3D pixclock;
> + =A0 =A0 =A0 temp *=3D 1000;
> + =A0 =A0 =A0 pixclock =3D temp;

Really?  I think you can simplify this.

> + =A0 =A0 =A0 pr_debug("DIU pixclock freq - %u\n", pixclock);
> +
> + =A0 =A0 =A0 temp *=3D 5;
> + =A0 =A0 =A0 temp /=3D 100; =A0/* pixclock * 0.05 */
> + =A0 =A0 =A0 pr_debug("deviation =3D %d\n", temp);
> + =A0 =A0 =A0 minpixclock =3D pixclock - temp;
> + =A0 =A0 =A0 maxpixclock =3D pixclock + temp;
> + =A0 =A0 =A0 pr_debug("DIU minpixclock - %lu\n", minpixclock);
> + =A0 =A0 =A0 pr_debug("DIU maxpixclock - %lu\n", maxpixclock);
> + =A0 =A0 =A0 pixval =3D speed_ccb/pixclock;
> + =A0 =A0 =A0 pr_debug("DIU pixval =3D %lu\n", pixval);
> +
> + =A0 =A0 =A0 err =3D 100000000;
> + =A0 =A0 =A0 bestval =3D pixval;
> + =A0 =A0 =A0 pr_debug("DIU bestval =3D %lu\n", bestval);
> +
> + =A0 =A0 =A0 bestfreq =3D 0;
> + =A0 =A0 =A0 for (i =3D -1; i <=3D 1; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp =3D speed_ccb / (pixval+i);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("DIU test pixval i=3D%d, pixval=3D=
%lu, temp freq. =3D %u\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i, pixval, temp);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((temp < minpixclock) || (temp > maxpixc=
lock))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("DIU exceeds monit=
or range (%lu to %lu)\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 minpixclock=
, maxpixclock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (abs(temp - pixclock) < err) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("Entered the else =
if block %d\n", i);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D abs(temp - pixclock=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bestval =3D pixval + i;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bestfreq =3D temp;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 pr_debug("DIU chose =3D %lx\n", bestval);
> + =A0 =A0 =A0 pr_debug("DIU error =3D %ld\n NomPixClk ", err);
> + =A0 =A0 =A0 pr_debug("DIU: Best Freq =3D %lx\n", bestfreq);
> + =A0 =A0 =A0 /* Modify DIU_DIV in CCM SCFR1 */
> + =A0 =A0 =A0 temp =3D in_be32(ccm + CCM_SCFR1);
> + =A0 =A0 =A0 pr_debug("DIU: Current value of SCFR1: 0x%08x\n", temp);
> + =A0 =A0 =A0 temp &=3D ~DIU_DIV_MASK;
> + =A0 =A0 =A0 temp |=3D (bestval & DIU_DIV_MASK);
> + =A0 =A0 =A0 out_be32(ccm + CCM_SCFR1, temp);
> + =A0 =A0 =A0 pr_debug("DIU: Modified value of SCFR1: 0x%08x\n", temp);
> + =A0 =A0 =A0 iounmap(ccm);
> +}
> +
> +ssize_t mpc512x_show_monitor_port(int monitor_port, char *buf)
> +{
> + =A0 =A0 =A0 return snprintf(buf, PAGE_SIZE, "0 - 5121 LCD\n");
> +}
> +
> +int mpc512x_set_sysfs_monitor_port(int val)
> +{
> + =A0 =A0 =A0 return 0;
> +}
> +
> +struct fsl_diu_shared_fb __attribute__ ((__aligned__(8))) diu_shared_fb;
> +EXPORT_SYMBOL_GPL(diu_shared_fb);
> +
> +#if defined(CONFIG_FB_FSL_DIU) || \
> + =A0 =A0defined(CONFIG_FB_FSL_DIU_MODULE)
> +static inline void mpc512x_free_bootmem(struct page *page)
> +{
> + =A0 =A0 =A0 __ClearPageReserved(page);
> + =A0 =A0 =A0 BUG_ON(PageTail(page));
> + =A0 =A0 =A0 BUG_ON(atomic_read(&page->_count) > 1);
> + =A0 =A0 =A0 atomic_set(&page->_count, 1);
> + =A0 =A0 =A0 __free_page(page);
> + =A0 =A0 =A0 totalram_pages++;
> +}
> +
> +void mpc512x_release_bootmem(void)
> +{
> + =A0 =A0 =A0 unsigned long addr =3D diu_shared_fb.fb_phys & PAGE_MASK;
> + =A0 =A0 =A0 unsigned long size =3D diu_shared_fb.fb_len;
> + =A0 =A0 =A0 unsigned long start, end;
> +
> + =A0 =A0 =A0 if (diu_shared_fb.in_use) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 start =3D PFN_UP(addr);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 end =3D PFN_DOWN(addr + size);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (; start < end; start++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc512x_free_bootmem(pfn_to=
_page(start));
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 diu_shared_fb.in_use =3D false;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 diu_ops.release_bootmem =3D NULL;
> +}
> +#endif
> +
> +/*
> + * Check if DIU was pre-initialized. If so, perform steps
> + * needed to continue displaying through the whole boot process.
> + * Move area descriptor and gamma table elsewhere, they are
> + * destroyed by bootmem allocator otherwise. The frame buffer
> + * address range will be reserved in setup_arch() after bootmem
> + * allocator is up.
> + */
> +void __init mpc512x_init_diu(void)
> +{
> + =A0 =A0 =A0 struct device_node *np;
> + =A0 =A0 =A0 void __iomem *diu_reg;
> + =A0 =A0 =A0 phys_addr_t desc;
> + =A0 =A0 =A0 void __iomem *vaddr;
> + =A0 =A0 =A0 unsigned long mode, pix_fmt, res, bpp;
> + =A0 =A0 =A0 unsigned long dst;
> +
> + =A0 =A0 =A0 np =3D of_find_compatible_node(NULL, NULL, "fsl,mpc5121-diu=
");
> + =A0 =A0 =A0 if (!np) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("No DIU node\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 diu_reg =3D of_iomap(np, 0);
> + =A0 =A0 =A0 of_node_put(np);
> + =A0 =A0 =A0 if (!diu_reg) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("Can't map DIU\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 mode =3D in_be32(diu_reg + 0x1c);
> + =A0 =A0 =A0 if (mode !=3D 1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_info("%s: DIU OFF\n", __func__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 desc =3D in_be32(diu_reg);
> + =A0 =A0 =A0 vaddr =3D ioremap(desc, sizeof(struct diu_ad));
> + =A0 =A0 =A0 if (!vaddr) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("Can't map DIU area desc.\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 memcpy(&diu_shared_fb.ad0, vaddr, sizeof(struct diu_ad));
> + =A0 =A0 =A0 /* flush fb area descriptor */
> + =A0 =A0 =A0 dst =3D (unsigned long)&diu_shared_fb.ad0;
> + =A0 =A0 =A0 flush_dcache_range(dst, dst + sizeof(struct diu_ad) - 1);
> +
> + =A0 =A0 =A0 res =3D in_be32(diu_reg + 0x28);
> + =A0 =A0 =A0 pix_fmt =3D in_le32(vaddr);
> + =A0 =A0 =A0 bpp =3D ((pix_fmt >> 16) & 0x3) + 1;
> + =A0 =A0 =A0 diu_shared_fb.fb_phys =3D in_le32(vaddr + 4);
> + =A0 =A0 =A0 diu_shared_fb.fb_len =3D ((res & 0xfff0000) >> 16) * (res &=
 0xfff) * bpp;
> + =A0 =A0 =A0 diu_shared_fb.in_use =3D true;
> + =A0 =A0 =A0 iounmap(vaddr);
> +
> + =A0 =A0 =A0 desc =3D in_be32(diu_reg + 0xc);
> + =A0 =A0 =A0 vaddr =3D ioremap(desc, sizeof(diu_shared_fb.gamma));
> + =A0 =A0 =A0 if (!vaddr) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("Can't map DIU area desc.\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 diu_shared_fb.in_use =3D false;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 memcpy(&diu_shared_fb.gamma, vaddr, sizeof(diu_shared_fb.ga=
mma));
> + =A0 =A0 =A0 /* flush gamma table */
> + =A0 =A0 =A0 dst =3D (unsigned long)&diu_shared_fb.gamma;
> + =A0 =A0 =A0 flush_dcache_range(dst, dst + sizeof(diu_shared_fb.gamma) -=
 1);
> +
> + =A0 =A0 =A0 iounmap(vaddr);
> + =A0 =A0 =A0 out_be32(diu_reg + 0xc, virt_to_phys(&diu_shared_fb.gamma))=
;
> + =A0 =A0 =A0 out_be32(diu_reg + 4, 0);
> + =A0 =A0 =A0 out_be32(diu_reg + 8, 0);
> + =A0 =A0 =A0 out_be32(diu_reg, virt_to_phys(&diu_shared_fb.ad0));
> +
> +out:
> + =A0 =A0 =A0 iounmap(diu_reg);
> +}
> +
> +void __init mpc512x_setup_diu(void)
> +{
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 if (diu_shared_fb.in_use) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D reserve_bootmem(diu_shared_fb.fb_ph=
ys,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 diu_shared_fb.fb_len,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 BOOTMEM_EXCLUSIVE);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: reserve bootmem=
 failed\n", __func__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 diu_shared_fb.in_use =3D fa=
lse;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> +#if defined(CONFIG_FB_FSL_DIU) || \
> + =A0 =A0defined(CONFIG_FB_FSL_DIU_MODULE)
> + =A0 =A0 =A0 diu_ops.get_pixel_format =A0 =A0 =A0 =A0=3D mpc512x_get_pix=
el_format;
> + =A0 =A0 =A0 diu_ops.set_gamma_table =A0 =A0 =A0 =A0 =3D mpc512x_set_gam=
ma_table;
> + =A0 =A0 =A0 diu_ops.set_monitor_port =A0 =A0 =A0 =A0=3D mpc512x_set_mon=
itor_port;
> + =A0 =A0 =A0 diu_ops.set_pixel_clock =A0 =A0 =A0 =A0 =3D mpc512x_set_pix=
el_clock;
> + =A0 =A0 =A0 diu_ops.show_monitor_port =A0 =A0 =A0 =3D mpc512x_show_moni=
tor_port;
> + =A0 =A0 =A0 diu_ops.set_sysfs_monitor_port =A0=3D mpc512x_set_sysfs_mon=
itor_port;
> + =A0 =A0 =A0 diu_ops.release_bootmem =A0 =A0 =A0 =A0 =3D mpc512x_release=
_bootmem;
> +#endif
> +}
> +
> =A0void __init mpc512x_init_IRQ(void)
> =A0{
> =A0 =A0 =A0 =A0struct device_node *np;
> diff --git a/arch/powerpc/sysdev/fsl_soc.h b/arch/powerpc/sysdev/fsl_soc.=
h
> index 19754be..346057d 100644
> --- a/arch/powerpc/sysdev/fsl_soc.h
> +++ b/arch/powerpc/sysdev/fsl_soc.h
> @@ -30,6 +30,7 @@ struct platform_diu_data_ops {
> =A0 =A0 =A0 =A0void (*set_pixel_clock) (unsigned int pixclock);
> =A0 =A0 =A0 =A0ssize_t (*show_monitor_port) (int monitor_port, char *buf)=
;
> =A0 =A0 =A0 =A0int (*set_sysfs_monitor_port) (int val);
> + =A0 =A0 =A0 void (*release_bootmem) (void);
> =A0};
>
> =A0extern struct platform_diu_data_ops diu_ops;
> diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
> index 19ca1da..263f7da 100644
> --- a/drivers/video/fsl-diu-fb.c
> +++ b/drivers/video/fsl-diu-fb.c
> @@ -34,7 +34,7 @@
> =A0#include <linux/of_platform.h>
>
> =A0#include <sysdev/fsl_soc.h>
> -#include "fsl-diu-fb.h"
> +#include <linux/fsl-diu-fb.h>
>
> =A0#include "ofmode.h"
>
> @@ -331,8 +331,11 @@ static int fsl_diu_enable_panel(struct fb_info *info=
)
> =A0 =A0 =A0 =A0if (mfbi->type !=3D MFB_TYPE_OFF) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0switch (mfbi->index) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case 0: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 /* plane 0 */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (hw->desc[0] !=3D ad->pa=
ddr)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (in_be32(&hw->desc[0]) !=
=3D ad->paddr) {

Unrelated bugfix?  If so, please split into separate patch.


> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(&d=
r.diu_reg->diu_mode, 0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0out_be32(&=
hw->desc[0], ad->paddr);

This line also looks like it needs fixing.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(&d=
r.diu_reg->diu_mode, 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case 1: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 /* plane 1 AOI 0 */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cmfbi =3D machine_data->fs=
l_diu_info[2]->par;
> @@ -391,7 +394,7 @@ static int fsl_diu_disable_panel(struct fb_info *info=
)
>
> =A0 =A0 =A0 =A0switch (mfbi->index) {
> =A0 =A0 =A0 =A0case 0: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 /* plane 0 */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (hw->desc[0] !=3D machine_data->dummy_ad=
->paddr)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (in_be32(&hw->desc[0]) !=3D machine_data=
->dummy_ad->paddr)

Same bugfix?

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0out_be32(&hw->desc[0],
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0machine_da=
ta->dummy_ad->paddr);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> @@ -1102,6 +1105,10 @@ static int fsl_diu_open(struct fb_info *info, int =
user)
> =A0 =A0 =A0 =A0struct mfb_info *mfbi =3D info->par;
> =A0 =A0 =A0 =A0int res =3D 0;
>
> + =A0 =A0 =A0 /* free boot splash memory on first /dev/fb0 open */
> + =A0 =A0 =A0 if (!mfbi->index && diu_ops.release_bootmem)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 diu_ops.release_bootmem();
> +
> =A0 =A0 =A0 =A0spin_lock(&diu_lock);
> =A0 =A0 =A0 =A0mfbi->count++;
> =A0 =A0 =A0 =A0if (mfbi->count =3D=3D 1) {
> @@ -1436,6 +1443,7 @@ static int __devinit fsl_diu_probe(struct of_device=
 *ofdev,
> =A0 =A0 =A0 =A0int ret, i, error =3D 0;
> =A0 =A0 =A0 =A0struct resource res;
> =A0 =A0 =A0 =A0struct fsl_diu_data *machine_data;
> + =A0 =A0 =A0 int diu_mode;
>
> =A0 =A0 =A0 =A0machine_data =3D kzalloc(sizeof(struct fsl_diu_data), GFP_=
KERNEL);
> =A0 =A0 =A0 =A0if (!machine_data)
> @@ -1472,7 +1480,9 @@ static int __devinit fsl_diu_probe(struct of_device=
 *ofdev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto error2;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 out_be32(&dr.diu_reg->diu_mode, 0); =A0 =A0 =A0 =A0 =A0 =A0=
 /* disable DIU anyway*/
> + =A0 =A0 =A0 diu_mode =3D in_be32(&dr.diu_reg->diu_mode);
> + =A0 =A0 =A0 if (diu_mode !=3D MFB_MODE1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(&dr.diu_reg->diu_mode, 0); =A0 =A0=
 /* disable DIU */

Is this the best approach?  Would it be better to make this decision
based on a property in the device tree?

>
> =A0 =A0 =A0 =A0/* Get the IRQ of the DIU */
> =A0 =A0 =A0 =A0machine_data->irq =3D irq_of_parse_and_map(np, 0);
> @@ -1520,7 +1530,12 @@ static int __devinit fsl_diu_probe(struct of_devic=
e *ofdev,
> =A0 =A0 =A0 =A0machine_data->dummy_ad->offset_xyd =3D 0;
> =A0 =A0 =A0 =A0machine_data->dummy_ad->next_ad =3D 0;
>
> - =A0 =A0 =A0 out_be32(&dr.diu_reg->desc[0], machine_data->dummy_ad->padd=
r);
> + =A0 =A0 =A0 /* Let DIU display splash screen if it was pre-initialized
> + =A0 =A0 =A0 =A0* by the bootloader, set dummy area descriptor otherwise=
.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (diu_mode !=3D MFB_MODE1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(&dr.diu_reg->desc[0], machine_data=
->dummy_ad->paddr);
> +

Same as above.

> =A0 =A0 =A0 =A0out_be32(&dr.diu_reg->desc[1], machine_data->dummy_ad->pad=
dr);
> =A0 =A0 =A0 =A0out_be32(&dr.diu_reg->desc[2], machine_data->dummy_ad->pad=
dr);
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
