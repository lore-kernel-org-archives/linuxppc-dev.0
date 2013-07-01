Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 7CB542C0097
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jul 2013 08:13:59 +1000 (EST)
Message-ID: <1372716832.18612.159.camel@pasglop>
Subject: [PATCH] powerpc: Handle both new style and old style reserve maps
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Tue, 02 Jul 2013 08:13:52 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Jeremy Kerr <jk@ozlabs.org>, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When Jeremy introduced the new device-tree based reserve map, he made
the code in early_reserve_mem_dt() bail out if it found one, thus not
reserving the initrd nor processing the old style map.

I hit problems with variants of kexec that didn't put the initrd in
the new style map either. While these could/will be fixed, I believe
we should be safe here and rather reserve more than not enough.

We could have a firmware passing stuff via the new style map, and
in the middle, a kexec that knows nothing about it and adding other
things to the old style map.

I don't see a big issue with processing both and reserving everything
that needs to be. memblock_reserve() supports overlaps fine these days.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 9c753bc..eb23ac9 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -559,7 +559,7 @@ void __init early_init_dt_setup_initrd_arch(unsigned long start,
 }
 #endif
 
-static bool __init early_reserve_mem_dt(void)
+static void __init early_reserve_mem_dt(void)
 {
 	unsigned long i, len, dt_root;
 	const __be32 *prop;
@@ -569,7 +569,9 @@ static bool __init early_reserve_mem_dt(void)
 	prop = of_get_flat_dt_prop(dt_root, "reserved-ranges", &len);
 
 	if (!prop)
-		return false;
+		return;
+
+	DBG("Found new-style reserved-ranges\n");
 
 	/* Each reserved range is an (address,size) pair, 2 cells each,
 	 * totalling 4 cells per range. */
@@ -579,11 +581,11 @@ static bool __init early_reserve_mem_dt(void)
 		base = of_read_number(prop + (i * 4) + 0, 2);
 		size = of_read_number(prop + (i * 4) + 2, 2);
 
-		if (size)
+		if (size) {
+			DBG("reserving: %llx -> %llx\n", base, size);
 			memblock_reserve(base, size);
+		}
 	}
-
-	return true;
 }
 
 static void __init early_reserve_mem(void)
@@ -601,20 +603,16 @@ static void __init early_reserve_mem(void)
 	self_size = initial_boot_params->totalsize;
 	memblock_reserve(self_base, self_size);
 
-	/*
-	 * Try looking for reserved-regions property in the DT first; if
-	 * it's present, it'll contain all of the necessary reservation
-	 * info
-	 */
-	if (early_reserve_mem_dt())
-		return;
+	/* Look for the new "reserved-regions" property in the DT */
+	early_reserve_mem_dt();
 
 #ifdef CONFIG_BLK_DEV_INITRD
-	/* then reserve the initrd, if any */
-	if (initrd_start && (initrd_end > initrd_start))
+	/* Then reserve the initrd, if any */
+	if (initrd_start && (initrd_end > initrd_start)) {
 		memblock_reserve(_ALIGN_DOWN(__pa(initrd_start), PAGE_SIZE),
 			_ALIGN_UP(initrd_end, PAGE_SIZE) -
 			_ALIGN_DOWN(initrd_start, PAGE_SIZE));
+	}
 #endif /* CONFIG_BLK_DEV_INITRD */
 
 #ifdef CONFIG_PPC32
@@ -626,6 +624,8 @@ static void __init early_reserve_mem(void)
 		u32 base_32, size_32;
 		u32 *reserve_map_32 = (u32 *)reserve_map;
 
+		DBG("Found old 32-bit reserve map\n");
+
 		while (1) {
 			base_32 = *(reserve_map_32++);
 			size_32 = *(reserve_map_32++);
@@ -640,6 +640,9 @@ static void __init early_reserve_mem(void)
 		return;
 	}
 #endif
+	DBG("Processing reserve map\n");
+
+	/* Handle the reserve map in the fdt blob if it exists */
 	while (1) {
 		base = *(reserve_map++);
 		size = *(reserve_map++);
        
