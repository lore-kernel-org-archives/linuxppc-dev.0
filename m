Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao12.cox.net (fed1rmmtao12.cox.net [68.230.241.27])
	by ozlabs.org (Postfix) with ESMTP id D88662BF0C
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Dec 2004 05:49:09 +1100 (EST)
Date: Wed, 15 Dec 2004 11:49:05 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Message-ID: <20041215114904.A3696@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
Subject: [PATCH][PPC32] Add uImage to default targets
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We'd like to get a uImage when just using 'make' on many
targets. After some discussion, it made sense to simply
add uImage to the default targets since it adds minimal
build overhead and will work on all platforms. Also,
fix a dependency in the boot stuff.

Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

===== arch/ppc/Makefile 1.66 vs edited =====
--- 1.66/arch/ppc/Makefile	2004-10-05 17:28:57 -07:00
+++ edited/arch/ppc/Makefile	2004-12-15 10:27:30 -07:00
@@ -68,7 +68,7 @@
 
 .PHONY: $(BOOT_TARGETS)
 
-all: zImage
+all: uImage zImage
 
 CPPFLAGS_vmlinux.lds	:= -Upowerpc
 
===== arch/ppc/boot/simple/misc.c 1.24 vs edited =====
--- 1.24/arch/ppc/boot/simple/misc.c	2004-10-08 02:57:32 -07:00
+++ edited/arch/ppc/boot/simple/misc.c	2004-12-15 10:25:10 -07:00
@@ -102,7 +102,7 @@
 	com_port = serial_init(0, NULL);
 #endif
 
-#ifdef CONFIG_44x
+#if defined(CONFIG_44x) && defined(PPC44x_EMAC0_MR0)
 	/* Reset MAL */
 	mtdcr(DCRN_MALCR(DCRN_MAL_BASE), MALCR_MMSR);
 	/* Wait for reset */
