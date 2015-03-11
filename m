Return-Path: <Igal.Liberman@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0124.outbound.protection.outlook.com [207.46.100.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EF5CD1A1128
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2015 20:13:06 +1100 (AEDT)
From: Igal.Liberman <igal.liberman@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: [RFC,4/8] soc/fman: Add FMan Parser and Keygen support
Date: Wed, 11 Mar 2015 07:08:29 +0200
Message-ID: <1426050509-12606-1-git-send-email-igal.liberman@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com, Igal Liberman <Igal.Liberman@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Igal Liberman <Igal.Liberman@freescale.com>

Signed-off-by: Igal Liberman <Igal.Liberman@freescale.com>
---
 drivers/soc/fsl/fman/fm.c             |   38 +++
 drivers/soc/fsl/fman/fm.h             |    1 +
 drivers/soc/fsl/fman/fm_common.h      |   32 +++
 drivers/soc/fsl/fman/fm_drv.c         |   89 ++++++-
 drivers/soc/fsl/fman/fm_drv.h         |   18 ++
 drivers/soc/fsl/fman/inc/fm_pcd_ext.h |  167 +++++++++++++
 drivers/soc/fsl/fman/pcd/Makefile     |    2 +-
 drivers/soc/fsl/fman/pcd/fm_pcd.c     |  428 +++++++++++++++++++++++++++++++++
 drivers/soc/fsl/fman/pcd/fm_pcd.h     |  145 +++++++++++
 drivers/soc/fsl/fman/pcd/fm_prs.c     |  276 +++++++++++++++++++++
 drivers/soc/fsl/fman/pcd/fm_prs.h     |  163 +++++++++++++
 11 files changed, 1357 insertions(+), 2 deletions(-)
 create mode 100644 drivers/soc/fsl/fman/inc/fm_pcd_ext.h
 create mode 100644 drivers/soc/fsl/fman/pcd/fm_pcd.c
 create mode 100644 drivers/soc/fsl/fman/pcd/fm_pcd.h
 create mode 100644 drivers/soc/fsl/fman/pcd/fm_prs.c
 create mode 100644 drivers/soc/fsl/fman/pcd/fm_prs.h

diff --git a/drivers/soc/fsl/fman/fm.c b/drivers/soc/fsl/fman/fm.c
index 56711cb..1d32d446 100644
--- a/drivers/soc/fsl/fman/fm.c
+++ b/drivers/soc/fsl/fman/fm.c
@@ -721,6 +721,17 @@ uint16_t fm_get_tnum_aging_period(void *h_fm)
 	return p_fm->tnum_aging_period;
 }
 
+uintptr_t fm_get_pcd_prs_base_addr(void *h_fm)
+{
+	struct fm_t *p_fm = (struct fm_t *)h_fm;
+
+	if (!p_fm->base_addr) {
+		pr_err("No base-addr!\n");
+		return 0;
+	}
+	return p_fm->base_addr + FM_MM_PRS;
+}
+
 struct muram_info *fm_get_muram_pointer(void *h_fm)
 {
 	struct fm_t *p_fm = (struct fm_t *)h_fm;
@@ -847,6 +858,33 @@ void fm_unregister_fman_ctrl_intr(void *h_fm, uint8_t event_reg_id)
 	p_fm->fman_ctrl_intr[event_reg_id].h_src_handle = NULL;
 }
 
+void fm_register_pcd(void *h_fm, void *h_fm_pcd)
+{
+	struct fm_t *p_fm = (struct fm_t *)h_fm;
+
+	if (p_fm->h_pcd)
+		pr_err("PCD already set\n");
+
+	p_fm->h_pcd = h_fm_pcd;
+}
+
+void fm_unregister_pcd(void *h_fm)
+{
+	struct fm_t *p_fm = (struct fm_t *)h_fm;
+
+	if (!p_fm->h_pcd)
+		pr_err("PCD handle!\n");
+
+	p_fm->h_pcd = NULL;
+}
+
+void *fm_get_pcd_handle(void *h_fm)
+{
+	struct fm_t *p_fm = (struct fm_t *)h_fm;
+
+	return p_fm->h_pcd;
+}
+
 uint8_t fm_get_id(void *h_fm)
 {
 	struct fm_t *p_fm = (struct fm_t *)h_fm;
diff --git a/drivers/soc/fsl/fman/fm.h b/drivers/soc/fsl/fman/fm.h
index 332f2e6..eb71103 100644
--- a/drivers/soc/fsl/fman/fm.h
+++ b/drivers/soc/fsl/fman/fm.h
@@ -452,6 +452,7 @@ struct fm_t {
 	uintptr_t base_addr;
 
 /* un-needed for recovery */
+	void *h_pcd;
 	char fm_module_name[MODULE_NAME_SIZE];
 	/* FM exceptions user callback */
 	struct fm_intr_src_t intr_mng[FM_EV_DUMMY_LAST];
diff --git a/drivers/soc/fsl/fman/fm_common.h b/drivers/soc/fsl/fman/fm_common.h
index f380133..1e3422c 100644
--- a/drivers/soc/fsl/fman/fm_common.h
+++ b/drivers/soc/fsl/fman/fm_common.h
@@ -38,6 +38,7 @@
 
 #include "service.h"
 #include "fm_ext.h"
+#include "fm_pcd_ext.h"
 
 #define CLS_PLAN_NUM_PER_GRP                        8
 
@@ -238,6 +239,27 @@ default:                                                \
 ((cls_plan_entries == 256) ? 8 : ((cls_plan_entries == 128) ? 7 : \
 ((cls_plan_entries == 64) ? 6 : ((cls_plan_entries == 32) ? 5 : 0))))
 
+struct fm_pcd_lock_t {
+	spinlock_t *spinlock;
+	volatile bool flag;
+	struct list_head node;
+};
+
+#define FM_PCD_LOCK_OBJ(ptr)  list_object(ptr, struct fm_pcd_lock_t, node)
+
+/* Common API for FM-PCD module */
+uint32_t fm_pcd_get_sw_prs_offset(void *h_fm_pcd, enum net_header_type hdr,
+				  uint8_t index_per_hdr);
+uint32_t fm_pcd_lock(void *h_fm_pcd);
+void fm_pcd_unlock(void *h_fm_pcd, unsigned long int_flags);
+bool fm_pcd_lock_try_lock_all(void *h_fm_pcd);
+void fm_pcd_lock_unlock_all(void *h_fm_pcd);
+
+/* Common API for FM-PCD parser module */
+int fm_pcd_prs_include_port_in_statistics(void *p_fm_pcd,
+					  uint8_t port_id,
+					  bool include);
+
 /* Function      fm_register_intr
  * Description   Used to register
  * an inter-module event handler to be processed by FM
@@ -276,6 +298,13 @@ enum fm_mac_type {
 	FM_MAC_1G	    /* 1G MAC */
 };
 
+/* Function      fm_get_pcd_prs_base_addr
+ * Description   Get the base address of the Parser from the FM module
+ * Param[in]     h_fm            A handle to an FM Module.
+ * Return        Base address.
+ */
+uintptr_t fm_get_pcd_prs_base_addr(void *h_fm);
+
 /* Function      fm_get_muram_pointer
  * Description   Get the pointer of the MURAM from the FM module
  * Param[in]     h_fm            A handle to an FM Module.
@@ -335,6 +364,9 @@ int fm_set_num_of_riscs_per_port(void *h_fm, uint8_t port_id,
 				 uint8_t num_of_fman_ctrls,
 				 fm_fman_ctrl_t or_fman_ctrl);
 
+void fm_register_pcd(void *h_fm, void *h_fm_pcd);
+void fm_unregister_pcd(void *h_fm);
+void *fm_get_pcd_handle(void *h_fm);
 int _fm_enable_rams_ecc(void *h_fm);
 int _fm_disable_rams_ecc(void *h_fm);
 int fm_alloc_fman_ctrl_event_reg(void *h_fm, uint8_t *p_event_id);
diff --git a/drivers/soc/fsl/fman/fm_drv.c b/drivers/soc/fsl/fman/fm_drv.c
index ffeb223..cacd318 100644
--- a/drivers/soc/fsl/fman/fm_drv.c
+++ b/drivers/soc/fsl/fman/fm_drv.c
@@ -55,7 +55,7 @@
 
 /* Internal services */
 #include "service.h"
-#include "fm_ext.h"
+#include "fm_common.h"
 #include "fm_drv.h"
 #include "fm_muram_ext.h"
 
@@ -219,6 +219,58 @@ static void destroy_fm_dev(struct lnx_wrp_fm_dev_t *p_lnx_wrp_fm_dev)
 	kfree(p_lnx_wrp_fm_dev);
 }
 
+#ifdef CONFIG_FSL_FMAN_PCD
+static void lnxwrp_fm_pcd_dev_exceptions_cb(void *h_app,
+					    enum fm_pcd_exceptions
+					    __maybe_unused exception)
+{
+	struct lnx_wrp_fm_dev_t *p_lnx_wrp_fm_dev =
+					(struct lnx_wrp_fm_dev_t *)h_app;
+
+	ASSERT(p_lnx_wrp_fm_dev);
+
+	pr_debug("got fm-pcd exception %d\n", exception);
+
+	/* do nothing */
+}
+
+static int init_fm_pcd_dev(struct lnx_wrp_fm_dev_t *p_lnx_wrp_fm_dev)
+{
+	if (p_lnx_wrp_fm_dev->pcd_active) {
+		struct fm_pcd_params_t fm_pcd_params;
+		int err;
+
+		memset(&fm_pcd_params, 0, sizeof(fm_pcd_params));
+		fm_pcd_params.h_fm = p_lnx_wrp_fm_dev->h_dev;
+		fm_pcd_params.prs_support = p_lnx_wrp_fm_dev->prs_active;
+
+		fm_pcd_params.f_exception = lnxwrp_fm_pcd_dev_exceptions_cb;
+		fm_pcd_params.h_app = p_lnx_wrp_fm_dev;
+
+		p_lnx_wrp_fm_dev->h_pcd_dev = fm_pcd_config(&fm_pcd_params);
+		if (!p_lnx_wrp_fm_dev->h_pcd_dev) {
+			pr_err("FM PCD!\n");
+			return -ENOSYS;
+		}
+
+		err = fm_pcd_init(p_lnx_wrp_fm_dev->h_pcd_dev);
+		if (err != 0)
+			return err;
+
+		if (p_lnx_wrp_fm_dev->err_irq == 0) {
+			fm_pcd_set_exception(p_lnx_wrp_fm_dev->h_pcd_dev,
+					     FM_PCD_PRS_EXCEPTION_DOUBLE_ECC,
+					    false);
+			fm_pcd_set_exception(p_lnx_wrp_fm_dev->h_pcd_dev,
+					     FM_PCD_PRS_EXCEPTION_SINGLE_ECC,
+					    false);
+		}
+	}
+
+	return 0;
+}
+#endif
+
 /**
 *find_fman_microcode - find the Fman microcode
  *
@@ -449,6 +501,23 @@ static struct lnx_wrp_fm_dev_t *read_fm_dev_tree_node(struct platform_device
 	}
 #endif
 
+#ifdef CONFIG_FSL_FMAN_PCD
+	/* Enable relevant PCD nodes - Parser */
+	p_lnx_wrp_fm_dev->prs_active = true;
+	p_lnx_wrp_fm_dev->pcd_active = true;
+
+	if (p_lnx_wrp_fm_dev->pcd_active) {
+		const char *str_prop =
+		    (char *)of_get_property(fm_node, "fsl,default-pcd", &lenp);
+		if (str_prop) {
+			if (strncmp(str_prop, "3-tuple", strlen("3-tuple")) ==
+			    0)
+				p_lnx_wrp_fm_dev->def_pcd = FM_PCD_3_TUPLE;
+		} else
+			p_lnx_wrp_fm_dev->def_pcd = e_NO_PCD;
+	}
+#endif
+
 	of_node_put(fm_node);
 
 	p_lnx_wrp_fm_dev->active = true;
@@ -684,6 +753,12 @@ static int init_fm_dev(struct lnx_wrp_fm_dev_t *p_lnx_wrp_fm_dev)
 		return -ENOSYS;
 	}
 
+#ifdef CONFIG_FSL_FMAN_PCD
+	if (init_fm_pcd_dev(p_lnx_wrp_fm_dev) != 0) {
+		pr_err("FM-PCD\n");
+		return -ENOSYS;
+	}
+#endif
 	/* TODO: Why we mask these interrupts? */
 	if (p_lnx_wrp_fm_dev->err_irq == 0) {
 		fm_set_exception(p_lnx_wrp_fm_dev->h_dev,
@@ -760,11 +835,23 @@ static int init_fm_dev(struct lnx_wrp_fm_dev_t *p_lnx_wrp_fm_dev)
 	return 0;
 }
 
+#ifdef CONFIG_FSL_FMAN_PCD
+void free_fm_pcd_dev(struct lnx_wrp_fm_dev_t *p_lnx_wrp_fm_dev)
+{
+	if (p_lnx_wrp_fm_dev->h_pcd_dev)
+		fm_pcd_free(p_lnx_wrp_fm_dev->h_pcd_dev);
+}
+#endif
+
 static void free_fm_dev(struct lnx_wrp_fm_dev_t *p_lnx_wrp_fm_dev)
 {
 	if (!p_lnx_wrp_fm_dev->active)
 		return;
 
+#ifdef CONFIG_FSL_FMAN_PCD
+	free_fm_pcd_dev(p_lnx_wrp_fm_dev);
+#endif
+
 #ifdef CONFIG_FSL_FMAN_RTC
 	if (p_lnx_wrp_fm_dev->h_rtc_dev)
 		fm_rtc_free((struct fm *)p_lnx_wrp_fm_dev);
diff --git a/drivers/soc/fsl/fman/fm_drv.h b/drivers/soc/fsl/fman/fm_drv.h
index c2831a7..3905795 100644
--- a/drivers/soc/fsl/fman/fm_drv.h
+++ b/drivers/soc/fsl/fman/fm_drv.h
@@ -61,6 +61,13 @@
 #define TX_10G_PORT_BASE		0x30
 #define RX_10G_PORT_BASE		0x10
 
+#ifdef CONFIG_FSL_FMAN_PCD
+enum lnx_wrp_fm_port_pcd_def_use_case {
+	e_NO_PCD = 0,
+	FM_PCD_3_TUPLE
+};
+#endif
+
 struct lnx_wrp_fm_port_dev_t {
 	uint8_t id;
 	char name[20];
@@ -68,6 +75,9 @@ struct lnx_wrp_fm_port_dev_t {
 	uint64_t phys_base_addr;
 	uint64_t base_addr;	/* Port's *virtual* address */
 	resource_size_t mem_size;
+#ifdef CONFIG_FSL_FMAN_PCD
+	enum lnx_wrp_fm_port_pcd_def_use_case def_pcd;
+#endif
 	struct fm_buffer_prefix_content_t buff_prefix_content;
 	void *h_dev;
 	void *h_lnx_wrp_fm_dev;
@@ -86,6 +96,11 @@ struct lnx_wrp_fm_dev_t {
 	uint8_t id;
 	char name[10];
 	bool active;
+#ifdef CONFIG_FSL_FMAN_PCD
+	bool pcd_active;
+	bool prs_active;
+	enum lnx_wrp_fm_port_pcd_def_use_case def_pcd;
+#endif
 	uint64_t fm_phys_base_addr;
 	uint64_t fm_base_addr;
 	resource_size_t fm_mem_size;
@@ -101,6 +116,9 @@ struct lnx_wrp_fm_dev_t {
 	int err_irq;
 	struct fm_params_t params;
 	void *h_dev;
+#ifdef CONFIG_FSL_FMAN_PCD
+	void *h_pcd_dev;
+#endif
 #ifdef CONFIG_FSL_FMAN_RTC
 	void *h_rtc_dev;
 #endif
diff --git a/drivers/soc/fsl/fman/inc/fm_pcd_ext.h b/drivers/soc/fsl/fman/inc/fm_pcd_ext.h
new file mode 100644
index 0000000..c716532
--- /dev/null
+++ b/drivers/soc/fsl/fman/inc/fm_pcd_ext.h
@@ -0,0 +1,167 @@
+/*
+ * Copyright 2008-2015 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+/*File          fm_pcd_ext.h
+ * FM PCD API definitions
+ */
+#ifndef __FM_PCD_EXT
+#define __FM_PCD_EXT
+
+#include "service.h"
+#include "net_ext.h"
+#include "fm_ext.h"
+
+/* Frame Manager PCD (Parse-Classify-Distribute) API.
+ * The FM PCD module is responsible for the initialization of all global
+ * classifying FM modules. This includes the parser general and common
+ * registers.
+ */
+
+/* General PCD defines */
+
+/* Number of headers supported by HW parser
+ * Number of distinction units is limited by register size (32 bits) minus
+ * reserved bits for private headers.
+ */
+#define FM_PCD_PRS_NUM_OF_HDRS                      16
+/* Maximum number of SW parser labels */
+#define FM_PCD_PRS_NUM_OF_LABELS                    32
+/* Total size of SW parser area */
+#define FM_PCD_SW_PRS_SIZE                          0x00000800
+
+/* Frame Manager PCD Initialization Unit API */
+
+/* PCD interrupts */
+enum fm_pcd_exceptions {
+	/* Parser double-bit ECC error */
+	FM_PCD_PRS_EXCEPTION_DOUBLE_ECC,
+	/* Parser single-bit ECC error */
+	FM_PCD_PRS_EXCEPTION_SINGLE_ECC
+};
+
+/*Description   Exceptions user callback routine, will be called upon an
+ *		exception passing the exception identification.
+ *Param[in]     h_app      - User's application descriptor.
+ *Param[in]     exception  - The exception.
+ */
+typedef void (fm_pcd_exception_cb) (void *h_app,
+					 enum fm_pcd_exceptions exception);
+
+/* The main structure for PCD initialization */
+struct fm_pcd_params_t {
+	/* true if Parser will be used for any of the FM ports. */
+	bool prs_support;
+	/* A handle to the FM module. */
+	void *h_fm;
+	/* Callback routine for general PCD exceptions;
+	 * Relevant when FM not runs in "guest-mode".
+	 **/
+	fm_pcd_exception_cb *f_exception;
+	/* A handle to an application layer object;
+	 * This handle will be passed by the driver upon calling
+	 * the above callbacks; Relevant when FM not runs in "guest-mode".
+	 */
+	void *h_app;
+};
+
+/*Function      fm_pcd_config
+ *Description   Basic configuration of the PCD module.
+ *		Creates descriptor for the FM PCD module.
+ *Param[in]     p_fm_pcd_params    A structure of parameters for the
+ *                                    initialization of PCD.
+ *Return        A handle to the initialized module.
+ */
+void *fm_pcd_config(struct fm_pcd_params_t *p_fm_pcd_params);
+
+/*Function      fm_pcd_init
+ *Description   Initialization of the PCD module.
+ *Param[in]     h_fm_pcd - FM PCD module descriptor.
+ *Return        0 on success; Error code otherwise.
+ */
+int fm_pcd_init(void *h_fm_pcd);
+
+/*Function      fm_pcd_free
+ *Description   Frees all resources that were assigned to FM module.
+ *		Calling this routine invalidates the descriptor.
+ *Param[in]     h_fm_pcd - FM PCD module descriptor.
+ *Return        0 on success; Error code otherwise.
+ */
+int fm_pcd_free(void *h_fm_pcd);
+
+/* Frame Manager PCD Runtime Unit API */
+
+/* A structure for SW parser labels*/
+struct fm_pcd_prs_label_params_t {
+	/* SW parser label instruction offset (2 bytes resolution),
+	 * relative to Parser RAM.
+	 */
+	uint32_t instruction_offset;
+	/* The existence of this header will invoke the SW parser code. */
+	enum net_header_type hdr;
+	/* Normally 0, if more than one SW parser  attachments for the
+	 * same header, use this index to distinguish between them.
+	 */
+	uint8_t index_per_hdr;
+};
+
+/*Function      fm_pcd_enable
+ *Description   This routine should be called after PCD is initialized for
+ *              enabling all
+ *		PCD engines according to their existing configuration.
+ *Param[in]     h_fm_pcd         FM PCD module descriptor.
+ *Return        0 on success; Error code otherwise.
+ *  Cautions      Allowed only following fm_pcd_init() and when PCD is disabled.
+ */
+int fm_pcd_enable(void *h_fm_pcd);
+
+/*Function      fm_pcd_disable
+ *Description   This routine may be called when PCD is enabled in order to
+ *		disable all PCD engines. It may be called
+ *		only when none of the ports in the system are using the PCD.
+ *Param[in]     h_fm_pcd         FM PCD module descriptor.
+ *Return        0 on success; Error code otherwise.
+ *  Cautions      Allowed only following fm_pcd_init() and when PCD is enabled.
+ */
+int fm_pcd_disable(void *h_fm_pcd);
+
+/*Function      fm_pcd_set_exception
+ *Description   Calling this routine enables/disables PCD interrupts.
+ *Param[in]     h_fm_pcd         FM PCD module descriptor.
+ *Param[in]     exception       The exception to be selected.
+ *Param[in]     enable          true to enable interrupt, false to mask it.
+ *Return        0 on success; Error code otherwise.
+ *  Cautions      Allowed only following fm_pcd_init().
+ */
+int fm_pcd_set_exception(void *h_fm_pcd, enum fm_pcd_exceptions
+			     exception, bool enable);
+
+#endif /* __FM_PCD_EXT */
diff --git a/drivers/soc/fsl/fman/pcd/Makefile b/drivers/soc/fsl/fman/pcd/Makefile
index b50aeac..e3ca6ff 100644
--- a/drivers/soc/fsl/fman/pcd/Makefile
+++ b/drivers/soc/fsl/fman/pcd/Makefile
@@ -1,3 +1,3 @@
 obj-$(CONFIG_FSL_FMAN_PCD)	+= fsl_fman_pcd.o
 
-fsl_fman_pcd-objs		:= fman_kg.o fman_prs.o
+fsl_fman_pcd-objs		:= fman_kg.o fman_prs.o fm_pcd.o fm_prs.o
diff --git a/drivers/soc/fsl/fman/pcd/fm_pcd.c b/drivers/soc/fsl/fman/pcd/fm_pcd.c
new file mode 100644
index 0000000..df490ce
--- /dev/null
+++ b/drivers/soc/fsl/fman/pcd/fm_pcd.c
@@ -0,0 +1,428 @@
+/*
+ * Copyright 2008 - 2015 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *	 notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *	 notice, this list of conditions and the following disclaimer in the
+ *	 documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *	 names of its contributors may be used to endorse or promote products
+ *	 derived from this software without specific prior written permission.
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include "service.h"
+#include "net_ext.h"
+#include "fm_ext.h"
+#include "fm_pcd_ext.h"
+
+#include "fm_common.h"
+#include "fm_pcd.h"
+#include "fm_muram_ext.h"
+
+#include <linux/string.h>
+#include <linux/slab.h>
+
+/* static functions */
+
+static int check_fm_pcd_parameters(struct fm_pcd_t *p_fm_pcd)
+{
+	if (!p_fm_pcd->h_fm) {
+		pr_err("h_fm has to be initialized\n");
+		return -EDOM;
+	}
+	if (!p_fm_pcd->f_exception) {
+		pr_err("f_FmPcdExceptions has to be initialized\n");
+		return -EDOM;
+	}
+	if (p_fm_pcd->p_fm_pcd_drv_param->prs_max_parse_cycle_limit >
+	    PRS_MAX_CYCLE_LIMIT) {
+		pr_err("prs_max_parse_cycle_limit has to be < 8191\n");
+		return -EDOM;
+	}
+	return 0;
+}
+
+static struct fm_pcd_lock_t *dequeue_lock_from_free_lst(struct fm_pcd_t
+							*p_fm_pcd)
+{
+	struct fm_pcd_lock_t *p_lock = NULL;
+	unsigned long int_flags;
+
+	spin_lock_irqsave(p_fm_pcd->spinlock, int_flags);
+	if (!list_empty(&p_fm_pcd->free_locks_lst)) {
+		p_lock = FM_PCD_LOCK_OBJ(p_fm_pcd->free_locks_lst.next);
+		list_del_init(&p_lock->node);
+	}
+	spin_unlock_irqrestore(p_fm_pcd->spinlock, int_flags);
+
+	return p_lock;
+}
+
+static void release_free_locks_lst(struct fm_pcd_t *p_fm_pcd)
+{
+	struct fm_pcd_lock_t *p_lock;
+
+	p_lock = dequeue_lock_from_free_lst(p_fm_pcd);
+	while (p_lock) {
+		kfree(p_lock->spinlock);
+		kfree(p_lock);
+		p_lock = dequeue_lock_from_free_lst(p_fm_pcd);
+	}
+}
+
+static struct fm_pcd_intg_t *set_pcd_intg_params(struct fm_pcd_t *p_fm_pcd)
+{
+	struct fm_pcd_intg_t *intg;
+
+	intg = kzalloc(sizeof(*intg), GFP_KERNEL);
+	if (!intg)
+		return NULL;
+
+	switch (p_fm_pcd->fm_rev_info.major_rev) {
+	case FM_IP_BLOCK_P2_P3_P5:
+	case FM_IP_BLOCK_P4:
+		intg->prs_sw_patches_size = 0x00000200;
+		break;
+
+	case FM_IP_BLOCK_P1:
+		intg->prs_sw_patches_size = 0x00000240;
+		break;
+
+	case FM_IP_BLOCK_B_T:
+		intg->prs_sw_patches_size = 0x00000240;
+		break;
+
+	default:
+		pr_err("Unsupported FMan version\n");
+		kfree(intg);
+		return NULL;
+	}
+
+	return intg;
+}
+
+/* Checks if p_fm_pcd driver parameters were initialized
+ * returns 0 if success else returns error
+ */
+static int is_init_done(struct fm_pcd_drv_param_t *p_fm_pcd_drv_param)
+{
+	if (p_fm_pcd_drv_param == NULL)
+		return 0;
+	return -ENOSYS;
+}
+
+/* Inter-module API routines */
+
+uint32_t fm_pcd_lock(void *h_fm_pcd)
+{
+	unsigned long int_flags;
+
+	spin_lock_irqsave(((struct fm_pcd_t *)h_fm_pcd)->spinlock, int_flags);
+	return int_flags;
+}
+
+void fm_pcd_unlock(void *h_fm_pcd, unsigned long int_flags)
+{
+	spin_unlock_irqrestore(((struct fm_pcd_t *)h_fm_pcd)->spinlock,
+			       int_flags);
+}
+
+bool fm_pcd_lock_try_lock_all(void *h_fm_pcd)
+{
+	uint32_t int_flags;
+	struct list_head *p_pos, *p_saved_pos = NULL;
+
+	int_flags = fm_pcd_lock(h_fm_pcd);
+	list_for_each(p_pos, &((struct fm_pcd_t *)h_fm_pcd)->
+		      acquired_locks_lst) {
+		struct fm_pcd_lock_t *p_lock = FM_PCD_LOCK_OBJ(p_pos);
+
+		if (!fm_pcd_lock_try_lock(p_lock)) {
+			p_saved_pos = p_pos;
+			break;
+		}
+	}
+	if (p_saved_pos) {
+		list_for_each(p_pos, &((struct fm_pcd_t *)h_fm_pcd)->
+					acquired_locks_lst) {
+			struct fm_pcd_lock_t *p_lock = FM_PCD_LOCK_OBJ(p_pos);
+
+			if (p_pos == p_saved_pos)
+				break;
+			fm_pcd_lock_unlock(p_lock);
+		}
+	}
+	fm_pcd_unlock(h_fm_pcd, int_flags);
+
+	/* Memory barrier */
+	mb();
+
+	if (p_saved_pos)
+		return false;
+
+	return true;
+}
+
+void fm_pcd_lock_unlock_all(void *h_fm_pcd)
+{
+	uint32_t int_flags;
+	struct list_head *p_pos;
+
+	int_flags = fm_pcd_lock(h_fm_pcd);
+	list_for_each(p_pos, &((struct fm_pcd_t *)h_fm_pcd)->
+				acquired_locks_lst) {
+		struct fm_pcd_lock_t *p_lock = FM_PCD_LOCK_OBJ(p_pos);
+
+		p_lock->flag = false;
+	}
+	fm_pcd_unlock(h_fm_pcd, int_flags);
+
+	/* Memory barrier */
+	mb();
+}
+
+/* End of inter-module routines */
+
+/* API Init unit functions */
+
+void *fm_pcd_config(struct fm_pcd_params_t *p_fm_pcd_params)
+{
+	struct fm_pcd_t *p_fm_pcd = NULL;
+
+	p_fm_pcd = kzalloc(sizeof(*p_fm_pcd), GFP_KERNEL);
+	if (!p_fm_pcd)
+		return NULL;
+
+	p_fm_pcd->p_fm_pcd_drv_param =
+	kzalloc(sizeof(*p_fm_pcd->p_fm_pcd_drv_param),
+		GFP_KERNEL);
+	if (!p_fm_pcd->p_fm_pcd_drv_param) {
+		kfree(p_fm_pcd);
+		pr_err("FM PCD Driver Param\n");
+		return NULL;
+	}
+
+	p_fm_pcd->h_fm = p_fm_pcd_params->h_fm;
+	fm_get_revision(p_fm_pcd->h_fm, &p_fm_pcd->fm_rev_info);
+	p_fm_pcd->pcd_intg = set_pcd_intg_params(p_fm_pcd);
+	if (!p_fm_pcd->pcd_intg) {
+			kfree(p_fm_pcd->p_fm_pcd_drv_param);
+			kfree(p_fm_pcd);
+			return NULL;
+	}
+
+	if (p_fm_pcd_params->prs_support) {
+		p_fm_pcd->p_fm_pcd_prs =
+		(struct fm_pcd_prs_t *)prs_config(p_fm_pcd, p_fm_pcd_params);
+
+		if (!p_fm_pcd->p_fm_pcd_prs) {
+			pr_err("FM PCD Parser\n");
+			fm_pcd_free(p_fm_pcd);
+			return NULL;
+		}
+	}
+
+	p_fm_pcd->spinlock = kmalloc(sizeof(spinlock_t), GFP_KERNEL);
+	if (!p_fm_pcd->spinlock) {
+		fm_pcd_free(p_fm_pcd);
+		return NULL;
+	}
+
+	spin_lock_init(p_fm_pcd->spinlock);
+
+	INIT_LIST_HEAD(&p_fm_pcd->free_locks_lst);
+	INIT_LIST_HEAD(&p_fm_pcd->acquired_locks_lst);
+
+	p_fm_pcd->f_exception = p_fm_pcd_params->f_exception;
+	p_fm_pcd->h_app = p_fm_pcd_params->h_app;
+
+	return p_fm_pcd;
+}
+
+int fm_pcd_init(void *h_fm_pcd)
+{
+	struct fm_pcd_t *p_fm_pcd = (struct fm_pcd_t *)h_fm_pcd;
+	int err = 0;
+	int ret, ret_err;
+
+	ret = is_init_done(p_fm_pcd->p_fm_pcd_drv_param);
+	if (!ret)
+		return -ENOSYS;
+
+	fm_get_revision(p_fm_pcd->h_fm, &p_fm_pcd->fm_rev_info);
+
+	ret_err = check_fm_pcd_parameters(p_fm_pcd);
+	if (ret_err)
+		return ret_err;
+
+	if (p_fm_pcd->p_fm_pcd_prs) {
+		err = prs_init(p_fm_pcd);
+		if (err)
+			return err;
+	}
+
+	kfree(p_fm_pcd->p_fm_pcd_drv_param);
+	p_fm_pcd->p_fm_pcd_drv_param = NULL;
+
+	fm_register_pcd(p_fm_pcd->h_fm, p_fm_pcd);
+
+	return 0;
+}
+
+int fm_pcd_free(void *h_fm_pcd)
+{
+	struct fm_pcd_t *p_fm_pcd = (struct fm_pcd_t *)h_fm_pcd;
+
+	if (p_fm_pcd->enabled)
+		fm_pcd_disable(p_fm_pcd);
+
+	kfree(p_fm_pcd->p_fm_pcd_drv_param);
+	p_fm_pcd->p_fm_pcd_drv_param = NULL;
+
+	kfree(p_fm_pcd->p_fm_pcd_prs);
+	p_fm_pcd->p_fm_pcd_prs = NULL;
+
+	fm_unregister_pcd(p_fm_pcd->h_fm);
+
+	release_free_locks_lst(p_fm_pcd);
+
+	kfree(p_fm_pcd->pcd_intg);
+
+	kfree(p_fm_pcd->spinlock);
+
+	kfree(p_fm_pcd);
+
+	return 0;
+}
+
+int fm_pcd_enable(void *h_fm_pcd)
+{
+	struct fm_pcd_t *p_fm_pcd = (struct fm_pcd_t *)h_fm_pcd;
+
+	if (p_fm_pcd->enabled)
+		return 0;
+
+	if (p_fm_pcd->p_fm_pcd_prs)
+		prs_enable(p_fm_pcd);
+
+	p_fm_pcd->enabled = true;
+
+	return 0;
+}
+
+int fm_pcd_disable(void *h_fm_pcd)
+{
+	struct fm_pcd_t *p_fm_pcd = (struct fm_pcd_t *)h_fm_pcd;
+
+	if (!p_fm_pcd->enabled)
+		return 0;
+
+	if (p_fm_pcd->p_fm_pcd_prs)
+		prs_disable(p_fm_pcd);
+
+	p_fm_pcd->enabled = false;
+
+	return 0;
+}
+
+int fm_pcd_set_exception(void *h_fm_pcd,
+			 enum fm_pcd_exceptions exception,
+			     bool enable)
+{
+	struct fm_pcd_t *p_fm_pcd = (struct fm_pcd_t *)h_fm_pcd;
+	uint32_t bit_mask = 0, tmp_reg;
+	int ret;
+
+	ret = is_init_done(p_fm_pcd->p_fm_pcd_drv_param);
+	if (ret)
+		return ret;
+
+	GET_FM_PCD_EXCEPTION_FLAG(bit_mask, exception);
+
+	if (bit_mask) {
+		if (enable)
+			p_fm_pcd->exceptions |= bit_mask;
+		else
+			p_fm_pcd->exceptions &= ~bit_mask;
+
+		switch (exception) {
+		case (FM_PCD_PRS_EXCEPTION_DOUBLE_ECC):
+		case (FM_PCD_PRS_EXCEPTION_SINGLE_ECC):
+			if (!p_fm_pcd->p_fm_pcd_prs) {
+				pr_warn("Parser is not working\n");
+				return -ENOSYS;
+			}
+			break;
+		default:
+				pr_warn("Unsupported exception\n");
+				return -ENOSYS;
+		}
+
+		switch (exception) {
+		case (FM_PCD_PRS_EXCEPTION_DOUBLE_ECC):
+			tmp_reg =
+			    GET_UINT32(p_fm_pcd->p_fm_pcd_prs->
+				       p_fm_pcd_prs_regs->
+				       fmpr_perer);
+			if (enable)
+				tmp_reg |= FM_PCD_PRS_DOUBLE_ECC;
+			else
+				tmp_reg &= ~FM_PCD_PRS_DOUBLE_ECC;
+			WRITE_UINT32(p_fm_pcd->p_fm_pcd_prs->p_fm_pcd_prs_regs->
+				     fmpr_perer, tmp_reg);
+			break;
+		case (FM_PCD_PRS_EXCEPTION_SINGLE_ECC):
+			tmp_reg =
+			    GET_UINT32(p_fm_pcd->p_fm_pcd_prs->
+				       p_fm_pcd_prs_regs->
+				       fmpr_pever);
+			if (enable)
+				tmp_reg |= FM_PCD_PRS_SINGLE_ECC;
+			else
+				tmp_reg &= ~FM_PCD_PRS_SINGLE_ECC;
+			WRITE_UINT32(p_fm_pcd->p_fm_pcd_prs->p_fm_pcd_prs_regs->
+				     fmpr_pever, tmp_reg);
+			break;
+		default:
+				pr_warn("Unsupported exception\n");
+				return -ENOSYS;
+		}
+		/* for ECC exceptions driver automatically enables
+		 * ECC mechanism, if disabled. Driver may disable them
+		 * automatically, depending on driver's status
+		 */
+		if ((enable) &&
+		    ((exception == FM_PCD_PRS_EXCEPTION_DOUBLE_ECC) |
+		    (exception == FM_PCD_PRS_EXCEPTION_SINGLE_ECC)))
+			_fm_enable_rams_ecc(p_fm_pcd->h_fm);
+		if ((!enable) &&
+		    ((exception == FM_PCD_PRS_EXCEPTION_DOUBLE_ECC) |
+		    (exception == FM_PCD_PRS_EXCEPTION_SINGLE_ECC)))
+			_fm_disable_rams_ecc(p_fm_pcd->h_fm);
+	} else {
+		pr_err("Undefined exceptioni\n");
+		return -EDOM;
+	}
+	return 0;
+}
diff --git a/drivers/soc/fsl/fman/pcd/fm_pcd.h b/drivers/soc/fsl/fman/pcd/fm_pcd.h
new file mode 100644
index 0000000..7a1926a
--- /dev/null
+++ b/drivers/soc/fsl/fman/pcd/fm_pcd.h
@@ -0,0 +1,145 @@
+/*
+ * Copyright 2008 - 2015 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *	 notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *	 notice, this list of conditions and the following disclaimer in the
+ *	 documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *	 names of its contributors may be used to endorse or promote products
+ *	 derived from this software without specific prior written permission.
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#ifndef __FM_PCD_H
+#define __FM_PCD_H
+
+#include "service.h"
+#include "fm_pcd_ext.h"
+#include "fm_common.h"
+#include "fsl_fman_prs.h"
+
+/* Network defines          */
+
+#define UDP_HEADER_SIZE     8
+
+#define ESP_SPI_OFFSET      0
+#define ESP_SPI_SIZE        4
+#define ESP_SEQ_NUM_OFFSET  ESP_SPI_SIZE
+#define ESP_SEQ_NUM_SIZE    4
+
+/* General defines          */
+
+#define ILLEGAL_CLS_PLAN    0xff
+
+#define FM_PCD_MAX_NUM_OF_ALIAS_HDRS    3
+
+/* Error defines           */
+
+#define GET_FM_PCD_EXCEPTION_FLAG(bit_mask, exception) do {\
+switch (exception) {\
+case FM_PCD_PRS_EXCEPTION_DOUBLE_ECC:\
+	bit_mask = FM_PCD_EX_PRS_DOUBLE_ECC;\
+	break;\
+case FM_PCD_PRS_EXCEPTION_SINGLE_ECC:\
+	bit_mask = FM_PCD_EX_PRS_SINGLE_ECC;\
+	break;\
+default:\
+	bit_mask = 0; break; } \
+} while (0)
+
+/*  Driver's internal structures                                       */
+
+struct fm_pcd_prs_t {
+	uint32_t *p_sw_prs_code;
+	uint32_t *p_curr_sw_prs;
+	uint8_t curr_label;
+	struct fman_prs_regs __iomem *p_fm_pcd_prs_regs;
+	struct fm_pcd_prs_label_params_t labels_table[FM_PCD_PRS_NUM_OF_LABELS];
+	uint32_t fm_pcd_prs_port_id_statistics;
+};
+
+struct fm_pcd_drv_param_t {
+	struct fman_prs_cfg dflt_cfg;
+	uint16_t prs_max_parse_cycle_limit;
+};
+
+struct fm_pcd_intg_t {
+	uint32_t prs_sw_patches_size;
+};
+
+struct fm_pcd_t {
+	void *h_fm;
+	struct fm_revision_info_t fm_rev_info;
+
+	spinlock_t *spinlock;
+	struct list_head free_locks_lst;
+	struct list_head acquired_locks_lst;
+
+	bool enabled;
+	char fm_pcd_module_name[MODULE_NAME_SIZE];
+	struct fm_pcd_prs_t *p_fm_pcd_prs;
+
+	uint32_t exceptions;
+	fm_pcd_exception_cb *f_exception;
+	void *h_app;
+	uintptr_t ipv6_frame_id_addr;
+
+	struct fm_pcd_drv_param_t *p_fm_pcd_drv_param;
+
+	struct fm_pcd_intg_t *pcd_intg;
+
+};
+
+/*  PCD internal routines                                              */
+
+/* only for SINGLE partittion */
+
+void *prs_config(struct fm_pcd_t *p_fm_pcd, struct fm_pcd_params_t
+		    *p_fm_pcd_params);
+int prs_init(struct fm_pcd_t *p_fm_pcd);
+void prs_enable(struct fm_pcd_t *p_fm_pcd);
+void prs_disable(struct fm_pcd_t *p_fm_pcd);
+void prs_free(struct fm_pcd_t *p_fm_pcd);
+int prs_include_port_in_statistics(struct fm_pcd_t *p_fm_pcd,
+				       uint8_t port_id,
+				       bool include);
+
+static inline bool fm_pcd_lock_try_lock(struct fm_pcd_lock_t *p_lock)
+{
+	unsigned long int_flags;
+
+	spin_lock_irqsave(p_lock->spinlock, int_flags);
+	if (p_lock->flag) {
+		spin_unlock_irqrestore(p_lock->spinlock, int_flags);
+		return false;
+	}
+	p_lock->flag = true;
+	spin_unlock_irqrestore(p_lock->spinlock, int_flags);
+	return true;
+}
+
+static inline void fm_pcd_lock_unlock(struct fm_pcd_lock_t *p_lock)
+{
+	p_lock->flag = false;
+}
+
+#endif /* __FM_PCD_H */
diff --git a/drivers/soc/fsl/fman/pcd/fm_prs.c b/drivers/soc/fsl/fman/pcd/fm_prs.c
new file mode 100644
index 0000000..5691ba5
--- /dev/null
+++ b/drivers/soc/fsl/fman/pcd/fm_prs.c
@@ -0,0 +1,276 @@
+/*
+ * Copyright 2008 - 2015 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *	 notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *	 notice, this list of conditions and the following disclaimer in the
+ *	 documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *	 names of its contributors may be used to endorse or promote products
+ *	 derived from this software without specific prior written permission.
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#include "service.h"
+#include "net_ext.h"
+
+#include "fm_common.h"
+#include "fm_pcd.h"
+#include "fm_prs.h"
+#include "fsl_fman_prs.h"
+
+#include <linux/string.h>
+#include <linux/slab.h>
+
+static void pcd_prs_error_exception(void *h_fm_pcd)
+{
+	struct fm_pcd_t *p_fm_pcd = (struct fm_pcd_t *)h_fm_pcd;
+	uint32_t event, ev_mask;
+	struct fman_prs_regs __iomem *prs_regs =
+		(struct fman_prs_regs __iomem *)
+		p_fm_pcd->p_fm_pcd_prs->p_fm_pcd_prs_regs;
+
+	ev_mask = fman_prs_get_err_ev_mask(prs_regs);
+
+	event = fman_prs_get_err_event(prs_regs, ev_mask);
+
+	fman_prs_ack_err_event(prs_regs, event);
+
+	pr_debug("parser error - 0x%08x\n", event);
+
+	if (event&FM_PCD_PRS_DOUBLE_ECC)
+		p_fm_pcd->f_exception(p_fm_pcd->h_app,
+				     FM_PCD_PRS_EXCEPTION_DOUBLE_ECC);
+}
+
+/* Checks if p_dtsec driver parameters were initialized
+ * returns 0 if success else returns error code
+ */
+static int is_init_done(struct fm_pcd_drv_param_t *p_fm_pcd_drv_parameters)
+{
+	if (!p_fm_pcd_drv_parameters)
+		return 0;
+	return -ENOSYS;
+}
+
+static void pcd_prs_exception(void *h_fm_pcd)
+{
+	struct fm_pcd_t *p_fm_pcd = (struct fm_pcd_t *)h_fm_pcd;
+	uint32_t event, ev_mask;
+	struct fman_prs_regs __iomem *prs_regs =
+		(struct fman_prs_regs __iomem *)
+		p_fm_pcd->p_fm_pcd_prs->p_fm_pcd_prs_regs;
+
+	ev_mask = fman_prs_get_expt_ev_mask(prs_regs);
+	event = fman_prs_get_expt_event(prs_regs, ev_mask);
+
+	ASSERT(event&FM_PCD_PRS_SINGLE_ECC);
+
+	pr_debug("parser event - 0x%08x\n", event);
+
+	fman_prs_ack_expt_event(prs_regs, event);
+
+	p_fm_pcd->f_exception(p_fm_pcd->h_app, FM_PCD_PRS_EXCEPTION_SINGLE_ECC);
+}
+
+void *prs_config(struct fm_pcd_t __maybe_unused *p_fm_pcd,
+		 struct fm_pcd_params_t __maybe_unused *p_fm_pcd_params)
+{
+	struct fm_pcd_prs_t *p_fm_pcd_prs;
+	uintptr_t base_addr;
+
+	p_fm_pcd_prs = kzalloc(sizeof(*p_fm_pcd_prs), GFP_KERNEL);
+	if (!p_fm_pcd_prs)
+		return NULL;
+	fman_prs_defconfig(&p_fm_pcd->p_fm_pcd_drv_param->dflt_cfg);
+
+	base_addr = fm_get_pcd_prs_base_addr(p_fm_pcd_params->h_fm);
+	p_fm_pcd_prs->p_sw_prs_code = (uint32_t *)UINT_TO_PTR(base_addr);
+	p_fm_pcd_prs->p_fm_pcd_prs_regs =
+		(struct fman_prs_regs __iomem *)UINT_TO_PTR(base_addr +
+							    PRS_REGS_OFFSET);
+
+	p_fm_pcd_prs->fm_pcd_prs_port_id_statistics =
+	    p_fm_pcd->p_fm_pcd_drv_param->dflt_cfg.port_id_stat;
+	p_fm_pcd->p_fm_pcd_drv_param->prs_max_parse_cycle_limit =
+	    p_fm_pcd->p_fm_pcd_drv_param->dflt_cfg.max_prs_cyc_lim;
+	p_fm_pcd->exceptions |=
+	    p_fm_pcd->p_fm_pcd_drv_param->dflt_cfg.prs_exceptions;
+
+	return p_fm_pcd_prs;
+}
+
+int prs_init(struct fm_pcd_t *p_fm_pcd)
+{
+	struct fm_pcd_drv_param_t *p_param = p_fm_pcd->p_fm_pcd_drv_param;
+	uint32_t *p_tmp_code;
+	uint32_t *p_load_target =
+	    (uint32_t *)PTR_MOVE(p_fm_pcd->p_fm_pcd_prs->p_sw_prs_code,
+				  FM_PCD_SW_PRS_SIZE -
+				  p_fm_pcd->pcd_intg->prs_sw_patches_size);
+	struct fman_prs_regs __iomem *prs_regs =
+		(struct fman_prs_regs __iomem *)
+		p_fm_pcd->p_fm_pcd_prs->p_fm_pcd_prs_regs;
+	uint32_t i;
+	uint32_t size_of_sw_prs_code;
+
+	if (p_fm_pcd->fm_rev_info.major_rev >= 6)
+		size_of_sw_prs_code =
+			sizeof(sw_prs_ip_frag_patch_ver_106_3_13);
+	else
+		size_of_sw_prs_code =
+			sizeof(sw_prs_ip_frag_patch_ver_106_1_9);
+
+	ASSERT((size_of_sw_prs_code) <=
+		(p_fm_pcd->pcd_intg->prs_sw_patches_size -
+		FM_PCD_PRS_SW_TAIL_SIZE));
+
+	p_tmp_code = kzalloc(ROUND_UP(size_of_sw_prs_code, 4), GFP_KERNEL);
+	if (!p_tmp_code)
+		return -ENOMEM;
+
+	if (p_fm_pcd->fm_rev_info.major_rev >= 6)
+		memcpy((uint8_t *)p_tmp_code,
+		       (uint8_t *)sw_prs_ip_frag_patch_ver_106_3_13,
+		       size_of_sw_prs_code);
+	else
+		memcpy((uint8_t *)p_tmp_code,
+		       (uint8_t *)sw_prs_ip_frag_patch_ver_106_1_9,
+		       size_of_sw_prs_code);
+
+	fman_prs_init(prs_regs, &p_param->dflt_cfg);
+
+	/* register even if no interrupts enabled, to allow future enablement */
+	fm_register_intr(p_fm_pcd->h_fm, FM_MOD_PRS, 0, FM_INTR_TYPE_ERR,
+			 pcd_prs_error_exception, p_fm_pcd);
+
+	/* register even if no interrupts enabled, to allow future enablement */
+	fm_register_intr(p_fm_pcd->h_fm, FM_MOD_PRS, 0, FM_INTR_TYPE_NORMAL,
+			 pcd_prs_exception, p_fm_pcd);
+
+	if (p_fm_pcd->exceptions&FM_PCD_EX_PRS_SINGLE_ECC)
+		_fm_enable_rams_ecc(p_fm_pcd->h_fm);
+
+	if (p_fm_pcd->exceptions&FM_PCD_EX_PRS_DOUBLE_ECC)
+		_fm_enable_rams_ecc(p_fm_pcd->h_fm);
+
+	for (i = 0; i < DIV_CEIL(size_of_sw_prs_code, 4); i++)
+		WRITE_UINT32(p_load_target[i], p_tmp_code[i]);
+
+	kfree(p_tmp_code);
+
+	return 0;
+}
+
+void prs_free(struct fm_pcd_t *p_fm_pcd)
+{
+	fm_unregister_intr(p_fm_pcd->h_fm, FM_MOD_PRS, 0, FM_INTR_TYPE_ERR);
+	/* register even if no interrupts enabled, to allow future enablement */
+	fm_unregister_intr(p_fm_pcd->h_fm, FM_MOD_PRS, 0, FM_INTR_TYPE_NORMAL);
+}
+
+void prs_enable(struct fm_pcd_t *p_fm_pcd)
+{
+	struct fman_prs_regs __iomem *prs_regs =
+	    (struct fman_prs_regs __iomem *)
+		p_fm_pcd->p_fm_pcd_prs->p_fm_pcd_prs_regs;
+
+	fman_prs_enable(prs_regs);
+}
+
+void prs_disable(struct fm_pcd_t *p_fm_pcd)
+{
+	struct fman_prs_regs __iomem *prs_regs =
+	    (struct fman_prs_regs __iomem *)
+		p_fm_pcd->p_fm_pcd_prs->p_fm_pcd_prs_regs;
+
+	fman_prs_disable(prs_regs);
+}
+
+int prs_include_port_in_statistics(struct fm_pcd_t *p_fm_pcd,
+				   uint8_t port_id,
+				       bool include)
+{
+	struct fman_prs_regs __iomem *prs_regs;
+	uint32_t bit_mask = 0;
+	uint8_t prs_port_id;
+
+	if ((port_id < 1 || port_id > 16))
+		return -ENOSYS;
+
+	prs_regs = (struct fman_prs_regs __iomem *)p_fm_pcd->p_fm_pcd_prs->
+		   p_fm_pcd_prs_regs;
+
+	GET_FM_PCD_PRS_PORT_ID(prs_port_id, port_id);
+	GET_FM_PCD_INDEX_FLAG(bit_mask, prs_port_id);
+
+	if (include)
+		p_fm_pcd->p_fm_pcd_prs->fm_pcd_prs_port_id_statistics |=
+		bit_mask;
+	else
+		p_fm_pcd->p_fm_pcd_prs->fm_pcd_prs_port_id_statistics &=
+		~bit_mask;
+
+	fman_prs_set_stst_port_msk(prs_regs,
+				   p_fm_pcd->p_fm_pcd_prs->
+				   fm_pcd_prs_port_id_statistics);
+
+	return 0;
+}
+
+int fm_pcd_prs_include_port_in_statistics(void *h_fm_pcd,
+					  uint8_t port_id,
+					      bool include)
+{
+	struct fm_pcd_t *p_fm_pcd = (struct fm_pcd_t *)h_fm_pcd;
+
+	if ((port_id < 1 || port_id > 16))
+		return -ENOSYS;
+
+	return prs_include_port_in_statistics(p_fm_pcd, port_id,
+					      include);
+}
+
+uint32_t fm_pcd_get_sw_prs_offset(void *h_fm_pcd, enum net_header_type hdr,
+				  uint8_t index_per_hdr)
+{
+	struct fm_pcd_t *p_fm_pcd = (struct fm_pcd_t *)h_fm_pcd;
+	struct fm_pcd_prs_label_params_t *p_label;
+	int i, ret;
+
+	ret = is_init_done(p_fm_pcd->p_fm_pcd_drv_param);
+	if (ret)
+		return 0;
+
+	ASSERT(p_fm_pcd->p_fm_pcd_prs->curr_label <
+		    FM_PCD_PRS_NUM_OF_LABELS);
+
+	for (i = 0; i < p_fm_pcd->p_fm_pcd_prs->curr_label; i++) {
+		p_label = &p_fm_pcd->p_fm_pcd_prs->labels_table[i];
+
+		if ((hdr == p_label->hdr) &&
+		    (index_per_hdr == p_label->index_per_hdr))
+			return p_label->instruction_offset;
+	}
+
+	pr_err("Sw Parser attachment Not found\n");
+	return (uint32_t)ILLEGAL_BASE;
+}
diff --git a/drivers/soc/fsl/fman/pcd/fm_prs.h b/drivers/soc/fsl/fman/pcd/fm_prs.h
new file mode 100644
index 0000000..f3cbd2f
--- /dev/null
+++ b/drivers/soc/fsl/fman/pcd/fm_prs.h
@@ -0,0 +1,163 @@
+/*
+ * Copyright 2008 - 2015 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *	 notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *	 notice, this list of conditions and the following disclaimer in the
+ *	 documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *	 names of its contributors may be used to endorse or promote products
+ *	 derived from this software without specific prior written permission.
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#ifndef __FM_PRS_H
+#define __FM_PRS_H
+
+#include "service.h"
+
+/* SW parser IP_FRAG patch */
+/* version: 106.1.9 */
+static uint8_t sw_prs_ip_frag_patch_ver_106_1_9[] = {
+	0x31, 0x52, 0x00, 0xDA, 0x0A, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x43, 0x0A, 0x00, 0x00, 0x00, 0x01, 0x1B, 0xFE,
+	0x00, 0x00, 0x99, 0x00, 0x53, 0x13, 0x00, 0x00, 0x00, 0x00,
+	0x9F, 0x98, 0x53, 0x13, 0x00, 0x00, 0x1B, 0x23, 0x33, 0xF1,
+	0x00, 0xF9, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x28, 0x7F, 0x00, 0x03, 0x00, 0x02, 0x00, 0x00, 0x00, 0x01,
+	0x32, 0xC1, 0x32, 0xF0, 0x00, 0x4A, 0x00, 0x80, 0x1F, 0xFF,
+	0x00, 0x01, 0x1B, 0xFE, 0x31, 0x52, 0x00, 0xDA, 0x06, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x43, 0x2F, 0x00, 0x00,
+	0x00, 0x01, 0x1B, 0xFE, 0x31, 0x52, 0x00, 0xDA, 0x00, 0x40,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x53, 0x95, 0x00, 0x00,
+	0x00, 0x00, 0x9B, 0x8F, 0x2F, 0x0F, 0x32, 0xC1, 0x00, 0x55,
+	0x00, 0x28, 0x28, 0x43, 0x30, 0x7E, 0x43, 0x45, 0x00, 0x00,
+	0x30, 0x7E, 0x43, 0x45, 0x00, 0x3C, 0x1B, 0x5D, 0x32, 0x11,
+	0x32, 0xC0, 0x00, 0x4F, 0x00, 0x81, 0x00, 0x00, 0x83, 0x8F,
+	0x2F, 0x0F, 0x06, 0x00, 0x32, 0x11, 0x32, 0xC0, 0x00, 0x4F,
+	0x00, 0x55, 0x00, 0x01, 0x00, 0x81, 0x32, 0x11, 0x00, 0x00,
+	0x83, 0x8E, 0x00, 0x50, 0x00, 0x01, 0x01, 0x04, 0x00, 0x4D,
+	0x28, 0x43, 0x06, 0x00, 0x1B, 0x3E, 0x30, 0x7E, 0x53, 0x79,
+	0x00, 0x2B, 0x32, 0x11, 0x32, 0xC0, 0x00, 0x4F, 0x00, 0x81,
+	0x00, 0x00, 0x87, 0x8F, 0x28, 0x23, 0x06, 0x00, 0x32, 0x11,
+	0x32, 0xC0, 0x00, 0x4F, 0x00, 0x55, 0x00, 0x01, 0x00, 0x81,
+	0x32, 0x11, 0x00, 0x00, 0x83, 0x8E, 0x00, 0x50, 0x00, 0x01,
+	0x01, 0x04, 0x00, 0x4D, 0x28, 0x43, 0x06, 0x00, 0x00, 0x01,
+	0x1B, 0xFE, 0x00, 0x00, 0x9B, 0x8E, 0x53, 0x90, 0x00, 0x00,
+	0x06, 0x29, 0x00, 0x00, 0x83, 0x8F, 0x28, 0x23, 0x06, 0x00,
+	0x06, 0x29, 0x32, 0xC1, 0x00, 0x55, 0x00, 0x28, 0x00, 0x00,
+	0x83, 0x8E, 0x00, 0x50, 0x00, 0x01, 0x01, 0x04, 0x00, 0x4D,
+	0x28, 0x43, 0x06, 0x00, 0x00, 0x01, 0x1B, 0xFE, 0x32, 0xC1,
+	0x00, 0x55, 0x00, 0x28, 0x28, 0x43, 0x1B, 0xCF, 0x00, 0x00,
+	0x9B, 0x8F, 0x2F, 0x0F, 0x32, 0xC1, 0x00, 0x55, 0x00, 0x28,
+	0x28, 0x43, 0x30, 0x7E, 0x43, 0xBF, 0x00, 0x2C, 0x32, 0x11,
+	0x32, 0xC0, 0x00, 0x4F, 0x00, 0x81, 0x00, 0x00, 0x87, 0x8F,
+	0x28, 0x23, 0x06, 0x00, 0x32, 0x11, 0x32, 0xC0, 0x00, 0x4F,
+	0x00, 0x81, 0x00, 0x00, 0x83, 0x8F, 0x2F, 0x0F, 0x06, 0x00,
+	0x32, 0x11, 0x32, 0xC0, 0x00, 0x4F, 0x00, 0x55, 0x00, 0x01,
+	0x00, 0x81, 0x32, 0x11, 0x00, 0x00, 0x83, 0x8E, 0x00, 0x50,
+	0x00, 0x01, 0x01, 0x04, 0x00, 0x4D, 0x28, 0x43, 0x06, 0x00,
+	0x1B, 0x9C, 0x33, 0xF1, 0x00, 0xF9, 0x00, 0x01, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x28, 0x7F, 0x00, 0x03, 0x00, 0x02,
+	0x00, 0x00, 0x00, 0x01, 0x32, 0xC1, 0x32, 0xF0, 0x00, 0x4A,
+	0x00, 0x80, 0x1F, 0xFF, 0x00, 0x01, 0x1B, 0xFE};
+
+/* version: 106.3.13 */
+static uint8_t sw_prs_ip_frag_patch_ver_106_3_13[] = {
+	0x31, 0x52, 0x00, 0xDA, 0x0E, 0x4F, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x52, 0xF6, 0x08, 0x4B, 0x31, 0x53, 0x00, 0xFB,
+	0xFF, 0xF0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x29, 0x2B,
+	0x33, 0xF1, 0x00, 0xFB, 0x00, 0xDF, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x28, 0x7F, 0x31, 0x52, 0x00, 0xDA, 0x0A, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x43, 0x00, 0x00, 0x00,
+	0x00, 0x01, 0x1B, 0xFE, 0x00, 0x00, 0x99, 0x00, 0x53, 0x09,
+	0x00, 0x00, 0x00, 0x00, 0x9F, 0x98, 0x53, 0x09, 0x00, 0x00,
+	0x1B, 0x24, 0x09, 0x5F, 0x00, 0x20, 0x00, 0x00, 0x09, 0x4F,
+	0x00, 0x20, 0x00, 0x00, 0x34, 0xB7, 0x00, 0xF9, 0x00, 0x00,
+	0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x2B, 0x97, 0x31, 0xB3,
+	0x29, 0x8F, 0x33, 0xF1, 0x00, 0xF9, 0x00, 0x01, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x28, 0x7F, 0x00, 0x03, 0x00, 0x02,
+	0x00, 0x00, 0x00, 0x01, 0x1B, 0xFE, 0x00, 0x01, 0x1B, 0xFE,
+	0x31, 0x52, 0x00, 0xDA, 0x0E, 0x4F, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x53, 0x3C, 0x04, 0x4B, 0x31, 0x53, 0x00, 0xFB,
+	0xFF, 0xF0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x29, 0x2B,
+	0x33, 0xF1, 0x00, 0xFB, 0x00, 0xDF, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x28, 0x7F, 0x31, 0x52, 0x00, 0xDA, 0x06, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x43, 0x46, 0x00, 0x00,
+	0x00, 0x01, 0x1B, 0xFE, 0x31, 0x52, 0x00, 0xDA, 0x00, 0x40,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x53, 0xAC, 0x00, 0x00,
+	0x00, 0x00, 0x9B, 0x8F, 0x2F, 0x0F, 0x32, 0xC1, 0x00, 0x55,
+	0x00, 0x28, 0x28, 0x43, 0x30, 0x7E, 0x43, 0x5C, 0x00, 0x00,
+	0x30, 0x7E, 0x43, 0x5C, 0x00, 0x3C, 0x1B, 0x74, 0x32, 0x11,
+	0x32, 0xC0, 0x00, 0x4F, 0x00, 0x81, 0x00, 0x00, 0x83, 0x8F,
+	0x2F, 0x0F, 0x06, 0x00, 0x32, 0x11, 0x32, 0xC0, 0x00, 0x4F,
+	0x00, 0x55, 0x00, 0x01, 0x00, 0x81, 0x32, 0x11, 0x00, 0x00,
+	0x83, 0x8E, 0x00, 0x50, 0x00, 0x01, 0x01, 0x04, 0x00, 0x4D,
+	0x28, 0x43, 0x06, 0x00, 0x1B, 0x55, 0x30, 0x7E, 0x53, 0x90,
+	0x00, 0x2B, 0x32, 0x11, 0x32, 0xC0, 0x00, 0x4F, 0x00, 0x81,
+	0x00, 0x00, 0x87, 0x8F, 0x28, 0x23, 0x06, 0x00, 0x32, 0x11,
+	0x32, 0xC0, 0x00, 0x4F, 0x00, 0x55, 0x00, 0x01, 0x00, 0x81,
+	0x32, 0x11, 0x00, 0x00, 0x83, 0x8E, 0x00, 0x50, 0x00, 0x01,
+	0x01, 0x04, 0x00, 0x4D, 0x28, 0x43, 0x06, 0x00, 0x00, 0x01,
+	0x1B, 0xFE, 0x00, 0x00, 0x9B, 0x8E, 0x53, 0xA7, 0x00, 0x00,
+	0x06, 0x29, 0x00, 0x00, 0x83, 0x8F, 0x28, 0x23, 0x06, 0x00,
+	0x06, 0x29, 0x32, 0xC1, 0x00, 0x55, 0x00, 0x28, 0x00, 0x00,
+	0x83, 0x8E, 0x00, 0x50, 0x00, 0x01, 0x01, 0x04, 0x00, 0x4D,
+	0x28, 0x43, 0x06, 0x00, 0x00, 0x01, 0x1B, 0xFE, 0x32, 0xC1,
+	0x00, 0x55, 0x00, 0x28, 0x28, 0x43, 0x1B, 0xF1, 0x00, 0x00,
+	0x9B, 0x8F, 0x2F, 0x0F, 0x32, 0xC1, 0x00, 0x55, 0x00, 0x28,
+	0x28, 0x43, 0x30, 0x7E, 0x43, 0xD6, 0x00, 0x2C, 0x32, 0x11,
+	0x32, 0xC0, 0x00, 0x4F, 0x00, 0x81, 0x00, 0x00, 0x87, 0x8F,
+	0x28, 0x23, 0x06, 0x00, 0x32, 0x11, 0x32, 0xC0, 0x00, 0x4F,
+	0x00, 0x81, 0x00, 0x00, 0x83, 0x8F, 0x2F, 0x0F, 0x06, 0x00,
+	0x32, 0x11, 0x32, 0xC0, 0x00, 0x4F, 0x00, 0x55, 0x00, 0x01,
+	0x00, 0x81, 0x32, 0x11, 0x00, 0x00, 0x83, 0x8E, 0x00, 0x50,
+	0x00, 0x01, 0x01, 0x04, 0x00, 0x4D, 0x28, 0x43, 0x06, 0x00,
+	0x1B, 0xB3, 0x09, 0x5F, 0x00, 0x20, 0x00, 0x00, 0x09, 0x4F,
+	0x00, 0x20, 0x00, 0x00, 0x34, 0xB7, 0x00, 0xF9, 0x00, 0x00,
+	0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x2B, 0x97, 0x31, 0xB3,
+	0x29, 0x8F, 0x33, 0xF1, 0x00, 0xF9, 0x00, 0x01, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x28, 0x7F, 0x00, 0x03, 0x00, 0x02,
+	0x00, 0x00, 0x00, 0x01, 0x1B, 0xFE, 0x00, 0x01, 0x1B, 0xFE};
+
+/* Parser defines */
+
+/* Number of bytes that must be cleared atthe end of the SW parser area */
+#define FM_PCD_PRS_SW_TAIL_SIZE             4
+
+/* masks */
+#define PRS_ERR_CAP                         0x80000000
+#define PRS_ERR_TYPE_DOUBLE                 0x40000000
+#define PRS_ERR_SINGLE_ECC_CNT_MASK         0x00FF0000
+#define PRS_ERR_ADDR_MASK                   0x000001FF
+
+/* others */
+#define PRS_MAX_CYCLE_LIMIT                 8191
+#define PRS_SW_DATA                         0x00000800
+#define PRS_REGS_OFFSET                     0x00000840
+
+#define GET_FM_PCD_PRS_PORT_ID(prs_port_id, port_id) \
+(prs_port_id = (uint8_t)(port_id&0x0f))
+
+#define GET_FM_PCD_INDEX_FLAG(bit_mask, prs_port_id) \
+(bit_mask = 0x80000000>>prs_port_id)
+
+#endif /* __FM_PRS_H */
-- 
1.7.9.5
