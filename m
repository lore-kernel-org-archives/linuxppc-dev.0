Date: Wed, 19 Apr 2000 22:55:05 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Chas Williams <chas@cmf.nrl.navy.mil>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: aty128 and offb and linux-2.3.99pre6
In-Reply-To: <200004191429.KAA11052@borg.cmf.nrl.navy.mil>
Message-ID: <Pine.LNX.4.10.10004192247200.436-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 19 Apr 2000, Chas Williams wrote:
> i think i have spotted an oversite, offb.c, the aty128 probing should
> come after the offb probing otherwise, my aty128 comes up as an
> unsupported framebuffer.  the following patch 'correctly' recoginizes
> my aty128 now:

I thought that was already fixed, but it wasn't, so I've just sent it to Linus.

What about other frame buffer devices, like e.g. matroxfb? Does it still work
after this patch? If yes, we can get rid of matrox_of_init() as well.

--- geert-2.3.99-pre5/drivers/video/fbmem.c.orig	Wed Apr 19 22:48:17 2000
+++ geert-2.3.99-pre5/drivers/video/fbmem.c	Wed Apr 19 22:48:26 2000
@@ -163,6 +163,9 @@
 #ifdef CONFIG_FB_ATY128
 	{ "aty128fb", aty128fb_init, aty128fb_setup },
 #endif
+#ifdef CONFIG_FB_MATROX
+	{ "matrox", matroxfb_init, matroxfb_setup },
+#endif
 #ifdef CONFIG_FB_OF
 	/*
 	 * Offb must be initialized _after_ all other frame buffer devices
@@ -203,9 +206,6 @@
 #ifdef CONFIG_FB_HGA
 	{ "hga", hgafb_init, hgafb_setup },
 #endif
-#ifdef CONFIG_FB_MATROX
-	{ "matrox", matroxfb_init, matroxfb_setup },
-#endif
 #ifdef CONFIG_FB_HP300
 	{ "hpfb", hpfb_init, hpfb_setup },
 #endif

I'd really like to get rid of all these:

    s3triofb_init_of()
    imsttfb_of_init()
    chips_of_init()
    matrox_of_init()
    control_of_init()
    valkyrie_of_init()
    platinum_of_init()
    clgen_of_init()

These are all PCI based, so they can be found using PCI probing and marked
busy using PCI resource management.

When creating this list, I noticed that

  - clgenfb is already initialized before offb, so I guess clgen_of_init() is
    dead code already.

  - chipsfb is always initialized from offb, there's no corresponding entry in
    fbmem.c:fb_drivers[].

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
