Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 21/63] powerpc: Make prom_init.c endian safe
Date: Wed,  7 Aug 2013 02:01:38 +1000
Message-Id: <1375804940-22050-22-git-send-email-anton@samba.org>
In-Reply-To: <1375804940-22050-1-git-send-email-anton@samba.org>
References: <1375804940-22050-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/prom_init.c | 253 +++++++++++++++++++++++-----------------
 1 file changed, 147 insertions(+), 106 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 6079024..5996a2983 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -107,10 +107,10 @@ int of_workarounds;
 typedef u32 prom_arg_t;
 
 struct prom_args {
-        u32 service;
-        u32 nargs;
-        u32 nret;
-        prom_arg_t args[10];
+        __be32 service;
+        __be32 nargs;
+        __be32 nret;
+        __be32 args[10];
 };
 
 struct prom_t {
@@ -123,11 +123,11 @@ struct prom_t {
 };
 
 struct mem_map_entry {
-	u64	base;
-	u64	size;
+	__be64	base;
+	__be64	size;
 };
 
-typedef u32 cell_t;
+typedef __be32 cell_t;
 
 extern void __start(unsigned long r3, unsigned long r4, unsigned long r5,
 		    unsigned long r6, unsigned long r7, unsigned long r8,
@@ -219,13 +219,13 @@ static int __init call_prom(const char *service, int nargs, int nret, ...)
 	struct prom_args args;
 	va_list list;
 
-	args.service = ADDR(service);
-	args.nargs = nargs;
-	args.nret = nret;
+	args.service = cpu_to_be32(ADDR(service));
+	args.nargs = cpu_to_be32(nargs);
+	args.nret = cpu_to_be32(nret);
 
 	va_start(list, nret);
 	for (i = 0; i < nargs; i++)
-		args.args[i] = va_arg(list, prom_arg_t);
+		args.args[i] = cpu_to_be32(va_arg(list, prom_arg_t));
 	va_end(list);
 
 	for (i = 0; i < nret; i++)
@@ -234,7 +234,7 @@ static int __init call_prom(const char *service, int nargs, int nret, ...)
 	if (enter_prom(&args, prom_entry) < 0)
 		return PROM_ERROR;
 
-	return (nret > 0) ? args.args[nargs] : 0;
+	return (nret > 0) ? be32_to_cpu(args.args[nargs]) : 0;
 }
 
 static int __init call_prom_ret(const char *service, int nargs, int nret,
@@ -244,13 +244,13 @@ static int __init call_prom_ret(const char *service, int nargs, int nret,
 	struct prom_args args;
 	va_list list;
 
-	args.service = ADDR(service);
-	args.nargs = nargs;
-	args.nret = nret;
+	args.service = cpu_to_be32(ADDR(service));
+	args.nargs = cpu_to_be32(nargs);
+	args.nret = cpu_to_be32(nret);
 
 	va_start(list, rets);
 	for (i = 0; i < nargs; i++)
-		args.args[i] = va_arg(list, prom_arg_t);
+		args.args[i] = cpu_to_be32(va_arg(list, prom_arg_t));
 	va_end(list);
 
 	for (i = 0; i < nret; i++)
@@ -261,9 +261,9 @@ static int __init call_prom_ret(const char *service, int nargs, int nret,
 
 	if (rets != NULL)
 		for (i = 1; i < nret; ++i)
-			rets[i-1] = args.args[nargs+i];
+			rets[i-1] = be32_to_cpu(args.args[nargs+i]);
 
-	return (nret > 0) ? args.args[nargs] : 0;
+	return (nret > 0) ? be32_to_cpu(args.args[nargs]) : 0;
 }
 
 
@@ -527,7 +527,7 @@ static int __init prom_setprop(phandle node, const char *nodename,
 #define islower(c)	('a' <= (c) && (c) <= 'z')
 #define toupper(c)	(islower(c) ? ((c) - 'a' + 'A') : (c))
 
-unsigned long prom_strtoul(const char *cp, const char **endp)
+static unsigned long prom_strtoul(const char *cp, const char **endp)
 {
 	unsigned long result = 0, base = 10, value;
 
@@ -552,7 +552,7 @@ unsigned long prom_strtoul(const char *cp, const char **endp)
 	return result;
 }
 
-unsigned long prom_memparse(const char *ptr, const char **retptr)
+static unsigned long prom_memparse(const char *ptr, const char **retptr)
 {
 	unsigned long ret = prom_strtoul(ptr, retptr);
 	int shift = 0;
@@ -724,7 +724,8 @@ unsigned char ibm_architecture_vec[] = {
 
 };
 
-/* Old method - ELF header with PT_NOTE sections */
+/* Old method - ELF header with PT_NOTE sections only works on BE */
+#ifdef __BIG_ENDIAN__
 static struct fake_elf {
 	Elf32_Ehdr	elfhdr;
 	Elf32_Phdr	phdr[2];
@@ -810,6 +811,7 @@ static struct fake_elf {
 		}
 	}
 };
+#endif /* __BIG_ENDIAN__ */
 
 static int __init prom_count_smt_threads(void)
 {
@@ -852,9 +854,9 @@ static int __init prom_count_smt_threads(void)
 
 static void __init prom_send_capabilities(void)
 {
-	ihandle elfloader, root;
+	ihandle root;
 	prom_arg_t ret;
-	u32 *cores;
+	__be32 *cores;
 
 	root = call_prom("open", 1, 1, ADDR("/"));
 	if (root != 0) {
@@ -864,15 +866,15 @@ static void __init prom_send_capabilities(void)
 		 * (we assume this is the same for all cores) and use it to
 		 * divide NR_CPUS.
 		 */
-		cores = (u32 *)&ibm_architecture_vec[IBM_ARCH_VEC_NRCORES_OFFSET];
-		if (*cores != NR_CPUS) {
+		cores = (__be32 *)&ibm_architecture_vec[IBM_ARCH_VEC_NRCORES_OFFSET];
+		if (be32_to_cpup(cores) != NR_CPUS) {
 			prom_printf("WARNING ! "
 				    "ibm_architecture_vec structure inconsistent: %lu!\n",
-				    *cores);
+				    be32_to_cpup(cores));
 		} else {
-			*cores = DIV_ROUND_UP(NR_CPUS, prom_count_smt_threads());
+			*cores = cpu_to_be32(DIV_ROUND_UP(NR_CPUS, prom_count_smt_threads()));
 			prom_printf("Max number of cores passed to firmware: %lu (NR_CPUS = %lu)\n",
-				    *cores, NR_CPUS);
+				    be32_to_cpup(cores), NR_CPUS);
 		}
 
 		/* try calling the ibm,client-architecture-support method */
@@ -893,17 +895,24 @@ static void __init prom_send_capabilities(void)
 		prom_printf(" not implemented\n");
 	}
 
-	/* no ibm,client-architecture-support call, try the old way */
-	elfloader = call_prom("open", 1, 1, ADDR("/packages/elf-loader"));
-	if (elfloader == 0) {
-		prom_printf("couldn't open /packages/elf-loader\n");
-		return;
+#ifdef __BIG_ENDIAN__
+	{
+		ihandle elfloader;
+
+		/* no ibm,client-architecture-support call, try the old way */
+		elfloader = call_prom("open", 1, 1,
+				      ADDR("/packages/elf-loader"));
+		if (elfloader == 0) {
+			prom_printf("couldn't open /packages/elf-loader\n");
+			return;
+		}
+		call_prom("call-method", 3, 1, ADDR("process-elf-header"),
+			  elfloader, ADDR(&fake_elf));
+		call_prom("close", 1, 0, elfloader);
 	}
-	call_prom("call-method", 3, 1, ADDR("process-elf-header"),
-			elfloader, ADDR(&fake_elf));
-	call_prom("close", 1, 0, elfloader);
+#endif /* __BIG_ENDIAN__ */
 }
-#endif
+#endif /* #if defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV) */
 
 /*
  * Memory allocation strategy... our layout is normally:
@@ -1050,11 +1059,11 @@ static unsigned long __init prom_next_cell(int s, cell_t **cellp)
 		p++;
 		s--;
 	}
-	r = *p++;
+	r = be32_to_cpu(*p++);
 #ifdef CONFIG_PPC64
 	if (s > 1) {
 		r <<= 32;
-		r |= *(p++);
+		r |= be32_to_cpu(*(p++));
 	}
 #endif
 	*cellp = p;
@@ -1087,8 +1096,8 @@ static void __init reserve_mem(u64 base, u64 size)
 
 	if (cnt >= (MEM_RESERVE_MAP_SIZE - 1))
 		prom_panic("Memory reserve map exhausted !\n");
-	mem_reserve_map[cnt].base = base;
-	mem_reserve_map[cnt].size = size;
+	mem_reserve_map[cnt].base = cpu_to_be64(base);
+	mem_reserve_map[cnt].size = cpu_to_be64(size);
 	mem_reserve_cnt = cnt + 1;
 }
 
@@ -1102,6 +1111,7 @@ static void __init prom_init_mem(void)
 	char *path, type[64];
 	unsigned int plen;
 	cell_t *p, *endp;
+	__be32 val;
 	u32 rac, rsc;
 
 	/*
@@ -1109,12 +1119,14 @@ static void __init prom_init_mem(void)
 	 * 1) top of RMO (first node)
 	 * 2) top of memory
 	 */
-	rac = 2;
-	prom_getprop(prom.root, "#address-cells", &rac, sizeof(rac));
-	rsc = 1;
-	prom_getprop(prom.root, "#size-cells", &rsc, sizeof(rsc));
-	prom_debug("root_addr_cells: %x\n", (unsigned long) rac);
-	prom_debug("root_size_cells: %x\n", (unsigned long) rsc);
+	val = cpu_to_be32(2);
+	prom_getprop(prom.root, "#address-cells", &val, sizeof(val));
+	rac = be32_to_cpu(val);
+	val = cpu_to_be32(1);
+	prom_getprop(prom.root, "#size-cells", &val, sizeof(rsc));
+	rsc = be32_to_cpu(val);
+	prom_debug("root_addr_cells: %x\n", rac);
+	prom_debug("root_size_cells: %x\n", rsc);
 
 	prom_debug("scanning memory:\n");
 	path = prom_scratch;
@@ -1222,25 +1234,23 @@ static void __init prom_init_mem(void)
 
 static void __init prom_close_stdin(void)
 {
-	ihandle val;
+	__be32 val;
+	ihandle stdin;
 
-	if (prom_getprop(prom.chosen, "stdin", &val, sizeof(val)) > 0)
-		call_prom("close", 1, 0, val);
+	if (prom_getprop(prom.chosen, "stdin", &val, sizeof(val)) > 0) {
+		stdin = be32_to_cpu(val);
+		call_prom("close", 1, 0, stdin);
+	}
 }
 
 #ifdef CONFIG_PPC_POWERNV
 
-static u64 __initdata prom_opal_size;
-static u64 __initdata prom_opal_align;
-static int __initdata prom_rtas_start_cpu;
-static u64 __initdata prom_rtas_data;
-static u64 __initdata prom_rtas_entry;
-
 #ifdef CONFIG_PPC_EARLY_DEBUG_OPAL
 static u64 __initdata prom_opal_base;
 static u64 __initdata prom_opal_entry;
 #endif
 
+#ifdef __BIG_ENDIAN__
 /* XXX Don't change this structure without updating opal-takeover.S */
 static struct opal_secondary_data {
 	s64				ack;	/*  0 */
@@ -1248,6 +1258,12 @@ static struct opal_secondary_data {
 	struct opal_takeover_args	args;	/* 16 */
 } opal_secondary_data;
 
+static u64 __initdata prom_opal_align;
+static u64 __initdata prom_opal_size;
+static int __initdata prom_rtas_start_cpu;
+static u64 __initdata prom_rtas_data;
+static u64 __initdata prom_rtas_entry;
+
 extern char opal_secondary_entry;
 
 static void __init prom_query_opal(void)
@@ -1265,6 +1281,7 @@ static void __init prom_query_opal(void)
 	}
 
 	prom_printf("Querying for OPAL presence... ");
+
 	rc = opal_query_takeover(&prom_opal_size,
 				 &prom_opal_align);
 	prom_debug("(rc = %ld) ", rc);
@@ -1425,6 +1442,7 @@ static void __init prom_opal_takeover(void)
 	for (;;)
 		opal_do_takeover(args);
 }
+#endif /* __BIG_ENDIAN__ */
 
 /*
  * Allocate room for and instantiate OPAL
@@ -1435,6 +1453,7 @@ static void __init prom_instantiate_opal(void)
 	ihandle opal_inst;
 	u64 base, entry;
 	u64 size = 0, align = 0x10000;
+	__be64 val64;
 	u32 rets[2];
 
 	prom_debug("prom_instantiate_opal: start...\n");
@@ -1444,11 +1463,14 @@ static void __init prom_instantiate_opal(void)
 	if (!PHANDLE_VALID(opal_node))
 		return;
 
-	prom_getprop(opal_node, "opal-runtime-size", &size, sizeof(size));
+	val64 = 0;
+	prom_getprop(opal_node, "opal-runtime-size", &val64, sizeof(val64));
+	size = be64_to_cpu(val64);
 	if (size == 0)
 		return;
-	prom_getprop(opal_node, "opal-runtime-alignment", &align,
-		     sizeof(align));
+	val64 = 0;
+	prom_getprop(opal_node, "opal-runtime-alignment", &val64,sizeof(val64));
+	align = be64_to_cpu(val64);
 
 	base = alloc_down(size, align, 0);
 	if (base == 0) {
@@ -1505,6 +1527,7 @@ static void __init prom_instantiate_rtas(void)
 	phandle rtas_node;
 	ihandle rtas_inst;
 	u32 base, entry = 0;
+	__be32 val;
 	u32 size = 0;
 
 	prom_debug("prom_instantiate_rtas: start...\n");
@@ -1514,7 +1537,9 @@ static void __init prom_instantiate_rtas(void)
 	if (!PHANDLE_VALID(rtas_node))
 		return;
 
-	prom_getprop(rtas_node, "rtas-size", &size, sizeof(size));
+	val = 0;
+	prom_getprop(rtas_node, "rtas-size", &val, sizeof(size));
+	size = be32_to_cpu(val);
 	if (size == 0)
 		return;
 
@@ -1541,12 +1566,14 @@ static void __init prom_instantiate_rtas(void)
 
 	reserve_mem(base, size);
 
+	val = cpu_to_be32(base);
 	prom_setprop(rtas_node, "/rtas", "linux,rtas-base",
-		     &base, sizeof(base));
+		     &val, sizeof(val));
+	val = cpu_to_be32(entry);
 	prom_setprop(rtas_node, "/rtas", "linux,rtas-entry",
-		     &entry, sizeof(entry));
+		     &val, sizeof(val));
 
-#ifdef CONFIG_PPC_POWERNV
+#if defined(CONFIG_PPC_POWERNV) && defined(__BIG_ENDIAN__)
 	/* PowerVN takeover hack */
 	prom_rtas_data = base;
 	prom_rtas_entry = entry;
@@ -1620,6 +1647,7 @@ static void __init prom_instantiate_sml(void)
 /*
  * Allocate room for and initialize TCE tables
  */
+#ifdef __BIG_ENDIAN__
 static void __init prom_initialize_tce_table(void)
 {
 	phandle node;
@@ -1748,7 +1776,8 @@ static void __init prom_initialize_tce_table(void)
 	/* Flag the first invalid entry */
 	prom_debug("ending prom_initialize_tce_table\n");
 }
-#endif
+#endif /* __BIG_ENDIAN__ */
+#endif /* CONFIG_PPC64 */
 
 /*
  * With CHRP SMP we need to use the OF to start the other processors.
@@ -1777,7 +1806,6 @@ static void __init prom_initialize_tce_table(void)
 static void __init prom_hold_cpus(void)
 {
 	unsigned long i;
-	unsigned int reg;
 	phandle node;
 	char type[64];
 	unsigned long *spinloop
@@ -1803,6 +1831,9 @@ static void __init prom_hold_cpus(void)
 
 	/* look for cpus */
 	for (node = 0; prom_next_node(&node); ) {
+		unsigned int cpu_no;
+		__be32 reg;
+
 		type[0] = 0;
 		prom_getprop(node, "device_type", type, sizeof(type));
 		if (strcmp(type, "cpu") != 0)
@@ -1813,10 +1844,11 @@ static void __init prom_hold_cpus(void)
 			if (strcmp(type, "okay") != 0)
 				continue;
 
-		reg = -1;
+		reg = cpu_to_be32(-1); /* make sparse happy */
 		prom_getprop(node, "reg", &reg, sizeof(reg));
+		cpu_no = be32_to_cpu(reg);
 
-		prom_debug("cpu hw idx   = %lu\n", reg);
+		prom_debug("cpu hw idx   = %lu\n", cpu_no);
 
 		/* Init the acknowledge var which will be reset by
 		 * the secondary cpu when it awakens from its OF
@@ -1824,24 +1856,24 @@ static void __init prom_hold_cpus(void)
 		 */
 		*acknowledge = (unsigned long)-1;
 
-		if (reg != prom.cpu) {
+		if (cpu_no != prom.cpu) {
 			/* Primary Thread of non-boot cpu or any thread */
-			prom_printf("starting cpu hw idx %lu... ", reg);
+			prom_printf("starting cpu hw idx %lu... ", cpu_no);
 			call_prom("start-cpu", 3, 0, node,
-				  secondary_hold, reg);
+				  secondary_hold, cpu_no);
 
 			for (i = 0; (i < 100000000) && 
 			     (*acknowledge == ((unsigned long)-1)); i++ )
 				mb();
 
-			if (*acknowledge == reg)
+			if (*acknowledge == cpu_no)
 				prom_printf("done\n");
 			else
 				prom_printf("failed: %x\n", *acknowledge);
 		}
 #ifdef CONFIG_SMP
 		else
-			prom_printf("boot cpu hw idx %lu\n", reg);
+			prom_printf("boot cpu hw idx %lu\n", cpu_no);
 #endif /* CONFIG_SMP */
 	}
 
@@ -1895,6 +1927,7 @@ static void __init prom_find_mmu(void)
 	prom.memory = call_prom("open", 1, 1, ADDR("/memory"));
 	prom_getprop(prom.chosen, "mmu", &prom.mmumap,
 		     sizeof(prom.mmumap));
+	prom.mmumap = be32_to_cpu(prom.mmumap);
 	if (!IHANDLE_VALID(prom.memory) || !IHANDLE_VALID(prom.mmumap))
 		of_workarounds &= ~OF_WA_CLAIM;		/* hmmm */
 }
@@ -1906,17 +1939,19 @@ static void __init prom_init_stdout(void)
 {
 	char *path = of_stdout_device;
 	char type[16];
-	u32 val;
+	phandle stdout_node;
+	__be32 val;
 
 	if (prom_getprop(prom.chosen, "stdout", &val, sizeof(val)) <= 0)
 		prom_panic("cannot find stdout");
 
-	prom.stdout = val;
+	prom.stdout = be32_to_cpu(val);
 
 	/* Get the full OF pathname of the stdout device */
 	memset(path, 0, 256);
 	call_prom("instance-to-path", 3, 1, prom.stdout, path, 255);
-	val = call_prom("instance-to-package", 1, 1, prom.stdout);
+	stdout_node = call_prom("instance-to-package", 1, 1, prom.stdout);
+	val = cpu_to_be32(stdout_node);
 	prom_setprop(prom.chosen, "/chosen", "linux,stdout-package",
 		     &val, sizeof(val));
 	prom_printf("OF stdout device is: %s\n", of_stdout_device);
@@ -1925,9 +1960,9 @@ static void __init prom_init_stdout(void)
 
 	/* If it's a display, note it */
 	memset(type, 0, sizeof(type));
-	prom_getprop(val, "device_type", type, sizeof(type));
+	prom_getprop(stdout_node, "device_type", type, sizeof(type));
 	if (strcmp(type, "display") == 0)
-		prom_setprop(val, path, "linux,boot-display", NULL, 0);
+		prom_setprop(stdout_node, path, "linux,boot-display", NULL, 0);
 }
 
 static int __init prom_find_machine_type(void)
@@ -2117,8 +2152,10 @@ static void __init *make_room(unsigned long *mem_start, unsigned long *mem_end,
 	return ret;
 }
 
-#define dt_push_token(token, mem_start, mem_end) \
-	do { *((u32 *)make_room(mem_start, mem_end, 4, 4)) = token; } while(0)
+#define dt_push_token(token, mem_start, mem_end) do { 			\
+		void *room = make_room(mem_start, mem_end, 4, 4);	\
+		*(__be32 *)room = cpu_to_be32(token);			\
+	} while(0)
 
 static unsigned long __init dt_find_string(char *str)
 {
@@ -2291,7 +2328,7 @@ static void __init scan_dt_build_struct(phandle node, unsigned long *mem_start,
 			dt_push_token(4, mem_start, mem_end);
 			dt_push_token(soff, mem_start, mem_end);
 			valp = make_room(mem_start, mem_end, 4, 4);
-			*(u32 *)valp = node;
+			*(__be32 *)valp = cpu_to_be32(node);
 		}
 	}
 
@@ -2364,16 +2401,16 @@ static void __init flatten_device_tree(void)
 	dt_struct_end = PAGE_ALIGN(mem_start);
 
 	/* Finish header */
-	hdr->boot_cpuid_phys = prom.cpu;
-	hdr->magic = OF_DT_HEADER;
-	hdr->totalsize = dt_struct_end - dt_header_start;
-	hdr->off_dt_struct = dt_struct_start - dt_header_start;
-	hdr->off_dt_strings = dt_string_start - dt_header_start;
-	hdr->dt_strings_size = dt_string_end - dt_string_start;
-	hdr->off_mem_rsvmap = ((unsigned long)rsvmap) - dt_header_start;
-	hdr->version = OF_DT_VERSION;
+	hdr->boot_cpuid_phys = cpu_to_be32(prom.cpu);
+	hdr->magic = cpu_to_be32(OF_DT_HEADER);
+	hdr->totalsize = cpu_to_be32(dt_struct_end - dt_header_start);
+	hdr->off_dt_struct = cpu_to_be32(dt_struct_start - dt_header_start);
+	hdr->off_dt_strings = cpu_to_be32(dt_string_start - dt_header_start);
+	hdr->dt_strings_size = cpu_to_be32(dt_string_end - dt_string_start);
+	hdr->off_mem_rsvmap = cpu_to_be32(((unsigned long)rsvmap) - dt_header_start);
+	hdr->version = cpu_to_be32(OF_DT_VERSION);
 	/* Version 16 is not backward compatible */
-	hdr->last_comp_version = 0x10;
+	hdr->last_comp_version = cpu_to_be32(0x10);
 
 	/* Copy the reserve map in */
 	memcpy(rsvmap, mem_reserve_map, sizeof(mem_reserve_map));
@@ -2384,8 +2421,8 @@ static void __init flatten_device_tree(void)
 		prom_printf("reserved memory map:\n");
 		for (i = 0; i < mem_reserve_cnt; i++)
 			prom_printf("  %x - %x\n",
-				    mem_reserve_map[i].base,
-				    mem_reserve_map[i].size);
+				    be64_to_cpu(mem_reserve_map[i].base),
+				    be64_to_cpu(mem_reserve_map[i].size));
 	}
 #endif
 	/* Bump mem_reserve_cnt to cause further reservations to fail
@@ -2397,7 +2434,6 @@ static void __init flatten_device_tree(void)
 		    dt_string_start, dt_string_end);
 	prom_printf("Device tree struct  0x%x -> 0x%x\n",
 		    dt_struct_start, dt_struct_end);
-
 }
 
 #ifdef CONFIG_PPC_MAPLE
@@ -2730,18 +2766,19 @@ static void __init fixup_device_tree(void)
 
 static void __init prom_find_boot_cpu(void)
 {
-	u32 getprop_rval;
+	__be32 rval;
 	ihandle prom_cpu;
 	phandle cpu_pkg;
 
-	prom.cpu = 0;
-	if (prom_getprop(prom.chosen, "cpu", &prom_cpu, sizeof(prom_cpu)) <= 0)
+	rval = 0;
+	if (prom_getprop(prom.chosen, "cpu", &rval, sizeof(rval)) <= 0)
 		return;
+	prom_cpu = be32_to_cpu(rval);
 
 	cpu_pkg = call_prom("instance-to-package", 1, 1, prom_cpu);
 
-	prom_getprop(cpu_pkg, "reg", &getprop_rval, sizeof(getprop_rval));
-	prom.cpu = getprop_rval;
+	prom_getprop(cpu_pkg, "reg", &rval, sizeof(rval));
+	prom.cpu = be32_to_cpu(rval);
 
 	prom_debug("Booting CPU hw index = %lu\n", prom.cpu);
 }
@@ -2750,15 +2787,15 @@ static void __init prom_check_initrd(unsigned long r3, unsigned long r4)
 {
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (r3 && r4 && r4 != 0xdeadbeef) {
-		unsigned long val;
+		__be64 val;
 
 		prom_initrd_start = is_kernel_addr(r3) ? __pa(r3) : r3;
 		prom_initrd_end = prom_initrd_start + r4;
 
-		val = prom_initrd_start;
+		val = cpu_to_be64(prom_initrd_start);
 		prom_setprop(prom.chosen, "/chosen", "linux,initrd-start",
 			     &val, sizeof(val));
-		val = prom_initrd_end;
+		val = cpu_to_be64(prom_initrd_end);
 		prom_setprop(prom.chosen, "/chosen", "linux,initrd-end",
 			     &val, sizeof(val));
 
@@ -2915,7 +2952,7 @@ unsigned long __init prom_init(unsigned long r3, unsigned long r4,
 	 */
 	prom_check_displays();
 
-#ifdef CONFIG_PPC64
+#if defined(CONFIG_PPC64) && defined(__BIG_ENDIAN__)
 	/*
 	 * Initialize IOMMU (TCE tables) on pSeries. Do that before anything else
 	 * that uses the allocator, we need to make sure we get the top of memory
@@ -2934,6 +2971,7 @@ unsigned long __init prom_init(unsigned long r3, unsigned long r4,
 		prom_instantiate_rtas();
 
 #ifdef CONFIG_PPC_POWERNV
+#ifdef __BIG_ENDIAN__
 	/* Detect HAL and try instanciating it & doing takeover */
 	if (of_platform == PLATFORM_PSERIES_LPAR) {
 		prom_query_opal();
@@ -2941,9 +2979,11 @@ unsigned long __init prom_init(unsigned long r3, unsigned long r4,
 			prom_opal_hold_cpus();
 			prom_opal_takeover();
 		}
-	} else if (of_platform == PLATFORM_OPAL)
+	} else
+#endif /* __BIG_ENDIAN__ */
+	if (of_platform == PLATFORM_OPAL)
 		prom_instantiate_opal();
-#endif
+#endif /* CONFIG_PPC_POWERNV */
 
 #ifdef CONFIG_PPC64
 	/* instantiate sml */
@@ -2962,10 +3002,11 @@ unsigned long __init prom_init(unsigned long r3, unsigned long r4,
 	/*
 	 * Fill in some infos for use by the kernel later on
 	 */
-	if (prom_memory_limit)
+	if (prom_memory_limit) {
+		__be64 val = cpu_to_be64(prom_memory_limit);
 		prom_setprop(prom.chosen, "/chosen", "linux,memory-limit",
-			     &prom_memory_limit,
-			     sizeof(prom_memory_limit));
+			     &val, sizeof(val));
+	}
 #ifdef CONFIG_PPC64
 	if (prom_iommu_off)
 		prom_setprop(prom.chosen, "/chosen", "linux,iommu-off",
-- 
1.8.1.2
