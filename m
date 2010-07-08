Return-Path: <avorontsov@mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id A98FEB6EEF
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Jul 2010 03:16:15 +1000 (EST)
Date: Thu, 8 Jul 2010 21:16:14 +0400
From: Anton Vorontsov <avorontsov@mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 2/3] powerpc/cpm1: Fix build with various
	CONFIG_*_UCODE_PATCH combinations
Message-ID: <20100708171614.GB11621@oksana.dev.rtsoft.ru>
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

Warnings are treated as errors for arch/powerpc code, so build fails
with CONFIG_I2C_SPI_UCODE_PATCH=y:

    CC      arch/powerpc/sysdev/micropatch.o
  cc1: warnings being treated as errors
  arch/powerpc/sysdev/micropatch.c: In function 'cpm_load_patch':
  arch/powerpc/sysdev/micropatch.c:630: warning: unused variable 'smp'
  make[1]: *** [arch/powerpc/sysdev/micropatch.o] Error 1

And with CONFIG_USB_SOF_UCODE_PATCH=y:

  CC      arch/powerpc/sysdev/micropatch.o
  cc1: warnings being treated as errors
  arch/powerpc/sysdev/micropatch.c: In function 'cpm_load_patch':
  arch/powerpc/sysdev/micropatch.c:629: warning: unused variable 'spp'
  arch/powerpc/sysdev/micropatch.c:628: warning: unused variable 'iip'
  make[1]: *** [arch/powerpc/sysdev/micropatch.o] Error 1

This patch fixes these issues by introducing proper #ifdefs.

Cc: <stable@kernel.org> [ .33, .34 ]
Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
---
 arch/powerpc/sysdev/micropatch.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/micropatch.c b/arch/powerpc/sysdev/micropatch.c
index 18080f3..6c56ae9 100644
--- a/arch/powerpc/sysdev/micropatch.c
+++ b/arch/powerpc/sysdev/micropatch.c
@@ -626,9 +626,14 @@ cpm_load_patch(cpm8xx_t	*cp)
 {
 	volatile uint		*dp;		/* Dual-ported RAM. */
 	volatile cpm8xx_t	*commproc;
+#if defined(CONFIG_I2C_SPI_UCODE_PATCH) || \
+    defined(CONFIG_I2C_SPI_SMC1_UCODE_PATCH)
 	volatile iic_t		*iip;
 	volatile struct spi_pram *spp;
+#ifdef CONFIG_I2C_SPI_SMC1_UCODE_PATCH
 	volatile smc_uart_t	*smp;
+#endif
+#endif
 	int	i;
 
 	commproc = cp;
-- 
1.7.0.5
