From: Chas Williams <chas@cmf.nrl.navy.mil>
Date: Wed, 19 Apr 2000 10:29:11 -0400 (EDT)
Message-Id: <200004191429.KAA11052@borg.cmf.nrl.navy.mil>
To: linuxppc-dev@lists.linuxppc.org
Subject: aty128 and offb and linux-2.3.99pre6
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


i think i have spotted an oversite, offb.c, the aty128 probing should
come after the offb probing otherwise, my aty128 comes up as an
unsupported framebuffer.  the following patch 'correctly' recoginizes
my aty128 now:

--- fbmem.c.000 Tue Apr 18 17:51:12 2000
+++ fbmem.c     Tue Apr 18 17:52:39 2000
@@ -160,15 +160,15 @@
 #ifdef CONFIG_FB_ATY
        { "atyfb", atyfb_init, atyfb_setup },
 #endif
+#ifdef CONFIG_FB_ATY128
+       { "aty128fb", aty128fb_init, aty128fb_setup },
+#endif
 #ifdef CONFIG_FB_OF
        /*
         * Offb must be initialized _after_ all other frame buffer devices
         * that use PCI probing and PCI resources! [ Geert ]
         */
        { "offb", offb_init, offb_setup },
-#endif
-#ifdef CONFIG_FB_ATY128
-       { "aty128fb", aty128fb_init, aty128fb_setup },
 #endif
 #ifdef CONFIG_FB_IGA
         { "igafb", igafb_init, igafb_setup },


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
