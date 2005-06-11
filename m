Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao07.cox.net (fed1rmmtao07.cox.net [68.230.241.32])
	by ozlabs.org (Postfix) with ESMTP id 572A767B31
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 11 Jun 2005 10:18:08 +1000 (EST)
Date: Fri, 10 Jun 2005 17:18:03 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: akpm@osdl.org
Message-ID: <20050610171802.B15999@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
Subject: [PATCH][MM] ppc32: enable rapidio on mpc85xx ads boards
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Enables RIO on the MPC8540/8560 ADS ref boards.  RIO can be used
with a crossover cable between two of them.

Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

diff --git a/arch/ppc/platforms/85xx/mpc85xx_ads_common.c b/arch/ppc/platforms/85xx/mpc85xx_ads_common.c
--- a/arch/ppc/platforms/85xx/mpc85xx_ads_common.c
+++ b/arch/ppc/platforms/85xx/mpc85xx_ads_common.c
@@ -47,6 +47,8 @@
 
 #include <mm/mmu_decl.h>
 
+#include <syslib/ppc85xx_rio.h>
+
 #include <platforms/85xx/mpc85xx_ads_common.h>
 
 #ifndef CONFIG_PCI
@@ -223,3 +225,11 @@ mpc85xx_exclude_device(u_char bus, u_cha
 }
 
 #endif /* CONFIG_PCI */
+
+#ifdef CONFIG_RAPIDIO
+void platform_rio_init(void)
+{
+	/* 512MB RIO LAW at 0xc0000000 */
+	mpc85xx_rio_setup(0xc0000000, 0x20000000);
+}
+#endif /* CONFIG_RAPIDIO */
