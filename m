Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 384671A01F2
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Aug 2014 19:08:26 +1000 (EST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 2/2] powerpc/ppc64: Print CPU/MMU/FW features at boot
Date: Wed,  6 Aug 2014 19:08:22 +1000
Message-Id: <1407316102-22917-2-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1407316102-22917-1-git-send-email-mpe@ellerman.id.au>
References: <1407316102-22917-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Helps debug funky firmware issues".

After:
  Starting Linux PPC64 #108 SMP Wed Aug 6 19:04:51 EST 2014
  -----------------------------------------------------
  ppc64_pft_size    = 0x1a
  phys_mem_size     = 0x200000000
  cpu_features      = 0x17fc7a6c18500249
    possible        = 0x1fffffff18700649
    always          = 0x0000000000000040
  cpu_user_features = 0xdc0065c2 0xee000000
  mmu_features      = 0x5a000001
  firmware_features = 0x00000001405a440b
  htab_hash_mask    = 0x7ffff
  -----------------------------------------------------

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
v2: Add CPU_FTRS_ALWAYS & CPU_FTRS_POSSIBLE.
---
 arch/powerpc/kernel/setup_64.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index b364f7bd0a94..dce860181b5c 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -525,6 +525,14 @@ void __init setup_system(void)
 	if (ppc64_caches.iline_size != 0x80)
 		printk("icache_line_size  = 0x%x\n", ppc64_caches.iline_size);
 
+	printk("cpu_features      = 0x%016lx\n", cur_cpu_spec->cpu_features);
+	printk("  possible        = 0x%016lx\n", CPU_FTRS_POSSIBLE);
+	printk("  always          = 0x%016lx\n", CPU_FTRS_ALWAYS);
+	printk("cpu_user_features = 0x%08x 0x%08x\n", cur_cpu_spec->cpu_user_features,
+		cur_cpu_spec->cpu_user_features2);
+	printk("mmu_features      = 0x%08x\n", cur_cpu_spec->mmu_features);
+	printk("firmware_features = 0x%016lx\n", powerpc_firmware_features);
+
 #ifdef CONFIG_PPC_STD_MMU_64
 	if (htab_address)
 		printk("htab_address      = 0x%p\n", htab_address);
-- 
1.9.1
