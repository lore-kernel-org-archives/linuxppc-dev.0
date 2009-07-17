Return-Path: <ben@codiert.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id A39BAB70A6
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 18 Jul 2009 06:29:51 +1000 (EST)
Received: from cursor.subgra.de (cursor.subgra.de [78.46.252.50])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "cursor.subgra.de", Issuer "cursor.subgra.de" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id E7B02DDD1B
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Jul 2009 06:29:50 +1000 (EST)
Date: Fri, 17 Jul 2009 22:29:22 +0200
From: Benjamin Krill <ben@codiert.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH] prom_init: evaluate mem kernel parameter for early allocation
Message-ID: <20090717202922.GA20168@codiert.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Evaluate mem kernel parameter for early memory allocations. If mem is set
no allocation in the region above the given boundary is allowed. The current
code doesn't take care about this and allocate memory above the given mem
boundary.

Signed-off-by: Benjamin Krill <ben@codiert.org>
---
 arch/powerpc/kernel/prom_init.c |  100 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 100 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index a538824..7c5b618 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -190,6 +190,8 @@ static int __initdata of_platform;

 static char __initdata prom_cmd_line[COMMAND_LINE_SIZE];

+static unsigned long __initdata prom_memory_limit;
+
 static unsigned long __initdata alloc_top;
 static unsigned long __initdata alloc_top_high;
 static unsigned long __initdata alloc_bottom;
@@ -484,6 +486,67 @@ static int __init prom_setprop(phandle node, const char *nodename,
 	return call_prom("interpret", 1, 1, (u32)(unsigned long) cmd);
 }

+/* We can't use the standard versions because of RELOC headaches. */
+#define isxdigit(c)	(('0' <= (c) && (c) <= '9') \
+			 || ('a' <= (c) && (c) <= 'f') \
+			 || ('A' <= (c) && (c) <= 'F'))
+
+#define isdigit(c)	('0' <= (c) && (c) <= '9')
+#define islower(c)	('a' <= (c) && (c) <= 'z')
+#define toupper(c)	(islower(c) ? ((c) - 'a' + 'A') : (c))
+
+unsigned long prom_strtoul(const char *cp, const char **endp)
+{
+	unsigned long result = 0, base = 10, value;
+
+	if (*cp == '0') {
+		base = 8;
+		cp++;
+		if (toupper(*cp) == 'X') {
+			cp++;
+			base = 16;
+		}
+	}
+
+	while (isxdigit(*cp) &&
+	       (value = isdigit(*cp) ? *cp - '0' : toupper(*cp) - 'A' + 10) < base) {
+		result = result * base + value;
+		cp++;
+	}
+
+	if (endp)
+		*endp = cp;
+
+	return result;
+}
+
+unsigned long prom_memparse(const char *ptr, const char **retptr)
+{
+	unsigned long ret = prom_strtoul(ptr, retptr);
+	int shift = 0;
+
+	/*
+	 * We can't use a switch here because GCC *may* generate a
+	 * jump table which won't work, because we're not running at
+	 * the address we're linked at.
+	 */
+	if ('G' == **retptr || 'g' == **retptr)
+		shift = 30;
+
+	if ('M' == **retptr || 'm' == **retptr)
+		shift = 20;
+
+	if ('K' == **retptr || 'k' == **retptr)
+		shift = 10;
+
+	if (shift) {
+		ret <<= shift;
+		(*retptr)++;
+	}
+
+	return ret;
+}
+
 /*
  * Early parsing of the command line passed to the kernel, used for
  * "mem=x" and the options that affect the iommu
@@ -521,6 +584,15 @@ static void __init early_cmdline_parse(void)
 			RELOC(prom_iommu_force_on) = 1;
 	}
 #endif
+	opt = strstr(RELOC(prom_cmd_line), RELOC("mem="));
+	if (opt) {
+		opt += 4;
+		RELOC(prom_memory_limit) = prom_memparse(opt, (const char **)&opt);
+#ifdef CONFIG_PPC64
+		/* Align to 16 MB == size of ppc64 large page */
+		RELOC(prom_memory_limit) = ALIGN(RELOC(prom_memory_limit), 0x1000000);
+#endif
+	}
 }

 #ifdef CONFIG_PPC_PSERIES
@@ -1027,6 +1099,29 @@ static void __init prom_init_mem(void)
 	}

 	/*
+	 * If prom_memory_limit is set we reduce the upper limits *except* for
+	 * alloc_top_high. This must be the real top of RAM so we can put
+	 * TCE's up there.
+	 */
+
+	RELOC(alloc_top_high) = RELOC(ram_top);
+
+	if (RELOC(prom_memory_limit)) {
+		if (RELOC(prom_memory_limit) <= RELOC(alloc_bottom)) {
+			prom_printf("Ignoring mem=%x <= alloc_bottom.\n",
+				RELOC(prom_memory_limit));
+			RELOC(prom_memory_limit) = 0;
+		} else if (RELOC(prom_memory_limit) >= RELOC(ram_top)) {
+			prom_printf("Ignoring mem=%x >= ram_top.\n",
+				RELOC(prom_memory_limit));
+			RELOC(prom_memory_limit) = 0;
+		} else {
+			RELOC(ram_top) = RELOC(prom_memory_limit);
+			RELOC(rmo_top) = min(RELOC(rmo_top), RELOC(prom_memory_limit));
+		}
+	}
+
+	/*
 	 * Setup our top alloc point, that is top of RMO or top of
 	 * segment 0 when running non-LPAR.
 	 * Some RS64 machines have buggy firmware where claims up at
@@ -1041,6 +1136,7 @@ static void __init prom_init_mem(void)
 	RELOC(alloc_top_high) = RELOC(ram_top);

 	prom_printf("memory layout at init:\n");
+	prom_printf("  memory_limit : %x (16 MB aligned)\n", RELOC(prom_memory_limit));
 	prom_printf("  alloc_bottom : %x\n", RELOC(alloc_bottom));
 	prom_printf("  alloc_top    : %x\n", RELOC(alloc_top));
 	prom_printf("  alloc_top_hi : %x\n", RELOC(alloc_top_high));
@@ -2399,6 +2495,10 @@ unsigned long __init prom_init(unsigned long r3, unsigned long r4,
 	/*
 	 * Fill in some infos for use by the kernel later on
 	 */
+	if (RELOC(prom_memory_limit))
+		prom_setprop(_prom->chosen, "/chosen", "linux,memory-limit",
+			     &RELOC(prom_memory_limit),
+			     sizeof(prom_memory_limit));
 #ifdef CONFIG_PPC64
 	if (RELOC(prom_iommu_off))
 		prom_setprop(_prom->chosen, "/chosen", "linux,iommu-off",
--
1.5.4.5
