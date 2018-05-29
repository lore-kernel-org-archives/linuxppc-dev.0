Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40w8kJ1TsTzDqGD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 May 2018 20:15:36 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: malat@debian.org
Subject: [PATCH] powerpc/prom: Fix %llx usage since prom_printf() change
Date: Tue, 29 May 2018 20:15:29 +1000
Message-Id: <20180529101529.2583-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We recently added the __printf attribute to prom_printf(), which means
GCC started warning about type/format mismatches. As part of that
commit we changed some "%lx" formats to "%llx" where the type is
actually unsigned long long.

Unfortunately prom_printf() doesn't know how to print "%llx", it just
prints a literal "lx", eg:

  reserved memory map:
    lx - lx
    lx - lx

We should fix that at some point, but for now just cast the relevant
values to unsigned long to get things printing again. On 64-bit that
has no effect on the output, because both types are 64-bit wide. On
32-bit it means we're potentially not printing the high 32-bits of
some values, but most of them are pointers anyway, and we've lived
with that behaviour up until now.

Fixes: eae5f709a4d7 ("powerpc: Add __printf verification to prom_printf")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/prom_init.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 425992e393bc..662dd68c3fb8 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -1580,7 +1580,7 @@ static void __init prom_instantiate_opal(void)
 		return;
 	}
 
-	prom_printf("instantiating opal at 0x%llx...", base);
+	prom_printf("instantiating opal at 0x%lx...", (unsigned long)base);
 
 	if (call_prom_ret("call-method", 4, 3, rets,
 			  ADDR("load-opal-runtime"),
@@ -1596,10 +1596,10 @@ static void __init prom_instantiate_opal(void)
 
 	reserve_mem(base, size);
 
-	prom_debug("opal base     = 0x%llx\n", base);
-	prom_debug("opal align    = 0x%llx\n", align);
-	prom_debug("opal entry    = 0x%llx\n", entry);
-	prom_debug("opal size     = 0x%llx\n", size);
+	prom_debug("opal base     = 0x%lx\n", (unsigned long)base);
+	prom_debug("opal align    = 0x%lx\n", (unsigned long)align);
+	prom_debug("opal entry    = 0x%lx\n", (unsigned long)entry);
+	prom_debug("opal size     = 0x%lx\n", (unsigned long)size);
 
 	prom_setprop(opal_node, "/ibm,opal", "opal-base-address",
 		     &base, sizeof(base));
@@ -1734,7 +1734,7 @@ static void __init prom_instantiate_sml(void)
 	if (base == 0)
 		prom_panic("Could not allocate memory for sml\n");
 
-	prom_printf("instantiating sml at 0x%llx...", base);
+	prom_printf("instantiating sml at 0x%lx...", (unsigned long)base);
 
 	memset((void *)base, 0, size);
 
@@ -1753,7 +1753,7 @@ static void __init prom_instantiate_sml(void)
 	prom_setprop(ibmvtpm_node, "/vdevice/vtpm", "linux,sml-size",
 		     &size, sizeof(size));
 
-	prom_debug("sml base     = 0x%llx\n", base);
+	prom_debug("sml base     = 0x%lx\n", (unsigned long)base);
 	prom_debug("sml size     = 0x%x\n", size);
 
 	prom_debug("prom_instantiate_sml: end...\n");
@@ -1847,7 +1847,7 @@ static void __init prom_initialize_tce_table(void)
 
 		prom_debug("TCE table: %s\n", path);
 		prom_debug("\tnode = 0x%x\n", node);
-		prom_debug("\tbase = 0x%llx\n", base);
+		prom_debug("\tbase = 0x%lx\n", (unsigned long)base);
 		prom_debug("\tsize = 0x%x\n", minsize);
 
 		/* Initialize the table to have a one-to-one mapping
@@ -2559,9 +2559,9 @@ static void __init flatten_device_tree(void)
 		int i;
 		prom_printf("reserved memory map:\n");
 		for (i = 0; i < mem_reserve_cnt; i++)
-			prom_printf("  %llx - %llx\n",
-				    be64_to_cpu(mem_reserve_map[i].base),
-				    be64_to_cpu(mem_reserve_map[i].size));
+			prom_printf("  %lx - %lx\n",
+				    (unsigned long)be64_to_cpu(mem_reserve_map[i].base),
+				    (unsigned long)be64_to_cpu(mem_reserve_map[i].size));
 	}
 #endif
 	/* Bump mem_reserve_cnt to cause further reservations to fail
-- 
2.14.1
