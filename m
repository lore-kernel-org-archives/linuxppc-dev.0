Return-Path: <dale@farnsworth.org>
Received: from farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	by ozlabs.org (Postfix) with SMTP id 9C778DDF6F
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Nov 2007 02:46:13 +1100 (EST)
Date: Thu, 22 Nov 2007 08:46:12 -0700
From: Dale Farnsworth <dale@farnsworth.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 04/10] powerpc: Add crash kernel support for classic ppc
Message-ID: <20071122154611.GA26459@xyzzy.farnsworth.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071122154159.GA24711@xyzzy.farnsworth.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add the ability for a classic ppc kernel to be loaded at
an address of 32MB.  This done by fixing a few places that
assume we are loaded at address 0, and by changing several
uses of KERNELBASE to use PAGE_OFFSET, instead.  We also
wire up the trampoline code for ppc32 to relay exceptions
from the vectors at address 0 to vectors at address 32MB.

Signed-off-by: Dale Farnsworth <dale@farnsworth.org>
---
 arch/powerpc/Kconfig              |    2 +-
 arch/powerpc/kernel/crash_dump.c  |    1 +
 arch/powerpc/kernel/head_32.S     |   11 ++++++-----
 arch/powerpc/kernel/setup_32.c    |    2 ++
 arch/powerpc/kernel/vmlinux.lds.S |    4 +---
 arch/powerpc/mm/init_32.c         |    2 +-
 arch/powerpc/mm/pgtable_32.c      |    4 ++--
 arch/powerpc/mm/ppc_mmu_32.c      |    8 ++++----
 include/asm-powerpc/ppc_asm.h     |    4 ++--
 9 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 9e9581a..805b4d1 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -253,7 +253,7 @@ config KEXEC
 
 config CRASH_DUMP
 	bool "Build a kdump crash kernel (EXPERIMENTAL)"
-	depends on PPC_MULTIPLATFORM && PPC64 && EXPERIMENTAL
+	depends on PPC_MULTIPLATFORM && EXPERIMENTAL
 	help
 	  Build a kernel suitable for use as a kdump capture kernel.
 	  The kernel will be linked at a different address than normal, and
diff --git a/arch/powerpc/kernel/crash_dump.c b/arch/powerpc/kernel/crash_dump.c
index 29ff77c..77c0376 100644
--- a/arch/powerpc/kernel/crash_dump.c
+++ b/arch/powerpc/kernel/crash_dump.c
@@ -40,6 +40,7 @@ static void __init create_trampoline(unsigned long addr)
 	 * branch to "addr" we jump to ("addr" + 32 MB). Although it requires
 	 * two instructions it doesn't require any registers.
 	 */
+	addr += PAGE_OFFSET;
 	create_instruction(addr, 0x60000000); /* nop */
 	create_branch(addr + 4, addr + PHYSICAL_START, 0);
 }
diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index a5b13ae..a9b50ab 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -175,7 +175,8 @@ __after_mmu_off:
 	bl	reloc_offset
 	mr	r26,r3
 	addis	r4,r3,KERNELBASE@h	/* current address of _start */
-	cmpwi	0,r4,0			/* are we already running at 0? */
+	lis	r5,PHYSICAL_START@h
+	cmplw	0,r4,r5			/* already running at PHYSICAL_START? */
 	bne	relocate_kernel
 /*
  * we now have the 1st 16M of ram mapped with the bats.
@@ -818,13 +819,13 @@ giveup_altivec:
 
 /*
  * This code is jumped to from the startup code to copy
- * the kernel image to physical address 0.
+ * the kernel image to physical address PHYSICAL_START.
  */
 relocate_kernel:
 	addis	r9,r26,klimit@ha	/* fetch klimit */
 	lwz	r25,klimit@l(r9)
 	addis	r25,r25,-KERNELBASE@h
-	li	r3,0			/* Destination base address */
+	lis	r3,PHYSICAL_START@h	/* Destination base address */
 	li	r6,0			/* Destination offset */
 	li	r5,0x4000		/* # bytes of memory to copy */
 	bl	copy_and_flush		/* copy the first 0x4000 bytes */
@@ -1186,11 +1187,11 @@ mmu_off:
 
 /*
  * Use the first pair of BAT registers to map the 1st 16MB
- * of RAM to KERNELBASE.  From this point on we can't safely
+ * of RAM to PAGE_OFFSET.  From this point on we can't safely
  * call OF any more.
  */
 initial_bats:
-	lis	r11,KERNELBASE@h
+	lis	r11,PAGE_OFFSET@h
 	mfspr	r9,SPRN_PVR
 	rlwinm	r9,r9,16,16,31		/* r9 = 1 for 601, 4 for 604 */
 	cmpwi	0,r9,1
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index cd870a8..bbb4caf 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -128,6 +128,8 @@ void __init machine_init(unsigned long dt_ptr, unsigned long phys)
 
 	probe_machine();
 
+	setup_kdump_trampoline();
+
 #ifdef CONFIG_6xx
 	if (cpu_has_feature(CPU_FTR_CAN_DOZE) ||
 	    cpu_has_feature(CPU_FTR_CAN_NAP))
diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index f66fa5d..242f17d 100644
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
 
diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
index 977cb1e..a25d3d7 100644
--- a/arch/powerpc/mm/init_32.c
+++ b/arch/powerpc/mm/init_32.c
@@ -48,7 +48,7 @@
 
 #if defined(CONFIG_KERNEL_START_BOOL) || defined(CONFIG_LOWMEM_SIZE_BOOL)
 /* The ammount of lowmem must be within 0xF0000000 - KERNELBASE. */
-#if (CONFIG_LOWMEM_SIZE > (0xF0000000 - KERNELBASE))
+#if (CONFIG_LOWMEM_SIZE > (0xF0000000 - PAGE_OFFSET))
 #error "You must adjust CONFIG_LOWMEM_SIZE or CONFIG_START_KERNEL"
 #endif
 #endif
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index 6448872..e7505ea 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -275,7 +275,7 @@ int map_page(unsigned long va, phys_addr_t pa, int flags)
 }
 
 /*
- * Map in all of physical memory starting at KERNELBASE.
+ * Map in all of physical memory starting at PAGE_OFFSET.
  */
 void __init mapin_ram(void)
 {
@@ -283,7 +283,7 @@ void __init mapin_ram(void)
 	int ktext;
 
 	s = mmu_mapin_ram();
-	v = KERNELBASE + s;
+	v = PAGE_OFFSET + s;
 	p = PPC_MEMSTART + s;
 	for (; s < total_lowmem; s += PAGE_SIZE) {
 		ktext = ((char *) v >= _stext && (char *) v < etext);
diff --git a/arch/powerpc/mm/ppc_mmu_32.c b/arch/powerpc/mm/ppc_mmu_32.c
index 5c45d47..6316895 100644
--- a/arch/powerpc/mm/ppc_mmu_32.c
+++ b/arch/powerpc/mm/ppc_mmu_32.c
@@ -105,16 +105,16 @@ unsigned long __init mmu_mapin_ram(void)
 			break;
 	}
 
-	setbat(2, KERNELBASE, PPC_MEMSTART, bl, _PAGE_RAM);
-	done = (unsigned long)bat_addrs[2].limit - KERNELBASE + 1;
+	setbat(2, PAGE_OFFSET, PPC_MEMSTART, bl, _PAGE_RAM);
+	done = (unsigned long)bat_addrs[2].limit - PAGE_OFFSET + 1;
 	if ((done < tot) && !bat_addrs[3].limit) {
 		/* use BAT3 to cover a bit more */
 		tot -= done;
 		for (bl = 128<<10; bl < max_size; bl <<= 1)
 			if (bl * 2 > tot)
 				break;
-		setbat(3, KERNELBASE+done, PPC_MEMSTART+done, bl, _PAGE_RAM);
-		done = (unsigned long)bat_addrs[3].limit - KERNELBASE + 1;
+		setbat(3, PAGE_OFFSET+done, PPC_MEMSTART+done, bl, _PAGE_RAM);
+		done = (unsigned long)bat_addrs[3].limit - PAGE_OFFSET + 1;
 	}
 
 	return done;
diff --git a/include/asm-powerpc/ppc_asm.h b/include/asm-powerpc/ppc_asm.h
index 2dbd4e7..f8943ec 100644
--- a/include/asm-powerpc/ppc_asm.h
+++ b/include/asm-powerpc/ppc_asm.h
@@ -382,14 +382,14 @@ END_FTR_SECTION_IFCLR(CPU_FTR_601)
 #define fromreal(rd)	tovirt(rd,rd)
 
 #define tophys(rd,rs)				\
-0:	addis	rd,rs,-KERNELBASE@h;		\
+0:	addis	rd,rs,-PAGE_OFFSET@h;		\
 	.section ".vtop_fixup","aw";		\
 	.align  1;				\
 	.long   0b;				\
 	.previous
 
 #define tovirt(rd,rs)				\
-0:	addis	rd,rs,KERNELBASE@h;		\
+0:	addis	rd,rs,PAGE_OFFSET@h;		\
 	.section ".ptov_fixup","aw";		\
 	.align  1;				\
 	.long   0b;				\
-- 
1.5.3.4
