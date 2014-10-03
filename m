Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 8752E1A1A16
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Oct 2014 22:56:14 +1000 (EST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Mark Brown <broonie@kernel.org>,
 Marcelo Tosatti <marcelo@kvack.org>, Vitaly Bordug <vitb@kernel.crashing.org>
Subject: [PATCH 2/2] spi: fsl-spi: Allow dynamic allocation of CPM1 parameter
 RAM
Message-Id: <20141003125609.5BEA11AB276@localhost.localdomain>
Date: Fri,  3 Oct 2014 14:56:09 +0200 (CEST)
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On CPM1, the SPI parameter RAM has a default location. In order to use SPI while
using SCC2 with features like QMC or Ethernet, it is necessary to relocate SPI
parameter RAM in a free location in the CPM dual port RAM. With this patch,
when CONFIG_CPM1_RELOCSPI is set, the parameter RAM for SPI is dynamically
allocated with cpm_muram_alloc().

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

---
 arch/powerpc/platforms/8xx/Kconfig | 11 +++++++++++
 drivers/spi/spi-fsl-cpm.c          |  5 +++++
 2 files changed, 16 insertions(+)

diff --git a/arch/powerpc/platforms/8xx/Kconfig b/arch/powerpc/platforms/8xx/Kconfig
index 7c1690b..3b76a3f 100644
--- a/arch/powerpc/platforms/8xx/Kconfig
+++ b/arch/powerpc/platforms/8xx/Kconfig
@@ -203,4 +203,15 @@ config UCODE_PATCH
 	default y
 	depends on !NO_UCODE_PATCH
 
+config CPM1_RELOCSPI
+	bool "Dynamic SPI relocation"
+	default n
+	help
+	  On recent MPC8xx (at least MPC866 and MPC885) SPI can be relocated
+	  without micropatch. This activates relocation to a dynamically
+	  allocated area in the CPM Dual port RAM.
+	  When combined with SPI relocation patch (for older MPC8xx) it avoids
+	  the "loss" of additional Dual port RAM space just above the patch,
+	  which might be needed for example when using the CPM QMC.
+
 endmenu
diff --git a/drivers/spi/spi-fsl-cpm.c b/drivers/spi/spi-fsl-cpm.c
index 0f3a912..f33820e 100644
--- a/drivers/spi/spi-fsl-cpm.c
+++ b/drivers/spi/spi-fsl-cpm.c
@@ -262,6 +262,10 @@ static unsigned long fsl_spi_cpm_get_pram(struct mpc8xxx_spi *mspi)
 		pram_ofs = cpm_muram_alloc(SPI_PRAM_SIZE, 64);
 		out_be16(spi_base, pram_ofs);
 	} else {
+#ifdef CONFIG_CPM1_RELOCSPI
+		pram_ofs = cpm_muram_alloc(SPI_PRAM_SIZE, 32);
+		out_be16(spi_base, pram_ofs);
+#else
 		u16 rpbase = in_be16(spi_base);
 
 		/* Microcode relocation patch applied | rpbase set by default */
@@ -271,6 +275,7 @@ static unsigned long fsl_spi_cpm_get_pram(struct mpc8xxx_spi *mspi)
 			pram_ofs = offsetof(cpm8xx_t, cp_dparam[PROFF_SPI]) -
 				   offsetof(cpm8xx_t, cp_dpmem[0]);
 		}
+#endif
 	}
 
 	iounmap(spi_base);
-- 
2.1.0
