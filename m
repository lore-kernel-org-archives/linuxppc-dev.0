Return-Path: <mgreer@mvista.com>
Date: Wed, 7 Nov 2007 18:54:15 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Subject: [PATCH 1/3] powerpc: mv64x60 - Fix PCI MEM->System Mem window setup
Message-ID: <20071108015415.GA14900@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Mark A. Greer <mgreer@mvista.com>

The Marvell mv64x60 line of host bridges just don't like
PCI MEM->System Memory windows setups that don't match
the CPU->System Memory window setups.  For example, if there
is 1GB of System Memory and 2 CPU->System Memory windows set up
for 512MB each, then there had better be 2 PCI->System Memory
windows set up for 512MB each as well.

This restriction was documented in early versions of the bridge
but isn't supposed to apply to recent versions.  It seems as though
it still applies to recent versions as well.

mv64x60_config_pci_windows() is now changed to make the windows match
as described above.

Signed-off-by: Mark A. Greer <mgreer@mvista.com>

---
 arch/powerpc/boot/mv64x60.c |  133 ++++++++++++++++++++++++----------
 arch/powerpc/boot/mv64x60.h |    2 
 2 files changed, 96 insertions(+), 39 deletions(-)

diff --git a/arch/powerpc/boot/mv64x60.c b/arch/powerpc/boot/mv64x60.c
index b432594..ddddc3f 100644
--- a/arch/powerpc/boot/mv64x60.c
+++ b/arch/powerpc/boot/mv64x60.c
@@ -92,6 +92,9 @@
 
 #define MV64x60_PCI0_BAR_ENABLE			0x0c3c
 #define MV64x60_PCI02MEM_0_SIZE			0x0c08
+#define MV64x60_PCI02MEM_1_SIZE			0x0d08
+#define MV64x60_PCI02MEM_2_SIZE			0x0c0c
+#define MV64x60_PCI02MEM_3_SIZE			0x0d0c
 #define MV64x60_PCI0_ACC_CNTL_0_BASE_LO		0x1e00
 #define MV64x60_PCI0_ACC_CNTL_0_BASE_HI		0x1e04
 #define MV64x60_PCI0_ACC_CNTL_0_SIZE		0x1e08
@@ -113,6 +116,9 @@
 
 #define MV64x60_PCI1_BAR_ENABLE			0x0cbc
 #define MV64x60_PCI12MEM_0_SIZE			0x0c88
+#define MV64x60_PCI12MEM_1_SIZE			0x0d88
+#define MV64x60_PCI12MEM_2_SIZE			0x0c8c
+#define MV64x60_PCI12MEM_3_SIZE			0x0d8c
 #define MV64x60_PCI1_ACC_CNTL_0_BASE_LO		0x1e80
 #define MV64x60_PCI1_ACC_CNTL_0_BASE_HI		0x1e84
 #define MV64x60_PCI1_ACC_CNTL_0_SIZE		0x1e88
@@ -331,18 +337,58 @@ void mv64x60_config_ctlr_windows(u8 *bridge_base, u8 *bridge_pbase,
 }
 
 /* PCI MEM -> system memory, et. al. setup */
-static struct mv64x60_pci_win mv64x60_pci2mem[2] = {
+static struct mv64x60_pci_win mv64x60_pci2mem[2][MV64x60_CPU2MEM_WINDOWS] = {
 	{ /* hose 0 */
-		.fcn	= 0,
-		.hi	= 0x14,
-		.lo	= 0x10,
-		.size	= MV64x60_PCI02MEM_0_SIZE,
+		[0] = {
+			.fcn	= 0,
+			.hi	= 0x14,
+			.lo	= 0x10,
+			.size	= MV64x60_PCI02MEM_0_SIZE,
+		},
+		[1] = {
+			.fcn	= 0,
+			.hi	= 0x1c,
+			.lo	= 0x18,
+			.size	= MV64x60_PCI02MEM_1_SIZE,
+		},
+		[2] = {
+			.fcn	= 1,
+			.hi	= 0x14,
+			.lo	= 0x10,
+			.size	= MV64x60_PCI02MEM_2_SIZE,
+		},
+		[3] = {
+			.fcn	= 1,
+			.hi	= 0x1c,
+			.lo	= 0x18,
+			.size	= MV64x60_PCI02MEM_3_SIZE,
+		},
 	},
 	{ /* hose 1 */
-		.fcn	= 0,
-		.hi	= 0x94,
-		.lo	= 0x90,
-		.size	= MV64x60_PCI12MEM_0_SIZE,
+		[0] = {
+			.fcn	= 0,
+			.hi	= 0x94,
+			.lo	= 0x90,
+			.size	= MV64x60_PCI12MEM_0_SIZE,
+		},
+		[1] = {
+			.fcn	= 0,
+			.hi	= 0x9c,
+			.lo	= 0x98,
+			.size	= MV64x60_PCI12MEM_1_SIZE,
+		},
+		[2] = {
+			.fcn	= 1,
+			.hi	= 0x94,
+			.lo	= 0x90,
+			.size	= MV64x60_PCI12MEM_2_SIZE,
+		},
+		[3] = {
+			.fcn	= 1,
+			.hi	= 0x9c,
+			.lo	= 0x98,
+			.size	= MV64x60_PCI12MEM_3_SIZE,
+		},
 	},
 };
 
@@ -394,70 +440,81 @@ mv64x60_mem_win mv64x60_pci_acc[2][MV64x60_PCI_ACC_CNTL_WINDOWS] = {
 	},
 };
 
-static struct mv64x60_mem_win mv64x60_pci2reg[2] = {
-	{
+static struct mv64x60_pci_win mv64x60_pci2reg[2] = {
+	{ /* hose 0 */
+		.fcn	= 0,
 		.hi	= 0x24,
 		.lo	= 0x20,
 		.size	= 0,
 	},
-	{
+	{ /* hose 1 */
+		.fcn	= 0,
 		.hi	= 0xa4,
 		.lo	= 0xa0,
 		.size	= 0,
 	},
 };
 
-/* Only need to use 1 window (per hose) to get access to all of system memory */
+/* Make PCI->System memory windows match CPU->System memory windows */
 void mv64x60_config_pci_windows(u8 *bridge_base, u8 *bridge_pbase, u8 hose,
-		u8 bus, u32 mem_size, u32 acc_bits)
+		u8 bus, u32 acc_bits)
 {
-	u32 i, offset, bar_enable, enables;
+	u32 i, offset, bar_enable, menables, penables, base, size;
 
 	/* Disable all windows but PCI MEM -> Bridge's regs window */
-	enables = ~(1 << 9);
+	penables = ~(1 << 9);
 	bar_enable = hose ? MV64x60_PCI1_BAR_ENABLE : MV64x60_PCI0_BAR_ENABLE;
-	out_le32((u32 *)(bridge_base + bar_enable), enables);
+	out_le32((u32 *)(bridge_base + bar_enable), penables);
 
 	for (i=0; i<MV64x60_PCI_ACC_CNTL_WINDOWS; i++)
 		out_le32((u32 *)(bridge_base + mv64x60_pci_acc[hose][i].lo), 0);
 
-	/* If mem_size is 0, leave windows disabled */
-	if (mem_size == 0)
-		return;
-
 	/* Cause automatic updates of PCI remap regs */
 	offset = hose ?
 		MV64x60_PCI1_PCI_DECODE_CNTL : MV64x60_PCI0_PCI_DECODE_CNTL;
 	i = in_le32((u32 *)(bridge_base + offset));
 	out_le32((u32 *)(bridge_base + offset), i & ~0x1);
 
-	mem_size = (mem_size - 1) & 0xfffff000;
+	menables = in_le32((u32 *)(bridge_base + MV64x60_CPU_BAR_ENABLE)) & 0xf;
 
-	/* Map PCI MEM addr 0 -> System Mem addr 0 */
-	mv64x60_cfg_write(bridge_base, hose, bus,
-			PCI_DEVFN(0, mv64x60_pci2mem[hose].fcn),
-			mv64x60_pci2mem[hose].hi, 0);
-	mv64x60_cfg_write(bridge_base, hose, bus,
-			PCI_DEVFN(0, mv64x60_pci2mem[hose].fcn),
-			mv64x60_pci2mem[hose].lo, 0);
-	out_le32((u32 *)(bridge_base + mv64x60_pci2mem[hose].size),mem_size);
+	for (i=0; i<MV64x60_CPU2MEM_WINDOWS; i++) {
+		if (menables & (1 << i)) /* Set means disabled */
+			continue;
 
-	acc_bits |= MV64x60_PCI_ACC_CNTL_ENABLE;
-	out_le32((u32 *)(bridge_base + mv64x60_pci_acc[hose][0].hi), 0);
-	out_le32((u32 *)(bridge_base + mv64x60_pci_acc[hose][0].lo), acc_bits);
-	out_le32((u32 *)(bridge_base + mv64x60_pci_acc[hose][0].size),mem_size);
+		penables &= ~(1 << i); /* Enable this PCI BAR */
+		base = in_le32((u32 *)(bridge_base + mv64x60_cpu2mem[i].lo))
+			<< 16;
+		size = (in_le32((u32 *)(bridge_base + mv64x60_cpu2mem[i].size))
+			<< 16) | 0xf000;
+
+		mv64x60_cfg_write(bridge_base, hose, bus,
+				PCI_DEVFN(0, mv64x60_pci2mem[hose][i].fcn),
+				mv64x60_pci2mem[hose][i].hi, 0);
+		mv64x60_cfg_write(bridge_base, hose, bus,
+				PCI_DEVFN(0, mv64x60_pci2mem[hose][i].fcn),
+				mv64x60_pci2mem[hose][i].lo, base | 0xc);
+		out_le32((u32 *)(bridge_base + mv64x60_pci2mem[hose][i].size),
+				size);
+
+		out_le32((u32 *)(bridge_base + mv64x60_pci_acc[hose][i].hi), 0);
+		out_le32((u32 *)(bridge_base + mv64x60_pci_acc[hose][i].lo),
+				base | acc_bits | MV64x60_PCI_ACC_CNTL_ENABLE);
+		out_le32((u32 *)(bridge_base + mv64x60_pci_acc[hose][i].size),
+				size);
+	}
 
 	/* Set PCI MEM->bridge's reg window to where they are in CPU mem map */
 	i = (u32)bridge_base;
 	i &= 0xffff0000;
 	i |= (0x2 << 1);
-	mv64x60_cfg_write(bridge_base, hose, bus, PCI_DEVFN(0,0),
+	mv64x60_cfg_write(bridge_base, hose, bus,
+			PCI_DEVFN(0, mv64x60_pci2reg[hose].fcn),
 			mv64x60_pci2reg[hose].hi, 0);
-	mv64x60_cfg_write(bridge_base, hose, bus, PCI_DEVFN(0,0),
+	mv64x60_cfg_write(bridge_base, hose, bus,
+			PCI_DEVFN(0, mv64x60_pci2reg[hose].fcn),
 			mv64x60_pci2reg[hose].lo, i);
 
-	enables &= ~0x1; /* Enable PCI MEM -> System Mem window 0 */
-	out_le32((u32 *)(bridge_base + bar_enable), enables);
+	out_le32((u32 *)(bridge_base + bar_enable), penables);
 }
 
 /* CPU -> PCI I/O & MEM setup */
diff --git a/arch/powerpc/boot/mv64x60.h b/arch/powerpc/boot/mv64x60.h
index b827105..d0b29a7 100644
--- a/arch/powerpc/boot/mv64x60.h
+++ b/arch/powerpc/boot/mv64x60.h
@@ -53,7 +53,7 @@ void mv64x60_cfg_write(u8 *bridge_base, u8 hose, u8 bus, u8 devfn,
 void mv64x60_config_ctlr_windows(u8 *bridge_base, u8 *bridge_pbase,
 		u8 is_coherent);
 void mv64x60_config_pci_windows(u8 *bridge_base, u8 *bridge_pbase, u8 hose,
-		u8 bus, u32 mem_size, u32 acc_bits);
+		u8 bus, u32 acc_bits);
 void mv64x60_config_cpu2pci_window(u8 *bridge_base, u8 hose, u32 pci_base_hi,
 		u32 pci_base_lo, u32 cpu_base, u32 size,
 		struct mv64x60_cpu2pci_win *offset_tbl);
