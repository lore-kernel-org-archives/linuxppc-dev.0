Return-Path: <mgreer@animalcreek.com>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40HMJ46LrMzF1tS
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Apr 2018 11:17:40 +1000 (AEST)
From: Mark Greer <mgreer@animalcreek.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Remi Machet <rmachet@nvidia.com>, Dale Farnsworth <dale@farnsworth.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Mark Greer <mgreer@animalcreek.com>
Subject: [PATCH 2/5] powerpc/boot: Remove support for Marvell MPSC serial
 controller
Date: Thu,  5 Apr 2018 18:17:17 -0700
Message-Id: <20180406011720.7728-3-mgreer@animalcreek.com>
In-Reply-To: <20180406011720.7728-1-mgreer@animalcreek.com>
References: <20180406011720.7728-1-mgreer@animalcreek.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There are no longer any platforms that use Marvell's MPSC serial
controller so remove its driver.

Signed-off-by: Mark Greer <mgreer@animalcreek.com>
---
 arch/powerpc/boot/Makefile |   2 +-
 arch/powerpc/boot/mpsc.c   | 169 ---------------------------------------------
 arch/powerpc/boot/ops.h    |   1 -
 arch/powerpc/boot/serial.c |   4 --
 4 files changed, 1 insertion(+), 175 deletions(-)
 delete mode 100644 arch/powerpc/boot/mpsc.c

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 70bf9b409fae..58f2dbfba275 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -120,7 +120,7 @@ src-wlib-$(CONFIG_40x) += 4xx.c planetcore.c
 src-wlib-$(CONFIG_44x) += 4xx.c ebony.c bamboo.c
 src-wlib-$(CONFIG_PPC_8xx) += mpc8xx.c planetcore.c fsl-soc.c
 src-wlib-$(CONFIG_PPC_82xx) += pq2.c fsl-soc.c planetcore.c
-src-wlib-$(CONFIG_EMBEDDED6xx) += mpsc.c mv64x60.c mv64x60_i2c.c ugecon.c fsl-soc.c
+src-wlib-$(CONFIG_EMBEDDED6xx) += mv64x60.c mv64x60_i2c.c ugecon.c fsl-soc.c
 src-wlib-$(CONFIG_XILINX_VIRTEX) += uartlite.c
 src-wlib-$(CONFIG_CPM) += cpm-serial.c
 
diff --git a/arch/powerpc/boot/mpsc.c b/arch/powerpc/boot/mpsc.c
deleted file mode 100644
index 425ad88cce8d..000000000000
--- a/arch/powerpc/boot/mpsc.c
+++ /dev/null
@@ -1,169 +0,0 @@
-/*
- * MPSC/UART driver for the Marvell mv64360, mv64460, ...
- *
- * Author: Mark A. Greer <mgreer@mvista.com>
- *
- * 2007 (c) MontaVista Software, Inc. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
- */
-
-#include <stdarg.h>
-#include <stddef.h>
-#include "types.h"
-#include "string.h"
-#include "stdio.h"
-#include "io.h"
-#include "ops.h"
-
-
-#define MPSC_CHR_1		0x000c
-
-#define MPSC_CHR_2		0x0010
-#define MPSC_CHR_2_TA		(1<<7)
-#define MPSC_CHR_2_TCS		(1<<9)
-#define MPSC_CHR_2_RA		(1<<23)
-#define MPSC_CHR_2_CRD		(1<<25)
-#define MPSC_CHR_2_EH		(1<<31)
-
-#define MPSC_CHR_4		0x0018
-#define MPSC_CHR_4_Z		(1<<29)
-
-#define MPSC_CHR_5		0x001c
-#define MPSC_CHR_5_CTL1_INTR	(1<<12)
-#define MPSC_CHR_5_CTL1_VALID	(1<<15)
-
-#define MPSC_CHR_10		0x0030
-
-#define MPSC_INTR_CAUSE		0x0000
-#define MPSC_INTR_CAUSE_RCC	(1<<6)
-#define MPSC_INTR_MASK		0x0080
-
-#define SDMA_SDCM		0x0008
-#define SDMA_SDCM_AR		(1<<15)
-#define SDMA_SDCM_AT		(1<<31)
-
-static volatile char *mpsc_base;
-static volatile char *mpscintr_base;
-static u32 chr1, chr2;
-
-static int mpsc_open(void)
-{
-	chr1 = in_le32((u32 *)(mpsc_base + MPSC_CHR_1)) & 0x00ff0000;
-	chr2 = in_le32((u32 *)(mpsc_base + MPSC_CHR_2)) & ~(MPSC_CHR_2_TA
-			| MPSC_CHR_2_TCS | MPSC_CHR_2_RA | MPSC_CHR_2_CRD
-			| MPSC_CHR_2_EH);
-	out_le32((u32 *)(mpsc_base + MPSC_CHR_4), MPSC_CHR_4_Z);
-	out_le32((u32 *)(mpsc_base + MPSC_CHR_5),
-			MPSC_CHR_5_CTL1_INTR | MPSC_CHR_5_CTL1_VALID);
-	out_le32((u32 *)(mpsc_base + MPSC_CHR_2), chr2 | MPSC_CHR_2_EH);
-	return 0;
-}
-
-static void mpsc_putc(unsigned char c)
-{
-	while (in_le32((u32 *)(mpsc_base + MPSC_CHR_2)) & MPSC_CHR_2_TCS);
-
-	out_le32((u32 *)(mpsc_base + MPSC_CHR_1), chr1 | c);
-	out_le32((u32 *)(mpsc_base + MPSC_CHR_2), chr2 | MPSC_CHR_2_TCS);
-}
-
-static unsigned char mpsc_getc(void)
-{
-	u32 cause = 0;
-	unsigned char c;
-
-	while (!(cause & MPSC_INTR_CAUSE_RCC))
-		cause = in_le32((u32 *)(mpscintr_base + MPSC_INTR_CAUSE));
-
-	c = in_8((u8 *)(mpsc_base + MPSC_CHR_10 + 2));
-	out_8((u8 *)(mpsc_base + MPSC_CHR_10 + 2), c);
-	out_le32((u32 *)(mpscintr_base + MPSC_INTR_CAUSE),
-			cause & ~MPSC_INTR_CAUSE_RCC);
-
-	return c;
-}
-
-static u8 mpsc_tstc(void)
-{
-	return (u8)((in_le32((u32 *)(mpscintr_base + MPSC_INTR_CAUSE))
-				& MPSC_INTR_CAUSE_RCC) != 0);
-}
-
-static void mpsc_stop_dma(volatile char *sdma_base)
-{
-	out_le32((u32 *)(mpsc_base + MPSC_CHR_2),MPSC_CHR_2_TA | MPSC_CHR_2_RA);
-	out_le32((u32 *)(sdma_base + SDMA_SDCM), SDMA_SDCM_AR | SDMA_SDCM_AT);
-
-	while ((in_le32((u32 *)(sdma_base + SDMA_SDCM))
-				& (SDMA_SDCM_AR | SDMA_SDCM_AT)) != 0)
-		udelay(100);
-}
-
-static volatile char *mpsc_get_virtreg_of_phandle(void *devp, char *prop)
-{
-	void *v;
-	int n;
-
-	n = getprop(devp, prop, &v, sizeof(v));
-	if (n != sizeof(v))
-		goto err_out;
-
-	devp = find_node_by_linuxphandle((u32)v);
-	if (devp == NULL)
-		goto err_out;
-
-	n = getprop(devp, "virtual-reg", &v, sizeof(v));
-	if (n == sizeof(v))
-		return v;
-
-err_out:
-	return NULL;
-}
-
-int mpsc_console_init(void *devp, struct serial_console_data *scdp)
-{
-	void *v;
-	int n, reg_set;
-	volatile char *sdma_base;
-
-	n = getprop(devp, "virtual-reg", &v, sizeof(v));
-	if (n != sizeof(v))
-		goto err_out;
-	mpsc_base = v;
-
-	sdma_base = mpsc_get_virtreg_of_phandle(devp, "sdma");
-	if (sdma_base == NULL)
-		goto err_out;
-
-	mpscintr_base = mpsc_get_virtreg_of_phandle(devp, "mpscintr");
-	if (mpscintr_base == NULL)
-		goto err_out;
-
-	n = getprop(devp, "cell-index", &v, sizeof(v));
-	if (n != sizeof(v))
-		goto err_out;
-	reg_set = (int)v;
-
-	mpscintr_base += (reg_set == 0) ? 0x4 : 0xc;
-
-	/* Make sure the mpsc ctlrs are shutdown */
-	out_le32((u32 *)(mpscintr_base + MPSC_INTR_CAUSE), 0);
-	out_le32((u32 *)(mpscintr_base + MPSC_INTR_CAUSE), 0);
-	out_le32((u32 *)(mpscintr_base + MPSC_INTR_MASK), 0);
-	out_le32((u32 *)(mpscintr_base + MPSC_INTR_MASK), 0);
-
-	mpsc_stop_dma(sdma_base);
-
-	scdp->open = mpsc_open;
-	scdp->putc = mpsc_putc;
-	scdp->getc = mpsc_getc;
-	scdp->tstc = mpsc_tstc;
-	scdp->close = NULL;
-
-	return 0;
-
-err_out:
-	return -1;
-}
diff --git a/arch/powerpc/boot/ops.h b/arch/powerpc/boot/ops.h
index fad1862f4b2d..cd043726ed88 100644
--- a/arch/powerpc/boot/ops.h
+++ b/arch/powerpc/boot/ops.h
@@ -86,7 +86,6 @@ void start(void);
 void fdt_init(void *blob);
 int serial_console_init(void);
 int ns16550_console_init(void *devp, struct serial_console_data *scdp);
-int mpsc_console_init(void *devp, struct serial_console_data *scdp);
 int cpm_console_init(void *devp, struct serial_console_data *scdp);
 int mpc5200_psc_console_init(void *devp, struct serial_console_data *scdp);
 int uartlite_console_init(void *devp, struct serial_console_data *scdp);
diff --git a/arch/powerpc/boot/serial.c b/arch/powerpc/boot/serial.c
index 88955095ec07..48e3743faedf 100644
--- a/arch/powerpc/boot/serial.c
+++ b/arch/powerpc/boot/serial.c
@@ -120,10 +120,6 @@ int serial_console_init(void)
 	if (dt_is_compatible(devp, "ns16550") ||
 	    dt_is_compatible(devp, "pnpPNP,501"))
 		rc = ns16550_console_init(devp, &serial_cd);
-#ifdef CONFIG_EMBEDDED6xx
-	else if (dt_is_compatible(devp, "marvell,mv64360-mpsc"))
-		rc = mpsc_console_init(devp, &serial_cd);
-#endif
 #ifdef CONFIG_CPM
 	else if (dt_is_compatible(devp, "fsl,cpm1-scc-uart") ||
 	         dt_is_compatible(devp, "fsl,cpm1-smc-uart") ||
-- 
2.16.2
