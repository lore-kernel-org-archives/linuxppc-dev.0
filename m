Date: Wed, 2 Aug 2000 22:11:05 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: free_initmem() bug
Message-ID: <Pine.LNX.4.10.10007311937060.442-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


free_initmem() must not be __init because that means sawing the branch
underneat itselves, which may cause a crash.

I also optimized the freeing of the various sections, both from a soure and
object view.

The patch is half tested, i.e. it compiles. Since I won't be able to do bk for
a while, can someone please take care of this? Thanks!

--- linux-2.4.0-test6-pre1/arch/ppc/mm/init.c	Tue Jul 18 14:08:50 2000
+++ geert-ppc-2.4.0-test6-pre1/arch/ppc/mm/init.c	Wed Aug  2 22:06:37 2000
@@ -788,76 +788,40 @@
 	return p;
 }

-void __init free_initmem(void)
+static void free_sec(unsigned long start, unsigned long end, const char *name)
 {
-	unsigned long a;
-	unsigned long num_freed_pages = 0, num_prep_pages = 0,
-		num_pmac_pages = 0, num_openfirmware_pages = 0,
-		num_apus_pages = 0, num_chrp_pages = 0;
-#define FREESEC(START,END,CNT) do { \
-	a = (unsigned long)(&START); \
-	for (; a < (unsigned long)(&END); a += PAGE_SIZE) { \
-	  	clear_bit(PG_reserved, &mem_map[MAP_NR(a)].flags); \
-		set_page_count(mem_map+MAP_NR(a), 1); \
-		free_page(a); \
-		CNT++; \
-	} \
-} while (0)
+	unsigned long cnt = 0;

-	FREESEC(__init_begin,__init_end,num_freed_pages);
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
-		FREESEC(__prep_begin,__prep_end,num_prep_pages);
-		FREESEC(__chrp_begin,__chrp_end,num_chrp_pages);
-		break;
-	case _MACH_apus:
-		FREESEC(__pmac_begin,__pmac_end,num_pmac_pages);
-		FREESEC(__prep_begin,__prep_end,num_prep_pages);
-		FREESEC(__chrp_begin,__chrp_end,num_chrp_pages);
-		break;
-	case _MACH_gemini:
-		FREESEC(__apus_begin,__apus_end,num_apus_pages);
-		FREESEC(__pmac_begin,__pmac_end,num_pmac_pages);
-		FREESEC(__prep_begin,__prep_end,num_prep_pages);
-		FREESEC(__chrp_begin,__chrp_end,num_chrp_pages);
-		break;
+	while (start < end) {
+	  	clear_bit(PG_reserved, &mem_map[MAP_NR(start)].flags);
+		set_page_count(mem_map+MAP_NR(start), 1);
+		free_page(start);
+		cnt++;
+		start += PAGE_SIZE;
 	}
+	if (cnt)
+		printk(" %ldk %s", PGTOKB(cnt), name);
+}

-	if ( !have_of )
-		FREESEC( __openfirmware_begin, __openfirmware_end,
-			 num_openfirmware_pages );
-
-	printk ("Freeing unused kernel memory: %ldk init",
-		PGTOKB(num_freed_pages));
+#define FREESEC(TYPE) \
+	free_sec((unsigned long)(&__ ## TYPE ## _begin), \
+		 (unsigned long)(&__ ## TYPE ## _end), \
+		 #TYPE);

-	if ( num_prep_pages )
-		printk(" %ldk prep", PGTOKB(num_prep_pages));
-	if ( num_chrp_pages )
-		printk(" %ldk chrp", PGTOKB(num_chrp_pages));
-	if ( num_pmac_pages )
-		printk(" %ldk pmac", PGTOKB(num_pmac_pages));
-	if ( num_openfirmware_pages )
-		printk(" %ldk open firmware", PGTOKB(num_openfirmware_pages));
-	if ( num_apus_pages )
-		printk(" %ldk apus", PGTOKB(num_apus_pages));
+void free_initmem(void)
+{
+	printk ("Freeing unused kernel memory:");
+	FREESEC(init);
+	if (_machine != _MACH_Pmac)
+		FREESEC(pmac);
+	if (_machine != _MACH_chrp)
+		FREESEC(chrp);
+	if (_machine != _MACH_prep)
+		FREESEC(prep);
+	if (_machine != _MACH_apus)
+		FREESEC(apus);
+	if (!have_of)
+		FREESEC(openfirmware);
 	printk("\n");
 }



Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
