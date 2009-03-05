Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <82074b2f0caa3852b64dd953a725304a072ea85a.1236229307.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [RFC/PATCH] Print linux_banner in prom_init
Date: Thu,  5 Mar 2009 16:02:01 +1100 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So at least you can see what kernel you're booting if you die
before the kernel prints it mid-way through start_kernel().

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/kernel/prom_init.c        |    2 ++
 arch/powerpc/kernel/prom_init_check.sh |    2 +-
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 7f1b33d..4d5ebb4 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -2283,6 +2283,8 @@ unsigned long __init prom_init(unsigned long r3, unsigned long r4,
 	 */
 	prom_init_stdout();
 
+	prom_printf("Preparing to boot %s", PTRRELOC((char *)linux_banner));
+
 	/*
 	 * Get default machine type. At this point, we do not differentiate
 	 * between pSeries SMP and pSeries LPAR
diff --git a/arch/powerpc/kernel/prom_init_check.sh b/arch/powerpc/kernel/prom_init_check.sh
index ea3a2ec..1ac136b 100644
--- a/arch/powerpc/kernel/prom_init_check.sh
+++ b/arch/powerpc/kernel/prom_init_check.sh
@@ -20,7 +20,7 @@ WHITELIST="add_reloc_offset __bss_start __bss_stop copy_and_flush
 _end enter_prom memcpy memset reloc_offset __secondary_hold
 __secondary_hold_acknowledge __secondary_hold_spinloop __start
 strcmp strcpy strlcpy strlen strncmp strstr logo_linux_clut224
-reloc_got2 kernstart_addr memstart_addr"
+reloc_got2 kernstart_addr memstart_addr linux_banner"
 
 NM="$1"
 OBJ="$2"
-- 
1.5.6.3
