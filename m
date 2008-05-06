Return-Path: <glikely@secretlab.ca>
Received: from ag-out-0708.google.com (ag-out-0708.google.com [72.14.246.249])
	by ozlabs.org (Postfix) with ESMTP id 07CE2DDDFB
	for <linuxppc-dev@ozlabs.org>; Tue,  6 May 2008 14:55:54 +1000 (EST)
Received: by ag-out-0708.google.com with SMTP id 8so1049075agc.0
	for <linuxppc-dev@ozlabs.org>; Mon, 05 May 2008 21:55:53 -0700 (PDT)
Message-ID: <fa686aa40805052155q43a7ebd8x14c1711bd4c6bbfa@mail.gmail.com>
Date: Mon, 5 May 2008 22:55:53 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
Subject: Re: [PATCH 4/4] [POWERPC] Xilinx: Framebuffer: Use dcr infrastructure.
In-Reply-To: <20080505175647.4F3AC1C9004A@mail57-sin.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080421080353.5d2b3bb9@zod.rchland.ibm.com>
	<1210010201-28436-1-git-send-email-stephen.neuendorffer@xilinx.com>
	<1210010201-28436-2-git-send-email-stephen.neuendorffer@xilinx.com>
	<1210010201-28436-3-git-send-email-stephen.neuendorffer@xilinx.com>
	<1210010201-28436-4-git-send-email-stephen.neuendorffer@xilinx.com>
	<20080505175647.4F3AC1C9004A@mail57-sin.bigfish.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 5, 2008 at 11:56 AM, Stephen Neuendorffer
<stephen.neuendorffer@xilinx.com> wrote:
> This device contains a dcr interface.  Previously, the dcr interface
>  was assumed to be used in mmio mode, and the register space of the dcr
>  interface was precomputed and stuffed in the device tree.  This patch
>  makes use of the new dcr infrastructure to represent the dcr interface
>  as any other dcr interface in the device tree.  This enables the dcr
>  interface to be connected directly to a native dcr interface in a
>  clean way.
>
>  In particular, the device tree expected looks like:
>
>                         dcr_v29_0: dcr@0 {
>                                 #address-cells = <1>;
>                                 #size-cells = <1>;
>                                 compatible = "xlnx,dcr-v29-1.00.a";
>                                 VGA_FrameBuffer: tft@80 {
>                                         compatible = "xlnx,plb-tft-cntlr-ref-1.00.a";
>                                         dcr-parent = <&opb2dcr_bridge_0>;
>                                         dcr-reg = < 80 2 >;
>                                         xlnx,default-tft-base-addr = <7f>;
>                                         xlnx,dps-init = <1>;
>                                         xlnx,on-init = <1>;
>                                         xlnx,pixclk-is-busclk-divby4 = <1>;
>                                 } ;
>                         } ;
>
>                         opb2dcr_bridge_0: opb2dcr-bridge@40700000 {
>                                 compatible = "xlnx,opb2dcr-bridge-1.00.b";
>                                 dcr-access-method = "mmio";
>                                 dcr-controller ;
>                                 dcr-mmio-range = < 40700000 1000 >;
>                                 dcr-mmio-stride = <4>;
>                                 reg = < 40700000 1000 >;
>                                 xlnx,family = "virtex2p";
>                         } ;

Hmmm, something doesn't quite feel right about this.  The node
describing the tft device is a child of the dcr@0 node which is the
dcr bus.  However, dcr bindings use dcr-bus and dcr-reg instead of
parent-child relationship to specify how to access the dcr registers.
So, in this example; if the device is described by tft@80, and the dcr
bus is described by opb2dcr-bridge@40700000, then what does dcr@0
describe?  (I do understand what they really describe in EDK terms;
but I'm looking at it through device tree glasses).

I don't think the presence of a dcr@0 node is a problem, but in this
case #size/address-cells doesn't have any meaning (the child doesn't
have a reg property) and it looks like it should be a child of the
opb2dcr-bridge node (otherwise, what is it attached to?).

Cheers,
g.

>
>  Signed-off-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
>  ---
>   drivers/video/xilinxfb.c |   54 +++++++++++++++++-----------------------------
>   1 files changed, 20 insertions(+), 34 deletions(-)
>
>  diff --git a/drivers/video/xilinxfb.c b/drivers/video/xilinxfb.c
>  index 4d64402..848752e 100644
>  --- a/drivers/video/xilinxfb.c
>  +++ b/drivers/video/xilinxfb.c
>  @@ -37,6 +37,7 @@
>   #endif
>   #include <asm/io.h>
>   #include <linux/xilinxfb.h>
>  +#include <asm/dcr.h>
>
>   #define DRIVER_NAME            "xilinxfb"
>   #define DRIVER_DESCRIPTION     "Xilinx TFT LCD frame buffer driver"
>  @@ -111,8 +112,9 @@ struct xilinxfb_drvdata {
>
>         struct fb_info  info;           /* FB driver info record */
>
>  -       u32             regs_phys;      /* phys. address of the control registers */
>  -       u32 __iomem     *regs;          /* virt. address of the control registers */
>  +       dcr_host_t      dcr_host;
>  +       unsigned int    dcr_start;
>  +       unsigned int    dcr_len;
>
>         void            *fb_virt;       /* virt. address of the frame buffer */
>         dma_addr_t      fb_phys;        /* phys. address of the frame buffer */
>  @@ -135,7 +137,7 @@ struct xilinxfb_drvdata {
>   * when it's needed.
>   */
>   #define xilinx_fb_out_be32(driverdata, offset, val) \
>  -       out_be32(driverdata->regs + offset, val)
>  +       dcr_write(driverdata->dcr_host, offset, val)
>
>   static int
>   xilinx_fb_setcolreg(unsigned regno, unsigned red, unsigned green, unsigned blue,
>  @@ -203,7 +205,8 @@ static struct fb_ops xilinxfb_ops =
>   * Bus independent setup/teardown
>   */
>
>  -static int xilinxfb_assign(struct device *dev, unsigned long physaddr,
>  +static int xilinxfb_assign(struct device *dev, dcr_host_t dcr_host,
>  +                          unsigned int dcr_start, unsigned int dcr_len,
>                            struct xilinxfb_platform_data *pdata)
>   {
>         struct xilinxfb_drvdata *drvdata;
>  @@ -218,21 +221,9 @@ static int xilinxfb_assign(struct device *dev, unsigned long physaddr,
>         }
>         dev_set_drvdata(dev, drvdata);
>
>  -       /* Map the control registers in */
>  -       if (!request_mem_region(physaddr, 8, DRIVER_NAME)) {
>  -               dev_err(dev, "Couldn't lock memory region at 0x%08lX\n",
>  -                       physaddr);
>  -               rc = -ENODEV;
>  -               goto err_region;
>  -       }
>  -       drvdata->regs_phys = physaddr;
>  -       drvdata->regs = ioremap(physaddr, 8);
>  -       if (!drvdata->regs) {
>  -               dev_err(dev, "Couldn't lock memory region at 0x%08lX\n",
>  -                       physaddr);
>  -               rc = -ENODEV;
>  -               goto err_map;
>  -       }
>  +       drvdata->dcr_start = dcr_start;
>  +       drvdata->dcr_len = dcr_len;
>  +       drvdata->dcr_host = dcr_host;
>
>         /* Allocate the framebuffer memory */
>         if (pdata->fb_phys) {
>  @@ -247,7 +238,7 @@ static int xilinxfb_assign(struct device *dev, unsigned long physaddr,
>         if (!drvdata->fb_virt) {
>                 dev_err(dev, "Could not allocate frame buffer memory\n");
>                 rc = -ENOMEM;
>  -               goto err_fbmem;
>  +               goto err_region;
>         }
>
>         /* Clear (turn to black) the framebuffer */
>  @@ -297,7 +288,6 @@ static int xilinxfb_assign(struct device *dev, unsigned long physaddr,
>         }
>
>         /* Put a banner in the log (for DEBUG) */
>  -       dev_dbg(dev, "regs: phys=%lx, virt=%p\n", physaddr, drvdata->regs);
>         dev_dbg(dev, "fb: phys=%p, virt=%p, size=%x\n",
>                 (void*)drvdata->fb_phys, drvdata->fb_virt, fbsize);
>
>  @@ -313,12 +303,6 @@ err_cmap:
>         /* Turn off the display */
>         xilinx_fb_out_be32(drvdata, REG_CTRL, 0);
>
>  -err_fbmem:
>  -       iounmap(drvdata->regs);
>  -
>  -err_map:
>  -       release_mem_region(physaddr, 8);
>  -
>   err_region:
>         kfree(drvdata);
>         dev_set_drvdata(dev, NULL);
>  @@ -344,9 +328,8 @@ static int xilinxfb_release(struct device *dev)
>
>         /* Turn off the display */
>         xilinx_fb_out_be32(drvdata, REG_CTRL, 0);
>  -       iounmap(drvdata->regs);
>
>  -       release_mem_region(drvdata->regs_phys, 8);
>  +       dcr_unmap(drvdata->dcr_host, drvdata->dcr_len);
>
>         kfree(drvdata);
>         dev_set_drvdata(dev, NULL);
>  @@ -362,20 +345,23 @@ static int xilinxfb_release(struct device *dev)
>   static int __devinit
>   xilinxfb_of_probe(struct of_device *op, const struct of_device_id *match)
>   {
>  -       struct resource res;
>         const u32 *prop;
>         struct xilinxfb_platform_data pdata;
>         int size, rc;
>  +       int start, len;
>  +       dcr_host_t dcr_host;
>
>         /* Copy with the default pdata (not a ptr reference!) */
>         pdata = xilinx_fb_default_pdata;
>
>         dev_dbg(&op->dev, "xilinxfb_of_probe(%p, %p)\n", op, match);
>
>  -       rc = of_address_to_resource(op->node, 0, &res);
>  -       if (rc) {
>  +       start = dcr_resource_start(op->node, 0);
>  +       len = dcr_resource_len(op->node, 0);
>  +       dcr_host = dcr_map(op->node, start, len);
>  +       if (!DCR_MAP_OK(dcr_host)) {
>                 dev_err(&op->dev, "invalid address\n");
>  -               return rc;
>  +               return -ENODEV;
>         }
>
>         prop = of_get_property(op->node, "phys-size", &size);
>  @@ -399,7 +385,7 @@ xilinxfb_of_probe(struct of_device *op, const struct of_device_id *match)
>         if (of_find_property(op->node, "rotate-display", NULL))
>                 pdata.rotate_screen = 1;
>
>  -       return xilinxfb_assign(&op->dev, res.start, &pdata);
>  +       return xilinxfb_assign(&op->dev, dcr_host, start, len, &pdata);
>   }
>
>   static int __devexit xilinxfb_of_remove(struct of_device *op)
>  --
>  1.5.3.4-dirty
>
>
>
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
