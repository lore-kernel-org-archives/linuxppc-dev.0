Date: Sat, 29 Jul 2000 14:40:08 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Michel Dänzer <daenzerm@student.ethz.ch>
cc: Roman Zippel <zippel@fh-brandenburg.de>,
        Linux/PPC on APUS <linux-apus-devel@lists.sourceforge.net>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: bogus dmasound.o module (was: Re: 2.4.0-test4 success (Re: affs))
In-Reply-To: <3981DBA6.7203A5B9@student.ethz.ch>
Message-ID: <Pine.LNX.4.10.10007291437400.1201-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 28 Jul 2000, Michel [iso-8859-1] Dänzer wrote:
> 'make modules_install' tries to install dmasound.o (which doesn't exist
> anymore) instead of dmasound_paula.o and dmasound_core.o

Does this help? IIRC, I have it in my tree since a while, but I forgot about
it.

--- linux-2.4.0-test5/drivers/sound/Makefile.orig	Tue Jul 18 14:09:03 2000
+++ linux-2.4.0-test5/drivers/sound/Makefile	Sat Jul 29 14:37:01 2000
@@ -92,11 +92,11 @@

 ifeq ($(CONFIG_DMASOUND),y)
   SUB_DIRS += dmasound
-  MOD_SUB_DIRS += dmasound
+  MOD_IN_SUB_DIRS += dmasound
   obj-y += dmasound/dmasound.o
 else
   ifeq ($(CONFIG_DMASOUND),m)
-    MOD_SUB_DIRS += dmasound
+    MOD_IN_SUB_DIRS += dmasound
   endif
 endif


Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
