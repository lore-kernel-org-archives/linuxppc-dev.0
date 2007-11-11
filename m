Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910711111530g1f50d6e6hfaa76b4f051b5887@mail.gmail.com>
Date: Sun, 11 Nov 2007 18:30:40 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "PowerPC dev list" <Linuxppc-dev@ozlabs.org>,
	"Kumar Gala" <galak@kernel.crashing.org>
Subject: Re: Gianfar ethernet device
In-Reply-To: <9e4733910711111511v36aa3504s3b55438698a4b4a8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910711111511v36aa3504s3b55438698a4b4a8@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Does this patch add the right ifdefs in fsl_soc.c to make these
drivers build on their proper platforms? As an experiment I have
disabled platform bus on the mpc5200 and I'm only using of_platform
bus. Turning off platform bus is exposing a lot of code that is
getting built into my mpc5200 kernel that is supporting devices not
available on the platform.

A few more fixups in some other drivers and I should have mpc5200
working without platform bus.

diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index d6ef264..7017510 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -130,6 +130,7 @@ u32 get_baudrate(void)
 EXPORT_SYMBOL(get_baudrate);
 #endif /* CONFIG_CPM2 */

+#if defined(CONFIG_PPC_83xx) || defined(CONFIG_PPC_85xx) ||
defined(CONFIG_PPC_86xx)
 static int __init gfar_mdio_of_init(void)
 {
 	struct device_node *np;
@@ -317,6 +318,7 @@ err:
 }

 arch_initcall(gfar_of_init);
+#endif

 #ifdef CONFIG_PPC_83xx
 static int __init mpc83xx_wdt_init(void)
@@ -379,7 +381,7 @@ nodev:
 }

 arch_initcall(mpc83xx_wdt_init);
-#endif
+

 static enum fsl_usb2_phy_modes determine_usb_phy(const char *phy_type)
 {
@@ -542,6 +544,7 @@ err:
 }

 arch_initcall(fsl_usb_of_init);
+#endif

 #ifndef CONFIG_PPC_CPM_NEW_BINDING
 #ifdef CONFIG_CPM2
@@ -1085,6 +1088,7 @@ arch_initcall(cpm_smc_uart_of_init);
 #endif /* CONFIG_8xx */
 #endif /* CONFIG_PPC_CPM_NEW_BINDING */

+#if defined(CONFIG_PPC_83xx)
 int __init fsl_spi_init(struct spi_board_info *board_infos,
 			unsigned int num_board_infos,
 			void (*activate_cs)(u8 cs, u8 polarity),
@@ -1174,6 +1178,7 @@ err:

 	return spi_register_board_info(board_infos, num_board_infos);
 }
+#endif

 #if defined(CONFIG_PPC_85xx) || defined(CONFIG_PPC_86xx)
 static __be32 __iomem *rstcr;

-- 
Jon Smirl
jonsmirl@gmail.com
