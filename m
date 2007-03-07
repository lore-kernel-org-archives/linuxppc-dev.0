Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 40490DDF21
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Mar 2007 16:47:43 +1100 (EST)
Date: Wed, 7 Mar 2007 16:47:37 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [POWERPC] Clean up deciding when PCI is selectable
Message-Id: <20070307164737.e927711d.sfr@canb.auug.org.au>
In-Reply-To: <1173033826.8184.68.camel@localhost.localdomain>
References: <20070304165839.4d2bf50b.sfr@canb.auug.org.au>
	<20070304170348.511af7cb.sfr@canb.auug.org.au>
	<20070304170444.2eb423ce.sfr@canb.auug.org.au>
	<200703041507.06307.arnd@arndb.de>
	<1173033826.8184.68.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/Kconfig                       |   18 +++++++++++++++---
 arch/powerpc/platforms/85xx/Kconfig        |    1 +
 arch/powerpc/platforms/embedded6xx/Kconfig |    2 ++
 3 files changed, 18 insertions(+), 3 deletions(-)

On Sun, 04 Mar 2007 19:43:46 +0100 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
> I dislike the giant conditional though.

How about this (only tested on a couple of configs).

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index e720527..d7c447f 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -157,12 +157,14 @@ config PPC_83xx
 	select FSL_SOC
 	select 83xx
 	select PPC_FPU
+	select PCI_SELECTABLE
 
 config PPC_85xx
 	bool "Freescale 85xx"
 	select E500
 	select FSL_SOC
 	select 85xx
+	select PCI_SELECTABLE
 
 config PPC_86xx
 	bool "Freescale 86xx"
@@ -170,6 +172,7 @@ config PPC_86xx
 	select FSL_SOC
 	select PPC_FPU
 	select ALTIVEC
+	select PCI_SELECTABLE
 	help
 	  The Freescale E600 SoCs have 74xx cores.
 
@@ -181,6 +184,7 @@ config PPC_8xx
 config 40x
 	bool "AMCC 40x"
 	select PPC_DCR_NATIVE
+	select PCI_SELECTABLE
 
 config 44x
 	bool "AMCC 44x"
@@ -413,12 +417,14 @@ config PPC_PSERIES
 	select RTAS_ERROR_LOGGING
 	select PPC_UDBG_16550
 	select PPC_NATIVE
+	select PCI_SELECTABLE if EMBEDDED
 	default y
 
 config PPC_ISERIES
 	bool "IBM Legacy iSeries"
 	depends on PPC_MULTIPLATFORM && PPC64
 	select PPC_INDIRECT_IO
+	select PCI_SELECTABLE if EMBEDDED
 
 config PPC_CHRP
 	bool "Common Hardware Reference Platform (CHRP) based machines"
@@ -434,6 +440,7 @@ config PPC_CHRP
 
 config PPC_MPC52xx
 	bool
+	select PCI_SELECTABLE
 	default n
 
 config PPC_MPC5200
@@ -557,6 +564,7 @@ config PPC_PS3
 	select USB_OHCI_BIG_ENDIAN_MMIO
 	select USB_ARCH_HAS_EHCI
 	select USB_EHCI_BIG_ENDIAN_MMIO
+	select PCI_SELECTABLE
 	help
 	  This option enables support for the Sony PS3 game console
 	  and other platforms using the PS3 hypervisor.
@@ -1026,10 +1034,14 @@ config FSL_SOC
 config MCA
 	bool
 
+config PCI_SELECTABLE
+	def_bool n
+	help
+	  A platform should select this if the builder of the kernel may
+	  choose whether CONFIG_PCI is set or not.
+
 config PCI
-	bool "PCI support" if 40x || CPM2 || PPC_83xx || PPC_85xx || PPC_86xx \
-		|| PPC_MPC52xx || (EMBEDDED && (PPC_PSERIES || PPC_ISERIES)) \
-		|| MPC7448HPC2 || PPC_PS3
+	bool "PCI support" if PCI_SELECTABLE
 	default y if !40x && !CPM2 && !8xx && !APUS && !PPC_83xx \
 		&& !PPC_85xx && !PPC_86xx
 	default PCI_PERMEDIA if !4xx && !CPM2 && !8xx && APUS
diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index eb661cc..67af06d 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -60,6 +60,7 @@ config MPIC
 
 config CPM2
 	bool
+	select PCI_SELECTABLE
 	depends on MPC8560
 	default y
 	help
diff --git a/arch/powerpc/platforms/embedded6xx/Kconfig b/arch/powerpc/platforms/embedded6xx/Kconfig
index 886c522..b659515 100644
--- a/arch/powerpc/platforms/embedded6xx/Kconfig
+++ b/arch/powerpc/platforms/embedded6xx/Kconfig
@@ -93,6 +93,7 @@ config MPC7448HPC2
 	select PPC_UDBG_16550
 	select MPIC
 	select MPIC_WEIRD
+	select PCI_SELECTABLE
 	help
 	  Select MPC7448HPC2 if configuring for Freescale MPC7448HPC2 (Taiga)
 	  platform
@@ -187,6 +188,7 @@ config 8272
 config CPM2
 	bool
 	depends on 8260 || MPC8560 || MPC8555
+	select PCI_SELECTABLE
 	default y
 	help
 	  The CPM2 (Communications Processor Module) is a coprocessor on
-- 
1.5.0.2
