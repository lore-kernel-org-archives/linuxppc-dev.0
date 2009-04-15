Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.229])
	by ozlabs.org (Postfix) with ESMTP id CFF7FDE18E
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Apr 2009 01:14:57 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f9so2593379rvb.9
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Apr 2009 08:14:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090414200834.D05446F8056@mail163-wa4.bigfish.com>
References: <20090414200834.D05446F8056@mail163-wa4.bigfish.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 15 Apr 2009 09:14:41 -0600
Message-ID: <fa686aa40904150814p40813d25w9d04f7e88897a88@mail.gmail.com>
Subject: Re: [PATCH] [V3] Xilinx : Framebuffer Driver: Add PLB support and
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

On Tue, Apr 14, 2009 at 2:08 PM, John Linn <john.linn@xilinx.com> wrote:
> Added support for the new xps tft controller. The new core
> has PLB interface support in addition to existing DCR interface.

Good looking patch.  A few more comments below.

g.

> =A0/*
> =A0* Xilinx calls it "PLB TFT LCD Controller" though it can also be used =
for
> - * the VGA port on the Xilinx ML40x board. This is a hardware display co=
ntroller
> - * for a 640x480 resolution TFT or VGA screen.
> + * the VGA port on the Xilinx ML40x board. This is a hardware display
> + * controller for a 640x480 resolution TFT or VGA screen.

This isn't necessarily true.  This driver will handle controllers
using different resolutions (I know, I know, this is just cleaning up
an existing comment, but no need to leave inaccuracies in there)  :-)

> -#define xilinx_fb_out_be32(driverdata, offset, val) \
> - =A0 =A0 =A0 out_be32(driverdata->regs + offset, val)
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

This could more simply be:

        if (drvdata->regs)
                out_be32(drvdata->regs + (offset << 2), val);
        else
                dcr_write(drvdata->dcr_host, offset, val);

regs will be NULL if DCR is active.

> -static int xilinxfb_assign(struct device *dev, unsigned long physaddr,
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
> - =A0 =A0 =A0 }
> - =A0 =A0 =A0 dev_set_drvdata(dev, drvdata);
> -
> - =A0 =A0 =A0 /* Map the control registers in */
> - =A0 =A0 =A0 if (!request_mem_region(physaddr, 8, DRIVER_NAME)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "Couldn't lock memory region a=
t 0x%08lX\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 physaddr);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc =3D -ENODEV;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_region;
> - =A0 =A0 =A0 }
> - =A0 =A0 =A0 drvdata->regs_phys =3D physaddr;
> - =A0 =A0 =A0 drvdata->regs =3D ioremap(physaddr, 8);
> - =A0 =A0 =A0 if (!drvdata->regs) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "Couldn't lock memory region a=
t 0x%08lX\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 physaddr);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc =3D -ENODEV;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_map;
> + =A0 =A0 =A0 if (drvdata->flags & PLB_ACCESS_FLAG) {

Again, I think using "if (physaddr) {" would be simpler and make more
sense and would eliminate even needing a flags data member.

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
>
> =A0 =A0 =A0 =A0/* Allocate the framebuffer memory */
> @@ -247,7 +267,10 @@ static int xilinxfb_assign(struct device *dev, unsig=
ned long physaddr,
> =A0 =A0 =A0 =A0if (!drvdata->fb_virt) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(dev, "Could not allocate frame buf=
fer memory\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rc =3D -ENOMEM;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_fbmem;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (drvdata->flags & PLB_ACCESS_FLAG)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_fbmem;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_region;

This change doesn't make much sense because the same condition is
tested for again at the err_fbmem: label.  To avoid confusion later
on, keep the unwind path simple (don't jump to different labels).

> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0/* Clear (turn to black) the framebuffer */
> @@ -260,7 +283,8 @@ static int xilinxfb_assign(struct device *dev, unsign=
ed long physaddr,
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
> @@ -296,11 +320,14 @@ static int xilinxfb_assign(struct device *dev, unsi=
gned long physaddr,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_regfb;
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 if (drvdata->flags & PLB_ACCESS_FLAG) {

if (drvdata->regs) {

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Put a banner in the log (for DEBUG) */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dev, "regs: phys=3D%lx, virt=3D%p\n=
", physaddr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 drvdata->regs);
> + =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0/* Put a banner in the log (for DEBUG) */
> - =A0 =A0 =A0 dev_dbg(dev, "regs: phys=3D%lx, virt=3D%p\n", physaddr, drv=
data->regs);
> - =A0 =A0 =A0 dev_dbg(dev, "fb: phys=3D%llx, virt=3D%p, size=3D%x\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned long long) drvdata->fb_phys, drvd=
ata->fb_virt,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 fbsize);
> + =A0 =A0 =A0 dev_dbg(dev, "fb: phys=3D%p, virt=3D%p, size=3D%x\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (void *)drvdata->fb_phys, drvdata->fb_virt,=
 fbsize);
>
> =A0 =A0 =A0 =A0return 0; =A0 =A0 =A0 /* success */
>
> @@ -311,14 +338,19 @@ err_cmap:
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
> =A0err_fbmem:
> - =A0 =A0 =A0 iounmap(drvdata->regs);
> + =A0 =A0 =A0 if (drvdata->flags & PLB_ACCESS_FLAG)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iounmap(drvdata->regs);

if (drvdata->regs)

>
> =A0err_map:
> - =A0 =A0 =A0 release_mem_region(physaddr, 8);
> + =A0 =A0 =A0 if (drvdata->flags & PLB_ACCESS_FLAG)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 release_mem_region(physaddr, 8);

if (physaddr)

>
> =A0err_region:
> =A0 =A0 =A0 =A0kfree(drvdata);
> @@ -342,12 +374,18 @@ static int xilinxfb_release(struct device *dev)
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
> - =A0 =A0 =A0 iounmap(drvdata->regs);
>
> - =A0 =A0 =A0 release_mem_region(drvdata->regs_phys, 8);
> + =A0 =A0 =A0 /* Release the resources, as allocated based on interface *=
/
> + =A0 =A0 =A0 if (drvdata->flags & PLB_ACCESS_FLAG) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iounmap(drvdata->regs);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 release_mem_region(drvdata->regs_phys, 8);
> + =A0 =A0 =A0 } else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dcr_unmap(drvdata->dcr_host, drvdata->dcr_l=
en);

et cetera

> -#if defined(CONFIG_OF)
> =A0static int __devinit
> =A0xilinxfb_of_probe(struct of_device *op, const struct of_device_id *mat=
ch)
> =A0{
> - =A0 =A0 =A0 struct resource res;
> =A0 =A0 =A0 =A0const u32 *prop;
> + =A0 =A0 =A0 u32 *p;
> + =A0 =A0 =A0 u32 tft_access;
> =A0 =A0 =A0 =A0struct xilinxfb_platform_data pdata;
> + =A0 =A0 =A0 struct resource res;
> =A0 =A0 =A0 =A0int size, rc;
> + =A0 =A0 =A0 int start =3D 0, len =3D 0;
> + =A0 =A0 =A0 dcr_host_t dcr_host;
> + =A0 =A0 =A0 struct xilinxfb_drvdata *drvdata;
>
> =A0 =A0 =A0 =A0/* Copy with the default pdata (not a ptr reference!) */
> =A0 =A0 =A0 =A0pdata =3D xilinx_fb_default_pdata;
>
> =A0 =A0 =A0 =A0dev_dbg(&op->dev, "xilinxfb_of_probe(%p, %p)\n", op, match=
);
>
> - =A0 =A0 =A0 rc =3D of_address_to_resource(op->node, 0, &res);
> - =A0 =A0 =A0 if (rc) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&op->dev, "invalid address\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return rc;
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* To check whether the core is connected directly to DCR=
 or PLB
> + =A0 =A0 =A0 =A0* interface and initialize the tft_access accordingly.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 p =3D (u32 *)of_get_property(op->node, "xlnx,dcr-splb-slave=
-if", NULL);

Hmmm.  This binding is undocumented.  It would be better to make the
decision on the presence/absence of the dcr-reg and/or reg properties.

> +
> + =A0 =A0 =A0 if (p)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tft_access =3D *p;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tft_access =3D 0; =A0 =A0 =A0 =A0 /* For ba=
ckward compatibility */

Common pattern: tft_access =3D p ? *p : 0;

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
> @@ -450,7 +468,26 @@ xilinxfb_of_probe(struct of_device *op, const struct=
 of_device_id *match)
> =A0 =A0 =A0 =A0if (of_find_property(op->node, "rotate-display", NULL))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pdata.rotate_screen =3D 1;
>
> - =A0 =A0 =A0 return xilinxfb_assign(&op->dev, res.start, &pdata);
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
> @@ -460,7 +497,9 @@ static int __devexit xilinxfb_of_remove(struct of_dev=
ice *op)
>
> =A0/* Match table for of_platform binding */
> =A0static struct of_device_id xilinxfb_of_match[] __devinitdata =3D {
> + =A0 =A0 =A0 { .compatible =3D "xlnx,xps-tft-1.00.a", },
> =A0 =A0 =A0 =A0{ .compatible =3D "xlnx,plb-tft-cntlr-ref-1.00.a", },
> + =A0 =A0 =A0 { .compatible =3D "xlnx,plb-dvi-cntlr-ref-1.00.c", },
> =A0 =A0 =A0 =A0{},
> =A0};
> =A0MODULE_DEVICE_TABLE(of, xilinxfb_of_match);
> @@ -476,22 +515,6 @@ static struct of_platform_driver xilinxfb_of_driver =
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
> @@ -500,28 +523,18 @@ static inline void __exit xilinxfb_of_unregister(vo=
id) { }
> =A0static int __init
> =A0xilinxfb_init(void)
> =A0{
> - =A0 =A0 =A0 int rc;
> - =A0 =A0 =A0 rc =3D xilinxfb_of_register();
> - =A0 =A0 =A0 if (rc)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return rc;
> -
> - =A0 =A0 =A0 rc =3D platform_driver_register(&xilinxfb_platform_driver);
> - =A0 =A0 =A0 if (rc)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 xilinxfb_of_unregister();
> -
> - =A0 =A0 =A0 return rc;
> + =A0 =A0 =A0 return of_register_platform_driver(&xilinxfb_of_driver);
> =A0}
>
> =A0static void __exit
> =A0xilinxfb_cleanup(void)
> =A0{
> - =A0 =A0 =A0 platform_driver_unregister(&xilinxfb_platform_driver);
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
