Message-Id: <200008191942.VAA00720@piglet.grunz.lu>
Date: Sat, 19 Aug 2000 21:42:17 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: mmap for controlfb (was: Re: some stuff about controlfb in 2.2)
To: olh@suse.de
cc: linux-fbdev@vuser.vu.union.edu, linuxppc-dev@lists.linuxppc.org,
        geert@linux-m68k.org
In-Reply-To: <Pine.LNX.4.10.10008182259040.378-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: MULTIPART/mixed; BOUNDARY="134458388-1804289383-966714147=:718"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--134458388-1804289383-966714147=:718
Content-Type: TEXT/plain; charset=us-ascii

Hi all,

>> I would like to attach the mentioned kernel patch to improve
>> performance, have no idea yet how to benchmark it.

Question here is how do we change the caching attributes for the
framebuffer mmap in fbem.c, if we are running controlfb. This is the
quick&dirty hack:

>> diff -urN linux-2.2.16.SuSE.orig/drivers/video/fbmem.c linux-2.2.16.SuSE/drivers/video/fbmem.c
>> --- linux-2.2.16.SuSE.orig/drivers/video/fbmem.c        Thu Aug 17 02:23:14 2000
>> +++ linux-2.2.16.SuSE/drivers/video/fbmem.c     Fri Aug 18 11:04:46 2000
>> @@ -577,7 +577,13 @@
>>                 pgprot_val(vma->vm_page_prot) |= _PAGE_NOCACHE_S;
>>         }
>>  #elif defined(__powerpc__)
>> -       pgprot_val(vma->vm_page_prot) |= _PAGE_NO_CACHE|_PAGE_GUARDED;
>> +       /* set mode for controlfb in PowerMacs
>> +        * see http://www.cpu.lu/~mlan/linux/dev/xf4.html
>> +        */
>> +       if(find_devices("control"))
>> +               pgprot_val(vma->vm_page_prot) |= _PAGE_WRITETHRU;
>> +       else
>> +               pgprot_val(vma->vm_page_prot) |= _PAGE_NO_CACHE|_PAGE_GUARDED;
>>  #elif defined(__alpha__)
>>         /* Caching is off in the I/O space quadrant by design.  */
>>  #elif defined(__i386__)

> I think the better way to handle this would be to provide a
> device-specific mmap function in the framebuffers that benefit from the
> changed caching. On Macs, all unaccelerated framebuffers should fall
> under that category.

So I went ahead and implemented mmap for controlfb. It's attached below
in versions for both 2.2 and 2.4 kernels.

I've not been able to test any of these, since all my recent kernels
(both 2.2 and 2.4) refuse to boot. So, can all of those concerned please
test this and let me know how it works out?

Thanks

Michel

PS There might be a few printk's littered in there to report what's
going on...

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "

--134458388-1804289383-966714147=:718
Content-Type: TEXT/plain; CHARSET=US-ASCII
Content-Disposition: attachment; filename="mmap-2.2-patch"

--- linux-2.2.16-pristine/drivers/video/fbmem.c	Fri May  5 14:55:01 2000
+++ linux-2.2.16/drivers/video/fbmem.c	Sat Aug 19 18:45:44 2000
@@ -214,7 +214,7 @@
 static int last_fb_vc = MAX_NR_CONSOLES-1;
 static int fbcon_is_default = 1;

-static int PROC_CONSOLE(struct fb_info *info)
+int PROC_CONSOLE(struct fb_info *info)
 {
 	int fgc;

--- linux-2.2.16-pristine/include/video/fbcon.h	Thu Feb 25 19:02:12 1999
+++ linux-2.2.16/include/video/fbcon.h	Sat Aug 19 18:39:10 2000
@@ -40,6 +40,7 @@
 };

 extern struct display_switch fbcon_dummy;
+extern int PROC_CONSOLE(const struct fb_info *info);

 #define fontheight(p) ((p)->_fontheight)
 #define fontheightlog(p) ((p)->_fontheightlog)
--- linux-2.2.16-pristine/drivers/video/controlfb.c	Wed Sep 15 07:48:12 1999
+++ linux-2.2.16/drivers/video/controlfb.c	Sat Aug 19 18:46:19 2000
@@ -126,6 +126,8 @@
 			  struct fb_info *info);
 static int control_ioctl(struct inode *inode, struct file *file, u_int cmd,
 		       u_long arg, int con, struct fb_info *info);
+static int control_mmap(struct fb_info *info, struct file *file,
+			struct vm_area_struct *vma);


 static int controlfb_getcolreg(u_int regno, u_int *red, u_int *green,
@@ -178,7 +180,8 @@
 	control_get_cmap,
 	control_set_cmap,
 	control_pan_display,
-	control_ioctl
+	control_ioctl,
+	control_mmap
 };


@@ -356,6 +359,54 @@
 		       u_long arg, int con, struct fb_info *info)
 {
 	return -EINVAL;
+}
+
+/* Private mmap since we want to have a different caching on the framebuffer
+ * for controlfb.
+ * Note there's no locking in here; it's done in fb_mmap() in fbmem.c.
+ */
+static int control_mmap(struct fb_info *info, struct file *file,
+			struct vm_area_struct *vma)
+{
+	struct fb_ops *fb = info->fbops;
+	struct fb_fix_screeninfo fix;
+	struct fb_var_screeninfo var;
+	unsigned long start;
+	u32 len;
+
+	fb->fb_get_fix(&fix, PROC_CONSOLE(info), info);
+printk(KERN_INFO "controlfb: Yeah, using new mmap!!\n");
+
+	/* frame buffer memory */
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

 /********************  End of controlfb_ops implementation  ********************/

--134458388-1804289383-966714147=:718
Content-Type: TEXT/plain; CHARSET=US-ASCII
Content-Disposition: attachment; filename="mmap-2.4-patch"

--- linux-2.4.0-test6/drivers/video/controlfb.c	Fri Aug 18 23:09:26 2000
+++ linux-2.4.0-test7/drivers/video/controlfb.c	Sat Aug 19 17:47:49 2000
@@ -127,6 +127,8 @@
 			  struct fb_info *info);
 static int control_set_cmap(struct fb_cmap *cmap, int kspc, int con,
 			  struct fb_info *info);
+static int control_mmap(struct fb_info *info, struct file *file,
+			  struct vm_area_struct *vma);


 static int controlfb_getcolreg(u_int regno, u_int *red, u_int *green,
@@ -176,6 +178,7 @@
 	fb_get_cmap:	control_get_cmap,
 	fb_set_cmap:	control_set_cmap,
 	fb_pan_display:	control_pan_display,
+	fb_mmap:	control_mmap,
 };


@@ -332,6 +335,47 @@
 	return 0;
 }

+/* Private mmap since we want to have a different caching on the framebuffer
+ * for controlfb.
+ * Note there's no locking in here; it's done in fb_mmap() in fbmem.c.
+ */
+static int control_mmap(struct fb_info *info, struct file *file,
+			struct vm_area_struct *vma)
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
+	return 0;
+}
+
 /********************  End of controlfb_ops implementation  ********************/
 /* (new one that is) */


--134458388-1804289383-966714147=:718--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
