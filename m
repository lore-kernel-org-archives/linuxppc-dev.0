Return-Path: <martijn.de.gouw@prodrive-technologies.com>
Received: from mail.prodrive.nl (mail.prodrive.nl [212.61.153.67])
 by lists.ozlabs.org (Postfix) with ESMTP id CF4DD1A0177
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jun 2014 00:12:09 +1000 (EST)
From: Martijn de Gouw <martijn.de.gouw@prodrive-technologies.com>
To: <Alexandre.Bounine@idt.com>
Subject: [PATCH v2] fsl-rio: add support for mapping inbound windows
Date: Mon, 23 Jun 2014 16:11:55 +0200
Message-ID: <1403532715-21389-1-git-send-email-martijn.de.gouw@prodrive-technologies.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Martijn de Gouw <martijn.de.gouw@prodrive.nl>,
 Martijn de Gouw <martijn.de.gouw@prodrive-technologies.com>,
 Barry.Wood@idt.com, scottwood@freescale.com,
 stef.van.os@prodrive-technologies.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Martijn de Gouw <martijn.de.gouw@prodrive.nl>

Add support for mapping and unmapping of inbound rapidio windows.

Signed-off-by: Martijn de Gouw <martijn.de.gouw@prodrive-technologies.com>
---
 arch/powerpc/sysdev/fsl_rio.c |   92 +++++++++++++++++++++++++++++++++++++++++
 arch/powerpc/sysdev/fsl_rio.h |   12 ++++++
 2 files changed, 104 insertions(+)

diff --git a/arch/powerpc/sysdev/fsl_rio.c b/arch/powerpc/sysdev/fsl_rio.c
index cf2b084..02fe69b 100644
--- a/arch/powerpc/sysdev/fsl_rio.c
+++ b/arch/powerpc/sysdev/fsl_rio.c
@@ -58,6 +58,19 @@
 #define RIO_ISR_AACR		0x10120
 #define RIO_ISR_AACR_AA		0x1	/* Accept All ID */
 
+#define RIWTAR_TRAD_VAL_SHIFT	12
+#define RIWTAR_TRAD_MASK	0x00FFFFFF
+#define RIWBAR_BADD_VAL_SHIFT	12
+#define RIWBAR_BADD_MASK	0x003FFFFF
+#define RIWAR_ENABLE		0x80000000
+#define RIWAR_TGINT_LOCAL	0x00F00000
+#define RIWAR_RDTYP_NO_SNOOP	0x00040000
+#define RIWAR_RDTYP_SNOOP	0x00050000
+#define RIWAR_WRTYP_NO_SNOOP	0x00004000
+#define RIWAR_WRTYP_SNOOP	0x00005000
+#define RIWAR_WRTYP_ALLOC	0x00006000
+#define RIWAR_SIZE_MASK		0x0000003F
+
 #define __fsl_read_rio_config(x, addr, err, op)		\
 	__asm__ __volatile__(				\
 		"1:	"op" %1,0(%2)\n"		\
@@ -266,6 +279,80 @@ fsl_rio_config_write(struct rio_mport *mport, int index, u16 destid,
 	return 0;
 }
 
+static void fsl_rio_inbound_mem_init(struct rio_priv *priv)
+{
+	int i;
+
+	/* close inbound windows */
+	for (i = 0; i < RIO_INB_ATMU_COUNT; i++)
+		out_be32(&priv->inb_atmu_regs[i].riwar, 0);
+}
+
+int fsl_map_inb_mem(struct rio_mport *mport, dma_addr_t lstart,
+	u64 rstart, u32 size, u32 flags)
+{
+	struct rio_priv *priv = mport->priv;
+	u32 base_size;
+	unsigned int base_size_log;
+	u64 win_start, win_end;
+	u32 riwar;
+	int i;
+
+	base_size_log = __ilog2(size) + ((size & (size - 1)) != 0);
+	base_size = 1 << base_size_log;
+
+	/* check for conflicting ranges */
+	for (i = 0; i < RIO_INB_ATMU_COUNT; i++) {
+		riwar = in_be32(&priv->inb_atmu_regs[i].riwar);
+		if ((riwar & RIWAR_ENABLE) == 0)
+			continue;
+		win_start = ((u64)(in_be32(&priv->inb_atmu_regs[i].riwbar) & RIWBAR_BADD_MASK))
+			<< RIWBAR_BADD_VAL_SHIFT;
+		win_end = win_start + ((1 << ((riwar & RIWAR_SIZE_MASK) + 1)) - 1);
+		if (rstart < win_end && (rstart + size) > win_start)
+			return -EINVAL;
+	}
+
+	/* find unused atmu */
+	for (i = 0; i < RIO_INB_ATMU_COUNT; i++) {
+		riwar = in_be32(&priv->inb_atmu_regs[i].riwar);
+		if ((riwar & RIWAR_ENABLE) == 0)
+			break;
+	}
+	if (i >= RIO_INB_ATMU_COUNT)
+		return -ENOMEM;
+
+	out_be32(&priv->inb_atmu_regs[i].riwtar, lstart >> RIWTAR_TRAD_VAL_SHIFT);
+	out_be32(&priv->inb_atmu_regs[i].riwbar, rstart >> RIWBAR_BADD_VAL_SHIFT);
+	out_be32(&priv->inb_atmu_regs[i].riwar, RIWAR_ENABLE | RIWAR_TGINT_LOCAL |
+		RIWAR_RDTYP_SNOOP | RIWAR_WRTYP_SNOOP | (base_size_log - 1));
+
+	return 0;
+}
+
+void fsl_unmap_inb_mem(struct rio_mport *mport, dma_addr_t lstart)
+{
+	u32 win_start_shift, base_start_shift;
+	struct rio_priv *priv = mport->priv;
+	u32 riwar, riwtar;
+	int i;
+
+	/* skip default window */
+	base_start_shift = lstart >> RIWTAR_TRAD_VAL_SHIFT;
+	for (i = 0; i < RIO_INB_ATMU_COUNT; i++) {
+		riwar = in_be32(&priv->inb_atmu_regs[i].riwar);
+		if ((riwar & RIWAR_ENABLE) == 0)
+			continue;
+
+		riwtar = in_be32(&priv->inb_atmu_regs[i].riwtar);
+		win_start_shift = riwtar & RIWTAR_TRAD_MASK;
+		if (win_start_shift == base_start_shift) {
+			out_be32(&priv->inb_atmu_regs[i].riwar, riwar & ~RIWAR_ENABLE);
+			return;
+		}
+	}
+}
+
 void fsl_rio_port_error_handler(int offset)
 {
 	/*XXX: Error recovery is not implemented, we just clear errors */
@@ -389,6 +476,8 @@ int fsl_rio_setup(struct platform_device *dev)
 	ops->add_outb_message = fsl_add_outb_message;
 	ops->add_inb_buffer = fsl_add_inb_buffer;
 	ops->get_inb_message = fsl_get_inb_message;
+	ops->map_inb = fsl_map_inb_mem;
+	ops->unmap_inb = fsl_unmap_inb_mem;
 
 	rmu_node = of_parse_phandle(dev->dev.of_node, "fsl,srio-rmu-handle", 0);
 	if (!rmu_node)
@@ -598,6 +687,8 @@ int fsl_rio_setup(struct platform_device *dev)
 			RIO_ATMU_REGS_PORT2_OFFSET));
 
 		priv->maint_atmu_regs = priv->atmu_regs + 1;
+		priv->inb_atmu_regs = (struct rio_inb_atmu_regs *)
+			(priv->regs_win + RIO_INB_ATMU_REGS_OFFSET);
 
 		/* Set to receive any dist ID for serial RapidIO controller. */
 		if (port->phy_type == RIO_PHY_SERIAL)
@@ -616,6 +707,7 @@ int fsl_rio_setup(struct platform_device *dev)
 		rio_law_start = range_start;
 
 		fsl_rio_setup_rmu(port, rmu_np[i]);
+		fsl_rio_inbound_mem_init(priv);
 
 		dbell->mport[i] = port;
 
diff --git a/arch/powerpc/sysdev/fsl_rio.h b/arch/powerpc/sysdev/fsl_rio.h
index ae8e274..dad17f9 100644
--- a/arch/powerpc/sysdev/fsl_rio.h
+++ b/arch/powerpc/sysdev/fsl_rio.h
@@ -50,9 +50,11 @@
 #define RIO_S_DBELL_REGS_OFFSET	0x13400
 #define RIO_S_PW_REGS_OFFSET	0x134e0
 #define RIO_ATMU_REGS_DBELL_OFFSET	0x10C40
+#define RIO_INB_ATMU_REGS_OFFSET 0x10d60
 
 #define MAX_MSG_UNIT_NUM	2
 #define MAX_PORT_NUM		4
+#define RIO_INB_ATMU_COUNT	4
 
 struct rio_atmu_regs {
 	 u32 rowtar;
@@ -63,6 +65,15 @@ struct rio_atmu_regs {
 	 u32 pad2[3];
 };
 
+struct rio_inb_atmu_regs {
+	u32 riwtar;
+	u32 pad1;
+	u32 riwbar;
+	u32 pad2;
+	u32 riwar;
+	u32 pad3[3];
+};
+
 struct rio_dbell_ring {
 	void *virt;
 	dma_addr_t phys;
@@ -99,6 +110,7 @@ struct rio_priv {
 	void __iomem *regs_win;
 	struct rio_atmu_regs __iomem *atmu_regs;
 	struct rio_atmu_regs __iomem *maint_atmu_regs;
+	struct rio_inb_atmu_regs __iomem *inb_atmu_regs;
 	void __iomem *maint_win;
 	void *rmm_handle; /* RapidIO message manager(unit) Handle */
 };
-- 
1.7.10.4
