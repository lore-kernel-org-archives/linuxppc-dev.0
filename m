Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vz1Yw5c6BzDqNZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Apr 2017 09:01:56 +1000 (AEST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id v35N1XK8021608
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Apr 2017 18:01:36 -0500
Message-ID: <1491433293.4166.97.camel@kernel.crashing.org>
Subject: [PATCH] powerpc: Add XIVE related definitions to opal-api.h
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Date: Thu, 06 Apr 2017 09:01:33 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

That should have been the first patch in the XIVE series...

 arch/powerpc/include/asm/opal-api.h            | 74 +++++++++++++++++++++++++-
 arch/powerpc/include/asm/opal.h                | 36 +++++++++++++
 arch/powerpc/platforms/powernv/opal-wrappers.S | 15 ++++++
 3 files changed, 124 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index a0aa285..bc8ac3c 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -40,6 +40,8 @@
 #define OPAL_I2C_ARBT_LOST	-22
 #define OPAL_I2C_NACK_RCVD	-23
 #define OPAL_I2C_STOP_ERR	-24
+#define OPAL_XIVE_PROVISIONING	-31
+#define OPAL_XIVE_FREE_ACTIVE	-32
 
 /* API Tokens (in r0) */
 #define OPAL_INVALID_CALL		       -1
@@ -168,7 +170,24 @@
 #define OPAL_INT_SET_MFRR			125
 #define OPAL_PCI_TCE_KILL			126
 #define OPAL_NMMU_SET_PTCR			127
-#define OPAL_LAST				127
+#define OPAL_XIVE_RESET				128
+#define OPAL_XIVE_GET_IRQ_INFO			129
+#define OPAL_XIVE_GET_IRQ_CONFIG		130
+#define OPAL_XIVE_SET_IRQ_CONFIG		131
+#define OPAL_XIVE_GET_QUEUE_INFO		132
+#define OPAL_XIVE_SET_QUEUE_INFO		133
+#define OPAL_XIVE_DONATE_PAGE			134
+#define OPAL_XIVE_ALLOCATE_VP_BLOCK		135
+#define OPAL_XIVE_FREE_VP_BLOCK			136
+#define OPAL_XIVE_GET_VP_INFO			137
+#define OPAL_XIVE_SET_VP_INFO			138
+#define OPAL_XIVE_ALLOCATE_IRQ			139
+#define OPAL_XIVE_FREE_IRQ			140
+#define OPAL_XIVE_SYNC				141
+#define OPAL_XIVE_DUMP				142
+#define OPAL_XIVE_RESERVED3			143
+#define OPAL_XIVE_RESERVED4			144
+#define OPAL_LAST				144
 
 /* Device tree flags */
 
@@ -928,6 +947,59 @@ enum {
 	OPAL_PCI_TCE_KILL_ALL,
 };
 
+/* The xive operation mode indicates the active "API" and
+ * corresponds to the "mode" parameter of the opal_xive_reset()
+ * call
+ */
+enum {
+	OPAL_XIVE_MODE_EMU	= 0,
+	OPAL_XIVE_MODE_EXPL	= 1,
+};
+
+/* Flags for OPAL_XIVE_GET_IRQ_INFO */
+enum {
+	OPAL_XIVE_IRQ_TRIGGER_PAGE	= 0x00000001,
+	OPAL_XIVE_IRQ_STORE_EOI		= 0x00000002,
+	OPAL_XIVE_IRQ_LSI		= 0x00000004,
+	OPAL_XIVE_IRQ_SHIFT_BUG		= 0x00000008,
+	OPAL_XIVE_IRQ_MASK_VIA_FW	= 0x00000010,
+	OPAL_XIVE_IRQ_EOI_VIA_FW	= 0x00000020,
+};
+
+/* Flags for OPAL_XIVE_GET/SET_QUEUE_INFO */
+enum {
+	OPAL_XIVE_EQ_ENABLED		= 0x00000001,
+	OPAL_XIVE_EQ_ALWAYS_NOTIFY	= 0x00000002,
+	OPAL_XIVE_EQ_ESCALATE		= 0x00000004,
+};
+
+/* Flags for OPAL_XIVE_GET/SET_VP_INFO */
+enum {
+	OPAL_XIVE_VP_ENABLED		= 0x00000001,
+};
+
+/* "Any chip" replacement for chip ID for allocation functions */
+enum {
+	OPAL_XIVE_ANY_CHIP		= 0xffffffff,
+};
+
+/* Xive sync options */
+enum {
+	/* This bits are cumulative, arg is a girq */
+	XIVE_SYNC_EAS			= 0x00000001, /* Sync irq source */
+	XIVE_SYNC_QUEUE			= 0x00000002, /* Sync irq target */
+};
+
+/* Dump options */
+enum {
+	XIVE_DUMP_TM_HYP	= 0,
+	XIVE_DUMP_TM_POOL	= 1,
+	XIVE_DUMP_TM_OS		= 2,
+	XIVE_DUMP_TM_USER	= 3,
+	XIVE_DUMP_VP		= 4,
+	XIVE_DUMP_EMU_STATE	= 5,
+};
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __OPAL_API_H */
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 1ff03a6..cb7d607 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -226,6 +226,42 @@ int64_t opal_pci_tce_kill(uint64_t phb_id, uint32_t kill_type,
 			  uint32_t pe_num, uint32_t tce_size,
 			  uint64_t dma_addr, uint32_t npages);
 int64_t opal_nmmu_set_ptcr(uint64_t chip_id, uint64_t ptcr);
+int64_t opal_xive_reset(uint64_t version);
+int64_t opal_xive_get_irq_info(uint32_t girq,
+			       __be64 *out_flags,
+			       __be64 *out_eoi_page,
+			       __be64 *out_trig_page,
+			       __be32 *out_esb_shift,
+			       __be32 *out_src_chip);
+int64_t opal_xive_get_irq_config(uint32_t girq, __be64 *out_vp,
+				 uint8_t *out_prio, __be32 *out_lirq);
+int64_t opal_xive_set_irq_config(uint32_t girq, uint64_t vp, uint8_t prio,
+				 uint32_t lirq);
+int64_t opal_xive_get_queue_info(uint64_t vp, uint32_t prio,
+				 __be64 *out_qpage,
+				 __be64 *out_qsize,
+				 __be64 *out_qeoi_page,
+				 __be32 *out_escalate_irq,
+				 __be64 *out_qflags);
+int64_t opal_xive_set_queue_info(uint64_t vp, uint32_t prio,
+				 uint64_t qpage,
+				 uint64_t qsize,
+				 uint64_t qflags);
+int64_t opal_xive_donate_page(uint32_t chip_id, uint64_t addr);
+int64_t opal_xive_alloc_vp_block(uint32_t alloc_order);
+int64_t opal_xive_free_vp_block(uint64_t vp);
+int64_t opal_xive_get_vp_info(uint64_t vp,
+			      __be64 *out_flags,
+			      __be64 *out_cam_value,
+			      __be64 *out_report_cl_pair,
+			      __be32 *out_chip_id);
+int64_t opal_xive_set_vp_info(uint64_t vp,
+			      uint64_t flags,
+			      uint64_t report_cl_pair);
+int64_t opal_xive_allocate_irq(uint32_t chip_id);
+int64_t opal_xive_free_irq(uint32_t girq);
+int64_t opal_xive_sync(uint32_t type, uint32_t id);
+int64_t opal_xive_dump(uint32_t type, uint32_t id);
 
 /* Internal functions */
 extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index da8a0f7..085605a 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -301,3 +301,18 @@ OPAL_CALL(opal_int_eoi,				OPAL_INT_EOI);
 OPAL_CALL(opal_int_set_mfrr,			OPAL_INT_SET_MFRR);
 OPAL_CALL(opal_pci_tce_kill,			OPAL_PCI_TCE_KILL);
 OPAL_CALL(opal_nmmu_set_ptcr,			OPAL_NMMU_SET_PTCR);
+OPAL_CALL(opal_xive_reset,			OPAL_XIVE_RESET);
+OPAL_CALL(opal_xive_get_irq_info,		OPAL_XIVE_GET_IRQ_INFO);
+OPAL_CALL(opal_xive_get_irq_config,		OPAL_XIVE_GET_IRQ_CONFIG);
+OPAL_CALL(opal_xive_set_irq_config,		OPAL_XIVE_SET_IRQ_CONFIG);
+OPAL_CALL(opal_xive_get_queue_info,		OPAL_XIVE_GET_QUEUE_INFO);
+OPAL_CALL(opal_xive_set_queue_info,		OPAL_XIVE_SET_QUEUE_INFO);
+OPAL_CALL(opal_xive_donate_page,		OPAL_XIVE_DONATE_PAGE);
+OPAL_CALL(opal_xive_alloc_vp_block,		OPAL_XIVE_ALLOCATE_VP_BLOCK);
+OPAL_CALL(opal_xive_free_vp_block,		OPAL_XIVE_FREE_VP_BLOCK);
+OPAL_CALL(opal_xive_allocate_irq,		OPAL_XIVE_ALLOCATE_IRQ);
+OPAL_CALL(opal_xive_free_irq,			OPAL_XIVE_FREE_IRQ);
+OPAL_CALL(opal_xive_get_vp_info,		OPAL_XIVE_GET_VP_INFO);
+OPAL_CALL(opal_xive_set_vp_info,		OPAL_XIVE_SET_VP_INFO);
+OPAL_CALL(opal_xive_sync,			OPAL_XIVE_SYNC);
+OPAL_CALL(opal_xive_dump,			OPAL_XIVE_DUMP);
