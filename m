Date: Mon, 30 Oct 2000 23:10:25 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: __{pmac,prep,chrp,apus,openfirmware}func()
Message-ID: <Pine.LNX.4.10.10010302304320.413-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Since __initfunc() was removed in 2.3.16, we should remove the PPC-specific
variants as well.

At least arch/ppc/ and drivers/macintosh/ don't contain files that use any of
these definitions anymore.

--- linux-2.4.0-test10-pre7/include/asm-ppc/init.h.orig	Mon Oct 30 22:52:59 2000
+++ linux-2.4.0-test10-pre7/include/asm-ppc/init.h	Mon Oct 30 23:04:21 2000
@@ -5,33 +5,18 @@

 #define __pmac __attribute__ ((__section__ (".text.pmac")))
 #define __pmacdata __attribute__ ((__section__ (".data.pmac")))
-#define __pmacfunc(__argpmac) \
-	__argpmac __pmac; \
-	__argpmac
-
+
 #define __prep __attribute__ ((__section__ (".text.prep")))
 #define __prepdata __attribute__ ((__section__ (".data.prep")))
-#define __prepfunc(__argprep) \
-	__argprep __prep; \
-	__argprep

 #define __chrp __attribute__ ((__section__ (".text.chrp")))
 #define __chrpdata __attribute__ ((__section__ (".data.chrp")))
-#define __chrpfunc(__argchrp) \
-	__argchrp __chrp; \
-	__argchrp

 #define __apus __attribute__ ((__section__ (".text.apus")))
 #define __apusdata __attribute__ ((__section__ (".data.apus")))
-#define __apusfunc(__argapus) \
-	__argapus __apus; \
-	__argapus

 /* this is actually just common chrp/pmac code, not OF code -- Cort */
 #define __openfirmware __attribute__ ((__section__ (".text.openfirmware")))
 #define __openfirmwaredata __attribute__ ((__section__ (".data.openfirmware")))
-#define __openfirmwarefunc(__argopenfirmware) \
-	__argopenfirmware __openfirmware; \
-	__argopenfirmware
-
+
 #endif /* _PPC_INIT_H */

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
