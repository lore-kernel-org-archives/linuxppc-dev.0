Return-Path: <tpiepho@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 469B0DDEE8
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Dec 2008 14:35:05 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	mB93Z1bU012045
	for <linuxppc-dev@ozlabs.org>; Mon, 8 Dec 2008 20:35:02 -0700 (MST)
From: Trent Piepho <tpiepho@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/5] powerpc: booke: Remove code duplication in lowmem mapping
Date: Mon,  8 Dec 2008 19:34:57 -0800
Message-Id: <1228793699-23110-3-git-send-email-tpiepho@freescale.com>
In-Reply-To: <1228793699-23110-1-git-send-email-tpiepho@freescale.com>
References: <1228793699-23110-1-git-send-email-tpiepho@freescale.com>
Cc: Trent Piepho <tpiepho@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The code to map lowmem uses three CAM aka TLB[1] entries to cover it.  The
size of each is stored in three globals named __cam0, __cam1, and __cam2.
All the code that uses them is duplicated three times for each of the three
variables.

We have these things called arrays and loops....

Once converted to use an array, it will be easier to make the number of
CAMs configurable.

Signed-off-by: Trent Piepho <tpiepho@freescale.com>
---
 arch/powerpc/mm/fsl_booke_mmu.c |   79 +++++++++++++++-----------------------
 1 files changed, 31 insertions(+), 48 deletions(-)

diff --git a/arch/powerpc/mm/fsl_booke_mmu.c b/arch/powerpc/mm/fsl_booke_mmu.c
index 1971e4e..1dabe1a 100644
--- a/arch/powerpc/mm/fsl_booke_mmu.c
+++ b/arch/powerpc/mm/fsl_booke_mmu.c
@@ -56,7 +56,7 @@
 
 extern void loadcam_entry(unsigned int index);
 unsigned int tlbcam_index;
-static unsigned long __cam0, __cam1, __cam2;
+static unsigned long cam[3];
 
 #define NUM_TLBCAMS	(16)
 
@@ -152,19 +152,19 @@ void invalidate_tlbcam_entry(int index)
 	loadcam_entry(index);
 }
 
-void __init cam_mapin_ram(unsigned long cam0, unsigned long cam1,
-		unsigned long cam2)
+unsigned long __init mmu_mapin_ram(void)
 {
-	settlbcam(0, PAGE_OFFSET, memstart_addr, cam0, _PAGE_KERNEL, 0);
-	tlbcam_index++;
-	if (cam1) {
-		tlbcam_index++;
-		settlbcam(1, PAGE_OFFSET+cam0, memstart_addr+cam0, cam1, _PAGE_KERNEL, 0);
-	}
-	if (cam2) {
+	unsigned long virt = PAGE_OFFSET;
+	phys_addr_t phys = memstart_addr;
+
+	while (cam[tlbcam_index] && tlbcam_index < ARRAY_SIZE(cam)) {
+		settlbcam(tlbcam_index, virt, phys, cam[tlbcam_index], _PAGE_KERNEL, 0);
+		virt += cam[tlbcam_index];
+		phys += cam[tlbcam_index];
 		tlbcam_index++;
-		settlbcam(2, PAGE_OFFSET+cam0+cam1, memstart_addr+cam0+cam1, cam2, _PAGE_KERNEL, 0);
 	}
+
+	return virt - PAGE_OFFSET;
 }
 
 /*
@@ -175,51 +175,34 @@ void __init MMU_init_hw(void)
 	flush_instruction_cache();
 }
 
-unsigned long __init mmu_mapin_ram(void)
-{
-	cam_mapin_ram(__cam0, __cam1, __cam2);
-
-	return __cam0 + __cam1 + __cam2;
-}
-
-
 void __init
 adjust_total_lowmem(void)
 {
-	phys_addr_t max_lowmem_size = __max_low_memory;
-	phys_addr_t cam_max_size = 0x10000000;
 	phys_addr_t ram;
+	unsigned int max_cam = 28;	/* 2^28 = 256 Mb */
+	char buf[ARRAY_SIZE(cam) * 5 + 1], *p = buf;
+	int i;
 
-	/* adjust CAM size to max_lowmem_size */
-	if (max_lowmem_size < cam_max_size)
-		cam_max_size = max_lowmem_size;
-
-	/* adjust lowmem size to max_lowmem_size */
-	ram = min(max_lowmem_size, total_lowmem);
+	/* adjust lowmem size to __max_low_memory */
+	ram = min((phys_addr_t)__max_low_memory, (phys_addr_t)total_lowmem);
 
 	/* Calculate CAM values */
-	__cam0 = 1UL << 2 * (__ilog2(ram) / 2);
-	if (__cam0 > cam_max_size)
-		__cam0 = cam_max_size;
-	ram -= __cam0;
-	if (ram) {
-		__cam1 = 1UL << 2 * (__ilog2(ram) / 2);
-		if (__cam1 > cam_max_size)
-			__cam1 = cam_max_size;
-		ram -= __cam1;
-	}
-	if (ram) {
-		__cam2 = 1UL << 2 * (__ilog2(ram) / 2);
-		if (__cam2 > cam_max_size)
-			__cam2 = cam_max_size;
-		ram -= __cam2;
+	__max_low_memory = 0;
+	for (i = 0; ram && i < ARRAY_SIZE(cam); i++) {
+		unsigned int camsize = __ilog2(ram) & ~1U;
+		if (camsize > max_cam)
+			camsize = max_cam;
+		cam[i] = 1UL << camsize;
+		ram -= cam[i];
+		__max_low_memory += cam[i];
+
+		p += sprintf(p, "%lu/", cam[i] >> 20);
 	}
+	for (; i < ARRAY_SIZE(cam); i++)
+		p += sprintf(p, "0/");
+	p[-1] = '\0';
 
-	printk(KERN_INFO "Memory CAM mapping: CAM0=%ldMb, CAM1=%ldMb,"
-			" CAM2=%ldMb residual: %ldMb\n",
-			__cam0 >> 20, __cam1 >> 20, __cam2 >> 20,
-			(long int)((total_lowmem - __cam0 - __cam1 - __cam2)
-				   >> 20));
-	__max_low_memory = __cam0 + __cam1 + __cam2;
+	pr_info("Memory CAM mapping: %s Mb, residual: %ldMb\n", buf,
+	        (total_lowmem - __max_low_memory) >> 20);
 	__initial_memory_limit_addr = memstart_addr + __max_low_memory;
 }
-- 
1.5.4.1
