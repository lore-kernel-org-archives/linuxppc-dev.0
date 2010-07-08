Return-Path: <avorontsov@mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id B3CDCB6EED
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Jul 2010 03:16:13 +1000 (EST)
Date: Thu, 8 Jul 2010 21:16:10 +0400
From: Anton Vorontsov <avorontsov@mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 1/3] powerpc/cpm: Reintroduce global spi_pram struct (fixes
	build issue)
Message-ID: <20100708171610.GA11621@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: LEROY Christophe <christophe.leroy@c-s.fr>, linuxppc-dev@ozlabs.org,
	Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

spi_t was removed in commit 644b2a680ccc51a9ec4d6beb12e9d47d2dee98e2
("powerpc/cpm: Remove SPI defines and spi structs"), the commit assumed
that spi_t isn't used anywhere outside of the spi_mpc8xxx driver. But
it appears that the struct is needed for micropatch code. So, let's
reintroduce the struct.

Fixes the following build issue:

    CC      arch/powerpc/sysdev/micropatch.o
  micropatch.c: In function 'cpm_load_patch':
  micropatch.c:629: error: expected '=', ',', ';', 'asm' or '__attribute__' before '*' token
  micropatch.c:629: error: 'spp' undeclared (first use in this function)
  micropatch.c:629: error: (Each undeclared identifier is reported only once
  micropatch.c:629: error: for each function it appears in.)

Reported-by: LEROY Christophe <christophe.leroy@c-s.fr>
Reported-by: Tony Breeds <tony@bakeyournoodle.com>
Cc: <stable@kernel.org> [ .33, .34 ]
Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
---
 arch/powerpc/include/asm/cpm.h   |   24 ++++++++++++++++++++++++
 arch/powerpc/sysdev/micropatch.c |    7 ++++---
 drivers/spi/spi_mpc8xxx.c        |   22 ----------------------
 3 files changed, 28 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/include/asm/cpm.h b/arch/powerpc/include/asm/cpm.h
index 0835eb9..e50323f 100644
--- a/arch/powerpc/include/asm/cpm.h
+++ b/arch/powerpc/include/asm/cpm.h
@@ -7,6 +7,30 @@
 #include <linux/of.h>
 
 /*
+ * SPI Parameter RAM common to QE and CPM.
+ */
+struct spi_pram {
+	__be16	rbase;	/* Rx Buffer descriptor base address */
+	__be16	tbase;	/* Tx Buffer descriptor base address */
+	u8	rfcr;	/* Rx function code */
+	u8	tfcr;	/* Tx function code */
+	__be16	mrblr;	/* Max receive buffer length */
+	__be32	rstate;	/* Internal */
+	__be32	rdp;	/* Internal */
+	__be16	rbptr;	/* Internal */
+	__be16	rbc;	/* Internal */
+	__be32	rxtmp;	/* Internal */
+	__be32	tstate;	/* Internal */
+	__be32	tdp;	/* Internal */
+	__be16	tbptr;	/* Internal */
+	__be16	tbc;	/* Internal */
+	__be32	txtmp;	/* Internal */
+	__be32	res;	/* Tx temp. */
+	__be16  rpbase;	/* Relocation pointer (CPM1 only) */
+	__be16	res1;	/* Reserved */
+};
+
+/*
  * USB Controller pram common to QE and CPM.
  */
 struct usb_ctlr {
diff --git a/arch/powerpc/sysdev/micropatch.c b/arch/powerpc/sysdev/micropatch.c
index d8d6028..18080f3 100644
--- a/arch/powerpc/sysdev/micropatch.c
+++ b/arch/powerpc/sysdev/micropatch.c
@@ -16,6 +16,7 @@
 #include <asm/page.h>
 #include <asm/pgtable.h>
 #include <asm/8xx_immap.h>
+#include <asm/cpm.h>
 #include <asm/cpm1.h>
 
 /*
@@ -626,7 +627,7 @@ cpm_load_patch(cpm8xx_t	*cp)
 	volatile uint		*dp;		/* Dual-ported RAM. */
 	volatile cpm8xx_t	*commproc;
 	volatile iic_t		*iip;
-	volatile spi_t		*spp;
+	volatile struct spi_pram *spp;
 	volatile smc_uart_t	*smp;
 	int	i;
 
@@ -668,8 +669,8 @@ cpm_load_patch(cpm8xx_t	*cp)
 	/* Put SPI above the IIC, also 32-byte aligned.
 	*/
 	i = (RPBASE + sizeof(iic_t) + 31) & ~31;
-	spp = (spi_t *)&commproc->cp_dparam[PROFF_SPI];
-	spp->spi_rpbase = i;
+	spp = (struct spi_pram *)&commproc->cp_dparam[PROFF_SPI];
+	spp->rpbase = i;
 
 # if defined(CONFIG_I2C_SPI_UCODE_PATCH)
 	commproc->cp_cpmcr1 = 0x802a;
diff --git a/drivers/spi/spi_mpc8xxx.c b/drivers/spi/spi_mpc8xxx.c
index ffa111a..97ab0a8 100644
--- a/drivers/spi/spi_mpc8xxx.c
+++ b/drivers/spi/spi_mpc8xxx.c
@@ -66,28 +66,6 @@ struct mpc8xxx_spi_reg {
 	__be32 receive;
 };
 
-/* SPI Parameter RAM */
-struct spi_pram {
-	__be16	rbase;	/* Rx Buffer descriptor base address */
-	__be16	tbase;	/* Tx Buffer descriptor base address */
-	u8	rfcr;	/* Rx function code */
-	u8	tfcr;	/* Tx function code */
-	__be16	mrblr;	/* Max receive buffer length */
-	__be32	rstate;	/* Internal */
-	__be32	rdp;	/* Internal */
-	__be16	rbptr;	/* Internal */
-	__be16	rbc;	/* Internal */
-	__be32	rxtmp;	/* Internal */
-	__be32	tstate;	/* Internal */
-	__be32	tdp;	/* Internal */
-	__be16	tbptr;	/* Internal */
-	__be16	tbc;	/* Internal */
-	__be32	txtmp;	/* Internal */
-	__be32	res;	/* Tx temp. */
-	__be16  rpbase;	/* Relocation pointer (CPM1 only) */
-	__be16	res1;	/* Reserved */
-};
-
 /* SPI Controller mode register definitions */
 #define	SPMODE_LOOP		(1 << 30)
 #define	SPMODE_CI_INACTIVEHIGH	(1 << 29)
-- 
1.7.0.5
