Date: Thu, 27 Jan 2000 23:00:32 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
        Linux Frame Buffer Device Development <linux-fbdev@vuser.vu.union.edu>
cc: Cort Dougan <cort@ppc.kernel.org>,
        Ulrik De Bie <winmute@atlantique.venturi.net>
Subject: vgacon, vga16fb, clgenfb on PPC
Message-ID: <Pine.LNX.4.05.10001272250560.428-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	Hi,

Finally I was able to compile a recent kernel again (2.3.41 from
bitkeeper/PPC)!

I revised my patch to make vga16fb and clgenfb compile (as modules, in my
case). I couldn't test clgenfb, but vga16fb works fine as my second head (S3
Trio64V+ initialized by em86, first head on ATI Rage II+ handled by atyfb).

Compared to my previous version from 2 months ago, I think I found the bug that
caused the endianness problems with vgacon on PReP: defining
scr_memcpyw_{from,to} to be equal to memcpy() was wrong, since in that case no
byteswapping was done when accessing video memory.

The idea behind this patch is to make scr_{write,read}w() use {write,read}w()
when {vga,mda}con is compiled in (independent of CONFIG_FB), and to use native
byte ordering when it isn't.

This patch is especially interesting for people who want to

  - have a second head handled by vga16fb
  - use clgenfb
  - have vgacon on one head and clgenfb on the second
  - ...

Can someone with a PReP box and vgacon (Cort?) please verify that it works this
time? Thx!

===== include/linux/vt_buffer.h 1.1 vs edited =====
--- include/linux/vt_buffer.h 1.1	Thu Jan 27 22:50:06 2000
+++ include/linux/vt_buffer.h Thu Jan 27 21:22:29 2000
@@ -15,7 +15,7 @@

 #include <linux/config.h>

-#ifdef CONFIG_VGA_CONSOLE
+#if defined(CONFIG_VGA_CONSOLE) || defined(CONFIG_MDA_CONSOLE)
 #include <asm/vga.h>
 #endif

===== include/asm-ppc/vga.h 1.1 vs edited =====
--- include/asm-ppc/vga.h 1.1	Thu Jan 27 22:50:13 2000
+++ include/asm-ppc/vga.h Thu Jan 27 21:21:49 2000
@@ -8,43 +8,33 @@
 #define _LINUX_ASM_VGA_H_

 #include <asm/io.h>
-#include <asm/processor.h>

 #include <linux/config.h>
-#include <linux/console.h>
+
+#if defined(CONFIG_VGA_CONSOLE) || defined(CONFIG_MDA_CONSOLE)

 #define VT_BUF_HAVE_RW
+/*
+ *  These are only needed for supporting VGA or MDA text mode, which use little
+ *  endian byte ordering.
+ *  In other cases, we can optimize by using native byte ordering and
+ *  <linux/vt_buffer.h> has already done the right job for us.
+ */

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

-#define VT_BUF_HAVE_MEMCPYF
-#define scr_memcpyw_from memcpy
-#define scr_memcpyw_to memcpy
+#define VT_BUF_HAVE_MEMCPYW
+#define scr_memcpyw	memcpy
+
+#endif /* !CONFIG_VGA_CONSOLE && !CONFIG_MDA_CONSOLE */

 extern unsigned long vgacon_remap_base;
 #define VGA_MAP_MEM(x) (x + vgacon_remap_base)

Gr{oetje,eeting}s,
--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
