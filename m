Message-Id: <200009132110.XAA04545@piglet.grunz.lu>
Date: Wed, 13 Sep 2000 23:10:22 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: per-fb mmap for platinumfb and valkyriefb in 2.4 (and 2.2)
To: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <200009132037.WAA00873@piglet.grunz.lu>
MIME-Version: 1.0
Content-Type: MULTIPART/mixed; BOUNDARY="134458388-1804289383-968879428=:814"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--134458388-1804289383-968879428=:814
Content-Type: TEXT/plain; charset=us-ascii

Hi all,

On  13 Sep, this message from mlan echoed through cyberspace:
> Below is the per-fb mmap implementation

Err.. nothing was below. Stupid /me... it's getting late.

Anyway, here it is for both 2.2 and 2.4. Note that to compile on 2.2,
you need my controlfb patch implementing mmap as well, since without it,
this one won't compile (get it on sourceforge).

Have fun!

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "

--134458388-1804289383-968879428=:814
Content-Type: TEXT/plain; CHARSET=US-ASCII
Content-Disposition: attachment; filename="2.2-powermacfb.diff"

--- linux-2.2.17-pristine/drivers/video/valkyriefb.c	Thu Oct  1 19:02:21 1998
+++ linux-2.2.17/drivers/video/valkyriefb.c	Wed Sep 13 22:56:33 2000
@@ -133,6 +133,8 @@
 			  struct fb_info *info);
 static int valkyrie_ioctl(struct inode *inode, struct file *file, u_int cmd,
 		       u_long arg, int con, struct fb_info *info);
+static int valkyrie_mmap(struct fb_info *info, struct file *file,
+			 struct vm_area_struct *vma);

 static int read_valkyrie_sense(struct fb_info_valkyrie *p);
 static inline int valkyrie_vram_reqd(int video_mode, int color_mode);
@@ -159,7 +161,8 @@
 	valkyrie_get_cmap,
 	valkyrie_set_cmap,
 	valkyrie_pan_display,
-	valkyrie_ioctl
+	valkyrie_ioctl,
+	valkyrie_mmap
 };

 static int valkyriefb_getcolreg(u_int regno, u_int *red, u_int *green,
@@ -308,6 +311,52 @@
 		       u_long arg, int con, struct fb_info *info)
 {
 	return -EINVAL;
+}
+
+/* Private mmap since we want to have a different caching on the framebuffer
+ * for valkyriefb.
+ * Note there's no locking in here; it's done in fb_mmap() in fbmem.c.
+ */
+static int valkyrie_mmap(struct fb_info *info, struct file *file,
+			struct vm_area_struct *vma)
+{
+	struct fb_ops *fb = info->fbops;
+	struct fb_fix_screeninfo fix;
+	struct fb_var_screeninfo var;
+	unsigned long start;
+	u32 len;
+
+	fb->fb_get_fix(&fix, PROC_CONSOLE(info), info);
+
+	start = (unsigned long)fix.smem_start;
+	len = (start & ~PAGE_MASK)+fix.smem_len;
+	len = (len+~PAGE_MASK) & PAGE_MASK;
+	if (vma->vm_offset >= len) {
+		/* memory mapped io */
+		vma->vm_offset -= len;
+		fb->fb_get_var(&var, PROC_CONSOLE(info), info);
+		if (var.accel_flags)
+			return -EINVAL;
+		start = (unsigned long)fix.mmio_start;
+		len = (start & ~PAGE_MASK)+fix.mmio_len;
+		len = (len+~PAGE_MASK) & PAGE_MASK;
+		pgprot_val(vma->vm_page_prot) |= _PAGE_NO_CACHE|_PAGE_GUARDED;
+	} else {
+		/* framebuffer */
+		pgprot_val(vma->vm_page_prot) |= _PAGE_WRITETHRU;
+	}
+	start &= PAGE_MASK;
+	if ((vma->vm_end - vma->vm_start + vma->vm_offset) > len)
+		return -EINVAL;
+	vma->vm_offset += start;
+	if (vma->vm_offset & ~PAGE_MASK)
+		return -ENXIO;
+
+	if (remap_page_range(vma->vm_start, vma->vm_offset,
+			     vma->vm_end - vma->vm_start, vma->vm_page_prot))
+		return -EAGAIN;
+
+	return 0;
 }

 static int valkyriefb_switch(int con, struct fb_info *fb)
--- linux-2.2.17-pristine/drivers/video/platinumfb.c	Wed Sep 15 07:48:12 1999
+++ linux-2.2.17/drivers/video/platinumfb.c	Wed Sep 13 23:00:54 2000
@@ -118,6 +118,8 @@
 			     struct fb_info *info);
 static int platinum_ioctl(struct inode *inode, struct file *file, u_int cmd,
 			  u_long arg, int con, struct fb_info *info);
+static int platinum_mmap(struct fb_info *info, struct file *file,
+			 struct vm_area_struct *vma);


 /*
@@ -175,7 +177,8 @@
 	platinum_get_cmap,
 	platinum_set_cmap,
 	platinum_pan_display,
-	platinum_ioctl
+	platinum_ioctl,
+	platinum_mmap
 };


@@ -377,6 +380,52 @@
 {
 	printk(KERN_ERR "platinum_ioctl not yet implemented\n");
 	return -EINVAL;
+}
+
+/* Private mmap since we want to have a different caching on the framebuffer
+ * for platinumfb.
+ * Note there's no locking in here; it's done in fb_mmap() in fbmem.c.
+ */
+static int platinum_mmap(struct fb_info *info, struct file *file,
+			 struct vm_area_struct *vma)
+{
+	struct fb_ops *fb = info->fbops;
+	struct fb_fix_screeninfo fix;
+	struct fb_var_screeninfo var;
+	unsigned long start;
+	u32 len;
+
+	fb->fb_get_fix(&fix, PROC_CONSOLE(info), info);
+
+	start = (unsigned long)fix.smem_start;
+	len = (start & ~PAGE_MASK)+fix.smem_len;
+	len = (len+~PAGE_MASK) & PAGE_MASK;
+	if (vma->vm_offset >= len) {
+		/* memory mapped io */
+		vma->vm_offset -= len;
+		fb->fb_get_var(&var, PROC_CONSOLE(info), info);
+		if (var.accel_flags)
+			return -EINVAL;
+		start = (unsigned long)fix.mmio_start;
+		len = (start & ~PAGE_MASK)+fix.mmio_len;
+		len = (len+~PAGE_MASK) & PAGE_MASK;
+		pgprot_val(vma->vm_page_prot) |= _PAGE_NO_CACHE|_PAGE_GUARDED;
+	} else {
+		/* framebuffer */
+		pgprot_val(vma->vm_page_prot) |= _PAGE_WRITETHRU;
+	}
+	start &= PAGE_MASK;
+	if ((vma->vm_end - vma->vm_start + vma->vm_offset) > len)
+		return -EINVAL;
+	vma->vm_offset += start;
+	if (vma->vm_offset & ~PAGE_MASK)
+		return -ENXIO;
+
+	if (remap_page_range(vma->vm_start, vma->vm_offset,
+			     vma->vm_end - vma->vm_start, vma->vm_page_prot))
+		return -EAGAIN;
+
+	return 0;
 }

 static int platinum_switch(int con, struct fb_info *fb)

--134458388-1804289383-968879428=:814
Content-Type: TEXT/plain; CHARSET=US-ASCII
Content-Disposition: attachment; filename="2.4-powermacfb.diff"

--- linux-2.4.paul/drivers/video/platinumfb.c	Sat Aug  5 09:40:52 2000
+++ linux/drivers/video/platinumfb.c	Wed Sep 13 22:06:57 2000
@@ -111,6 +111,8 @@
 			     struct fb_info *info);
 static int platinum_set_cmap(struct fb_cmap *cmap, int kspc, int con,
 			     struct fb_info *info);
+static int platinum_mmap(struct fb_info *info, struct file *file,
+			     struct vm_area_struct *vma);


 /*
@@ -163,6 +165,7 @@
 	fb_set_var:	platinum_set_var,
 	fb_get_cmap:	platinum_get_cmap,
 	fb_set_cmap:	platinum_set_cmap,
+	fb_mmap:	platinum_mmap,
 };

 static int platinum_get_fix(struct fb_fix_screeninfo *fix, int con,
@@ -326,6 +329,47 @@
 		return fb_set_cmap(cmap, kspc, platinum_setcolreg, info);
 	else
 		fb_copy_cmap(cmap, &disp->cmap, kspc ? 0 : 1);
+	return 0;
+}
+
+/* Private mmap since we want to have a different caching on the framebuffer
+ * for platinumfb.
+ * Note there's no locking in here; it's done in fb_mmap() in fbmem.c.
+ */
+static int platinum_mmap(struct fb_info *info, struct file *file,
+			 struct vm_area_struct *vma)
+{
+	struct fb_ops *fb = info->fbops;
+	struct fb_fix_screeninfo fix;
+	struct fb_var_screeninfo var;
+	unsigned long off, start;
+	u32 len;
+
+	fb->fb_get_fix(&fix, PROC_CONSOLE(info), info);
+	off = vma->vm_pgoff << PAGE_SHIFT;
+
+	/* frame buffer memory */
+	start = fix.smem_start;
+	len = PAGE_ALIGN((start & ~PAGE_MASK)+fix.smem_len);
+	if (off >= len) {
+		/* memory mapped io */
+		off -= len;
+		fb->fb_get_var(&var, PROC_CONSOLE(info), info);
+		if (var.accel_flags)
+			return -EINVAL;
+		start = fix.mmio_start;
+		len = PAGE_ALIGN((start & ~PAGE_MASK)+fix.mmio_len);
+		pgprot_val(vma->vm_page_prot) |= _PAGE_NO_CACHE|_PAGE_GUARDED;
+	} else {
+		/* framebuffer */
+		pgprot_val(vma->vm_page_prot) |= _PAGE_WRITETHRU;
+	}
+	start &= PAGE_MASK;
+	vma->vm_pgoff = off >> PAGE_SHIFT;
+	if (io_remap_page_range(vma->vm_start, off,
+	    vma->vm_end - vma->vm_start, vma->vm_page_prot))
+		return -EAGAIN;
+
 	return 0;
 }

--- linux-2.4.paul/drivers/video/valkyriefb.c	Fri Aug 25 03:17:16 2000
+++ linux/drivers/video/valkyriefb.c	Wed Sep 13 22:20:39 2000
@@ -128,6 +128,8 @@
 			  struct fb_info *info);
 static int valkyrie_set_cmap(struct fb_cmap *cmap, int kspc, int con,
 			  struct fb_info *info);
+static int valkyrie_mmap(struct fb_info *info, struct file *file,
+			  struct vm_area_struct *vma);

 static int read_valkyrie_sense(struct fb_info_valkyrie *p);
 static inline int valkyrie_vram_reqd(int video_mode, int color_mode);
@@ -152,6 +154,7 @@
 	fb_set_var:	valkyrie_set_var,
 	fb_get_cmap:	valkyrie_get_cmap,
 	fb_set_cmap:	valkyrie_set_cmap,
+	fb_mmap:	valkyrie_mmap,
 };

 static int valkyriefb_getcolreg(u_int regno, u_int *red, u_int *green,
@@ -269,6 +272,47 @@
 		return fb_set_cmap(cmap, kspc, valkyriefb_setcolreg, info);
 	}
 	fb_copy_cmap(cmap, &disp->cmap, kspc ? 0 : 1);
+	return 0;
+}
+
+/* Private mmap since we want to have a different caching on the framebuffer
+ * for valkyriefb.
+ * Note there's no locking in here; it's done in fb_mmap() in fbmem.c.
+ */
+static int valkyrie_mmap(struct fb_info *info, struct file *file,
+			 struct vm_area_struct *vma)
+{
+	struct fb_ops *fb = info->fbops;
+	struct fb_fix_screeninfo fix;
+	struct fb_var_screeninfo var;
+	unsigned long off, start;
+	u32 len;
+
+	fb->fb_get_fix(&fix, PROC_CONSOLE(info), info);
+	off = vma->vm_pgoff << PAGE_SHIFT;
+
+	/* frame buffer memory */
+	start = fix.smem_start;
+	len = PAGE_ALIGN((start & ~PAGE_MASK)+fix.smem_len);
+	if (off >= len) {
+		/* memory mapped io */
+		off -= len;
+		fb->fb_get_var(&var, PROC_CONSOLE(info), info);
+		if (var.accel_flags)
+			return -EINVAL;
+		start = fix.mmio_start;
+		len = PAGE_ALIGN((start & ~PAGE_MASK)+fix.mmio_len);
+		pgprot_val(vma->vm_page_prot) |= _PAGE_NO_CACHE|_PAGE_GUARDED;
+	} else {
+		/* framebuffer */
+		pgprot_val(vma->vm_page_prot) |= _PAGE_WRITETHRU;
+	}
+	start &= PAGE_MASK;
+	vma->vm_pgoff = off >> PAGE_SHIFT;
+	if (io_remap_page_range(vma->vm_start, off,
+	    vma->vm_end - vma->vm_start, vma->vm_page_prot))
+		return -EAGAIN;
+
 	return 0;
 }


--134458388-1804289383-968879428=:814--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
