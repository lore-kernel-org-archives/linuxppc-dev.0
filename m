Message-ID: <398EA2B0.C5B16FA6@student.ethz.ch>
Date: Mon, 07 Aug 2000 13:51:12 +0200
From: Michel Dänzer <daenzerm@student.ethz.ch>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: [PATCH] r128 DRM module, aty128fb panning
Content-Type: multipart/mixed;
 boundary="------------7C426FB160227283A8A6F935"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------7C426FB160227283A8A6F935
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit



These patches are against today's linux-pmac-devel (2.4.0-test6).


The first one makes the Rage128 DRM module build and work, I've successfully
run several DRI apps with it.


The second one fixes panning in aty128fb, I can now start X with big virtual
resolutions and scroll around.


Is someone picking these up now, or where should I put them?


Michel


PS: This kernel installs the modules to very unusual places, so my modutils
don't find them - are working modutils (which version?) available?

--
There's no place like ~
______________________________________________________________________________
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86, Team *AMIGA*, AUGS
--------------7C426FB160227283A8A6F935
Content-Type: text/plain; charset=us-ascii;
 name="drm-r128.diff"
Content-Disposition: inline;
 filename="drm-r128.diff"
Content-Transfer-Encoding: 7bit

--- drivers/char/drm/drmP.h.orig	Mon Aug  7 12:00:38 2000
+++ drivers/char/drm/drmP.h	Mon Aug  7 12:03:23 2000
@@ -143,6 +143,7 @@
 #ifndef __HAVE_ARCH_CMPXCHG
 				/* Include this here so that driver can be
                                    used with older kernels. */
+#if defined(__i386__)
 static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
 				      unsigned long new, int size)
 {
@@ -169,6 +170,33 @@
 	}
 	return old;
 }
+#elif defined(__powerpc__)
+extern void __cmpxchg_called_with_bad_pointer(void);
+static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
+                                      unsigned long new, int size)
+{
+        unsigned long prev;
+
+        switch (size) {
+        case 4:
+           __asm__ __volatile__(
+                                "sync;"
+                                "0:    lwarx %0,0,%1 ;"
+                                "      cmpl 0,%0,%3;"
+                                "      bne 1f;"
+                                "      stwcx. %2,0,%1;"
+                                "      bne- 0b;"
+                                "1:    "
+                                "sync;"
+                                : "=&r"(prev)
+                                : "r"(ptr), "r"(new), "r"(old)
+                                : "cr0", "memory");
+            return prev;
+        }
+        __cmpxchg_called_with_bad_pointer();
+        return old;
+}
+#endif

 #define cmpxchg(ptr,o,n)						\
   ((__typeof__(*(ptr)))__cmpxchg((ptr),(unsigned long)(o),		\
--- drivers/char/drm/r128_drv.h.orig	Mon Aug  7 12:17:42 2000
+++ drivers/char/drm/r128_drv.h	Mon Aug  7 12:18:30 2000
@@ -197,6 +197,43 @@
 #define R128_MAX_USEC_TIMEOUT	100000	/* 100 ms */


+#ifdef __powerpc__
+
+static __inline__ void
+WriteMmio32Le(void *base, const unsigned long offset,
+                  const unsigned long val)
+{
+        __asm__ __volatile__(
+                        "stwbrx %1,%2,%3\n\t"
+                        : "=m" (*(volatile unsigned char *)(base+offset))
+                        : "r" (val), "b" (base), "r" (offset));
+}
+
+static __inline__ unsigned int
+ReadMmio32Le(void *base, const unsigned long offset)
+{
+        register unsigned int val;
+        __asm__ __volatile__(
+                        "lwbrx %0,%1,%2\n\t"
+                        "eieio"
+                        : "=r" (val)
+                        : "b" (base), "r" (offset),
+                        "m" (*(volatile unsigned char *)(base+offset)));
+        return(val);
+}
+
+#define R128_BASE(reg)		((u32)(dev_priv->mmio->handle))
+#define R128_ADDR(reg)		(R128_BASE(reg) + reg)
+
+#define R128_READ(reg)		ReadMmio32Le(R128_BASE(reg),reg)
+#define R128_WRITE(reg,val)	WriteMmio32Le(R128_BASE(reg),reg,val)
+
+#define R128_DEREF8(reg)	*(__volatile__ char *)R128_ADDR(reg)
+#define R128_READ8(reg)		R128_DEREF8(reg)
+#define R128_WRITE8(reg,val)	do { R128_DEREF8(reg) = val; } while (0)
+
+#else	/* ! __powerpc__ */
+
 #define R128_BASE(reg)		((u32)(dev_priv->mmio->handle))
 #define R128_ADDR(reg)		(R128_BASE(reg) + reg)

@@ -207,6 +244,8 @@
 #define R128_DEREF8(reg)	*(__volatile__ char *)R128_ADDR(reg)
 #define R128_READ8(reg)		R128_DEREF8(reg)
 #define R128_WRITE8(reg,val)	do { R128_DEREF8(reg) = val; } while (0)
+
+#endif	/* __powerpc__ */

 #define R128_WRITE_PLL(addr,val)                                              \
 do {                                                                          \
--- drivers/char/drm/vm.c.orig	Fri Aug  4 09:02:58 2000
+++ drivers/char/drm/vm.c	Mon Aug  7 12:03:23 2000
@@ -283,6 +283,8 @@
 				pgprot_val(vma->vm_page_prot) |= _PAGE_PCD;
 				pgprot_val(vma->vm_page_prot) &= ~_PAGE_PWT;
 			}
+#elif defined(__powerpc__)
+			pgprot_val(vma->vm_page_prot) |= _PAGE_NO_CACHE|_PAGE_GUARDED;
 #endif
 			vma->vm_flags |= VM_IO;	/* not in core dump */
 		}
--- drivers/char/drm/r128_dma.c.orig	Mon Aug  7 12:31:42 2000
+++ drivers/char/drm/r128_dma.c	Mon Aug  7 12:32:21 2000
@@ -72,6 +72,7 @@
 {
 	int xchangeDummy;

+#ifdef __i386__
 	__asm__ volatile("push %%eax ;"
 			 "xchg %%eax, %0 ;"
 			 "pop %%eax" : : "m" (xchangeDummy));
@@ -85,6 +86,9 @@
 			 "pop %%ecx ;"
 			 "pop %%ebx ;"
 			 "pop %%eax" : /* no outputs */ :  /* no inputs */ );
+#else
+	mb();
+#endif
 }

 static void r128_status(drm_device_t *dev)

--------------7C426FB160227283A8A6F935
Content-Type: text/plain; charset=us-ascii;
 name="aty128fb-pan.diff"
Content-Disposition: inline;
 filename="aty128fb-pan.diff"
Content-Transfer-Encoding: 7bit

--- drivers/video/aty128fb.c.orig	Mon Aug  7 11:56:05 2000
+++ drivers/video/aty128fb.c	Mon Aug  7 12:09:32 2000
@@ -1539,7 +1539,20 @@
     par->crtc.xoffset = xoffset;
     par->crtc.yoffset = yoffset;

-    offset = ((yoffset * par->crtc.vxres + xoffset) * par->crtc.bpp) >> 6;
+    offset = (yoffset * par->crtc.vxres + xoffset);
+
+    switch (par->crtc.bpp) {
+    case 15:
+    case 16: offset *= 2; break;
+    case 24: offset *= 3; break;
+    case 32: offset *= 4; break;
+    default:		break;
+    }
+
+    offset &= ~7;			/* 3 lower bits are always 0 */
+
+    if (par->crtc.bpp == 24)
+	offset += 8 * (offset % 3); /* Must be multiple of 8 and 3 */

     aty_st_le32(CRTC_OFFSET, offset);


--------------7C426FB160227283A8A6F935--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
