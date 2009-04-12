Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.28])
	by ozlabs.org (Postfix) with ESMTP id 229FADE1A1
	for <linuxppc-dev@ozlabs.org>; Sun, 12 Apr 2009 16:15:33 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so1008725yxg.39
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Apr 2009 23:15:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090410211754.1ECF9FC804E@mail107-sin.bigfish.com>
References: <20090410211754.1ECF9FC804E@mail107-sin.bigfish.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sun, 12 Apr 2009 00:15:16 -0600
Message-ID: <fa686aa40904112315j172ef523xc35f7b0b7fa098db@mail.gmail.com>
Subject: Re: [PATCH] [V2] Xilinx : Framebuffer Driver: Add PLB support
	(non-DCR)
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

What tree is this patch prepared against?  The version in mainline
already does PLB access, and doesn't support DCR at all.  It appears
that this driver is based on something that does the opposite.

g.

On Fri, Apr 10, 2009 at 3:17 PM, John Linn <john.linn@xilinx.com> wrote:
> From: Suneel <suneelg@xilinx.com>
>
> Added support for the new xps tft controller.
>
> The new core has PLB interface support in addition to existing
> DCR interface.
>
> The driver has been modified to support this new core which
> can be connected on PLB or DCR bus.
>
> Signed-off-by: Suneel <suneelg@xilinx.com>
> Signed-off-by: John Linn <john.linn@xilinx.com>
> ---
>
> V2 - Incorporated comments from Josh, Grant and others
>
> =A0drivers/video/xilinxfb.c | =A0213 ++++++++++++++++++++++++++++++++----=
----------
> =A01 files changed, 150 insertions(+), 63 deletions(-)
>
> diff --git a/drivers/video/xilinxfb.c b/drivers/video/xilinxfb.c
> index a82c530..d151237 100644
> --- a/drivers/video/xilinxfb.c
> +++ b/drivers/video/xilinxfb.c
> @@ -1,13 +1,13 @@
> =A0/*
> - * xilinxfb.c
> =A0*
> - * Xilinx TFT LCD frame buffer driver
> + * Xilinx TFT frame buffer driver
> =A0*
> =A0* Author: MontaVista Software, Inc.
> =A0* =A0 =A0 =A0 =A0 source@mvista.com
> =A0*
> =A0* 2002-2007 (c) MontaVista Software, Inc.
> =A0* 2007 (c) Secret Lab Technologies, Ltd.
> + * 2009 (c) Xilinx Inc.
> =A0*
> =A0* This file is licensed under the terms of the GNU General Public Lice=
nse
> =A0* version 2. =A0This program is licensed "as is" without any warranty =
of any
> @@ -31,27 +31,31 @@
> =A0#include <linux/fb.h>
> =A0#include <linux/init.h>
> =A0#include <linux/dma-mapping.h>
> -#if defined(CONFIG_OF)
> =A0#include <linux/of_device.h>
> =A0#include <linux/of_platform.h>
> -#endif
> -#include <asm/io.h>
> +#include <linux/io.h>
> =A0#include <linux/xilinxfb.h>
> =A0#include <asm/dcr.h>
>
> =A0#define DRIVER_NAME =A0 =A0 =A0 =A0 =A0 =A0"xilinxfb"
> -#define DRIVER_DESCRIPTION =A0 =A0 "Xilinx TFT LCD frame buffer driver"
> +
>
> =A0/*
> =A0* Xilinx calls it "PLB TFT LCD Controller" though it can also be used =
for
> - * the VGA port on the Xilinx ML40x board. This is a hardware display co=
ntroller
> - * for a 640x480 resolution TFT or VGA screen.
> + * the VGA port on the Xilinx ML40x board. This is a hardware display
> + * controller for a 640x480 resolution TFT or VGA screen.
> =A0*
> =A0* The interface to the framebuffer is nice and simple. =A0There are tw=
o
> =A0* control registers. =A0The first tells the LCD interface where in mem=
ory
> =A0* the frame buffer is (only the 11 most significant bits are used, so
> =A0* don't start thinking about scrolling). =A0The second allows the LCD =
to
> =A0* be turned on or off as well as rotated 180 degrees.
> + *
> + * In case of direct PLB access the second control register will be at
> + * an offset of 4 as compared to the DCR access where the offset is 1
> + * i.e. REG_CTRL. So this is taken care in the function
> + * xilinx_fb_out_be32 where it left shifts the offset 2 times in case of
> + * direct PLB access.
> =A0*/
> =A0#define NUM_REGS =A0 =A0 =A0 2
> =A0#define REG_FB_ADDR =A0 =A00
> @@ -108,10 +112,18 @@ static struct fb_var_screeninfo xilinx_fb_var =3D {
> =A0 =A0 =A0 =A0.activate =3D =A0 =A0 FB_ACTIVATE_NOW
> =A0};
>
> +
> +#define PLB_ACCESS_FLAG =A0 =A0 =A0 =A00x1 =A0 =A0 =A0 =A0 =A0 =A0 /* 1 =
=3D PLB, 0 =3D DCR */
> +
> =A0struct xilinxfb_drvdata {
>
> =A0 =A0 =A0 =A0struct fb_info =A0info; =A0 =A0 =A0 =A0 =A0 /* FB driver i=
nfo record */
>
> + =A0 =A0 =A0 phys_addr_t =A0 =A0 regs_phys; =A0 =A0 =A0/* phys. address =
of the control
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 registers */
> + =A0 =A0 =A0 void __iomem =A0 =A0*regs; =A0 =A0 =A0 =A0 =A0/* virt. addr=
ess of the control
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 registers */
> +
> =A0 =A0 =A0 =A0dcr_host_t =A0 =A0 =A0dcr_host;
> =A0 =A0 =A0 =A0unsigned int =A0 =A0dcr_start;
> =A0 =A0 =A0 =A0unsigned int =A0 =A0dcr_len;
> @@ -120,6 +132,8 @@ struct xilinxfb_drvdata {
> =A0 =A0 =A0 =A0dma_addr_t =A0 =A0 =A0fb_phys; =A0 =A0 =A0 =A0/* phys. add=
ress of the frame buffer */
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 fb_alloced; =A0 =A0 /* Flag, w=
as the fb memory alloced? */
>
> + =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0flags; =A0 =A0 =A0 =A0 =A0/* =
features of the driver */
> +
> =A0 =A0 =A0 =A0u32 =A0 =A0 =A0 =A0 =A0 =A0 reg_ctrl_default;
>
> =A0 =A0 =A0 =A0u32 =A0 =A0 =A0 =A0 =A0 =A0 pseudo_palette[PALETTE_ENTRIES=
_NO];
> @@ -130,14 +144,19 @@ struct xilinxfb_drvdata {
> =A0 =A0 =A0 =A0container_of(_info, struct xilinxfb_drvdata, info)
>
> =A0/*
> - * The LCD controller has DCR interface to its registers, but all
> - * the boards and configurations the driver has been tested with
> - * use opb2dcr bridge. So the registers are seen as memory mapped.
> - * This macro is to make it simple to add the direct DCR access
> - * when it's needed.
> + * The XPS TFT Controller can be accessed through PLB or DCR interface.
> + * To perform the read/write on the registers we need to check on
> + * which bus its connected and call the appropriate write API.
> =A0*/
> -#define xilinx_fb_out_be32(driverdata, offset, val) \
> - =A0 =A0 =A0 dcr_write(driverdata->dcr_host, offset, val)
> +static void xilinx_fb_out_be32(struct xilinxfb_drvdata *drvdata, u32 off=
set,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 val)
> +{
> + =A0 =A0 =A0 if (drvdata->flags & PLB_ACCESS_FLAG)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(drvdata->regs + (offset << 2), val=
);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dcr_write(drvdata->dcr_host, offset, val);
> +
> +}
>
> =A0static int
> =A0xilinx_fb_setcolreg(unsigned regno, unsigned red, unsigned green, unsi=
gned blue,
> @@ -175,7 +194,8 @@ xilinx_fb_blank(int blank_mode, struct fb_info *fbi)
> =A0 =A0 =A0 =A0switch (blank_mode) {
> =A0 =A0 =A0 =A0case FB_BLANK_UNBLANK:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* turn on panel */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 xilinx_fb_out_be32(drvdata, REG_CTRL, drvda=
ta->reg_ctrl_default);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 xilinx_fb_out_be32(drvdata, REG_CTRL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 drvdata->reg_ctrl_default);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>
> =A0 =A0 =A0 =A0case FB_BLANK_NORMAL:
> @@ -191,8 +211,7 @@ xilinx_fb_blank(int blank_mode, struct fb_info *fbi)
> =A0 =A0 =A0 =A0return 0; /* success */
> =A0}
>
> -static struct fb_ops xilinxfb_ops =3D
> -{
> +static struct fb_ops xilinxfb_ops =3D {
> =A0 =A0 =A0 =A0.owner =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D THIS_MODULE,
> =A0 =A0 =A0 =A0.fb_setcolreg =A0 =A0 =A0 =A0 =A0 =3D xilinx_fb_setcolreg,
> =A0 =A0 =A0 =A0.fb_blank =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D xilinx_fb_blank,
> @@ -205,25 +224,35 @@ static struct fb_ops xilinxfb_ops =3D
> =A0* Bus independent setup/teardown
> =A0*/
>
> -static int xilinxfb_assign(struct device *dev, dcr_host_t dcr_host,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned int dcr_sta=
rt, unsigned int dcr_len,
> +static int xilinxfb_assign(struct device *dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct xilinxfb_drvd=
ata *drvdata,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned long physad=
dr,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct xilinxfb_platf=
orm_data *pdata)
> =A0{
> - =A0 =A0 =A0 struct xilinxfb_drvdata *drvdata;
> =A0 =A0 =A0 =A0int rc;
> =A0 =A0 =A0 =A0int fbsize =3D pdata->xvirt * pdata->yvirt * BYTES_PER_PIX=
EL;
>
> - =A0 =A0 =A0 /* Allocate the driver data region */
> - =A0 =A0 =A0 drvdata =3D kzalloc(sizeof(*drvdata), GFP_KERNEL);
> - =A0 =A0 =A0 if (!drvdata) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "Couldn't allocate device priv=
ate record\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> + =A0 =A0 =A0 if (drvdata->flags & PLB_ACCESS_FLAG) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Map the control registers in if the co=
ntroller
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* is on direct PLB interface.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!request_mem_region(physaddr, 8, DRIVER=
_NAME)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "Couldn't lock=
 memory region at 0x%08lX\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 physaddr);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc =3D -ENODEV;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_region;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 drvdata->regs_phys =3D physaddr;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 drvdata->regs =3D ioremap(physaddr, 8);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!drvdata->regs) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "Couldn't lock=
 memory region at 0x%08lX\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 physaddr);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc =3D -ENODEV;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_map;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 dev_set_drvdata(dev, drvdata);
> -
> - =A0 =A0 =A0 drvdata->dcr_start =3D dcr_start;
> - =A0 =A0 =A0 drvdata->dcr_len =3D dcr_len;
> - =A0 =A0 =A0 drvdata->dcr_host =3D dcr_host;
>
> =A0 =A0 =A0 =A0/* Allocate the framebuffer memory */
> =A0 =A0 =A0 =A0if (pdata->fb_phys) {
> @@ -238,7 +267,10 @@ static int xilinxfb_assign(struct device *dev, dcr_h=
ost_t dcr_host,
> =A0 =A0 =A0 =A0if (!drvdata->fb_virt) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(dev, "Could not allocate frame buf=
fer memory\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rc =3D -ENOMEM;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_region;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (drvdata->flags & PLB_ACCESS_FLAG)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_fbmem;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_region;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0/* Clear (turn to black) the framebuffer */
> @@ -251,7 +283,8 @@ static int xilinxfb_assign(struct device *dev, dcr_ho=
st_t dcr_host,
> =A0 =A0 =A0 =A0drvdata->reg_ctrl_default =3D REG_CTRL_ENABLE;
> =A0 =A0 =A0 =A0if (pdata->rotate_screen)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0drvdata->reg_ctrl_default |=3D REG_CTRL_RO=
TATE;
> - =A0 =A0 =A0 xilinx_fb_out_be32(drvdata, REG_CTRL, drvdata->reg_ctrl_def=
ault);
> + =A0 =A0 =A0 xilinx_fb_out_be32(drvdata, REG_CTRL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 drvdata->reg_ctrl_default);
>
> =A0 =A0 =A0 =A0/* Fill struct fb_info */
> =A0 =A0 =A0 =A0drvdata->info.device =3D dev;
> @@ -287,9 +320,14 @@ static int xilinxfb_assign(struct device *dev, dcr_h=
ost_t dcr_host,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_regfb;
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 if (drvdata->flags & PLB_ACCESS_FLAG) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Put a banner in the log (for DEBUG) */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dev, "regs: phys=3D%lx, virt=3D%p\n=
", physaddr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 drvdata->regs);
> + =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0/* Put a banner in the log (for DEBUG) */
> =A0 =A0 =A0 =A0dev_dbg(dev, "fb: phys=3D%p, virt=3D%p, size=3D%x\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 (void*)drvdata->fb_phys, drvdata->fb_virt, =
fbsize);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (void *)drvdata->fb_phys, drvdata->fb_virt,=
 fbsize);
>
> =A0 =A0 =A0 =A0return 0; =A0 =A0 =A0 /* success */
>
> @@ -300,9 +338,20 @@ err_cmap:
> =A0 =A0 =A0 =A0if (drvdata->fb_alloced)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dma_free_coherent(dev, PAGE_ALIGN(fbsize),=
 drvdata->fb_virt,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0drvdata->fb_phys);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iounmap(drvdata->fb_virt);
> +
> =A0 =A0 =A0 =A0/* Turn off the display */
> =A0 =A0 =A0 =A0xilinx_fb_out_be32(drvdata, REG_CTRL, 0);
>
> +err_fbmem:
> + =A0 =A0 =A0 if (drvdata->flags & PLB_ACCESS_FLAG)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iounmap(drvdata->regs);
> +
> +err_map:
> + =A0 =A0 =A0 if (drvdata->flags & PLB_ACCESS_FLAG)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 release_mem_region(physaddr, 8);
> +
> =A0err_region:
> =A0 =A0 =A0 =A0kfree(drvdata);
> =A0 =A0 =A0 =A0dev_set_drvdata(dev, NULL);
> @@ -325,11 +374,18 @@ static int xilinxfb_release(struct device *dev)
> =A0 =A0 =A0 =A0if (drvdata->fb_alloced)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dma_free_coherent(dev, PAGE_ALIGN(drvdata-=
>info.fix.smem_len),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0drvdat=
a->fb_virt, drvdata->fb_phys);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iounmap(drvdata->fb_virt);
>
> =A0 =A0 =A0 =A0/* Turn off the display */
> =A0 =A0 =A0 =A0xilinx_fb_out_be32(drvdata, REG_CTRL, 0);
>
> - =A0 =A0 =A0 dcr_unmap(drvdata->dcr_host, drvdata->dcr_len);
> + =A0 =A0 =A0 /* Release the resources, as allocated based on interface *=
/
> + =A0 =A0 =A0 if (drvdata->flags & PLB_ACCESS_FLAG) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iounmap(drvdata->regs);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 release_mem_region(drvdata->regs_phys, 8);
> + =A0 =A0 =A0 } else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dcr_unmap(drvdata->dcr_host, drvdata->dcr_l=
en);
>
> =A0 =A0 =A0 =A0kfree(drvdata);
> =A0 =A0 =A0 =A0dev_set_drvdata(dev, NULL);
> @@ -341,27 +397,54 @@ static int xilinxfb_release(struct device *dev)
> =A0* OF bus binding
> =A0*/
>
> -#if defined(CONFIG_OF)
> =A0static int __devinit
> =A0xilinxfb_of_probe(struct of_device *op, const struct of_device_id *mat=
ch)
> =A0{
> =A0 =A0 =A0 =A0const u32 *prop;
> + =A0 =A0 =A0 u32 *p;
> + =A0 =A0 =A0 u32 tft_access;
> =A0 =A0 =A0 =A0struct xilinxfb_platform_data pdata;
> + =A0 =A0 =A0 struct resource res;
> =A0 =A0 =A0 =A0int size, rc;
> - =A0 =A0 =A0 int start, len;
> + =A0 =A0 =A0 int start =3D 0, len =3D 0;
> =A0 =A0 =A0 =A0dcr_host_t dcr_host;
> + =A0 =A0 =A0 struct xilinxfb_drvdata *drvdata;
>
> =A0 =A0 =A0 =A0/* Copy with the default pdata (not a ptr reference!) */
> =A0 =A0 =A0 =A0pdata =3D xilinx_fb_default_pdata;
>
> =A0 =A0 =A0 =A0dev_dbg(&op->dev, "xilinxfb_of_probe(%p, %p)\n", op, match=
);
>
> - =A0 =A0 =A0 start =3D dcr_resource_start(op->node, 0);
> - =A0 =A0 =A0 len =3D dcr_resource_len(op->node, 0);
> - =A0 =A0 =A0 dcr_host =3D dcr_map(op->node, start, len);
> - =A0 =A0 =A0 if (!DCR_MAP_OK(dcr_host)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&op->dev, "invalid address\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* To check whether the core is connected directly to DCR=
 or PLB
> + =A0 =A0 =A0 =A0* interface and initialize the tft_access accordingly.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 p =3D (u32 *)of_get_property(op->node, "xlnx,dcr-splb-slave=
-if", NULL);
> +
> + =A0 =A0 =A0 if (p)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tft_access =3D *p;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tft_access =3D 0; =A0 =A0 =A0 =A0 /* For ba=
ckward compatibility */
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Fill the resource structure if its direct PLB interfac=
e
> + =A0 =A0 =A0 =A0* otherwise fill the dcr_host structure.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (tft_access) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc =3D of_address_to_resource(op->node, 0, =
&res);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (rc) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&op->dev, "invalid =
address\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 start =3D dcr_resource_start(op->node, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 len =3D dcr_resource_len(op->node, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dcr_host =3D dcr_map(op->node, start, len);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!DCR_MAP_OK(dcr_host)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&op->dev, "invalid =
address\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0prop =3D of_get_property(op->node, "phys-size", &size);
> @@ -385,7 +468,26 @@ xilinxfb_of_probe(struct of_device *op, const struct=
 of_device_id *match)
> =A0 =A0 =A0 =A0if (of_find_property(op->node, "rotate-display", NULL))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pdata.rotate_screen =3D 1;
>
> - =A0 =A0 =A0 return xilinxfb_assign(&op->dev, dcr_host, start, len, &pda=
ta);
> + =A0 =A0 =A0 /* Allocate the driver data region */
> + =A0 =A0 =A0 drvdata =3D kzalloc(sizeof(*drvdata), GFP_KERNEL);
> + =A0 =A0 =A0 if (!drvdata) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&op->dev, "Couldn't allocate device=
 private record\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 dev_set_drvdata(&op->dev, drvdata);
> +
> + =A0 =A0 =A0 if (tft_access)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 drvdata->flags |=3D PLB_ACCESS_FLAG;
> +
> + =A0 =A0 =A0 /* Arguments are passed based on the interface */
> + =A0 =A0 =A0 if (drvdata->flags & PLB_ACCESS_FLAG) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return xilinxfb_assign(&op->dev, drvdata, r=
es.start, &pdata);
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 drvdata->dcr_start =3D start;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 drvdata->dcr_len =3D len;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 drvdata->dcr_host =3D dcr_host;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return xilinxfb_assign(&op->dev, drvdata, 0=
, &pdata);
> + =A0 =A0 =A0 }
> =A0}
>
> =A0static int __devexit xilinxfb_of_remove(struct of_device *op)
> @@ -395,6 +497,7 @@ static int __devexit xilinxfb_of_remove(struct of_dev=
ice *op)
>
> =A0/* Match table for of_platform binding */
> =A0static struct of_device_id xilinxfb_of_match[] __devinitdata =3D {
> + =A0 =A0 =A0 { .compatible =3D "xlnx,xps-tft-1.00.a", },
> =A0 =A0 =A0 =A0{ .compatible =3D "xlnx,plb-tft-cntlr-ref-1.00.a", },
> =A0 =A0 =A0 =A0{ .compatible =3D "xlnx,plb-dvi-cntlr-ref-1.00.c", },
> =A0 =A0 =A0 =A0{},
> @@ -412,22 +515,6 @@ static struct of_platform_driver xilinxfb_of_driver =
=3D {
> =A0 =A0 =A0 =A0},
> =A0};
>
> -/* Registration helpers to keep the number of #ifdefs to a minimum */
> -static inline int __init xilinxfb_of_register(void)
> -{
> - =A0 =A0 =A0 pr_debug("xilinxfb: calling of_register_platform_driver()\n=
");
> - =A0 =A0 =A0 return of_register_platform_driver(&xilinxfb_of_driver);
> -}
> -
> -static inline void __exit xilinxfb_of_unregister(void)
> -{
> - =A0 =A0 =A0 of_unregister_platform_driver(&xilinxfb_of_driver);
> -}
> -#else /* CONFIG_OF */
> -/* CONFIG_OF not enabled; do nothing helpers */
> -static inline int __init xilinxfb_of_register(void) { return 0; }
> -static inline void __exit xilinxfb_of_unregister(void) { }
> -#endif /* CONFIG_OF */
>
> =A0/* -------------------------------------------------------------------=
--
> =A0* Module setup and teardown
> @@ -436,18 +523,18 @@ static inline void __exit xilinxfb_of_unregister(vo=
id) { }
> =A0static int __init
> =A0xilinxfb_init(void)
> =A0{
> - =A0 =A0 =A0 return xilinxfb_of_register();
> + =A0 =A0 =A0 return of_register_platform_driver(&xilinxfb_of_driver);
> =A0}
>
> =A0static void __exit
> =A0xilinxfb_cleanup(void)
> =A0{
> - =A0 =A0 =A0 xilinxfb_of_unregister();
> + =A0 =A0 =A0 of_unregister_platform_driver(&xilinxfb_of_driver);
> =A0}
>
> =A0module_init(xilinxfb_init);
> =A0module_exit(xilinxfb_cleanup);
>
> =A0MODULE_AUTHOR("MontaVista Software, Inc. <source@mvista.com>");
> -MODULE_DESCRIPTION(DRIVER_DESCRIPTION);
> +MODULE_DESCRIPTION("Xilinx TFT frame buffer driver");
> =A0MODULE_LICENSE("GPL");
> --
> 1.6.2.1
>
>
>
> This email and any attachments are intended for the sole use of the named=
 recipient(s) and contain(s) confidential information that may be proprieta=
ry, privileged or copyrighted under applicable law. If you are not the inte=
nded recipient, do not read, copy, or forward this email message or any att=
achments. Delete this email message and any attachments immediately.
>
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
