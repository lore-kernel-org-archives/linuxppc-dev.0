Return-Path: <timur.tabi@gmail.com>
Received: from mail-iw0-f181.google.com (mail-iw0-f181.google.com
	[209.85.223.181]) by ozlabs.org (Postfix) with ESMTP id B0AA2B7BEE
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Apr 2010 12:05:58 +1000 (EST)
Received: by iwn11 with SMTP id 11so12517422iwn.11
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Apr 2010 19:05:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1272584978-19063-4-git-send-email-agust@denx.de>
References: <1272584978-19063-1-git-send-email-agust@denx.de>
	<1272584978-19063-4-git-send-email-agust@denx.de>
From: Timur Tabi <timur.tabi@gmail.com>
Date: Thu, 29 Apr 2010 21:05:26 -0500
Message-ID: <s2ted82fe3e1004291905mf562f0cbi24054bb973aa2dbb@mail.gmail.com>
Subject: Re: [PATCH 3/5] powerpc/mpc5121: shared DIU framebuffer support
To: Anatolij Gustschin <agust@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
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

On Thu, Apr 29, 2010 at 6:49 PM, Anatolij Gustschin <agust@denx.de> wrote:


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

How about just doing this?

.init_early             =3D mpc512x_init_diu,

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

And a similar change here.

> =A0 =A0 =A0 =A0.init_IRQ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D mpc512x_init_IRQ=
,
> =A0 =A0 =A0 =A0.get_irq =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D ipic_get_irq,
> =A0 =A0 =A0 =A0.calibrate_decr =A0 =A0 =A0 =A0 =3D generic_calibrate_decr=
,
> diff --git a/arch/powerpc/platforms/512x/mpc512x.h b/arch/powerpc/platfor=
ms/512x/mpc512x.h
> index b2daca0..1ab6d11 100644
> --- a/arch/powerpc/platforms/512x/mpc512x.h
> +++ b/arch/powerpc/platforms/512x/mpc512x.h
> @@ -16,4 +16,6 @@ extern void __init mpc512x_init(void);
> =A0extern int __init mpc5121_clk_init(void);
> =A0void __init mpc512x_declare_of_platform_devices(void);
> =A0extern void mpc512x_restart(char *cmd);
> +extern void mpc512x_init_diu(void);
> +extern void mpc512x_setup_diu(void);
> =A0#endif =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* __MPC512X_H_=
_ */
> diff --git a/arch/powerpc/platforms/512x/mpc512x_shared.c b/arch/powerpc/=
platforms/512x/mpc512x_shared.c
> index b7f518a..8e297fa 100644
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
> @@ -53,6 +57,286 @@ void mpc512x_restart(char *cmd)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0;
> =A0}
>
> +struct fsl_diu_shared_fb {
> + =A0 =A0 =A0 char =A0 =A0 =A0 =A0 =A0 =A0gamma[0x300]; =A0 /* 32-bit ali=
gned! */

char or u8?

> + =A0 =A0 =A0 struct diu_ad =A0 ad0; =A0 =A0 =A0 =A0 =A0 =A0/* 32-bit ali=
gned! */
> + =A0 =A0 =A0 phys_addr_t =A0 =A0 fb_phys;
> + =A0 =A0 =A0 size_t =A0 =A0 =A0 =A0 =A0fb_len;
> + =A0 =A0 =A0 bool =A0 =A0 =A0 =A0 =A0 =A0in_use;
> +};

Where did "bool" come from?  Use "int" instead.

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

This is simpler:

       switch (bits_per_pixel) {
       case 32:
               return 0x88883316;
       case 24:
               return 0x88082219;
       case 16:
               return =3D 0x65053118;
      }

      return 0x00000400;
}

> + =A0 =A0 =A0 ccm =3D of_iomap(np, 0);
> + =A0 =A0 =A0 if (!ccm) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("Can't map clock control module reg.=
\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_node_put(np);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 of_node_put(np);

This is simpler:

       ccm =3D of_iomap(np, 0);
       of_node_put(np);
       if (!ccm) {
               pr_err("Can't map clock control module reg.\n");
               return;
       }


> + =A0 =A0 =A0 np =3D of_find_node_by_type(NULL, "cpu");
> + =A0 =A0 =A0 if (np) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int size;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 const unsigned int *prop =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_get_property(np, "bus-fr=
equency", &size);

Since you don't use 'size', you can skip it:

              const unsigned int *prop =3D
                      of_get_property(np, "bus-frequency", NULL);

> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("Can't find \"cpu\" node.\n");

'cpu' is simpler than \"cpu\"

> + =A0 =A0 =A0 /* Calculate the pixel clock with the smallest error */
> + =A0 =A0 =A0 /* calculate the following in steps to avoid overflow */
> + =A0 =A0 =A0 pr_debug("DIU pixclock in ps - %d\n", pixclock);
> + =A0 =A0 =A0 temp =3D (1000000000 / pixclock) * 1000;

I'm pretty sure the compiler will optimize this to:

    temp =3D (1000000000000UL / pixclock);

so you may as well do it that way.

> + =A0 =A0 =A0 pixclock =3D temp;
> + =A0 =A0 =A0 pr_debug("DIU pixclock freq - %u\n", pixclock);
> +
> + =A0 =A0 =A0 temp =3D (temp * 5) / 100; /* pixclock * 0.05 */

The compiler will optimize this to:

    temp /=3D 20;

> + =A0 =A0 =A0 pr_debug("deviation =3D %d\n", temp);
> + =A0 =A0 =A0 minpixclock =3D pixclock - temp;
> + =A0 =A0 =A0 maxpixclock =3D pixclock + temp;
> + =A0 =A0 =A0 pr_debug("DIU minpixclock - %lu\n", minpixclock);
> + =A0 =A0 =A0 pr_debug("DIU maxpixclock - %lu\n", maxpixclock);
> + =A0 =A0 =A0 pixval =3D speed_ccb/pixclock;
> + =A0 =A0 =A0 pr_debug("DIU pixval =3D %lu\n", pixval);
> +
> + =A0 =A0 =A0 err =3D 100000000;

Why do you assign err to this arbitrary value?

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

Don't use offsets like + CCM_SCFR1.  Create a structure and use that instea=
d.

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

There's no point in using snprintf since you're printing a string
literal.  You can use sprintf.

> +}
> +
> +int mpc512x_set_sysfs_monitor_port(int val)
> +{
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static struct fsl_diu_shared_fb __attribute__ ((__aligned__(8))) diu_sha=
red_fb;
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

Do you really need to use reserve_bootmem?  Have you tried kmalloc or
alloc_pages_exact()?

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

Shouldn't you be probing as an OF driver instead of manually searching
for the DIU node?

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

How can in_be32() return a -1?

--=20
Timur Tabi
Linux kernel developer at Freescale
