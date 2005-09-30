Return-Path: <sfr@canb.auug.org.au>
Date: Sat, 1 Oct 2005 00:14:39 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Message-Id: <20051001001439.2f04423d.sfr@canb.auug.org.au>
In-Reply-To: <20050930233602.138b6e27.sfr@canb.auug.org.au>
References: <20050930233602.138b6e27.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc64-dev <linuxppc64-dev@ozlabs.org>, ppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 9/9] powerpc: make iSeries boot
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Now that we use the device tree, it helps to build it in.
It also helps to link the kernel at the correct address.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---

 arch/powerpc/Kconfig       |    4 ++--
 arch/powerpc/Kconfig.debug |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

1b4c416e0cf237dce004392122db45eb22dbc416
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -317,7 +317,7 @@ config PPC_BPA
 
 config PPC_OF
 	bool
-	depends on PPC_MULTIPLATFORM	# for now
+	depends on PPC_MULTIPLATFORM || PPC_ISERIES
 	default y
 
 config XICS
@@ -836,7 +836,7 @@ endmenu
 if PPC64
 config KERNEL_START
 	hex
-	default "0xc0000000"
+	default "0xc000000000000000"
 endif
 
 source "net/Kconfig"
diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -55,7 +55,7 @@ config BDI_SWITCH
 
 config BOOTX_TEXT
 	bool "Support for early boot text console (BootX or OpenFirmware only)"
-	depends PPC_OF
+	depends PPC_OF && !PPC_ISERIES
 	help
 	  Say Y here to see progress messages from the boot firmware in text
 	  mode. Requires either BootX or Open Firmware.
