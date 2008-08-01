Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id BF9F7DE48F
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Aug 2008 00:14:22 +1000 (EST)
Date: Fri, 1 Aug 2008 18:14:20 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 4/8] powerpc: add the ability for a classic ppc kernel to
	be loaded at 32M
Message-ID: <20080801141420.GD1161@polina.dev.rtsoft.ru>
References: <20080801141306.GA29127@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <20080801141306.GA29127@polina.dev.rtsoft.ru>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Dale Farnsworth <dale@farnsworth.org>

Add the ability for a classic ppc kernel to be loaded at an address
of 32MB.  This done by fixing a few places that assume we are loaded
at address 0, and by changing several uses of KERNELBASE to use
PAGE_OFFSET, instead.

Signed-off-by: Dale Farnsworth <dale@farnsworth.org>
Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/kernel/head_32.S |   11 ++++++-----
 arch/powerpc/mm/init_32.c     |    2 +-
 arch/powerpc/mm/pgtable_32.c  |    4 ++--
 arch/powerpc/mm/ppc_mmu_32.c  |    8 ++++----
 include/asm-powerpc/ppc_asm.h |    4 ++--
 5 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index 99ee2f0..45e612b 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -176,7 +176,8 @@ __after_mmu_off:
 	bl	reloc_offset
 	mr	r26,r3
 	addis	r4,r3,KERNELBASE@h	/* current address of _start */
-	cmpwi	0,r4,0			/* are we already running at 0? */
+	lis	r5,PHYSICAL_START@h
+	cmplw	0,r4,r5			/* already running at PHYSICAL_START? */
 	bne	relocate_kernel
 /*
  * we now have the 1st 16M of ram mapped with the bats.
@@ -804,13 +805,13 @@ giveup_altivec:
 
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
@@ -1172,11 +1173,11 @@ mmu_off:
 
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
diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
index 388ceda..4ac0e4e 100644
--- a/arch/powerpc/mm/init_32.c
+++ b/arch/powerpc/mm/init_32.c
@@ -49,7 +49,7 @@
 
 #if defined(CONFIG_KERNEL_START_BOOL) || defined(CONFIG_LOWMEM_SIZE_BOOL)
 /* The ammount of lowmem must be within 0xF0000000 - KERNELBASE. */
-#if (CONFIG_LOWMEM_SIZE > (0xF0000000 - KERNELBASE))
+#if (CONFIG_LOWMEM_SIZE > (0xF0000000 - PAGE_OFFSET))
 #error "You must adjust CONFIG_LOWMEM_SIZE or CONFIG_START_KERNEL"
 #endif
 #endif
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index 2001abd..ea50968 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -288,7 +288,7 @@ int map_page(unsigned long va, phys_addr_t pa, int flags)
 }
 
 /*
- * Map in all of physical memory starting at KERNELBASE.
+ * Map in all of physical memory starting at PAGE_OFFSET.
  */
 void __init mapin_ram(void)
 {
@@ -297,7 +297,7 @@ void __init mapin_ram(void)
 	int ktext;
 
 	s = mmu_mapin_ram();
-	v = KERNELBASE + s;
+	v = PAGE_OFFSET + s;
 	p = memstart_addr + s;
 	for (; s < total_lowmem; s += PAGE_SIZE) {
 		ktext = ((char *) v >= _stext && (char *) v < etext);
diff --git a/arch/powerpc/mm/ppc_mmu_32.c b/arch/powerpc/mm/ppc_mmu_32.c
index c53145f..7c86103 100644
--- a/arch/powerpc/mm/ppc_mmu_32.c
+++ b/arch/powerpc/mm/ppc_mmu_32.c
@@ -95,16 +95,16 @@ unsigned long __init mmu_mapin_ram(void)
 			break;
 	}
 
-	setbat(2, KERNELBASE, 0, bl, _PAGE_RAM);
-	done = (unsigned long)bat_addrs[2].limit - KERNELBASE + 1;
+	setbat(2, PAGE_OFFSET, 0, bl, _PAGE_RAM);
+	done = (unsigned long)bat_addrs[2].limit - PAGE_OFFSET + 1;
 	if ((done < tot) && !bat_addrs[3].limit) {
 		/* use BAT3 to cover a bit more */
 		tot -= done;
 		for (bl = 128<<10; bl < max_size; bl <<= 1)
 			if (bl * 2 > tot)
 				break;
-		setbat(3, KERNELBASE+done, done, bl, _PAGE_RAM);
-		done = (unsigned long)bat_addrs[3].limit - KERNELBASE + 1;
+		setbat(3, PAGE_OFFSET+done, done, bl, _PAGE_RAM);
+		done = (unsigned long)bat_addrs[3].limit - PAGE_OFFSET + 1;
 	}
 
 	return done;
diff --git a/include/asm-powerpc/ppc_asm.h b/include/asm-powerpc/ppc_asm.h
index 0966899..d0c7f33 100644
--- a/include/asm-powerpc/ppc_asm.h
+++ b/include/asm-powerpc/ppc_asm.h
@@ -425,14 +425,14 @@ END_FTR_SECTION_IFCLR(CPU_FTR_601)
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
1.5.5.4
