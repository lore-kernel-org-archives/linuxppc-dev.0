Date: Tue, 30 May 2000 08:34:01 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: FREESEC optimization
Message-ID: <Pine.LNX.4.05.10005300830530.13793-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I think this is a better algorithm to free unused sections (untested).

--- arch/ppc/mm/init.c.orig	Mon May 22 11:19:43 2000
+++ arch/ppc/mm/init.c	Mon May 22 11:24:04 2000
@@ -796,42 +796,14 @@
 } while (0)

 	FREESEC(__init_begin,__init_end,num_freed_pages);
-	switch (_machine)
-	{
-	case _MACH_Pmac:
-		FREESEC(__apus_begin,__apus_end,num_apus_pages);
-		FREESEC(__prep_begin,__prep_end,num_prep_pages);
-		FREESEC(__chrp_begin,__chrp_end,num_chrp_pages);
-		break;
-	case _MACH_chrp:
-		FREESEC(__apus_begin,__apus_end,num_apus_pages);
-		FREESEC(__pmac_begin,__pmac_end,num_pmac_pages);
-		FREESEC(__prep_begin,__prep_end,num_prep_pages);
-		break;
-	case _MACH_prep:
-		FREESEC(__apus_begin,__apus_end,num_apus_pages);
-		FREESEC(__pmac_begin,__pmac_end,num_pmac_pages);
-		FREESEC(__chrp_begin,__chrp_end,num_chrp_pages);
-		break;
-	case _MACH_mbx:
-		FREESEC(__apus_begin,__apus_end,num_apus_pages);
-		FREESEC(__pmac_begin,__pmac_end,num_pmac_pages);
+	if (_machine != _MACH_prep)
 		FREESEC(__prep_begin,__prep_end,num_prep_pages);
+	if (_machine != _MACH_chrp)
 		FREESEC(__chrp_begin,__chrp_end,num_chrp_pages);
-		break;
-	case _MACH_apus:
+	if (_machine != _MACH_Pmac)
 		FREESEC(__pmac_begin,__pmac_end,num_pmac_pages);
-		FREESEC(__prep_begin,__prep_end,num_prep_pages);
-		FREESEC(__chrp_begin,__chrp_end,num_chrp_pages);
-		break;
-	case _MACH_gemini:
+	if (_machine != _MACH_apus)
 		FREESEC(__apus_begin,__apus_end,num_apus_pages);
-		FREESEC(__pmac_begin,__pmac_end,num_pmac_pages);
-		FREESEC(__prep_begin,__prep_end,num_prep_pages);
-		FREESEC(__chrp_begin,__chrp_end,num_chrp_pages);
-		break;
-	}
-
 	if ( !have_of )
 		FREESEC( __openfirmware_begin, __openfirmware_end,
 			 num_openfirmware_pages );

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
