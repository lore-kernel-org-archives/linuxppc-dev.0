Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 17E0ADDF00
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2008 16:03:24 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id m2B53KPC015108
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2008 00:03:20 -0500
Date: Tue, 11 Mar 2008 00:00:03 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] Remove Kconfig option BOOT_LOAD
Message-ID: <Pine.LNX.4.64.0803102359240.19195@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Nothing appears to use BOOT_LOAD so remove it as a configurable option.

---
in my powerpc-next branch.

- k

 arch/powerpc/Kconfig |   16 ----------------
 1 files changed, 0 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index e4e13e0..803415e 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -663,22 +663,6 @@ config CONSISTENT_SIZE
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
