Return-Path: <ard.biesheuvel@linaro.org>
Received: from mail-wg0-f48.google.com (mail-wg0-f48.google.com [74.125.82.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9952B1A0A0E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2015 03:00:33 +1100 (AEDT)
Received: by wggx13 with SMTP id x13so10302254wgg.4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2015 09:00:30 -0700 (PDT)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org, robh@kernel.org,
 mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
 linux@arm.linux.org.uk, linuxppc-dev@lists.ozlabs.org,
 devicetree@vger.kernel.org
Subject: [PATCH v2 1/5] of/fdt: split off FDT self reservation from memreserve
 processing
Date: Wed, 11 Mar 2015 17:00:16 +0100
Message-Id: <1426089620-9459-2-git-send-email-ard.biesheuvel@linaro.org>
In-Reply-To: <1426089620-9459-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1426089620-9459-1-git-send-email-ard.biesheuvel@linaro.org>
Cc: Paul Mackerras <paulus@samba.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This splits off the reservation of the memory occupied by the FDT
binary itself from the processing of the memory reservations it
contains. This is necessary because the physical address of the FDT,
which is needed to perform the reservation, may not be known to the
FDT driver core, i.e., it may be mapped outside the linear direct
mapping, in which case __pa() returns a bogus value.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/mm/init.c         |  1 +
 arch/arm64/mm/init.c       |  1 +
 arch/powerpc/kernel/prom.c |  1 +
 drivers/of/fdt.c           | 19 ++++++++++++++-----
 include/linux/of_fdt.h     |  2 ++
 5 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 1609b022a72f..0b8657c36fe4 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -317,6 +317,7 @@ void __init arm_memblock_init(const struct machine_desc *mdesc)
 	if (mdesc->reserve)
 		mdesc->reserve();
 
+	early_init_fdt_reserve_self();
 	early_init_fdt_scan_reserved_mem();
 
 	/* reserve memory for DMA contiguous allocations */
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index ae85da6307bb..fa2389b0f7f0 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -170,6 +170,7 @@ void __init arm64_memblock_init(void)
 		memblock_reserve(__virt_to_phys(initrd_start), initrd_end - initrd_start);
 #endif
 
+	early_init_fdt_reserve_self();
 	early_init_fdt_scan_reserved_mem();
 
 	/* 4GB maximum for 32-bit only capable devices */
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index b8e15c678960..093ccfb384af 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -573,6 +573,7 @@ static void __init early_reserve_mem_dt(void)
 	int len;
 	const __be32 *prop;
 
+	early_init_fdt_reserve_self();
 	early_init_fdt_scan_reserved_mem();
 
 	dt_root = of_get_flat_dt_root();
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 3a896c9aeb74..bbb35cdb06e8 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -561,11 +561,6 @@ void __init early_init_fdt_scan_reserved_mem(void)
 	if (!initial_boot_params)
 		return;
 
-	/* Reserve the dtb region */
-	early_init_dt_reserve_memory_arch(__pa(initial_boot_params),
-					  fdt_totalsize(initial_boot_params),
-					  0);
-
 	/* Process header /memreserve/ fields */
 	for (n = 0; ; n++) {
 		fdt_get_mem_rsv(initial_boot_params, n, &base, &size);
@@ -579,6 +574,20 @@ void __init early_init_fdt_scan_reserved_mem(void)
 }
 
 /**
+ * early_init_fdt_reserve_self() - reserve the memory used by the FDT blob
+ */
+void __init early_init_fdt_reserve_self(void)
+{
+	if (!initial_boot_params)
+		return;
+
+	/* Reserve the dtb region */
+	early_init_dt_reserve_memory_arch(__pa(initial_boot_params),
+					  fdt_totalsize(initial_boot_params),
+					  0);
+}
+
+/**
  * of_scan_flat_dt - scan flattened tree blob and call callback on each.
  * @it: callback function
  * @data: context data pointer
diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
index 0ff360d5b3b3..6ef6b33238d3 100644
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -62,6 +62,7 @@ extern int early_init_dt_scan_chosen(unsigned long node, const char *uname,
 extern int early_init_dt_scan_memory(unsigned long node, const char *uname,
 				     int depth, void *data);
 extern void early_init_fdt_scan_reserved_mem(void);
+extern void early_init_fdt_reserve_self(void);
 extern void early_init_dt_add_memory_arch(u64 base, u64 size);
 extern int early_init_dt_reserve_memory_arch(phys_addr_t base, phys_addr_t size,
 					     bool no_map);
@@ -89,6 +90,7 @@ extern u64 fdt_translate_address(const void *blob, int node_offset);
 extern void of_fdt_limit_memory(int limit);
 #else /* CONFIG_OF_FLATTREE */
 static inline void early_init_fdt_scan_reserved_mem(void) {}
+static inline void early_init_fdt_reserve_self(void) {}
 static inline const char *of_flat_dt_get_machine_name(void) { return NULL; }
 static inline void unflatten_device_tree(void) {}
 static inline void unflatten_and_copy_device_tree(void) {}
-- 
1.8.3.2
