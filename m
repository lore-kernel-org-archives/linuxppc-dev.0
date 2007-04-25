Return-Path: <yur@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 114B4DDF0E
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2007 04:33:53 +1000 (EST)
From: Yuri Tikhonov <yur@emcraft.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] ppc: Add support for bigger page sizes than 4KB on PPC44x
Date: Wed, 25 Apr 2007 21:37:06 +0400
References: <200703161634.58444.yur@emcraft.com>
	<200703171441.51276.yur@emcraft.com>
	<17921.3150.242081.66071@cargo.ozlabs.ibm.com>
In-Reply-To: <17921.3150.242081.66071@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200704252137.06340.yur@emcraft.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


 The patch replaces the CONFIG_PPC_PAGE_SHIFT integer option with choice of
three boolean options

 Signed-off-by: Yuri Tikhonov <yur@emcraft.com>
--

diff --git a/arch/ppc/Kconfig b/arch/ppc/Kconfig
index 72af523..5eb58dc 100644
--- a/arch/ppc/Kconfig
+++ b/arch/ppc/Kconfig
@@ -1201,15 +1201,24 @@ config SECCOMP

          If unsure, say Y. Only embedded should say N here.

-config PPC_PAGE_SHIFT
-       int "Page size (12=>4KB; 14=>16KB; 16=>64KB)" if 44x
-       default "12"
-       range 12 16
-       help
+choice
+       prompt "Page size"
+       default PPC_PAGE_4K
+       ---help---
          The PAGE_SIZE definition. Increasing the page size may
          improve the system performance in some dedicated cases.

-         If unsure, set it to 12 (4KB).
+         If unsure, set it to 4 KB.
+
+config PPC_PAGE_4K
+       bool "4 KB"
+
+config PPC_PAGE_16K
+       bool "16 KB" if 44x
+
+config PPC_PAGE_64K
+       bool "64 KB" if 44x
+endchoice

 endmenu

diff --git a/include/asm-ppc/page.h b/include/asm-ppc/page.h
index 0b8f354..f46712e 100644
--- a/include/asm-ppc/page.h
+++ b/include/asm-ppc/page.h
@@ -4,7 +4,13 @@
 #include <asm/asm-compat.h>

 /* PAGE_SHIFT determines the page size */
-#define PAGE_SHIFT     CONFIG_PPC_PAGE_SHIFT
+#if defined(CONFIG_PPC_PAGE_4K)
+#define PAGE_SHIFT     12
+#elif defined(CONFIG_PPC_PAGE_16K)
+#define PAGE_SHIFT     14
+#elif defined(CONFIG_PPC_PAGE_64K)
+#define PAGE_SHIFT     16
+#endif
 #define PAGE_SIZE      (ASM_CONST(1) << PAGE_SHIFT)

 /*
