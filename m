Date: Fri, 14 Sep 2001 14:44:03 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Board names for 4xx
Message-ID: <20010914144403.G3851@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The patch below allows publishing the type of board the kernel is
running on in /proc/cpuinfo (under "machine") for 4xx machines.  It
displays Walnut boards as "IBM Walnut" and (currently) all others
simply as "4xx".  Adding other boards is trivial - just a #define in
the relevant header file.  It also eliminates a warning in
ppc4xx_setup.c

diff -urN ../linuxppc_2_4_devel/arch/ppc/kernel/ppc4xx_setup.c linux-bungo/arch/ppc/kernel/ppc4xx_setup.c
--- ../linuxppc_2_4_devel/arch/ppc/kernel/ppc4xx_setup.c	Mon Sep 10 11:57:26 2001
+++ linux-bungo/arch/ppc/kernel/ppc4xx_setup.c	Wed Sep 12 16:33:15 2001
@@ -86,7 +86,7 @@
 #endif

 #define BOOT_WDT_DEFAULT_PERIOD		120	/* 2 minutes */
-extern board_setup_arch(void);
+extern void board_setup_arch(void);

 void __init
 ppc4xx_setup_arch(void)
@@ -165,6 +165,8 @@
 	int len = 0;
 	bd_t *bip = (bd_t *)__res;

+	len += sprintf(len + buffer,
+		       "machine\t: %s\n", PPC4xx_MACHINE_NAME);
 #ifdef CONFIG_STB03xxx
 	len += sprintf(len + buffer,
 			"plb bus clock\t: %dMHz\n",
diff -urN ../linuxppc_2_4_devel/include/asm-ppc/walnut.h linux-bungo/include/asm-ppc/walnut.h
--- ../linuxppc_2_4_devel/include/asm-ppc/walnut.h	Thu Aug 16 04:45:34 2001
+++ linux-bungo/include/asm-ppc/walnut.h	Wed Sep 12 16:29:23 2001
@@ -78,6 +78,7 @@
 /* Generic 4xx type
 */
 #define _MACH_4xx (_MACH_walnut)
+#define PPC4xx_MACHINE_NAME	"IBM Walnut"

 #endif /* __WALNUT_H__ */
 #endif /* __KERNEL__ */

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
