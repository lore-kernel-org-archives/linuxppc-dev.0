Date: Tue, 19 Oct 1999 19:56:22 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux Frame Buffer Device Development <linux-fbdev@vuser.vu.union.edu>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
cc: Jeff Garzik <jgarzik@pobox.com>, Martin Mares <mj@ucw.cz>
Subject: PPC scr_{read,write}w() cleanup
Message-ID: <Pine.LNX.4.05.9910132022030.21844-100000@callisto.thomas.kotnet.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Finally I found some time to sort out the PPC scr_{read,write}w() mess.
Now scr_{read,write}w() always swaps bytes if {vga,mda}con was compiled in,
while we did a runtime check before.

This patch matters specifically for people with PReP boxes, who may want to use
vgacon on one head and a real frame buffer device on either a second head or on
the first head after boot up (insmod *fb.o takes over vgacon).

Without this patch, clgenfb and vga16fb don't compile if you don't compile in
vgacon because they include asm/vga.h after linux/vt_buffer.h (remember,
CONFIG_VGA_CONSOLE is not set, hence vt_buffer.h doesn't include vga.h).

Please test this so I can send this patch to Linus! I do not have such a PReP
box. The patch does allow me to use vga16fb again on the second head
(S3Trio64V+ initialized to VGA text mode by em86) in my CHRP box.

Comments?

diff -urN -x CVS /home/geert/linux/native-2.3.23-pre2/include/linux/vt_buffer.h vger.rutgers.edu/include/linux/vt_buffer.h
--- /home/geert/linux/native-2.3.23-pre2/include/linux/vt_buffer.h	Tue May 11 22:03:59 1999
+++ vger.rutgers.edu/include/linux/vt_buffer.h	Wed Oct 13 20:27:01 1999
@@ -15,7 +15,7 @@
 
 #include <linux/config.h>
 
-#ifdef CONFIG_VGA_CONSOLE
+#if defined(CONFIG_VGA_CONSOLE) || defined(CONFIG_MDA_CONSOLE)
 #include <asm/vga.h>
 #endif
 
diff -urN -x CVS /home/geert/linux/native-2.3.23-pre2/include/asm-ppc/vga.h vger.rutgers.edu/include/asm-ppc/vga.h
--- /home/geert/linux/native-2.3.23-pre2/include/asm-ppc/vga.h	Thu Apr 29 21:39:07 1999
+++ vger.rutgers.edu/include/asm-ppc/vga.h	Wed Oct 13 20:21:35 1999
@@ -8,43 +8,35 @@
 #define _LINUX_ASM_VGA_H_
 
 #include <asm/io.h>
-#include <asm/processor.h>
 
 #include <linux/config.h>
-#include <linux/console.h>
 
 #define VT_BUF_HAVE_RW
 
+#if defined(CONFIG_VGA_CONSOLE) || defined(CONFIG_MDA_CONSOLE)
+
+/*
+ *  These are only needed for supporting VGA or MDA text mode, which use little
+ *  endian byte ordering.
+ *  In other cases, we can optimize by using native byte ordering and
+ *  <linux/vt_buffer.h> has already done the right job for us.
+ */
+
 extern inline void scr_writew(u16 val, u16 *addr)
 {
-	/* If using vgacon (not fbcon) byteswap the writes.
-	 * If non-vgacon assume fbcon and don't byteswap
-	 * just like include/linux/vt_buffer.h.
-	 * XXX: this is a performance loss so get rid of it
-	 *      as soon as fbcon works on prep.
-	 * -- Cort
-	 */
-#ifdef CONFIG_FB
-	if ( conswitchp != &vga_con )
-		(*(addr) = (val));
-	else
-#endif /* CONFIG_FB */
-		st_le16(addr, val);
+    writew(val, (unsigned long)addr);
 }
 
 extern inline u16 scr_readw(const u16 *addr)
 {
-#ifdef CONFIG_FB
-	if ( conswitchp != &vga_con )
-		return (*(addr));
-	else
-#endif /* CONFIG_FB */
-		return ld_le16((unsigned short *)addr);
+    return readw((unsigned long)addr);
 }
 
 #define VT_BUF_HAVE_MEMCPYF
 #define scr_memcpyw_from memcpy
 #define scr_memcpyw_to memcpy
+
+#endif /* !CONFIG_VGA_CONSOLE && !CONFIG_MDA_CONSOLE */
 
 extern unsigned long vgacon_remap_base;
 #define VGA_MAP_MEM(x) (x + vgacon_remap_base)

Greetings,

						Geert

--
Geert Uytterhoeven ----------------- Sony Suprastructure Center Europe (SUPC-E)
Geert.Uytterhoeven@sonycom.com ------------------- Sint Stevens Woluwestraat 55
Phone +32-2-7248632 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
