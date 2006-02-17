Return-Path: <dale@farnsworth.org>
Received: from farnsworth.org (unknown [65.200.49.142])
	by ozlabs.org (Postfix) with SMTP id 38627679F2
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 18 Feb 2006 10:37:35 +1100 (EST)
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Fri, 17 Feb 2006 16:37:33 -0700
To: Kumar Gala <galak@kernel.crashing.org>
Subject: ppc32: mpc85xx: set pcibios_fixup only #ifdef CONFIG_PCI
Message-ID: <20060217233733.GA30701@xyzzy.farnsworth.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

From: Dale Farnsworth <dale@farnsworth.org>

Signed-off-by: Dale Farnsworth <dale@farnsworth.org>
---

 arch/ppc/platforms/85xx/mpc85xx_cds_common.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6.10/arch/ppc/platforms/85xx/mpc85xx_cds_common.c
===================================================================
--- linux-2.6.10.orig/arch/ppc/platforms/85xx/mpc85xx_cds_common.c
+++ linux-2.6.10/arch/ppc/platforms/85xx/mpc85xx_cds_common.c
@@ -456,9 +456,6 @@ mpc85xx_cds_setup_arch(void)
 	mtspr(SPRN_DBCR0, (DBCR0_IDM));
 	mtspr(SPRN_DBSR, 0xffffffff);
 #endif
-
- 	/* VIA IDE configuration */
-         ppc_md.pcibios_fixup = mpc85xx_cds_pcibios_fixup;
  
 #ifdef CONFIG_CPM2
 	cpm2_reset();
@@ -480,6 +477,9 @@ mpc85xx_cds_setup_arch(void)
         loops_per_jiffy = freq / HZ;
 
 #ifdef CONFIG_PCI
+ 	/* VIA IDE configuration */
+         ppc_md.pcibios_fixup = mpc85xx_cds_pcibios_fixup;
+
         /* setup PCI host bridges */
         mpc85xx_setup_hose();
 #endif
