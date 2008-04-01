Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 11A0EDDE19
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Apr 2008 12:12:38 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: paulus@samba.org
Subject: [PATCH 02/11] [POWERPC] Remove Kconfig option BOOT_LOAD
Date: Mon, 31 Mar 2008 21:08:26 -0500
Message-Id: <1207015715-31496-3-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1207015715-31496-2-git-send-email-galak@kernel.crashing.org>
References: <1207015715-31496-1-git-send-email-galak@kernel.crashing.org>
	<1207015715-31496-2-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Nothing appears to use BOOT_LOAD so remove it as a configurable option.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/Kconfig |   16 ----------------
 1 files changed, 0 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 3651355..4d9ced2 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -674,22 +674,6 @@ config CONSISTENT_SIZE
 	hex "Size of consistent memory pool" if CONSISTENT_SIZE_BOOL
 	default "0x00200000" if NOT_COHERENT_CACHE
 
-config BOOT_LOAD_BOOL
-	bool "Set the boot link/load address"
-	depends on ADVANCED_OPTIONS && !PPC_MULTIPLATFORM
-	help
-	  This option allows you to set the initial load address of the zImage
-	  or zImage.initrd file.  This can be useful if you are on a board
-	  which has a small amount of memory.
-
-	  Say N here unless you know what you are doing.
-
-config BOOT_LOAD
-	hex "Link/load address for booting" if BOOT_LOAD_BOOL
-	default "0x00400000" if 40x || 8xx || 8260
-	default "0x01000000" if 44x
-	default "0x00800000"
-
 config PIN_TLB
 	bool "Pinned Kernel TLBs (860 ONLY)"
 	depends on ADVANCED_OPTIONS && 8xx
-- 
1.5.4.1
