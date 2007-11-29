Return-Path: <adolnikov@ru.mvista.com>
Received: from barber.spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B6A42DDE16
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 02:35:27 +1100 (EST)
Received: from barber.spb.rtsoft.ru (localhost.localdomain [127.0.0.1])
	by barber.spb.rtsoft.ru (8.13.1/8.13.1) with ESMTP id lATFZthM014975
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2007 18:35:55 +0300
Received: (from root@localhost)
	by barber.spb.rtsoft.ru (8.13.1/8.13.1/Submit) id lATFZtYq014974
	for linuxppc-dev@ozlabs.org; Thu, 29 Nov 2007 18:35:55 +0300
Date: Thu, 29 Nov 2007 18:35:55 +0300
From: Andrei Dolnikov <adolnikov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/5] PowerPC 74xx: Minor updates to MV64x60 boot code
Message-ID: <20071129153555.GC13751@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071129150726.GA13751@ru.mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds new functionality to MV64x60 boot code. The changes are required
to access DevCS windows registers and set PCI bus and devfn numbers for MV644x60
PCI/PCI-X interfaces.

Signed-off-by: Andrei Dolnikov <adolnikov@ru.mvista.com>

---
 mv64x60.c |   74 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 mv64x60.h |   10 ++++++++
 2 files changed, 84 insertions(+)

diff --git a/arch/powerpc/boot/mv64x60.c b/arch/powerpc/boot/mv64x60.c
index d207a0b..787a124 100644
--- a/arch/powerpc/boot/mv64x60.c
+++ b/arch/powerpc/boot/mv64x60.c
@@ -32,6 +32,16 @@
 #define MV64x60_CPU2MEM_3_BASE			0x0218
 #define MV64x60_CPU2MEM_3_SIZE			0x0220
 
+#define MV64x60_DEV2MEM_WINDOWS			4
+#define MV64x60_DEV2MEM_0_BASE			0x0028
+#define MV64x60_DEV2MEM_0_SIZE			0x0030
+#define MV64x60_DEV2MEM_1_BASE			0x0228
+#define MV64x60_DEV2MEM_1_SIZE			0x0230
+#define MV64x60_DEV2MEM_2_BASE			0x0248
+#define MV64x60_DEV2MEM_2_SIZE			0x0250
+#define MV64x60_DEV2MEM_3_BASE			0x0038
+#define MV64x60_DEV2MEM_3_SIZE			0x0040
+
 #define MV64x60_ENET2MEM_BAR_ENABLE		0x2290
 #define MV64x60_ENET2MEM_0_BASE			0x2200
 #define MV64x60_ENET2MEM_0_SIZE			0x2204
@@ -219,6 +229,25 @@ static struct mv64x60_mem_win mv64x60_cpu2mem[MV64x60_CPU2MEM_WINDOWS] = {
 	},
 };
 
+static struct mv64x60_mem_win mv64x60_devcs[MV64x60_DEV2MEM_WINDOWS] = {
+	[0] = {
+		.lo	= MV64x60_DEV2MEM_0_BASE,
+		.size	= MV64x60_DEV2MEM_0_SIZE,
+	},
+	[1] = {
+		.lo	= MV64x60_DEV2MEM_1_BASE,
+		.size	= MV64x60_DEV2MEM_1_SIZE,
+	},
+	[2] = {
+		.lo	= MV64x60_DEV2MEM_2_BASE,
+		.size	= MV64x60_DEV2MEM_2_SIZE,
+	},
+	[3] = {
+		.lo	= MV64x60_DEV2MEM_3_BASE,
+		.size	= MV64x60_DEV2MEM_3_SIZE,
+	},
+};
+
 static struct mv64x60_mem_win mv64x60_enet2mem[MV64x60_CPU2MEM_WINDOWS] = {
 	[0] = {
 		.lo	= MV64x60_ENET2MEM_0_BASE,
@@ -567,6 +596,36 @@ void mv64x60_config_cpu2pci_window(u8 *bridge_base, u8 hose, u32 pci_base_hi,
 	out_le32((u32 *)(bridge_base + offset_tbl[hose].size), size);
 }
 
+/* Set PCI bus number for a PCI interface and force its devnum to 0 */
+void mv64x60_set_pci_bus(u8 *bridge_base, u8 hose, u32 bus, u32 devnum)
+{
+	u8 *pci_mode_reg, *p2p_cfg_reg;
+	u32 pci_mode, p2p_cfg;
+	u32 pci_cfg_offset;
+	
+	if (hose == 0) {
+		pci_mode_reg = bridge_base + MV64x60_PCI0_MODE;
+		p2p_cfg_reg = bridge_base + MV64x60_PCI0_P2P_CONF;
+		pci_cfg_offset = 0x64;
+	} else {
+		pci_mode_reg = bridge_base + MV64x60_PCI1_MODE;
+		p2p_cfg_reg = bridge_base + MV64x60_PCI1_P2P_CONF;
+		pci_cfg_offset = 0xe4;
+	}
+
+	pci_mode = in_le32((u32*)pci_mode_reg) & MV64x60_PCI_MODE_MASK;
+	p2p_cfg = in_le32((u32*)p2p_cfg_reg);
+
+	if (pci_mode == MV64x60_PCI_CONVENTIONAL_MODE) {
+		p2p_cfg &= 0xe0000000;
+		p2p_cfg |= (devnum << 24) | (bus << 16) | 0xff;
+		out_le32((u32*)p2p_cfg_reg, p2p_cfg);
+	} else
+		mv64x60_cfg_write(bridge_base, hose, (p2p_cfg >> 16) & 0xff,
+				 PCI_DEVFN((p2p_cfg >> 24) & 0x1f, 0),
+				 pci_cfg_offset, (devnum << 3) | (bus << 8));
+}
+
 /* Read mem ctlr to get the amount of mem in system */
 u32 mv64x60_get_mem_size(u8 *bridge_base)
 {
@@ -586,6 +645,21 @@ u32 mv64x60_get_mem_size(u8 *bridge_base)
 	return mem;
 }
 
+/* Read a size of DEV_CS window */
+u32 mv64x60_get_devcs_size(u8 *bridge_base, u32 devcs)
+{
+	u32 enables, size = 0;
+
+	enables = in_le32((u32 *)(bridge_base + MV64x60_CPU_BAR_ENABLE)) & 0xf0;
+	
+	if (devcs < 4 && !(enables && (0x10 << devcs))) {
+		size = in_le32((u32*)(bridge_base + mv64x60_devcs[devcs].size));
+		size = ((size & 0xffff) + 1) << 16;
+	}
+
+	return size;
+}
+
 /* Get physical address of bridge's registers */
 u8 *mv64x60_get_bridge_pbase(void)
 {
diff --git a/arch/powerpc/boot/mv64x60.h b/arch/powerpc/boot/mv64x60.h
index d0b29a7..a633d2e 100644
--- a/arch/powerpc/boot/mv64x60.h
+++ b/arch/powerpc/boot/mv64x60.h
@@ -12,6 +12,14 @@
 
 #define MV64x60_CPU_BAR_ENABLE			0x0278
 
+#define MV64x60_PCI0_MODE			0x0d00
+#define MV64x60_PCI1_MODE			0x0d80
+#define MV64x60_PCI0_P2P_CONF			0x1d14
+#define MV64x60_PCI1_P2P_CONF			0x1d94
+
+#define MV64x60_PCI_MODE_MASK			0x00000030
+#define MV64x60_PCI_CONVENTIONAL_MODE		0x00000000
+
 #define MV64x60_PCI_ACC_CNTL_ENABLE		(1<<0)
 #define MV64x60_PCI_ACC_CNTL_REQ64		(1<<1)
 #define MV64x60_PCI_ACC_CNTL_SNOOP_NONE		0x00000000
@@ -57,7 +65,9 @@ void mv64x60_config_pci_windows(u8 *bridge_base, u8 *bridge_pbase, u8 hose,
 void mv64x60_config_cpu2pci_window(u8 *bridge_base, u8 hose, u32 pci_base_hi,
 		u32 pci_base_lo, u32 cpu_base, u32 size,
 		struct mv64x60_cpu2pci_win *offset_tbl);
+void mv64x60_set_pci_bus(u8 *bridge_base, u8 hose, u32 bus, u32 devnum);
 u32 mv64x60_get_mem_size(u8 *bridge_base);
+u32 mv64x60_get_devcs_size(u8 *bridge_base, u32 devcs);
 u8 *mv64x60_get_bridge_pbase(void);
 u8 *mv64x60_get_bridge_base(void);
 u8 mv64x60_is_coherent(void);
