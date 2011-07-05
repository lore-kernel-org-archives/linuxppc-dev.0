Return-Path: <tony@bakeyournoodle.com>
Date: Tue, 5 Jul 2011 14:38:17 +1000
From: Tony Breeds <tony@bakeyournoodle.com>
To: LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>,
	Josh Boyer <jwboyer@linux.vnet.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 3/3] powerpc/44x: boot wrapper: allow kernel to load into
	non-zero address
Message-ID: <20110705043817.GH13483@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20110705043657.GF13483@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>

For AMP, different kernel instances load into separate memory regions.
Read the start of memory from the device tree and limit the memory to what's
specified in the device tree.

Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/boot/treeboot-iss4xx.c |   23 ++++++++++++++++++++++-
 1 files changed, 22 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/treeboot-iss4xx.c b/arch/powerpc/boot/treeboot-iss4xx.c
index fcc4495..329e710 100644
--- a/arch/powerpc/boot/treeboot-iss4xx.c
+++ b/arch/powerpc/boot/treeboot-iss4xx.c
@@ -34,9 +34,29 @@
 
 BSS_STACK(4096);
 
+static u32 ibm4xx_memstart;
+
 static void iss_4xx_fixups(void)
 {
-	ibm4xx_sdram_fixup_memsize();
+	void *memory;
+	u32 reg[3];
+
+	memory = finddevice("/memory");
+	if (!memory)
+		fatal("Can't find memory node\n");
+	/* This assumes #address-cells = 2, #size-cells =1 and that */
+	getprop(memory, "reg", reg, sizeof(reg));
+	if (reg[2])
+		/* If the device tree specifies the memory range, use it */
+		ibm4xx_memstart = reg[1];
+	else
+		/* othersize, read it from the SDRAM controller */
+		ibm4xx_sdram_fixup_memsize();
+}
+
+static void *iss_4xx_vmlinux_alloc(unsigned long size)
+{
+	return (void *)ibm4xx_memstart;
 }
 
 #define SPRN_PIR	0x11E	/* Processor Indentification Register */
@@ -48,6 +68,7 @@ void platform_init(void)
 
 	simple_alloc_init(_end, avail_ram, 128, 64);
 	platform_ops.fixups = iss_4xx_fixups;
+	platform_ops.vmlinux_alloc = iss_4xx_vmlinux_alloc;
 	platform_ops.exit = ibm44x_dbcr_reset;
 	pir_reg = mfspr(SPRN_PIR);
 	fdt_set_boot_cpuid_phys(_dtb_start, pir_reg);
-- 
1.7.4.4
