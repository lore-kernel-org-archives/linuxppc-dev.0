Return-Path: <anton@ozlabs.org>
Date: Wed, 9 Jun 2010 16:01:10 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org
Subject: [PATCH] powerpc: rtas_flash cannot be a module
Message-ID: <20100609060110.GM28295@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


When trying to flash a machine via the update_flash command, I received the
following error:


    Restarting system.
    FLASH: kernel bug...flash list header addr above 4GB


The code in question has a comment that the flash list should be in
the kernel data and therefore under 4GB:

        /* NOTE: the "first" block list is a global var with no data
         * blocks in the kernel data segment.  We do this because
         * we want to ensure this block_list addr is under 4GB.
         */

Unfortunately the Kconfig option is marked tristate which means the variable
may not be in the kernel data and could be above 4GB.

Change RTAS_FLASH to a bool. If we are worried about kernel footprint we
could move the problem variables out of the module and export them.

Signed-off-by: Anton Blanchard <anton@samba.org>
---     

Index: linux-2.6/arch/powerpc/platforms/Kconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/Kconfig	2010-06-09 15:44:53.635955260 +1000
+++ linux-2.6/arch/powerpc/platforms/Kconfig	2010-06-09 15:45:00.503453428 +1000
@@ -97,7 +97,7 @@ config RTAS_PROC
 	default y
 
 config RTAS_FLASH
-	tristate "Firmware flash interface"
+	bool "Firmware flash interface"
 	depends on PPC64 && RTAS_PROC
 
 config MMIO_NVRAM
Index: linux-2.6/arch/powerpc/configs/ppc64_defconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/configs/ppc64_defconfig	2010-06-09 15:46:25.394704486 +1000
+++ linux-2.6/arch/powerpc/configs/ppc64_defconfig	2010-06-09 15:46:37.083454943 +1000
@@ -264,7 +264,7 @@ CONFIG_U3_DART=y
 CONFIG_PPC_RTAS=y
 CONFIG_RTAS_ERROR_LOGGING=y
 CONFIG_RTAS_PROC=y
-CONFIG_RTAS_FLASH=m
+CONFIG_RTAS_FLASH=y
 CONFIG_PPC_PMI=m
 CONFIG_MMIO_NVRAM=y
 CONFIG_MPIC_U3_HT_IRQS=y
Index: linux-2.6/arch/powerpc/configs/pseries_defconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/configs/pseries_defconfig	2010-06-09 15:46:25.364703092 +1000
+++ linux-2.6/arch/powerpc/configs/pseries_defconfig	2010-06-09 15:46:31.723454300 +1000
@@ -213,7 +213,7 @@ CONFIG_PPC_I8259=y
 CONFIG_PPC_RTAS=y
 CONFIG_RTAS_ERROR_LOGGING=y
 CONFIG_RTAS_PROC=y
-CONFIG_RTAS_FLASH=m
+CONFIG_RTAS_FLASH=y
 # CONFIG_MMIO_NVRAM is not set
 CONFIG_IBMVIO=y
 CONFIG_IBMEBUS=y
