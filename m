Return-Path: <adaplas@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.239])
	by ozlabs.org (Postfix) with ESMTP id F2238DDE16
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 May 2007 05:57:20 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id 50so638386wra
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 03 May 2007 12:57:19 -0700 (PDT)
Subject: Re: [Linux-fbdev-devel] [PATCH] Xilinx framebuffer device driver -
	3d version
From: "Antonino A. Daplas" <adaplas@gmail.com>
To: linux-fbdev-devel@lists.sourceforge.net
In-Reply-To: <463A1B58.8000804@ru.mvista.com>
References: <463A1B58.8000804@ru.mvista.com>
Content-Type: text/plain
Date: Fri, 04 May 2007 03:57:12 +0800
Message-Id: <1178222232.28617.28.camel@daplas>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 2007-05-03 at 21:26 +0400, Andrei Konovalov wrote:
> Add support for the video controller IP block included into Xilinx ML300
> and ML403 reference designs.
> 
> Signed-off-by: Andrei Konovalov <akonovalov@ru.mvista.com>
> 
> -----
> The driver has been tested with Xilinx ML300 and ML403 reference designs.
> 
> The two first version has been posted to linuxppc-embedded, and this
> version tries to address all the comments and criticism received.
> 
> The platform device registration for Xilinx ML300 and ML403
> moved into separate patch (will be posted to linuxppc-embedded
> in couple minutes).
> 
> Would be nice to get this driver into mainline for the 2.6.22.
> Reviews and comments are welcome.

It's hard to make comments when you submit patches as attachment, but
here goes.

+static int
+xilinx_fb_blank(int blank_mode, struct fb_info *fbi)
+{
+	struct xilinxfb_drvdata *drvdata = to_xilinxfb_drvdata(fbi);
+
+	switch (blank_mode) {
+	case VESA_NO_BLANKING:
+		/* turn on panel */
+		xilinx_fb_out_be32(drvdata, REG_CTRL, drvdata->reg_ctrl_default);
+		break;
+
+	case VESA_VSYNC_SUSPEND:
+	case VESA_HSYNC_SUSPEND:
+	case VESA_POWERDOWN:
+		/* turn off panel */
+		xilinx_fb_out_be32(drvdata, REG_CTRL, 0);
+	default:
+		break;
+
+	}
+	return 0; /* success */
+}
+

Use the FB_BLANK_* constants defined in include/linux/fb.h instead of
the VESA_* constants.

+static int
+xilinx_fb_pan_display(struct fb_var_screeninfo *var, struct fb_info
*fbi)
+{
+	if (var->xoffset != 0 || var->yoffset != 0)
+		return -EINVAL;
+
+	return 0;
+}
+

This silently succeeds.  If you don't have a pan_display() hook, might
as well remove it.

+static int
+xilinxfb_drv_probe(struct device *dev)
+{
+	struct platform_device *pdev;
+	struct xilinxfb_platform_data *pdata;
+	struct xilinxfb_drvdata *drvdata;
+	struct resource *regs_res;
+	int retval;
+
+	if (!dev)
+		return -EINVAL;
+
+	pdev = to_platform_device(dev);
+	pdata = (struct xilinxfb_platform_data *)pdev->dev.platform_data;

Is the cast really needed?

+
+	if (pdata == NULL) {
+		printk(KERN_ERR "Couldn't find platform data.\n");
+		return -EFAULT;
+	}
+
+	drvdata = kzalloc(sizeof(*drvdata), GFP_KERNEL);
+	if (!drvdata) {
+		printk(KERN_ERR "Couldn't allocate device private record\n");
+		return -ENOMEM;
+	}
+	dev_set_drvdata(dev, (void *)drvdata);

Here also.

+
+	/* Map the control registers in */
+	regs_res = platform_get_resource(pdev, IORESOURCE_IO, 0);
+	if (!regs_res || (regs_res->end - regs_res->start + 1 < 8)) {
+		printk(KERN_ERR "Couldn't get registers resource\n");
+		retval = -EFAULT;
+		goto failed1;
+	}
+
+	if (!request_mem_region(regs_res->start, 8, DRIVER_NAME)) {
+		printk(KERN_ERR
+		       "Couldn't lock memory region at 0x%08X\n",
+		       regs_res->start);
+		retval = -EBUSY;
+		goto failed1;
+	}
+	drvdata->regs = (u32 __iomem*) ioremap(regs_res->start, 8);
+	drvdata->regs_phys = regs_res->start;
+
+	/* Allocate the framebuffer memory */
+	drvdata->fb_virt = dma_alloc_coherent(dev, PAGE_ALIGN(FB_SIZE),
+				&drvdata->fb_phys, GFP_KERNEL);
+	if (!drvdata->fb_virt) {
+		printk(KERN_ERR "Could not allocate frame buffer memory\n");
+		retval = -ENOMEM;
+		goto failed2;
+	}
+
+	/* Clear (turn to black) the framebuffer */
+	memset((void *) drvdata->fb_virt, 0, FB_SIZE);

memset() or memset_io()?

+
+	/* Tell the hardware where the frame buffer is */
+	xilinx_fb_out_be32(drvdata, REG_FB_ADDR, drvdata->fb_phys);
+
+	/* Turn on the display */
+	if (pdata->rotate_screen) {
+		drvdata->reg_ctrl_default = REG_CTRL_ENABLE | REG_CTRL_ROTATE;
+	} else {
+		drvdata->reg_ctrl_default = REG_CTRL_ENABLE;
+	}
+	xilinx_fb_out_be32(drvdata, REG_CTRL, drvdata->reg_ctrl_default);
+
+	/* Fill struct fb_info */
+	drvdata->info.screen_base = drvdata->fb_virt;
+	drvdata->info.fbops = &xilinxfb_ops;
+	drvdata->info.fix = xilinx_fb_fix;
+	drvdata->info.fix.smem_start = drvdata->fb_phys;
+	drvdata->info.pseudo_palette = drvdata->pseudo_palette;

If you cannot use framebuffer_alloc()/release(), set
drvdata->info.device so your driver shows up in /sys/class/graphics.

Tony
