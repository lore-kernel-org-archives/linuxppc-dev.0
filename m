Return-Path: <a.heider@gmail.com>
From: Andre Heider <a.heider@gmail.com>
To: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 01/15] [PS3] Add udbg driver using the PS3 gelic Ethernet
	device
Date: Mon,  1 Aug 2011 22:02:52 +0200
Message-Id: <1312228986-32307-2-git-send-email-a.heider@gmail.com>
In-Reply-To: <1312228986-32307-1-git-send-email-a.heider@gmail.com>
References: <1312228986-32307-1-git-send-email-a.heider@gmail.com>
Cc: cbe-oss-dev@lists.ozlabs.org, Hector Martin <hector@marcansoft.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Hector Martin <hector@marcansoft.com>

Signed-off-by: Hector Martin <hector@marcansoft.com>
[a.heider: Various cleanups to make checkpatch.pl happy]
Signed-off-by: Andre Heider <a.heider@gmail.com>
---
 arch/powerpc/Kconfig.debug              |    8 +
 arch/powerpc/include/asm/udbg.h         |    1 +
 arch/powerpc/kernel/udbg.c              |    2 +
 arch/powerpc/platforms/ps3/Kconfig      |   12 ++
 arch/powerpc/platforms/ps3/Makefile     |    1 +
 arch/powerpc/platforms/ps3/gelic_udbg.c |  272 +++++++++++++++++++++++++++++++
 drivers/net/ps3_gelic_net.c             |    3 +
 drivers/net/ps3_gelic_net.h             |    6 +
 8 files changed, 305 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/platforms/ps3/gelic_udbg.c

diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index 2d38a50..47edab6 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -267,6 +267,14 @@ config PPC_EARLY_DEBUG_USBGECKO
 	  Select this to enable early debugging for Nintendo GameCube/Wii
 	  consoles via an external USB Gecko adapter.
 
+config PPC_EARLY_DEBUG_PS3GELIC
+	bool "Early debugging through the PS3 Ethernet port"
+	depends on PPC_PS3
+	select PS3GELIC_UDBG
+	help
+	  Select this to enable early debugging for the PlayStation3 via
+	  UDP broadcasts sent out through the Ethernet port.
+
 endchoice
 
 config PPC_EARLY_DEBUG_44x_PHYSLOW
diff --git a/arch/powerpc/include/asm/udbg.h b/arch/powerpc/include/asm/udbg.h
index 11ae699..58f0ab9 100644
--- a/arch/powerpc/include/asm/udbg.h
+++ b/arch/powerpc/include/asm/udbg.h
@@ -52,6 +52,7 @@ extern void __init udbg_init_44x_as1(void);
 extern void __init udbg_init_40x_realmode(void);
 extern void __init udbg_init_cpm(void);
 extern void __init udbg_init_usbgecko(void);
+extern void __init udbg_init_ps3gelic(void);
 
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_UDBG_H */
diff --git a/arch/powerpc/kernel/udbg.c b/arch/powerpc/kernel/udbg.c
index e39cad8..9ea9897 100644
--- a/arch/powerpc/kernel/udbg.c
+++ b/arch/powerpc/kernel/udbg.c
@@ -62,6 +62,8 @@ void __init udbg_early_init(void)
 	udbg_init_cpm();
 #elif defined(CONFIG_PPC_EARLY_DEBUG_USBGECKO)
 	udbg_init_usbgecko();
+#elif defined(CONFIG_PPC_EARLY_DEBUG_PS3GELIC)
+	udbg_init_ps3gelic();
 #endif
 
 #ifdef CONFIG_PPC_EARLY_DEBUG
diff --git a/arch/powerpc/platforms/ps3/Kconfig b/arch/powerpc/platforms/ps3/Kconfig
index dfe316b..476d9d9 100644
--- a/arch/powerpc/platforms/ps3/Kconfig
+++ b/arch/powerpc/platforms/ps3/Kconfig
@@ -148,4 +148,16 @@ config PS3_LPM
 	  profiling support of the Cell processor with programs like
 	  oprofile and perfmon2, then say Y or M, otherwise say N.
 
+config PS3GELIC_UDBG
+	bool "PS3 udbg output via UDP broadcasts on Ethernet"
+	depends on PPC_PS3
+	help
+	  Enables udbg early debugging output by sending broadcast UDP
+	  via the Ethernet port (UDP port number 18194).
+
+	  This driver uses a trivial implementation and is independent
+	  from the main network driver.
+
+	  If in doubt, say N here.
+
 endmenu
diff --git a/arch/powerpc/platforms/ps3/Makefile b/arch/powerpc/platforms/ps3/Makefile
index ac1bdf8..02b9e63 100644
--- a/arch/powerpc/platforms/ps3/Makefile
+++ b/arch/powerpc/platforms/ps3/Makefile
@@ -2,6 +2,7 @@ obj-y += setup.o mm.o time.o hvcall.o htab.o repository.o
 obj-y += interrupt.o exports.o os-area.o
 obj-y += system-bus.o
 
+obj-$(CONFIG_PS3GELIC_UDBG) += gelic_udbg.o
 obj-$(CONFIG_SMP) += smp.o
 obj-$(CONFIG_SPU_BASE) += spu.o
 obj-y += device-init.o
diff --git a/arch/powerpc/platforms/ps3/gelic_udbg.c b/arch/powerpc/platforms/ps3/gelic_udbg.c
new file mode 100644
index 0000000..9b383bd
--- /dev/null
+++ b/arch/powerpc/platforms/ps3/gelic_udbg.c
@@ -0,0 +1,272 @@
+/*
+ * arch/powerpc/platforms/ps3/gelic_udbg.c
+ *
+ * udbg debug output routine via GELIC UDP broadcasts
+ * Copyright (C) 2010 Hector Martin <hector@marcansoft.com>
+ * Copyright (C) 2011 Andre Heider <a.heider@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ */
+
+#include <asm/io.h>
+#include <asm/udbg.h>
+#include <asm/lv1call.h>
+
+#define GELIC_BUS_ID 1
+#define GELIC_DEVICE_ID 0
+#define GELIC_DEBUG_PORT 18194
+#define GELIC_MAX_MESSAGE_SIZE 1000
+
+#define GELIC_LV1_GET_MAC_ADDRESS 1
+#define GELIC_LV1_GET_VLAN_ID 4
+#define GELIC_LV1_VLAN_TX_ETHERNET_0 2
+
+#define GELIC_DESCR_DMA_STAT_MASK 0xf0000000
+#define GELIC_DESCR_DMA_CARDOWNED 0xa0000000
+
+#define GELIC_DESCR_TX_DMA_IKE 0x00080000
+#define GELIC_DESCR_TX_DMA_NO_CHKSUM 0x00000000
+#define GELIC_DESCR_TX_DMA_FRAME_TAIL 0x00040000
+
+#define GELIC_DESCR_DMA_CMD_NO_CHKSUM (GELIC_DESCR_DMA_CARDOWNED | \
+				       GELIC_DESCR_TX_DMA_IKE | \
+				       GELIC_DESCR_TX_DMA_NO_CHKSUM)
+
+static u64 bus_addr;
+
+struct gelic_descr {
+	/* as defined by the hardware */
+	u32 buf_addr;
+	u32 buf_size;
+	u32 next_descr_addr;
+	u32 dmac_cmd_status;
+	u32 result_size;
+	u32 valid_size;	/* all zeroes for tx */
+	u32 data_status;
+	u32 data_error;	/* all zeroes for tx */
+} __attribute__((aligned(32)));
+
+struct debug_block {
+	struct gelic_descr descr;
+	u8 pkt[1520];
+} __packed;
+
+struct ethhdr {
+	u8 dest[6];
+	u8 src[6];
+	u16 type;
+} __packed;
+
+struct vlantag {
+	u16 vlan;
+	u16 subtype;
+} __packed;
+
+struct iphdr {
+	u8 ver_len;
+	u8 dscp_ecn;
+	u16 total_length;
+	u16 ident;
+	u16 frag_off_flags;
+	u8 ttl;
+	u8 proto;
+	u16 checksum;
+	u32 src;
+	u32 dest;
+} __packed;
+
+struct udphdr {
+	u16 src;
+	u16 dest;
+	u16 len;
+	u16 checksum;
+} __packed;
+
+static __iomem struct ethhdr *h_eth;
+static __iomem struct vlantag *h_vlan;
+static __iomem struct iphdr *h_ip;
+static __iomem struct udphdr *h_udp;
+
+static __iomem char *pmsg;
+static __iomem char *pmsgc;
+
+static __iomem struct debug_block dbg __attribute__((aligned(32)));
+
+static int header_size;
+
+static void map_dma_mem(int bus_id, int dev_id, void *start, size_t len,
+			u64 *real_bus_addr)
+{
+	s64 result;
+	u64 real_addr = ((u64)start) & 0x0fffffffffffffffUL;
+	u64 real_end = real_addr + len;
+	u64 map_start = real_addr & ~0xfff;
+	u64 map_end = (real_end + 0xfff) & ~0xfff;
+	u64 bus_addr = 0;
+
+	u64 flags = 0xf800000000000000UL;
+
+	result = lv1_allocate_device_dma_region(bus_id, dev_id,
+						map_end - map_start, 12, 0,
+						&bus_addr);
+	if (result)
+		lv1_panic(0);
+
+	result = lv1_map_device_dma_region(bus_id, dev_id, map_start,
+					   bus_addr, map_end - map_start,
+					   flags);
+	if (result)
+		lv1_panic(0);
+
+	*real_bus_addr = bus_addr + real_addr - map_start;
+}
+
+static int unmap_dma_mem(int bus_id, int dev_id, u64 bus_addr, size_t len)
+{
+	s64 result;
+	u64 real_bus_addr;
+
+	real_bus_addr = bus_addr & ~0xfff;
+	len += bus_addr - real_bus_addr;
+	len = (len + 0xfff) & ~0xfff;
+
+	result = lv1_unmap_device_dma_region(bus_id, dev_id, real_bus_addr,
+					     len);
+	if (result)
+		return result;
+
+	return lv1_free_device_dma_region(bus_id, dev_id, real_bus_addr);
+}
+
+static void gelic_debug_init(void)
+{
+	s64 result;
+	u64 v2;
+	u64 mac;
+	u64 vlan_id;
+
+	result = lv1_open_device(GELIC_BUS_ID, GELIC_DEVICE_ID, 0);
+	if (result)
+		lv1_panic(0);
+
+	map_dma_mem(GELIC_BUS_ID, GELIC_DEVICE_ID, &dbg, sizeof(dbg),
+		    &bus_addr);
+
+	memset(&dbg, 0, sizeof(dbg));
+
+	dbg.descr.buf_addr = bus_addr + offsetof(struct debug_block, pkt);
+
+	wmb();
+
+	result = lv1_net_control(GELIC_BUS_ID, GELIC_DEVICE_ID,
+				 GELIC_LV1_GET_MAC_ADDRESS, 0, 0, 0,
+				 &mac, &v2);
+	if (result)
+		lv1_panic(0);
+
+	mac <<= 16;
+
+	h_eth = (struct ethhdr *)dbg.pkt;
+
+	memset(&h_eth->dest, 0xff, 6);
+	memcpy(&h_eth->src, &mac, 6);
+
+	header_size = sizeof(struct ethhdr);
+
+	result = lv1_net_control(GELIC_BUS_ID, GELIC_DEVICE_ID,
+				 GELIC_LV1_GET_VLAN_ID,
+				 GELIC_LV1_VLAN_TX_ETHERNET_0, 0, 0,
+				 &vlan_id, &v2);
+	if (result == 0) {
+		h_eth->type = 0x8100;
+
+		header_size += sizeof(struct vlantag);
+		h_vlan = (struct vlantag *)(h_eth + 1);
+		h_vlan->vlan = vlan_id;
+		h_vlan->subtype = 0x0800;
+		h_ip = (struct iphdr *)(h_vlan + 1);
+	} else {
+		h_eth->type = 0x0800;
+		h_ip = (struct iphdr *)(h_eth + 1);
+	}
+
+	header_size += sizeof(struct iphdr);
+	h_ip->ver_len = 0x45;
+	h_ip->ttl = 10;
+	h_ip->proto = 0x11;
+	h_ip->src = 0x00000000;
+	h_ip->dest = 0xffffffff;
+
+	header_size += sizeof(struct udphdr);
+	h_udp = (struct udphdr *)(h_ip + 1);
+	h_udp->src = GELIC_DEBUG_PORT;
+	h_udp->dest = GELIC_DEBUG_PORT;
+
+	pmsgc = pmsg = (char *)(h_udp + 1);
+}
+
+static void gelic_debug_shutdown(void)
+{
+	if (bus_addr)
+		unmap_dma_mem(GELIC_BUS_ID, GELIC_DEVICE_ID,
+			      bus_addr, sizeof(dbg));
+	lv1_close_device(GELIC_BUS_ID, GELIC_DEVICE_ID);
+}
+
+static void gelic_sendbuf(int msgsize)
+{
+	u16 *p;
+	u32 sum;
+	int i;
+
+	dbg.descr.buf_size = header_size + msgsize;
+	h_ip->total_length = msgsize + sizeof(struct udphdr) +
+			     sizeof(struct iphdr);
+	h_udp->len = msgsize + sizeof(struct udphdr);
+
+	h_ip->checksum = 0;
+	sum = 0;
+	p = (u16 *)h_ip;
+	for (i = 0; i < 5; i++)
+		sum += *p++;
+	h_ip->checksum = ~(sum + (sum >> 16));
+
+	dbg.descr.dmac_cmd_status = GELIC_DESCR_DMA_CMD_NO_CHKSUM |
+				    GELIC_DESCR_TX_DMA_FRAME_TAIL;
+	dbg.descr.result_size = 0;
+	dbg.descr.data_status = 0;
+
+	wmb();
+
+	lv1_net_start_tx_dma(GELIC_BUS_ID, GELIC_DEVICE_ID, bus_addr, 0);
+
+	while ((dbg.descr.dmac_cmd_status & GELIC_DESCR_DMA_STAT_MASK) ==
+	       GELIC_DESCR_DMA_CARDOWNED)
+		cpu_relax();
+}
+
+static void ps3gelic_udbg_putc(char ch)
+{
+	*pmsgc++ = ch;
+	if (ch == '\n' || (pmsgc-pmsg) >= GELIC_MAX_MESSAGE_SIZE) {
+		gelic_sendbuf(pmsgc-pmsg);
+		pmsgc = pmsg;
+	}
+}
+
+void __init udbg_init_ps3gelic(void)
+{
+	gelic_debug_init();
+	udbg_putc = ps3gelic_udbg_putc;
+}
+
+void udbg_shutdown_ps3gelic(void)
+{
+	udbg_putc = NULL;
+	gelic_debug_shutdown();
+}
+EXPORT_SYMBOL(udbg_shutdown_ps3gelic);
diff --git a/drivers/net/ps3_gelic_net.c b/drivers/net/ps3_gelic_net.c
index 035a676..4488655 100644
--- a/drivers/net/ps3_gelic_net.c
+++ b/drivers/net/ps3_gelic_net.c
@@ -1688,6 +1688,9 @@ static int __devinit ps3_gelic_driver_probe(struct ps3_system_bus_device *dev)
 	int result;
 
 	pr_debug("%s: called\n", __func__);
+
+	udbg_shutdown_ps3gelic();
+
 	result = ps3_open_hv_device(dev);
 
 	if (result) {
diff --git a/drivers/net/ps3_gelic_net.h b/drivers/net/ps3_gelic_net.h
index 07bdc17..57ef974 100644
--- a/drivers/net/ps3_gelic_net.h
+++ b/drivers/net/ps3_gelic_net.h
@@ -360,6 +360,12 @@ static inline void *port_priv(struct gelic_port *port)
 	return port->priv;
 }
 
+#ifdef CONFIG_PPC_EARLY_DEBUG_PS3GELIC
+extern void udbg_shutdown_ps3gelic(void);
+#else
+static inline void udbg_shutdown_ps3gelic(void) {}
+#endif
+
 extern int gelic_card_set_irq_mask(struct gelic_card *card, u64 mask);
 /* shared netdev ops */
 extern void gelic_card_up(struct gelic_card *card);
-- 
1.7.5.4
