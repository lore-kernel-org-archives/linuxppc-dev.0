Return-Path: <haokexin@gmail.com>
Received: from mail-pd0-x233.google.com (mail-pd0-x233.google.com
 [IPv6:2607:f8b0:400e:c02::233])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 962872C02B0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Dec 2013 18:13:43 +1100 (EST)
Received: by mail-pd0-f179.google.com with SMTP id r10so6051980pdi.10
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Dec 2013 23:13:40 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: [PATCH v4 07/10] powerpc/fsl_booke: introduce map_mem_in_cams_addr
Date: Tue, 24 Dec 2013 15:12:09 +0800
Message-Id: <1387869132-12650-8-git-send-email-haokexin@gmail.com>
In-Reply-To: <1387869132-12650-1-git-send-email-haokexin@gmail.com>
References: <1387869132-12650-1-git-send-email-haokexin@gmail.com>
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Introduce this function so we can set both the physical and virtual
address for the map in cams. This will be used by the relocation code.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
v4: A new patch in v4.

 arch/powerpc/mm/fsl_booke_mmu.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/fsl_booke_mmu.c b/arch/powerpc/mm/fsl_booke_mmu.c
index 1d54f6d35e71..ca956c83e3a2 100644
--- a/arch/powerpc/mm/fsl_booke_mmu.c
+++ b/arch/powerpc/mm/fsl_booke_mmu.c
@@ -171,11 +171,10 @@ unsigned long calc_cam_sz(unsigned long ram, unsigned long virt,
 	return 1UL << camsize;
 }
 
-unsigned long map_mem_in_cams(unsigned long ram, int max_cam_idx)
+static unsigned long map_mem_in_cams_addr(phys_addr_t phys, unsigned long virt,
+					unsigned long ram, int max_cam_idx)
 {
 	int i;
-	unsigned long virt = PAGE_OFFSET;
-	phys_addr_t phys = memstart_addr;
 	unsigned long amount_mapped = 0;
 
 	/* Calculate CAM values */
@@ -195,6 +194,14 @@ unsigned long map_mem_in_cams(unsigned long ram, int max_cam_idx)
 	return amount_mapped;
 }
 
+unsigned long map_mem_in_cams(unsigned long ram, int max_cam_idx)
+{
+	unsigned long virt = PAGE_OFFSET;
+	phys_addr_t phys = memstart_addr;
+
+	return map_mem_in_cams_addr(phys, virt, ram, max_cam_idx);
+}
+
 #ifdef CONFIG_PPC32
 
 #if defined(CONFIG_LOWMEM_CAM_NUM_BOOL) && (CONFIG_LOWMEM_CAM_NUM >= NUM_TLBCAMS)
-- 
1.8.3.1
