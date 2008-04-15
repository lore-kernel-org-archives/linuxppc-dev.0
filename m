Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B33E0DE904
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 05:56:29 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: paulus@samba.org
Subject: [PATCH 08/13] [POWERPC] Clean up some linker and symbol usage
Date: Tue, 15 Apr 2008 14:52:26 -0500
Message-Id: <1208289151-2925-9-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1208289151-2925-8-git-send-email-galak@kernel.crashing.org>
References: <1208289151-2925-1-git-send-email-galak@kernel.crashing.org>
	<1208289151-2925-2-git-send-email-galak@kernel.crashing.org>
	<1208289151-2925-3-git-send-email-galak@kernel.crashing.org>
	<1208289151-2925-4-git-send-email-galak@kernel.crashing.org>
	<1208289151-2925-5-git-send-email-galak@kernel.crashing.org>
	<1208289151-2925-6-git-send-email-galak@kernel.crashing.org>
	<1208289151-2925-7-git-send-email-galak@kernel.crashing.org>
	<1208289151-2925-8-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* PAGE_OFFSET is not always the start of code, use _stext instead.
* grab PAGE_SIZE and KERNELBASE from asm/page.h like ppc64 does.  Makes the
  code a bit more common and provide a single place to manipulate the
  defines for things like kdump.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/kernel/setup_32.c    |    2 +-
 arch/powerpc/kernel/setup_64.c    |    2 +-
 arch/powerpc/kernel/vmlinux.lds.S |    4 +---
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index eac936e..d813c39 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -289,7 +289,7 @@ void __init setup_arch(char **cmdline_p)
 	if (ppc_md.panic)
 		setup_panic();
 
-	init_mm.start_code = PAGE_OFFSET;
+	init_mm.start_code = (unsigned long)_stext;
 	init_mm.end_code = (unsigned long) _etext;
 	init_mm.end_data = (unsigned long) _edata;
 	init_mm.brk = klimit;
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 2c2d831..0205d40 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -510,7 +510,7 @@ void __init setup_arch(char **cmdline_p)
 	if (ppc_md.panic)
 		setup_panic();
 
-	init_mm.start_code = PAGE_OFFSET;
+	init_mm.start_code = (unsigned long)_stext;
 	init_mm.end_code = (unsigned long) _etext;
 	init_mm.end_data = (unsigned long) _edata;
 	init_mm.brk = klimit;
diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 0afb9e3..b5a76bc 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -1,11 +1,9 @@
 #ifdef CONFIG_PPC64
-#include <asm/page.h>
 #define PROVIDE32(x)	PROVIDE(__unused__##x)
 #else
-#define PAGE_SIZE	4096
-#define KERNELBASE	CONFIG_KERNEL_START
 #define PROVIDE32(x)	PROVIDE(x)
 #endif
+#include <asm/page.h>
 #include <asm-generic/vmlinux.lds.h>
 #include <asm/cache.h>
 
-- 
1.5.4.1
