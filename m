Date: Fri, 8 Feb 2002 18:47:43 -0700
From: Val Henson <val@nmt.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: [PATCH] Allow sysmap to be used on non CONFIG_ALL_PPC
Message-ID: <20020208184743.F28166@boardwalk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This patch allows the System.map to be stored in RAM on non
CONFIG_ALL_PPC architectures.

(Note: Gemini is still an easy candidate for CONFIG_ALL_PPC.)

-VAL

diff -Nru a/arch/ppc/mm/init.c b/arch/ppc/mm/init.c
--- a/arch/ppc/mm/init.c	Fri Feb  8 15:12:57 2002
+++ b/arch/ppc/mm/init.c	Fri Feb  8 15:12:57 2002
@@ -581,9 +581,6 @@
 	/* remove the RTAS pages from the available memory */
 	if (rtas_data)
 		mem_pieces_remove(&phys_avail, rtas_data, rtas_size, 1);
-	/* remove the sysmap pages from the available memory */
-	if (sysmap)
-		mem_pieces_remove(&phys_avail, __pa(sysmap), sysmap_size, 1);
 	/* Because of some uninorth weirdness, we need a page of
 	 * memory as high as possible (it must be outside of the
 	 * bus address seen as the AGP aperture). It will be used
@@ -599,6 +596,9 @@
 		agp_special_page = (unsigned long)__va(agp_special_page);
 	}
 #endif /* CONFIG_ALL_PPC */
+	/* remove the sysmap pages from the available memory */
+	if (sysmap)
+		mem_pieces_remove(&phys_avail, __pa(sysmap), sysmap_size, 1);
 }

 /* Mark some memory as reserved by removing it from phys_avail. */

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
