Return-Path: <anton@samba.org>
Date: Tue, 27 Nov 2012 14:40:03 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, amodra@gmail.com
Subject: [PATCH 2/3] powerpc: Remove RELOC() macro
Message-ID: <20121127144003.23f1e330@kryten>
In-Reply-To: <20121127143903.4b5cab17@kryten>
References: <20121127143903.4b5cab17@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Now we relocate prom_init.c on 64bit we can finally remove the
nasty RELOC() macro.

Finally a patch that I can claim has a net positive effect on
the kernel. It doesn't happen very often.

Signed-off-by: Anton Blanchard <anton@samba.org>
--- 

Index: b/arch/powerpc/kernel/prom_init.c
===================================================================
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -79,7 +79,6 @@
  * On ppc64, 64 bit values are truncated to 32 bits (and
  * fortunately don't get interpreted as two arguments).
  */
-#define RELOC(x)	(x)
 #define ADDR(x)		(u32)(unsigned long)(x)
 
 #ifdef CONFIG_PPC64
@@ -94,7 +93,7 @@ int of_workarounds;
 
 #define PROM_BUG() do {						\
         prom_printf("kernel BUG at %s line 0x%x!\n",		\
-		    RELOC(__FILE__), __LINE__);			\
+		    __FILE__, __LINE__);			\
         __asm__ __volatile__(".long " BUG_ILLEGAL_INSTR);	\
 } while (0)
 
@@ -232,7 +231,7 @@ static int __init call_prom(const char *
 	for (i = 0; i < nret; i++)
 		args.args[nargs+i] = 0;
 
-	if (enter_prom(&args, RELOC(prom_entry)) < 0)
+	if (enter_prom(&args, prom_entry) < 0)
 		return PROM_ERROR;
 
 	return (nret > 0) ? args.args[nargs] : 0;
@@ -257,7 +256,7 @@ static int __init call_prom_ret(const ch
 	for (i = 0; i < nret; i++)
 		args.args[nargs+i] = 0;
 
-	if (enter_prom(&args, RELOC(prom_entry)) < 0)
+	if (enter_prom(&args, prom_entry) < 0)
 		return PROM_ERROR;
 
 	if (rets != NULL)
@@ -271,20 +270,19 @@ static int __init call_prom_ret(const ch
 static void __init prom_print(const char *msg)
 {
 	const char *p, *q;
-	struct prom_t *_prom = &RELOC(prom);
 
-	if (_prom->stdout == 0)
+	if (prom.stdout == 0)
 		return;
 
 	for (p = msg; *p != 0; p = q) {
 		for (q = p; *q != 0 && *q != '\n'; ++q)
 			;
 		if (q > p)
-			call_prom("write", 3, 1, _prom->stdout, p, q - p);
+			call_prom("write", 3, 1, prom.stdout, p, q - p);
 		if (*q == 0)
 			break;
 		++q;
-		call_prom("write", 3, 1, _prom->stdout, ADDR("\r\n"), 2);
+		call_prom("write", 3, 1, prom.stdout, ADDR("\r\n"), 2);
 	}
 }
 
@@ -293,7 +291,6 @@ static void __init prom_print_hex(unsign
 {
 	int i, nibbles = sizeof(val)*2;
 	char buf[sizeof(val)*2+1];
-	struct prom_t *_prom = &RELOC(prom);
 
 	for (i = nibbles-1;  i >= 0;  i--) {
 		buf[i] = (val & 0xf) + '0';
@@ -302,7 +299,7 @@ static void __init prom_print_hex(unsign
 		val >>= 4;
 	}
 	buf[nibbles] = '\0';
-	call_prom("write", 3, 1, _prom->stdout, buf, nibbles);
+	call_prom("write", 3, 1, prom.stdout, buf, nibbles);
 }
 
 /* max number of decimal digits in an unsigned long */
@@ -311,7 +308,6 @@ static void __init prom_print_dec(unsign
 {
 	int i, size;
 	char buf[UL_DIGITS+1];
-	struct prom_t *_prom = &RELOC(prom);
 
 	for (i = UL_DIGITS-1; i >= 0;  i--) {
 		buf[i] = (val % 10) + '0';
@@ -321,7 +317,7 @@ static void __init prom_print_dec(unsign
 	}
 	/* shift stuff down */
 	size = UL_DIGITS - i;
-	call_prom("write", 3, 1, _prom->stdout, buf+i, size);
+	call_prom("write", 3, 1, prom.stdout, buf+i, size);
 }
 
 static void __init prom_printf(const char *format, ...)
@@ -330,19 +326,18 @@ static void __init prom_printf(const cha
 	va_list args;
 	unsigned long v;
 	long vs;
-	struct prom_t *_prom = &RELOC(prom);
 
 	va_start(args, format);
 	for (p = format; *p != 0; p = q) {
 		for (q = p; *q != 0 && *q != '\n' && *q != '%'; ++q)
 			;
 		if (q > p)
-			call_prom("write", 3, 1, _prom->stdout, p, q - p);
+			call_prom("write", 3, 1, prom.stdout, p, q - p);
 		if (*q == 0)
 			break;
 		if (*q == '\n') {
 			++q;
-			call_prom("write", 3, 1, _prom->stdout,
+			call_prom("write", 3, 1, prom.stdout,
 				  ADDR("\r\n"), 2);
 			continue;
 		}
@@ -364,7 +359,7 @@ static void __init prom_printf(const cha
 			++q;
 			vs = va_arg(args, int);
 			if (vs < 0) {
-				prom_print(RELOC("-"));
+				prom_print("-");
 				vs = -vs;
 			}
 			prom_print_dec(vs);
@@ -385,7 +380,7 @@ static void __init prom_printf(const cha
 				++q;
 				vs = va_arg(args, long);
 				if (vs < 0) {
-					prom_print(RELOC("-"));
+					prom_print("-");
 					vs = -vs;
 				}
 				prom_print_dec(vs);
@@ -399,7 +394,6 @@ static void __init prom_printf(const cha
 static unsigned int __init prom_claim(unsigned long virt, unsigned long size,
 				unsigned long align)
 {
-	struct prom_t *_prom = &RELOC(prom);
 
 	if (align == 0 && (OF_WORKAROUNDS & OF_WA_CLAIM)) {
 		/*
@@ -410,21 +404,21 @@ static unsigned int __init prom_claim(un
 		prom_arg_t result;
 
 		ret = call_prom_ret("call-method", 5, 2, &result,
-				    ADDR("claim"), _prom->memory,
+				    ADDR("claim"), prom.memory,
 				    align, size, virt);
 		if (ret != 0 || result == -1)
 			return -1;
 		ret = call_prom_ret("call-method", 5, 2, &result,
-				    ADDR("claim"), _prom->mmumap,
+				    ADDR("claim"), prom.mmumap,
 				    align, size, virt);
 		if (ret != 0) {
 			call_prom("call-method", 4, 1, ADDR("release"),
-				  _prom->memory, size, virt);
+				  prom.memory, size, virt);
 			return -1;
 		}
 		/* the 0x12 is M (coherence) + PP == read/write */
 		call_prom("call-method", 6, 1,
-			  ADDR("map"), _prom->mmumap, 0x12, size, virt, virt);
+			  ADDR("map"), prom.mmumap, 0x12, size, virt, virt);
 		return virt;
 	}
 	return call_prom("claim", 3, 1, (prom_arg_t)virt, (prom_arg_t)size,
@@ -436,7 +430,7 @@ static void __init __attribute__((noretu
 	prom_print(reason);
 	/* Do not call exit because it clears the screen on pmac
 	 * it also causes some sort of double-fault on early pmacs */
-	if (RELOC(of_platform) == PLATFORM_POWERMAC)
+	if (of_platform == PLATFORM_POWERMAC)
 		asm("trap\n");
 
 	/* ToDo: should put up an SRC here on pSeries */
@@ -518,13 +512,13 @@ static int __init prom_setprop(phandle n
 	add_string(&p, tohex((u32)(unsigned long) value));
 	add_string(&p, tohex(valuelen));
 	add_string(&p, tohex(ADDR(pname)));
-	add_string(&p, tohex(strlen(RELOC(pname))));
+	add_string(&p, tohex(strlen(pname)));
 	add_string(&p, "property");
 	*p = 0;
 	return call_prom("interpret", 1, 1, (u32)(unsigned long) cmd);
 }
 
-/* We can't use the standard versions because of RELOC headaches. */
+/* We can't use the standard versions because of relocation headaches. */
 #define isxdigit(c)	(('0' <= (c) && (c) <= '9') \
 			 || ('a' <= (c) && (c) <= 'f') \
 			 || ('A' <= (c) && (c) <= 'F'))
@@ -591,43 +585,42 @@ static unsigned long prom_memparse(const
  */
 static void __init early_cmdline_parse(void)
 {
-	struct prom_t *_prom = &RELOC(prom);
 	const char *opt;
 
 	char *p;
 	int l = 0;
 
-	RELOC(prom_cmd_line[0]) = 0;
-	p = RELOC(prom_cmd_line);
-	if ((long)_prom->chosen > 0)
-		l = prom_getprop(_prom->chosen, "bootargs", p, COMMAND_LINE_SIZE-1);
+	prom_cmd_line[0] = 0;
+	p = prom_cmd_line;
+	if ((long)prom.chosen > 0)
+		l = prom_getprop(prom.chosen, "bootargs", p, COMMAND_LINE_SIZE-1);
 #ifdef CONFIG_CMDLINE
 	if (l <= 0 || p[0] == '\0') /* dbl check */
-		strlcpy(RELOC(prom_cmd_line),
-			RELOC(CONFIG_CMDLINE), sizeof(prom_cmd_line));
+		strlcpy(prom_cmd_line,
+			CONFIG_CMDLINE, sizeof(prom_cmd_line));
 #endif /* CONFIG_CMDLINE */
-	prom_printf("command line: %s\n", RELOC(prom_cmd_line));
+	prom_printf("command line: %s\n", prom_cmd_line);
 
 #ifdef CONFIG_PPC64
-	opt = strstr(RELOC(prom_cmd_line), RELOC("iommu="));
+	opt = strstr(prom_cmd_line, "iommu=");
 	if (opt) {
 		prom_printf("iommu opt is: %s\n", opt);
 		opt += 6;
 		while (*opt && *opt == ' ')
 			opt++;
-		if (!strncmp(opt, RELOC("off"), 3))
-			RELOC(prom_iommu_off) = 1;
-		else if (!strncmp(opt, RELOC("force"), 5))
-			RELOC(prom_iommu_force_on) = 1;
+		if (!strncmp(opt, "off", 3))
+			prom_iommu_off = 1;
+		else if (!strncmp(opt, "force", 5))
+			prom_iommu_force_on = 1;
 	}
 #endif
-	opt = strstr(RELOC(prom_cmd_line), RELOC("mem="));
+	opt = strstr(prom_cmd_line, "mem=");
 	if (opt) {
 		opt += 4;
-		RELOC(prom_memory_limit) = prom_memparse(opt, (const char **)&opt);
+		prom_memory_limit = prom_memparse(opt, (const char **)&opt);
 #ifdef CONFIG_PPC64
 		/* Align to 16 MB == size of ppc64 large page */
-		RELOC(prom_memory_limit) = ALIGN(RELOC(prom_memory_limit), 0x1000000);
+		prom_memory_limit = ALIGN(prom_memory_limit, 0x1000000);
 #endif
 	}
 }
@@ -880,7 +873,7 @@ static int __init prom_count_smt_threads
 		type[0] = 0;
 		prom_getprop(node, "device_type", type, sizeof(type));
 
-		if (strcmp(type, RELOC("cpu")))
+		if (strcmp(type, "cpu"))
 			continue;
 		/*
 		 * There is an entry for each smt thread, each entry being
@@ -998,21 +991,21 @@ static void __init prom_send_capabilitie
  */
 static unsigned long __init alloc_up(unsigned long size, unsigned long align)
 {
-	unsigned long base = RELOC(alloc_bottom);
+	unsigned long base = alloc_bottom;
 	unsigned long addr = 0;
 
 	if (align)
 		base = _ALIGN_UP(base, align);
 	prom_debug("alloc_up(%x, %x)\n", size, align);
-	if (RELOC(ram_top) == 0)
+	if (ram_top == 0)
 		prom_panic("alloc_up() called with mem not initialized\n");
 
 	if (align)
-		base = _ALIGN_UP(RELOC(alloc_bottom), align);
+		base = _ALIGN_UP(alloc_bottom, align);
 	else
-		base = RELOC(alloc_bottom);
+		base = alloc_bottom;
 
-	for(; (base + size) <= RELOC(alloc_top); 
+	for(; (base + size) <= alloc_top; 
 	    base = _ALIGN_UP(base + 0x100000, align)) {
 		prom_debug("    trying: 0x%x\n\r", base);
 		addr = (unsigned long)prom_claim(base, size, 0);
@@ -1024,14 +1017,14 @@ static unsigned long __init alloc_up(uns
 	}
 	if (addr == 0)
 		return 0;
-	RELOC(alloc_bottom) = addr + size;
+	alloc_bottom = addr + size;
 
 	prom_debug(" -> %x\n", addr);
-	prom_debug("  alloc_bottom : %x\n", RELOC(alloc_bottom));
-	prom_debug("  alloc_top    : %x\n", RELOC(alloc_top));
-	prom_debug("  alloc_top_hi : %x\n", RELOC(alloc_top_high));
-	prom_debug("  rmo_top      : %x\n", RELOC(rmo_top));
-	prom_debug("  ram_top      : %x\n", RELOC(ram_top));
+	prom_debug("  alloc_bottom : %x\n", alloc_bottom);
+	prom_debug("  alloc_top    : %x\n", alloc_top);
+	prom_debug("  alloc_top_hi : %x\n", alloc_top_high);
+	prom_debug("  rmo_top      : %x\n", rmo_top);
+	prom_debug("  ram_top      : %x\n", ram_top);
 
 	return addr;
 }
@@ -1047,32 +1040,32 @@ static unsigned long __init alloc_down(u
 	unsigned long base, addr = 0;
 
 	prom_debug("alloc_down(%x, %x, %s)\n", size, align,
-		   highmem ? RELOC("(high)") : RELOC("(low)"));
-	if (RELOC(ram_top) == 0)
+		   highmem ? "(high)" : "(low)");
+	if (ram_top == 0)
 		prom_panic("alloc_down() called with mem not initialized\n");
 
 	if (highmem) {
 		/* Carve out storage for the TCE table. */
-		addr = _ALIGN_DOWN(RELOC(alloc_top_high) - size, align);
-		if (addr <= RELOC(alloc_bottom))
+		addr = _ALIGN_DOWN(alloc_top_high - size, align);
+		if (addr <= alloc_bottom)
 			return 0;
 		/* Will we bump into the RMO ? If yes, check out that we
 		 * didn't overlap existing allocations there, if we did,
 		 * we are dead, we must be the first in town !
 		 */
-		if (addr < RELOC(rmo_top)) {
+		if (addr < rmo_top) {
 			/* Good, we are first */
-			if (RELOC(alloc_top) == RELOC(rmo_top))
-				RELOC(alloc_top) = RELOC(rmo_top) = addr;
+			if (alloc_top == rmo_top)
+				alloc_top = rmo_top = addr;
 			else
 				return 0;
 		}
-		RELOC(alloc_top_high) = addr;
+		alloc_top_high = addr;
 		goto bail;
 	}
 
-	base = _ALIGN_DOWN(RELOC(alloc_top) - size, align);
-	for (; base > RELOC(alloc_bottom);
+	base = _ALIGN_DOWN(alloc_top - size, align);
+	for (; base > alloc_bottom;
 	     base = _ALIGN_DOWN(base - 0x100000, align))  {
 		prom_debug("    trying: 0x%x\n\r", base);
 		addr = (unsigned long)prom_claim(base, size, 0);
@@ -1082,15 +1075,15 @@ static unsigned long __init alloc_down(u
 	}
 	if (addr == 0)
 		return 0;
-	RELOC(alloc_top) = addr;
+	alloc_top = addr;
 
  bail:
 	prom_debug(" -> %x\n", addr);
-	prom_debug("  alloc_bottom : %x\n", RELOC(alloc_bottom));
-	prom_debug("  alloc_top    : %x\n", RELOC(alloc_top));
-	prom_debug("  alloc_top_hi : %x\n", RELOC(alloc_top_high));
-	prom_debug("  rmo_top      : %x\n", RELOC(rmo_top));
-	prom_debug("  ram_top      : %x\n", RELOC(ram_top));
+	prom_debug("  alloc_bottom : %x\n", alloc_bottom);
+	prom_debug("  alloc_top    : %x\n", alloc_top);
+	prom_debug("  alloc_top_hi : %x\n", alloc_top_high);
+	prom_debug("  rmo_top      : %x\n", rmo_top);
+	prom_debug("  ram_top      : %x\n", ram_top);
 
 	return addr;
 }
@@ -1130,7 +1123,7 @@ static unsigned long __init prom_next_ce
 static void __init reserve_mem(u64 base, u64 size)
 {
 	u64 top = base + size;
-	unsigned long cnt = RELOC(mem_reserve_cnt);
+	unsigned long cnt = mem_reserve_cnt;
 
 	if (size == 0)
 		return;
@@ -1145,9 +1138,9 @@ static void __init reserve_mem(u64 base,
 
 	if (cnt >= (MEM_RESERVE_MAP_SIZE - 1))
 		prom_panic("Memory reserve map exhausted !\n");
-	RELOC(mem_reserve_map)[cnt].base = base;
-	RELOC(mem_reserve_map)[cnt].size = size;
-	RELOC(mem_reserve_cnt) = cnt + 1;
+	mem_reserve_map[cnt].base = base;
+	mem_reserve_map[cnt].size = size;
+	mem_reserve_cnt = cnt + 1;
 }
 
 /*
@@ -1160,7 +1153,6 @@ static void __init prom_init_mem(void)
 	char *path, type[64];
 	unsigned int plen;
 	cell_t *p, *endp;
-	struct prom_t *_prom = &RELOC(prom);
 	u32 rac, rsc;
 
 	/*
@@ -1169,14 +1161,14 @@ static void __init prom_init_mem(void)
 	 * 2) top of memory
 	 */
 	rac = 2;
-	prom_getprop(_prom->root, "#address-cells", &rac, sizeof(rac));
+	prom_getprop(prom.root, "#address-cells", &rac, sizeof(rac));
 	rsc = 1;
-	prom_getprop(_prom->root, "#size-cells", &rsc, sizeof(rsc));
+	prom_getprop(prom.root, "#size-cells", &rsc, sizeof(rsc));
 	prom_debug("root_addr_cells: %x\n", (unsigned long) rac);
 	prom_debug("root_size_cells: %x\n", (unsigned long) rsc);
 
 	prom_debug("scanning memory:\n");
-	path = RELOC(prom_scratch);
+	path = prom_scratch;
 
 	for (node = 0; prom_next_node(&node); ) {
 		type[0] = 0;
@@ -1189,15 +1181,15 @@ static void __init prom_init_mem(void)
 			 */
 			prom_getprop(node, "name", type, sizeof(type));
 		}
-		if (strcmp(type, RELOC("memory")))
+		if (strcmp(type, "memory"))
 			continue;
 
-		plen = prom_getprop(node, "reg", RELOC(regbuf), sizeof(regbuf));
+		plen = prom_getprop(node, "reg", regbuf, sizeof(regbuf));
 		if (plen > sizeof(regbuf)) {
 			prom_printf("memory node too large for buffer !\n");
 			plen = sizeof(regbuf);
 		}
-		p = RELOC(regbuf);
+		p = regbuf;
 		endp = p + (plen / sizeof(cell_t));
 
 #ifdef DEBUG_PROM
@@ -1215,14 +1207,14 @@ static void __init prom_init_mem(void)
 			if (size == 0)
 				continue;
 			prom_debug("    %x %x\n", base, size);
-			if (base == 0 && (RELOC(of_platform) & PLATFORM_LPAR))
-				RELOC(rmo_top) = size;
-			if ((base + size) > RELOC(ram_top))
-				RELOC(ram_top) = base + size;
+			if (base == 0 && (of_platform & PLATFORM_LPAR))
+				rmo_top = size;
+			if ((base + size) > ram_top)
+				ram_top = base + size;
 		}
 	}
 
-	RELOC(alloc_bottom) = PAGE_ALIGN((unsigned long)&RELOC(_end) + 0x4000);
+	alloc_bottom = PAGE_ALIGN((unsigned long)&_end + 0x4000);
 
 	/*
 	 * If prom_memory_limit is set we reduce the upper limits *except* for
@@ -1230,20 +1222,20 @@ static void __init prom_init_mem(void)
 	 * TCE's up there.
 	 */
 
-	RELOC(alloc_top_high) = RELOC(ram_top);
+	alloc_top_high = ram_top;
 
-	if (RELOC(prom_memory_limit)) {
-		if (RELOC(prom_memory_limit) <= RELOC(alloc_bottom)) {
+	if (prom_memory_limit) {
+		if (prom_memory_limit <= alloc_bottom) {
 			prom_printf("Ignoring mem=%x <= alloc_bottom.\n",
-				RELOC(prom_memory_limit));
-			RELOC(prom_memory_limit) = 0;
-		} else if (RELOC(prom_memory_limit) >= RELOC(ram_top)) {
+				prom_memory_limit);
+			prom_memory_limit = 0;
+		} else if (prom_memory_limit >= ram_top) {
 			prom_printf("Ignoring mem=%x >= ram_top.\n",
-				RELOC(prom_memory_limit));
-			RELOC(prom_memory_limit) = 0;
+				prom_memory_limit);
+			prom_memory_limit = 0;
 		} else {
-			RELOC(ram_top) = RELOC(prom_memory_limit);
-			RELOC(rmo_top) = min(RELOC(rmo_top), RELOC(prom_memory_limit));
+			ram_top = prom_memory_limit;
+			rmo_top = min(rmo_top, prom_memory_limit);
 		}
 	}
 
@@ -1255,36 +1247,35 @@ static void __init prom_init_mem(void)
 	 * Since 768MB is plenty of room, and we need to cap to something
 	 * reasonable on 32-bit, cap at 768MB on all machines.
 	 */
-	if (!RELOC(rmo_top))
-		RELOC(rmo_top) = RELOC(ram_top);
-	RELOC(rmo_top) = min(0x30000000ul, RELOC(rmo_top));
-	RELOC(alloc_top) = RELOC(rmo_top);
-	RELOC(alloc_top_high) = RELOC(ram_top);
+	if (!rmo_top)
+		rmo_top = ram_top;
+	rmo_top = min(0x30000000ul, rmo_top);
+	alloc_top = rmo_top;
+	alloc_top_high = ram_top;
 
 	/*
 	 * Check if we have an initrd after the kernel but still inside
 	 * the RMO.  If we do move our bottom point to after it.
 	 */
-	if (RELOC(prom_initrd_start) &&
-	    RELOC(prom_initrd_start) < RELOC(rmo_top) &&
-	    RELOC(prom_initrd_end) > RELOC(alloc_bottom))
-		RELOC(alloc_bottom) = PAGE_ALIGN(RELOC(prom_initrd_end));
+	if (prom_initrd_start &&
+	    prom_initrd_start < rmo_top &&
+	    prom_initrd_end > alloc_bottom)
+		alloc_bottom = PAGE_ALIGN(prom_initrd_end);
 
 	prom_printf("memory layout at init:\n");
-	prom_printf("  memory_limit : %x (16 MB aligned)\n", RELOC(prom_memory_limit));
-	prom_printf("  alloc_bottom : %x\n", RELOC(alloc_bottom));
-	prom_printf("  alloc_top    : %x\n", RELOC(alloc_top));
-	prom_printf("  alloc_top_hi : %x\n", RELOC(alloc_top_high));
-	prom_printf("  rmo_top      : %x\n", RELOC(rmo_top));
-	prom_printf("  ram_top      : %x\n", RELOC(ram_top));
+	prom_printf("  memory_limit : %x (16 MB aligned)\n", prom_memory_limit);
+	prom_printf("  alloc_bottom : %x\n", alloc_bottom);
+	prom_printf("  alloc_top    : %x\n", alloc_top);
+	prom_printf("  alloc_top_hi : %x\n", alloc_top_high);
+	prom_printf("  rmo_top      : %x\n", rmo_top);
+	prom_printf("  ram_top      : %x\n", ram_top);
 }
 
 static void __init prom_close_stdin(void)
 {
-	struct prom_t *_prom = &RELOC(prom);
 	ihandle val;
 
-	if (prom_getprop(_prom->chosen, "stdin", &val, sizeof(val)) > 0)
+	if (prom_getprop(prom.chosen, "stdin", &val, sizeof(val)) > 0)
 		call_prom("close", 1, 0, val);
 }
 
@@ -1325,19 +1316,19 @@ static void __init prom_query_opal(void)
 	}
 
 	prom_printf("Querying for OPAL presence... ");
-	rc = opal_query_takeover(&RELOC(prom_opal_size),
-				 &RELOC(prom_opal_align));
+	rc = opal_query_takeover(&prom_opal_size,
+				 &prom_opal_align);
 	prom_debug("(rc = %ld) ", rc);
 	if (rc != 0) {
 		prom_printf("not there.\n");
 		return;
 	}
-	RELOC(of_platform) = PLATFORM_OPAL;
+	of_platform = PLATFORM_OPAL;
 	prom_printf(" there !\n");
-	prom_debug("  opal_size  = 0x%lx\n", RELOC(prom_opal_size));
-	prom_debug("  opal_align = 0x%lx\n", RELOC(prom_opal_align));
-	if (RELOC(prom_opal_align) < 0x10000)
-		RELOC(prom_opal_align) = 0x10000;
+	prom_debug("  opal_size  = 0x%lx\n", prom_opal_size);
+	prom_debug("  opal_align = 0x%lx\n", prom_opal_align);
+	if (prom_opal_align < 0x10000)
+		prom_opal_align = 0x10000;
 }
 
 static int prom_rtas_call(int token, int nargs, int nret, int *outputs, ...)
@@ -1358,8 +1349,8 @@ static int prom_rtas_call(int token, int
 	for (i = 0; i < nret; ++i)
 		rtas_args.rets[i] = 0;
 
-	opal_enter_rtas(&rtas_args, RELOC(prom_rtas_data),
-			RELOC(prom_rtas_entry));
+	opal_enter_rtas(&rtas_args, prom_rtas_data,
+			prom_rtas_entry);
 
 	if (nret > 1 && outputs != NULL)
 		for (i = 0; i < nret-1; ++i)
@@ -1374,9 +1365,8 @@ static void __init prom_opal_hold_cpus(v
 	phandle node;
 	char type[64];
 	u32 servers[8];
-	struct prom_t *_prom = &RELOC(prom);
-	void *entry = (unsigned long *)&RELOC(opal_secondary_entry);
-	struct opal_secondary_data *data = &RELOC(opal_secondary_data);
+	void *entry = (unsigned long *)&opal_secondary_entry;
+	struct opal_secondary_data *data = &opal_secondary_data;
 
 	prom_debug("prom_opal_hold_cpus: start...\n");
 	prom_debug("    - entry       = 0x%x\n", entry);
@@ -1389,12 +1379,12 @@ static void __init prom_opal_hold_cpus(v
 	for (node = 0; prom_next_node(&node); ) {
 		type[0] = 0;
 		prom_getprop(node, "device_type", type, sizeof(type));
-		if (strcmp(type, RELOC("cpu")) != 0)
+		if (strcmp(type, "cpu") != 0)
 			continue;
 
 		/* Skip non-configured cpus. */
 		if (prom_getprop(node, "status", type, sizeof(type)) > 0)
-			if (strcmp(type, RELOC("okay")) != 0)
+			if (strcmp(type, "okay") != 0)
 				continue;
 
 		cnt = prom_getprop(node, "ibm,ppc-interrupt-server#s", servers,
@@ -1405,7 +1395,7 @@ static void __init prom_opal_hold_cpus(v
 		for (i = 0; i < cnt; i++) {
 			cpu = servers[i];
 			prom_debug("CPU %d ... ", cpu);
-			if (cpu == _prom->cpu) {
+			if (cpu == prom.cpu) {
 				prom_debug("booted !\n");
 				continue;
 			}
@@ -1416,7 +1406,7 @@ static void __init prom_opal_hold_cpus(v
 			 * spinloop.
 			 */
 			data->ack = -1;
-			rc = prom_rtas_call(RELOC(prom_rtas_start_cpu), 3, 1,
+			rc = prom_rtas_call(prom_rtas_start_cpu, 3, 1,
 					    NULL, cpu, entry, data);
 			prom_debug("rtas rc=%d ...", rc);
 
@@ -1436,21 +1426,21 @@ static void __init prom_opal_hold_cpus(v
 
 static void __init prom_opal_takeover(void)
 {
-	struct opal_secondary_data *data = &RELOC(opal_secondary_data);
+	struct opal_secondary_data *data = &opal_secondary_data;
 	struct opal_takeover_args *args = &data->args;
-	u64 align = RELOC(prom_opal_align);
+	u64 align = prom_opal_align;
 	u64 top_addr, opal_addr;
 
-	args->k_image	= (u64)RELOC(_stext);
+	args->k_image	= (u64)_stext;
 	args->k_size	= _end - _stext;
 	args->k_entry	= 0;
 	args->k_entry2	= 0x60;
 
 	top_addr = _ALIGN_UP(args->k_size, align);
 
-	if (RELOC(prom_initrd_start) != 0) {
-		args->rd_image = RELOC(prom_initrd_start);
-		args->rd_size = RELOC(prom_initrd_end) - args->rd_image;
+	if (prom_initrd_start != 0) {
+		args->rd_image = prom_initrd_start;
+		args->rd_size = prom_initrd_end - args->rd_image;
 		args->rd_loc = top_addr;
 		top_addr = _ALIGN_UP(args->rd_loc + args->rd_size, align);
 	}
@@ -1462,13 +1452,13 @@ static void __init prom_opal_takeover(vo
 	 * has plenty of memory, and we ask for the HAL for now to
 	 * be just below the 1G point, or above the initrd
 	 */
-	opal_addr = _ALIGN_DOWN(0x40000000 - RELOC(prom_opal_size), align);
+	opal_addr = _ALIGN_DOWN(0x40000000 - prom_opal_size, align);
 	if (opal_addr < top_addr)
 		opal_addr = top_addr;
 	args->hal_addr = opal_addr;
 
 	/* Copy the command line to the kernel image */
-	strlcpy(RELOC(boot_command_line), RELOC(prom_cmd_line),
+	strlcpy(boot_command_line, prom_cmd_line,
 		COMMAND_LINE_SIZE);
 
 	prom_debug("  k_image    = 0x%lx\n", args->k_image);
@@ -1550,8 +1540,8 @@ static void __init prom_instantiate_opal
 		     &entry, sizeof(entry));
 
 #ifdef CONFIG_PPC_EARLY_DEBUG_OPAL
-	RELOC(prom_opal_base) = base;
-	RELOC(prom_opal_entry) = entry;
+	prom_opal_base = base;
+	prom_opal_entry = entry;
 #endif
 	prom_debug("prom_instantiate_opal: end...\n");
 }
@@ -1609,9 +1599,9 @@ static void __init prom_instantiate_rtas
 
 #ifdef CONFIG_PPC_POWERNV
 	/* PowerVN takeover hack */
-	RELOC(prom_rtas_data) = base;
-	RELOC(prom_rtas_entry) = entry;
-	prom_getprop(rtas_node, "start-cpu", &RELOC(prom_rtas_start_cpu), 4);
+	prom_rtas_data = base;
+	prom_rtas_entry = entry;
+	prom_getprop(rtas_node, "start-cpu", &prom_rtas_start_cpu, 4);
 #endif
 	prom_debug("rtas base     = 0x%x\n", base);
 	prom_debug("rtas entry    = 0x%x\n", entry);
@@ -1686,20 +1676,20 @@ static void __init prom_initialize_tce_t
 	phandle node;
 	ihandle phb_node;
 	char compatible[64], type[64], model[64];
-	char *path = RELOC(prom_scratch);
+	char *path = prom_scratch;
 	u64 base, align;
 	u32 minalign, minsize;
 	u64 tce_entry, *tce_entryp;
 	u64 local_alloc_top, local_alloc_bottom;
 	u64 i;
 
-	if (RELOC(prom_iommu_off))
+	if (prom_iommu_off)
 		return;
 
 	prom_debug("starting prom_initialize_tce_table\n");
 
 	/* Cache current top of allocs so we reserve a single block */
-	local_alloc_top = RELOC(alloc_top_high);
+	local_alloc_top = alloc_top_high;
 	local_alloc_bottom = local_alloc_top;
 
 	/* Search all nodes looking for PHBs. */
@@ -1712,19 +1702,19 @@ static void __init prom_initialize_tce_t
 		prom_getprop(node, "device_type", type, sizeof(type));
 		prom_getprop(node, "model", model, sizeof(model));
 
-		if ((type[0] == 0) || (strstr(type, RELOC("pci")) == NULL))
+		if ((type[0] == 0) || (strstr(type, "pci") == NULL))
 			continue;
 
 		/* Keep the old logic intact to avoid regression. */
 		if (compatible[0] != 0) {
-			if ((strstr(compatible, RELOC("python")) == NULL) &&
-			    (strstr(compatible, RELOC("Speedwagon")) == NULL) &&
-			    (strstr(compatible, RELOC("Winnipeg")) == NULL))
+			if ((strstr(compatible, "python") == NULL) &&
+			    (strstr(compatible, "Speedwagon") == NULL) &&
+			    (strstr(compatible, "Winnipeg") == NULL))
 				continue;
 		} else if (model[0] != 0) {
-			if ((strstr(model, RELOC("ython")) == NULL) &&
-			    (strstr(model, RELOC("peedwagon")) == NULL) &&
-			    (strstr(model, RELOC("innipeg")) == NULL))
+			if ((strstr(model, "ython") == NULL) &&
+			    (strstr(model, "peedwagon") == NULL) &&
+			    (strstr(model, "innipeg") == NULL))
 				continue;
 		}
 
@@ -1803,8 +1793,8 @@ static void __init prom_initialize_tce_t
 
 	/* These are only really needed if there is a memory limit in
 	 * effect, but we don't know so export them always. */
-	RELOC(prom_tce_alloc_start) = local_alloc_bottom;
-	RELOC(prom_tce_alloc_end) = local_alloc_top;
+	prom_tce_alloc_start = local_alloc_bottom;
+	prom_tce_alloc_end = local_alloc_top;
 
 	/* Flag the first invalid entry */
 	prom_debug("ending prom_initialize_tce_table\n");
@@ -1841,7 +1831,6 @@ static void __init prom_hold_cpus(void)
 	unsigned int reg;
 	phandle node;
 	char type[64];
-	struct prom_t *_prom = &RELOC(prom);
 	unsigned long *spinloop
 		= (void *) LOW_ADDR(__secondary_hold_spinloop);
 	unsigned long *acknowledge
@@ -1867,12 +1856,12 @@ static void __init prom_hold_cpus(void)
 	for (node = 0; prom_next_node(&node); ) {
 		type[0] = 0;
 		prom_getprop(node, "device_type", type, sizeof(type));
-		if (strcmp(type, RELOC("cpu")) != 0)
+		if (strcmp(type, "cpu") != 0)
 			continue;
 
 		/* Skip non-configured cpus. */
 		if (prom_getprop(node, "status", type, sizeof(type)) > 0)
-			if (strcmp(type, RELOC("okay")) != 0)
+			if (strcmp(type, "okay") != 0)
 				continue;
 
 		reg = -1;
@@ -1886,7 +1875,7 @@ static void __init prom_hold_cpus(void)
 		 */
 		*acknowledge = (unsigned long)-1;
 
-		if (reg != _prom->cpu) {
+		if (reg != prom.cpu) {
 			/* Primary Thread of non-boot cpu or any thread */
 			prom_printf("starting cpu hw idx %lu... ", reg);
 			call_prom("start-cpu", 3, 0, node,
@@ -1913,22 +1902,20 @@ static void __init prom_hold_cpus(void)
 
 static void __init prom_init_client_services(unsigned long pp)
 {
-	struct prom_t *_prom = &RELOC(prom);
-
 	/* Get a handle to the prom entry point before anything else */
-	RELOC(prom_entry) = pp;
+	prom_entry = pp;
 
 	/* get a handle for the stdout device */
-	_prom->chosen = call_prom("finddevice", 1, 1, ADDR("/chosen"));
-	if (!PHANDLE_VALID(_prom->chosen))
+	prom.chosen = call_prom("finddevice", 1, 1, ADDR("/chosen"));
+	if (!PHANDLE_VALID(prom.chosen))
 		prom_panic("cannot find chosen"); /* msg won't be printed :( */
 
 	/* get device tree root */
-	_prom->root = call_prom("finddevice", 1, 1, ADDR("/"));
-	if (!PHANDLE_VALID(_prom->root))
+	prom.root = call_prom("finddevice", 1, 1, ADDR("/"));
+	if (!PHANDLE_VALID(prom.root))
 		prom_panic("cannot find device tree root"); /* msg won't be printed :( */
 
-	_prom->mmumap = 0;
+	prom.mmumap = 0;
 }
 
 #ifdef CONFIG_PPC32
@@ -1939,7 +1926,6 @@ static void __init prom_init_client_serv
  */
 static void __init prom_find_mmu(void)
 {
-	struct prom_t *_prom = &RELOC(prom);
 	phandle oprom;
 	char version[64];
 
@@ -1957,10 +1943,10 @@ static void __init prom_find_mmu(void)
 		call_prom("interpret", 1, 1, "dev /memory 0 to allow-reclaim");
 	} else
 		return;
-	_prom->memory = call_prom("open", 1, 1, ADDR("/memory"));
-	prom_getprop(_prom->chosen, "mmu", &_prom->mmumap,
-		     sizeof(_prom->mmumap));
-	if (!IHANDLE_VALID(_prom->memory) || !IHANDLE_VALID(_prom->mmumap))
+	prom.memory = call_prom("open", 1, 1, ADDR("/memory"));
+	prom_getprop(prom.chosen, "mmu", &prom.mmumap,
+		     sizeof(prom.mmumap));
+	if (!IHANDLE_VALID(prom.memory) || !IHANDLE_VALID(prom.mmumap))
 		of_workarounds &= ~OF_WA_CLAIM;		/* hmmm */
 }
 #else
@@ -1969,36 +1955,34 @@ static void __init prom_find_mmu(void)
 
 static void __init prom_init_stdout(void)
 {
-	struct prom_t *_prom = &RELOC(prom);
-	char *path = RELOC(of_stdout_device);
+	char *path = of_stdout_device;
 	char type[16];
 	u32 val;
 
-	if (prom_getprop(_prom->chosen, "stdout", &val, sizeof(val)) <= 0)
+	if (prom_getprop(prom.chosen, "stdout", &val, sizeof(val)) <= 0)
 		prom_panic("cannot find stdout");
 
-	_prom->stdout = val;
+	prom.stdout = val;
 
 	/* Get the full OF pathname of the stdout device */
 	memset(path, 0, 256);
-	call_prom("instance-to-path", 3, 1, _prom->stdout, path, 255);
-	val = call_prom("instance-to-package", 1, 1, _prom->stdout);
-	prom_setprop(_prom->chosen, "/chosen", "linux,stdout-package",
+	call_prom("instance-to-path", 3, 1, prom.stdout, path, 255);
+	val = call_prom("instance-to-package", 1, 1, prom.stdout);
+	prom_setprop(prom.chosen, "/chosen", "linux,stdout-package",
 		     &val, sizeof(val));
-	prom_printf("OF stdout device is: %s\n", RELOC(of_stdout_device));
-	prom_setprop(_prom->chosen, "/chosen", "linux,stdout-path",
+	prom_printf("OF stdout device is: %s\n", of_stdout_device);
+	prom_setprop(prom.chosen, "/chosen", "linux,stdout-path",
 		     path, strlen(path) + 1);
 
 	/* If it's a display, note it */
 	memset(type, 0, sizeof(type));
 	prom_getprop(val, "device_type", type, sizeof(type));
-	if (strcmp(type, RELOC("display")) == 0)
+	if (strcmp(type, "display") == 0)
 		prom_setprop(val, path, "linux,boot-display", NULL, 0);
 }
 
 static int __init prom_find_machine_type(void)
 {
-	struct prom_t *_prom = &RELOC(prom);
 	char compat[256];
 	int len, i = 0;
 #ifdef CONFIG_PPC64
@@ -2007,7 +1991,7 @@ static int __init prom_find_machine_type
 #endif
 
 	/* Look for a PowerMac or a Cell */
-	len = prom_getprop(_prom->root, "compatible",
+	len = prom_getprop(prom.root, "compatible",
 			   compat, sizeof(compat)-1);
 	if (len > 0) {
 		compat[len] = 0;
@@ -2016,16 +2000,16 @@ static int __init prom_find_machine_type
 			int sl = strlen(p);
 			if (sl == 0)
 				break;
-			if (strstr(p, RELOC("Power Macintosh")) ||
-			    strstr(p, RELOC("MacRISC")))
+			if (strstr(p, "Power Macintosh") ||
+			    strstr(p, "MacRISC"))
 				return PLATFORM_POWERMAC;
 #ifdef CONFIG_PPC64
 			/* We must make sure we don't detect the IBM Cell
 			 * blades as pSeries due to some firmware issues,
 			 * so we do it here.
 			 */
-			if (strstr(p, RELOC("IBM,CBEA")) ||
-			    strstr(p, RELOC("IBM,CPBW-1.0")))
+			if (strstr(p, "IBM,CBEA") ||
+			    strstr(p, "IBM,CPBW-1.0"))
 				return PLATFORM_GENERIC;
 #endif /* CONFIG_PPC64 */
 			i += sl + 1;
@@ -2042,11 +2026,11 @@ static int __init prom_find_machine_type
 	 *    non-IBM designs !
 	 *  - it has /rtas
 	 */
-	len = prom_getprop(_prom->root, "device_type",
+	len = prom_getprop(prom.root, "device_type",
 			   compat, sizeof(compat)-1);
 	if (len <= 0)
 		return PLATFORM_GENERIC;
-	if (strcmp(compat, RELOC("chrp")))
+	if (strcmp(compat, "chrp"))
 		return PLATFORM_GENERIC;
 
 	/* Default to pSeries. We need to know if we are running LPAR */
@@ -2108,11 +2092,11 @@ static void __init prom_check_displays(v
 	for (node = 0; prom_next_node(&node); ) {
 		memset(type, 0, sizeof(type));
 		prom_getprop(node, "device_type", type, sizeof(type));
-		if (strcmp(type, RELOC("display")) != 0)
+		if (strcmp(type, "display") != 0)
 			continue;
 
 		/* It seems OF doesn't null-terminate the path :-( */
-		path = RELOC(prom_scratch);
+		path = prom_scratch;
 		memset(path, 0, PROM_SCRATCH_SIZE);
 
 		/*
@@ -2136,15 +2120,15 @@ static void __init prom_check_displays(v
 
 		/* Setup a usable color table when the appropriate
 		 * method is available. Should update this to set-colors */
-		clut = RELOC(default_colors);
+		clut = default_colors;
 		for (i = 0; i < 16; i++, clut += 3)
 			if (prom_set_color(ih, i, clut[0], clut[1],
 					   clut[2]) != 0)
 				break;
 
 #ifdef CONFIG_LOGO_LINUX_CLUT224
-		clut = PTRRELOC(RELOC(logo_linux_clut224.clut));
-		for (i = 0; i < RELOC(logo_linux_clut224.clutsize); i++, clut += 3)
+		clut = PTRRELOC(logo_linux_clut224.clut);
+		for (i = 0; i < logo_linux_clut224.clutsize; i++, clut += 3)
 			if (prom_set_color(ih, i + 32, clut[0], clut[1],
 					   clut[2]) != 0)
 				break;
@@ -2164,8 +2148,8 @@ static void __init *make_room(unsigned l
 		unsigned long room, chunk;
 
 		prom_debug("Chunk exhausted, claiming more at %x...\n",
-			   RELOC(alloc_bottom));
-		room = RELOC(alloc_top) - RELOC(alloc_bottom);
+			   alloc_bottom);
+		room = alloc_top - alloc_bottom;
 		if (room > DEVTREE_CHUNK_SIZE)
 			room = DEVTREE_CHUNK_SIZE;
 		if (room < PAGE_SIZE)
@@ -2191,9 +2175,9 @@ static unsigned long __init dt_find_stri
 {
 	char *s, *os;
 
-	s = os = (char *)RELOC(dt_string_start);
+	s = os = (char *)dt_string_start;
 	s += 4;
-	while (s <  (char *)RELOC(dt_string_end)) {
+	while (s <  (char *)dt_string_end) {
 		if (strcmp(s, str) == 0)
 			return s - os;
 		s += strlen(s) + 1;
@@ -2215,10 +2199,10 @@ static void __init scan_dt_build_strings
 	unsigned long soff;
 	phandle child;
 
-	sstart =  (char *)RELOC(dt_string_start);
+	sstart =  (char *)dt_string_start;
 
 	/* get and store all property names */
-	prev_name = RELOC("");
+	prev_name = "";
 	for (;;) {
 		/* 64 is max len of name including nul. */
 		namep = make_room(mem_start, mem_end, MAX_PROPERTY_NAME, 1);
@@ -2229,9 +2213,9 @@ static void __init scan_dt_build_strings
 		}
 
  		/* skip "name" */
- 		if (strcmp(namep, RELOC("name")) == 0) {
+ 		if (strcmp(namep, "name") == 0) {
  			*mem_start = (unsigned long)namep;
- 			prev_name = RELOC("name");
+ 			prev_name = "name";
  			continue;
  		}
 		/* get/create string entry */
@@ -2242,7 +2226,7 @@ static void __init scan_dt_build_strings
 		} else {
 			/* Trim off some if we can */
 			*mem_start = (unsigned long)namep + strlen(namep) + 1;
-			RELOC(dt_string_end) = *mem_start;
+			dt_string_end = *mem_start;
 		}
 		prev_name = namep;
 	}
@@ -2297,35 +2281,35 @@ static void __init scan_dt_build_struct(
 	}
 
 	/* get it again for debugging */
-	path = RELOC(prom_scratch);
+	path = prom_scratch;
 	memset(path, 0, PROM_SCRATCH_SIZE);
 	call_prom("package-to-path", 3, 1, node, path, PROM_SCRATCH_SIZE-1);
 
 	/* get and store all properties */
-	prev_name = RELOC("");
-	sstart = (char *)RELOC(dt_string_start);
+	prev_name = "";
+	sstart = (char *)dt_string_start;
 	for (;;) {
 		if (call_prom("nextprop", 3, 1, node, prev_name,
-			      RELOC(pname)) != 1)
+			      pname) != 1)
 			break;
 
  		/* skip "name" */
- 		if (strcmp(RELOC(pname), RELOC("name")) == 0) {
- 			prev_name = RELOC("name");
+ 		if (strcmp(pname, "name") == 0) {
+ 			prev_name = "name";
  			continue;
  		}
 
 		/* find string offset */
-		soff = dt_find_string(RELOC(pname));
+		soff = dt_find_string(pname);
 		if (soff == 0) {
 			prom_printf("WARNING: Can't find string index for"
-				    " <%s>, node %s\n", RELOC(pname), path);
+				    " <%s>, node %s\n", pname, path);
 			break;
 		}
 		prev_name = sstart + soff;
 
 		/* get length */
-		l = call_prom("getproplen", 2, 1, node, RELOC(pname));
+		l = call_prom("getproplen", 2, 1, node, pname);
 
 		/* sanity checks */
 		if (l == PROM_ERROR)
@@ -2338,10 +2322,10 @@ static void __init scan_dt_build_struct(
 
 		/* push property content */
 		valp = make_room(mem_start, mem_end, l, 4);
-		call_prom("getprop", 4, 1, node, RELOC(pname), valp, l);
+		call_prom("getprop", 4, 1, node, pname, valp, l);
 		*mem_start = _ALIGN(*mem_start, 4);
 
-		if (!strcmp(RELOC(pname), RELOC("phandle")))
+		if (!strcmp(pname, "phandle"))
 			has_phandle = 1;
 	}
 
@@ -2349,7 +2333,7 @@ static void __init scan_dt_build_struct(
 	 * existed (can happen with OPAL)
 	 */
 	if (!has_phandle) {
-		soff = dt_find_string(RELOC("linux,phandle"));
+		soff = dt_find_string("linux,phandle");
 		if (soff == 0)
 			prom_printf("WARNING: Can't find string index for"
 				    " <linux-phandle> node %s\n", path);
@@ -2377,7 +2361,6 @@ static void __init flatten_device_tree(v
 	phandle root;
 	unsigned long mem_start, mem_end, room;
 	struct boot_param_header *hdr;
-	struct prom_t *_prom = &RELOC(prom);
 	char *namep;
 	u64 *rsvmap;
 
@@ -2385,10 +2368,10 @@ static void __init flatten_device_tree(v
 	 * Check how much room we have between alloc top & bottom (+/- a
 	 * few pages), crop to 1MB, as this is our "chunk" size
 	 */
-	room = RELOC(alloc_top) - RELOC(alloc_bottom) - 0x4000;
+	room = alloc_top - alloc_bottom - 0x4000;
 	if (room > DEVTREE_CHUNK_SIZE)
 		room = DEVTREE_CHUNK_SIZE;
-	prom_debug("starting device tree allocs at %x\n", RELOC(alloc_bottom));
+	prom_debug("starting device tree allocs at %x\n", alloc_bottom);
 
 	/* Now try to claim that */
 	mem_start = (unsigned long)alloc_up(room, PAGE_SIZE);
@@ -2405,66 +2388,66 @@ static void __init flatten_device_tree(v
 	mem_start = _ALIGN(mem_start, 4);
 	hdr = make_room(&mem_start, &mem_end,
 			sizeof(struct boot_param_header), 4);
-	RELOC(dt_header_start) = (unsigned long)hdr;
+	dt_header_start = (unsigned long)hdr;
 	rsvmap = make_room(&mem_start, &mem_end, sizeof(mem_reserve_map), 8);
 
 	/* Start of strings */
 	mem_start = PAGE_ALIGN(mem_start);
-	RELOC(dt_string_start) = mem_start;
+	dt_string_start = mem_start;
 	mem_start += 4; /* hole */
 
 	/* Add "linux,phandle" in there, we'll need it */
 	namep = make_room(&mem_start, &mem_end, 16, 1);
-	strcpy(namep, RELOC("linux,phandle"));
+	strcpy(namep, "linux,phandle");
 	mem_start = (unsigned long)namep + strlen(namep) + 1;
 
 	/* Build string array */
 	prom_printf("Building dt strings...\n"); 
 	scan_dt_build_strings(root, &mem_start, &mem_end);
-	RELOC(dt_string_end) = mem_start;
+	dt_string_end = mem_start;
 
 	/* Build structure */
 	mem_start = PAGE_ALIGN(mem_start);
-	RELOC(dt_struct_start) = mem_start;
+	dt_struct_start = mem_start;
 	prom_printf("Building dt structure...\n"); 
 	scan_dt_build_struct(root, &mem_start, &mem_end);
 	dt_push_token(OF_DT_END, &mem_start, &mem_end);
-	RELOC(dt_struct_end) = PAGE_ALIGN(mem_start);
+	dt_struct_end = PAGE_ALIGN(mem_start);
 
 	/* Finish header */
-	hdr->boot_cpuid_phys = _prom->cpu;
+	hdr->boot_cpuid_phys = prom.cpu;
 	hdr->magic = OF_DT_HEADER;
-	hdr->totalsize = RELOC(dt_struct_end) - RELOC(dt_header_start);
-	hdr->off_dt_struct = RELOC(dt_struct_start) - RELOC(dt_header_start);
-	hdr->off_dt_strings = RELOC(dt_string_start) - RELOC(dt_header_start);
-	hdr->dt_strings_size = RELOC(dt_string_end) - RELOC(dt_string_start);
-	hdr->off_mem_rsvmap = ((unsigned long)rsvmap) - RELOC(dt_header_start);
+	hdr->totalsize = dt_struct_end - dt_header_start;
+	hdr->off_dt_struct = dt_struct_start - dt_header_start;
+	hdr->off_dt_strings = dt_string_start - dt_header_start;
+	hdr->dt_strings_size = dt_string_end - dt_string_start;
+	hdr->off_mem_rsvmap = ((unsigned long)rsvmap) - dt_header_start;
 	hdr->version = OF_DT_VERSION;
 	/* Version 16 is not backward compatible */
 	hdr->last_comp_version = 0x10;
 
 	/* Copy the reserve map in */
-	memcpy(rsvmap, RELOC(mem_reserve_map), sizeof(mem_reserve_map));
+	memcpy(rsvmap, mem_reserve_map, sizeof(mem_reserve_map));
 
 #ifdef DEBUG_PROM
 	{
 		int i;
 		prom_printf("reserved memory map:\n");
-		for (i = 0; i < RELOC(mem_reserve_cnt); i++)
+		for (i = 0; i < mem_reserve_cnt; i++)
 			prom_printf("  %x - %x\n",
-				    RELOC(mem_reserve_map)[i].base,
-				    RELOC(mem_reserve_map)[i].size);
+				    mem_reserve_map[i].base,
+				    mem_reserve_map[i].size);
 	}
 #endif
 	/* Bump mem_reserve_cnt to cause further reservations to fail
 	 * since it's too late.
 	 */
-	RELOC(mem_reserve_cnt) = MEM_RESERVE_MAP_SIZE;
+	mem_reserve_cnt = MEM_RESERVE_MAP_SIZE;
 
 	prom_printf("Device tree strings 0x%x -> 0x%x\n",
-		    RELOC(dt_string_start), RELOC(dt_string_end)); 
+		    dt_string_start, dt_string_end);
 	prom_printf("Device tree struct  0x%x -> 0x%x\n",
-		    RELOC(dt_struct_start), RELOC(dt_struct_end));
+		    dt_struct_start, dt_struct_end);
 
 }
 
@@ -2519,7 +2502,6 @@ static void __init fixup_device_tree_map
 	phandle mc;
 	u32 mc_reg[4];
 	char *name = "/hostbridge@f8000000";
-	struct prom_t *_prom = &RELOC(prom);
 	u32 ac, sc;
 
 	mc = call_prom("finddevice", 1, 1, ADDR(name));
@@ -2529,8 +2511,8 @@ static void __init fixup_device_tree_map
 	if (prom_getproplen(mc, "reg") != 8)
 		return;
 
-	prom_getprop(_prom->root, "#address-cells", &ac, sizeof(ac));
-	prom_getprop(_prom->root, "#size-cells", &sc, sizeof(sc));
+	prom_getprop(prom.root, "#address-cells", &ac, sizeof(ac));
+	prom_getprop(prom.root, "#size-cells", &sc, sizeof(sc));
 	if ((ac != 2) || (sc != 2))
 		return;
 
@@ -2799,46 +2781,43 @@ static void __init fixup_device_tree(voi
 
 static void __init prom_find_boot_cpu(void)
 {
-	struct prom_t *_prom = &RELOC(prom);
 	u32 getprop_rval;
 	ihandle prom_cpu;
 	phandle cpu_pkg;
 
-	_prom->cpu = 0;
-	if (prom_getprop(_prom->chosen, "cpu", &prom_cpu, sizeof(prom_cpu)) <= 0)
+	prom.cpu = 0;
+	if (prom_getprop(prom.chosen, "cpu", &prom_cpu, sizeof(prom_cpu)) <= 0)
 		return;
 
 	cpu_pkg = call_prom("instance-to-package", 1, 1, prom_cpu);
 
 	prom_getprop(cpu_pkg, "reg", &getprop_rval, sizeof(getprop_rval));
-	_prom->cpu = getprop_rval;
+	prom.cpu = getprop_rval;
 
-	prom_debug("Booting CPU hw index = %lu\n", _prom->cpu);
+	prom_debug("Booting CPU hw index = %lu\n", prom.cpu);
 }
 
 static void __init prom_check_initrd(unsigned long r3, unsigned long r4)
 {
 #ifdef CONFIG_BLK_DEV_INITRD
-	struct prom_t *_prom = &RELOC(prom);
-
 	if (r3 && r4 && r4 != 0xdeadbeef) {
 		unsigned long val;
 
-		RELOC(prom_initrd_start) = is_kernel_addr(r3) ? __pa(r3) : r3;
-		RELOC(prom_initrd_end) = RELOC(prom_initrd_start) + r4;
+		prom_initrd_start = is_kernel_addr(r3) ? __pa(r3) : r3;
+		prom_initrd_end = prom_initrd_start + r4;
 
-		val = RELOC(prom_initrd_start);
-		prom_setprop(_prom->chosen, "/chosen", "linux,initrd-start",
+		val = prom_initrd_start;
+		prom_setprop(prom.chosen, "/chosen", "linux,initrd-start",
 			     &val, sizeof(val));
-		val = RELOC(prom_initrd_end);
-		prom_setprop(_prom->chosen, "/chosen", "linux,initrd-end",
+		val = prom_initrd_end;
+		prom_setprop(prom.chosen, "/chosen", "linux,initrd-end",
 			     &val, sizeof(val));
 
-		reserve_mem(RELOC(prom_initrd_start),
-			    RELOC(prom_initrd_end) - RELOC(prom_initrd_start));
+		reserve_mem(prom_initrd_start,
+			    prom_initrd_end - prom_initrd_start);
 
-		prom_debug("initrd_start=0x%x\n", RELOC(prom_initrd_start));
-		prom_debug("initrd_end=0x%x\n", RELOC(prom_initrd_end));
+		prom_debug("initrd_start=0x%x\n", prom_initrd_start);
+		prom_debug("initrd_end=0x%x\n", prom_initrd_end);
 	}
 #endif /* CONFIG_BLK_DEV_INITRD */
 }
@@ -2901,7 +2880,6 @@ unsigned long __init prom_init(unsigned
 			       unsigned long r6, unsigned long r7,
 			       unsigned long kbase)
 {	
-	struct prom_t *_prom;
 	unsigned long hdr;
 
 #ifdef CONFIG_PPC32
@@ -2911,12 +2889,10 @@ unsigned long __init prom_init(unsigned
 	reloc_toc();
 #endif
 
-	_prom = &RELOC(prom);
-
 	/*
 	 * First zero the BSS
 	 */
-	memset(&RELOC(__bss_start), 0, __bss_stop - __bss_start);
+	memset(&__bss_start, 0, __bss_stop - __bss_start);
 
 	/*
 	 * Init interface to Open Firmware, get some node references,
@@ -2935,14 +2911,14 @@ unsigned long __init prom_init(unsigned
 	 */
 	prom_init_stdout();
 
-	prom_printf("Preparing to boot %s", RELOC(linux_banner));
+	prom_printf("Preparing to boot %s", linux_banner);
 
 	/*
 	 * Get default machine type. At this point, we do not differentiate
 	 * between pSeries SMP and pSeries LPAR
 	 */
-	RELOC(of_platform) = prom_find_machine_type();
-	prom_printf("Detected machine type: %x\n", RELOC(of_platform));
+	of_platform = prom_find_machine_type();
+	prom_printf("Detected machine type: %x\n", of_platform);
 
 #ifndef CONFIG_NONSTATIC_KERNEL
 	/* Bail if this is a kdump kernel. */
@@ -2959,15 +2935,15 @@ unsigned long __init prom_init(unsigned
 	/*
 	 * On pSeries, inform the firmware about our capabilities
 	 */
-	if (RELOC(of_platform) == PLATFORM_PSERIES ||
-	    RELOC(of_platform) == PLATFORM_PSERIES_LPAR)
+	if (of_platform == PLATFORM_PSERIES ||
+	    of_platform == PLATFORM_PSERIES_LPAR)
 		prom_send_capabilities();
 #endif
 
 	/*
 	 * Copy the CPU hold code
 	 */
-	if (RELOC(of_platform) != PLATFORM_POWERMAC)
+	if (of_platform != PLATFORM_POWERMAC)
 		copy_and_flush(0, kbase, 0x100, 0);
 
 	/*
@@ -2996,7 +2972,7 @@ unsigned long __init prom_init(unsigned
 	 * that uses the allocator, we need to make sure we get the top of memory
 	 * available for us here...
 	 */
-	if (RELOC(of_platform) == PLATFORM_PSERIES)
+	if (of_platform == PLATFORM_PSERIES)
 		prom_initialize_tce_table();
 #endif
 
@@ -3004,19 +2980,19 @@ unsigned long __init prom_init(unsigned
 	 * On non-powermacs, try to instantiate RTAS. PowerMacs don't
 	 * have a usable RTAS implementation.
 	 */
-	if (RELOC(of_platform) != PLATFORM_POWERMAC &&
-	    RELOC(of_platform) != PLATFORM_OPAL)
+	if (of_platform != PLATFORM_POWERMAC &&
+	    of_platform != PLATFORM_OPAL)
 		prom_instantiate_rtas();
 
 #ifdef CONFIG_PPC_POWERNV
 	/* Detect HAL and try instanciating it & doing takeover */
-	if (RELOC(of_platform) == PLATFORM_PSERIES_LPAR) {
+	if (of_platform == PLATFORM_PSERIES_LPAR) {
 		prom_query_opal();
-		if (RELOC(of_platform) == PLATFORM_OPAL) {
+		if (of_platform == PLATFORM_OPAL) {
 			prom_opal_hold_cpus();
 			prom_opal_takeover();
 		}
-	} else if (RELOC(of_platform) == PLATFORM_OPAL)
+	} else if (of_platform == PLATFORM_OPAL)
 		prom_instantiate_opal();
 #endif
 
@@ -3030,32 +3006,32 @@ unsigned long __init prom_init(unsigned
 	 *
 	 * PowerMacs use a different mechanism to spin CPUs
 	 */
-	if (RELOC(of_platform) != PLATFORM_POWERMAC &&
-	    RELOC(of_platform) != PLATFORM_OPAL)
+	if (of_platform != PLATFORM_POWERMAC &&
+	    of_platform != PLATFORM_OPAL)
 		prom_hold_cpus();
 
 	/*
 	 * Fill in some infos for use by the kernel later on
 	 */
-	if (RELOC(prom_memory_limit))
-		prom_setprop(_prom->chosen, "/chosen", "linux,memory-limit",
-			     &RELOC(prom_memory_limit),
+	if (prom_memory_limit)
+		prom_setprop(prom.chosen, "/chosen", "linux,memory-limit",
+			     &prom_memory_limit,
 			     sizeof(prom_memory_limit));
 #ifdef CONFIG_PPC64
-	if (RELOC(prom_iommu_off))
-		prom_setprop(_prom->chosen, "/chosen", "linux,iommu-off",
+	if (prom_iommu_off)
+		prom_setprop(prom.chosen, "/chosen", "linux,iommu-off",
 			     NULL, 0);
 
-	if (RELOC(prom_iommu_force_on))
-		prom_setprop(_prom->chosen, "/chosen", "linux,iommu-force-on",
+	if (prom_iommu_force_on)
+		prom_setprop(prom.chosen, "/chosen", "linux,iommu-force-on",
 			     NULL, 0);
 
-	if (RELOC(prom_tce_alloc_start)) {
-		prom_setprop(_prom->chosen, "/chosen", "linux,tce-alloc-start",
-			     &RELOC(prom_tce_alloc_start),
+	if (prom_tce_alloc_start) {
+		prom_setprop(prom.chosen, "/chosen", "linux,tce-alloc-start",
+			     &prom_tce_alloc_start,
 			     sizeof(prom_tce_alloc_start));
-		prom_setprop(_prom->chosen, "/chosen", "linux,tce-alloc-end",
-			     &RELOC(prom_tce_alloc_end),
+		prom_setprop(prom.chosen, "/chosen", "linux,tce-alloc-end",
+			     &prom_tce_alloc_end,
 			     sizeof(prom_tce_alloc_end));
 	}
 #endif
@@ -3077,8 +3053,8 @@ unsigned long __init prom_init(unsigned
 	 * closed stdin already (in particular the powerbook 101). It
 	 * appears that the OPAL version of OFW doesn't like it either.
 	 */
-	if (RELOC(of_platform) != PLATFORM_POWERMAC &&
-	    RELOC(of_platform) != PLATFORM_OPAL)
+	if (of_platform != PLATFORM_POWERMAC &&
+	    of_platform != PLATFORM_OPAL)
 		prom_close_stdin();
 
 	/*
@@ -3093,10 +3069,10 @@ unsigned long __init prom_init(unsigned
 	 * tree and NULL as r5, thus triggering the new entry point which
 	 * is common to us and kexec
 	 */
-	hdr = RELOC(dt_header_start);
+	hdr = dt_header_start;
 
 	/* Don't print anything after quiesce under OPAL, it crashes OFW */
-	if (RELOC(of_platform) != PLATFORM_OPAL) {
+	if (of_platform != PLATFORM_OPAL) {
 		prom_printf("returning from prom_init\n");
 		prom_debug("->dt_header_start=0x%x\n", hdr);
 	}
@@ -3110,7 +3086,7 @@ unsigned long __init prom_init(unsigned
 #ifdef CONFIG_PPC_EARLY_DEBUG_OPAL
 	/* OPAL early debug gets the OPAL base & entry in r8 and r9 */
 	__start(hdr, kbase, 0, 0, 0,
-		RELOC(prom_opal_base), RELOC(prom_opal_entry));
+		prom_opal_base, prom_opal_entry);
 #else
 	__start(hdr, kbase, 0, 0, 0, 0, 0);
 #endif
