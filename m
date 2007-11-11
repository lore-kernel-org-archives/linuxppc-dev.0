Return-Path: <jochen@scram.de>
Received: from mail0.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail0.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id E0B61DDE2E
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 12 Nov 2007 04:02:01 +1100 (EST)
Message-ID: <47373571.3070605@scram.de>
Date: Sun, 11 Nov 2007 18:01:37 +0100
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: "linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] powerpc: Add EXPORT_SYMBOL for symbols required by fs_enet
	and cpm_uart
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Cc: paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

fs_enet and cpm_uart need symbols from commproc.c (for CPM1) or
cpm2_common.c. Add EXPORT_SYMBOL for cpmp, cpm_setbrg and cpm2_immr, so
the drivers can be compiled as modules.

  Building modules, stage 2.
  MODPOST 5 modules
ERROR: "cpm2_immr" [drivers/net/fs_enet/fs_enet.ko] undefined!
ERROR: "cpmp" [drivers/net/fs_enet/fs_enet.ko] undefined!
make[1]: *** [__modpost] Error 1
make: *** [modules] Error 2

Signed-off-by: Jochen Friedrich <jochen@scram.de>
---
 arch/powerpc/sysdev/commproc.c    |    3 +++
 arch/powerpc/sysdev/cpm2_common.c |    3 +++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/commproc.c b/arch/powerpc/sysdev/commproc.c
index f6a6378..d5a0dcf 100644
--- a/arch/powerpc/sysdev/commproc.c
+++ b/arch/powerpc/sysdev/commproc.c
@@ -51,6 +51,8 @@ static void m8xx_cpm_dpinit(void);
 static uint host_buffer; /* One page of host buffer */
 static uint host_end;    /* end + 1 */
 cpm8xx_t __iomem *cpmp;  /* Pointer to comm processor space */
+EXPORT_SYMBOL(cpmp);
+
 immap_t __iomem *mpc8xx_immr;
 static cpic8xx_t __iomem *cpic_reg;
 
@@ -302,6 +304,7 @@ cpm_setbrg(uint brg, uint rate)
 		out_be32(bp, (((BRG_UART_CLK_DIV16 / rate) - 1) << 1) |
 		             CPM_BRG_EN | CPM_BRG_DIV16);
 }
+EXPORT_SYMBOL(cpm_setbrg);
 
 #ifndef CONFIG_PPC_CPM_NEW_BINDING
 /*
diff --git a/arch/powerpc/sysdev/cpm2_common.c b/arch/powerpc/sysdev/cpm2_common.c
index 859362f..4ed5df6 100644
--- a/arch/powerpc/sysdev/cpm2_common.c
+++ b/arch/powerpc/sysdev/cpm2_common.c
@@ -51,11 +51,13 @@ static void cpm2_dpinit(void);
 #endif
 
 cpm_cpm2_t __iomem *cpmp; /* Pointer to comm processor space */
+EXPORT_SYMBOL(cpmp);
 
 /* We allocate this here because it is used almost exclusively for
  * the communication processor devices.
  */
 cpm2_map_t __iomem *cpm2_immr;
+EXPORT_SYMBOL(cpm2_immr);
 
 #define CPM_MAP_SIZE	(0x40000)	/* 256k - the PQ3 reserve this amount
 					   of space for CPM as it is larger
@@ -117,6 +119,7 @@ cpm_setbrg(uint brg, uint rate)
 
 	cpm2_unmap(bp);
 }
+EXPORT_SYMBOL(cpm_setbrg);
 
 /* This function is used to set high speed synchronous baud rate
  * clocks.
-- 
1.5.3.5
