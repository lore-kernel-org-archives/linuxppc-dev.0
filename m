Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9406F1A0279
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Oct 2015 08:09:23 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: thuth@redhat.com
Subject: [PATCH 4/6] powerpc/kconfig: Move SCOM_DEBUGFS into "Kernel Hacking"
Date: Fri,  9 Oct 2015 08:09:15 +1100
Message-Id: <1444338557-14988-4-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1444338557-14988-1-git-send-email-mpe@ellerman.id.au>
References: <1444338557-14988-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently SCOM_DEBUGFS appears at the top level in menuconfig, but it's
not particularly important so shouldn't really be there. Move it under
"Kernel Hacking" which seems more appropriate.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/Kconfig.debug  | 5 +++++
 arch/powerpc/sysdev/Kconfig | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index 3a510f4a6b68..807515b1a743 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -63,6 +63,11 @@ config PPC_EMULATED_STATS
 	  warnings can be printed to the console when instructions are
 	  emulated.
 
+config SCOM_DEBUGFS
+	bool "Expose SCOM controllers via debugfs"
+	depends on PPC_SCOM && DEBUG_FS
+	default n
+
 config CODE_PATCHING_SELFTEST
 	bool "Run self-tests of the code-patching code."
 	depends on DEBUG_KERNEL
diff --git a/arch/powerpc/sysdev/Kconfig b/arch/powerpc/sysdev/Kconfig
index a19332a38715..fd8888b43f5b 100644
--- a/arch/powerpc/sysdev/Kconfig
+++ b/arch/powerpc/sysdev/Kconfig
@@ -32,11 +32,6 @@ source "arch/powerpc/sysdev/xics/Kconfig"
 config PPC_SCOM
 	bool
 
-config SCOM_DEBUGFS
-	bool "Expose SCOM controllers via debugfs"
-	depends on PPC_SCOM && DEBUG_FS
-	default n
-
 config GE_FPGA
 	bool
 	default n
-- 
2.1.4
