Return-Path: <geert@sonycom.com>
Message-Id: <20071008161614.419556000@pademelon.sonytel.be>
References: <20071008161421.818458000@pademelon.sonytel.be>
Date: Mon, 08 Oct 2007 18:14:26 +0200
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>,
	linux-fbdev-devel@lists.sourceforge.net
Subject: [patch 5/9] ps3fb: Fix possible overlap of GPU command buffer and
	frame buffer
Sender: Geert Uytterhoeven <geert@sonycom.com>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

ps3fb: In the case of non-fullscreen video modes, there was a partial overlap
of the GPU command buffer and the frame buffer. Fix and cleanup various issues
with overlap and alignment:
  - Move the GPU command buffer from the beginning to the end of video memory
  - Exclude the GPU command buffer from the actual frame buffer memory
  - Align the start of the virtual frame buffer to PAGE_SIZE instead of to 64
    KiB, and don't waste memory if it's already aligned (for fullscreen modes)
  - Take into account the alignment when checking memory requirements and
    maximum number of frames
  - Make sure fb_fix_screeninfo.smem_start always points to the virtual frame
    buffer start, so we don't have to compensate for that in ps3fb_mmap()

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 drivers/video/ps3fb.c |   66 +++++++++++++++++++++++++++++---------------------
 1 files changed, 39 insertions(+), 27 deletions(-)

--- a/drivers/video/ps3fb.c
+++ b/drivers/video/ps3fb.c
@@ -52,7 +52,7 @@
 #define L1GPU_DISPLAY_SYNC_VSYNC		2
 
 #define DDR_SIZE				(0)	/* used no ddr */
-#define GPU_OFFSET				(64 * 1024)
+#define GPU_CMD_BUF_SIZE			(64 * 1024)
 #define GPU_IOIF				(0x0d000000UL)
 
 #define PS3FB_FULL_MODE_BIT			0x80
@@ -117,6 +117,7 @@ struct ps3fb_priv {
 
 	u64 context_handle, memory_handle;
 	void *xdr_ea;
+	size_t xdr_size;
 	struct gpu_driver_info *dinfo;
 	u32 res_index;
 
@@ -280,9 +281,20 @@ static const struct fb_videomode ps3fb_m
 #define Y_OFF(i)	(ps3fb_res[i].yoff)	/* top/bottom margin (pixel) */
 #define WIDTH(i)	(ps3fb_res[i].xres)	/* width of FB */
 #define HEIGHT(i)	(ps3fb_res[i].yres)	/* height of FB */
-#define BPP	4		/* number of bytes per pixel */
-#define VP_OFF(i)	(WIDTH(i) * Y_OFF(i) * BPP + X_OFF(i) * BPP)
-#define FB_OFF(i)	(GPU_OFFSET - VP_OFF(i) % GPU_OFFSET)
+#define BPP		4			/* number of bytes per pixel */
+
+/* Start of the virtual frame buffer (relative to fullscreen ) */
+#define VP_OFF(i)	((WIDTH(i) * Y_OFF(i) + X_OFF(i)) * BPP)
+
+/*
+ * Start of the virtual frame buffer (relative to start of video memory)
+ * This is PAGE_SIZE aligned for easier mmap()
+ */
+#define VFB_OFF(i)	PAGE_ALIGN(VP_OFF(i))
+
+/* Start of the fullscreen frame buffer (relative to start of video memory) */
+#define FB_OFF(i)	(-VP_OFF(i) & ~PAGE_MASK)
+
 
 static int ps3fb_mode;
 module_param(ps3fb_mode, int, 0);
@@ -517,7 +529,8 @@ static int ps3fb_check_var(struct fb_var
 
 	/* Memory limit */
 	i = ps3fb_get_res_table(var->xres, var->yres, mode);
-	if (ps3fb_res[i].xres*ps3fb_res[i].yres*BPP > ps3fb_videomemory.size) {
+	if (ps3fb_res[i].xres*ps3fb_res[i].yres*BPP >
+	    ps3fb.xdr_size - VFB_OFF(i)) {
 		dev_dbg(info->device, "Not enough memory\n");
 		return -ENOMEM;
 	}
@@ -549,12 +562,13 @@ static int ps3fb_set_par(struct fb_info 
 	i = ps3fb_get_res_table(info->var.xres, info->var.yres, mode);
 	ps3fb.res_index = i;
 
-	offset = FB_OFF(i) + VP_OFF(i);
-	info->fix.smem_len = ps3fb_videomemory.size - offset;
+	offset = VFB_OFF(i);
+	info->fix.smem_start = virt_to_abs(ps3fb.xdr_ea) + offset;
+	info->fix.smem_len = ps3fb.xdr_size - offset;
 	info->screen_base = (char __iomem *)ps3fb.xdr_ea + offset;
-	memset(ps3fb.xdr_ea, 0, ps3fb_videomemory.size);
+	memset(ps3fb.xdr_ea, 0, ps3fb.xdr_size);
 
-	ps3fb.num_frames = ps3fb_videomemory.size/
+	ps3fb.num_frames = info->fix.smem_len/
 			   (ps3fb_res[i].xres*ps3fb_res[i].yres*BPP);
 
 	/* Keep the special bits we cannot set using fb_var_screeninfo */
@@ -596,18 +610,13 @@ static int ps3fb_setcolreg(unsigned int 
 static int ps3fb_mmap(struct fb_info *info, struct vm_area_struct *vma)
 {
 	unsigned long size, offset;
-	int i;
-
-	i = ps3fb_get_res_table(info->var.xres, info->var.yres, ps3fb_mode);
-	if (i == -1)
-		return -EINVAL;
 
 	size = vma->vm_end - vma->vm_start;
 	offset = vma->vm_pgoff << PAGE_SHIFT;
 	if (offset + size > info->fix.smem_len)
 		return -EINVAL;
 
-	offset += info->fix.smem_start + FB_OFF(i) + VP_OFF(i);
+	offset += info->fix.smem_start;
 	if (remap_pfn_range(vma, vma->vm_start, offset >> PAGE_SHIFT,
 			    size, vma->vm_page_prot))
 		return -EAGAIN;
@@ -899,8 +908,9 @@ static int ps3fb_xdr_settings(u64 xdr_lp
 
 	status = lv1_gpu_context_attribute(ps3fb.context_handle,
 					   L1GPU_CONTEXT_ATTRIBUTE_FB_SETUP,
-					   xdr_lpar, ps3fb_videomemory.size,
-					   GPU_IOIF, 0);
+					   xdr_lpar + ps3fb.xdr_size,
+					   GPU_CMD_BUF_SIZE,
+					   GPU_IOIF + ps3fb.xdr_size, 0);
 	if (status) {
 		dev_err(dev,
 			"%s: lv1_gpu_context_attribute FB_SETUP failed: %d\n",
@@ -1038,29 +1048,31 @@ static int __devinit ps3fb_probe(struct 
 	if (retval)
 		goto err_iounmap_dinfo;
 
-	/* xdr frame buffer */
+	/* XDR frame buffer */
 	ps3fb.xdr_ea = ps3fb_videomemory.address;
 	xdr_lpar = ps3_mm_phys_to_lpar(__pa(ps3fb.xdr_ea));
+
+	/* Clear memory to prevent kernel info leakage into userspace */
+	memset(ps3fb.xdr_ea, 0, ps3fb_videomemory.size);
+
+	/* The GPU command buffer is at the end of video memory */
+	ps3fb.xdr_size = ps3fb_videomemory.size - GPU_CMD_BUF_SIZE;
+
 	retval = ps3fb_xdr_settings(xdr_lpar, &dev->core);
 	if (retval)
 		goto err_free_irq;
 
-	/*
-	 * ps3fb must clear memory to prevent kernel info
-	 * leakage into userspace
-	 */
-	memset(ps3fb.xdr_ea, 0, ps3fb_videomemory.size);
 	info = framebuffer_alloc(sizeof(u32) * 16, &dev->core);
 	if (!info)
 		goto err_free_irq;
 
-	offset = FB_OFF(ps3fb.res_index) + VP_OFF(ps3fb.res_index);
+	offset = VFB_OFF(ps3fb.res_index);
 	info->screen_base = (char __iomem *)ps3fb.xdr_ea + offset;
 	info->fbops = &ps3fb_ops;
 
 	info->fix = ps3fb_fix;
-	info->fix.smem_start = virt_to_abs(ps3fb.xdr_ea);
-	info->fix.smem_len = ps3fb_videomemory.size - offset;
+	info->fix.smem_start = virt_to_abs(ps3fb.xdr_ea) + offset;
+	info->fix.smem_len = ps3fb.xdr_size - offset;
 	info->pseudo_palette = info->par;
 	info->par = NULL;
 	info->flags = FBINFO_DEFAULT | FBINFO_READS_FAST;
@@ -1086,7 +1098,7 @@ static int __devinit ps3fb_probe(struct 
 
 	dev_info(info->device, "%s %s, using %lu KiB of video memory\n",
 		 dev_driver_string(info->dev), info->dev->bus_id,
-		 ps3fb_videomemory.size >> 10);
+		 ps3fb.xdr_size >> 10);
 
 	task = kthread_run(ps3fbd, info, DEVICE_NAME);
 	if (IS_ERR(task)) {

-- 
With kind regards,
 
Geert Uytterhoeven
Software Architect

Sony Network and Software Technology Center Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium
 
Phone:    +32 (0)2 700 8453	
Fax:      +32 (0)2 700 8622	
E-mail:   Geert.Uytterhoeven@sonycom.com	
Internet: http://www.sony-europe.com/
 	
Sony Network and Software Technology Center Europe	
A division of Sony Service Centre (Europe) N.V.	
Registered office: Technologielaan 7 · B-1840 Londerzeel · Belgium	
VAT BE 0413.825.160 · RPR Brussels	
Fortis Bank Zaventem · Swift GEBABEBB08A · IBAN BE39001382358619
