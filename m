Return-Path: <galak@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 7C52967CD2
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Jul 2005 13:13:31 +1000 (EST)
Date: Thu, 14 Jul 2005 22:13:15 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
To: Andrew Morton <akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0507142212490.14976@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] ppc32: Add proper prototype for cpm2_reset()
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Added a proper prototype for cpm2_reset() which gets ride of a build
warning.

Signed-off-by: Jon Loeliger <jdl@freescale.com>
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit d2a144648ecfe8652d19dd9019141e88a3a2a974
tree a047dc753c56ae50ed5a20beeb893654b08aca18
parent 0a224850142b1169b5a67735e51268057d24b833
author Kumar K. Gala <kumar.gala@freescale.com> Thu, 14 Jul 2005 22:10:13 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Thu, 14 Jul 2005 22:10:13 -0500

 arch/ppc/platforms/85xx/mpc8560_ads.c        |    1 -
 arch/ppc/platforms/85xx/mpc85xx_cds_common.c |    2 +-
 arch/ppc/platforms/85xx/stx_gp3.c            |    3 +--
 arch/ppc/syslib/cpm2_common.c                |    1 -
 arch/ppc/syslib/m8260_setup.c                |    3 +--
 include/asm-ppc/cpm2.h                       |    5 +++--
 6 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/ppc/platforms/85xx/mpc8560_ads.c b/arch/ppc/platforms/85xx/mpc8560_ads.c
--- a/arch/ppc/platforms/85xx/mpc8560_ads.c
+++ b/arch/ppc/platforms/85xx/mpc8560_ads.c
@@ -56,7 +56,6 @@
 #include <syslib/ppc85xx_common.h>
 #include <syslib/ppc85xx_setup.h>
 
-extern void cpm2_reset(void);
 
 /* ************************************************************************
  *
diff --git a/arch/ppc/platforms/85xx/mpc85xx_cds_common.c b/arch/ppc/platforms/85xx/mpc85xx_cds_common.c
--- a/arch/ppc/platforms/85xx/mpc85xx_cds_common.c
+++ b/arch/ppc/platforms/85xx/mpc85xx_cds_common.c
@@ -49,7 +49,7 @@
 #include <asm/mpc85xx.h>
 #include <asm/irq.h>
 #include <asm/immap_85xx.h>
-#include <asm/immap_cpm2.h>
+#include <asm/cpm2.h>
 #include <asm/ppc_sys.h>
 #include <asm/kgdb.h>
 
diff --git a/arch/ppc/platforms/85xx/stx_gp3.c b/arch/ppc/platforms/85xx/stx_gp3.c
--- a/arch/ppc/platforms/85xx/stx_gp3.c
+++ b/arch/ppc/platforms/85xx/stx_gp3.c
@@ -52,14 +52,13 @@
 #include <asm/mpc85xx.h>
 #include <asm/irq.h>
 #include <asm/immap_85xx.h>
-#include <asm/immap_cpm2.h>
+#include <asm/cpm2.h>
 #include <asm/mpc85xx.h>
 #include <asm/ppc_sys.h>
 
 #include <syslib/cpm2_pic.h>
 #include <syslib/ppc85xx_common.h>
 
-extern void cpm2_reset(void);
 
 unsigned char __res[sizeof(bd_t)];
 
diff --git a/arch/ppc/syslib/cpm2_common.c b/arch/ppc/syslib/cpm2_common.c
--- a/arch/ppc/syslib/cpm2_common.c
+++ b/arch/ppc/syslib/cpm2_common.c
@@ -27,7 +27,6 @@
 #include <asm/mpc8260.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
-#include <asm/immap_cpm2.h>
 #include <asm/cpm2.h>
 #include <asm/rheap.h>
 
diff --git a/arch/ppc/syslib/m8260_setup.c b/arch/ppc/syslib/m8260_setup.c
--- a/arch/ppc/syslib/m8260_setup.c
+++ b/arch/ppc/syslib/m8260_setup.c
@@ -24,7 +24,7 @@
 #include <asm/io.h>
 #include <asm/pgtable.h>
 #include <asm/mpc8260.h>
-#include <asm/immap_cpm2.h>
+#include <asm/cpm2.h>
 #include <asm/machdep.h>
 #include <asm/bootinfo.h>
 #include <asm/time.h>
@@ -33,7 +33,6 @@
 
 unsigned char __res[sizeof(bd_t)];
 
-extern void cpm2_reset(void);
 extern void pq2_find_bridges(void);
 extern void pq2pci_init_irq(void);
 extern void idma_pci9_init(void);
diff --git a/include/asm-ppc/cpm2.h b/include/asm-ppc/cpm2.h
--- a/include/asm-ppc/cpm2.h
+++ b/include/asm-ppc/cpm2.h
@@ -109,6 +109,7 @@ static inline long IS_DPERR(const uint o
  * and dual port ram.
  */
 extern		cpm_cpm2_t	*cpmp;	 /* Pointer to comm processor */
+
 extern uint cpm_dpalloc(uint size, uint align);
 extern int cpm_dpfree(uint offset);
 extern uint cpm_dpalloc_fixed(uint offset, uint size, uint align);
@@ -116,6 +117,8 @@ extern void cpm_dpdump(void);
 extern void *cpm_dpram_addr(uint offset);
 extern void cpm_setbrg(uint brg, uint rate);
 extern void cpm2_fastbrg(uint brg, uint rate, int div16);
+extern void cpm2_reset(void);
+
 
 /* Buffer descriptors used by many of the CPM protocols.
 */
@@ -1087,5 +1090,3 @@ typedef struct im_idma {
 
 #endif /* __CPM2__ */
 #endif /* __KERNEL__ */
-
-
