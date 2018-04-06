Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wr0-x242.google.com (mail-wr0-x242.google.com
 [IPv6:2a00:1450:400c:c0c::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40HrTX2YZKzF1xq
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Apr 2018 06:12:31 +1000 (AEST)
Received: by mail-wr0-x242.google.com with SMTP id l49so2803698wrl.4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Apr 2018 13:12:31 -0700 (PDT)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: add __printf verification to prom_printf
Date: Fri,  6 Apr 2018 22:12:19 +0200
Message-Id: <20180406201220.31957-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

__printf is useful to verify format and arguments. Fix arg mismatch
reported by gcc, remove the following warnings (with W=1):

  arch/powerpc/kernel/prom_init.c:1467:31: error: format ‘%x’ expects argument of type ‘unsigned int’, but argument 2 has type ‘long unsigned int’ [-Werror=format=]
  arch/powerpc/kernel/prom_init.c:1471:31: error: format ‘%x’ expects argument of type ‘unsigned int’, but argument 2 has type ‘long unsigned int’ [-Werror=format=]
  arch/powerpc/kernel/prom_init.c:1504:33: error: format ‘%x’ expects argument of type ‘unsigned int’, but argument 2 has type ‘long unsigned int’ [-Werror=format=]
  arch/powerpc/kernel/prom_init.c:1505:33: error: format ‘%x’ expects argument of type ‘unsigned int’, but argument 2 has type ‘long unsigned int’ [-Werror=format=]
  arch/powerpc/kernel/prom_init.c:1506:33: error: format ‘%x’ expects argument of type ‘unsigned int’, but argument 2 has type ‘long unsigned int’ [-Werror=format=]
  arch/powerpc/kernel/prom_init.c:1507:33: error: format ‘%x’ expects argument of type ‘unsigned int’, but argument 2 has type ‘long unsigned int’ [-Werror=format=]
  arch/powerpc/kernel/prom_init.c:1508:33: error: format ‘%x’ expects argument of type ‘unsigned int’, but argument 2 has type ‘long unsigned int’ [-Werror=format=]
  arch/powerpc/kernel/prom_init.c:1509:33: error: format ‘%x’ expects argument of type ‘unsigned int’, but argument 2 has type ‘long unsigned int’ [-Werror=format=]
  arch/powerpc/kernel/prom_init.c:1975:39: error: format ‘%lu’ expects argument of type ‘long unsigned int’, but argument 2 has type ‘unsigned int’ [-Werror=format=]
  arch/powerpc/kernel/prom_init.c:1986:27: error: format ‘%x’ expects argument of type ‘unsigned int’, but argument 2 has type ‘long unsigned int’ [-Werror=format=]
  arch/powerpc/kernel/prom_init.c:2567:38: error: format ‘%x’ expects argument of type ‘unsigned int’, but argument 2 has type ‘long unsigned int’ [-Werror=format=]
  arch/powerpc/kernel/prom_init.c:2567:46: error: format ‘%x’ expects argument of type ‘unsigned int’, but argument 3 has type ‘long unsigned int’ [-Werror=format=]
  arch/powerpc/kernel/prom_init.c:2569:38: error: format ‘%x’ expects argument of type ‘unsigned int’, but argument 2 has type ‘long unsigned int’ [-Werror=format=]
  arch/powerpc/kernel/prom_init.c:2569:46: error: format ‘%x’ expects argument of type ‘unsigned int’, but argument 3 has type ‘long unsigned int’ [-Werror=format=]

The patch also include arg mismatch fix for case with #define DEBUG_PROM
(warning not listed here).

This patch fix also the following warnings revealed by checkpatch:

  WARNING: Prefer using '"%s...", __func__' to using 'alloc_up', this function's name, in a string
  #101: FILE: arch/powerpc/kernel/prom_init.c:1235:
  + prom_debug("alloc_up(%lx, %lx)\n", size, align);

and

  WARNING: Prefer using '"%s...", __func__' to using 'alloc_down', this function's name, in a string
  #138: FILE: arch/powerpc/kernel/prom_init.c:1278:
  + prom_debug("alloc_down(%lx, %lx, %s)\n", size, align,

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/kernel/prom_init.c | 114 ++++++++++++++++++++--------------------
 1 file changed, 58 insertions(+), 56 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 051f6e7e3a3d..7925f64fefde 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -334,6 +334,7 @@ static void __init prom_print_dec(unsigned long val)
 	call_prom("write", 3, 1, prom.stdout, buf+i, size);
 }
 
+__printf(1, 2)
 static void __init prom_printf(const char *format, ...)
 {
 	const char *p, *q, *s;
@@ -1149,7 +1150,7 @@ static void __init prom_send_capabilities(void)
 		 */
 
 		cores = DIV_ROUND_UP(NR_CPUS, prom_count_smt_threads());
-		prom_printf("Max number of cores passed to firmware: %lu (NR_CPUS = %lu)\n",
+		prom_printf("Max number of cores passed to firmware: %u (NR_CPUS = %d)\n",
 			    cores, NR_CPUS);
 
 		ibm_architecture_vec.vec5.max_cpus = cpu_to_be32(cores);
@@ -1231,7 +1232,7 @@ static unsigned long __init alloc_up(unsigned long size, unsigned long align)
 
 	if (align)
 		base = _ALIGN_UP(base, align);
-	prom_debug("alloc_up(%x, %x)\n", size, align);
+	prom_debug("%s(%lx, %lx)\n", __func__, size, align);
 	if (ram_top == 0)
 		prom_panic("alloc_up() called with mem not initialized\n");
 
@@ -1242,7 +1243,7 @@ static unsigned long __init alloc_up(unsigned long size, unsigned long align)
 
 	for(; (base + size) <= alloc_top; 
 	    base = _ALIGN_UP(base + 0x100000, align)) {
-		prom_debug("    trying: 0x%x\n\r", base);
+		prom_debug("    trying: 0x%lx\n\r", base);
 		addr = (unsigned long)prom_claim(base, size, 0);
 		if (addr != PROM_ERROR && addr != 0)
 			break;
@@ -1254,12 +1255,12 @@ static unsigned long __init alloc_up(unsigned long size, unsigned long align)
 		return 0;
 	alloc_bottom = addr + size;
 
-	prom_debug(" -> %x\n", addr);
-	prom_debug("  alloc_bottom : %x\n", alloc_bottom);
-	prom_debug("  alloc_top    : %x\n", alloc_top);
-	prom_debug("  alloc_top_hi : %x\n", alloc_top_high);
-	prom_debug("  rmo_top      : %x\n", rmo_top);
-	prom_debug("  ram_top      : %x\n", ram_top);
+	prom_debug(" -> %lx\n", addr);
+	prom_debug("  alloc_bottom : %lx\n", alloc_bottom);
+	prom_debug("  alloc_top    : %lx\n", alloc_top);
+	prom_debug("  alloc_top_hi : %lx\n", alloc_top_high);
+	prom_debug("  rmo_top      : %lx\n", rmo_top);
+	prom_debug("  ram_top      : %lx\n", ram_top);
 
 	return addr;
 }
@@ -1274,7 +1275,7 @@ static unsigned long __init alloc_down(unsigned long size, unsigned long align,
 {
 	unsigned long base, addr = 0;
 
-	prom_debug("alloc_down(%x, %x, %s)\n", size, align,
+	prom_debug("%s(%lx, %lx, %s)\n", __func__, size, align,
 		   highmem ? "(high)" : "(low)");
 	if (ram_top == 0)
 		prom_panic("alloc_down() called with mem not initialized\n");
@@ -1302,7 +1303,7 @@ static unsigned long __init alloc_down(unsigned long size, unsigned long align,
 	base = _ALIGN_DOWN(alloc_top - size, align);
 	for (; base > alloc_bottom;
 	     base = _ALIGN_DOWN(base - 0x100000, align))  {
-		prom_debug("    trying: 0x%x\n\r", base);
+		prom_debug("    trying: 0x%lx\n\r", base);
 		addr = (unsigned long)prom_claim(base, size, 0);
 		if (addr != PROM_ERROR && addr != 0)
 			break;
@@ -1313,12 +1314,12 @@ static unsigned long __init alloc_down(unsigned long size, unsigned long align,
 	alloc_top = addr;
 
  bail:
-	prom_debug(" -> %x\n", addr);
-	prom_debug("  alloc_bottom : %x\n", alloc_bottom);
-	prom_debug("  alloc_top    : %x\n", alloc_top);
-	prom_debug("  alloc_top_hi : %x\n", alloc_top_high);
-	prom_debug("  rmo_top      : %x\n", rmo_top);
-	prom_debug("  ram_top      : %x\n", ram_top);
+	prom_debug(" -> %lx\n", addr);
+	prom_debug("  alloc_bottom : %lx\n", alloc_bottom);
+	prom_debug("  alloc_top    : %lx\n", alloc_top);
+	prom_debug("  alloc_top_hi : %lx\n", alloc_top_high);
+	prom_debug("  rmo_top      : %lx\n", rmo_top);
+	prom_debug("  ram_top      : %lx\n", ram_top);
 
 	return addr;
 }
@@ -1443,7 +1444,7 @@ static void __init prom_init_mem(void)
 
 			if (size == 0)
 				continue;
-			prom_debug("    %x %x\n", base, size);
+			prom_debug("    %lx %lx\n", base, size);
 			if (base == 0 && (of_platform & PLATFORM_LPAR))
 				rmo_top = size;
 			if ((base + size) > ram_top)
@@ -1463,12 +1464,12 @@ static void __init prom_init_mem(void)
 
 	if (prom_memory_limit) {
 		if (prom_memory_limit <= alloc_bottom) {
-			prom_printf("Ignoring mem=%x <= alloc_bottom.\n",
-				prom_memory_limit);
+			prom_printf("Ignoring mem=%lx <= alloc_bottom.\n",
+				    prom_memory_limit);
 			prom_memory_limit = 0;
 		} else if (prom_memory_limit >= ram_top) {
-			prom_printf("Ignoring mem=%x >= ram_top.\n",
-				prom_memory_limit);
+			prom_printf("Ignoring mem=%lx >= ram_top.\n",
+				    prom_memory_limit);
 			prom_memory_limit = 0;
 		} else {
 			ram_top = prom_memory_limit;
@@ -1500,12 +1501,13 @@ static void __init prom_init_mem(void)
 		alloc_bottom = PAGE_ALIGN(prom_initrd_end);
 
 	prom_printf("memory layout at init:\n");
-	prom_printf("  memory_limit : %x (16 MB aligned)\n", prom_memory_limit);
-	prom_printf("  alloc_bottom : %x\n", alloc_bottom);
-	prom_printf("  alloc_top    : %x\n", alloc_top);
-	prom_printf("  alloc_top_hi : %x\n", alloc_top_high);
-	prom_printf("  rmo_top      : %x\n", rmo_top);
-	prom_printf("  ram_top      : %x\n", ram_top);
+	prom_printf("  memory_limit : %lx (16 MB aligned)\n",
+		    prom_memory_limit);
+	prom_printf("  alloc_bottom : %lx\n", alloc_bottom);
+	prom_printf("  alloc_top    : %lx\n", alloc_top);
+	prom_printf("  alloc_top_hi : %lx\n", alloc_top_high);
+	prom_printf("  rmo_top      : %lx\n", rmo_top);
+	prom_printf("  ram_top      : %lx\n", ram_top);
 }
 
 static void __init prom_close_stdin(void)
@@ -1566,7 +1568,7 @@ static void __init prom_instantiate_opal(void)
 		return;
 	}
 
-	prom_printf("instantiating opal at 0x%x...", base);
+	prom_printf("instantiating opal at 0x%llx...", base);
 
 	if (call_prom_ret("call-method", 4, 3, rets,
 			  ADDR("load-opal-runtime"),
@@ -1582,10 +1584,10 @@ static void __init prom_instantiate_opal(void)
 
 	reserve_mem(base, size);
 
-	prom_debug("opal base     = 0x%x\n", base);
-	prom_debug("opal align    = 0x%x\n", align);
-	prom_debug("opal entry    = 0x%x\n", entry);
-	prom_debug("opal size     = 0x%x\n", (long)size);
+	prom_debug("opal base     = 0x%llx\n", base);
+	prom_debug("opal align    = 0x%llx\n", align);
+	prom_debug("opal entry    = 0x%llx\n", entry);
+	prom_debug("opal size     = 0x%llx\n", size);
 
 	prom_setprop(opal_node, "/ibm,opal", "opal-base-address",
 		     &base, sizeof(base));
@@ -1662,7 +1664,7 @@ static void __init prom_instantiate_rtas(void)
 
 	prom_debug("rtas base     = 0x%x\n", base);
 	prom_debug("rtas entry    = 0x%x\n", entry);
-	prom_debug("rtas size     = 0x%x\n", (long)size);
+	prom_debug("rtas size     = 0x%x\n", size);
 
 	prom_debug("prom_instantiate_rtas: end...\n");
 }
@@ -1720,7 +1722,7 @@ static void __init prom_instantiate_sml(void)
 	if (base == 0)
 		prom_panic("Could not allocate memory for sml\n");
 
-	prom_printf("instantiating sml at 0x%x...", base);
+	prom_printf("instantiating sml at 0x%llx...", base);
 
 	memset((void *)base, 0, size);
 
@@ -1739,8 +1741,8 @@ static void __init prom_instantiate_sml(void)
 	prom_setprop(ibmvtpm_node, "/vdevice/vtpm", "linux,sml-size",
 		     &size, sizeof(size));
 
-	prom_debug("sml base     = 0x%x\n", base);
-	prom_debug("sml size     = 0x%x\n", (long)size);
+	prom_debug("sml base     = 0x%llx\n", base);
+	prom_debug("sml size     = 0x%x\n", size);
 
 	prom_debug("prom_instantiate_sml: end...\n");
 }
@@ -1841,7 +1843,7 @@ static void __init prom_initialize_tce_table(void)
 
 		prom_debug("TCE table: %s\n", path);
 		prom_debug("\tnode = 0x%x\n", node);
-		prom_debug("\tbase = 0x%x\n", base);
+		prom_debug("\tbase = 0x%llx\n", base);
 		prom_debug("\tsize = 0x%x\n", minsize);
 
 		/* Initialize the table to have a one-to-one mapping
@@ -1928,12 +1930,12 @@ static void __init prom_hold_cpus(void)
 	}
 
 	prom_debug("prom_hold_cpus: start...\n");
-	prom_debug("    1) spinloop       = 0x%x\n", (unsigned long)spinloop);
-	prom_debug("    1) *spinloop      = 0x%x\n", *spinloop);
-	prom_debug("    1) acknowledge    = 0x%x\n",
+	prom_debug("    1) spinloop       = 0x%lx\n", (unsigned long)spinloop);
+	prom_debug("    1) *spinloop      = 0x%lx\n", *spinloop);
+	prom_debug("    1) acknowledge    = 0x%lx\n",
 		   (unsigned long)acknowledge);
-	prom_debug("    1) *acknowledge   = 0x%x\n", *acknowledge);
-	prom_debug("    1) secondary_hold = 0x%x\n", secondary_hold);
+	prom_debug("    1) *acknowledge   = 0x%lx\n", *acknowledge);
+	prom_debug("    1) secondary_hold = 0x%lx\n", secondary_hold);
 
 	/* Set the common spinloop variable, so all of the secondary cpus
 	 * will block when they are awakened from their OF spinloop.
@@ -1961,7 +1963,7 @@ static void __init prom_hold_cpus(void)
 		prom_getprop(node, "reg", &reg, sizeof(reg));
 		cpu_no = be32_to_cpu(reg);
 
-		prom_debug("cpu hw idx   = %lu\n", cpu_no);
+		prom_debug("cpu hw idx   = %u\n", cpu_no);
 
 		/* Init the acknowledge var which will be reset by
 		 * the secondary cpu when it awakens from its OF
@@ -1971,7 +1973,7 @@ static void __init prom_hold_cpus(void)
 
 		if (cpu_no != prom.cpu) {
 			/* Primary Thread of non-boot cpu or any thread */
-			prom_printf("starting cpu hw idx %lu... ", cpu_no);
+			prom_printf("starting cpu hw idx %u... ", cpu_no);
 			call_prom("start-cpu", 3, 0, node,
 				  secondary_hold, cpu_no);
 
@@ -1982,11 +1984,11 @@ static void __init prom_hold_cpus(void)
 			if (*acknowledge == cpu_no)
 				prom_printf("done\n");
 			else
-				prom_printf("failed: %x\n", *acknowledge);
+				prom_printf("failed: %lx\n", *acknowledge);
 		}
 #ifdef CONFIG_SMP
 		else
-			prom_printf("boot cpu hw idx %lu\n", cpu_no);
+			prom_printf("boot cpu hw idx %u\n", cpu_no);
 #endif /* CONFIG_SMP */
 	}
 
@@ -2264,7 +2266,7 @@ static void __init *make_room(unsigned long *mem_start, unsigned long *mem_end,
 	while ((*mem_start + needed) > *mem_end) {
 		unsigned long room, chunk;
 
-		prom_debug("Chunk exhausted, claiming more at %x...\n",
+		prom_debug("Chunk exhausted, claiming more at %lx...\n",
 			   alloc_bottom);
 		room = alloc_top - alloc_bottom;
 		if (room > DEVTREE_CHUNK_SIZE)
@@ -2490,7 +2492,7 @@ static void __init flatten_device_tree(void)
 	room = alloc_top - alloc_bottom - 0x4000;
 	if (room > DEVTREE_CHUNK_SIZE)
 		room = DEVTREE_CHUNK_SIZE;
-	prom_debug("starting device tree allocs at %x\n", alloc_bottom);
+	prom_debug("starting device tree allocs at %lx\n", alloc_bottom);
 
 	/* Now try to claim that */
 	mem_start = (unsigned long)alloc_up(room, PAGE_SIZE);
@@ -2553,7 +2555,7 @@ static void __init flatten_device_tree(void)
 		int i;
 		prom_printf("reserved memory map:\n");
 		for (i = 0; i < mem_reserve_cnt; i++)
-			prom_printf("  %x - %x\n",
+			prom_printf("  %llx - %llx\n",
 				    be64_to_cpu(mem_reserve_map[i].base),
 				    be64_to_cpu(mem_reserve_map[i].size));
 	}
@@ -2563,9 +2565,9 @@ static void __init flatten_device_tree(void)
 	 */
 	mem_reserve_cnt = MEM_RESERVE_MAP_SIZE;
 
-	prom_printf("Device tree strings 0x%x -> 0x%x\n",
+	prom_printf("Device tree strings 0x%lx -> 0x%lx\n",
 		    dt_string_start, dt_string_end);
-	prom_printf("Device tree struct  0x%x -> 0x%x\n",
+	prom_printf("Device tree struct  0x%lx -> 0x%lx\n",
 		    dt_struct_start, dt_struct_end);
 }
 
@@ -2997,7 +2999,7 @@ static void __init prom_find_boot_cpu(void)
 	prom_getprop(cpu_pkg, "reg", &rval, sizeof(rval));
 	prom.cpu = be32_to_cpu(rval);
 
-	prom_debug("Booting CPU hw index = %lu\n", prom.cpu);
+	prom_debug("Booting CPU hw index = %d\n", prom.cpu);
 }
 
 static void __init prom_check_initrd(unsigned long r3, unsigned long r4)
@@ -3019,8 +3021,8 @@ static void __init prom_check_initrd(unsigned long r3, unsigned long r4)
 		reserve_mem(prom_initrd_start,
 			    prom_initrd_end - prom_initrd_start);
 
-		prom_debug("initrd_start=0x%x\n", prom_initrd_start);
-		prom_debug("initrd_end=0x%x\n", prom_initrd_end);
+		prom_debug("initrd_start=0x%lx\n", prom_initrd_start);
+		prom_debug("initrd_end=0x%lx\n", prom_initrd_end);
 	}
 #endif /* CONFIG_BLK_DEV_INITRD */
 }
@@ -3273,7 +3275,7 @@ unsigned long __init prom_init(unsigned long r3, unsigned long r4,
 	/* Don't print anything after quiesce under OPAL, it crashes OFW */
 	if (of_platform != PLATFORM_OPAL) {
 		prom_printf("Booting Linux via __start() @ 0x%lx ...\n", kbase);
-		prom_debug("->dt_header_start=0x%x\n", hdr);
+		prom_debug("->dt_header_start=0x%lx\n", hdr);
 	}
 
 #ifdef CONFIG_PPC32
-- 
2.11.0
