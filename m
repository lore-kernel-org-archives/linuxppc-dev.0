Return-Path: <olh@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DA30067B57
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Aug 2006 04:50:33 +1000 (EST)
Date: Mon, 31 Jul 2006 20:50:24 +0200
From: Olaf Hering <olh@suse.de>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Andrew Morton <akpm@osdl.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] crash in aty128_set_lcd_enable on PowerBook
Message-ID: <20060731185024.GA5117@suse.de>
References: <20060716163728.GA16228@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20060716163728.GA16228@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Sun, Jul 16, Olaf Hering wrote:

> 
> Current Linus tree crashes in aty128_set_lcd_enable() because par->pdev
> is NULL. This happens since at least a week. Call trace is:
> 
> aty128_set_lcd_enable
> aty128fb_set_par
> fbcon_init
> visual_init
> take_over_console
> fbcon_takeover
> notifier_call_chain
> blocking_notifier_call_chain
> register_framebuffer
> aty128fb_probe
> pci_device_probe
> bus_for_each_dev
> driver_attach
> bus_add_driver
> driver_register
> __pci_register_driver
> aty128fb_init
> init
> kernel_thread
> 


- info->fix was assigned twice.
- par->vram_size is assigned in aty128_probe(), no need to redo it again in aty128_init()
- register_framebuffer() uses uninitialized struct members,
  move it past par->pdev assignment and past aty128_bl_init().


Signed-off-by: Olaf Hering <olh@suse.de>

Index: linux-2.6.18-rc3/drivers/video/aty/aty128fb.c
===================================================================
--- linux-2.6.18-rc3.orig/drivers/video/aty/aty128fb.c
+++ linux-2.6.18-rc3/drivers/video/aty/aty128fb.c
@@ -1910,9 +1910,6 @@ static int __devinit aty128_init(struct 
 	u8 chip_rev;
 	u32 dac;
 
-	if (!par->vram_size)	/* may have already been probed */
-		par->vram_size = aty_ld_le32(CONFIG_MEMSIZE) & 0x03FFFFFF;
-
 	/* Get the chip revision */
 	chip_rev = (aty_ld_le32(CONFIG_CNTL) >> 16) & 0x1F;
 
@@ -2025,9 +2022,6 @@ static int __devinit aty128_init(struct 
 
 	aty128_init_engine(par);
 
-	if (register_framebuffer(info) < 0)
-		return 0;
-
 	par->pm_reg = pci_find_capability(pdev, PCI_CAP_ID_PM);
 	par->pdev = pdev;
 	par->asleep = 0;
@@ -2037,6 +2031,9 @@ static int __devinit aty128_init(struct 
 	aty128_bl_init(par);
 #endif
 
+	if (register_framebuffer(info) < 0)
+		return 0;
+
 	printk(KERN_INFO "fb%d: %s frame buffer device on %s\n",
 	       info->node, info->fix.id, video_card);
 
@@ -2086,7 +2083,6 @@ static int __devinit aty128_probe(struct
 	par = info->par;
 
 	info->pseudo_palette = par->pseudo_palette;
-	info->fix = aty128fb_fix;
 
 	/* Virtualize mmio region */
 	info->fix.mmio_start = reg_addr;
