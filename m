Date: Thu, 9 Aug 2001 11:52:33 -0500
From: Hollis Blanchard <hollis@austin.ibm.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: VGA console endian bug
Message-ID: <20010809115233.D23147@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


These two patches came from Daniel Berlin on July 9. They completely resolve
the VGA console backwards-endian problem for me on PPC. If they have Geert's
seal of approval ;) can they be committed?

-Hollis

--- linuxppc_2_4_devel/include/asm-ppc/vga.h.old	Thu Aug  9 11:49:23 2001
+++ linuxppc_2_4_devel/include/asm-ppc/vga.h	Thu Aug  9 11:49:42 2001
@@ -37,6 +37,9 @@

 #define VT_BUF_HAVE_MEMCPYW
 #define scr_memcpyw	memcpy
+#define VT_BUF_HAVE_MEMCPYF
+#define scr_memcpyw_to memcpy
+#define scr_memcpyw_from memcpy

 #endif /* !CONFIG_VGA_CONSOLE && !CONFIG_MDA_CONSOLE */

--- linuxppc_2_4_devel/drivers/video/fbcon.c.old	Thu Aug  9 11:45:10 2001
+++ linuxppc_2_4_devel/drivers/video/fbcon.c	Thu Aug  9 11:46:23 2001
@@ -2028,13 +2028,13 @@
 	if (!conp->vc_can_do_color)
 	    *p++ ^= 0x0800;
 	else if (conp->vc_hi_font_mask == 0x100) {
-	    u16 a = *p;
+	    u16 a = scr_read(p);
 	    a = ((a) & 0x11ff) | (((a) & 0xe000) >> 4) | (((a) & 0x0e00) << 4);
-	    *p++ = a;
+	    scr_write(a, p++);
 	} else {
-	    u16 a = *p;
+	    u16 a = scr_read(p);
 	    a = ((a) & 0x88ff) | (((a) & 0x7000) >> 4) | (((a) & 0x0700) << 4);
-	    *p++ = a;
+	    scr_write(a, p++);
 	}
 	if (p == (u16 *)softback_end)
 	    p = (u16 *)softback_buf;

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
