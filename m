Message-ID: <3A9C1F98.C61A48E4@iiic.ethz.ch>
Date: Tue, 27 Feb 2001 22:43:52 +0100
From: Michel =?iso-8859-1?Q?D=E4nzer?= <michdaen@iiic.ethz.ch>
MIME-Version: 1.0
To: "Timothy A. Seufert" <tas@mindspring.com>
Cc: Gareth Hughes <gareth@valinux.com>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: r128 DRI driver now fully functional on PPC
References: <3A76769B.87242FAA@valinux.com>				
		 <v04220800b6bbb8f01525@[10.0.0.42]> <3A963519.C439E7C0@valinux.com>
		 <v04220800b6be6735bfd4@[165.247.215.42]> <3A9A246D.72D1B5BE@iiic.ethz.ch>
		 <3A9A2A9D.8A779B@valinux.com> <3A9A2E16.6F679EF3@iiic.ethz.ch>
		 <3A9A2FBF.B304ADD1@valinux.com> <v04220800b6c12899d73e@[10.0.0.42]> <3A9B91EA.7DCFFEF3@valinux.com>
Content-Type: multipart/mixed;
 boundary="------------93763FFF019494781E8DCE1E"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------93763FFF019494781E8DCE1E
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Gareth Hughes wrote:
>
> "Timothy A. Seufert" wrote:
> >
> > I still have the problem with keyboard/mouse input being ignored once
> > a GL app starts.  A friend suggested disabling DGA, but that didn't
> > help.  I do notice this message popping in the system logs, repeated
> > numerous times:
> >
> > [drm:drm_lock_take] *ERROR* 1 holds heavyweight lock
>
> This happens when the lock ioctl occurs when the lock is already held.
> '1' is the X server, so the X server is grabbing the lock when it
> already has it.

Which might be fixed by the attached patch which Gareth posted to dri-devel
lately.

But don't expect this to solve your input problems as I never had them.


--
Earthling Michel Dänzer (MrCooper)    \   Debian GNU/Linux (powerpc) developer
CS student, Free Software enthusiast   \        XFree86 and DRI project member
--------------93763FFF019494781E8DCE1E
Content-Type: text/plain; charset=us-ascii;
 name="r128-4.0.2-patch"
Content-Disposition: inline;
 filename="r128-4.0.2-patch"
Content-Transfer-Encoding: 7bit

diff -ur xc/programs/Xserver/hw/xfree86/os-support/linux/drm/kernel/r128_cce.c xc.gh/programs/Xserver/hw/xfree86/os-support/linux/drm/kernel/r128_cce.c
--- xc/programs/Xserver/hw/xfree86/os-support/linux/drm/kernel/r128_cce.c	Wed Dec 13 11:02:12 2000
+++ xc.gh/programs/Xserver/hw/xfree86/os-support/linux/drm/kernel/r128_cce.c	Tue Feb 20 18:10:16 2001
@@ -36,9 +36,8 @@
 #include <linux/interrupt.h>	/* For task queue support */
 #include <linux/delay.h>

+#define R128_FIFO_DEBUG		0

-/* FIXME: Temporary CCE packet buffer */
-u32 r128_cce_buffer[(1 << 14)] __attribute__ ((aligned (32)));

 /* CCE microcode (from ATI) */
 static u32 r128_cce_microcode[] = {
@@ -114,7 +113,7 @@
 	return R128_READ(R128_CLOCK_CNTL_DATA);
 }

-#if 0
+#if R128_FIFO_DEBUG
 static void r128_status( drm_r128_private_t *dev_priv )
 {
 	printk( "GUI_STAT           = 0x%08x\n",
@@ -152,7 +151,9 @@
 		udelay( 1 );
 	}

+#if R128_FIFO_DEBUG
 	DRM_ERROR( "%s failed!\n", __FUNCTION__ );
+#endif
 	return -EBUSY;
 }

@@ -166,7 +167,9 @@
 		udelay( 1 );
 	}

+#if R128_FIFO_DEBUG
 	DRM_ERROR( "%s failed!\n", __FUNCTION__ );
+#endif
 	return -EBUSY;
 }

@@ -175,7 +178,7 @@
 	int i, ret;

 	ret = r128_do_wait_for_fifo( dev_priv, 64 );
-	if ( !ret ) return ret;
+	if ( ret < 0 ) return ret;

 	for ( i = 0 ; i < dev_priv->usec_timeout ; i++ ) {
 		if ( !(R128_READ( R128_GUI_STAT ) & R128_GUI_ACTIVE) ) {
@@ -185,7 +188,9 @@
 		udelay( 1 );
 	}

+#if R128_FIFO_DEBUG
 	DRM_ERROR( "%s failed!\n", __FUNCTION__ );
+#endif
 	return -EBUSY;
 }

@@ -241,7 +246,7 @@
 		udelay( 1 );
 	}

-#if 0
+#if R128_FIFO_DEBUG
 	DRM_ERROR( "failed!\n" );
 	r128_status( dev_priv );
 #endif
diff -ur xc/programs/Xserver/hw/xfree86/os-support/linux/drm/kernel/r128_drv.h xc.gh/programs/Xserver/hw/xfree86/os-support/linux/drm/kernel/r128_drv.h
--- xc/programs/Xserver/hw/xfree86/os-support/linux/drm/kernel/r128_drv.h	Tue Dec  5 11:57:26 2000
+++ xc.gh/programs/Xserver/hw/xfree86/os-support/linux/drm/kernel/r128_drv.h	Tue Feb 20 18:04:17 2001
@@ -388,11 +388,11 @@
 #define R128_BASE(reg)		((u32)(dev_priv->mmio->handle))
 #define R128_ADDR(reg)		(R128_BASE(reg) + reg)

-#define R128_DEREF(reg)		*(__volatile__ int *)R128_ADDR(reg)
+#define R128_DEREF(reg)		*(volatile u32 *)R128_ADDR(reg)
 #define R128_READ(reg)		R128_DEREF(reg)
 #define R128_WRITE(reg,val)	do { R128_DEREF(reg) = val; } while (0)

-#define R128_DEREF8(reg)	*(__volatile__ char *)R128_ADDR(reg)
+#define R128_DEREF8(reg)	*(volatile u8 *)R128_ADDR(reg)
 #define R128_READ8(reg)		R128_DEREF8(reg)
 #define R128_WRITE8(reg,val)	do { R128_DEREF8(reg) = val; } while (0)

diff -ur xc/programs/Xserver/hw/xfree86/os-support/linux/drm/xf86drmR128.c xc.gh/programs/Xserver/hw/xfree86/os-support/linux/drm/xf86drmR128.c
--- xc/programs/Xserver/hw/xfree86/os-support/linux/drm/xf86drmR128.c	Wed Dec 13 11:02:11 2000
+++ xc.gh/programs/Xserver/hw/xfree86/os-support/linux/drm/xf86drmR128.c	Tue Feb 20 23:44:14 2001
@@ -78,7 +78,7 @@
 #include "drm.h"

 #define R128_BUFFER_RETRY	32
-#define R128_IDLE_RETRY		16
+#define R128_IDLE_RETRY		32


 int drmR128InitCCE( int fd, drmR128Init *info )
@@ -154,8 +154,11 @@

    ret = ioctl( fd, DRM_IOCTL_R128_CCE_STOP, &stop );

-   if ( ret && errno != EBUSY )
+   if ( ret == 0 ) {
+      return 0;
+   } else if ( errno != EBUSY ) {
       return -errno;
+   }

    stop.flush = 0;

@@ -163,8 +166,11 @@
       ret = ioctl( fd, DRM_IOCTL_R128_CCE_STOP, &stop );
    } while ( ret && errno == EBUSY && i++ < R128_IDLE_RETRY );

-   if ( ret && errno != EBUSY )
+   if ( ret == 0 ) {
+      return 0;
+   } else if ( errno != EBUSY ) {
       return -errno;
+   }

    stop.idle = 0;


--------------93763FFF019494781E8DCE1E--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
