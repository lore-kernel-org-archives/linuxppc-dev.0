Message-Id: <200011181831.TAA00710@piglet.grunz.lu>
Date: Sat, 18 Nov 2000 19:31:35 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: controlfb and X (fixed)
To: bob@kunk.jriver.com, bh40@calva.net,
        Paul Mackerras <paulus@linuxcare.com.au>
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20001107212230.7256.qmail@kunk.jriver.com>
MIME-Version: 1.0
Content-Type: MULTIPART/mixed; BOUNDARY="134458388-1804289383-974572302=:708"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--134458388-1804289383-974572302=:708
Content-Type: TEXT/plain; charset=us-ascii

Hi all,

Some time ago, there were reports of crashes with controlfb and 2.4
kernels, while starting XF4.0.

I've taken a look, and it seems that indeed the mmap code recently added
to controlfb is to blame.

Below is the patch that fixes the hanging box while starting X for me.
It seems while implementing mmap() for 2.4 kernels in controlfb, I
forgot to copy 2 lines :-((

Ben and Paul, could you apply this patch to all your 2.4 / 2.5 trees? It
also fixes the 7_spaces_instead_of_tab problem in the mmap() code ;-)

Cheers, happy hacking, and sorry for this bug :-)

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "

--134458388-1804289383-974572302=:708
Content-Type: TEXT/plain; CHARSET=US-ASCII
Content-Disposition: attachment; filename="2.4-control-mmap-fix.diff"

--- /mnt/r4/usr/src/linux-2.4.paul/drivers/video/controlfb.c	Thu Oct 19 03:36:07 2000
+++ linux-2.4.0-test10/drivers/video/controlfb.c	Sat Nov 18 19:23:10 2000
@@ -338,38 +343,41 @@
 static int control_mmap(struct fb_info *info, struct file *file,
                        struct vm_area_struct *vma)
 {
-       struct fb_ops *fb = info->fbops;
-       struct fb_fix_screeninfo fix;
-       struct fb_var_screeninfo var;
-       unsigned long off, start;
-       u32 len;
-
-       fb->fb_get_fix(&fix, PROC_CONSOLE(info), info);
-       off = vma->vm_pgoff << PAGE_SHIFT;
-
-       /* frame buffer memory */
-       start = fix.smem_start;
-       len = PAGE_ALIGN((start & ~PAGE_MASK)+fix.smem_len);
-       if (off >= len) {
-               /* memory mapped io */
-               off -= len;
-               fb->fb_get_var(&var, PROC_CONSOLE(info), info);
-               if (var.accel_flags)
-                       return -EINVAL;
-               start = fix.mmio_start;
-               len = PAGE_ALIGN((start & ~PAGE_MASK)+fix.mmio_len);
-               pgprot_val(vma->vm_page_prot) |= _PAGE_NO_CACHE|_PAGE_GUARDED;
-       } else {
-               /* framebuffer */
-               pgprot_val(vma->vm_page_prot) |= _PAGE_WRITETHRU;
-       }
-       start &= PAGE_MASK;
-       vma->vm_pgoff = off >> PAGE_SHIFT;
-       if (io_remap_page_range(vma->vm_start, off,
-           vma->vm_end - vma->vm_start, vma->vm_page_prot))
-               return -EAGAIN;
+	struct fb_ops *fb = info->fbops;
+	struct fb_fix_screeninfo fix;
+	struct fb_var_screeninfo var;
+	unsigned long off, start;
+	u32 len;

-       return 0;
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
+	if ((vma->vm_end - vma->vm_start + off) > len)
+		return -EINVAL;
+	off += start;
+	vma->vm_pgoff = off >> PAGE_SHIFT;
+	if (io_remap_page_range(vma->vm_start, off,
+	    vma->vm_end - vma->vm_start, vma->vm_page_prot))
+		return -EAGAIN;
+
+	return 0;
 }



--134458388-1804289383-974572302=:708--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
