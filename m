Return-Path: <rep.dot.nop@gmail.com>
Received: from email.aon.at (nat-warsl417-02.aon.at [195.3.96.120])
	by ozlabs.org (Postfix) with ESMTP id C39EBDDFFD
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 08:43:04 +1100 (EST)
Received: from unknown (HELO email.aon.at) ([172.18.5.230])
	(envelope-sender <rep.dot.nop@gmail.com>)
	by fallback01.highway.telekom.at (qmail-ldap-1.03) with SMTP
	for <linuxppc-dev@ozlabs.org>; 25 Jan 2007 21:36:22 -0000
Date: Thu, 25 Jan 2007 22:36:37 +0100
From: Bernhard Fischer <rep.dot.nop@gmail.com>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [Linux-fbdev-devel] [PATCH 6/9] ps3: Virtual Frame Buffer Driver
Message-ID: <20070125213637.GI28221@aon.at>
References: <Pine.LNX.4.62.0701251825390.14799@pademelon.sonytel.be>
	<Pine.LNX.4.62.0701251850220.24610@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.62.0701251850220.24610@pademelon.sonytel.be>
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Linux Frame Buffer Device Development
	<linux-fbdev-devel@lists.sourceforge.net>,
	Paul Mackerras <paulus@samba.org>, Bernhard Fischer <rep.dot.nop@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Just some minor cosmetics..

On Thu, Jan 25, 2007 at 06:50:44PM +0100, Geert Uytterhoeven wrote:
>--- /dev/null
>+++ ps3-linux/drivers/video/ps3fb.c
>@@ -0,0 +1,1266 @@
>+/*
>+ * linux/drivers/video/ps3fb.c -- PS3 GPU frame buffer device
>+ *
>+ * Copyright (C) 2006 Sony Computer Entertainment Inc.
>+ * Copyright (C) 2006-2007 Sony Corporation
>+ *
>+ *  this file is based on :
>+ *
>+ *  linux/drivers/video/vfb.c -- Virtual frame buffer device
>+ *
>+ *      Copyright (C) 2002 James Simmons
>+ *
>+ *	Copyright (C) 1997 Geert Uytterhoeven

One (C) has spaces, yours a tab.


>+struct ps3fb_priv {
>+	unsigned long videomemory_phys;
>+	unsigned long videomemorysize;

Is the naming with and without underscore intentional?


>+static int ps3fb_get_res_table(u32 xres, u32 yres)
>+{
>+	int i, full_mode;

unsigned?

>+	u32 x, y, f = 0;
>+
>+	full_mode = (ps3fb_mode & PS3FB_FULL_MODE_BIT) ? PS3FB_RES_FULL : 0;
>+	for (i = 0;; i++) {
>+		x = ps3fb_res[i].xres;
>+		y = ps3fb_res[i].yres;
>+		f = ps3fb_res[i].type;

Why did you set f=0 above?

>+
>+static const struct fb_videomode *ps3fb_default_mode(void)
>+{
>+	u32 mode = ps3fb_mode & PS3AV_MODE_MASK;
>+	u32 flags = ps3fb_mode & ~PS3AV_MODE_MASK;
>+
>+	if (mode < 1 || mode > 13)
>+		return NULL;

smaller if you set flags only after this check?


>+static int ps3fb_sync(u32 frame)
>+{
>+	int i;
>+	u32 xres, yres;
>+	u64 head, fb_ioif, offset;

#if defined HEAD_A || defined HEAD_B
	u64 head;
#endif

Resp, remove it and pass the value in directly like you do in
ps3fb_set_sync()?

It's unlikely that neither HEAD_A nor HEAD_B are defined, i assume, so
the check is most likely not needed?

>+	u64 sync = 1;

you don't seem to use sync much, perhaps use just 1 below?

>+	int status;

I'd reuse status and drop i, perhaps.
>+
>+	i = ps3fb.res_index;
>+	xres = ps3fb_res[i].xres;
>+	yres = ps3fb_res[i].yres;
>+
>+	if (frame > ps3fb.num_frames - 1) {
>+		printk(KERN_WARNING "%s: invalid frame number (%u)\n",
>+		       __FUNCTION__, frame);
>+		return -EINVAL;
>+	}
>+	offset = xres * yres * BPP * frame;
>+
>+	fb_ioif = GPU_IOIF + FB_OFF(i) + offset;
>+	status = lv1_gpu_context_attribute(ps3fb.context_handle,
>+					   L1GPU_CONTEXT_ATTRIBUTE_FB_BLIT,
>+					   offset, fb_ioif,
>+					   (sync << 32) | (xres << 16) | yres,
>+					   xres * BPP);	/* line_length */
>+	if (status)
>+		printk(KERN_ERR "%s: lv1_gpu_context_attribute FB_BLIT failed: %d\n",
>+		       __FUNCTION__, status);
>+#ifdef HEAD_A
>+	head = 0;
>+	status = lv1_gpu_context_attribute(ps3fb.context_handle,
>+					   L1GPU_CONTEXT_ATTRIBUTE_DISPLAY_FLIP,
>+					   head, offset, 0, 0);
>+	if (status)
>+		printk(KERN_ERR "%s: lv1_gpu_context_attribute FLIP failed: %d\n",
>+		       __FUNCTION__, status);
>+#endif
>+#ifdef HEAD_B
>+	head = 1;
>+	status = lv1_gpu_context_attribute(ps3fb.context_handle,
>+					   L1GPU_CONTEXT_ATTRIBUTE_DISPLAY_FLIP,
>+					   head, offset, 0, 0);
>+	if (status)
>+		printk(KERN_ERR "%s: lv1_gpu_context_attribute FLIP failed: %d\n",
>+		       __FUNCTION__, status);
>+#endif
>+	return 0;
>+}


[snip ps3fb_check_var that doesn't need a mode variable currently so i'd
drop it]

>+/* This routine actually sets the video mode. It's in here where we
>+ * the hardware state info->par and fix which can be affected by the
>+ * change in par. For this driver it doesn't do much.
>+ */

I can't parse the second sentence, something is missing..

>+static int ps3fb_set_par(struct fb_info *info)
>+{
>+	unsigned int mode;
>+	int i;
>+	unsigned long offset;
>+	static int first = 1;
>+
>+	DPRINTK("xres:%d xv:%d yres:%d yv:%d clock:%d\n",
>+		info->var.xres, info->var.xres_virtual,
>+		info->var.yres, info->var.yres_virtual, info->var.pixclock);
>+	i = ps3fb_get_res_table(info->var.xres, info->var.yres);
>+	ps3fb.res_index = i;
>+
>+	mode = ps3fb_find_mode(&info->var, &info->fix.line_length);
>+	if (!mode)
>+		return -EINVAL;
>+
>+	offset = FB_OFF(i) + VP_OFF(i);
>+	info->fix.smem_len = ps3fb.videomemorysize-offset;

spaces around the minus would make this more readable

>+	info->screen_base = (char __iomem *)ps3fb.xdr_ea + offset;
>+	memset(ps3fb.xdr_ea, 0, ps3fb.videomemorysize);
>+
>+	ps3fb.num_frames = ps3fb.videomemorysize/
>+			   (ps3fb_res[i].xres*ps3fb_res[i].yres*BPP);
>+
>+	/* Keep the special bits we cannot set using fb_var_screeninfo */
>+	ps3fb_mode = (ps3fb_mode & ~PS3AV_MODE_MASK) | mode;
>+
>+	if (ps3av_set_video_mode(ps3fb_mode, first))
>+		return -EINVAL;
>+
>+	first = 0;
>+	return 0;
>+}

>+    /*
>+     *  Most drivers don't need their own mmap function
>+     */

hm?

>+
>+static int ps3fb_mmap(struct fb_info *info, struct vm_area_struct *vma)
>+{
>+	unsigned long size = vma->vm_end - vma->vm_start;
>+	unsigned long offset = vma->vm_pgoff << PAGE_SHIFT;

>+	int i;
>+
>+	i = ps3fb_get_res_table(info->var.xres, info->var.yres);
>+	if (i == -1)
>+		return -EINVAL;

	unsigned long size, offset;

	if (ps3fb_get_res_table(info->var.xres, info->var.yres) == -1)
		return -EINVAL;
	
	size = vma->vm_end - vma->vm_start;
	offset = vma->vm_pgoff << PAGE_SHIFT;

perhaps ?
>+
>+	if (offset + size > info->fix.smem_len)
>+		return -EINVAL;
>+	offset += ps3fb.videomemory_phys + FB_OFF(i) + VP_OFF(i);
>+	if (remap_pfn_range(vma, vma->vm_start, offset >> PAGE_SHIFT,
>+			    size, vma->vm_page_prot))
>+		return -EAGAIN;
>+	printk(KERN_DEBUG "ps3fb: mmap framebuffer P(%lx)->V(%lx)\n", offset,
>+	       vma->vm_start);
>+	return 0;
>+}
>+
>+    /*
>+     * Blank the display
>+     */
>+
>+static int ps3fb_blank(int blank, struct fb_info *info)
>+{
>+	int retval = 0;

Not sure why you set the retval here while ps3av_set_av_video_mute seem
to allways return 0 or -1 and retval will always be set below?

>+	DPRINTK("%s: blank:%d\n", __FUNCTION__, blank);
>+	switch (blank) {
>+	case FB_BLANK_POWERDOWN:
>+	case FB_BLANK_HSYNC_SUSPEND:
>+	case FB_BLANK_VSYNC_SUSPEND:
>+	case FB_BLANK_NORMAL:
>+		retval = ps3av_video_mute(1);	/* mute on */
>+		if (!retval)
>+			ps3fb.is_blanked = 1;
>+		break;
>+	default:		/* unblank */
>+		retval = ps3av_video_mute(0);	/* mute off */
>+		if (!retval)
>+			ps3fb.is_blanked = 0;
>+		break;
>+	}
>+	return retval;
>+}


>+int ps3fb_wait_for_vsync(u32 crtc)
>+{
->+	int ret;
>+	u64 count;
>+
>+	count = ps3fb.vblank_count;
>+	ret = wait_event_interruptible_timeout(ps3fb.wait_vsync,
>+					       count != ps3fb.vblank_count,
>+					       HZ / 10);
>+	if (!ret)
>+		return -ETIMEDOUT;
>+
>+	return 0;
>+}
>+
>+EXPORT_SYMBOL(ps3fb_wait_for_vsync);
>+

>+int ps3fb_flip_ctl(int on)

void?

>+{
>+	if (on) {
>+		if (atomic_read(&ps3fb.ext_flip) > 0) {
>+			atomic_dec(&ps3fb.ext_flip);
>+		}
>+	} else {
>+		atomic_inc(&ps3fb.ext_flip);
>+	}
>+	return 0;
>+}
>+
>+EXPORT_SYMBOL(ps3fb_flip_ctl);
>+
>+    /*
>+     * ioctl
>+     */
>+
>+static int ps3fb_ioctl(struct fb_info *info, unsigned int cmd,
>+		       unsigned long arg)
>+{
>+	void __user *argp = (void __user *)arg;
>+	u32 val, old_mode;
>+	int retval = 0;
>+
>+	switch (cmd) {
>+	case FBIOGET_VBLANK:
>+		{
>+			struct fb_vblank vblank;
>+			DPRINTK("FBIOGET_VBLANK:\n");
>+			retval = ps3fb_get_vblank(&vblank);
>+			if (!retval) {
>+				if (copy_to_user(argp, &vblank,
>+						 sizeof(vblank))) {
>+					retval = -EFAULT;
>+				}
>+			}
>+			break;
>+		}
>+
>+	case FBIO_WAITFORVSYNC:
>+		{
>+			u32 crt;
>+			DPRINTK("FBIO_WAITFORVSYNC:\n");
>+			if (get_user(crt, (u32 __user *) arg)) {
>+				retval = -EFAULT;
>+				break;
>+			}
>+			retval = ps3fb_wait_for_vsync(crt);
>+			break;
>+		}
>+
>+	case PS3FB_IOCTL_SETMODE:
>+		{
>+			const struct fb_videomode *mode;
>+			struct fb_var_screeninfo var;
>+
>+			if (copy_from_user(&val, argp, sizeof(val))) {
>+				retval = -EFAULT;
>+				break;
>+			}
>+			DPRINTK("PS3FB_IOCTL_SETMODE:%x\n", val);
>+			retval = -EINVAL;

I'd default to -EFAULT and eventually set retval = 0 if !copy_from and if
all went fine (like for get_mode) but that's probably not the convention.
Didn't look recently.


>+static int __init ps3fb_init(void)
>+{
>+	int ret = 0;

ret is set here and then again set by platform_driver_register() but not
used for anything else until then. s/= 0//

>+	int status;
>+#ifndef MODULE
>+	int mode;
>+	char *option = NULL;
>+
>+	if (fb_get_options("ps3fb", &option))
>+		goto err;
>+#endif
>+
>+	if (!ps3fb_videomemory.address)
>+		goto err;
>+
>+	status = ps3av_dev_open();
>+	if (status) {
>+		printk(KERN_ERR "%s: ps3av_dev_open failed\n", __FUNCTION__);
>+		goto err;
>+	}
>+
>+	/* set gpu-driver internal video mode */
>+#ifdef HEAD_A
>+	status = lv1_gpu_context_attribute(0x0, L1GPU_CONTEXT_ATTRIBUTE_DISPLAY_MODE_SET, 0, 0, 0, 0);	/* head a */
>+	if (status) {
>+		printk(KERN_ERR "%s: lv1_gpu_context_attribute DISPLAY_MODE failed: %d\n",
>+		       __FUNCTION__, status);
>+		goto err;
>+	}
>+#endif
>+#ifdef HEAD_B
>+	status = lv1_gpu_context_attribute(0x0, L1GPU_CONTEXT_ATTRIBUTE_DISPLAY_MODE_SET, 0, 0, 1, 0);	/* head b */
>+
>+	if (status) {
>+		printk(KERN_ERR "%s: lv1_gpu_context_attribute DISPLAY_MODE failed: %d\n",
>+		       __FUNCTION__, status);
>+		goto err;
>+	}
>+#endif
>+
>+	ps3fb_mode = ps3av_get_mode();
>+	DPRINTK("ps3av_mode:%d\n", ps3fb_mode);
>+#ifndef MODULE
>+	mode = ps3fb_setup(option);	/* check boot option */
>+	if (mode)
>+		ps3fb_mode = mode;
>+#endif
>+	if (ps3fb_mode > 0) {
>+		u32 xres, yres;
>+		ps3av_video_mode2res(ps3fb_mode, &xres, &yres);
>+		ps3fb.res_index = ps3fb_get_res_table(xres, yres);
>+		DPRINTK("res_index:%d\n", ps3fb.res_index);
>+	} else
>+		ps3fb.res_index = GPU_RES_INDEX;
>+	ps3fb.videomemorysize = ps3fb_videomemory.size;
>+
>+	atomic_set(&ps3fb.f_count, -1);	/* fbcon opens ps3fb */
>+	atomic_set(&ps3fb.ext_flip, 0);	/* for flip with vsync */
>+	init_MUTEX(&ps3fb.sem);
>+	init_waitqueue_head(&ps3fb.wait_vsync);
>+	ps3fb.num_frames = 1;
>+	ret = platform_driver_register(&ps3fb_driver);
>+
>+	if (!ret) {
>+		ret = platform_device_register(&ps3fb_device);
>+		if (ret)
>+			platform_driver_unregister(&ps3fb_driver);
>+	}
>+
>+	register_reboot_notifier(&ps3fb_reboot_nb);
>+	ps3fb_set_sync();
>+
>+	return ret;
>+
>+err:
>+	return -ENXIO;
>+}
>+

cheers,
