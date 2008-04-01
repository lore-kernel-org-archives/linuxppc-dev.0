Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2B7CCDDF31
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Apr 2008 12:12:45 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: paulus@samba.org
Subject: [PATCH 09/11] [POWERPC] Clean up some linker and symbol usage
Date: Mon, 31 Mar 2008 21:08:33 -0500
Message-Id: <1207015715-31496-10-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1207015715-31496-9-git-send-email-galak@kernel.crashing.org>
References: <1207015715-31496-1-git-send-email-galak@kernel.crashing.org>
	<1207015715-31496-2-git-send-email-galak@kernel.crashing.org>
	<1207015715-31496-3-git-send-email-galak@kernel.crashing.org>
	<1207015715-31496-4-git-send-email-galak@kernel.crashing.org>
	<1207015715-31496-5-git-send-email-galak@kernel.crashing.org>
	<1207015715-31496-6-git-send-email-galak@kernel.crashing.org>
	<1207015715-31496-7-git-send-email-galak@kernel.crashing.org>
	<1207015715-31496-8-git-send-email-galak@kernel.crashing.org>
	<1207015715-31496-9-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* use _stext and _end sybmols when reserving kernel text in the lmb.  Use
  of these symbols is a bit more robust way to determine the physical start
  and size of the kernel text.
* PAGE_OFFSET is not always the start of code, use _stext instead.
* grab PAGE_SIZE and KERNELBASE from asm/page.h like ppc64 does.  Makes the
  code a bit more common and provide a single place to manipulate the
  defines for things like kdump.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/kernel/prom.c        |    2 +-
 arch/powerpc/kernel/setup_32.c    |    2 +-
 arch/powerpc/kernel/setup_64.c    |    2 +-
 arch/powerpc/kernel/vmlinux.lds.S |    4 +---
 4 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 9330920..60ef7d1 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -1124,7 +1124,7 @@ void __init early_init_devtree(void *params)
 	parse_early_param();
 
 	/* Reserve LMB regions used by kernel, initrd, dt, etc... */
-	lmb_reserve(PHYSICAL_START, __pa(klimit) - PHYSICAL_START);
+	lmb_reserve(__pa(_stext), _end - _stext);
 	reserve_kdump_trampoline();
 	reserve_crashkernel();
 	early_reserve_mem();
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index cd870a8..b0989ca 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -277,7 +277,7 @@ void __init setup_arch(char **cmdline_p)
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
