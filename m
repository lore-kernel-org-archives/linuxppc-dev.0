Date: Tue, 11 Sep 2001 16:29:26 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-embedded@lists.linuxppc.org
Subject: A few warning fixes for 4xx
Message-ID: <20010911162926.Q4823@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


As the subject suggests:

diff -urN ../linuxppc_2_4_devel/arch/ppc/kernel/ppc4xx_setup.c linux-bungo/arch/ppc/kernel/ppc4xx_setup.c
--- ../linuxppc_2_4_devel/arch/ppc/kernel/ppc4xx_setup.c	Mon Sep 10 11:57:26 2001
+++ linux-bungo/arch/ppc/kernel/ppc4xx_setup.c	Tue Sep 11 16:14:03 2001
@@ -86,7 +86,7 @@
 #endif

 #define BOOT_WDT_DEFAULT_PERIOD		120	/* 2 minutes */
-extern board_setup_arch(void);
+extern void board_setup_arch(void);

 void __init
 ppc4xx_setup_arch(void)
diff -urN ../linuxppc_2_4_devel/arch/ppc/mm/mmu_decl.h linux-bungo/arch/ppc/mm/mmu_decl.h
--- ../linuxppc_2_4_devel/arch/ppc/mm/mmu_decl.h	Tue Aug 28 07:59:35 2001
+++ linux-bungo/arch/ppc/mm/mmu_decl.h	Tue Sep 11 16:18:35 2001
@@ -53,6 +53,7 @@

 #elif defined(CONFIG_4xx)
 #define flush_HPTE(X, va, pg)	__tlbia()
+extern void MMU_init_hw(void);

 #else
 /* anything except 4xx or 8xx */


--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
