Return-Path: <Igal.Liberman@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0137.outbound.protection.outlook.com [157.56.111.137])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C09B61A0BA2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2015 20:13:21 +1100 (AEDT)
From: Igal.Liberman <igal.liberman@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: [RFC,5/8] soc/fman: Add FMan MAC support
Date: Wed, 11 Mar 2015 07:08:39 +0200
Message-ID: <1426050519-12640-1-git-send-email-igal.liberman@freescale.com>
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
 drivers/soc/fsl/fman/fm.c                   |  119 ++
 drivers/soc/fsl/fman/fm.h                   |    8 +
 drivers/soc/fsl/fman/fm_common.h            |   47 +
 drivers/soc/fsl/fman/inc/crc_mac_addr_ext.h |  343 ++++++
 drivers/soc/fsl/fman/inc/fm_mac_ext.h       |  660 +++++++++++
 drivers/soc/fsl/fman/mac/Makefile           |    7 +-
 drivers/soc/fsl/fman/mac/dtsec.c            | 1655 +++++++++++++++++++++++++++
 drivers/soc/fsl/fman/mac/dtsec.h            |  187 +++
 drivers/soc/fsl/fman/mac/dtsec_mii_acc.c    |   82 ++
 drivers/soc/fsl/fman/mac/dtsec_mii_acc.h    |   43 +
 drivers/soc/fsl/fman/mac/fm_mac.c           |  701 ++++++++++++
 drivers/soc/fsl/fman/mac/fm_mac.h           |  203 ++++
 drivers/soc/fsl/fman/mac/memac.c            | 1115 ++++++++++++++++++
 drivers/soc/fsl/fman/mac/memac.h            |  103 ++
 drivers/soc/fsl/fman/mac/memac_mii_acc.c    |   66 ++
 drivers/soc/fsl/fman/mac/memac_mii_acc.h    |   50 +
 drivers/soc/fsl/fman/mac/tgec.c             | 1030 +++++++++++++++++
 drivers/soc/fsl/fman/mac/tgec.h             |  112 ++
 drivers/soc/fsl/fman/mac/tgec_mii_acc.h     |   66 ++
 19 files changed, 6595 insertions(+), 2 deletions(-)
 create mode 100644 drivers/soc/fsl/fman/inc/crc_mac_addr_ext.h
 create mode 100644 drivers/soc/fsl/fman/inc/fm_mac_ext.h
 create mode 100644 drivers/soc/fsl/fman/mac/dtsec.c
 create mode 100644 drivers/soc/fsl/fman/mac/dtsec.h
 create mode 100644 drivers/soc/fsl/fman/mac/dtsec_mii_acc.c
 create mode 100644 drivers/soc/fsl/fman/mac/dtsec_mii_acc.h
 create mode 100644 drivers/soc/fsl/fman/mac/fm_mac.c
 create mode 100644 drivers/soc/fsl/fman/mac/fm_mac.h
 create mode 100644 drivers/soc/fsl/fman/mac/memac.c
 create mode 100644 drivers/soc/fsl/fman/mac/memac.h
 create mode 100644 drivers/soc/fsl/fman/mac/memac_mii_acc.c
 create mode 100644 drivers/soc/fsl/fman/mac/memac_mii_acc.h
 create mode 100644 drivers/soc/fsl/fman/mac/tgec.c
 create mode 100644 drivers/soc/fsl/fman/mac/tgec.h
 create mode 100644 drivers/soc/fsl/fman/mac/tgec_mii_acc.h

diff --git a/drivers/soc/fsl/fman/fm.c b/drivers/soc/fsl/fman/fm.c
index 1d32d446..7095dc2 100644
--- a/drivers/soc/fsl/fman/fm.c
+++ b/drivers/soc/fsl/fman/fm.c
@@ -708,6 +708,36 @@ static int fw_not_reset_erratum_bugzilla6173wa(struct fm_t *p_fm)
 #endif /* FM_UCODE_NOT_RESET_ERRATA_BUGZILLA6173 */
 
 /*       Inter-Module functions         */
+#ifdef FM_TX_ECC_FRMS_ERRATA_10GMAC_A004
+int fm_10g_tx_ecc_workaround(void *h_fm, uint8_t mac_id)
+{
+	struct fm_t *p_fm = (struct fm_t *)h_fm;
+	uint8_t rx_port_id, tx_port_id;
+	struct fman_fpm_regs __iomem *fpm_rg = p_fm->p_fm_fpm_regs;
+
+	if (!(is_fman_ctrl_code_loaded(p_fm)))
+		return -ENOSYS;
+
+	SW_PORT_ID_TO_HW_PORT_ID(p_fm->p_fm_state_struct->rev_info.major_rev,
+				 rx_port_id,
+				 FM_PORT_TYPE_RX,
+				 mac_id);
+	SW_PORT_ID_TO_HW_PORT_ID(p_fm->p_fm_state_struct->rev_info.major_rev,
+				 tx_port_id,
+				 FM_PORT_TYPE_TX,
+				 mac_id);
+
+	if ((p_fm->p_fm_state_struct->ports_types[rx_port_id] !=
+	     FM_PORT_TYPE_DUMMY) ||
+	    (p_fm->p_fm_state_struct->ports_types[tx_port_id] !=
+		FM_PORT_TYPE_DUMMY)) {
+		pr_err("Initialize MAC  prior to Rx & Tx ports!\n");
+		return -ENOSYS;
+	}
+
+	return fman_set_erratum_10gmac_a004_wa(fpm_rg);
+}
+#endif /* FM_TX_ECC_FRMS_ERRATA_10GMAC_A004 */
 
 uint16_t fm_get_tnum_aging_period(void *h_fm)
 {
@@ -721,6 +751,48 @@ uint16_t fm_get_tnum_aging_period(void *h_fm)
 	return p_fm->tnum_aging_period;
 }
 
+int fm_set_port_prefetch_cfg(void *h_fm, uint8_t port_num,
+			     bool pre_fetch_configured)
+{
+	struct fm_t *p_fm = (struct fm_t *)h_fm;
+	int ret;
+
+	ret = is_init_done(p_fm->p_fm_drv_param);
+	if (ret)
+		return ret;
+
+	p_fm->ports_pre_fetch_configured[port_num] = true;
+	p_fm->ports_pre_fetch_value[port_num] = pre_fetch_configured;
+
+	return 0;
+}
+
+int fm_get_port_prefetch_cfg(void *h_fm, uint8_t port_num,
+			     bool *p_port_configured,
+			     bool *p_pre_fetch_configured)
+{
+	int ret;
+	struct fm_t *p_fm = (struct fm_t *)h_fm;
+
+	ret = is_init_done(p_fm->p_fm_drv_param);
+	if (ret)
+		return ret;
+
+	/* If the prefetch wasn't configured yet (not enable or disabled)
+	 * we return the value true as it was already configured
+	 */
+	if (!p_fm->ports_pre_fetch_configured[port_num]) {
+		*p_port_configured = false;
+		*p_pre_fetch_configured = false;
+	} else {
+		*p_port_configured = true;
+		*p_pre_fetch_configured =
+		(p_fm->ports_pre_fetch_configured[port_num]);
+	}
+
+	return 0;
+}
+
 uintptr_t fm_get_pcd_prs_base_addr(void *h_fm)
 {
 	struct fm_t *p_fm = (struct fm_t *)h_fm;
@@ -892,6 +964,53 @@ uint8_t fm_get_id(void *h_fm)
 	return p_fm->p_fm_state_struct->fm_id;
 }
 
+int fm_reset_mac(void *h_fm, enum fm_mac_type type, uint8_t mac_id)
+{
+	struct fm_t *p_fm = (struct fm_t *)h_fm;
+	int err;
+	struct fman_fpm_regs __iomem *fpm_rg = p_fm->p_fm_fpm_regs;
+
+	if (p_fm->p_fm_state_struct->rev_info.major_rev >= 6) {
+		pr_warn("FMan MAC reset!\n");
+		return -ENOSYS;
+	}
+	if (!p_fm->base_addr) {
+		pr_warn("'base_address' is required!\n");
+		return -ENOSYS;
+	}
+	err =
+	    (int)fman_reset_mac(fpm_rg, mac_id);
+
+	if (err == -EINVAL) {
+		pr_warn("Illegal MAC Id\n");
+		return -EINVAL;
+	} else if (err == EINVAL) {
+		return -EINVAL;
+	}
+	return 0;
+}
+
+int fm_set_mac_max_frame(void *h_fm, enum fm_mac_type type,
+			 uint8_t mac_id,
+			     uint16_t mtu)
+{
+	struct fm_t *p_fm = (struct fm_t *)h_fm;
+
+	/* if port is already initialized, check that MaxFrameLength is smaller
+	 * or equal to the port's max
+	 */
+	if ((!p_fm->p_fm_state_struct->port_max_frame_lengths[mac_id]) ||
+	    (p_fm->p_fm_state_struct->port_max_frame_lengths[mac_id] &&
+	    (mtu <=
+	    p_fm->p_fm_state_struct->port_max_frame_lengths[mac_id]))) {
+		p_fm->p_fm_state_struct->mac_max_frame_lengths[mac_id] = mtu;
+	} else {
+		pr_warn("MAC max_frame_length is larger than Port max_frame_length\n");
+		return -EDOM;
+	}
+	return 0;
+}
+
 uint16_t fm_get_clock_freq(void *h_fm)
 {
 	struct fm_t *p_fm = (struct fm_t *)h_fm;
diff --git a/drivers/soc/fsl/fman/fm.h b/drivers/soc/fsl/fman/fm.h
index eb71103..1b2442a 100644
--- a/drivers/soc/fsl/fman/fm.h
+++ b/drivers/soc/fsl/fman/fm.h
@@ -396,6 +396,7 @@ struct fm_state_struct_t {
 /* Master/Guest parameters */
 
 	uint8_t fm_id;
+	enum fm_port_type ports_types[FM_MAX_NUM_OF_HW_PORT_IDS];
 	uint16_t fm_clk_freq;
 	struct fm_revision_info_t rev_info;
 
@@ -421,6 +422,8 @@ struct fm_state_struct_t {
 	uint32_t extra_fifo_pool_size;
 	uint8_t extra_tasks_pool_size;
 	uint8_t extra_open_dmas_pool_size;
+	uint16_t port_max_frame_lengths[FM_MAX_NUM_OF_MACS];
+	uint16_t mac_max_frame_lengths[FM_MAX_NUM_OF_MACS];
 };
 
 struct fm_intg_t {
@@ -473,6 +476,11 @@ struct fm_t {
 	uint16_t tnum_aging_period;
 
 /* un-needed for recovery */
+	/* Prefetch configration per Tx-port */
+	bool ports_pre_fetch_configured[FM_MAX_NUM_OF_HW_PORT_IDS];
+	/* Prefetch configration per Tx-port */
+	bool ports_pre_fetch_value[FM_MAX_NUM_OF_HW_PORT_IDS];
+
 	struct fman_cfg *p_fm_drv_param;
 	struct muram_info *p_muram;
 	phys_addr_t fm_muram_phys_base_addr;
diff --git a/drivers/soc/fsl/fman/fm_common.h b/drivers/soc/fsl/fman/fm_common.h
index 1e3422c..75ba185 100644
--- a/drivers/soc/fsl/fman/fm_common.h
+++ b/drivers/soc/fsl/fman/fm_common.h
@@ -175,6 +175,30 @@ static inline bool TRY_LOCK(spinlock_t *spinlock, volatile bool *p_flag)
 
 #define FM_CTL_PARAMS_PAGE_ERROR_VSP_MASK       0x0000003f
 
+/* Description       Port Id defines */
+#define BASE_OH_PORTID(major)		(major >= 6 ? 2 : 1)
+#define BASE_RX_PORTID			0x08
+#define BASE_TX_PORTID			0x28
+
+#define SW_PORT_ID_TO_HW_PORT_ID(major, _port,	type, mac_id)		\
+do {									\
+	switch (type) {							\
+	case (FM_PORT_TYPE_OP):						\
+		_port = (uint8_t)(BASE_OH_PORTID(major) + mac_id);	\
+		break;							\
+	case (FM_PORT_TYPE_RX):					\
+		_port = (uint8_t)(BASE_RX_PORTID + mac_id);		\
+		break;							\
+	case (FM_PORT_TYPE_TX):					\
+		_port = (uint8_t)(BASE_TX_PORTID + mac_id);		\
+		break;							\
+	default:							\
+		pr_err("Illegal port type\n");				\
+		_port = 0;						\
+		break;							\
+	}								\
+} while (0)
+
 #define BMI_MAX_FIFO_SIZE                   (FM_MURAM_SIZE)
 #define BMI_FIFO_UNITS                      0x100
 
@@ -334,6 +358,16 @@ void fm_get_physical_muram_base(void *h_fm,
  */
 uint32_t fm_get_time_stamp_scale(void *h_fm);
 
+/* Function      fm_reset_mac
+ * Description   Used by MAC driver to reset the MAC registers
+ * Param[in]     h_fm            A handle to an FM Module.
+ * Param[in]     type            MAC type.
+ * Param[in]     mac_id           MAC id - according to type.
+ * Return        0 on success; Error code otherwise.
+ * Cautions      Allowed only following fm_init().
+ */
+int fm_reset_mac(void *h_fm, enum fm_mac_type type, uint8_t mac_id);
+
 /* Function      fm_get_clock_freq
  * Description   Used by MAC driver to get the FM clock frequency
  * Param[in]     h_fm            A handle to an FM Module.
@@ -379,6 +413,10 @@ void fm_register_fman_ctrl_intr(void *h_fm, uint8_t event_reg_id,
 				void *h_src_arg);
 void fm_unregister_fman_ctrl_intr(void *h_fm, uint8_t event_reg_id);
 
+#ifdef FM_TX_ECC_FRMS_ERRATA_10GMAC_A004
+int fm_10g_tx_ecc_workaround(void *h_fm, uint8_t mac_id);
+#endif /* FM_TX_ECC_FRMS_ERRATA_10GMAC_A004 */
+
 void fm_muram_clear(struct muram_info *p_muram);
 int fm_set_num_of_open_dmas(void *h_fm,
 			    uint8_t port_id,
@@ -401,5 +439,14 @@ int fm_set_congestion_group_pfc_priority(void *h_fm,
 					 uint8_t priority_bit_map);
 uint32_t fm_get_bmi_max_fifo_size(void *h_fm);
 struct num_of_ports_info_t *fm_get_num_of_ports(void *h_fm);
+uint16_t fm_get_tnum_aging_period(void *h_fm);
+int fm_set_port_prefetch_cfg(void *h_fm, uint8_t port_num,
+			     bool pre_fetch_configured);
+int fm_get_port_prefetch_cfg(void *h_fm, uint8_t port_num,
+			     bool *p_port_configured,
+			     bool *p_pre_fetch_configured);
+
+int fm_set_mac_max_frame(void *h_fm, enum fm_mac_type type,
+			 uint8_t mac_id, uint16_t mtu);
 
 #endif /* __FM_COMMON_H */
diff --git a/drivers/soc/fsl/fman/inc/crc_mac_addr_ext.h b/drivers/soc/fsl/fman/inc/crc_mac_addr_ext.h
new file mode 100644
index 0000000..12468cb
--- /dev/null
+++ b/drivers/soc/fsl/fman/inc/crc_mac_addr_ext.h
@@ -0,0 +1,343 @@
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
+/* Define a macro that calculate the crc value of an Ethernet MAC address
+ * (48 bitd address)
+ */
+
+#ifndef __crc_mac_addr_ext_h
+#define __crc_mac_addr_ext_h
+
+#include <linux/bitrev.h>
+
+static uint32_t crc_table[256] = {
+	0x00000000,
+	0x77073096,
+	0xee0e612c,
+	0x990951ba,
+	0x076dc419,
+	0x706af48f,
+	0xe963a535,
+	0x9e6495a3,
+	0x0edb8832,
+	0x79dcb8a4,
+	0xe0d5e91e,
+	0x97d2d988,
+	0x09b64c2b,
+	0x7eb17cbd,
+	0xe7b82d07,
+	0x90bf1d91,
+	0x1db71064,
+	0x6ab020f2,
+	0xf3b97148,
+	0x84be41de,
+	0x1adad47d,
+	0x6ddde4eb,
+	0xf4d4b551,
+	0x83d385c7,
+	0x136c9856,
+	0x646ba8c0,
+	0xfd62f97a,
+	0x8a65c9ec,
+	0x14015c4f,
+	0x63066cd9,
+	0xfa0f3d63,
+	0x8d080df5,
+	0x3b6e20c8,
+	0x4c69105e,
+	0xd56041e4,
+	0xa2677172,
+	0x3c03e4d1,
+	0x4b04d447,
+	0xd20d85fd,
+	0xa50ab56b,
+	0x35b5a8fa,
+	0x42b2986c,
+	0xdbbbc9d6,
+	0xacbcf940,
+	0x32d86ce3,
+	0x45df5c75,
+	0xdcd60dcf,
+	0xabd13d59,
+	0x26d930ac,
+	0x51de003a,
+	0xc8d75180,
+	0xbfd06116,
+	0x21b4f4b5,
+	0x56b3c423,
+	0xcfba9599,
+	0xb8bda50f,
+	0x2802b89e,
+	0x5f058808,
+	0xc60cd9b2,
+	0xb10be924,
+	0x2f6f7c87,
+	0x58684c11,
+	0xc1611dab,
+	0xb6662d3d,
+	0x76dc4190,
+	0x01db7106,
+	0x98d220bc,
+	0xefd5102a,
+	0x71b18589,
+	0x06b6b51f,
+	0x9fbfe4a5,
+	0xe8b8d433,
+	0x7807c9a2,
+	0x0f00f934,
+	0x9609a88e,
+	0xe10e9818,
+	0x7f6a0dbb,
+	0x086d3d2d,
+	0x91646c97,
+	0xe6635c01,
+	0x6b6b51f4,
+	0x1c6c6162,
+	0x856530d8,
+	0xf262004e,
+	0x6c0695ed,
+	0x1b01a57b,
+	0x8208f4c1,
+	0xf50fc457,
+	0x65b0d9c6,
+	0x12b7e950,
+	0x8bbeb8ea,
+	0xfcb9887c,
+	0x62dd1ddf,
+	0x15da2d49,
+	0x8cd37cf3,
+	0xfbd44c65,
+	0x4db26158,
+	0x3ab551ce,
+	0xa3bc0074,
+	0xd4bb30e2,
+	0x4adfa541,
+	0x3dd895d7,
+	0xa4d1c46d,
+	0xd3d6f4fb,
+	0x4369e96a,
+	0x346ed9fc,
+	0xad678846,
+	0xda60b8d0,
+	0x44042d73,
+	0x33031de5,
+	0xaa0a4c5f,
+	0xdd0d7cc9,
+	0x5005713c,
+	0x270241aa,
+	0xbe0b1010,
+	0xc90c2086,
+	0x5768b525,
+	0x206f85b3,
+	0xb966d409,
+	0xce61e49f,
+	0x5edef90e,
+	0x29d9c998,
+	0xb0d09822,
+	0xc7d7a8b4,
+	0x59b33d17,
+	0x2eb40d81,
+	0xb7bd5c3b,
+	0xc0ba6cad,
+	0xedb88320,
+	0x9abfb3b6,
+	0x03b6e20c,
+	0x74b1d29a,
+	0xead54739,
+	0x9dd277af,
+	0x04db2615,
+	0x73dc1683,
+	0xe3630b12,
+	0x94643b84,
+	0x0d6d6a3e,
+	0x7a6a5aa8,
+	0xe40ecf0b,
+	0x9309ff9d,
+	0x0a00ae27,
+	0x7d079eb1,
+	0xf00f9344,
+	0x8708a3d2,
+	0x1e01f268,
+	0x6906c2fe,
+	0xf762575d,
+	0x806567cb,
+	0x196c3671,
+	0x6e6b06e7,
+	0xfed41b76,
+	0x89d32be0,
+	0x10da7a5a,
+	0x67dd4acc,
+	0xf9b9df6f,
+	0x8ebeeff9,
+	0x17b7be43,
+	0x60b08ed5,
+	0xd6d6a3e8,
+	0xa1d1937e,
+	0x38d8c2c4,
+	0x4fdff252,
+	0xd1bb67f1,
+	0xa6bc5767,
+	0x3fb506dd,
+	0x48b2364b,
+	0xd80d2bda,
+	0xaf0a1b4c,
+	0x36034af6,
+	0x41047a60,
+	0xdf60efc3,
+	0xa867df55,
+	0x316e8eef,
+	0x4669be79,
+	0xcb61b38c,
+	0xbc66831a,
+	0x256fd2a0,
+	0x5268e236,
+	0xcc0c7795,
+	0xbb0b4703,
+	0x220216b9,
+	0x5505262f,
+	0xc5ba3bbe,
+	0xb2bd0b28,
+	0x2bb45a92,
+	0x5cb36a04,
+	0xc2d7ffa7,
+	0xb5d0cf31,
+	0x2cd99e8b,
+	0x5bdeae1d,
+	0x9b64c2b0,
+	0xec63f226,
+	0x756aa39c,
+	0x026d930a,
+	0x9c0906a9,
+	0xeb0e363f,
+	0x72076785,
+	0x05005713,
+	0x95bf4a82,
+	0xe2b87a14,
+	0x7bb12bae,
+	0x0cb61b38,
+	0x92d28e9b,
+	0xe5d5be0d,
+	0x7cdcefb7,
+	0x0bdbdf21,
+	0x86d3d2d4,
+	0xf1d4e242,
+	0x68ddb3f8,
+	0x1fda836e,
+	0x81be16cd,
+	0xf6b9265b,
+	0x6fb077e1,
+	0x18b74777,
+	0x88085ae6,
+	0xff0f6a70,
+	0x66063bca,
+	0x11010b5c,
+	0x8f659eff,
+	0xf862ae69,
+	0x616bffd3,
+	0x166ccf45,
+	0xa00ae278,
+	0xd70dd2ee,
+	0x4e048354,
+	0x3903b3c2,
+	0xa7672661,
+	0xd06016f7,
+	0x4969474d,
+	0x3e6e77db,
+	0xaed16a4a,
+	0xd9d65adc,
+	0x40df0b66,
+	0x37d83bf0,
+	0xa9bcae53,
+	0xdebb9ec5,
+	0x47b2cf7f,
+	0x30b5ffe9,
+	0xbdbdf21c,
+	0xcabac28a,
+	0x53b39330,
+	0x24b4a3a6,
+	0xbad03605,
+	0xcdd70693,
+	0x54de5729,
+	0x23d967bf,
+	0xb3667a2e,
+	0xc4614ab8,
+	0x5d681b02,
+	0x2a6f2b94,
+	0xb40bbe37,
+	0xc30c8ea1,
+	0x5a05df1b,
+	0x2d02ef8d
+};
+
+/* CRC calculation */
+#define GET_MAC_ADDR_CRC(addr, crc)				\
+{								\
+	uint32_t i;						\
+	uint8_t  data;						\
+	crc = 0xffffffff;					\
+	for (i = 0; i < 6; i++) {				\
+		data = (uint8_t)(addr >> ((5 - i) * 8));	\
+		crc = crc ^ data;				\
+		crc = crc_table[crc & 0xff] ^ (crc >> 8);	\
+	}							\
+}								\
+
+/*    Define a macro for getting the mirrored value of      */
+/*    a byte size number. (0x11010011 --> 0x11001011)       */
+/*    Sometimes the mirrored value of the CRC is required   */
+static inline uint8_t swab(uint8_t n)
+{
+	uint8_t mirror[16] = {
+		0x00,
+		0x08,
+		0x04,
+		0x0c,
+		0x02,
+		0x0a,
+		0x06,
+		0x0e,
+		0x01,
+		0x09,
+		0x05,
+		0x0d,
+		0x03,
+		0x0b,
+		0x07,
+		0x0f
+	};
+	return ((uint8_t)(((mirror[n & 0x0f] << 4) | (mirror[n >> 4]))));
+}
+
+#define MIRROR      bitrev
+#define MIRROR_32   bitrev32
+
+#endif /* __crc_mac_addr_ext_h */
diff --git a/drivers/soc/fsl/fman/inc/fm_mac_ext.h b/drivers/soc/fsl/fman/inc/fm_mac_ext.h
new file mode 100644
index 0000000..c5209c7
--- /dev/null
+++ b/drivers/soc/fsl/fman/inc/fm_mac_ext.h
@@ -0,0 +1,660 @@
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
+/* File          fm_mac_ext.h
+ * Description   FM MAC ...
+ */
+#ifndef __FM_MAC_EXT_H
+#define __FM_MAC_EXT_H
+
+#include "service.h"
+#include "enet_ext.h"
+#include "dpaa_integration_ext.h"
+
+struct fm_mac_dev;
+
+/* Description   FM MAC API functions, definitions and enums */
+
+#define FM_MAC_NO_PFC   0xff
+
+/* FM MAC Exceptions */
+enum fm_mac_exceptions {
+	FM_MAC_EX_10G_MDIO_SCAN_EVENT = 0
+	/* 10GEC MDIO scan event interrupt */
+	, FM_MAC_EX_10G_MDIO_CMD_CMPL
+	/* 10GEC MDIO command completion interrupt */
+	, FM_MAC_EX_10G_REM_FAULT
+	/* 10GEC, mEMAC Remote fault interrupt */
+	, FM_MAC_EX_10G_LOC_FAULT
+	/* 10GEC, mEMAC Local fault interrupt */
+	, FM_MAC_EX_10G_1TX_ECC_ER
+	/* 10GEC, mEMAC Transmit frame ECC error interrupt */
+	, FM_MAC_EX_10G_TX_FIFO_UNFL
+	/* 10GEC, mEMAC Transmit FIFO underflow interrupt */
+	, FM_MAC_EX_10G_TX_FIFO_OVFL
+	/* 10GEC, mEMAC Transmit FIFO overflow interrupt */
+	, FM_MAC_EX_10G_TX_ER
+	/* 10GEC Transmit frame error interrupt */
+	, FM_MAC_EX_10G_RX_FIFO_OVFL
+	/* 10GEC, mEMAC Receive FIFO overflow interrupt */
+	, FM_MAC_EX_10G_RX_ECC_ER
+	/* 10GEC, mEMAC Receive frame ECC error interrupt */
+	, FM_MAC_EX_10G_RX_JAB_FRM
+	/* 10GEC Receive jabber frame interrupt */
+	, FM_MAC_EX_10G_RX_OVRSZ_FRM
+	/* 10GEC Receive oversized frame interrupt */
+	, FM_MAC_EX_10G_RX_RUNT_FRM
+	/* 10GEC Receive runt frame interrupt */
+	, FM_MAC_EX_10G_RX_FRAG_FRM
+	/* 10GEC Receive fragment frame interrupt */
+	, FM_MAC_EX_10G_RX_LEN_ER
+	/* 10GEC Receive payload length error interrupt */
+	, FM_MAC_EX_10G_RX_CRC_ER
+	/* 10GEC Receive CRC error interrupt */
+	, FM_MAC_EX_10G_RX_ALIGN_ER
+	/* 10GEC Receive alignment error interrupt */
+	, FM_MAC_EX_1G_BAB_RX
+	/* dTSEC Babbling receive error */
+	, FM_MAC_EX_1G_RX_CTL
+	/* dTSEC Receive control (pause frame) interrupt */
+	, FM_MAC_EX_1G_GRATEFUL_TX_STP_COMPLET
+	/* dTSEC Graceful transmit stop complete */
+	, FM_MAC_EX_1G_BAB_TX
+	/* dTSEC Babbling transmit error */
+	, FM_MAC_EX_1G_TX_CTL
+	/* dTSEC Transmit control (pause frame) interrupt */
+	, FM_MAC_EX_1G_TX_ERR
+	/* dTSEC Transmit error */
+	, FM_MAC_EX_1G_LATE_COL
+	/* dTSEC Late collision */
+	, FM_MAC_EX_1G_COL_RET_LMT
+	/* dTSEC Collision retry limit */
+	, FM_MAC_EX_1G_TX_FIFO_UNDRN
+	/* dTSEC Transmit FIFO underrun */
+	, FM_MAC_EX_1G_MAG_PCKT
+	/* dTSEC Magic Packet detection */
+	, FM_MAC_EX_1G_MII_MNG_RD_COMPLET
+	/* dTSEC MII management read completion */
+	, FM_MAC_EX_1G_MII_MNG_WR_COMPLET
+	/* dTSEC MII management write completion */
+	, FM_MAC_EX_1G_GRATEFUL_RX_STP_COMPLET
+	/* dTSEC Graceful receive stop complete */
+	, FM_MAC_EX_1G_DATA_ERR
+	/* dTSEC Internal data error on transmit */
+	, FM_MAC_1G_RX_DATA_ERR
+	/* dTSEC Internal data error on receive */
+	, FM_MAC_EX_1G_1588_TS_RX_ERR
+	/* dTSEC Time-Stamp Receive Error */
+	, FM_MAC_EX_1G_RX_MIB_CNT_OVFL
+	/* dTSEC MIB counter overflow */
+	, FM_MAC_EX_TS_FIFO_ECC_ERR
+	/* mEMAC Time-stamp FIFO ECC error interrupt;
+	 * not supported on T4240/B4860 rev1 chips
+	 */
+	, FM_MAC_EX_MAGIC_PACKET_INDICATION = FM_MAC_EX_1G_MAG_PCKT
+	/* mEMAC Magic Packet Indication Interrupt */
+};
+
+/* TM MAC statistics level */
+enum fm_mac_statistics_level {
+	/* No statistics */
+	FM_MAC_NONE_STATISTICS = 0,
+	/* Only error counters are available; Optimized for performance */
+	FM_MAC_PARTIAL_STATISTICS,
+	/* All counters available; Not optimized for performance */
+	FM_MAC_FULL_STATISTICS
+};
+
+/* Function      fm_mac_exception_cb
+ * Description   Fm Mac Exception Callback from FM MAC to the user
+ *  Param[in]     h_app             - Handle to the upper layer handler
+ *  Param[in]     exceptions        - The exception that occurred
+ *  Return        void.
+ */
+typedef void (fm_mac_exception_cb) (void *h_app,
+				    enum fm_mac_exceptions exceptions);
+
+/* TM MAC statistics rfc3635 */
+struct fm_mac_statistics_t {
+/* RMON */
+	uint64_t e_stat_pkts64;	 /* r-10G tr-DT 64 byte frame counter */
+	uint64_t e_stat_pkts65to127; /* r-10G 65 to 127 byte frame counter */
+	uint64_t e_stat_pkts128to255;/* r-10G 128 to 255 byte frame counter */
+	uint64_t e_stat_pkts256to511;/* r-10G 256 to 511 byte frame counter */
+	/* r-10G 512 to 1023 byte frame counter */
+	uint64_t e_stat_pkts512to1023;
+	/* r-10G 1024 to 1518 byte frame counter */
+	uint64_t e_stat_pkts1024to1518;
+	/* r-10G 1519 to 1522 byte good frame count */
+	uint64_t e_stat_pkts1519to1522;
+	/* Total number of packets that were less than 64 octets
+	 * long with a wrong CRC.
+	 */
+	uint64_t e_stat_fragments;
+	/* Total number of packets longer than valid maximum length octets */
+	uint64_t e_stat_jabbers;
+	/* number of dropped packets due to internal errors
+	 * of the MAC Client (during receive).
+	 */
+	uint64_t e_stats_drop_events;
+	/* Incremented when frames of correct length
+	 * but with CRC error are received.
+	 */
+	uint64_t e_stat_crc_align_errors;
+	/* Incremented for frames under 64 bytes with a valid FCS
+	 * and otherwise well formed; This count does not include range
+	 * length errors
+	 */
+	uint64_t e_stat_undersize_pkts;
+	/* Incremented for frames which exceed 1518 (non VLAN) or 1522
+	 * (VLAN) and contains a valid FCS and otherwise well formed
+	 */
+	uint64_t e_stat_oversize_pkts;
+/* Pause */
+	uint64_t te_stat_pause;	       /* Pause MAC Control received */
+	uint64_t re_stat_pause;	       /* Pause MAC Control sent */
+/* MIB II */
+	uint64_t if_in_octets;	       /* Total number of byte received. */
+	uint64_t if_in_pkts;	       /* Total number of packets received.*/
+	/* Total number of unicast frame received; NOTE: this counter
+	 * is not supported on dTSEC MAC
+	 */
+	uint64_t if_in_ucast_pkts;
+	/* Total number of multicast frame received*/
+	uint64_t if_in_mcast_pkts;
+	/* Total number of broadcast frame received */
+	uint64_t if_in_bcast_pkts;
+	/* Frames received, but discarded due to problems
+	 * within the MAC RX.
+	 */
+	uint64_t if_in_discards;
+	/* Number of frames received with error:
+	 * - FIFO Overflow Error
+	 * - CRC Error
+	 * - Frame Too Long Error
+	 * - Alignment Error
+	 * - The dedicated Error Code (0xfe, not a code error) was received
+	 */
+	uint64_t if_in_errors;
+	uint64_t if_out_octets;	       /* Total number of byte sent. */
+	uint64_t if_out_pkts;	       /* Total number of packets sent .*/
+	uint64_t if_out_ucast_pkts;    /* Total number of unicast frame sent;
+					* NOTE: this counter is not supported
+					* on dTSEC MAC
+					*/
+	/* Total number of multicast frame sent */
+	uint64_t if_out_mcast_pkts;
+	/* Total number of multicast frame sent */
+	uint64_t if_out_bcast_pkts;
+	/* Frames received, but discarded due to
+	 * problems within the MAC TX N/A!.
+	 */
+	uint64_t if_out_discards;
+	uint64_t if_out_errors;	 /* Number of frames transmitted with error:
+				  * - FIFO Overflow Error
+				  * - FIFO Underflow Error
+				  * - Other
+				  */
+};
+
+/* FM MAC Initialization Unit */
+
+/* FM MAC config input */
+struct fm_mac_params_t {
+	/* Base of memory mapped FM MAC registers */
+	uintptr_t base_addr;
+	/* MAC address of device; First octet is sent first */
+	enet_addr_t addr;
+	/* MAC ID; numbering of dTSEC and 1G-mEMAC:
+	 * 0 - FM_MAX_NUM_OF_1G_MACS;
+	 * numbering of 10G-MAC (TGEC) and 10G-mEMAC:
+	 * 0 - FM_MAX_NUM_OF_10G_MACS
+	 */
+	uint8_t mac_id;
+	/* Ethernet operation mode (MAC-PHY interface and speed);
+	 * Note that the speed should indicate the maximum rate that
+	 * this MAC should support rather than the actual speed;
+	 * i.e. user should use the FM_MAC_AdjustLink() routine to
+	 * provide accurate speed;
+	 * In case of mEMAC RGMII mode, the MAC is configured to RGMII
+	 * automatic mode, where actual speed/duplex mode information
+	 * is provided by PHY automatically in-band; FM_MAC_AdjustLink()
+	 * function should be used to switch to manual RGMII speed/duplex mode
+	 * configuration if RGMII PHY doesn't support in-band status signaling;
+	 * In addition, in mEMAC, in case where user is using the higher MACs
+	 * (i.e. the MACs that should support 10G), user should pass here
+	 * speed=10000 even if the interface is not allowing that (e.g. SGMII).
+	 */
+	enum e_enet_mode enet_mode;
+	/* A handle to the FM object this port related to */
+	void *h_fm;
+	/* MDIO exceptions interrupt source - not valid for all
+	 * MACs; MUST be set to 'NO_IRQ' for MACs that don't have
+	 * mdio-irq, or for polling
+	 */
+	int mdio_irq;
+	fm_mac_exception_cb *f_event;	    /* MDIO Events Callback Routine */
+	fm_mac_exception_cb *f_exception;  /* Exception Callback Routine */
+	void *h_app;	/* A handle to an application layer object;
+			 * This handle will be passed by the driver
+			 * upon calling the above callbacks
+			 */
+};
+
+struct fm_mac_dev;
+
+/* Function	fm_mac_config
+ * Description	  Creates descriptor for the FM MAC module.
+ *		  The routine returns a pointer to the FM MAC object.
+ *		  This pointer must be passed as first parameter to all other
+ *		  FM MAC function calls.
+ *		  No actual initialization or configuration of FM MAC hardware
+ *		  is done by this routine.
+ * Param[in]	  p_fm_mac_param - Pointer to data structure of parameters
+ * Retval	  Pointer to FM MAC object, or NULL for Failure.
+ */
+struct fm_mac_dev *fm_mac_config(struct fm_mac_params_t *p_fm_mac_param);
+
+/* Function	fm_mac_init
+ * Description	  Initializes the FM MAC module
+ * Param[in]	  fm_mac_dev - Pointer to MAC object
+ * Return	  0 on success; Error code otherwise.
+ */
+int fm_mac_init(struct fm_mac_dev *fm_mac_dev);
+
+/* Function	fm_free
+ * Description	  Frees all resources that were assigned to FM MAC module.
+ *		  Calling this routine invalidates the descriptor.
+ * Param[in]	  fm_mac_dev - Pointer to MAC object
+ * Return	  0 on success; Error code otherwise.
+ */
+int fm_mac_free(struct fm_mac_dev *fm_mac_dev);
+
+/* Description   Configuration functions used to change default values. */
+
+/* Function	fm_mac_cfg_reset_on_init
+ * Description	  Tell the driver whether to reset the FM MAC before
+ *		  initialization or not. It changes the default configuration
+ *		  [DEFAULT_RESET_ON_INIT].
+ * Param[in]	  fm_mac_dev - Pointer to MAC object
+ * Param[in]	  enable - When true, FM will be reset before initialization.
+ * Return	  0 on success; Error code otherwise.
+ * Cautions	  Allowed only following fm_mac_config() and before
+ *		  fm_mac_init().
+ */
+int fm_mac_cfg_reset_on_init(struct fm_mac_dev *fm_mac_dev, bool enable);
+
+/* Function	fm_mac_cfg_max_frame_len
+ * Description	  Setup maximum Rx Frame Length (in 1G MAC, effects also Tx)
+ * Param[in]	  fm_mac_dev - Pointer to MAC object
+ * Param[in]	  new_val - MAX Frame length
+ * Return	  0 on success; Error code otherwise.
+ * Cautions	  Allowed only following fm_mac_config() and before
+ *		  fm_mac_init().
+ */
+int fm_mac_cfg_max_frame_len(struct fm_mac_dev *fm_mac_dev, uint16_t new_val);
+
+/* Function	fm_mac_cfg_wan
+ * Description	  ENABLE WAN mode in 10G-MAC
+ * Param[in]	  fm_mac_dev - Pointer to MAC object
+ * Param[in]	  enable - true to enable or false to disable.
+ *  Return	  0 on success; Error code otherwise.
+ *  Cautions	  Allowed only following fm_mac_config() and before
+ *		  fm_mac_init().
+ */
+int fm_mac_cfg_wan(struct fm_mac_dev *fm_mac_dev, bool enable);
+
+/* Function	fm_mac_cfg_pad_and_crc
+ * Description	  Config PAD and CRC mode
+ * Param[in]	  fm_mac_dev - Pointer to MAC object
+ * Param[in]	  enable - true to enable or false to disable.
+ * Return	  0 on success; Error code otherwise.
+ * Cautions	  Allowed only following fm_mac_config() and before
+ *		  fm_mac_init().
+ *		  Not supported on 10G-MAC (i.e. CRC&PAD are added
+ *		  automatically by HW); on mEMAC, this routine supports only
+ *		  PAD (i.e. CRC is added automatically by HW).
+ */
+int fm_mac_cfg_pad_and_crc(struct fm_mac_dev *fm_mac_dev, bool enable);
+
+/* Function	fm_mac_cfg_half_duplex
+ * Description	  Config Half Duplex Mode
+ * Param[in]	  fm_mac_dev - Pointer to MAC object
+ * Param[in]	  enable - true to enable or false to disable.
+ * Return	  0 on success; Error code otherwise.
+ * Cautions	  Allowed only following fm_mac_config() and before
+ *		  fm_mac_init().
+ */
+int fm_mac_cfg_half_duplex(struct fm_mac_dev *fm_mac_dev, bool enable);
+
+/* Function	fm_mac_cfg_tbi_phy_addr
+ * Description	  Configures the address of internal TBI PHY.
+ * Param[in]	  fm_mac_dev - Pointer to MAC object
+ * Param[in]	  new_val - TBI PHY address (1-31).
+ * Return	  0 on success; Error code otherwise.
+ * Cautions	  Allowed only following fm_mac_config() and before
+ *		  fm_mac_init().
+ */
+int fm_mac_cfg_tbi_phy_addr(struct fm_mac_dev *fm_mac_dev, uint8_t new_val);
+
+/* Function	fm_mac_cfg_len_check
+ * Description	  Configure the frame length checking.
+ * Param[in]	  fm_mac_dev - Pointer to MAC object
+ * Param[in]	  enable - true to enable or false to disable.
+ * Return	  0 on success; Error code otherwise.
+ * Cautions	  Allowed only following fm_mac_config() and before
+ *		  fm_mac_init().
+ */
+int fm_mac_cfg_len_check(struct fm_mac_dev *fm_mac_dev, bool enable);
+
+/* Function	fm_mac_cfg_exception
+ * Description	  Change Exception selection from default
+ * Param[in]	  fm_mac_dev - Pointer to MAC object
+ * Param[in]	  ex - Type of the desired exceptions
+ * Param[in]	  enable - true to enable the specified exception,
+ * Return	  0 on success; Error code otherwise.
+ * Cautions	  Allowed only following fm_mac_config() and before
+ *		  fm_mac_init().
+ */
+int fm_mac_cfg_exception(struct fm_mac_dev *fm_mac_dev,
+			 enum fm_mac_exceptions ex,
+			 bool enable);
+
+#ifdef FM_TX_ECC_FRMS_ERRATA_10GMAC_A004
+int fm_mac_cfg_skip_fman11_wa(struct fm_mac_dev *fm_mac_dev);
+#endif /* FM_TX_ECC_FRMS_ERRATA_10GMAC_A004 */
+
+/* FM MAC Runtime control unit API functions, definitions and enums. */
+
+/* Function	fm_mac_enable
+ * Description	  Enable the MAC
+ * Param[in]	  fm_mac_dev - Pointer to MAC object
+ * Param[in]	  mode - Mode of operation (RX, TX, Both)
+ * Return	  0 on success; Error code otherwise.
+ * Cautions	  Allowed only following fm_mac_init().
+ */
+int fm_mac_enable(struct fm_mac_dev*, enum comm_mode mode);
+
+/* Function	fm_mac_disable
+ * Description	  Disavle the MAC
+ * Param[in]	  fm_mac_dev - Pointer to MAC object
+ * Param[in]	  mode - Mode of operation (RX, TX, Both)
+ * Return	  0 on success; Error code otherwise.
+ * Cautions	  Allowed only following fm_mac_init().
+ */
+int fm_mac_disable(struct fm_mac_dev *fm_mac_dev, enum comm_mode mode);
+
+/* Function	fm_mac_enable_1588_time_stamp
+ * Description	  Enables the TSU operation.
+ * Param[in]	  fm_mac_dev - Pointer to MAC object
+ * Return	  0 on success; Error code otherwise.
+ * Cautions	  Allowed only following fm_mac_init().
+ */
+int fm_mac_enable_1588_time_stamp(struct fm_mac_dev *fm_mac_dev);
+
+/* Function	fm_mac_enable_1588_time_stamp
+ * Description	  Disable the TSU operation.
+ * Param[in]	  fm_mac_dev - Pointer to MAC object
+ * Return	  0 on success; Error code otherwise.
+ * Cautions	  Allowed only following fm_mac_init().
+ */
+int fm_mac_disable_1588_time_stamp(struct fm_mac_dev *fm_mac_dev);
+
+#define FSL_FM_PAUSE_TIME_ENABLE	0xf000
+#define FSL_FM_PAUSE_TIME_DISABLE	0
+#define FSL_FM_PAUSE_THRESH_DEFAULT	0
+
+/* Function	fm_mac_set_tx_pause_frames
+ * Description	  Enable/Disable transmission of Pause-Frames.
+ *		  The routine changes the default configuration:
+ *		  pause-time - [DEFAULT_TX_PAUSE_TIME]
+ *		  threshold-time - [0]
+ * Param[in]	  fm_mac_dev - Pointer to MAC object
+ * Param[in]	  priority - the PFC class of service; use 'FM_MAC_NO_PFC'
+ *		  to indicate legacy pause support (i.e. no PFC).
+ * Param[in]	  pause_time - Pause quanta value used with transmitted pause
+ *		  frames. Each quanta represents a 512 bit-times;
+ *		  Note that '0' as an input here will be used as disabling the
+ *		  transmission of the pause-frames.
+ * Param[in]	  thresh_time - Pause Threshold equanta value used by the MAC
+ *		  to retransmit pause frame.
+ *		  If the situation causing a pause frame to be sent didn't
+ *		  finish when the timer reached the threshold quanta, the MAC
+ *		  will retransmit the pause frame. Each quanta represents a
+ *		  512 bit-times. For legacy pause support (i.e. no PFC), thus
+ *		  value should be '0'.
+ * Return	  0 on success; Error code otherwise.
+ * Cautions	  Allowed only following fm_mac_init().
+ *		  In order for PFC to work properly the user must configure
+ *		  TNUM-aging in the tx-port it is recommended that pre-fetch
+ *		  and rate limit in the tx port should be disabled;
+ *		  PFC is supported only on new mEMAC; i.e. in MACs that don't
+ *		  have PFC support (10G-MAC and dTSEC), user should use
+ *		  'FM_MAC_NO_PFC' in the 'priority' field.
+ */
+int fm_mac_set_tx_pause_frames(struct fm_mac_dev *fm_mac_dev,
+			       uint8_t priority,
+			       uint16_t pause_time,
+			       uint16_t thresh_time);
+
+/* Function	fm_mac_set_rx_pause_frames
+ * Description	  Enable/Disable rx Pause-Frames.
+ * Param[in]	  fm_mac_dev - A Pointer to MAC object
+ * Param[in]	  en - boolean indicates whether to ignore the incoming pause
+ *		  frames or not.
+ * Return	  0 on success; Error code otherwise.
+ * Cautions	  Allowed only following fm_mac_init().
+ */
+int fm_mac_set_rx_pause_frames(struct fm_mac_dev *fm_mac_dev, bool en);
+
+/* Function	fm_mac_set_wake_on_lan
+ * Description	  Enable/Disable Wake On Lan support
+ * Param[in]	  fm_mac_dev - A Pointer to MAC object
+ * Param[in]	  en - boolean indicates whether to enable Wake On Lan
+ *		  support or not.
+ * Return	  0 on success; Error code otherwise.
+ * Cautions	  Allowed only following fm_mac_init().
+ */
+int fm_mac_set_wake_on_lan(struct fm_mac_dev *fm_mac_dev, bool en);
+
+/* Function	fm_mac_reset_counters
+ * Description	  reset all statistics counters
+ * Param[in]	  fm_mac_dev - Pointer to MAC object
+ * Return	  0 on success; Error code otherwise.
+ * Cautions	  Allowed only following fm_mac_init().
+ */
+int fm_mac_reset_counters(struct fm_mac_dev *fm_mac_dev);
+
+/* Function	fm_mac_set_exception
+ * Description	  Enable/Disable a specific Exception
+ * Param[in]	  fm_mac_dev - Pointer to MAC object
+ * Param[in]	  ex - Type of the desired exceptions
+ * Param[in]	  enable - true to enable the specified exception,
+ *		  false to disable it.
+ * Return	  0 on success; Error code otherwise.
+ * Cautions	  Allowed only following fm_mac_init().
+ */
+int fm_mac_set_exception(struct fm_mac_dev *fm_mac_dev,
+			 enum fm_mac_exceptions ex,
+			 bool enable);
+
+/* Function	fm_mac_set_statistics
+ * Description	  Define Statistics level.
+ *		  Where applicable, the routine also enables the MIB counters
+ *		  overflow interrupt in order to keep counters accurate
+ *		  and account for overflows.
+ *		  This routine is relevant only for dTSEC.
+ * Param[in]	  fm_mac_dev - Pointer to MAC object
+ * Param[in]	  statistics_level - Full statistics level provides all
+ *		  standard counters but may reduce performance.
+ *		  Partial statistics provides only special event counters
+ *		  (errors etc.). If selected, regular counters
+ *		  (such as byte/packet) will be invalid and will return -1.
+ * Return	  0 on success; Error code otherwise.
+ * Cautions	  Allowed only following fm_mac_init().
+ */
+int fm_mac_set_statistics(struct fm_mac_dev *fm_mac_dev,
+			  enum fm_mac_statistics_level statistics_level);
+
+/* Function	fm_mac_get_statistics
+ * Description	  get all statistics counters
+ * Param[in]	  fm_mac_dev - Pointer to MAC object
+ * Param[in]	  p_statistics - Structure with statistics
+ * Return	  0 on success; Error code otherwise.
+ * Cautions	  Allowed only following fm_init().
+ */
+int fm_mac_get_statistics(struct fm_mac_dev *fm_mac_dev,
+			  struct fm_mac_statistics_t *p_statistics);
+
+/* Function	fm_mac_modify_mac_addr
+ * Description	  Replace the main MAC Address
+ * Param[in]	  fm_mac_dev - A pointer to MAC object
+ * Param[in]	  p_enet_addr - Ethernet Mac address
+ * Return	  0 on success; Error code otherwise.
+ * Cautions	  Allowed only after fm_mac_init().
+ */
+int fm_mac_modify_mac_addr(struct fm_mac_dev *fm_mac_dev,
+			   enet_addr_t *p_enet_addr);
+
+/* Function	fm_mac_add_hash_mac_addr
+ * Description	  Add an Address to the hash table. This is for filter purpose
+ *		  only.
+ * Param[in]	  fm_mac_dev - Pointer to MAC object
+ * Param[in]	  p_enet_addr - Ethernet Mac address
+ * Return	  0 on success; Error code otherwise.
+ * Cautions	  Allowed only following fm_mac_init().
+ *		  It is a filter only address.
+ * Cautions	  Some address need to be filterd out in upper FM blocks.
+ */
+int fm_mac_add_hash_mac_addr(struct fm_mac_dev *fm_mac_dev,
+			     enet_addr_t *p_enet_addr);
+
+/* Function	fm_mac_remove_hash_mac_addr
+ * Description	  Delete an Address to the hash table. This is for filter
+ *		  purpose only.
+ * Param[in]	  fm_mac_dev - Pointer to MAC object
+ * Param[in]	  p_enet_addr - Ethernet Mac address
+ * Return	  0 on success; Error code otherwise.
+ * Cautions	  Allowed only following fm_mac_init().
+ */
+int fm_mac_remove_hash_mac_addr(struct fm_mac_dev *fm_mac_dev,
+				enet_addr_t *p_enet_addr);
+
+/* Function	fm_mac_add_exact_match_mac_addr
+ * Description	  Add a unicast or multicast mac address for exact-match
+ *		  filtering (8 on dTSEC, 2 for 10G-MAC)
+ * Param[in]	  fm_mac_dev - Pointer to MAC object
+ * Param[in]	  p_enet_addr - MAC Address to ADD
+ * Return	  0 on success; Error code otherwise.
+ * Cautions	  Allowed only after fm_mac_init().
+ */
+int fm_mac_add_exact_match_mac_addr(struct fm_mac_dev *fm_mac_dev,
+				    enet_addr_t *p_enet_addr);
+
+/* Function	fm_mac_removel_exact_match_mac_addr
+ * Description	  Remove a uni cast or multi cast mac address.
+ * Param[in]	  fm_mac_dev - Pointer to MAC object
+ * Param[in]	  p_enet_addr - MAC Address to remove
+ * Return	  0 on success; Error code otherwise.
+ * Cautions	  Allowed only after fm_mac_init().
+ */
+int fm_mac_removel_exact_match_mac_addr(struct fm_mac_dev *fm_mac_dev,
+					enet_addr_t *p_enet_addr);
+
+/* Function	fm_mac_set_promiscuous
+ * Description	  Enable/Disable MAC Promiscuous mode for ALL mac addresses.
+ * Param[in]	  fm_mac_dev - Pointer to MAC object
+ * Param[in]	  enable -true to enable or false to disable.
+ * Return	  0 on success; Error code otherwise.
+ * Cautions	  Allowed only after fm_mac_init().
+ */
+int fm_mac_set_promiscuous(struct fm_mac_dev *fm_mac_dev, bool enable);
+
+/* Function	fm_mac_adjust_link
+ * Description	  Adjusts the Ethernet link with new speed/duplex setup.
+ *		  This routine is relevant for dTSEC and mEMAC.
+ *		  In case of mEMAC, this routine is also used for manual
+ *		  re-configuration of RGMII speed and duplex mode for
+ *		  RGMII PHYs not supporting in-band status information to MAC.
+ * Param[in]	  fm_mac_dev - A pointer to MAC object
+ * Param[in]	  speed - Ethernet speed.
+ * Param[in]	  full_duplex - true for full-duplex mode;
+ *		  false for half-duplex mode.
+ * Return	  0 on success; Error code otherwise.
+ */
+int fm_mac_adjust_link(struct fm_mac_dev *fm_mac_dev, int link,
+		       enum ethernet_speed speed, bool full_duplex);
+
+/* Function	fm_mac_restart_autoneg
+ * Description	  Restarts the auto-negotiation process.
+ *		  When auto-negotiation process is invoked under traffic the
+ *		  auto-negotiation process between the internal SGMII PHY and
+ *		  the external PHY does not always complete successfully.
+ *		  Calling this function will restart the auto-negotiation
+ *		  process that will end successfully. It is recommended to
+ *		  call this function after issuing auto-negotiation restart
+ *		  command to the Eth Phy.
+ *		  This routine is relevant only for dTSEC.
+ * Param[in]	  fm_mac_dev - Pointer to MAC object
+ * Return	  0 on success; Error code otherwise.
+ */
+int fm_mac_restart_autoneg(struct fm_mac_dev *fm_mac_dev);
+
+/* Function	fm_mac_get_max_frame_length
+ * Description	  Return the max frame length value
+ * Param[in]	  fm_mac_dev - Pointer to MAC object
+ * Param[out]	  p_mac_id - MAC ID of device.
+ * Return	  the maximum frame length value
+ * Cautions	  Allowed only after fm_mac_init().
+ */
+uint16_t fm_mac_get_max_frame_length(struct fm_mac_dev *fm_mac_dev);
+
+/* Function	fm_mac_get_id
+ * Description	  Return the MAC ID
+ * Param[in]	  fm_mac_dev - Pointer to MAC object
+ * Param[out]	  p_mac_id - MAC ID of device.
+ * Return	  0 on success; Error code otherwise.
+ * Cautions	  Allowed only after fm_mac_init().
+ */
+int fm_mac_get_id(struct fm_mac_dev *fm_mac_dev, uint32_t *p_mac_id);
+
+/* Function	fm_mac_get_version
+ * Description	  Return Mac HW chip version
+ * Param[in]	  fm_mac_dev - Pointer to MAC object
+ * Param[out]	  p_mac_version -   Mac version as defined by the chip
+ * Return	  0 on success; Error code otherwise.
+ * Cautions	  Allowed only after fm_mac_init().
+ */
+int fm_mac_get_version(struct fm_mac_dev *fm_mac_dev,
+		       uint32_t *p_mac_version);
+
+#endif /* __FM_MAC_EXT_H */
diff --git a/drivers/soc/fsl/fman/mac/Makefile b/drivers/soc/fsl/fman/mac/Makefile
index 80b7048..042a1f7 100644
--- a/drivers/soc/fsl/fman/mac/Makefile
+++ b/drivers/soc/fsl/fman/mac/Makefile
@@ -1,5 +1,8 @@
 obj-$(CONFIG_FSL_FMAN_MAC)	+= fsl_fman_mac.o
 
 fsl_fman_mac-objs		:= fman_dtsec.o fman_dtsec_mii_acc.o	\
-				   fman_memac.o fman_tgec.o		\
-				   fman_crc32.o fman_memac_mii_acc.o
+				    dtsec.o dtsec_mii_acc.o		\
+				   fman_memac.o fman_memac_mii_acc.o	\
+				   memac.o memac_mii_acc.o		\
+				   fman_tgec.o tgec.o			\
+				   fman_crc32.o fm_mac.o
diff --git a/drivers/soc/fsl/fman/mac/dtsec.c b/drivers/soc/fsl/fman/mac/dtsec.c
new file mode 100644
index 0000000..67909cf
--- /dev/null
+++ b/drivers/soc/fsl/fman/mac/dtsec.c
@@ -0,0 +1,1655 @@
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
+/* FMan dTSEC driver */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include "service.h"
+#include "crc_mac_addr_ext.h"
+
+#include "fm_common.h"
+#include "dtsec.h"
+#include "fsl_fman_dtsec.h"
+#include "fsl_fman_dtsec_mii_acc.h"
+
+#include <linux/string.h>
+#include <linux/slab.h>
+#include <linux/bitrev.h>
+
+/* Internal routines */
+
+static int check_init_parameters(struct dtsec_t *p_dtsec)
+{
+	if (ENET_SPEED_FROM_MODE(p_dtsec->enet_mode) >= ENET_SPEED_10000) {
+		pr_err("1G MAC driver supports 1G or lower speeds\n");
+		return -EDOM;
+	}
+	if (p_dtsec->addr == 0) {
+		pr_err("Ethernet MAC Must have a valid MAC Address\n");
+		return -EDOM;
+	}
+	if ((ENET_SPEED_FROM_MODE(p_dtsec->enet_mode) >= ENET_SPEED_1000) &&
+	    p_dtsec->p_dtsec_drv_param->halfdup_on) {
+		pr_err("Ethernet MAC 1G can't work in half duplex\n");
+		return -EDOM;
+	}
+	if (p_dtsec->p_dtsec_drv_param->halfdup_on &&
+	    (p_dtsec->p_dtsec_drv_param)->loopback) {
+		pr_err("LoopBack is not supported in half_duplex mode\n");
+		return -EDOM;
+	}
+#ifdef FM_RX_PREAM_4_ERRATA_DTSEC_A001
+	/* fixed for rev3 */
+	if (p_dtsec->fm_mac_ctrl_drv.fm_rev_info.major_rev <= 6)
+		if (p_dtsec->p_dtsec_drv_param->rx_preamble) {
+			pr_err("preambleRxEn\n");
+			return -ENOSYS;
+	}
+#endif /* FM_RX_PREAM_4_ERRATA_DTSEC_A001 */
+	if (((p_dtsec->p_dtsec_drv_param)->tx_preamble ||
+	     (p_dtsec->p_dtsec_drv_param)->rx_preamble) &&
+	    ((p_dtsec->p_dtsec_drv_param)->preamble_len != 0x7)) {
+		pr_err("Preamble length should be 0x7 bytes\n");
+		return -EDOM;
+	}
+	if ((p_dtsec->p_dtsec_drv_param)->halfdup_on &&
+	    (p_dtsec->p_dtsec_drv_param->tx_time_stamp_en ||
+	     p_dtsec->p_dtsec_drv_param->rx_time_stamp_en)) {
+		pr_err("1588 timeStamp disabled in half duplex mode\n");
+		return -EDOM;
+	}
+	if ((p_dtsec->p_dtsec_drv_param)->rx_flow &&
+	    (p_dtsec->p_dtsec_drv_param)->rx_ctrl_acc) {
+		pr_err("Receive control frame can not be accepted\n");
+		return -ENOSYS;
+	}
+	if ((p_dtsec->p_dtsec_drv_param)->rx_prepend >
+	    MAX_PACKET_ALIGNMENT) {
+		pr_err("packetAlignmentPadding can't be > than %d\n",
+		       MAX_PACKET_ALIGNMENT);
+		return -ENOSYS;
+	}
+	if (((p_dtsec->p_dtsec_drv_param)->non_back_to_back_ipg1 >
+	     MAX_INTER_PACKET_GAP) ||
+	    ((p_dtsec->p_dtsec_drv_param)->non_back_to_back_ipg2 >
+	     MAX_INTER_PACKET_GAP) ||
+	     ((p_dtsec->p_dtsec_drv_param)->back_to_back_ipg >
+	      MAX_INTER_PACKET_GAP)) {
+		pr_err("Inter packet gap can't be greater than %d\n",
+		       MAX_INTER_PACKET_GAP);
+		return -ENOSYS;
+	}
+	if ((p_dtsec->p_dtsec_drv_param)->halfdup_alt_backoff_val >
+	    MAX_INTER_PALTERNATE_BEB) {
+		pr_err("alternateBackoffVal can't be greater than %d\n",
+		       MAX_INTER_PALTERNATE_BEB);
+		return -ENOSYS;
+	}
+	if ((p_dtsec->p_dtsec_drv_param)->halfdup_retransmit >
+	    MAX_RETRANSMISSION) {
+		pr_err("maxRetransmission can't be greater than %d\n",
+		       MAX_RETRANSMISSION);
+		return -ENOSYS;
+	}
+	if ((p_dtsec->p_dtsec_drv_param)->halfdup_coll_window >
+	    MAX_COLLISION_WINDOW) {
+		pr_err("collisionWindow can't be greater than %d\n",
+		       MAX_COLLISION_WINDOW);
+		return -ENOSYS;
+	/*  If Auto negotiation process is disabled, need to */
+	/*  Set up the PHY using the MII Management Interface */
+	}
+	if (p_dtsec->p_dtsec_drv_param->tbipa > MAX_PHYS) {
+		pr_err("PHY address (should be 0-%d)\n", MAX_PHYS);
+		return -ERANGE;
+	}
+	if (!p_dtsec->f_exception) {
+		pr_err("uninitialized f_exception\n");
+		return -EINVAL;
+	}
+	if (!p_dtsec->f_event) {
+		pr_err("uninitialized f_event\n");
+		return -EINVAL;
+	}
+#ifdef FM_LEN_CHECK_ERRATA_FMAN_SW002
+	if (p_dtsec->fm_mac_ctrl_drv.fm_rev_info.major_rev != 4 &&
+	    p_dtsec->p_dtsec_drv_param->rx_len_check) {
+		pr_warn("LengthCheck!\n");
+		return -ENOSYS;
+	}
+#endif /* FM_LEN_CHECK_ERRATA_FMAN_SW002 */
+
+	return 0;
+}
+
+static int get_exception_flag(enum fm_mac_exceptions exception)
+{
+	uint32_t bit_mask;
+
+	switch (exception) {
+	case FM_MAC_EX_1G_BAB_RX:
+		bit_mask = DTSEC_IMASK_BREN;
+		break;
+	case FM_MAC_EX_1G_RX_CTL:
+		bit_mask = DTSEC_IMASK_RXCEN;
+		break;
+	case FM_MAC_EX_1G_GRATEFUL_TX_STP_COMPLET:
+		bit_mask = DTSEC_IMASK_GTSCEN;
+		break;
+	case FM_MAC_EX_1G_BAB_TX:
+		bit_mask = DTSEC_IMASK_BTEN;
+		break;
+	case FM_MAC_EX_1G_TX_CTL:
+		bit_mask = DTSEC_IMASK_TXCEN;
+		break;
+	case FM_MAC_EX_1G_TX_ERR:
+		bit_mask = DTSEC_IMASK_TXEEN;
+		break;
+	case FM_MAC_EX_1G_LATE_COL:
+		bit_mask = DTSEC_IMASK_LCEN;
+		break;
+	case FM_MAC_EX_1G_COL_RET_LMT:
+		bit_mask = DTSEC_IMASK_CRLEN;
+		break;
+	case FM_MAC_EX_1G_TX_FIFO_UNDRN:
+		bit_mask = DTSEC_IMASK_XFUNEN;
+		break;
+	case FM_MAC_EX_1G_MAG_PCKT:
+		bit_mask = DTSEC_IMASK_MAGEN;
+		break;
+	case FM_MAC_EX_1G_MII_MNG_RD_COMPLET:
+		bit_mask = DTSEC_IMASK_MMRDEN;
+		break;
+	case FM_MAC_EX_1G_MII_MNG_WR_COMPLET:
+		bit_mask = DTSEC_IMASK_MMWREN;
+		break;
+	case FM_MAC_EX_1G_GRATEFUL_RX_STP_COMPLET:
+		bit_mask = DTSEC_IMASK_GRSCEN;
+		break;
+	case FM_MAC_EX_1G_DATA_ERR:
+		bit_mask = DTSEC_IMASK_TDPEEN;
+		break;
+	case FM_MAC_EX_1G_RX_MIB_CNT_OVFL:
+		bit_mask = DTSEC_IMASK_MSROEN;
+		break;
+	default:
+		bit_mask = 0;
+		break;
+	}
+
+	return bit_mask;
+}
+
+/* Checks if p_dtsec driver parameters were initialized
+ * returns 0 if success else returns error code
+ */
+static int is_init_done(struct dtsec_cfg *p_dtsec_drv_parameters)
+{
+	if (!p_dtsec_drv_parameters)
+		return 0;
+	return -ENOSYS;
+}
+
+static uint32_t get_mac_addr_hash_code(uint64_t eth_addr)
+{
+	uint32_t crc;
+
+	/* CRC calculation */
+	GET_MAC_ADDR_CRC(eth_addr, crc);
+
+	crc = bitrev32(crc);
+
+	return crc;
+}
+
+static void update_statistics(struct dtsec_t *p_dtsec)
+{
+	uint32_t car1, car2;
+
+	fman_dtsec_get_clear_carry_regs(p_dtsec->p_mem_map, &car1, &car2);
+
+	if (car1) {
+		if (car1 & CAR1_TR64)
+			p_dtsec->internal_statistics.tr64 += VAL22BIT;
+		if (car1 & CAR1_TR127)
+			p_dtsec->internal_statistics.tr127 += VAL22BIT;
+		if (car1 & CAR1_TR255)
+			p_dtsec->internal_statistics.tr255 += VAL22BIT;
+		if (car1 & CAR1_TR511)
+			p_dtsec->internal_statistics.tr511 += VAL22BIT;
+		if (car1 & CAR1_TRK1)
+			p_dtsec->internal_statistics.tr1k += VAL22BIT;
+		if (car1 & CAR1_TRMAX)
+			p_dtsec->internal_statistics.trmax += VAL22BIT;
+		if (car1 & CAR1_TRMGV)
+			p_dtsec->internal_statistics.trmgv += VAL22BIT;
+		if (car1 & CAR1_RBYT)
+			p_dtsec->internal_statistics.rbyt += (uint64_t)VAL32BIT;
+		if (car1 & CAR1_RPKT)
+			p_dtsec->internal_statistics.rpkt += VAL22BIT;
+		if (car1 & CAR1_RMCA)
+			p_dtsec->internal_statistics.rmca += VAL22BIT;
+		if (car1 & CAR1_RBCA)
+			p_dtsec->internal_statistics.rbca += VAL22BIT;
+		if (car1 & CAR1_RXPF)
+			p_dtsec->internal_statistics.rxpf += VAL16BIT;
+		if (car1 & CAR1_RALN)
+			p_dtsec->internal_statistics.raln += VAL16BIT;
+		if (car1 & CAR1_RFLR)
+			p_dtsec->internal_statistics.rflr += VAL16BIT;
+		if (car1 & CAR1_RCDE)
+			p_dtsec->internal_statistics.rcde += VAL16BIT;
+		if (car1 & CAR1_RCSE)
+			p_dtsec->internal_statistics.rcse += VAL16BIT;
+		if (car1 & CAR1_RUND)
+			p_dtsec->internal_statistics.rund += VAL16BIT;
+		if (car1 & CAR1_ROVR)
+			p_dtsec->internal_statistics.rovr += VAL16BIT;
+		if (car1 & CAR1_RFRG)
+			p_dtsec->internal_statistics.rfrg += VAL16BIT;
+		if (car1 & CAR1_RJBR)
+			p_dtsec->internal_statistics.rjbr += VAL16BIT;
+		if (car1 & CAR1_RDRP)
+			p_dtsec->internal_statistics.rdrp += VAL16BIT;
+	}
+	if (car2) {
+		if (car2 & CAR2_TFCS)
+			p_dtsec->internal_statistics.tfcs += VAL12BIT;
+		if (car2 & CAR2_TBYT)
+			p_dtsec->internal_statistics.tbyt += (uint64_t)VAL32BIT;
+		if (car2 & CAR2_TPKT)
+			p_dtsec->internal_statistics.tpkt += VAL22BIT;
+		if (car2 & CAR2_TMCA)
+			p_dtsec->internal_statistics.tmca += VAL22BIT;
+		if (car2 & CAR2_TBCA)
+			p_dtsec->internal_statistics.tbca += VAL22BIT;
+		if (car2 & CAR2_TXPF)
+			p_dtsec->internal_statistics.txpf += VAL16BIT;
+		if (car2 & CAR2_TDRP)
+			p_dtsec->internal_statistics.tdrp += VAL16BIT;
+	}
+}
+
+static uint16_t dtsec_get_max_frame_length(void *h_dtsec)
+{
+	struct dtsec_t *p_dtsec = (struct dtsec_t *)h_dtsec;
+	int ret;
+
+	ret = is_init_done(p_dtsec->p_dtsec_drv_param);
+	if (ret)
+		return 0;
+
+	return fman_dtsec_get_max_frame_len(p_dtsec->p_mem_map);
+}
+
+static void dtsec_isr(void *h_dtsec)
+{
+	struct dtsec_t *p_dtsec = (struct dtsec_t *)h_dtsec;
+	uint32_t event;
+	struct dtsec_regs __iomem *p_dtsec_mem_map = p_dtsec->p_mem_map;
+
+	/* do not handle MDIO events */
+	event =
+	    fman_dtsec_get_event(p_dtsec_mem_map,
+				 (uint32_t)(~
+					     (DTSEC_IMASK_MMRDEN |
+					      DTSEC_IMASK_MMWREN)));
+
+	event &= fman_dtsec_get_interrupt_mask(p_dtsec_mem_map);
+
+	fman_dtsec_ack_event(p_dtsec_mem_map, event);
+
+	if (event & DTSEC_IMASK_BREN)
+		p_dtsec->f_exception(p_dtsec->h_app, FM_MAC_EX_1G_BAB_RX);
+	if (event & DTSEC_IMASK_RXCEN)
+		p_dtsec->f_exception(p_dtsec->h_app, FM_MAC_EX_1G_RX_CTL);
+	if (event & DTSEC_IMASK_MSROEN)
+		update_statistics(p_dtsec);
+	if (event & DTSEC_IMASK_GTSCEN)
+		p_dtsec->f_exception(p_dtsec->h_app,
+				     FM_MAC_EX_1G_GRATEFUL_TX_STP_COMPLET);
+	if (event & DTSEC_IMASK_BTEN)
+		p_dtsec->f_exception(p_dtsec->h_app, FM_MAC_EX_1G_BAB_TX);
+	if (event & DTSEC_IMASK_TXCEN)
+		p_dtsec->f_exception(p_dtsec->h_app, FM_MAC_EX_1G_TX_CTL);
+	if (event & DTSEC_IMASK_TXEEN)
+		p_dtsec->f_exception(p_dtsec->h_app, FM_MAC_EX_1G_TX_ERR);
+	if (event & DTSEC_IMASK_LCEN)
+		p_dtsec->f_exception(p_dtsec->h_app, FM_MAC_EX_1G_LATE_COL);
+	if (event & DTSEC_IMASK_CRLEN)
+		p_dtsec->f_exception(p_dtsec->h_app,
+				     FM_MAC_EX_1G_COL_RET_LMT);
+	if (event & DTSEC_IMASK_XFUNEN) {
+#ifdef FM_TX_LOCKUP_ERRATA_DTSEC6
+		if (p_dtsec->fm_mac_ctrl_drv.fm_rev_info.major_rev == 2) {
+			uint32_t tpkt1, tmp_reg1, tpkt2, tmp_reg2, i;
+			/* a. Write 0x00E0_0C00 to DTSEC_ID */
+			/* This is a read only regidter
+			 */
+
+			/* b. Read and save the value of TPKT */
+			tpkt1 = GET_UINT32(p_dtsec_mem_map->tpkt);
+
+			/* c. Read the register at dTSEC address offset 0x32C */
+			tmp_reg1 =
+			    GET_UINT32(*(uint32_t *)
+				       ((uint8_t *)p_dtsec_mem_map + 0x32c));
+
+			/* d. Compare bits [9:15] to bits [25:31] of the
+			 * register at address offset 0x32C.
+			 */
+			if ((tmp_reg1 & 0x007F0000) !=
+				(tmp_reg1 & 0x0000007F)) {
+				/* If they are not equal, save the value of
+				 * this register and wait for at least
+				 * MAXFRM*16 ns
+				 */
+				usleep_range((uint32_t)(min
+					(dtsec_get_max_frame_length(p_dtsec) *
+					16 / 1000, 1)), (uint32_t)
+					(min(dtsec_get_max_frame_length
+					(p_dtsec) * 16 / 1000, 1) + 1));
+			}
+
+			/* e. Read and save TPKT again and read the register
+			 * at dTSEC address offset 0x32C again
+			 */
+			tpkt2 = GET_UINT32(p_dtsec_mem_map->tpkt);
+			tmp_reg2 =
+			    GET_UINT32(*(uint32_t __iomem *)
+				       ((uint8_t *)p_dtsec_mem_map + 0x32c));
+
+			/* f. Compare the value of TPKT saved in step b to
+			 * value read in step e. Also compare bits [9:15] of
+			 * the register at offset 0x32C saved in step d to the
+			 * value of bits [9:15] saved in step e. If the two
+			 * registers values are unchanged, then the transmit
+			 * portion of the dTSEC controller is locked up and
+			 * the user should proceed to the recover sequence.
+			 */
+			if ((tpkt1 == tpkt2) && ((tmp_reg1 & 0x007F0000) ==
+				(tmp_reg2 & 0x007F0000))) {
+				/* recover sequence */
+
+				/* a.Write a 1 to RCTRL[GRS] */
+
+				WRITE_UINT32(p_dtsec_mem_map->rctrl,
+					     GET_UINT32(p_dtsec_mem_map->
+							rctrl) | RCTRL_GRS);
+
+				/* b.Wait until IEVENT[GRSC]=1, or at least
+				 * 100 us has elapsed.
+				 */
+				for (i = 0; i < 100; i++) {
+					if (GET_UINT32(p_dtsec_mem_map->
+						       ievent) &
+					    DTSEC_IMASK_GRSCEN)
+						break;
+					udelay(1);
+				}
+				if (GET_UINT32(p_dtsec_mem_map->ievent) &
+				    DTSEC_IMASK_GRSCEN)
+					WRITE_UINT32(p_dtsec_mem_map->ievent,
+						     DTSEC_IMASK_GRSCEN);
+				else
+					pr_debug("Rx lockup due to Tx lockup\n");
+
+				/* c.Write a 1 to bit n of FM_RSTC
+				 * (offset 0x0CC of FPM)
+				 */
+				fm_reset_mac(p_dtsec->fm_mac_ctrl_drv.h_fm,
+					     FM_MAC_1G,
+					     p_dtsec->fm_mac_ctrl_drv.mac_id);
+
+				/* d.Wait 4 Tx clocks (32 ns) */
+				udelay(1);
+
+				/* e.Write a 0 to bit n of FM_RSTC. */
+				/* cleared by FMAN
+				 */
+			}
+		}
+#endif /* FM_TX_LOCKUP_ERRATA_DTSEC6 */
+
+		p_dtsec->f_exception(p_dtsec->h_app,
+				     FM_MAC_EX_1G_TX_FIFO_UNDRN);
+	}
+	if (event & DTSEC_IMASK_MAGEN)
+		p_dtsec->f_exception(p_dtsec->h_app, FM_MAC_EX_1G_MAG_PCKT);
+	if (event & DTSEC_IMASK_GRSCEN)
+		p_dtsec->f_exception(p_dtsec->h_app,
+				     FM_MAC_EX_1G_GRATEFUL_RX_STP_COMPLET);
+	if (event & DTSEC_IMASK_TDPEEN)
+		p_dtsec->f_exception(p_dtsec->h_app,
+				     FM_MAC_EX_1G_DATA_ERR);
+	if (event & DTSEC_IMASK_RDPEEN)
+		p_dtsec->f_exception(p_dtsec->h_app,
+				     FM_MAC_1G_RX_DATA_ERR);
+
+	/*  - masked interrupts */
+	ASSERT(!(event & DTSEC_IMASK_ABRTEN));
+	ASSERT(!(event & DTSEC_IMASK_IFERREN));
+}
+
+static void dtsec_1588_isr(void *h_dtsec)
+{
+	struct dtsec_t *p_dtsec = (struct dtsec_t *)h_dtsec;
+	uint32_t event;
+	struct dtsec_regs __iomem *p_dtsec_mem_map = p_dtsec->p_mem_map;
+
+	if (p_dtsec->ptp_tsu_enabled) {
+		event = fman_dtsec_check_and_clear_tmr_event(p_dtsec_mem_map);
+
+		if (event) {
+			ASSERT(event & TMR_PEVENT_TSRE);
+			p_dtsec->f_exception(p_dtsec->h_app,
+					     FM_MAC_EX_1G_1588_TS_RX_ERR);
+		}
+	}
+}
+
+static void free_init_resources(struct dtsec_t *p_dtsec)
+{
+	fm_unregister_intr(p_dtsec->fm_mac_ctrl_drv.h_fm,
+			   FM_MOD_MAC, p_dtsec->mac_id, FM_INTR_TYPE_ERR);
+	fm_unregister_intr(p_dtsec->fm_mac_ctrl_drv.h_fm,
+			   FM_MOD_MAC, p_dtsec->mac_id,
+			   FM_INTR_TYPE_NORMAL);
+
+	/* release the driver's group hash table */
+	free_hash_table(p_dtsec->p_multicast_addr_hash);
+	p_dtsec->p_multicast_addr_hash = NULL;
+
+	/* release the driver's individual hash table */
+	free_hash_table(p_dtsec->p_unicast_addr_hash);
+	p_dtsec->p_unicast_addr_hash = NULL;
+}
+
+static int graceful_stop(struct dtsec_t *p_dtsec, enum comm_mode mode)
+{
+	struct dtsec_regs __iomem *p_mem_map;
+
+	p_mem_map = p_dtsec->p_mem_map;
+
+	/* Assert the graceful transmit stop bit */
+	if (mode & COMM_MODE_RX) {
+		fman_dtsec_stop_rx(p_mem_map);
+
+#ifdef FM_GRS_ERRATA_DTSEC_A002
+		if (p_dtsec->fm_mac_ctrl_drv.fm_rev_info.major_rev == 2)
+			usleep_range(100, 101);
+#else				/* FM_GRS_ERRATA_DTSEC_A002 */
+#ifdef FM_GTS_AFTER_DROPPED_FRAME_ERRATA_DTSEC_A004839
+		usleep_range(10, 11);
+#endif /* FM_GTS_AFTER_DROPPED_FRAME_ERRATA_DTSEC_A004839 */
+#endif /* FM_GRS_ERRATA_DTSEC_A002 */
+	}
+
+	if (mode & COMM_MODE_TX) {
+#if defined(FM_GTS_ERRATA_DTSEC_A004) || \
+defined(FM_GTS_AFTER_MAC_ABORTED_FRAME_ERRATA_DTSEC_A0012)
+		if (p_dtsec->fm_mac_ctrl_drv.fm_rev_info.major_rev == 2)
+			pr_debug("GTS not supported due to DTSEC_A004 errata.\n");
+#else				/* not defined(FM_GTS_ERRATA_DTSEC_A004) ||..*/
+#ifdef FM_GTS_UNDERRUN_ERRATA_DTSEC_A0014
+		if (p_dtsec->fm_mac_ctrl_drv.fm_rev_info.major_rev != 4)
+			pr_debug("GTS not supported due to DTSEC_A0014 errata.\n");
+#else				/* FM_GTS_UNDERRUN_ERRATA_DTSEC_A0014 */
+		fman_dtsec_stop_tx(p_mem_map);
+#endif /* FM_GTS_UNDERRUN_ERRATA_DTSEC_A0014 */
+#endif /* defined(FM_GTS_ERRATA_DTSEC_A004) ||...  */
+	}
+	return 0;
+}
+
+static int graceful_restart(struct dtsec_t *p_dtsec, enum comm_mode mode)
+{
+	struct dtsec_regs __iomem *p_mem_map;
+
+	p_mem_map = p_dtsec->p_mem_map;
+	/* clear the graceful receive stop bit */
+	if (mode & COMM_MODE_TX)
+		fman_dtsec_start_tx(p_mem_map);
+
+	if (mode & COMM_MODE_RX)
+		fman_dtsec_start_rx(p_mem_map);
+
+	return 0;
+}
+
+/* dTSEC Configs modification functions */
+
+static int dtsec_cfg_lb(void *h_dtsec, bool new_val)
+{
+	struct dtsec_t *p_dtsec = (struct dtsec_t *)h_dtsec;
+	int ret;
+
+	ret = is_init_done(p_dtsec->p_dtsec_drv_param);
+	if (!ret)
+		return -ENOSYS;
+
+	p_dtsec->p_dtsec_drv_param->loopback = new_val;
+
+	return 0;
+}
+
+static int dtsec_cfg_max_frame_len(void *h_dtsec, uint16_t new_val)
+{
+	struct dtsec_t *p_dtsec = (struct dtsec_t *)h_dtsec;
+	int ret;
+
+	ret = is_init_done(p_dtsec->p_dtsec_drv_param);
+	if (!ret)
+		return -ENOSYS;
+
+	p_dtsec->p_dtsec_drv_param->maximum_frame = new_val;
+
+	return 0;
+}
+
+static int dtsec_cfg_pad_and_crc(void *h_dtsec, bool new_val)
+{
+	struct dtsec_t *p_dtsec = (struct dtsec_t *)h_dtsec;
+	int ret;
+
+	ret = is_init_done(p_dtsec->p_dtsec_drv_param);
+	if (!ret)
+		return -ENOSYS;
+
+	p_dtsec->p_dtsec_drv_param->tx_pad_crc = new_val;
+
+	return 0;
+}
+
+static int dtsec_cfg_half_duplex(void *h_dtsec, bool new_val)
+{
+	struct dtsec_t *p_dtsec = (struct dtsec_t *)h_dtsec;
+	int ret;
+
+	ret = is_init_done(p_dtsec->p_dtsec_drv_param);
+	if (!ret)
+		return -ENOSYS;
+
+	p_dtsec->p_dtsec_drv_param->halfdup_on = new_val;
+
+	return 0;
+}
+
+static int dtsec_cfg_tbi_phy_addr(void *h_dtsec, uint8_t new_val)
+{
+	struct dtsec_t *p_dtsec = (struct dtsec_t *)h_dtsec;
+	int ret;
+
+	ret = is_init_done(p_dtsec->p_dtsec_drv_param);
+	if (!ret)
+		return -ENOSYS;
+
+	p_dtsec->p_dtsec_drv_param->tbi_phy_addr = new_val;
+
+	return 0;
+}
+
+static int dtsec_cfg_len_check(void *h_dtsec, bool new_val)
+{
+	struct dtsec_t *p_dtsec = (struct dtsec_t *)h_dtsec;
+	int ret;
+
+	ret = is_init_done(p_dtsec->p_dtsec_drv_param);
+	if (!ret)
+		return -ENOSYS;
+
+	p_dtsec->p_dtsec_drv_param->rx_len_check = new_val;
+
+	return 0;
+}
+
+static int dtsec_cfg_exception(void *h_dtsec, enum fm_mac_exceptions
+			       exception, bool enable)
+{
+	struct dtsec_t *p_dtsec = (struct dtsec_t *)h_dtsec;
+	uint32_t bit_mask = 0;
+	int ret;
+
+	ret = is_init_done(p_dtsec->p_dtsec_drv_param);
+	if (!ret)
+		return -ENOSYS;
+
+	if (exception != FM_MAC_EX_1G_1588_TS_RX_ERR) {
+		bit_mask = get_exception_flag(exception);
+		if (bit_mask) {
+			if (enable)
+				p_dtsec->exceptions |= bit_mask;
+			else
+				p_dtsec->exceptions &= ~bit_mask;
+		} else {
+			pr_err("Undefined exception\n");
+			return -EDOM;
+		}
+	} else {
+		if (!p_dtsec->ptp_tsu_enabled) {
+			pr_err("Exception valid for 1588 only\n");
+			return -EDOM;
+		}
+		switch (exception) {
+		case (FM_MAC_EX_1G_1588_TS_RX_ERR):
+			if (enable)
+				p_dtsec->en_tsu_err_exeption = true;
+			else
+				p_dtsec->en_tsu_err_exeption = false;
+			break;
+		default:
+			pr_err("Undefined exception\n");
+			return -EDOM;
+		}
+	}
+	return 0;
+}
+
+/* dTSEC Run Time API functions  */
+
+static int dtsec_enable(void *h_dtsec, enum comm_mode mode)
+{
+	struct dtsec_t *p_dtsec = (struct dtsec_t *)h_dtsec;
+	int ret;
+
+	ret = is_init_done(p_dtsec->p_dtsec_drv_param);
+	if (ret)
+		return ret;
+
+	fman_dtsec_enable(p_dtsec->p_mem_map,
+			  (bool)!!(mode & COMM_MODE_RX),
+			  (bool)!!(mode & COMM_MODE_TX));
+
+	graceful_restart(p_dtsec, mode);
+
+	return 0;
+}
+
+static int dtsec_disable(void *h_dtsec, enum comm_mode mode)
+{
+	struct dtsec_t *p_dtsec = (struct dtsec_t *)h_dtsec;
+	int ret;
+
+	ret = is_init_done(p_dtsec->p_dtsec_drv_param);
+	if (ret)
+		return ret;
+
+	graceful_stop(p_dtsec, mode);
+
+	fman_dtsec_disable(p_dtsec->p_mem_map,
+			   (bool)!!(mode & COMM_MODE_RX),
+			   (bool)!!(mode & COMM_MODE_TX));
+
+	return 0;
+}
+
+static int dtsec_set_tx_pause_frames(void *h_dtsec,
+				     uint8_t __maybe_unused priority,
+				     uint16_t pause_time,
+				     uint16_t __maybe_unused thresh_time)
+{
+	struct dtsec_t *p_dtsec = (struct dtsec_t *)h_dtsec;
+	int ret;
+
+	ret = is_init_done(p_dtsec->p_dtsec_drv_param);
+	if (ret)
+		return ret;
+
+#ifdef FM_BAD_TX_TS_IN_B_2_B_ERRATA_DTSEC_A003
+	if (p_dtsec->fm_mac_ctrl_drv.fm_rev_info.major_rev == 2)
+		if (0 < pause_time && pause_time <= 320) {
+			pr_warn("pause-time:%d illegal.Should be >320\n",
+				pause_time);
+			return -EDOM;
+		}
+#endif /* FM_BAD_TX_TS_IN_B_2_B_ERRATA_DTSEC_A003 */
+
+	fman_dtsec_set_tx_pause_frames(p_dtsec->p_mem_map, pause_time);
+	return 0;
+}
+
+/* backward compatibility. will be removed in the future. */
+static int dtsec_tx_mac_pause(void *h_dtsec, uint16_t pause_time)
+{
+	return dtsec_set_tx_pause_frames(h_dtsec, 0, pause_time, 0);
+}
+
+static int dtsec_rx_ignore_mac_pause(void *h_dtsec, bool en)
+{
+	struct dtsec_t *p_dtsec = (struct dtsec_t *)h_dtsec;
+	int ret;
+	bool accept_pause = !en;
+
+	ret = is_init_done(p_dtsec->p_dtsec_drv_param);
+	if (ret)
+		return ret;
+
+	fman_dtsec_handle_rx_pause(p_dtsec->p_mem_map, accept_pause);
+
+	return 0;
+}
+
+static int dtsec_enable_1588_ts(void *h_dtsec)
+{
+	struct dtsec_t *p_dtsec = (struct dtsec_t *)h_dtsec;
+	int ret;
+
+	ret = is_init_done(p_dtsec->p_dtsec_drv_param);
+	if (ret)
+		return ret;
+
+	p_dtsec->ptp_tsu_enabled = true;
+	fman_dtsec_set_ts(p_dtsec->p_mem_map, true);
+
+	return 0;
+}
+
+static int dtsec_disable_1588_ts(void *h_dtsec)
+{
+	struct dtsec_t *p_dtsec = (struct dtsec_t *)h_dtsec;
+	int ret;
+
+	ret = is_init_done(p_dtsec->p_dtsec_drv_param);
+	if (ret)
+		return ret;
+
+	p_dtsec->ptp_tsu_enabled = false;
+	fman_dtsec_set_ts(p_dtsec->p_mem_map, false);
+
+	return 0;
+}
+
+static int dtsec_get_statistics(void *h_dtsec,
+				struct fm_mac_statistics_t *p_statistics)
+{
+	struct dtsec_t *p_dtsec = (struct dtsec_t *)h_dtsec;
+	struct dtsec_regs __iomem *p_dtsec_mem_map;
+	int ret;
+
+	ret = is_init_done(p_dtsec->p_dtsec_drv_param);
+	if (ret)
+		return ret;
+
+	p_dtsec_mem_map = p_dtsec->p_mem_map;
+
+	if (p_dtsec->statistics_level == FM_MAC_NONE_STATISTICS) {
+		pr_warn("Statistics disabled\n");
+		return -ENOSYS;
+	}
+
+	memset(p_statistics, 0xff, sizeof(struct fm_mac_statistics_t));
+
+	if (p_dtsec->statistics_level == FM_MAC_FULL_STATISTICS) {
+		p_statistics->e_stat_pkts64 =
+		    fman_dtsec_get_stat_counter(p_dtsec_mem_map,
+						E_DTSEC_STAT_TR64)
+		    + p_dtsec->internal_statistics.tr64;
+		p_statistics->e_stat_pkts65to127 =
+		    fman_dtsec_get_stat_counter(p_dtsec_mem_map,
+						E_DTSEC_STAT_TR127)
+		    + p_dtsec->internal_statistics.tr127;
+		p_statistics->e_stat_pkts128to255 =
+		    fman_dtsec_get_stat_counter(p_dtsec_mem_map,
+						E_DTSEC_STAT_TR255)
+		    + p_dtsec->internal_statistics.tr255;
+		p_statistics->e_stat_pkts256to511 =
+		    fman_dtsec_get_stat_counter(p_dtsec_mem_map,
+						E_DTSEC_STAT_TR511)
+		    + p_dtsec->internal_statistics.tr511;
+		p_statistics->e_stat_pkts512to1023 =
+		    fman_dtsec_get_stat_counter(p_dtsec_mem_map,
+						E_DTSEC_STAT_TR1K)
+		    + p_dtsec->internal_statistics.tr1k;
+		p_statistics->e_stat_pkts1024to1518 =
+		    fman_dtsec_get_stat_counter(p_dtsec_mem_map,
+						E_DTSEC_STAT_TRMAX)
+		    + p_dtsec->internal_statistics.trmax;
+		p_statistics->e_stat_pkts1519to1522 =
+		    fman_dtsec_get_stat_counter(p_dtsec_mem_map,
+						E_DTSEC_STAT_TRMGV)
+		    + p_dtsec->internal_statistics.trmgv;
+
+		/* MIB II */
+		p_statistics->if_in_octets =
+		    fman_dtsec_get_stat_counter(p_dtsec_mem_map,
+						E_DTSEC_STAT_RBYT)
+		    + p_dtsec->internal_statistics.rbyt;
+		p_statistics->if_in_pkts =
+		    fman_dtsec_get_stat_counter(p_dtsec_mem_map,
+						E_DTSEC_STAT_RPKT)
+		    + p_dtsec->internal_statistics.rpkt;
+		p_statistics->if_in_ucast_pkts = 0;
+		p_statistics->if_in_mcast_pkts =
+		    fman_dtsec_get_stat_counter(p_dtsec_mem_map,
+						E_DTSEC_STAT_RMCA)
+		    + p_dtsec->internal_statistics.rmca;
+		p_statistics->if_in_bcast_pkts =
+		    fman_dtsec_get_stat_counter(p_dtsec_mem_map,
+						E_DTSEC_STAT_RBCA)
+		    + p_dtsec->internal_statistics.rbca;
+		p_statistics->if_out_octets =
+		    fman_dtsec_get_stat_counter(p_dtsec_mem_map,
+						E_DTSEC_STAT_TBYT)
+		    + p_dtsec->internal_statistics.tbyt;
+		p_statistics->if_out_pkts =
+		    fman_dtsec_get_stat_counter(p_dtsec_mem_map,
+						E_DTSEC_STAT_TPKT)
+		    + p_dtsec->internal_statistics.tpkt;
+		p_statistics->if_out_ucast_pkts = 0;
+		p_statistics->if_out_mcast_pkts =
+		    fman_dtsec_get_stat_counter(p_dtsec_mem_map,
+						E_DTSEC_STAT_TMCA)
+		    + p_dtsec->internal_statistics.tmca;
+		p_statistics->if_out_bcast_pkts =
+		    fman_dtsec_get_stat_counter(p_dtsec_mem_map,
+						E_DTSEC_STAT_TBCA)
+		    + p_dtsec->internal_statistics.tbca;
+	}
+
+	p_statistics->e_stat_fragments =
+	    fman_dtsec_get_stat_counter(p_dtsec_mem_map, E_DTSEC_STAT_RFRG)
+	    + p_dtsec->internal_statistics.rfrg;
+	p_statistics->e_stat_jabbers =
+	    fman_dtsec_get_stat_counter(p_dtsec_mem_map, E_DTSEC_STAT_RJBR)
+	    + p_dtsec->internal_statistics.rjbr;
+	p_statistics->e_stats_drop_events =
+	    fman_dtsec_get_stat_counter(p_dtsec_mem_map, E_DTSEC_STAT_RDRP)
+	    + p_dtsec->internal_statistics.rdrp;
+	p_statistics->e_stat_crc_align_errors =
+	    fman_dtsec_get_stat_counter(p_dtsec_mem_map, E_DTSEC_STAT_RALN)
+	    + p_dtsec->internal_statistics.raln;
+	p_statistics->e_stat_undersize_pkts =
+	    fman_dtsec_get_stat_counter(p_dtsec_mem_map, E_DTSEC_STAT_RUND)
+	    + p_dtsec->internal_statistics.rund;
+	p_statistics->e_stat_oversize_pkts =
+	    fman_dtsec_get_stat_counter(p_dtsec_mem_map, E_DTSEC_STAT_ROVR)
+	    + p_dtsec->internal_statistics.rovr;
+	p_statistics->re_stat_pause =
+	    fman_dtsec_get_stat_counter(p_dtsec_mem_map, E_DTSEC_STAT_RXPF)
+	    + p_dtsec->internal_statistics.rxpf;
+	p_statistics->te_stat_pause =
+	    fman_dtsec_get_stat_counter(p_dtsec_mem_map, E_DTSEC_STAT_TXPF)
+	    + p_dtsec->internal_statistics.txpf;
+	p_statistics->if_in_discards = p_statistics->e_stats_drop_events;
+	p_statistics->if_in_errors =
+	    p_statistics->e_stats_drop_events +
+	    p_statistics->e_stat_crc_align_errors +
+	    fman_dtsec_get_stat_counter(p_dtsec_mem_map,
+					E_DTSEC_STAT_RFLR) +
+	    p_dtsec->internal_statistics.rflr +
+	    fman_dtsec_get_stat_counter(p_dtsec_mem_map,
+					E_DTSEC_STAT_RCDE) +
+	    p_dtsec->internal_statistics.rcde +
+	    fman_dtsec_get_stat_counter(p_dtsec_mem_map,
+					E_DTSEC_STAT_RCSE) +
+	    p_dtsec->internal_statistics.rcse;
+
+	p_statistics->if_out_discards =
+	    fman_dtsec_get_stat_counter(p_dtsec_mem_map, E_DTSEC_STAT_TDRP)
+	    + p_dtsec->internal_statistics.tdrp;
+	/* Number of frames transmitted with error: */
+	p_statistics->if_out_errors = p_statistics->if_out_discards
+	    + fman_dtsec_get_stat_counter(p_dtsec_mem_map, E_DTSEC_STAT_TFCS)
+	    + p_dtsec->internal_statistics.tfcs;
+
+	return 0;
+}
+
+static int dtsec_modify_mac_address(void *h_dtsec, enet_addr_t
+					*p_enet_addr)
+{
+	struct dtsec_t *p_dtsec = (struct dtsec_t *)h_dtsec;
+	int ret;
+
+	ret = is_init_done(p_dtsec->p_dtsec_drv_param);
+	if (ret)
+		return ret;
+
+	/* Initialize MAC Station Address registers (1&2)    */
+	/* Station address have to be swapped (big endian to little endian */
+	p_dtsec->addr = ENET_ADDR_TO_UINT64(*p_enet_addr);
+	fman_dtsec_set_mac_address(p_dtsec->p_mem_map,
+				   (uint8_t *)(*p_enet_addr));
+
+	return 0;
+}
+
+static int dtsec_reset_counters(void *h_dtsec)
+{
+	struct dtsec_t *p_dtsec = (struct dtsec_t *)h_dtsec;
+	int ret;
+
+	ret = is_init_done(p_dtsec->p_dtsec_drv_param);
+	if (ret)
+		return ret;
+
+	/* clear HW counters */
+	fman_dtsec_reset_stat(p_dtsec->p_mem_map);
+
+	/* clear SW counters holding carries */
+	memset(&p_dtsec->internal_statistics, 0,
+	       sizeof(struct internal_statistics_t));
+
+	return 0;
+}
+
+static int dtsec_add_exact_match_mac_address(void *h_dtsec,
+					     enet_addr_t *p_eth_addr)
+{
+	struct dtsec_t *p_dtsec = (struct dtsec_t *)h_dtsec;
+	uint64_t eth_addr;
+	uint8_t paddr_num;
+	int ret;
+
+	ret = is_init_done(p_dtsec->p_dtsec_drv_param);
+	if (ret)
+		return ret;
+
+	eth_addr = ENET_ADDR_TO_UINT64(*p_eth_addr);
+
+	if (eth_addr & GROUP_ADDRESS) {
+		/* Multicast address has no effect in PADDR */
+		pr_err("Multicast address\n");
+		return -EDOM;
+	}
+	/* Make sure no PADDR contains this address */
+	for (paddr_num = 0; paddr_num < DTSEC_NUM_OF_PADDRS; paddr_num++)
+		if (p_dtsec->ind_addr_reg_used[paddr_num])
+			if (p_dtsec->paddr[paddr_num] == eth_addr)
+				return -EEXIST;
+
+	/* Find first unused PADDR */
+	for (paddr_num = 0; paddr_num < DTSEC_NUM_OF_PADDRS; paddr_num++)
+		if (!(p_dtsec->ind_addr_reg_used[paddr_num])) {
+			/* mark this PADDR as used */
+			p_dtsec->ind_addr_reg_used[paddr_num] = true;
+			/* store address */
+			p_dtsec->paddr[paddr_num] = eth_addr;
+
+			/* put in hardware */
+			fman_dtsec_add_addr_in_paddr(p_dtsec->p_mem_map,
+						     (uint64_t)
+						     PTR_TO_UINT(&eth_addr),
+						     paddr_num);
+			p_dtsec->num_of_ind_addr_in_regs++;
+
+			return 0;
+		}
+
+	/* No free PADDR */
+	return -EBUSY;
+}
+
+static int dtsec_del_exact_match_mac_address(void *h_dtsec,
+					     enet_addr_t *p_eth_addr)
+{
+	struct dtsec_t *p_dtsec = (struct dtsec_t *)h_dtsec;
+	uint64_t eth_addr;
+	uint8_t paddr_num;
+	int ret;
+
+	ret = is_init_done(p_dtsec->p_dtsec_drv_param);
+	if (ret)
+		return ret;
+
+	eth_addr = ENET_ADDR_TO_UINT64(*p_eth_addr);
+
+	/* Find used PADDR containing this address */
+	for (paddr_num = 0; paddr_num < DTSEC_NUM_OF_PADDRS; paddr_num++) {
+		if ((p_dtsec->ind_addr_reg_used[paddr_num]) &&
+		    (p_dtsec->paddr[paddr_num] == eth_addr)) {
+			/* mark this PADDR as not used */
+			p_dtsec->ind_addr_reg_used[paddr_num] = false;
+			/* clear in hardware */
+			fman_dtsec_clear_addr_in_paddr(p_dtsec->p_mem_map,
+						       paddr_num);
+			p_dtsec->num_of_ind_addr_in_regs--;
+
+			return 0;
+		}
+	}
+
+	return -ENOMEDIUM;
+}
+
+static int dtsec_add_hash_mac_address(void *h_dtsec,
+				      enet_addr_t *p_eth_addr)
+{
+	struct dtsec_t *p_dtsec = (struct dtsec_t *)h_dtsec;
+	struct eth_hash_entry_t *p_hash_entry;
+	uint64_t eth_addr;
+	int32_t bucket;
+	uint32_t crc;
+	bool mcast, ghtx;
+	int ret;
+
+	ret = is_init_done(p_dtsec->p_dtsec_drv_param);
+	if (ret)
+		return ret;
+
+	eth_addr = ENET_ADDR_TO_UINT64(*p_eth_addr);
+
+	ghtx = (bool)((fman_dtsec_get_rctrl(p_dtsec->p_mem_map) &
+			RCTRL_GHTX) ? true : false);
+	mcast = (bool)((eth_addr & MAC_GROUP_ADDRESS) ? true : false);
+
+	/* Cannot handle unicast mac addr when GHTX is on */
+	if (ghtx && !mcast) {
+		pr_err("Could not compute hash bucket\n");
+		return -ENOSYS;
+	}
+	crc = get_mac_addr_hash_code(eth_addr);
+
+	/* considering the 9 highest order bits in crc H[8:0]:
+	 *if ghtx = 0 H[8:6] (highest order 3 bits) identify the hash register
+	 *and H[5:1] (next 5 bits) identify the hash bit
+	 *if ghts = 1 H[8:5] (highest order 4 bits) identify the hash register
+	 *and H[4:0] (next 5 bits) identify the hash bit.
+	 *
+	 *In bucket index output the low 5 bits identify the hash register
+	 *bit, while the higher 4 bits identify the hash register
+	 */
+
+	if (ghtx) {
+		bucket = (int32_t)((crc >> 23) & 0x1ff);
+	} else {
+		bucket = (int32_t)((crc >> 24) & 0xff);
+		/* if !ghtx and mcast the bit must be set in gaddr instead of
+		 *igaddr.
+		 */
+		if (mcast)
+			bucket += 0x100;
+	}
+
+	fman_dtsec_set_bucket(p_dtsec->p_mem_map, bucket, true);
+
+	/* Create element to be added to the driver hash table */
+	p_hash_entry = kmalloc(sizeof(*p_hash_entry), GFP_KERNEL);
+	if (!p_hash_entry)
+		return -ENOMEM;
+	p_hash_entry->addr = eth_addr;
+	INIT_LIST_HEAD(&p_hash_entry->node);
+
+	if (eth_addr & MAC_GROUP_ADDRESS)
+		/* Group Address */
+		list_add_tail(&p_hash_entry->node,
+			      &(p_dtsec->p_multicast_addr_hash->p_lsts[bucket]
+			       ));
+	else
+		list_add_tail(&p_hash_entry->node,
+			      &p_dtsec->p_unicast_addr_hash->p_lsts[bucket]);
+
+	return 0;
+}
+
+static int dtsec_del_hash_mac_address(void *h_dtsec, enet_addr_t
+					  *p_eth_addr)
+{
+	struct dtsec_t *p_dtsec = (struct dtsec_t *)h_dtsec;
+	struct list_head *p_pos;
+	struct eth_hash_entry_t *p_hash_entry = NULL;
+	uint64_t eth_addr;
+	int32_t bucket;
+	uint32_t crc;
+	bool mcast, ghtx;
+	int ret;
+
+	ret = is_init_done(p_dtsec->p_dtsec_drv_param);
+	if (ret)
+		return ret;
+
+	eth_addr = ENET_ADDR_TO_UINT64(*p_eth_addr);
+
+	ghtx =
+	    (bool)((fman_dtsec_get_rctrl(p_dtsec->p_mem_map) & RCTRL_GHTX) ?
+		    true : false);
+	mcast = (bool)((eth_addr & MAC_GROUP_ADDRESS) ? true : false);
+
+	/* Cannot handle unicast mac addr when GHTX is on */
+	if (ghtx && !mcast) {
+		pr_err("Could not compute hash bucket\n");
+		return -ENOSYS;
+	}
+	crc = get_mac_addr_hash_code(eth_addr);
+
+	if (ghtx) {
+		bucket = (int32_t)((crc >> 23) & 0x1ff);
+	} else {
+		bucket = (int32_t)((crc >> 24) & 0xff);
+		/* if !ghtx and mcast the bit must be set
+		 * in gaddr instead of igaddr.
+		 */
+		if (mcast)
+			bucket += 0x100;
+	}
+
+	if (eth_addr & MAC_GROUP_ADDRESS) {
+		/* Group Address */
+		list_for_each(p_pos,
+			      &(p_dtsec->p_multicast_addr_hash->
+				p_lsts[bucket])) {
+			p_hash_entry = ETH_HASH_ENTRY_OBJ(p_pos);
+			if (p_hash_entry->addr == eth_addr) {
+				list_del_init(&p_hash_entry->node);
+				kfree(p_hash_entry);
+				break;
+			}
+		}
+		if (list_empty(&p_dtsec->p_multicast_addr_hash->p_lsts[bucket]))
+			fman_dtsec_set_bucket(p_dtsec->p_mem_map, bucket,
+					      false);
+	} else {
+		/* Individual Address */
+		list_for_each(p_pos,
+			      &p_dtsec->p_unicast_addr_hash->p_lsts[bucket]) {
+			p_hash_entry = ETH_HASH_ENTRY_OBJ(p_pos);
+			if (p_hash_entry->addr == eth_addr) {
+				list_del_init(&p_hash_entry->node);
+				kfree(p_hash_entry);
+				break;
+			}
+		}
+		if (list_empty(&p_dtsec->p_unicast_addr_hash->p_lsts[bucket]))
+			fman_dtsec_set_bucket(p_dtsec->p_mem_map, bucket,
+					      false);
+	}
+
+	/* address does not exist */
+	ASSERT(p_hash_entry);
+
+	return 0;
+}
+
+static int dtsec_set_promiscuous(void *h_dtsec, bool new_val)
+{
+	struct dtsec_t *p_dtsec = (struct dtsec_t *)h_dtsec;
+	int ret;
+
+	ret = is_init_done(p_dtsec->p_dtsec_drv_param);
+	if (ret)
+		return ret;
+
+	fman_dtsec_set_uc_promisc(p_dtsec->p_mem_map, new_val);
+	fman_dtsec_set_mc_promisc(p_dtsec->p_mem_map, new_val);
+
+	return 0;
+}
+
+static int dtsec_set_statistics(void *h_dtsec,
+				enum fm_mac_statistics_level
+				    statistics_level)
+{
+	struct dtsec_t *p_dtsec = (struct dtsec_t *)h_dtsec;
+	int err, ret;
+
+	ret = is_init_done(p_dtsec->p_dtsec_drv_param);
+	if (ret)
+		return ret;
+
+	p_dtsec->statistics_level = statistics_level;
+
+	err = (int)fman_dtsec_set_stat_level(p_dtsec->p_mem_map,
+						 (enum dtsec_stat_level)
+						 statistics_level);
+	if (err != 0)
+		return err;
+
+	switch (statistics_level) {
+	case (FM_MAC_NONE_STATISTICS):
+		p_dtsec->exceptions &= ~DTSEC_IMASK_MSROEN;
+		break;
+	case (FM_MAC_PARTIAL_STATISTICS):
+		p_dtsec->exceptions |= DTSEC_IMASK_MSROEN;
+		break;
+	case (FM_MAC_FULL_STATISTICS):
+		p_dtsec->exceptions |= DTSEC_IMASK_MSROEN;
+		break;
+	default:
+		return -EBADRQC;
+	}
+
+	return 0;
+}
+
+static int dtsec_set_wake_on_lan(void *h_dtsec, bool en)
+{
+	struct dtsec_t *p_dtsec = (struct dtsec_t *)h_dtsec;
+	int ret;
+
+	ret = is_init_done(p_dtsec->p_dtsec_drv_param);
+	if (ret)
+		return ret;
+
+	fman_dtsec_set_wol(p_dtsec->p_mem_map, en);
+
+	return 0;
+}
+
+static int dtsec_adjust_link(void *h_dtsec, enum ethernet_speed speed,
+			     bool full_duplex)
+{
+	struct dtsec_t *p_dtsec = (struct dtsec_t *)h_dtsec;
+	int err;
+	enum enet_interface enet_interface;
+	enum enet_speed enet_speed;
+	int ret;
+
+	ret = is_init_done(p_dtsec->p_dtsec_drv_param);
+	if (ret)
+		return ret;
+
+	p_dtsec->enet_mode =
+	    MAKE_ENET_MODE(ENET_INTERFACE_FROM_MODE(p_dtsec->enet_mode), speed);
+	enet_interface =
+	    (enum enet_interface)ENET_INTERFACE_FROM_MODE(p_dtsec->enet_mode);
+	enet_speed = (enum enet_speed)ENET_SPEED_FROM_MODE(p_dtsec->enet_mode);
+	p_dtsec->half_duplex = !full_duplex;
+
+	err =
+	    (int)fman_dtsec_adjust_link(p_dtsec->p_mem_map, enet_interface,
+					    enet_speed, full_duplex);
+
+	if (err == -EINVAL) {
+		pr_err("Ethernet doesn't support Half Duplex mode\n");
+		return -EINVAL;
+	}
+
+	return err;
+}
+
+static int dtsec_restart_autoneg(void *h_dtsec)
+{
+	struct dtsec_t *p_dtsec = (struct dtsec_t *)h_dtsec;
+	uint16_t tmp_reg16;
+	int ret;
+
+	ret = is_init_done(p_dtsec->p_dtsec_drv_param);
+	if (ret)
+		return ret;
+
+	dtsec_mii_read_phy_reg(p_dtsec, p_dtsec->tbi_phy_addr, 0, &tmp_reg16);
+
+	tmp_reg16 &= ~(PHY_CR_SPEED0 | PHY_CR_SPEED1);
+	tmp_reg16 |=
+	    (PHY_CR_ANE | PHY_CR_RESET_AN | PHY_CR_FULLDUPLEX | PHY_CR_SPEED1);
+
+	dtsec_mii_write_phy_reg(p_dtsec, p_dtsec->tbi_phy_addr, 0, tmp_reg16);
+
+	return 0;
+}
+
+static int dtsec_get_id(void *h_dtsec, uint32_t *mac_id)
+{
+	struct dtsec_t *p_dtsec = (struct dtsec_t *)h_dtsec;
+	int ret;
+
+	ret = is_init_done(p_dtsec->p_dtsec_drv_param);
+	if (ret)
+		return ret;
+
+	*mac_id = p_dtsec->mac_id;
+
+	return 0;
+}
+
+static int dtsec_get_version(void *h_dtsec, uint32_t *mac_version)
+{
+	struct dtsec_t *p_dtsec = (struct dtsec_t *)h_dtsec;
+	int ret;
+
+	ret = is_init_done(p_dtsec->p_dtsec_drv_param);
+	if (ret)
+		return ret;
+
+	*mac_version = fman_dtsec_get_revision(p_dtsec->p_mem_map);
+
+	return 0;
+}
+
+static int dtsec_set_exception(void *h_dtsec,
+			       enum fm_mac_exceptions exception,
+				   bool enable)
+{
+	struct dtsec_t *p_dtsec = (struct dtsec_t *)h_dtsec;
+	uint32_t bit_mask = 0;
+	int ret;
+
+	ret = is_init_done(p_dtsec->p_dtsec_drv_param);
+	if (ret)
+		return ret;
+
+	if (exception != FM_MAC_EX_1G_1588_TS_RX_ERR) {
+		bit_mask = get_exception_flag(exception);
+		if (bit_mask) {
+			if (enable)
+				p_dtsec->exceptions |= bit_mask;
+			else
+				p_dtsec->exceptions &= ~bit_mask;
+		} else {
+			pr_err("Undefined exception\n");
+			return -EDOM;
+		}
+		if (enable)
+			fman_dtsec_enable_interrupt(p_dtsec->p_mem_map,
+						    bit_mask);
+		else
+			fman_dtsec_disable_interrupt(p_dtsec->p_mem_map,
+						     bit_mask);
+	} else {
+		if (!p_dtsec->ptp_tsu_enabled) {
+			pr_err("Exception valid for 1588 only\n");
+			return -EDOM;
+		}
+		switch (exception) {
+		case (FM_MAC_EX_1G_1588_TS_RX_ERR):
+			if (enable) {
+				p_dtsec->en_tsu_err_exeption = true;
+				fman_dtsec_enable_tmr_interrupt(p_dtsec->
+								p_mem_map);
+			} else {
+				p_dtsec->en_tsu_err_exeption = false;
+				fman_dtsec_disable_tmr_interrupt(p_dtsec->
+								 p_mem_map);
+			}
+			break;
+		default:
+			pr_err("Undefined exception\n");
+			return -EDOM;
+		}
+	}
+
+	return 0;
+}
+
+/* dTSEC Init&Free API */
+
+static int dtsec_init(void *h_dtsec)
+{
+	struct dtsec_t *p_dtsec = (struct dtsec_t *)h_dtsec;
+	struct dtsec_cfg *p_dtsec_drv_param;
+	int err;
+	uint16_t max_frm_ln;
+	enum enet_interface enet_interface;
+	enum enet_speed enet_speed;
+	enet_addr_t eth_addr;
+	int ret, ret_err;
+
+	ret = is_init_done(p_dtsec->p_dtsec_drv_param);
+	if (!ret)
+		return ret;
+
+	fm_get_revision(p_dtsec->fm_mac_ctrl_drv.h_fm,
+			&p_dtsec->fm_mac_ctrl_drv.fm_rev_info);
+	ret_err = check_init_parameters(p_dtsec);
+	if (ret_err)
+		return -ret_err;
+
+	p_dtsec_drv_param = p_dtsec->p_dtsec_drv_param;
+	p_dtsec->half_duplex = p_dtsec_drv_param->halfdup_on;
+
+	enet_interface =
+	    (enum enet_interface)ENET_INTERFACE_FROM_MODE(p_dtsec->enet_mode);
+	enet_speed = (enum enet_speed)ENET_SPEED_FROM_MODE(p_dtsec->enet_mode);
+	MAKE_ENET_ADDR_FROM_UINT64(p_dtsec->addr, eth_addr);
+
+	err = (int)fman_dtsec_init(p_dtsec->p_mem_map,
+				       p_dtsec_drv_param,
+				       enet_interface,
+				       enet_speed,
+				       (uint8_t *)eth_addr,
+				       p_dtsec->fm_mac_ctrl_drv.
+				       fm_rev_info.major_rev,
+				       p_dtsec->fm_mac_ctrl_drv.
+				       fm_rev_info.minor_rev,
+				       p_dtsec->exceptions);
+	if (err) {
+		free_init_resources(p_dtsec);
+		pr_err("DTSEC version doesn't support this i/f mode\n");
+		return err;
+	}
+
+	if (ENET_INTERFACE_FROM_MODE(p_dtsec->enet_mode) == ENET_IF_SGMII) {
+		uint16_t tmp_reg16;
+
+		/* Configure the TBI PHY Control Register */
+		tmp_reg16 = PHY_TBICON_CLK_SEL | PHY_TBICON_SRESET;
+		dtsec_mii_write_phy_reg(p_dtsec,
+					(uint8_t)p_dtsec_drv_param->tbipa,
+					17, tmp_reg16);
+
+		tmp_reg16 = PHY_TBICON_CLK_SEL;
+		dtsec_mii_write_phy_reg(p_dtsec,
+					(uint8_t)p_dtsec_drv_param->tbipa,
+					17, tmp_reg16);
+
+		tmp_reg16 =
+		    (PHY_CR_PHY_RESET | PHY_CR_ANE | PHY_CR_FULLDUPLEX |
+		     PHY_CR_SPEED1);
+		dtsec_mii_write_phy_reg(p_dtsec,
+					(uint8_t)p_dtsec_drv_param->tbipa,
+					0, tmp_reg16);
+
+		if (p_dtsec->enet_mode & ENET_IF_SGMII_BASEX)
+			tmp_reg16 = PHY_TBIANA_1000X;
+		else
+			tmp_reg16 = PHY_TBIANA_SGMII;
+		dtsec_mii_write_phy_reg(p_dtsec,
+					(uint8_t)p_dtsec_drv_param->tbipa,
+					4, tmp_reg16);
+
+		tmp_reg16 =
+		    (PHY_CR_ANE | PHY_CR_RESET_AN | PHY_CR_FULLDUPLEX |
+		     PHY_CR_SPEED1);
+
+		dtsec_mii_write_phy_reg(p_dtsec,
+					(uint8_t)p_dtsec_drv_param->tbipa,
+					0, tmp_reg16);
+	}
+
+	/* Max Frame Length */
+	max_frm_ln = fman_dtsec_get_max_frame_len(p_dtsec->p_mem_map);
+	err = fm_set_mac_max_frame(p_dtsec->fm_mac_ctrl_drv.h_fm,
+				   FM_MAC_1G,
+				   p_dtsec->fm_mac_ctrl_drv.mac_id,
+				   max_frm_ln);
+	if (err) {
+		pr_err("Setting max frame length FAILED\n");
+		free_init_resources(p_dtsec);
+		return -EINVAL;
+	}
+
+	p_dtsec->p_multicast_addr_hash =
+	alloc_hash_table(EXTENDED_HASH_TABLE_SIZE);
+	if (!p_dtsec->p_multicast_addr_hash) {
+		free_init_resources(p_dtsec);
+		pr_err("MC hash table is FAILED\n");
+		return -ENOMEM;
+	}
+
+	p_dtsec->p_unicast_addr_hash = alloc_hash_table(HASH_TABLE_SIZE);
+	if (!p_dtsec->p_unicast_addr_hash) {
+		free_init_resources(p_dtsec);
+		pr_err("UC hash table is FAILED\n");
+		return -ENOMEM;
+	}
+
+	/* register err intr handler for dtsec to FPM (err) */
+	fm_register_intr(p_dtsec->fm_mac_ctrl_drv.h_fm,
+			 FM_MOD_MAC,
+			 p_dtsec->mac_id,
+			 FM_INTR_TYPE_ERR,
+			 dtsec_isr,
+			 p_dtsec);
+	/* register 1588 intr handler for TMR to FPM (normal) */
+	fm_register_intr(p_dtsec->fm_mac_ctrl_drv.h_fm,
+			 FM_MOD_MAC,
+			 p_dtsec->mac_id,
+			 FM_INTR_TYPE_NORMAL,
+			 dtsec_1588_isr,
+			 p_dtsec);
+
+	kfree(p_dtsec_drv_param);
+	p_dtsec->p_dtsec_drv_param = NULL;
+
+	err = dtsec_set_statistics(h_dtsec, FM_MAC_FULL_STATISTICS);
+	if (err) {
+		free_init_resources(p_dtsec);
+		pr_err("Undefined statistics level\n");
+		return err;
+	}
+
+	return 0;
+}
+
+static int dtsec_free(void *h_dtsec)
+{
+	struct dtsec_t *p_dtsec = (struct dtsec_t *)h_dtsec;
+
+	free_init_resources(p_dtsec);
+
+	kfree(p_dtsec->p_dtsec_drv_param);
+	p_dtsec->p_dtsec_drv_param = NULL;
+	kfree(h_dtsec);
+
+	return 0;
+}
+
+static void init_fm_mac_ctrl_drv(struct fm_mac_ctrl_drv_t *
+				      p_fm_mac_ctrl_drv)
+{
+	p_fm_mac_ctrl_drv->f_fm_mac_init = dtsec_init;
+	p_fm_mac_ctrl_drv->f_fm_mac_free = dtsec_free;
+
+	p_fm_mac_ctrl_drv->f_fm_mac_set_statistics = dtsec_set_statistics;
+	p_fm_mac_ctrl_drv->f_fm_mac_cfg_lb = dtsec_cfg_lb;
+	p_fm_mac_ctrl_drv->f_fm_mac_cfg_max_frame_len =
+	dtsec_cfg_max_frame_len;
+
+	/* Not supported on dTSEC */
+	p_fm_mac_ctrl_drv->f_fm_mac_cfg_wan = NULL;
+
+	p_fm_mac_ctrl_drv->f_fm_mac_cfg_pad_and_crc =
+	    dtsec_cfg_pad_and_crc;
+	p_fm_mac_ctrl_drv->f_fm_mac_cfg_half_duplex = dtsec_cfg_half_duplex;
+	p_fm_mac_ctrl_drv->f_fm_mac_cfg_len_check = dtsec_cfg_len_check;
+	p_fm_mac_ctrl_drv->f_fm_mac_cfg_tbi_phy_addr = dtsec_cfg_tbi_phy_addr;
+	p_fm_mac_ctrl_drv->f_fm_mac_cfg_exception = dtsec_cfg_exception;
+	p_fm_mac_ctrl_drv->f_fm_mac_cfg_reset_on_init = NULL;
+
+	p_fm_mac_ctrl_drv->f_fm_mac_enable = dtsec_enable;
+	p_fm_mac_ctrl_drv->f_fm_mac_disable = dtsec_disable;
+
+	p_fm_mac_ctrl_drv->f_fm_mac_set_exception = dtsec_set_exception;
+
+	p_fm_mac_ctrl_drv->f_fm_mac_set_promiscuous = dtsec_set_promiscuous;
+	p_fm_mac_ctrl_drv->f_fm_mac_adjust_link = dtsec_adjust_link;
+	p_fm_mac_ctrl_drv->f_fm_mac_set_wake_on_lan = dtsec_set_wake_on_lan;
+	p_fm_mac_ctrl_drv->f_fm_mac_restart_autoneg = dtsec_restart_autoneg;
+
+	p_fm_mac_ctrl_drv->f_fm_mac_enable_1588_ts = dtsec_enable_1588_ts;
+	p_fm_mac_ctrl_drv->f_fm_mac_disable_1588_ts = dtsec_disable_1588_ts;
+
+	p_fm_mac_ctrl_drv->f_fm_mac_set_tx_auto_pause_frames =
+	    dtsec_tx_mac_pause;
+	p_fm_mac_ctrl_drv->f_fm_mac_set_tx_pause_frames =
+	    dtsec_set_tx_pause_frames;
+	p_fm_mac_ctrl_drv->f_fm_mac_set_rx_ignore_pause_frames =
+	    dtsec_rx_ignore_mac_pause;
+
+	p_fm_mac_ctrl_drv->f_fm_mac_reset_counters = dtsec_reset_counters;
+	p_fm_mac_ctrl_drv->f_fm_mac_get_statistics = dtsec_get_statistics;
+
+	p_fm_mac_ctrl_drv->f_fm_mac_modify_mac_addr =
+	dtsec_modify_mac_address;
+	p_fm_mac_ctrl_drv->f_fm_mac_add_hash_mac_addr =
+	    dtsec_add_hash_mac_address;
+	p_fm_mac_ctrl_drv->f_fm_mac_remove_hash_mac_addr =
+	    dtsec_del_hash_mac_address;
+	p_fm_mac_ctrl_drv->f_fm_mac_add_exact_match_mac_addr =
+	    dtsec_add_exact_match_mac_address;
+	p_fm_mac_ctrl_drv->f_fm_mac_removel_exact_match_mac_addr =
+	    dtsec_del_exact_match_mac_address;
+	p_fm_mac_ctrl_drv->f_fm_mac_get_id = dtsec_get_id;
+	p_fm_mac_ctrl_drv->f_fm_mac_get_version = dtsec_get_version;
+	p_fm_mac_ctrl_drv->f_fm_mac_get_max_frame_length =
+	    dtsec_get_max_frame_length;
+}
+
+/* d_tsec config main entry */
+
+void *dtsec_config(struct fm_mac_params_t *p_fm_mac_param)
+{
+	struct dtsec_t *p_dtsec;
+	struct dtsec_cfg *p_dtsec_drv_param;
+	uintptr_t base_addr;
+
+	base_addr = p_fm_mac_param->base_addr;
+
+	/* allocate memory for the UCC GETH data structure. */
+	p_dtsec = kzalloc(sizeof(*p_dtsec), GFP_KERNEL);
+	if (!p_dtsec)
+		return ERR_PTR(-ENOMEM);
+	init_fm_mac_ctrl_drv(&p_dtsec->fm_mac_ctrl_drv);
+
+	/* allocate memory for the d_tsec driver parameters data structure. */
+	p_dtsec_drv_param = kzalloc(sizeof(*p_dtsec_drv_param),
+				    GFP_KERNEL);
+	if (!p_dtsec_drv_param) {
+		kfree(p_dtsec);
+		pr_err("dTSEC driver parameters");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	/* Plant parameter structure pointer */
+	p_dtsec->p_dtsec_drv_param = p_dtsec_drv_param;
+
+	fman_dtsec_defconfig(p_dtsec_drv_param);
+
+	p_dtsec->p_mem_map = (struct dtsec_regs __iomem *)
+			    UINT_TO_PTR(base_addr);
+	p_dtsec->p_mii_mem_map = (struct dtsec_mii_reg __iomem *)
+	    UINT_TO_PTR(base_addr + DTSEC_TO_MII_OFFSET);
+	p_dtsec->addr = ENET_ADDR_TO_UINT64(p_fm_mac_param->addr);
+	p_dtsec->enet_mode = p_fm_mac_param->enet_mode;
+	p_dtsec->mac_id = p_fm_mac_param->mac_id;
+	p_dtsec->exceptions = DEFAULT_exceptions;
+	p_dtsec->f_exception = p_fm_mac_param->f_exception;
+	p_dtsec->f_event = p_fm_mac_param->f_event;
+	p_dtsec->h_app = p_fm_mac_param->h_app;
+	p_dtsec->ptp_tsu_enabled = p_dtsec->p_dtsec_drv_param->ptp_tsu_en;
+	p_dtsec->en_tsu_err_exeption =
+	    p_dtsec->p_dtsec_drv_param->ptp_exception_en;
+	p_dtsec->tbi_phy_addr = p_dtsec->p_dtsec_drv_param->tbi_phy_addr;
+
+	return p_dtsec;
+}
diff --git a/drivers/soc/fsl/fman/mac/dtsec.h b/drivers/soc/fsl/fman/mac/dtsec.h
new file mode 100644
index 0000000..6723a47
--- /dev/null
+++ b/drivers/soc/fsl/fman/mac/dtsec.h
@@ -0,0 +1,187 @@
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
+/* FM dTSEC ... */
+#ifndef __DTSEC_H
+#define __DTSEC_
+
+#include "service.h"
+#include "enet_ext.h"
+
+#include "dtsec_mii_acc.h"
+#include "fm_mac.h"
+
+#define DEFAULT_exceptions			\
+((uint32_t)(DTSEC_IMASK_BREN		|	\
+		DTSEC_IMASK_RXCEN	|	\
+		DTSEC_IMASK_BTEN	|	\
+		DTSEC_IMASK_TXCEN	|	\
+		DTSEC_IMASK_TXEEN	|	\
+		DTSEC_IMASK_ABRTEN	|	\
+		DTSEC_IMASK_LCEN	|	\
+		DTSEC_IMASK_CRLEN	|	\
+		DTSEC_IMASK_XFUNEN	|	\
+		DTSEC_IMASK_IFERREN	|	\
+		DTSEC_IMASK_MAGEN	|	\
+		DTSEC_IMASK_TDPEEN	|	\
+		DTSEC_IMASK_RDPEEN))
+
+#define MAX_PACKET_ALIGNMENT        31
+#define MAX_INTER_PACKET_GAP        0x7f
+#define MAX_INTER_PALTERNATE_BEB    0x0f
+#define MAX_RETRANSMISSION          0x0f
+#define MAX_COLLISION_WINDOW        0x03ff
+
+/*number of pattern match registers (entries) */
+#define DTSEC_NUM_OF_PADDRS             15
+
+/* Group address bit indication */
+#define GROUP_ADDRESS                   0x0000010000000000LL
+
+/* Hash table size (32 bits*8 regs) */
+#define HASH_TABLE_SIZE                 256
+/* Extended Hash table size (32 bits*16 regs) */
+#define EXTENDED_HASH_TABLE_SIZE        512
+
+/* number of pattern match registers (entries) */
+#define DTSEC_TO_MII_OFFSET             0x1000
+/* maximum number of phys */
+#define MAX_PHYS                    32
+
+#define     VAL32BIT    0x100000000LL
+#define     VAL22BIT    0x00400000
+#define     VAL16BIT    0x00010000
+#define     VAL12BIT    0x00001000
+
+/* CAR1/2 bits */
+#define CAR1_TR64   0x80000000
+#define CAR1_TR127  0x40000000
+#define CAR1_TR255  0x20000000
+#define CAR1_TR511  0x10000000
+#define CAR1_TRK1   0x08000000
+#define CAR1_TRMAX  0x04000000
+#define CAR1_TRMGV  0x02000000
+
+#define CAR1_RBYT   0x00010000
+#define CAR1_RPKT   0x00008000
+#define CAR1_RMCA   0x00002000
+#define CAR1_RBCA   0x00001000
+#define CAR1_RXPF   0x00000400
+#define CAR1_RALN   0x00000100
+#define CAR1_RFLR   0x00000080
+#define CAR1_RCDE   0x00000040
+#define CAR1_RCSE   0x00000020
+#define CAR1_RUND   0x00000010
+#define CAR1_ROVR   0x00000008
+#define CAR1_RFRG   0x00000004
+#define CAR1_RJBR   0x00000002
+#define CAR1_RDRP   0x00000001
+
+#define CAR2_TFCS   0x00040000
+#define CAR2_TBYT   0x00002000
+#define CAR2_TPKT   0x00001000
+#define CAR2_TMCA   0x00000800
+#define CAR2_TBCA   0x00000400
+#define CAR2_TXPF   0x00000200
+#define CAR2_TDRP   0x00000001
+
+struct internal_statistics_t {
+	uint64_t tr64;
+	uint64_t tr127;
+	uint64_t tr255;
+	uint64_t tr511;
+	uint64_t tr1k;
+	uint64_t trmax;
+	uint64_t trmgv;
+	uint64_t rfrg;
+	uint64_t rjbr;
+	uint64_t rdrp;
+	uint64_t raln;
+	uint64_t rund;
+	uint64_t rovr;
+	uint64_t rxpf;
+	uint64_t txpf;
+	uint64_t rbyt;
+	uint64_t rpkt;
+	uint64_t rmca;
+	uint64_t rbca;
+	uint64_t rflr;
+	uint64_t rcde;
+	uint64_t rcse;
+	uint64_t tbyt;
+	uint64_t tpkt;
+	uint64_t tmca;
+	uint64_t tbca;
+	uint64_t tdrp;
+	uint64_t tfcs;
+};
+
+struct dtsec_t {
+	struct fm_mac_ctrl_drv_t fm_mac_ctrl_drv;
+	/* Handle to the upper layer application              */
+	void *h_app;
+	/* pointer to dTSEC memory mapped registers.          */
+	struct dtsec_regs __iomem *p_mem_map;
+	/* pointer to dTSEC MII memory mapped registers.          */
+	struct dtsec_mii_reg __iomem *p_mii_mem_map;
+	/* MAC address of device;                             */
+	uint64_t addr;
+	/* Ethernet physical interface  */
+	enum e_enet_mode enet_mode;
+	fm_mac_exception_cb *f_exception;
+	fm_mac_exception_cb *f_event;
+	/* Whether a particular individual address recognition
+	 * register is being used
+	 */
+	bool ind_addr_reg_used[DTSEC_NUM_OF_PADDRS];
+	/* MAC address for particular individual
+	 * address recognition register
+	 */
+	uint64_t paddr[DTSEC_NUM_OF_PADDRS];
+	/* Number of individual addresses in registers for this station. */
+	uint8_t num_of_ind_addr_in_regs;
+	bool half_duplex;
+	struct internal_statistics_t internal_statistics;
+	/* pointer to driver's global address hash table  */
+	struct eth_hash_t *p_multicast_addr_hash;
+	/* pointer to driver's individual address hash table  */
+	struct eth_hash_t *p_unicast_addr_hash;
+	uint8_t mac_id;
+	uint8_t tbi_phy_addr;
+	uint32_t exceptions;
+	bool ptp_tsu_enabled;
+	bool en_tsu_err_exeption;
+	enum fm_mac_statistics_level statistics_level;
+	struct dtsec_cfg *p_dtsec_drv_param;
+};
+
+#endif /* __DTSEC_H */
diff --git a/drivers/soc/fsl/fman/mac/dtsec_mii_acc.c b/drivers/soc/fsl/fman/mac/dtsec_mii_acc.c
new file mode 100644
index 0000000..0b2ef14
--- /dev/null
+++ b/drivers/soc/fsl/fman/mac/dtsec_mii_acc.c
@@ -0,0 +1,82 @@
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
+/* FM dtsec MII register access MAC ... */
+
+#include "service.h"
+#include "fm_mac.h"
+#include "dtsec.h"
+#include "fsl_fman_dtsec_mii_acc.h"
+
+int dtsec_mii_write_phy_reg(void *h_dtsec, uint8_t phy_addr, uint8_t reg,
+			    uint16_t data)
+{
+	struct dtsec_t *p_dtsec = (struct dtsec_t *)h_dtsec;
+	struct dtsec_mii_reg __iomem *miiregs;
+	uint16_t dtsec_freq;
+	int err;
+
+	dtsec_freq = (uint16_t)(p_dtsec->fm_mac_ctrl_drv.clk_freq >> 1);
+	miiregs = p_dtsec->p_mii_mem_map;
+
+	err =
+	    (int)fman_dtsec_mii_write_reg(miiregs, phy_addr, reg, data,
+					       dtsec_freq);
+
+	return err;
+}
+
+int dtsec_mii_read_phy_reg(void *h_dtsec, uint8_t phy_addr, uint8_t reg,
+			   uint16_t *p_data)
+{
+	struct dtsec_t *p_dtsec = (struct dtsec_t *)h_dtsec;
+	struct dtsec_mii_reg __iomem *miiregs;
+	uint16_t dtsec_freq;
+	int err;
+
+	dtsec_freq = (uint16_t)(p_dtsec->fm_mac_ctrl_drv.clk_freq >> 1);
+	miiregs = p_dtsec->p_mii_mem_map;
+
+	err =
+	    (int)fman_dtsec_mii_read_reg(miiregs, phy_addr, reg, p_data,
+					      dtsec_freq);
+
+	if (*p_data == 0xffff) {
+		pr_warn("Read wrong data(0xffff):phy_addr 0x%x,reg 0x%x",
+			phy_addr, reg);
+		return -ENXIO;
+	}
+	if (err)
+		return err;
+
+	return err;
+}
diff --git a/drivers/soc/fsl/fman/mac/dtsec_mii_acc.h b/drivers/soc/fsl/fman/mac/dtsec_mii_acc.h
new file mode 100644
index 0000000..e599642
--- /dev/null
+++ b/drivers/soc/fsl/fman/mac/dtsec_mii_acc.h
@@ -0,0 +1,43 @@
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
+#ifndef __DTSEC_MII_ACC_H
+#define __DTSEC_MII_ACC_H
+
+#include "service.h"
+
+int dtsec_mii_write_phy_reg(void *h_dtsec, uint8_t phy_addr, uint8_t reg,
+			    uint16_t data);
+int dtsec_mii_read_phy_reg(void *h_dtsec, uint8_t phy_addr, uint8_t reg,
+			   uint16_t *p_data);
+
+#endif /* __DTSEC_MII_ACC_H */
diff --git a/drivers/soc/fsl/fman/mac/fm_mac.c b/drivers/soc/fsl/fman/mac/fm_mac.c
new file mode 100644
index 0000000..1b043a2
--- /dev/null
+++ b/drivers/soc/fsl/fman/mac/fm_mac.c
@@ -0,0 +1,701 @@
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
+/* FM MAC ... */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include "service.h"
+#include "fm_ext.h"
+
+#include "fm_common.h"
+#include "fm_mac.h"
+
+#include <linux/string.h>
+
+struct fm_mac_dev *fm_mac_config(struct fm_mac_params_t *p_fm_mac_param)
+{
+	struct fm_mac_dev *fm_mac_dev;
+	struct fm_mac_ctrl_drv_t *p_fm_mac_ctrl_drv;
+	struct fm_revision_info_t fm_rev_info;
+
+	fm_get_revision(p_fm_mac_param->h_fm, &fm_rev_info);
+
+	if (fm_rev_info.major_rev >= 6) {
+		p_fm_mac_ctrl_drv = (struct fm_mac_ctrl_drv_t *)
+			memac_config(p_fm_mac_param);
+	} else {
+		if (ENET_SPEED_FROM_MODE(p_fm_mac_param->enet_mode) <
+			ENET_SPEED_10000)
+			p_fm_mac_ctrl_drv = (struct fm_mac_ctrl_drv_t *)
+				dtsec_config(p_fm_mac_param);
+		else if (ENET_SPEED_FROM_MODE(p_fm_mac_param->enet_mode) ==
+			ENET_SPEED_10000)
+			p_fm_mac_ctrl_drv = (struct fm_mac_ctrl_drv_t *)
+				tgec_config(p_fm_mac_param);
+		else
+			p_fm_mac_ctrl_drv = NULL;
+	}
+
+	if (!p_fm_mac_ctrl_drv)
+		return NULL;
+
+	p_fm_mac_ctrl_drv->h_fm = p_fm_mac_param->h_fm;
+	p_fm_mac_ctrl_drv->enet_mode = p_fm_mac_param->enet_mode;
+	p_fm_mac_ctrl_drv->mac_id = p_fm_mac_param->mac_id;
+	p_fm_mac_ctrl_drv->reset_on_init = DEFAULT_RESET_ON_INIT;
+	p_fm_mac_ctrl_drv->fm_rev_info.major_rev = fm_rev_info.major_rev;
+	p_fm_mac_ctrl_drv->fm_rev_info.minor_rev = fm_rev_info.minor_rev;
+	p_fm_mac_ctrl_drv->clk_freq =
+		fm_get_clock_freq(p_fm_mac_ctrl_drv->h_fm);
+
+	if (p_fm_mac_ctrl_drv->clk_freq  == 0) {
+		pr_err("Can't get clock for MAC!\n");
+		kfree(p_fm_mac_ctrl_drv);
+		return NULL;
+	}
+
+	fm_mac_dev = (void *)p_fm_mac_ctrl_drv;
+
+	return fm_mac_dev;
+}
+EXPORT_SYMBOL(fm_mac_config);
+
+int fm_mac_init(struct fm_mac_dev *fm_mac_dev)
+{
+	int err;
+	struct fm_mac_ctrl_drv_t *p_fm_mac_ctrl_drv = (void *)fm_mac_dev;
+
+	if (p_fm_mac_ctrl_drv->reset_on_init &&
+	    !p_fm_mac_ctrl_drv->f_fm_mac_cfg_reset_on_init &&
+	    (fm_reset_mac(p_fm_mac_ctrl_drv->h_fm,
+			((ENET_INTERFACE_FROM_MODE
+			  (p_fm_mac_ctrl_drv->enet_mode) ==
+			  ENET_IF_XGMII) ? FM_MAC_10G : FM_MAC_1G),
+			p_fm_mac_ctrl_drv->mac_id) != 0)) {
+		pr_err("Can't reset MAC!\n");
+		return -ENOSYS;
+	}
+	if (p_fm_mac_ctrl_drv->f_fm_mac_init)
+		err = p_fm_mac_ctrl_drv->f_fm_mac_init(fm_mac_dev);
+	else
+		err = -ENOSYS;
+
+	if (unlikely(err < 0))
+		pr_err("fm_mac_init() = 0x%08x\n", err);
+
+	return err;
+}
+EXPORT_SYMBOL(fm_mac_init);
+
+int fm_mac_free(struct fm_mac_dev *fm_mac_dev)
+{
+	int err;
+	struct fm_mac_ctrl_drv_t *p_fm_mac_ctrl_drv = (void *)fm_mac_dev;
+
+	if (p_fm_mac_ctrl_drv->f_fm_mac_free)
+		err = p_fm_mac_ctrl_drv->f_fm_mac_free(fm_mac_dev);
+	else
+		err = -ENOSYS;
+
+	if (unlikely(err < 0))
+		pr_err("fm_mac_free() = 0x%08x\n", err);
+
+	return err;
+}
+EXPORT_SYMBOL(fm_mac_free);
+
+int fm_mac_cfg_reset_on_init(struct fm_mac_dev *fm_mac_dev, bool enable)
+{
+	int err;
+	struct fm_mac_ctrl_drv_t *p_fm_mac_ctrl_drv = (void *)fm_mac_dev;
+
+	if (p_fm_mac_ctrl_drv->f_fm_mac_cfg_reset_on_init)
+		err = p_fm_mac_ctrl_drv->f_fm_mac_cfg_reset_on_init(fm_mac_dev,
+								    enable);
+	else
+		err = 0;
+
+	p_fm_mac_ctrl_drv->reset_on_init = enable;
+	if (unlikely(err < 0))
+		pr_err("fm_mac_reset_on_init() = 0x%08x\n", err);
+
+	return err;
+}
+EXPORT_SYMBOL(fm_mac_cfg_reset_on_init);
+
+int fm_mac_cfg_max_frame_len(struct fm_mac_dev *fm_mac_dev, uint16_t new_val)
+{
+	int err;
+	struct fm_mac_ctrl_drv_t *p_fm_mac_ctrl_drv = (void *)fm_mac_dev;
+
+	if (p_fm_mac_ctrl_drv->f_fm_mac_cfg_max_frame_len)
+		err = p_fm_mac_ctrl_drv->f_fm_mac_cfg_max_frame_len(fm_mac_dev,
+								    new_val);
+	else
+		err = -ENOSYS;
+
+	if (unlikely(err < 0))
+		pr_err("fm_mac_cfg_max_frame_len() = 0x%08x\n", err);
+
+	return err;
+}
+EXPORT_SYMBOL(fm_mac_cfg_max_frame_len);
+
+int fm_mac_cfg_wan(struct fm_mac_dev *fm_mac_dev, bool enable)
+{
+	int err;
+	struct fm_mac_ctrl_drv_t *p_fm_mac_ctrl_drv = (void *)fm_mac_dev;
+
+	if (p_fm_mac_ctrl_drv->f_fm_mac_cfg_wan)
+		err = p_fm_mac_ctrl_drv->f_fm_mac_cfg_wan(fm_mac_dev, enable);
+	else
+		err = -ENOSYS;
+
+	if (unlikely(err < 0))
+		pr_err("fm_mac_cfg_wan() = 0x%08x\n", err);
+
+	return err;
+}
+EXPORT_SYMBOL(fm_mac_cfg_wan);
+
+int fm_mac_cfg_pad_and_crc(struct fm_mac_dev *fm_mac_dev, bool new_val)
+{
+	int err;
+	struct fm_mac_ctrl_drv_t *p_fm_mac_ctrl_drv = (void *)fm_mac_dev;
+
+	if (p_fm_mac_ctrl_drv->f_fm_mac_cfg_pad_and_crc)
+		err = p_fm_mac_ctrl_drv->f_fm_mac_cfg_pad_and_crc(fm_mac_dev,
+								  new_val);
+	else
+		err = -ENOSYS;
+
+	if (unlikely(err < 0))
+		pr_err("fm_mac_init() = 0x%08x\n", err);
+
+	return err;
+}
+EXPORT_SYMBOL(fm_mac_cfg_pad_and_crc);
+
+int fm_mac_cfg_half_duplex(struct fm_mac_dev *fm_mac_dev, bool new_val)
+{
+	int err;
+	struct fm_mac_ctrl_drv_t *p_fm_mac_ctrl_drv = (void *)fm_mac_dev;
+
+	if (p_fm_mac_ctrl_drv->f_fm_mac_cfg_half_duplex)
+		err = p_fm_mac_ctrl_drv->f_fm_mac_cfg_half_duplex(fm_mac_dev,
+								  new_val);
+	else
+		err = -ENOSYS;
+
+	if (unlikely(err < 0))
+		pr_err("fm_mac_cfg_half_duplex() = 0x%08x\n", err);
+
+	return err;
+}
+EXPORT_SYMBOL(fm_mac_cfg_half_duplex);
+
+int fm_mac_cfg_tbi_phy_addr(struct fm_mac_dev *fm_mac_dev, uint8_t new_val)
+{
+	int err;
+	struct fm_mac_ctrl_drv_t *p_fm_mac_ctrl_drv = (void *)fm_mac_dev;
+
+	if (p_fm_mac_ctrl_drv->f_fm_mac_cfg_tbi_phy_addr)
+		err = p_fm_mac_ctrl_drv->f_fm_mac_cfg_tbi_phy_addr(fm_mac_dev,
+								    new_val);
+	else
+		err = -ENOSYS;
+
+	if (unlikely(err < 0))
+		pr_err("fm_mac_cfg_tbi_phy_addr() = 0x%08x\n", err);
+
+	return err;
+}
+EXPORT_SYMBOL(fm_mac_cfg_tbi_phy_addr);
+
+int fm_mac_cfg_len_check(struct fm_mac_dev *fm_mac_dev, bool new_val)
+{
+	int err;
+	struct fm_mac_ctrl_drv_t *p_fm_mac_ctrl_drv = (void *)fm_mac_dev;
+
+	if (p_fm_mac_ctrl_drv->f_fm_mac_cfg_len_check)
+		err = p_fm_mac_ctrl_drv->f_fm_mac_cfg_len_check(fm_mac_dev,
+								new_val);
+	else
+		err = -ENOSYS;
+
+	if (unlikely(err < 0))
+		pr_err("fm_mac_cfg_len_check() = 0x%08x\n", err);
+
+	return err;
+}
+EXPORT_SYMBOL(fm_mac_cfg_len_check);
+
+int fm_mac_cfg_exception(struct fm_mac_dev *fm_mac_dev,
+			 enum fm_mac_exceptions ex,
+			 bool enable)
+{
+	int err;
+	struct fm_mac_ctrl_drv_t *p_fm_mac_ctrl_drv = (void *)fm_mac_dev;
+
+	if (p_fm_mac_ctrl_drv->f_fm_mac_cfg_exception)
+		err = p_fm_mac_ctrl_drv->f_fm_mac_cfg_exception(fm_mac_dev,
+								ex,
+								enable);
+	else
+		err = -ENOSYS;
+
+	if (unlikely(err < 0))
+		pr_err("fm_mac_cfg_exception() = 0x%08x\n", err);
+
+	return err;
+}
+EXPORT_SYMBOL(fm_mac_cfg_exception);
+
+#ifdef FM_TX_ECC_FRMS_ERRATA_10GMAC_A004
+int fm_mac_cfg_skip_fman11_wa(struct fm_mac_dev *fm_mac_dev)
+{
+	int err;
+	struct fm_mac_ctrl_drv_t *p_fm_mac_ctrl_drv = (void *)fm_mac_dev;
+
+	if (p_fm_mac_ctrl_drv->f_fm_mac_cfg_skip_fman11_wa)
+		err = p_fm_mac_ctrl_drv->
+			f_fm_mac_cfg_skip_fman11_wa(fm_mac_dev);
+	else
+		err = -ENOSYS;
+
+	if (unlikely(err < 0))
+		pr_err("fm_mac_cfg_skip_fman11_wa() = 0x%08x\n",
+		       err);
+
+	return err;
+}
+EXPORT_SYMBOL(fm_mac_cfg_skip_fman11_wa);
+
+#endif /* FM_TX_ECC_FRMS_ERRATA_10GMAC_A004 */
+
+/* Run Time Control                                                          */
+
+int fm_mac_enable(struct fm_mac_dev *fm_mac_dev, enum comm_mode mode)
+{
+	int err;
+	struct fm_mac_ctrl_drv_t *p_fm_mac_ctrl_drv = (void *)fm_mac_dev;
+
+	if (p_fm_mac_ctrl_drv->f_fm_mac_enable)
+		err = p_fm_mac_ctrl_drv->f_fm_mac_enable(fm_mac_dev, mode);
+	else
+		err = -ENOSYS;
+
+	if (unlikely(err < 0))
+		pr_err("fm_mac_enable() = 0x%08x\n", err);
+
+	return err;
+}
+EXPORT_SYMBOL(fm_mac_enable);
+
+int fm_mac_disable(struct fm_mac_dev *fm_mac_dev, enum comm_mode mode)
+{
+	int err;
+	struct fm_mac_ctrl_drv_t *p_fm_mac_ctrl_drv = (void *)fm_mac_dev;
+
+	if (p_fm_mac_ctrl_drv->f_fm_mac_disable)
+		err = p_fm_mac_ctrl_drv->f_fm_mac_disable(fm_mac_dev, mode);
+	else
+		err = -ENOSYS;
+
+	if (unlikely(err < 0))
+		pr_err("fm_mac_disable() = 0x%08x\n", err);
+
+	return err;
+}
+EXPORT_SYMBOL(fm_mac_disable);
+
+int fm_mac_enable_1588_time_stamp(struct fm_mac_dev *fm_mac_dev)
+{
+	int err;
+	struct fm_mac_ctrl_drv_t *p_fm_mac_ctrl_drv = (void *)fm_mac_dev;
+
+	if (p_fm_mac_ctrl_drv->f_fm_mac_enable_1588_ts)
+		err = p_fm_mac_ctrl_drv->f_fm_mac_enable_1588_ts(fm_mac_dev);
+	else
+		err = -ENOSYS;
+
+	if (unlikely(err < 0))
+		pr_err("fm_mac_enable_1588_time_stamp() = 0x%08x\n", err);
+
+	return err;
+}
+EXPORT_SYMBOL(fm_mac_enable_1588_time_stamp);
+
+int fm_mac_disable_1588_time_stamp(struct fm_mac_dev *fm_mac_dev)
+{
+	int err;
+	struct fm_mac_ctrl_drv_t *p_fm_mac_ctrl_drv = (void *)fm_mac_dev;
+
+	if (p_fm_mac_ctrl_drv->f_fm_mac_disable_1588_ts)
+		err = p_fm_mac_ctrl_drv->f_fm_mac_disable_1588_ts(fm_mac_dev);
+	else
+		err = -ENOSYS;
+
+	if (unlikely(err < 0))
+		pr_err("fm_mac_disable_1588_time_stamp() = 0x%08x\n", err);
+
+	return err;
+}
+EXPORT_SYMBOL(fm_mac_disable_1588_time_stamp);
+
+int fm_mac_set_tx_pause_frames(struct fm_mac_dev *fm_mac_dev,
+			       uint8_t priority,
+			       uint16_t pause_time,
+			       uint16_t thresh_time)
+{
+	struct fm_mac_ctrl_drv_t *p_fm_mac_ctrl_drv = (void *)fm_mac_dev;
+
+#ifdef CONFIG_FMAN_PFC
+	if (p_fm_mac_ctrl_drv->f_fm_mac_set_tx_pause_frames)
+		return p_fm_mac_ctrl_drv->
+			f_fm_mac_set_tx_pause_frames(fm_mac_dev,
+						     priority,
+						     pause_time,
+						     thresh_time);
+#else
+	if (p_fm_mac_ctrl_drv->f_fm_mac_set_tx_auto_pause_frames)
+		return p_fm_mac_ctrl_drv->
+		    f_fm_mac_set_tx_auto_pause_frames(fm_mac_dev, pause_time);
+#endif
+	return -ENOSYS;
+}
+EXPORT_SYMBOL(fm_mac_set_tx_pause_frames);
+
+int fm_mac_set_rx_pause_frames(struct fm_mac_dev *fm_mac_dev, bool en)
+{
+	int err;
+	struct fm_mac_ctrl_drv_t *p_fm_mac_ctrl_drv = (void *)fm_mac_dev;
+
+	if (p_fm_mac_ctrl_drv->f_fm_mac_set_rx_ignore_pause_frames)
+		err = p_fm_mac_ctrl_drv->
+			f_fm_mac_set_rx_ignore_pause_frames(fm_mac_dev, !en);
+	else
+		err = -ENOSYS;
+
+	if (unlikely(err < 0))
+		pr_err("fm_mac_set_rx_ignore_pause_frames() = 0x%08x\n", err);
+
+	return err;
+}
+EXPORT_SYMBOL(fm_mac_set_rx_pause_frames);
+
+int fm_mac_set_wake_on_lan(struct fm_mac_dev *fm_mac_dev, bool en)
+{
+	int err;
+	struct fm_mac_ctrl_drv_t *p_fm_mac_ctrl_drv = (void *)fm_mac_dev;
+
+	if (p_fm_mac_ctrl_drv->f_fm_mac_set_wake_on_lan)
+		err = p_fm_mac_ctrl_drv->f_fm_mac_set_wake_on_lan(fm_mac_dev,
+								  en);
+	else
+		err = -ENOSYS;
+
+	if (unlikely(err < 0))
+		pr_err("fm_mac_set_wake_on_lan() = 0x%08x\n", err);
+
+	return err;
+}
+EXPORT_SYMBOL(fm_mac_set_wake_on_lan);
+
+int fm_mac_reset_counters(struct fm_mac_dev *fm_mac_dev)
+{
+	int err;
+	struct fm_mac_ctrl_drv_t *p_fm_mac_ctrl_drv = (void *)fm_mac_dev;
+
+	if (p_fm_mac_ctrl_drv->f_fm_mac_reset_counters)
+		err = p_fm_mac_ctrl_drv->f_fm_mac_reset_counters(fm_mac_dev);
+	else
+		err = -ENOSYS;
+
+	if (unlikely(err < 0))
+		pr_err("fm_mac_reset_counters() = 0x%08x\n", err);
+
+	return err;
+}
+EXPORT_SYMBOL(fm_mac_reset_counters);
+
+int fm_mac_set_exception(struct fm_mac_dev *fm_mac_dev,
+			 enum fm_mac_exceptions ex,
+			 bool enable)
+{
+	int err;
+	struct fm_mac_ctrl_drv_t *p_fm_mac_ctrl_drv = (void *)fm_mac_dev;
+
+	if (p_fm_mac_ctrl_drv->f_fm_mac_set_exception)
+		err = p_fm_mac_ctrl_drv->f_fm_mac_set_exception(fm_mac_dev,
+								ex,
+								enable);
+	else
+		err = -ENOSYS;
+
+	if (unlikely(err < 0))
+		pr_err("fm_mac_set_exception() = 0x%08x\n", err);
+
+	return err;
+}
+EXPORT_SYMBOL(fm_mac_set_exception);
+
+int fm_mac_set_statistics(struct fm_mac_dev *fm_mac_dev,
+			  enum fm_mac_statistics_level statistics_level)
+{
+	int err;
+	struct fm_mac_ctrl_drv_t *p_fm_mac_ctrl_drv = (void *)fm_mac_dev;
+
+	if (p_fm_mac_ctrl_drv->f_fm_mac_set_statistics)
+		err = p_fm_mac_ctrl_drv->
+			f_fm_mac_set_statistics(fm_mac_dev, statistics_level);
+	else
+		err = -ENOSYS;
+
+	if (unlikely(err < 0))
+		pr_err("fm_mac_set_statistics() = 0x%08x\n", err);
+
+	return err;
+}
+EXPORT_SYMBOL(fm_mac_set_statistics);
+
+int fm_mac_get_statistics(struct fm_mac_dev *fm_mac_dev,
+			  struct fm_mac_statistics_t *p_statistics)
+{
+	int err;
+	struct fm_mac_ctrl_drv_t *p_fm_mac_ctrl_drv = (void *)fm_mac_dev;
+
+	if (p_fm_mac_ctrl_drv->f_fm_mac_get_statistics)
+		err = p_fm_mac_ctrl_drv->f_fm_mac_get_statistics(fm_mac_dev,
+								 p_statistics);
+	else
+		err = -ENOSYS;
+
+	if (unlikely(err < 0))
+		pr_err("fm_mac_get_statistics() = 0x%08x\n", err);
+
+	return err;
+}
+EXPORT_SYMBOL(fm_mac_get_statistics);
+
+int fm_mac_modify_mac_addr(struct fm_mac_dev *fm_mac_dev,
+			   enet_addr_t *p_enet_addr)
+{
+	struct fm_mac_ctrl_drv_t *p_fm_mac_ctrl_drv = (void *)fm_mac_dev;
+
+	if (p_fm_mac_ctrl_drv->f_fm_mac_modify_mac_addr)
+		return p_fm_mac_ctrl_drv->f_fm_mac_modify_mac_addr(fm_mac_dev,
+								   p_enet_addr);
+
+	return -ENOSYS;
+}
+EXPORT_SYMBOL(fm_mac_modify_mac_addr);
+
+int fm_mac_add_hash_mac_addr(struct fm_mac_dev *fm_mac_dev,
+			     enet_addr_t *p_enet_addr)
+{
+	int err;
+	struct fm_mac_ctrl_drv_t *p_fm_mac_ctrl_drv = (void *)fm_mac_dev;
+
+	if (p_fm_mac_ctrl_drv->f_fm_mac_add_hash_mac_addr)
+		err = p_fm_mac_ctrl_drv->
+			f_fm_mac_add_hash_mac_addr(fm_mac_dev, p_enet_addr);
+	else
+		err = -ENOSYS;
+
+	if (unlikely(err < 0))
+		pr_err("fm_mac_add_hash_mac_addr() = 0x%08x\n", err);
+
+	return err;
+}
+EXPORT_SYMBOL(fm_mac_add_hash_mac_addr);
+
+int fm_mac_remove_hash_mac_addr(struct fm_mac_dev *fm_mac_dev,
+				enet_addr_t *p_enet_addr)
+{
+	int err;
+	struct fm_mac_ctrl_drv_t *p_fm_mac_ctrl_drv = (void *)fm_mac_dev;
+
+	if (p_fm_mac_ctrl_drv->f_fm_mac_remove_hash_mac_addr)
+		err = p_fm_mac_ctrl_drv->
+			f_fm_mac_remove_hash_mac_addr(fm_mac_dev, p_enet_addr);
+	else
+		err = -ENOSYS;
+
+	if (unlikely(err < 0))
+		pr_err("fm_mac_remove_hash_mac_addr() = 0x%08x\n", err);
+
+	return err;
+}
+EXPORT_SYMBOL(fm_mac_remove_hash_mac_addr);
+
+int fm_mac_add_exact_match_mac_addr(struct fm_mac_dev *fm_mac_dev,
+				    enet_addr_t *p_enet_addr)
+{
+	int err;
+	struct fm_mac_ctrl_drv_t *p_fm_mac_ctrl_drv = (void *)fm_mac_dev;
+
+	if (p_fm_mac_ctrl_drv->f_fm_mac_add_exact_match_mac_addr)
+		err = p_fm_mac_ctrl_drv->
+			f_fm_mac_add_exact_match_mac_addr(fm_mac_dev,
+							  p_enet_addr);
+	else
+		err = -ENOSYS;
+
+	if (unlikely(err < 0))
+		pr_err("fm_mac_add_exact_match_mac_addr() = 0x%08x\n", err);
+
+	return err;
+}
+EXPORT_SYMBOL(fm_mac_add_exact_match_mac_addr);
+
+int fm_mac_removel_exact_match_mac_addr(struct fm_mac_dev *fm_mac_dev,
+					enet_addr_t *p_enet_addr)
+{
+	int err;
+	struct fm_mac_ctrl_drv_t *p_fm_mac_ctrl_drv = (void *)fm_mac_dev;
+
+	if (p_fm_mac_ctrl_drv->f_fm_mac_removel_exact_match_mac_addr)
+		err = p_fm_mac_ctrl_drv->
+			f_fm_mac_removel_exact_match_mac_addr(fm_mac_dev,
+							      p_enet_addr);
+	else
+		err = -ENOSYS;
+
+	if (unlikely(err < 0))
+		pr_err("fm_mac_removel_exact_match_mac_addr() = 0x%08x\n", err);
+
+	return err;
+}
+EXPORT_SYMBOL(fm_mac_removel_exact_match_mac_addr);
+
+int fm_mac_get_version(struct fm_mac_dev *fm_mac_dev, uint32_t *mac_version)
+{
+	int err;
+	struct fm_mac_ctrl_drv_t *p_fm_mac_ctrl_drv = (void *)fm_mac_dev;
+
+	if (p_fm_mac_ctrl_drv->f_fm_mac_get_version)
+		err = p_fm_mac_ctrl_drv->f_fm_mac_get_version(fm_mac_dev,
+							      mac_version);
+	else
+		err = -ENOSYS;
+
+	if (unlikely(err < 0))
+		pr_err("fm_mac_get_version() = 0x%08x\n", err);
+
+	return err;
+}
+EXPORT_SYMBOL(fm_mac_get_version);
+
+int fm_mac_get_id(struct fm_mac_dev *fm_mac_dev, uint32_t *mac_id)
+{
+	int err;
+	struct fm_mac_ctrl_drv_t *p_fm_mac_ctrl_drv = (void *)fm_mac_dev;
+
+	if (p_fm_mac_ctrl_drv->f_fm_mac_get_id)
+		err = p_fm_mac_ctrl_drv->f_fm_mac_get_id(fm_mac_dev, mac_id);
+	else
+		err = -ENOSYS;
+	if (unlikely(err < 0))
+		pr_err("fm_mac_get_id() = 0x%08x\n", err);
+
+	return err;
+}
+EXPORT_SYMBOL(fm_mac_get_id);
+
+int fm_mac_set_promiscuous(struct fm_mac_dev *fm_mac_dev, bool new_val)
+{
+	int err;
+	struct fm_mac_ctrl_drv_t *p_fm_mac_ctrl_drv = (void *)fm_mac_dev;
+
+	if (p_fm_mac_ctrl_drv->f_fm_mac_set_promiscuous)
+		err =  p_fm_mac_ctrl_drv->
+			f_fm_mac_set_promiscuous(fm_mac_dev, new_val);
+	else
+		err = -ENOSYS;
+
+	if (unlikely(err < 0))
+		pr_err("fm_mac_get_id() = 0x%08x\n", err);
+
+	return err;
+}
+EXPORT_SYMBOL(fm_mac_set_promiscuous);
+
+int fm_mac_adjust_link(struct fm_mac_dev *fm_mac_dev, int link,
+		       enum ethernet_speed speed, bool full_duplex)
+{
+	struct fm_mac_ctrl_drv_t *p_fm_mac_ctrl_drv = (void *)fm_mac_dev;
+
+	if (!link) {
+		if (p_fm_mac_ctrl_drv->fm_rev_info.major_rev < 6)
+			fm_mac_restart_autoneg(fm_mac_dev);
+
+		return 0;
+	}
+
+	if (p_fm_mac_ctrl_drv->f_fm_mac_adjust_link)
+		return p_fm_mac_ctrl_drv->f_fm_mac_adjust_link(fm_mac_dev,
+							       speed,
+							       full_duplex);
+
+	return -ENOSYS;
+}
+EXPORT_SYMBOL(fm_mac_adjust_link);
+
+int fm_mac_restart_autoneg(struct fm_mac_dev *fm_mac_dev)
+{
+	struct fm_mac_ctrl_drv_t *p_fm_mac_ctrl_drv = (void *)fm_mac_dev;
+
+	if (p_fm_mac_ctrl_drv->f_fm_mac_restart_autoneg)
+		return p_fm_mac_ctrl_drv->f_fm_mac_restart_autoneg(fm_mac_dev);
+
+	return -ENOSYS;
+}
+
+uint16_t fm_mac_get_max_frame_length(struct fm_mac_dev *fm_mac_dev)
+{
+	int err;
+	struct fm_mac_ctrl_drv_t *p_fm_mac_ctrl_drv = (void *)fm_mac_dev;
+
+	if (p_fm_mac_ctrl_drv->f_fm_mac_get_max_frame_length)
+		err = p_fm_mac_ctrl_drv->
+		f_fm_mac_get_max_frame_length(fm_mac_dev);
+	else
+		err = -ENOSYS;
+
+	if (unlikely(err < 0))
+		pr_err("fm_mac_get_max_frame_length() = 0x%08x\n", err);
+
+	return err;
+}
+EXPORT_SYMBOL(fm_mac_get_max_frame_length);
diff --git a/drivers/soc/fsl/fman/mac/fm_mac.h b/drivers/soc/fsl/fman/mac/fm_mac.h
new file mode 100644
index 0000000..0c4cc15
--- /dev/null
+++ b/drivers/soc/fsl/fman/mac/fm_mac.h
@@ -0,0 +1,203 @@
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
+/* FM MAC ... */
+#ifndef __FM_MAC_H
+#define __FM_MAC_H
+
+#include "service.h"
+#include "fm_mac_ext.h"
+#include "fm_common.h"
+
+#include <linux/slab.h>
+
+/* defaults */
+
+#define DEFAULT_RESET_ON_INIT                 false
+
+struct eth_hash_entry_t {
+	uint64_t addr;		/* Ethernet Address  */
+	struct list_head node;
+};
+
+#define ETH_HASH_ENTRY_OBJ(ptr) list_object(ptr, struct eth_hash_entry_t, node)
+
+struct eth_hash_t {
+	uint16_t size;
+	struct list_head *p_lsts;
+};
+
+struct fm_mac_ctrl_drv_t {
+	int (*f_fm_mac_init)(void *h_fm_mac);
+	int (*f_fm_mac_free)(void *h_fm_mac);
+
+	int (*f_fm_mac_set_statistics)(void *h_fm_mac,
+				       enum fm_mac_statistics_level
+				       statistics_level);
+	int (*f_fm_mac_cfg_lb)(void *h_fm_mac, bool new_val);
+	int (*f_fm_mac_cfg_max_frame_len)(void *h_fm_mac, uint16_t new_val);
+	int (*f_fm_mac_cfg_wan)(void *h_fm_mac, bool flag);
+	int (*f_fm_mac_cfg_pad_and_crc)(void *h_fm_mac, bool new_val);
+	int (*f_fm_mac_cfg_half_duplex)(void *h_fm_mac, bool new_val);
+	int (*f_fm_mac_cfg_len_check)(void *h_fm_mac, bool new_val);
+	int (*f_fm_mac_cfg_tbi_phy_addr)(void *h_fm_mac, uint8_t new_val);
+	int (*f_fm_mac_cfg_exception)(void *h_fm_mac,
+				      enum fm_mac_exceptions, bool enable);
+	int (*f_fm_mac_cfg_reset_on_init)(void *h_fm_mac, bool enable);
+#ifdef FM_TX_ECC_FRMS_ERRATA_10GMAC_A004
+	int (*f_fm_mac_cfg_skip_fman11_wa)(void *h_fm_mac);
+#endif /* FM_TX_ECC_FRMS_ERRATA_10GMAC_A004 */
+
+	int (*f_fm_mac_set_exception)(void *h_fm_mac,
+				      enum fm_mac_exceptions ex,
+				      bool enable);
+
+	int (*f_fm_mac_enable)(void *h_fm_mac, enum comm_mode mode);
+	int (*f_fm_mac_disable)(void *h_fm_mac, enum comm_mode mode);
+	int (*f_fm_mac_enable_1588_ts)(void *h_fm_mac);
+	int (*f_fm_mac_disable_1588_ts)(void *h_fm_mac);
+	int (*f_fm_mac_reset)(void *h_fm_mac, bool wait);
+
+	int (*f_fm_mac_set_tx_auto_pause_frames)(void *h_fm_mac,
+						 uint16_t pause_time);
+	int (*f_fm_mac_set_tx_pause_frames)(void *h_fm_mac,
+					    uint8_t priority,
+					    uint16_t pause_time,
+					    uint16_t thresh_time);
+	int (*f_fm_mac_set_rx_ignore_pause_frames)(void *h_fm_mac, bool en);
+
+	int (*f_fm_mac_reset_counters)(void *h_fm_mac);
+	int (*f_fm_mac_get_statistics)(void *h_fm_mac,
+				       struct fm_mac_statistics_t
+				       *p_statistics);
+
+	int (*f_fm_mac_modify_mac_addr)(void *h_fm_mac,
+					enet_addr_t *p_enet_addr);
+	int (*f_fm_mac_add_hash_mac_addr)(void *h_fm_mac,
+					  enet_addr_t *p_enet_addr);
+	int (*f_fm_mac_remove_hash_mac_addr)(void *h_fm_mac,
+					     enet_addr_t *p_enet_addr);
+	int (*f_fm_mac_add_exact_match_mac_addr)(void *h_fm_mac,
+						 enet_addr_t *p_enet_addr);
+	int (*f_fm_mac_removel_exact_match_mac_addr)(void *h_fm_mac,
+						     enet_addr_t *p_enet_addr);
+
+	int (*f_fm_mac_set_promiscuous)(void *h_fm_mac, bool new_val);
+	int (*f_fm_mac_adjust_link)(void *h_fm_mac,
+				    enum ethernet_speed speed,
+				    bool full_duplex);
+	int (*f_fm_mac_restart_autoneg)(void *h_fm_mac);
+
+	int (*f_fm_mac_set_wake_on_lan)(void *h_fm_mac, bool en);
+
+	int (*f_fm_mac_get_id)(void *h_fm_mac, uint32_t *mac_id);
+
+	int (*f_fm_mac_get_version)(void *h_fm_mac, uint32_t *mac_version);
+
+	uint16_t (*f_fm_mac_get_max_frame_length)(void *h_fm_mac);
+
+	void *h_fm;
+	struct fm_revision_info_t fm_rev_info;
+	enum e_enet_mode enet_mode;
+	uint8_t mac_id;
+	bool reset_on_init;
+	uint16_t clk_freq;
+};
+
+void *dtsec_config(struct fm_mac_params_t *p_fm_mac_param);
+void *tgec_config(struct fm_mac_params_t *p_fm_mac_params);
+void *memac_config(struct fm_mac_params_t *p_fm_mac_param);
+
+static inline struct eth_hash_entry_t
+*dequeue_addr_from_hash_entry(struct list_head *p_addr_lst)
+{
+	struct eth_hash_entry_t *p_hash_entry = NULL;
+
+	if (!list_empty(p_addr_lst)) {
+		p_hash_entry = ETH_HASH_ENTRY_OBJ(p_addr_lst->next);
+		list_del_init(&p_hash_entry->node);
+	}
+	return p_hash_entry;
+}
+
+static inline void free_hash_table(struct eth_hash_t *p_hash)
+{
+	struct eth_hash_entry_t *p_hash_entry;
+	int i = 0;
+
+	if (p_hash) {
+		if (p_hash->p_lsts) {
+			for (i = 0; i < p_hash->size; i++) {
+				p_hash_entry =
+				    dequeue_addr_from_hash_entry(&p_hash->
+							     p_lsts[i]);
+				while (p_hash_entry) {
+					kfree(p_hash_entry);
+					p_hash_entry =
+					    dequeue_addr_from_hash_entry
+					    (&p_hash->p_lsts[i]);
+				}
+			}
+
+			kfree(p_hash->p_lsts);
+		}
+
+		kfree(p_hash);
+	}
+}
+
+static inline struct eth_hash_t *alloc_hash_table(uint16_t size)
+{
+	uint32_t i;
+	struct eth_hash_t *p_hash;
+
+	/* Allocate address hash table */
+	p_hash = kmalloc_array(size, sizeof(struct eth_hash_t *), GFP_KERNEL);
+	if (!p_hash)
+		return NULL;
+
+	p_hash->size = size;
+
+	p_hash->p_lsts = kmalloc_array(p_hash->size, sizeof(struct list_head),
+				       GFP_KERNEL);
+	if (!p_hash->p_lsts) {
+		kfree(p_hash);
+		return NULL;
+	}
+
+	for (i = 0; i < p_hash->size; i++)
+		INIT_LIST_HEAD(&p_hash->p_lsts[i]);
+
+	return p_hash;
+}
+
+#endif /* __FM_MAC_H */
diff --git a/drivers/soc/fsl/fman/mac/memac.c b/drivers/soc/fsl/fman/mac/memac.c
new file mode 100644
index 0000000..6d6f515
--- /dev/null
+++ b/drivers/soc/fsl/fman/mac/memac.c
@@ -0,0 +1,1115 @@
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
+/* FM mEMAC driver */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include "service.h"
+
+#include "fm_common.h"
+#include "memac.h"
+
+#include <linux/string.h>
+#include <linux/slab.h>
+
+/* Internal routine */
+static uint32_t get_mac_addr_hash_code(uint64_t eth_addr)
+{
+	uint64_t mask1, mask2;
+	uint32_t xor_val = 0;
+	uint8_t i, j;
+
+	for (i = 0; i < 6; i++) {
+		mask1 = eth_addr & (uint64_t)0x01;
+		eth_addr >>= 1;
+
+		for (j = 0; j < 7; j++) {
+			mask2 = eth_addr & (uint64_t)0x01;
+			mask1 ^= mask2;
+			eth_addr >>= 1;
+		}
+
+		xor_val |= (mask1 << (5 - i));
+	}
+
+	return xor_val;
+}
+
+static void setup_sgmii_internal_phy(struct memac_t *p_memac, uint8_t phy_addr)
+{
+	uint16_t tmp_reg16;
+	enum e_enet_mode enet_mode;
+
+	/* In case the higher MACs are used (i.e. the MACs that should
+	 * support 10G), speed=10000 is provided for SGMII ports.
+	 * Temporary modify enet mode to 1G one, so MII functions can
+	 * work correctly.
+	 */
+	enet_mode = p_memac->enet_mode;
+	p_memac->enet_mode =
+	    MAKE_ENET_MODE(ENET_INTERFACE_FROM_MODE(p_memac->enet_mode),
+			   ENET_SPEED_1000);
+
+	/* SGMII mode + AN enable */
+	tmp_reg16 = PHY_SGMII_IF_MODE_AN | PHY_SGMII_IF_MODE_SGMII;
+	memac_mii_write_phy_reg(p_memac, phy_addr, 0x14, tmp_reg16);
+
+	/* Device ability according to SGMII specification */
+	tmp_reg16 = PHY_SGMII_DEV_ABILITY_SGMII;
+	memac_mii_write_phy_reg(p_memac, phy_addr, 0x4, tmp_reg16);
+
+	/* Adjust link timer for SGMII  -
+	 * According to Cisco SGMII specification the timer should be 1.6 ms.
+	 * The link_timer register is configured in units of the clock.
+	 * - When running as 1G SGMII, Serdes clock is 125 MHz, so
+	 * unit = 1 / (125*10^6 Hz) = 8 ns.
+	 * 1.6 ms in units of 8 ns = 1.6ms / 8ns = 2*10^5 = 0x30d40
+	 * - When running as 2.5G SGMII, Serdes clock is 312.5 MHz, so
+	 * unit = 1 / (312.5*10^6 Hz) = 3.2 ns.
+	 * 1.6 ms in units of 3.2 ns = 1.6ms / 3.2ns = 5*10^5 = 0x7a120.
+	 * Since link_timer value of 1G SGMII will be too short for 2.5 SGMII,
+	 * we always set up here a value of 2.5 SGMII.
+	 */
+	memac_mii_write_phy_reg(p_memac, phy_addr, 0x13, 0x0007);
+	memac_mii_write_phy_reg(p_memac, phy_addr, 0x12, 0xa120);
+
+	/* Restart AN */
+	tmp_reg16 = PHY_SGMII_CR_DEF_VAL | PHY_SGMII_CR_RESET_AN;
+	memac_mii_write_phy_reg(p_memac, phy_addr, 0x0, tmp_reg16);
+
+	/* Restore original enet mode */
+	p_memac->enet_mode = enet_mode;
+}
+
+static void setup_sgmii_internal_phy_base_x(struct memac_t *p_memac,
+					    uint8_t phy_addr)
+{
+	uint16_t tmp_reg16;
+	enum e_enet_mode enet_mode;
+
+	/* In case the higher MACs are used (i.e. the MACs that
+	 * should support 10G), speed=10000 is provided for SGMII ports.
+	 * Temporary modify enet mode to 1G one, so MII functions can
+	 * work correctly.
+	 */
+	enet_mode = p_memac->enet_mode;
+	p_memac->enet_mode =
+	    MAKE_ENET_MODE(ENET_INTERFACE_FROM_MODE(p_memac->enet_mode),
+			   ENET_SPEED_1000);
+
+	/* 1000BaseX mode */
+	tmp_reg16 = PHY_SGMII_IF_MODE_1000X;
+	memac_mii_write_phy_reg(p_memac, phy_addr, 0x14, tmp_reg16);
+
+	/* AN Device capability  */
+	tmp_reg16 = PHY_SGMII_DEV_ABILITY_1000X;
+	memac_mii_write_phy_reg(p_memac, phy_addr, 0x4, tmp_reg16);
+
+	/* Adjust link timer for SGMII  -
+	 * For Serdes 1000BaseX auto-negotiation the timer should be 10 ms.
+	 * The link_timer register is configured in units of the clock.
+	 * - When running as 1G SGMII, Serdes clock is 125 MHz, so
+	 * unit = 1 / (125*10^6 Hz) = 8 ns.
+	 * 10 ms in units of 8 ns = 10ms / 8ns = 1250000 = 0x1312d0
+	 * - When running as 2.5G SGMII, Serdes clock is 312.5 MHz, so
+	 * unit = 1 / (312.5*10^6 Hz) = 3.2 ns.
+	 * 10 ms in units of 3.2 ns = 10ms / 3.2ns = 3125000 = 0x2faf08.
+	 * Since link_timer value of 1G SGMII will be too short for 2.5 SGMII,
+	 * we always set up here a value of 2.5 SGMII.
+	 */
+	memac_mii_write_phy_reg(p_memac, phy_addr, 0x13, 0x002f);
+	memac_mii_write_phy_reg(p_memac, phy_addr, 0x12, 0xaf08);
+
+	/* Restart AN */
+	tmp_reg16 = PHY_SGMII_CR_DEF_VAL | PHY_SGMII_CR_RESET_AN;
+	memac_mii_write_phy_reg(p_memac, phy_addr, 0x0, tmp_reg16);
+
+	/* Restore original enet mode */
+	p_memac->enet_mode = enet_mode;
+}
+
+static int check_init_parameters(struct memac_t *p_memac)
+{
+	if (p_memac->addr == 0) {
+		pr_err("Ethernet MAC must have a valid MAC address\n");
+		return -EDOM;
+	}
+	if (!p_memac->f_exception) {
+		pr_err("Uninitialized f_exception\n");
+		return -EDOM;
+	}
+	if (!p_memac->f_event) {
+		pr_warn("Uninitialize f_event\n");
+		return -EDOM;
+	}
+#ifdef FM_LEN_CHECK_ERRATA_FMAN_SW002
+	if (!p_memac->p_memac_drv_param->no_length_check_enable) {
+		pr_err("LengthCheck!\n");
+		return -ENOSYS;
+	}
+#endif /* FM_LEN_CHECK_ERRATA_FMAN_SW002 */
+
+	return 0;
+}
+
+static int get_exception_flag(enum fm_mac_exceptions exception)
+{
+	uint32_t bit_mask;
+
+	switch (exception) {
+	case FM_MAC_EX_10G_1TX_ECC_ER:
+		bit_mask = MEMAC_IMASK_TECC_ER;
+		break;
+	case FM_MAC_EX_10G_RX_ECC_ER:
+		bit_mask = MEMAC_IMASK_RECC_ER;
+		break;
+	case FM_MAC_EX_TS_FIFO_ECC_ERR:
+		bit_mask = MEMAC_IMASK_TSECC_ER;
+		break;
+	case FM_MAC_EX_MAGIC_PACKET_INDICATION:
+		bit_mask = MEMAC_IMASK_MGI;
+		break;
+	default:
+		bit_mask = 0;
+		break;
+	}
+
+	return bit_mask;
+}
+
+static void memac_err_exception(void *h_memac)
+{
+	struct memac_t *p_memac = (struct memac_t *)h_memac;
+	uint32_t event, imask;
+
+	event = fman_memac_get_event(p_memac->p_mem_map, 0xffffffff);
+	imask = fman_memac_get_interrupt_mask(p_memac->p_mem_map);
+
+	/* Imask include both error and notification/event bits.
+	 * Leaving only error bits enabled by imask.
+	 * The imask error bits are shifted by 16 bits offset from
+	 * their corresponding location in the ievent - hence the >> 16
+	 */
+	event &= ((imask & MEMAC_ALL_ERRS_IMASK) >> 16);
+
+	fman_memac_ack_event(p_memac->p_mem_map, event);
+
+	if (event & MEMAC_IEVNT_TS_ECC_ER)
+		p_memac->f_exception(p_memac->h_app,
+				     FM_MAC_EX_TS_FIFO_ECC_ERR);
+	if (event & MEMAC_IEVNT_TX_ECC_ER)
+		p_memac->f_exception(p_memac->h_app,
+				     FM_MAC_EX_10G_1TX_ECC_ER);
+	if (event & MEMAC_IEVNT_RX_ECC_ER)
+		p_memac->f_exception(p_memac->h_app,
+				     FM_MAC_EX_10G_RX_ECC_ER);
+}
+
+static void memac_exception(void *h_memac)
+{
+	struct memac_t *p_memac = (struct memac_t *)h_memac;
+	uint32_t event, imask;
+
+	event = fman_memac_get_event(p_memac->p_mem_map, 0xffffffff);
+	imask = fman_memac_get_interrupt_mask(p_memac->p_mem_map);
+
+	/* Imask include both error and notification/event bits.
+	 * Leaving only error bits enabled by imask.
+	 * The imask error bits are shifted by 16 bits offset from
+	 * their corresponding location in the ievent - hence the >> 16
+	 */
+	event &= ((imask & MEMAC_ALL_ERRS_IMASK) >> 16);
+
+	fman_memac_ack_event(p_memac->p_mem_map, event);
+
+	if (event & MEMAC_IEVNT_MGI)
+		p_memac->f_exception(p_memac->h_app,
+				     FM_MAC_EX_MAGIC_PACKET_INDICATION);
+}
+
+static void free_init_resources(struct memac_t *p_memac)
+{
+	fm_unregister_intr(p_memac->fm_mac_ctrl_drv.h_fm,
+			   FM_MOD_MAC,
+			   p_memac->mac_id,
+			   FM_INTR_TYPE_ERR);
+
+	/* release the driver's group hash table */
+	free_hash_table(p_memac->p_multicast_addr_hash);
+	p_memac->p_multicast_addr_hash = NULL;
+
+	/* release the driver's individual hash table */
+	free_hash_table(p_memac->p_unicast_addr_hash);
+	p_memac->p_unicast_addr_hash = NULL;
+}
+
+/* Checks if p_memac driver parameters were initialized
+ * returns 0 if success else returns error code
+ */
+static int is_init_done(struct memac_cfg *p_memac_drv_parameters)
+{
+	if (!p_memac_drv_parameters)
+		return 0;
+	return -ENOSYS;
+}
+
+/* mEMAC API routine */
+
+static int memac_enable(void *h_memac, enum comm_mode mode)
+{
+	struct memac_t *p_memac = (struct memac_t *)h_memac;
+	int ret;
+
+	ret = is_init_done(p_memac->p_memac_drv_param);
+	if (ret)
+		return ret;
+
+	fman_memac_enable(p_memac->p_mem_map,
+			  (mode & COMM_MODE_RX),
+			  (mode & COMM_MODE_TX));
+
+	return 0;
+}
+
+static int memac_disable(void *h_memac, enum comm_mode mode)
+{
+	struct memac_t *p_memac = (struct memac_t *)h_memac;
+	int ret;
+
+	ret = is_init_done(p_memac->p_memac_drv_param);
+	if (ret)
+		return ret;
+
+	fman_memac_disable(p_memac->p_mem_map,
+			   (mode & COMM_MODE_RX),
+			   (mode & COMM_MODE_TX));
+
+	return 0;
+}
+
+static int memac_set_promiscuous(void *h_memac, bool new_val)
+{
+	struct memac_t *p_memac = (struct memac_t *)h_memac;
+	int ret;
+
+	ret = is_init_done(p_memac->p_memac_drv_param);
+	if (ret)
+		return ret;
+
+	fman_memac_set_promiscuous(p_memac->p_mem_map, new_val);
+
+	return 0;
+}
+
+static int memac_adjust_link(void *h_memac, enum ethernet_speed speed,
+			     bool full_duplex)
+{
+	struct memac_t *p_memac = (struct memac_t *)h_memac;
+	int ret;
+
+	ret = is_init_done(p_memac->p_memac_drv_param);
+	if (ret)
+		return ret;
+
+	if ((speed >= ENET_SPEED_1000) && (!full_duplex)) {
+		pr_err("MAC 1G or 10G doesn't support half-duplex");
+		return -EINVAL;
+	}
+
+	fman_memac_adjust_link(p_memac->p_mem_map,
+			       (enum enet_interface)
+			       ENET_INTERFACE_FROM_MODE(p_memac->enet_mode),
+			       (enum enet_speed)speed, full_duplex);
+	return 0;
+}
+
+/* memac configs modification function */
+
+static int memac_cfg_lb(void *h_memac, bool new_val)
+{
+	struct memac_t *p_memac = (struct memac_t *)h_memac;
+	int ret;
+
+	ret = is_init_done(p_memac->p_memac_drv_param);
+	if (!ret)
+		return -ENOSYS;
+
+	p_memac->p_memac_drv_param->loopback_enable = new_val;
+
+	return 0;
+}
+
+static int memac_cfg_wan(void *h_memac, bool new_val)
+{
+	struct memac_t *p_memac = (struct memac_t *)h_memac;
+	int ret;
+
+	ret = is_init_done(p_memac->p_memac_drv_param);
+	if (!ret)
+		return -ENOSYS;
+
+	p_memac->p_memac_drv_param->wan_mode_enable = new_val;
+
+	return 0;
+}
+
+static int memac_cfg_max_frame_len(void *h_memac, uint16_t new_val)
+{
+	struct memac_t *p_memac = (struct memac_t *)h_memac;
+	int ret;
+
+	ret = is_init_done(p_memac->p_memac_drv_param);
+	if (!ret)
+		return -ENOSYS;
+
+	p_memac->p_memac_drv_param->max_frame_length = new_val;
+
+	return 0;
+}
+
+static int memac_cfg_pad(void *h_memac, bool new_val)
+{
+	struct memac_t *p_memac = (struct memac_t *)h_memac;
+	int ret;
+
+	ret = is_init_done(p_memac->p_memac_drv_param);
+	if (!ret)
+		return -ENOSYS;
+
+	p_memac->p_memac_drv_param->pad_enable = new_val;
+
+	return 0;
+}
+
+static int memac_cfg_len_check(void *h_memac, bool new_val)
+{
+	struct memac_t *p_memac = (struct memac_t *)h_memac;
+	int ret;
+
+	ret = is_init_done(p_memac->p_memac_drv_param);
+	if (!ret)
+		return -ENOSYS;
+
+	p_memac->p_memac_drv_param->no_length_check_enable = !new_val;
+
+	return 0;
+}
+
+static int memac_cfg_exception(void *h_memac,
+			       enum fm_mac_exceptions exception, bool enable)
+{
+	struct memac_t *p_memac = (struct memac_t *)h_memac;
+	uint32_t bit_mask = 0;
+	int ret;
+
+	ret = is_init_done(p_memac->p_memac_drv_param);
+	if (!ret)
+		return -ENOSYS;
+
+	bit_mask = get_exception_flag(exception);
+	if (bit_mask) {
+		if (enable)
+			p_memac->exceptions |= bit_mask;
+		else
+			p_memac->exceptions &= ~bit_mask;
+	} else {
+		pr_err("Undefined exception\n");
+		return -EDOM;
+	}
+	return 0;
+}
+
+static int memac_cfg_reset_on_init(void *h_memac, bool enable)
+{
+	struct memac_t *p_memac = (struct memac_t *)h_memac;
+	int ret;
+
+	ret = is_init_done(p_memac->p_memac_drv_param);
+	if (!ret)
+		return -ENOSYS;
+
+	p_memac->p_memac_drv_param->reset_on_init = enable;
+
+	return 0;
+}
+
+/* memac run time api functions */
+
+static int memac_set_tx_pause_frames(void *h_memac,
+				     uint8_t priority,
+					 uint16_t pause_time,
+					 uint16_t thresh_time)
+{
+	struct memac_t *p_memac = (struct memac_t *)h_memac;
+	int ret;
+
+	ret = is_init_done(p_memac->p_memac_drv_param);
+	if (ret)
+		return ret;
+
+	if (priority != 0xFF) {
+		bool port_configured, pre_fetch_enabled;
+
+		if (fm_get_tnum_aging_period(p_memac->
+					     fm_mac_ctrl_drv.h_fm) == 0) {
+			pr_err("PFC operation:Enable TNUM aging");
+			return -EINVAL;
+		}
+
+		fm_get_port_prefetch_cfg(p_memac->fm_mac_ctrl_drv.h_fm,
+					 p_memac->fm_mac_ctrl_drv.mac_id,
+					 &port_configured, &pre_fetch_enabled);
+
+		if ((ENET_SPEED_FROM_MODE
+		     (p_memac->fm_mac_ctrl_drv.enet_mode) ==
+		     ENET_SPEED_1000) && !port_configured)
+			pr_debug("PFC operation:prefetch configured on FMTxPORT\n");
+
+		if ((ENET_SPEED_FROM_MODE
+		     (p_memac->fm_mac_ctrl_drv.enet_mode) ==
+		     ENET_SPEED_1000) && port_configured && !pre_fetch_enabled)
+			pr_debug("PFC operation:prefetch configured on FMTxPORT\n");
+	}
+
+	fman_memac_set_tx_pause_frames(p_memac->p_mem_map, priority,
+				       pause_time, thresh_time);
+
+	return 0;
+}
+
+static int memac_set_tx_auto_pause_frames(void *h_memac,
+					  uint16_t pause_time)
+{
+	return memac_set_tx_pause_frames(h_memac, FM_MAC_NO_PFC, pause_time,
+					 0);
+}
+
+static int memac_set_rx_ignore_pause_frames(void *h_memac, bool en)
+{
+	struct memac_t *p_memac = (struct memac_t *)h_memac;
+	int ret;
+
+	ret = is_init_done(p_memac->p_memac_drv_param);
+	if (ret)
+		return ret;
+
+	fman_memac_set_rx_ignore_pause_frames(p_memac->p_mem_map, en);
+
+	return 0;
+}
+
+static int memac_set_wake_on_lan(void *h_memac, bool en)
+{
+	struct memac_t *p_memac = (struct memac_t *)h_memac;
+	int ret;
+
+	ret = is_init_done(p_memac->p_memac_drv_param);
+	if (ret)
+		return ret;
+
+	fman_memac_set_wol(p_memac->p_mem_map, en);
+
+	return 0;
+}
+
+static int memac_enable_1588_ts(void *h_memac)
+{
+	struct memac_t __maybe_unused *p_memac = (struct memac_t *)h_memac;
+	int ret;
+
+	ret = is_init_done(p_memac->p_memac_drv_param);
+	if (ret)
+		return ret;
+
+	pr_debug("mEMAC has 1588 always enabled!\n");
+
+	return 0;
+}
+
+/* Counters handling */
+
+static int memac_get_statistics(void *h_memac,
+				struct fm_mac_statistics_t *p_statistics)
+{
+	struct memac_t *p_memac = (struct memac_t *)h_memac;
+	int ret;
+
+	ret = is_init_done(p_memac->p_memac_drv_param);
+	if (ret)
+		return ret;
+
+	p_statistics->e_stat_pkts64 =
+	    fman_memac_get_counter(p_memac->p_mem_map, E_MEMAC_COUNTER_R64);
+	p_statistics->e_stat_pkts65to127 =
+	    fman_memac_get_counter(p_memac->p_mem_map, E_MEMAC_COUNTER_R127);
+	p_statistics->e_stat_pkts128to255 =
+	    fman_memac_get_counter(p_memac->p_mem_map, E_MEMAC_COUNTER_R255);
+	p_statistics->e_stat_pkts256to511 =
+	    fman_memac_get_counter(p_memac->p_mem_map, E_MEMAC_COUNTER_R511);
+	p_statistics->e_stat_pkts512to1023 =
+	    fman_memac_get_counter(p_memac->p_mem_map, E_MEMAC_COUNTER_R1023);
+	p_statistics->e_stat_pkts1024to1518 =
+	    fman_memac_get_counter(p_memac->p_mem_map, E_MEMAC_COUNTER_R1518);
+	p_statistics->e_stat_pkts1519to1522 =
+	    fman_memac_get_counter(p_memac->p_mem_map, E_MEMAC_COUNTER_R1519X);
+
+	p_statistics->e_stat_fragments =
+	    fman_memac_get_counter(p_memac->p_mem_map, E_MEMAC_COUNTER_RFRG);
+	p_statistics->e_stat_jabbers =
+	    fman_memac_get_counter(p_memac->p_mem_map, E_MEMAC_COUNTER_RJBR);
+
+	p_statistics->e_stats_drop_events =
+	    fman_memac_get_counter(p_memac->p_mem_map, E_MEMAC_COUNTER_RDRP);
+	p_statistics->e_stat_crc_align_errors =
+	    fman_memac_get_counter(p_memac->p_mem_map, E_MEMAC_COUNTER_RALN);
+
+	p_statistics->e_stat_undersize_pkts =
+	    fman_memac_get_counter(p_memac->p_mem_map, E_MEMAC_COUNTER_TUND);
+	p_statistics->e_stat_oversize_pkts =
+	    fman_memac_get_counter(p_memac->p_mem_map, E_MEMAC_COUNTER_ROVR);
+/* Pause */
+	p_statistics->re_stat_pause =
+	    fman_memac_get_counter(p_memac->p_mem_map, E_MEMAC_COUNTER_RXPF);
+	p_statistics->te_stat_pause =
+	    fman_memac_get_counter(p_memac->p_mem_map, E_MEMAC_COUNTER_TXPF);
+
+/* MIB II */
+	p_statistics->if_in_octets =
+	    fman_memac_get_counter(p_memac->p_mem_map, E_MEMAC_COUNTER_ROCT);
+	p_statistics->if_in_ucast_pkts =
+	    fman_memac_get_counter(p_memac->p_mem_map, E_MEMAC_COUNTER_RUCA);
+	p_statistics->if_in_mcast_pkts =
+	    fman_memac_get_counter(p_memac->p_mem_map, E_MEMAC_COUNTER_RMCA);
+	p_statistics->if_in_bcast_pkts =
+	    fman_memac_get_counter(p_memac->p_mem_map, E_MEMAC_COUNTER_RBCA);
+	p_statistics->if_in_pkts =
+	    p_statistics->if_in_ucast_pkts + p_statistics->if_in_mcast_pkts +
+	    p_statistics->if_in_bcast_pkts;
+	p_statistics->if_in_discards = 0;
+	p_statistics->if_in_errors =
+	    fman_memac_get_counter(p_memac->p_mem_map, E_MEMAC_COUNTER_RERR);
+
+	p_statistics->if_out_octets =
+	    fman_memac_get_counter(p_memac->p_mem_map, E_MEMAC_COUNTER_TOCT);
+	p_statistics->if_out_ucast_pkts =
+	    fman_memac_get_counter(p_memac->p_mem_map, E_MEMAC_COUNTER_TUCA);
+	p_statistics->if_out_mcast_pkts =
+	    fman_memac_get_counter(p_memac->p_mem_map, E_MEMAC_COUNTER_TMCA);
+	p_statistics->if_out_bcast_pkts =
+	    fman_memac_get_counter(p_memac->p_mem_map, E_MEMAC_COUNTER_TBCA);
+	p_statistics->if_out_pkts =
+	    p_statistics->if_out_ucast_pkts + p_statistics->if_out_mcast_pkts +
+	    p_statistics->if_out_bcast_pkts;
+	p_statistics->if_out_discards = 0;
+	p_statistics->if_out_errors =
+	    fman_memac_get_counter(p_memac->p_mem_map, E_MEMAC_COUNTER_TERR);
+
+	return 0;
+}
+
+static int memac_modify_mac_address(void *h_memac,
+				    enet_addr_t *p_enet_addr)
+{
+	struct memac_t *p_memac = (struct memac_t *)h_memac;
+	int ret;
+
+	ret = is_init_done(p_memac->p_memac_drv_param);
+	if (ret)
+		return ret;
+
+	fman_memac_add_addr_in_paddr(p_memac->p_mem_map,
+				     (uint8_t *)(*p_enet_addr), 0);
+
+	return 0;
+}
+
+static int memac_reset_counters(void *h_memac)
+{
+	struct memac_t *p_memac = (struct memac_t *)h_memac;
+	int ret;
+
+	ret = is_init_done(p_memac->p_memac_drv_param);
+	if (ret)
+		return ret;
+
+	fman_memac_reset_stat(p_memac->p_mem_map);
+
+	return 0;
+}
+
+static int memac_add_exact_match_mac_address(void *h_memac,
+					     enet_addr_t *p_eth_addr)
+{
+	struct memac_t *p_memac = (struct memac_t *)h_memac;
+	uint64_t eth_addr;
+	uint8_t paddr_num;
+	int ret;
+
+	ret = is_init_done(p_memac->p_memac_drv_param);
+	if (ret)
+		return ret;
+
+	eth_addr = ENET_ADDR_TO_UINT64(*p_eth_addr);
+
+	if (eth_addr & GROUP_ADDRESS) {
+		/* Multicast address has no effect in PADDR */
+		pr_err("Multicast address\n");
+		return -EDOM;
+	}
+	/* Make sure no PADDR contains this address */
+	for (paddr_num = 0; paddr_num < MEMAC_NUM_OF_PADDRS; paddr_num++)
+		if (p_memac->ind_addr_reg_used[paddr_num])
+			if (p_memac->paddr[paddr_num] == eth_addr)
+				return -EEXIST;
+
+	/* Find first unused PADDR */
+	for (paddr_num = 0; paddr_num < MEMAC_NUM_OF_PADDRS; paddr_num++)
+		if (!(p_memac->ind_addr_reg_used[paddr_num])) {
+			/* mark this PADDR as used */
+			p_memac->ind_addr_reg_used[paddr_num] = true;
+			/* store address */
+			p_memac->paddr[paddr_num] = eth_addr;
+
+			/* put in hardware */
+			fman_memac_add_addr_in_paddr(p_memac->p_mem_map,
+						     (uint8_t *)(*p_eth_addr),
+						     paddr_num);
+			p_memac->num_of_ind_addr_in_regs++;
+
+			return 0;
+		}
+
+	/* No free PADDR */
+	return -EXFULL;
+}
+
+static int memac_del_exact_match_mac_address(void *h_memac,
+					     enet_addr_t *p_eth_addr)
+{
+	struct memac_t *p_memac = (struct memac_t *)h_memac;
+	uint64_t eth_addr;
+	uint8_t paddr_num;
+	int ret;
+
+	ret = is_init_done(p_memac->p_memac_drv_param);
+	if (ret)
+		return ret;
+
+	eth_addr = ENET_ADDR_TO_UINT64(*p_eth_addr);
+
+	/* Find used PADDR containing this address */
+	for (paddr_num = 0; paddr_num < MEMAC_NUM_OF_PADDRS; paddr_num++) {
+		if ((p_memac->ind_addr_reg_used[paddr_num]) &&
+		    (p_memac->paddr[paddr_num] == eth_addr)) {
+			/* mark this PADDR as not used */
+			p_memac->ind_addr_reg_used[paddr_num] = false;
+			/* clear in hardware */
+			fman_memac_clear_addr_in_paddr(p_memac->p_mem_map,
+						       paddr_num);
+			p_memac->num_of_ind_addr_in_regs--;
+
+			return 0;
+		}
+	}
+
+	return -ENOMEDIUM;
+}
+
+static int memac_add_hash_mac_address(void *h_memac,
+				      enet_addr_t *p_eth_addr)
+{
+	struct memac_t *p_memac = (struct memac_t *)h_memac;
+	struct eth_hash_entry_t *p_hash_entry;
+	uint32_t hash;
+	uint64_t eth_addr;
+	int ret;
+
+	ret = is_init_done(p_memac->p_memac_drv_param);
+	if (ret)
+		return ret;
+
+	eth_addr = ENET_ADDR_TO_UINT64(*p_eth_addr);
+
+	if (!(eth_addr & GROUP_ADDRESS)) {
+		/* Unicast addresses not supported in hash */
+		pr_err("Unicast Address\n");
+		return -ENOSYS;
+	}
+	hash = get_mac_addr_hash_code(eth_addr) & HASH_CTRL_ADDR_MASK;
+
+	/* Create element to be added to the driver hash table */
+	p_hash_entry = kmalloc(sizeof(*p_hash_entry), GFP_KERNEL);
+	if (!p_hash_entry)
+		return -ENOMEM;
+	p_hash_entry->addr = eth_addr;
+	INIT_LIST_HEAD(&p_hash_entry->node);
+
+	list_add_tail(&p_hash_entry->node,
+		      &p_memac->p_multicast_addr_hash->p_lsts[hash]);
+	fman_memac_set_hash_table(p_memac->p_mem_map,
+				  (hash | HASH_CTRL_MCAST_EN));
+
+	return 0;
+}
+
+static int memac_del_hash_mac_address(void *h_memac,
+				      enet_addr_t *p_eth_addr)
+{
+	struct memac_t *p_memac = (struct memac_t *)h_memac;
+	struct eth_hash_entry_t *p_hash_entry = NULL;
+	struct list_head *p_pos;
+	uint32_t hash;
+	uint64_t eth_addr;
+	int ret;
+
+	ret = is_init_done(p_memac->p_memac_drv_param);
+	if (ret)
+		return ret;
+
+	eth_addr = ENET_ADDR_TO_UINT64(*p_eth_addr);
+
+	hash = get_mac_addr_hash_code(eth_addr) & HASH_CTRL_ADDR_MASK;
+
+	list_for_each(p_pos, &p_memac->p_multicast_addr_hash->p_lsts[hash]) {
+		p_hash_entry = ETH_HASH_ENTRY_OBJ(p_pos);
+		if (p_hash_entry->addr == eth_addr) {
+			list_del_init(&p_hash_entry->node);
+			kfree(p_hash_entry);
+			break;
+		}
+	}
+	if (list_empty(&p_memac->p_multicast_addr_hash->p_lsts[hash]))
+		fman_memac_set_hash_table(p_memac->p_mem_map,
+					  (hash & ~HASH_CTRL_MCAST_EN));
+
+	return 0;
+}
+
+static int memac_set_exception(void *h_memac,
+			       enum fm_mac_exceptions exception,
+				   bool enable)
+{
+	struct memac_t *p_memac = (struct memac_t *)h_memac;
+	uint32_t bit_mask = 0;
+	int ret;
+
+	ret = is_init_done(p_memac->p_memac_drv_param);
+	if (ret)
+		return ret;
+
+	bit_mask = get_exception_flag(exception);
+	if (bit_mask) {
+		if (enable)
+			p_memac->exceptions |= bit_mask;
+		else
+			p_memac->exceptions &= ~bit_mask;
+	} else {
+		pr_err("Undefined exception\n");
+		return -EDOM;
+	}
+	fman_memac_set_exception(p_memac->p_mem_map, bit_mask, enable);
+
+	return 0;
+}
+
+static uint16_t memac_get_max_frame_length(void *h_memac)
+{
+	struct memac_t *p_memac = (struct memac_t *)h_memac;
+	int ret;
+
+	ret = is_init_done(p_memac->p_memac_drv_param);
+	if (ret)
+		return 0;
+
+	return fman_memac_get_max_frame_len(p_memac->p_mem_map);
+}
+
+/* mEMAC Init & Free API */
+static int memac_init(void *h_memac)
+{
+	struct memac_t *p_memac = (struct memac_t *)h_memac;
+	struct memac_cfg *p_memac_drv_param;
+	enum enet_interface enet_interface;
+	enum enet_speed enet_speed;
+	uint8_t i, phy_addr;
+	enet_addr_t eth_addr;
+	enum fm_mac_type port_type;
+	bool slow_10g_if = false;
+	int err, ret;
+
+	ret = is_init_done(p_memac->p_memac_drv_param);
+	if (!ret)
+		return -ENOSYS;
+
+	err = check_init_parameters(p_memac);
+	if (err)
+		return err;
+
+	p_memac_drv_param = p_memac->p_memac_drv_param;
+
+	if (p_memac->fm_mac_ctrl_drv.fm_rev_info.major_rev == 6 &&
+	    p_memac->fm_mac_ctrl_drv.fm_rev_info.minor_rev == 4)
+		slow_10g_if = true;
+
+	port_type =
+	    ((ENET_SPEED_FROM_MODE(p_memac->enet_mode) <
+	      ENET_SPEED_10000) ? FM_MAC_1G : FM_MAC_10G);
+
+	/* First, reset the MAC if desired. */
+	if (p_memac_drv_param->reset_on_init)
+		fman_memac_reset(p_memac->p_mem_map);
+
+	/* MAC Address */
+	MAKE_ENET_ADDR_FROM_UINT64(p_memac->addr, eth_addr);
+	fman_memac_add_addr_in_paddr(p_memac->p_mem_map,
+				     (uint8_t *)eth_addr, 0);
+
+	enet_interface =
+	    (enum enet_interface)ENET_INTERFACE_FROM_MODE(p_memac->enet_mode);
+	enet_speed = (enum enet_speed)ENET_SPEED_FROM_MODE(p_memac->enet_mode);
+
+	fman_memac_init(p_memac->p_mem_map,
+			p_memac->p_memac_drv_param,
+			enet_interface,
+			enet_speed,
+			slow_10g_if,
+			p_memac->exceptions);
+
+#ifdef FM_RX_FIFO_CORRUPT_ERRATA_10GMAC_A006320
+	{
+		uint32_t tmp_reg = 0;
+
+		fm_get_revision(p_memac->fm_mac_ctrl_drv.h_fm,
+				&p_memac->fm_mac_ctrl_drv.fm_rev_info);
+		/* check the FMAN version - the bug exists only in rev1 */
+		if ((p_memac->fm_mac_ctrl_drv.fm_rev_info.major_rev == 6) &&
+		    ((p_memac->fm_mac_ctrl_drv.fm_rev_info.minor_rev == 0) ||
+		     (p_memac->fm_mac_ctrl_drv.fm_rev_info.minor_rev == 3))) {
+			/* MAC strips CRC from received frames - this
+			 * workaround should decrease the likelihood of bug
+			 * appearance
+			 */
+			tmp_reg = GET_UINT32(p_memac->p_mem_map->
+					     command_config);
+			tmp_reg &= ~CMD_CFG_CRC_FWD;
+			WRITE_UINT32(p_memac->p_mem_map->command_config,
+				     tmp_reg);
+		}
+	}
+#endif /* FM_RX_FIFO_CORRUPT_ERRATA_10GMAC_A006320 */
+
+	if (ENET_INTERFACE_FROM_MODE(p_memac->enet_mode) == ENET_IF_SGMII) {
+		/* Configure internal SGMII PHY */
+		if (p_memac->enet_mode & ENET_IF_SGMII_BASEX)
+			setup_sgmii_internal_phy_base_x(p_memac, PHY_MDIO_ADDR);
+		else
+			setup_sgmii_internal_phy(p_memac, PHY_MDIO_ADDR);
+	} else if (ENET_INTERFACE_FROM_MODE(p_memac->enet_mode) ==
+		   ENET_IF_QSGMII) {
+		/* Configure 4 internal SGMII PHYs */
+		for (i = 0; i < 4; i++) {
+			/* QSGMII PHY address occupies 3 upper bits of 5-bit
+			 * phy_address; the lower 2 bits are used to extend
+			 * register address space and access each one of 4
+			 * ports inside QSGMII.
+			 */
+			phy_addr = (uint8_t)((PHY_MDIO_ADDR << 2) | i);
+			if (p_memac->enet_mode & ENET_IF_SGMII_BASEX)
+				setup_sgmii_internal_phy_base_x(p_memac,
+								phy_addr);
+			else
+				setup_sgmii_internal_phy(p_memac, phy_addr);
+		}
+	}
+
+	/* Max Frame Length */
+	err = fm_set_mac_max_frame(p_memac->fm_mac_ctrl_drv.h_fm,
+				   port_type,
+				   p_memac->fm_mac_ctrl_drv.mac_id,
+				   p_memac_drv_param->max_frame_length);
+	if (err) {
+		pr_err("settings Mac max frame length is FAILED\n");
+		return err;
+	}
+
+	p_memac->p_multicast_addr_hash = alloc_hash_table(HASH_TABLE_SIZE);
+	if (!p_memac->p_multicast_addr_hash) {
+		free_init_resources(p_memac);
+		pr_err("allocation hash table is FAILED\n");
+		return -ENOMEM;
+	}
+
+	p_memac->p_unicast_addr_hash = alloc_hash_table(HASH_TABLE_SIZE);
+	if (!p_memac->p_unicast_addr_hash) {
+		free_init_resources(p_memac);
+		pr_err("allocation hash table is FAILED\n");
+		return -ENOMEM;
+	}
+
+	fm_register_intr(p_memac->fm_mac_ctrl_drv.h_fm,
+			 FM_MOD_MAC,
+			 p_memac->mac_id,
+			 FM_INTR_TYPE_ERR,
+			 memac_err_exception,
+			 p_memac);
+
+	fm_register_intr(p_memac->fm_mac_ctrl_drv.h_fm,
+			 FM_MOD_MAC,
+			 p_memac->mac_id, FM_INTR_TYPE_NORMAL,
+			 memac_exception, p_memac);
+
+	kfree(p_memac_drv_param);
+	p_memac->p_memac_drv_param = NULL;
+
+	return 0;
+}
+
+static int memac_free(void *h_memac)
+{
+	struct memac_t *p_memac = (struct memac_t *)h_memac;
+
+	free_init_resources(p_memac);
+
+	kfree(p_memac->p_memac_drv_param);
+	kfree(p_memac);
+
+	return 0;
+}
+
+static void init_fm_mac_ctrl_drv(struct fm_mac_ctrl_drv_t *
+					  p_fm_mac_ctrl_drv)
+{
+	p_fm_mac_ctrl_drv->f_fm_mac_init = memac_init;
+	p_fm_mac_ctrl_drv->f_fm_mac_free = memac_free;
+
+	p_fm_mac_ctrl_drv->f_fm_mac_set_statistics = NULL;
+	p_fm_mac_ctrl_drv->f_fm_mac_cfg_lb = memac_cfg_lb;
+	p_fm_mac_ctrl_drv->f_fm_mac_cfg_max_frame_len =
+	memac_cfg_max_frame_len;
+
+	p_fm_mac_ctrl_drv->f_fm_mac_cfg_wan = memac_cfg_wan;
+
+	p_fm_mac_ctrl_drv->f_fm_mac_cfg_pad_and_crc = memac_cfg_pad;
+	/* half-duplex is detected automatically */
+	p_fm_mac_ctrl_drv->f_fm_mac_cfg_half_duplex = NULL;
+	p_fm_mac_ctrl_drv->f_fm_mac_cfg_len_check = memac_cfg_len_check;
+
+	p_fm_mac_ctrl_drv->f_fm_mac_cfg_exception = memac_cfg_exception;
+	p_fm_mac_ctrl_drv->f_fm_mac_cfg_reset_on_init =
+	memac_cfg_reset_on_init;
+
+	p_fm_mac_ctrl_drv->f_fm_mac_set_exception = memac_set_exception;
+
+	/* always enabled */
+	p_fm_mac_ctrl_drv->f_fm_mac_enable_1588_ts = memac_enable_1588_ts;
+	p_fm_mac_ctrl_drv->f_fm_mac_disable_1588_ts = NULL;
+
+	p_fm_mac_ctrl_drv->f_fm_mac_set_promiscuous = memac_set_promiscuous;
+	p_fm_mac_ctrl_drv->f_fm_mac_adjust_link = memac_adjust_link;
+	p_fm_mac_ctrl_drv->f_fm_mac_restart_autoneg = NULL;
+
+	p_fm_mac_ctrl_drv->f_fm_mac_enable = memac_enable;
+	p_fm_mac_ctrl_drv->f_fm_mac_disable = memac_disable;
+
+	p_fm_mac_ctrl_drv->f_fm_mac_set_tx_auto_pause_frames =
+		memac_set_tx_auto_pause_frames;
+	p_fm_mac_ctrl_drv->f_fm_mac_set_tx_pause_frames =
+		memac_set_tx_pause_frames;
+	p_fm_mac_ctrl_drv->f_fm_mac_set_rx_ignore_pause_frames =
+		memac_set_rx_ignore_pause_frames;
+
+	p_fm_mac_ctrl_drv->f_fm_mac_set_wake_on_lan = memac_set_wake_on_lan;
+
+	p_fm_mac_ctrl_drv->f_fm_mac_reset_counters = memac_reset_counters;
+	p_fm_mac_ctrl_drv->f_fm_mac_get_statistics = memac_get_statistics;
+
+	p_fm_mac_ctrl_drv->f_fm_mac_modify_mac_addr =
+		memac_modify_mac_address;
+	p_fm_mac_ctrl_drv->f_fm_mac_add_hash_mac_addr =
+		memac_add_hash_mac_address;
+	p_fm_mac_ctrl_drv->f_fm_mac_remove_hash_mac_addr =
+		memac_del_hash_mac_address;
+	p_fm_mac_ctrl_drv->f_fm_mac_add_exact_match_mac_addr =
+		memac_add_exact_match_mac_address;
+	p_fm_mac_ctrl_drv->f_fm_mac_removel_exact_match_mac_addr =
+		memac_del_exact_match_mac_address;
+	p_fm_mac_ctrl_drv->f_fm_mac_get_id = NULL;
+	p_fm_mac_ctrl_drv->f_fm_mac_get_version = NULL;
+	p_fm_mac_ctrl_drv->f_fm_mac_get_max_frame_length =
+		memac_get_max_frame_length;
+}
+
+/* m_emac config main entry */
+
+void *memac_config(struct fm_mac_params_t *p_fm_mac_param)
+{
+	struct memac_t *p_memac;
+	struct memac_cfg *p_memac_drv_param;
+	uintptr_t base_addr;
+
+	base_addr = p_fm_mac_param->base_addr;
+	/* allocate memory for the m_emac data structure */
+	p_memac = kzalloc(sizeof(*p_memac), GFP_KERNEL);
+	if (!p_memac)
+		return NULL;
+
+	init_fm_mac_ctrl_drv(&p_memac->fm_mac_ctrl_drv);
+
+	/* allocate memory for the m_emac driver parameters data structure */
+	p_memac_drv_param = kzalloc(sizeof(*p_memac_drv_param),
+				    GFP_KERNEL);
+	if (!p_memac_drv_param) {
+		memac_free(p_memac);
+		return NULL;
+	}
+
+	/* Plant parameter structure pointer */
+	p_memac->p_memac_drv_param = p_memac_drv_param;
+
+	fman_memac_defconfig(p_memac_drv_param);
+
+	p_memac->addr = ENET_ADDR_TO_UINT64(p_fm_mac_param->addr);
+
+	p_memac->p_mem_map =
+		(struct memac_regs __iomem *)UINT_TO_PTR(base_addr);
+	p_memac->p_mii_mem_map = (struct memac_mii_access_mem_map __iomem *)
+		UINT_TO_PTR(base_addr + MEMAC_TO_MII_OFFSET);
+
+	p_memac->enet_mode = p_fm_mac_param->enet_mode;
+	p_memac->mac_id = p_fm_mac_param->mac_id;
+	p_memac->exceptions = MEMAC_default_exceptions;
+	p_memac->f_exception = p_fm_mac_param->f_exception;
+	p_memac->f_event = p_fm_mac_param->f_event;
+	p_memac->h_app = p_fm_mac_param->h_app;
+
+	return p_memac;
+}
diff --git a/drivers/soc/fsl/fman/mac/memac.h b/drivers/soc/fsl/fman/mac/memac.h
new file mode 100644
index 0000000..9f0c607
--- /dev/null
+++ b/drivers/soc/fsl/fman/mac/memac.h
@@ -0,0 +1,103 @@
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
+/* FM Multirate Ethernet MAC (mEMAC) */
+#ifndef __MEMAC_H
+#define __MEMAC_H
+
+#include "service.h"
+
+#include "fsl_fman_memac_mii_acc.h"
+#include "fm_mac.h"
+#include "fsl_fman_memac.h"
+
+#define MEMAC_default_exceptions\
+	((uint32_t)(MEMAC_IMASK_TSECC_ER | MEMAC_IMASK_TECC_ER |\
+		MEMAC_IMASK_RECC_ER | MEMAC_IMASK_MGI))
+
+struct memac_t {
+	/* Upper Mac control block */
+	struct fm_mac_ctrl_drv_t fm_mac_ctrl_drv;
+	/* Handle to the upper layer application  */
+	void *h_app;
+	/* Pointer to MAC memory mapped registers */
+	struct memac_regs __iomem *p_mem_map;
+	/* Pointer to MII memory mapped registers */
+	struct memac_mii_access_mem_map __iomem *p_mii_mem_map;
+	/* MAC address of device */
+	uint64_t addr;
+	/* Ethernet physical interface  */
+	enum e_enet_mode enet_mode;
+	fm_mac_exception_cb *f_exception;
+	int mdio_irq;
+	fm_mac_exception_cb *f_event;
+	/* Whether a particular individual address
+	 * recognition register is being used
+	 */
+	bool ind_addr_reg_used[MEMAC_NUM_OF_PADDRS];
+	/* MAC address for particular individual address
+	 * recognition register
+	 */
+	uint64_t paddr[MEMAC_NUM_OF_PADDRS];
+	/* Number of individual addresses in registers for this station. */
+	uint8_t num_of_ind_addr_in_regs;
+	/* Pointer to driver's global address hash table  */
+	struct eth_hash_t *p_multicast_addr_hash;
+	/* Pointer to driver's individual address hash table  */
+	struct eth_hash_t *p_unicast_addr_hash;
+	bool debug_mode;
+	uint8_t mac_id;
+	uint32_t exceptions;
+	struct memac_cfg *p_memac_drv_param;
+};
+
+/* Internal PHY access */
+#define PHY_MDIO_ADDR               0
+
+/* Internal PHY Registers - SGMII */
+#define PHY_SGMII_CR_RESET_AN           0x0200
+#define PHY_SGMII_CR_DEF_VAL            0x1140
+#define PHY_SGMII_DEV_ABILITY_SGMII     0x4001
+#define PHY_SGMII_DEV_ABILITY_1000X     0x01A0
+#define PHY_SGMII_IF_MODE_AN            0x0002
+#define PHY_SGMII_IF_MODE_SGMII         0x0001
+#define PHY_SGMII_IF_MODE_1000X         0x0000
+
+/* Offset from the MEM map to the MDIO mem map */
+#define MEMAC_TO_MII_OFFSET         0x030
+
+int memac_mii_write_phy_reg(void *h_memac, uint8_t phy_addr, uint8_t reg,
+			    uint16_t data);
+int memac_mii_read_phy_reg(void *h_memac, uint8_t phy_addr, uint8_t reg,
+			   uint16_t *p_data);
+
+#endif /* __MEMAC_H */
diff --git a/drivers/soc/fsl/fman/mac/memac_mii_acc.c b/drivers/soc/fsl/fman/mac/memac_mii_acc.c
new file mode 100644
index 0000000..0150e9d
--- /dev/null
+++ b/drivers/soc/fsl/fman/mac/memac_mii_acc.c
@@ -0,0 +1,66 @@
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
+#include "service.h"
+#include "fm_mac.h"
+#include "memac.h"
+
+#include "fm_common.h"
+#include "memac_mii_acc.h"
+
+int memac_mii_write_phy_reg(void *h_memac,
+			    uint8_t phy_addr, uint8_t reg, uint16_t data)
+{
+	struct memac_t *p_memac = (struct memac_t *)h_memac;
+
+	return (int)fman_memac_mii_write_phy_reg(p_memac->p_mii_mem_map,
+						 phy_addr,
+						     reg,
+						     data,
+						     (enum enet_speed)
+						     ENET_SPEED_FROM_MODE
+						     (p_memac->enet_mode));
+}
+
+int memac_mii_read_phy_reg(void *h_memac,
+			   uint8_t phy_addr, uint8_t reg, uint16_t *p_data)
+{
+	struct memac_t *p_memac = (struct memac_t *)h_memac;
+
+	return fman_memac_mii_read_phy_reg(p_memac->p_mii_mem_map,
+					   phy_addr,
+					   reg,
+					   p_data,
+					   (enum enet_speed)
+					   ENET_SPEED_FROM_MODE(p_memac->
+								enet_mode));
+}
diff --git a/drivers/soc/fsl/fman/mac/memac_mii_acc.h b/drivers/soc/fsl/fman/mac/memac_mii_acc.h
new file mode 100644
index 0000000..f38572c
--- /dev/null
+++ b/drivers/soc/fsl/fman/mac/memac_mii_acc.h
@@ -0,0 +1,50 @@
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
+#ifndef __MEMAC_MII_ACC_H
+#define __MEMAC_MII_ACC_H
+
+#include "service.h"
+
+/* MII Management Registers */
+#define MDIO_CFG_CLK_DIV_MASK       0x0080ff80
+#define MDIO_CFG_HOLD_MASK          0x0000001c
+#define MDIO_CFG_ENC45              0x00000040
+#define MDIO_CFG_READ_ERR           0x00000002
+#define MDIO_CFG_BSY                0x00000001
+
+#define MDIO_CTL_PHY_ADDR_SHIFT     5
+#define MDIO_CTL_READ               0x00008000
+
+#define MDIO_DATA_BSY               0x80000000
+
+#endif /* __MEMAC_MII_ACC_H */
diff --git a/drivers/soc/fsl/fman/mac/tgec.c b/drivers/soc/fsl/fman/mac/tgec.c
new file mode 100644
index 0000000..5796032
--- /dev/null
+++ b/drivers/soc/fsl/fman/mac/tgec.c
@@ -0,0 +1,1030 @@
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
+/* TGEC MAC ... */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include "service.h"
+#include "crc_mac_addr_ext.h"
+
+#include "fm_common.h"
+#include "fsl_fman_tgec.h"
+#include "tgec.h"
+
+#include <linux/string.h>
+#include <linux/slab.h>
+#include <linux/bitrev.h>
+
+/* Internal routines */
+
+static int check_init_parameters(struct tgec_t *p_tgec)
+{
+	if (ENET_SPEED_FROM_MODE(p_tgec->enet_mode) < ENET_SPEED_10000) {
+		pr_err("10G MAC driver only support 10G speed\n");
+		return -EDOM;
+	}
+	if (p_tgec->addr == 0) {
+		pr_err("Ethernet 10G MAC Must have valid MAC Address\n");
+		return -EDOM;
+	}
+	if (!p_tgec->f_exception) {
+		pr_err("uninitialized f_exception\n");
+		return -EDOM;
+	}
+	if (!p_tgec->f_event) {
+		pr_err("uninitialized f_event\n");
+		return -EDOM;
+	}
+#ifdef FM_LEN_CHECK_ERRATA_FMAN_SW002
+	if (!p_tgec->p_tgec_drv_param->no_length_check_enable) {
+		pr_warn("LengthCheck!\n");
+		return -EDOM;
+	}
+#endif /* FM_LEN_CHECK_ERRATA_FMAN_SW002 */
+	return 0;
+}
+
+static int get_exception_flag(enum fm_mac_exceptions exception)
+{
+	uint32_t bit_mask;
+
+	switch (exception) {
+	case FM_MAC_EX_10G_MDIO_SCAN_EVENT:
+		bit_mask = TGEC_IMASK_MDIO_SCAN_EVENT;
+		break;
+	case FM_MAC_EX_10G_MDIO_CMD_CMPL:
+		bit_mask = TGEC_IMASK_MDIO_CMD_CMPL;
+		break;
+	case FM_MAC_EX_10G_REM_FAULT:
+		bit_mask = TGEC_IMASK_REM_FAULT;
+		break;
+	case FM_MAC_EX_10G_LOC_FAULT:
+		bit_mask = TGEC_IMASK_LOC_FAULT;
+		break;
+	case FM_MAC_EX_10G_1TX_ECC_ER:
+		bit_mask = TGEC_IMASK_TX_ECC_ER;
+		break;
+	case FM_MAC_EX_10G_TX_FIFO_UNFL:
+		bit_mask = TGEC_IMASK_TX_FIFO_UNFL;
+		break;
+	case FM_MAC_EX_10G_TX_FIFO_OVFL:
+		bit_mask = TGEC_IMASK_TX_FIFO_OVFL;
+		break;
+	case FM_MAC_EX_10G_TX_ER:
+		bit_mask = TGEC_IMASK_TX_ER;
+		break;
+	case FM_MAC_EX_10G_RX_FIFO_OVFL:
+		bit_mask = TGEC_IMASK_RX_FIFO_OVFL;
+		break;
+	case FM_MAC_EX_10G_RX_ECC_ER:
+		bit_mask = TGEC_IMASK_RX_ECC_ER;
+		break;
+	case FM_MAC_EX_10G_RX_JAB_FRM:
+		bit_mask = TGEC_IMASK_RX_JAB_FRM;
+		break;
+	case FM_MAC_EX_10G_RX_OVRSZ_FRM:
+		bit_mask = TGEC_IMASK_RX_OVRSZ_FRM;
+		break;
+	case FM_MAC_EX_10G_RX_RUNT_FRM:
+		bit_mask = TGEC_IMASK_RX_RUNT_FRM;
+		break;
+	case FM_MAC_EX_10G_RX_FRAG_FRM:
+		bit_mask = TGEC_IMASK_RX_FRAG_FRM;
+		break;
+	case FM_MAC_EX_10G_RX_LEN_ER:
+		bit_mask = TGEC_IMASK_RX_LEN_ER;
+		break;
+	case FM_MAC_EX_10G_RX_CRC_ER:
+		bit_mask = TGEC_IMASK_RX_CRC_ER;
+		break;
+	case FM_MAC_EX_10G_RX_ALIGN_ER:
+		bit_mask = TGEC_IMASK_RX_ALIGN_ER;
+		break;
+	default:
+		bit_mask = 0;
+		break;
+	}
+
+	return bit_mask;
+}
+
+static uint32_t get_mac_addr_hash_code(uint64_t eth_addr)
+{
+	uint32_t crc;
+
+	/* CRC calculation */
+	GET_MAC_ADDR_CRC(eth_addr, crc);
+
+	crc = bitrev32(crc);
+
+	return crc;
+}
+
+static void tgec_err_exception(void *h_tgec)
+{
+	struct tgec_t *p_tgec = (struct tgec_t *)h_tgec;
+	uint32_t event;
+	struct tgec_regs __iomem *p_tgec_mem_map = p_tgec->p_mem_map;
+
+	/* do not handle MDIO events */
+	event =
+	    fman_tgec_get_event(p_tgec_mem_map,
+				~(TGEC_IMASK_MDIO_SCAN_EVENT |
+				  TGEC_IMASK_MDIO_CMD_CMPL));
+	event &= fman_tgec_get_interrupt_mask(p_tgec_mem_map);
+
+	fman_tgec_ack_event(p_tgec_mem_map, event);
+
+	if (event & TGEC_IMASK_REM_FAULT)
+		p_tgec->f_exception(p_tgec->h_app, FM_MAC_EX_10G_REM_FAULT);
+	if (event & TGEC_IMASK_LOC_FAULT)
+		p_tgec->f_exception(p_tgec->h_app, FM_MAC_EX_10G_LOC_FAULT);
+	if (event & TGEC_IMASK_TX_ECC_ER)
+		p_tgec->f_exception(p_tgec->h_app, FM_MAC_EX_10G_1TX_ECC_ER);
+	if (event & TGEC_IMASK_TX_FIFO_UNFL)
+		p_tgec->f_exception(p_tgec->h_app,
+				    FM_MAC_EX_10G_TX_FIFO_UNFL);
+	if (event & TGEC_IMASK_TX_FIFO_OVFL)
+		p_tgec->f_exception(p_tgec->h_app,
+				    FM_MAC_EX_10G_TX_FIFO_OVFL);
+	if (event & TGEC_IMASK_TX_ER)
+		p_tgec->f_exception(p_tgec->h_app, FM_MAC_EX_10G_TX_ER);
+	if (event & TGEC_IMASK_RX_FIFO_OVFL)
+		p_tgec->f_exception(p_tgec->h_app,
+				    FM_MAC_EX_10G_RX_FIFO_OVFL);
+	if (event & TGEC_IMASK_RX_ECC_ER)
+		p_tgec->f_exception(p_tgec->h_app, FM_MAC_EX_10G_RX_ECC_ER);
+	if (event & TGEC_IMASK_RX_JAB_FRM)
+		p_tgec->f_exception(p_tgec->h_app, FM_MAC_EX_10G_RX_JAB_FRM);
+	if (event & TGEC_IMASK_RX_OVRSZ_FRM)
+		p_tgec->f_exception(p_tgec->h_app,
+				    FM_MAC_EX_10G_RX_OVRSZ_FRM);
+	if (event & TGEC_IMASK_RX_RUNT_FRM)
+		p_tgec->f_exception(p_tgec->h_app, FM_MAC_EX_10G_RX_RUNT_FRM);
+	if (event & TGEC_IMASK_RX_FRAG_FRM)
+		p_tgec->f_exception(p_tgec->h_app, FM_MAC_EX_10G_RX_FRAG_FRM);
+	if (event & TGEC_IMASK_RX_LEN_ER)
+		p_tgec->f_exception(p_tgec->h_app, FM_MAC_EX_10G_RX_LEN_ER);
+	if (event & TGEC_IMASK_RX_CRC_ER)
+		p_tgec->f_exception(p_tgec->h_app, FM_MAC_EX_10G_RX_CRC_ER);
+	if (event & TGEC_IMASK_RX_ALIGN_ER)
+		p_tgec->f_exception(p_tgec->h_app, FM_MAC_EX_10G_RX_ALIGN_ER);
+}
+
+static void free_init_resources(struct tgec_t *p_tgec)
+{
+	fm_unregister_intr(p_tgec->fm_mac_ctrl_drv.h_fm,
+			   FM_MOD_MAC, p_tgec->mac_id, FM_INTR_TYPE_ERR);
+
+	/* release the driver's group hash table */
+	free_hash_table(p_tgec->p_multicast_addr_hash);
+	p_tgec->p_multicast_addr_hash = NULL;
+
+	/* release the driver's individual hash table */
+	free_hash_table(p_tgec->p_unicast_addr_hash);
+	p_tgec->p_unicast_addr_hash = NULL;
+}
+
+/* Checks if p_tgec driver parameters were initialized
+ * returns 0 if success else returns error
+ */
+static int is_init_done(struct tgec_cfg *p_tgec_drv_parameters)
+{
+	if (!p_tgec_drv_parameters)
+		return 0;
+	return -ENOSYS;
+}
+
+/* TGEC MAC API routines */
+static int tgec_enable(void *h_tgec, enum comm_mode mode)
+{
+	struct tgec_t *p_tgec = (struct tgec_t *)h_tgec;
+	int ret;
+
+	ret = is_init_done(p_tgec->p_tgec_drv_param);
+	if (ret)
+		return ret;
+
+	fman_tgec_enable(p_tgec->p_mem_map,
+			 (mode & COMM_MODE_RX),
+			 (mode & COMM_MODE_TX));
+
+	return 0;
+}
+
+static int tgec_disable(void *h_tgec, enum comm_mode mode)
+{
+	struct tgec_t *p_tgec = (struct tgec_t *)h_tgec;
+	int ret;
+
+	ret = is_init_done(p_tgec->p_tgec_drv_param);
+	if (ret)
+		return ret;
+
+	fman_tgec_disable(p_tgec->p_mem_map,
+			  (mode & COMM_MODE_RX),
+			  (mode & COMM_MODE_TX));
+
+	return 0;
+}
+
+static int tgec_set_promiscuous(void *h_tgec, bool new_val)
+{
+	struct tgec_t *p_tgec = (struct tgec_t *)h_tgec;
+	int ret;
+
+	ret = is_init_done(p_tgec->p_tgec_drv_param);
+	if (ret)
+		return ret;
+
+	fman_tgec_set_promiscuous(p_tgec->p_mem_map, new_val);
+
+	return 0;
+}
+
+/* tgec configs modification functions */
+
+static int tgec_cfg_lb(void *h_tgec, bool new_val)
+{
+	struct tgec_t *p_tgec = (struct tgec_t *)h_tgec;
+	int ret;
+
+	ret = is_init_done(p_tgec->p_tgec_drv_param);
+	if (!ret)
+		return -ENOSYS;
+
+	p_tgec->p_tgec_drv_param->loopback_enable = new_val;
+
+	return 0;
+}
+
+static int tgec_cfg_wan(void *h_tgec, bool new_val)
+{
+	struct tgec_t *p_tgec = (struct tgec_t *)h_tgec;
+	int ret;
+
+	ret = is_init_done(p_tgec->p_tgec_drv_param);
+	if (!ret)
+		return -ENOSYS;
+
+	p_tgec->p_tgec_drv_param->wan_mode_enable = new_val;
+
+	return 0;
+}
+
+static int tgec_cfg_max_frame_len(void *h_tgec, uint16_t new_val)
+{
+	struct tgec_t *p_tgec = (struct tgec_t *)h_tgec;
+	int ret;
+
+	ret = is_init_done(p_tgec->p_tgec_drv_param);
+	if (!ret)
+		return -ENOSYS;
+
+	p_tgec->p_tgec_drv_param->max_frame_length = new_val;
+
+	return 0;
+}
+
+static int tgec_cfg_len_check(void *h_tgec, bool __maybe_unused new_val)
+{
+	struct tgec_t *p_tgec = (struct tgec_t *)h_tgec;
+	int ret;
+
+	ret = is_init_done(p_tgec->p_tgec_drv_param);
+	if (!ret)
+		return -ENOSYS;
+
+	p_tgec->p_tgec_drv_param->no_length_check_enable = !new_val;
+
+	return 0;
+}
+
+static int tgec_cfg_exception(void *h_tgec,
+			      enum fm_mac_exceptions exception, bool enable)
+{
+	struct tgec_t *p_tgec = (struct tgec_t *)h_tgec;
+	uint32_t bit_mask = 0;
+	int ret;
+
+	ret = is_init_done(p_tgec->p_tgec_drv_param);
+	if (!ret)
+		return -ENOSYS;
+
+	bit_mask = get_exception_flag(exception);
+	if (bit_mask) {
+		if (enable)
+			p_tgec->exceptions |= bit_mask;
+		else
+			p_tgec->exceptions &= ~bit_mask;
+	} else {
+		pr_err("Undefined exception\n");
+		return -EDOM;
+	}
+	return 0;
+}
+
+#ifdef FM_TX_ECC_FRMS_ERRATA_10GMAC_A004
+
+static int tgec_cfg_skip_fman11_wa(void *h_tgec)
+{
+	struct tgec_t *p_tgec = (struct tgec_t *)h_tgec;
+	int ret;
+
+	ret = is_init_done(p_tgec->p_tgec_drv_param);
+	if (!ret)
+		return -ENOSYS;
+
+	p_tgec->p_tgec_drv_param->skip_fman11_workaround = true;
+
+	return 0;
+}
+#endif /* FM_TX_ECC_FRMS_ERRATA_10GMAC_A004 */
+
+/* tgec run time api functions */
+
+/* backward compatibility. will be removed in the future. */
+static int tgec_tx_mac_pause(void *h_tgec, uint16_t pause_time)
+{
+	struct tgec_t *p_tgec = (struct tgec_t *)h_tgec;
+	int ret;
+
+	ret = is_init_done(p_tgec->p_tgec_drv_param);
+	if (ret)
+		return ret;
+
+	fman_tgec_set_tx_pause_frames(p_tgec->p_mem_map, pause_time);
+
+	return 0;
+}
+
+static int tgec_set_tx_pause_frames(void *h_tgec,
+				    uint8_t __maybe_unused priority,
+				    uint16_t pause_time,
+				    uint16_t __maybe_unused thresh_time)
+{
+	struct tgec_t *p_tgec = (struct tgec_t *)h_tgec;
+	int ret;
+
+	ret = is_init_done(p_tgec->p_tgec_drv_param);
+	if (ret)
+		return ret;
+
+	fman_tgec_set_tx_pause_frames(p_tgec->p_mem_map, pause_time);
+
+	return 0;
+}
+
+static int tgec_rx_ignore_mac_pause(void *h_tgec, bool en)
+{
+	struct tgec_t *p_tgec = (struct tgec_t *)h_tgec;
+	int ret;
+
+	ret = is_init_done(p_tgec->p_tgec_drv_param);
+	if (ret)
+		return ret;
+
+	fman_tgec_set_rx_ignore_pause_frames(p_tgec->p_mem_map, en);
+
+	return 0;
+}
+
+static int tgec_get_statistics(void *h_tgec,
+			       struct fm_mac_statistics_t *p_statistics)
+{
+	struct tgec_t *p_tgec = (struct tgec_t *)h_tgec;
+	struct tgec_regs __iomem *p_tgec_mem_map;
+	int ret;
+
+	ret = is_init_done(p_tgec->p_tgec_drv_param);
+	if (ret)
+		return ret;
+
+	p_tgec_mem_map = p_tgec->p_mem_map;
+
+	p_statistics->e_stat_pkts64 =
+	    fman_tgec_get_counter(p_tgec_mem_map, E_TGEC_COUNTER_R64);
+	p_statistics->e_stat_pkts65to127 =
+	    fman_tgec_get_counter(p_tgec_mem_map, E_TGEC_COUNTER_R127);
+	p_statistics->e_stat_pkts128to255 =
+	    fman_tgec_get_counter(p_tgec_mem_map, E_TGEC_COUNTER_R255);
+	p_statistics->e_stat_pkts256to511 =
+	    fman_tgec_get_counter(p_tgec_mem_map, E_TGEC_COUNTER_R511);
+	p_statistics->e_stat_pkts512to1023 =
+	    fman_tgec_get_counter(p_tgec_mem_map, E_TGEC_COUNTER_R1023);
+	p_statistics->e_stat_pkts1024to1518 =
+	    fman_tgec_get_counter(p_tgec_mem_map, E_TGEC_COUNTER_R1518);
+	p_statistics->e_stat_pkts1519to1522 =
+	    fman_tgec_get_counter(p_tgec_mem_map, E_TGEC_COUNTER_R1519X);
+	p_statistics->e_stat_fragments =
+	    fman_tgec_get_counter(p_tgec_mem_map, E_TGEC_COUNTER_TRFRG);
+	p_statistics->e_stat_jabbers =
+	    fman_tgec_get_counter(p_tgec_mem_map, E_TGEC_COUNTER_TRJBR);
+
+	p_statistics->e_stats_drop_events =
+	    fman_tgec_get_counter(p_tgec_mem_map, E_TGEC_COUNTER_RDRP);
+	p_statistics->e_stat_crc_align_errors =
+	    fman_tgec_get_counter(p_tgec_mem_map, E_TGEC_COUNTER_RALN);
+
+	p_statistics->e_stat_undersize_pkts =
+	    fman_tgec_get_counter(p_tgec_mem_map, E_TGEC_COUNTER_TRUND);
+	p_statistics->e_stat_oversize_pkts =
+	    fman_tgec_get_counter(p_tgec_mem_map, E_TGEC_COUNTER_TROVR);
+/* Pause */
+	p_statistics->re_stat_pause =
+	    fman_tgec_get_counter(p_tgec_mem_map, E_TGEC_COUNTER_RXPF);
+	p_statistics->te_stat_pause =
+	    fman_tgec_get_counter(p_tgec_mem_map, E_TGEC_COUNTER_TXPF);
+
+/* MIB II */
+	p_statistics->if_in_octets =
+	    fman_tgec_get_counter(p_tgec_mem_map, E_TGEC_COUNTER_ROCT);
+	p_statistics->if_in_ucast_pkts =
+	    fman_tgec_get_counter(p_tgec_mem_map, E_TGEC_COUNTER_RUCA);
+	p_statistics->if_in_mcast_pkts =
+	    fman_tgec_get_counter(p_tgec_mem_map, E_TGEC_COUNTER_RMCA);
+	p_statistics->if_in_bcast_pkts =
+	    fman_tgec_get_counter(p_tgec_mem_map, E_TGEC_COUNTER_RBCA);
+	p_statistics->if_in_pkts =
+	    p_statistics->if_in_ucast_pkts + p_statistics->if_in_mcast_pkts +
+	    p_statistics->if_in_bcast_pkts;
+	p_statistics->if_in_discards = 0;
+	p_statistics->if_in_errors =
+	    fman_tgec_get_counter(p_tgec_mem_map, E_TGEC_COUNTER_RERR);
+
+	p_statistics->if_out_octets =
+	    fman_tgec_get_counter(p_tgec_mem_map, E_TGEC_COUNTER_TOCT);
+	p_statistics->if_out_ucast_pkts =
+	    fman_tgec_get_counter(p_tgec_mem_map, E_TGEC_COUNTER_TUCA);
+	p_statistics->if_out_mcast_pkts =
+	    fman_tgec_get_counter(p_tgec_mem_map, E_TGEC_COUNTER_TMCA);
+	p_statistics->if_out_bcast_pkts =
+	    fman_tgec_get_counter(p_tgec_mem_map, E_TGEC_COUNTER_TBCA);
+	p_statistics->if_out_pkts =
+	    p_statistics->if_out_ucast_pkts + p_statistics->if_out_mcast_pkts +
+	    p_statistics->if_out_bcast_pkts;
+	p_statistics->if_out_discards = 0;
+	p_statistics->if_out_errors =
+	    fman_tgec_get_counter(p_tgec_mem_map, E_TGEC_COUNTER_TERR);
+
+	return 0;
+}
+
+static int tgec_enable_1588_ts(void *h_tgec)
+{
+	struct tgec_t *p_tgec = (struct tgec_t *)h_tgec;
+	int ret;
+
+	ret = is_init_done(p_tgec->p_tgec_drv_param);
+	if (ret)
+		return ret;
+
+	fman_tgec_enable_1588_time_stamp(p_tgec->p_mem_map, 1);
+
+	return 0;
+}
+
+static int tgec_disable_1588_ts(void *h_tgec)
+{
+	struct tgec_t *p_tgec = (struct tgec_t *)h_tgec;
+	int ret;
+
+	ret = is_init_done(p_tgec->p_tgec_drv_param);
+	if (ret)
+		return ret;
+
+	fman_tgec_enable_1588_time_stamp(p_tgec->p_mem_map, 0);
+
+	return 0;
+}
+
+static int tgec_modify_mac_address(void *h_tgec, enet_addr_t
+				       *p_enet_addr)
+{
+	struct tgec_t *p_tgec = (struct tgec_t *)h_tgec;
+	int ret;
+
+	ret = is_init_done(p_tgec->p_tgec_drv_param);
+	if (ret)
+		return ret;
+
+	p_tgec->addr = ENET_ADDR_TO_UINT64(*p_enet_addr);
+	fman_tgec_set_mac_address(p_tgec->p_mem_map, (uint8_t *)(*p_enet_addr));
+
+	return 0;
+}
+
+static int tgec_reset_counters(void *h_tgec)
+{
+	struct tgec_t *p_tgec = (struct tgec_t *)h_tgec;
+	int ret;
+
+	ret = is_init_done(p_tgec->p_tgec_drv_param);
+	if (ret)
+		return ret;
+
+	fman_tgec_reset_stat(p_tgec->p_mem_map);
+
+	return 0;
+}
+
+static int tgec_add_exact_match_mac_address(void *h_tgec,
+					    enet_addr_t *p_eth_addr)
+{
+	struct tgec_t *p_tgec = (struct tgec_t *)h_tgec;
+	uint64_t eth_addr;
+	uint8_t paddr_num;
+	int ret;
+
+	ret = is_init_done(p_tgec->p_tgec_drv_param);
+	if (ret)
+		return ret;
+
+	eth_addr = ENET_ADDR_TO_UINT64(*p_eth_addr);
+
+	if (eth_addr & GROUP_ADDRESS) {
+		/* Multicast address has no effect in PADDR */
+		pr_err("Multicast address\n");
+		return -EDOM;
+	}
+
+	/* Make sure no PADDR contains this address */
+	for (paddr_num = 0; paddr_num < TGEC_NUM_OF_PADDRS; paddr_num++)
+		if (p_tgec->ind_addr_reg_used[paddr_num])
+			if (p_tgec->paddr[paddr_num] == eth_addr)
+				return -EEXIST;
+
+	/* Find first unused PADDR */
+	for (paddr_num = 0; paddr_num < TGEC_NUM_OF_PADDRS; paddr_num++) {
+		if (!(p_tgec->ind_addr_reg_used[paddr_num])) {
+			/* mark this PADDR as used */
+			p_tgec->ind_addr_reg_used[paddr_num] = true;
+			/* store address */
+			p_tgec->paddr[paddr_num] = eth_addr;
+
+			/* put in hardware */
+			fman_tgec_add_addr_in_paddr(p_tgec->p_mem_map,
+						    (uint8_t *)(*p_eth_addr)
+						    ); /* , paddr_num */
+			p_tgec->num_of_ind_addr_in_regs++;
+
+			return 0;
+		}
+	}
+
+	/* No free PADDR */
+	return -EBUSY;
+}
+
+static int tgec_del_exact_match_mac_address(void *h_tgec,
+					    enet_addr_t *p_eth_addr)
+{
+	struct tgec_t *p_tgec = (struct tgec_t *)h_tgec;
+	uint64_t eth_addr;
+	uint8_t paddr_num;
+	int ret;
+
+	ret = is_init_done(p_tgec->p_tgec_drv_param);
+	if (ret)
+		return ret;
+
+	eth_addr = ENET_ADDR_TO_UINT64(*p_eth_addr);
+
+	/* Find used PADDR containing this address */
+	for (paddr_num = 0; paddr_num < TGEC_NUM_OF_PADDRS; paddr_num++) {
+		if ((p_tgec->ind_addr_reg_used[paddr_num]) &&
+		    (p_tgec->paddr[paddr_num] == eth_addr)) {
+			/* mark this PADDR as not used */
+			p_tgec->ind_addr_reg_used[paddr_num] = false;
+			/* clear in hardware */
+			fman_tgec_clear_addr_in_paddr(p_tgec->
+						      p_mem_map /*, paddr_num */
+						      );
+			p_tgec->num_of_ind_addr_in_regs--;
+
+			return 0;
+		}
+	}
+
+	return -ENOMEDIUM;
+}
+
+static int tgec_add_hash_mac_address(void *h_tgec, enet_addr_t
+					 *p_eth_addr)
+{
+	struct tgec_t *p_tgec = (struct tgec_t *)h_tgec;
+	struct eth_hash_entry_t *p_hash_entry;
+	uint32_t crc;
+	uint32_t hash;
+	uint64_t eth_addr;
+	int ret;
+
+	ret = is_init_done(p_tgec->p_tgec_drv_param);
+	if (ret)
+		return ret;
+
+	eth_addr = ENET_ADDR_TO_UINT64(*p_eth_addr);
+
+	if (!(eth_addr & GROUP_ADDRESS)) {
+		/* Unicast addresses not supported in hash */
+		pr_err("Unicast Address\n");
+		return -ENOSYS;
+	}
+	/* CRC calculation */
+	crc = get_mac_addr_hash_code(eth_addr);
+
+	/* Take 9 MSB bits */
+	hash = (crc >> TGEC_HASH_MCAST_SHIFT) & TGEC_HASH_ADR_MSK;
+
+	/* Create element to be added to the driver hash table */
+	p_hash_entry = kmalloc(sizeof(*p_hash_entry), GFP_KERNEL);
+	if (!p_hash_entry)
+		return -ENOMEM;
+	p_hash_entry->addr = eth_addr;
+	INIT_LIST_HEAD(&p_hash_entry->node);
+
+	list_add_tail(&p_hash_entry->node,
+		      &p_tgec->p_multicast_addr_hash->p_lsts[hash]);
+	fman_tgec_set_hash_table(p_tgec->p_mem_map,
+				 (hash | TGEC_HASH_MCAST_EN));
+
+	return 0;
+}
+
+static int tgec_del_hash_mac_address(void *h_tgec, enet_addr_t
+					 *p_eth_addr)
+{
+	struct tgec_t *p_tgec = (struct tgec_t *)h_tgec;
+	struct eth_hash_entry_t *p_hash_entry = NULL;
+	struct list_head *p_pos;
+	uint32_t crc;
+	uint32_t hash;
+	uint64_t eth_addr;
+	int ret;
+
+	ret = is_init_done(p_tgec->p_tgec_drv_param);
+	if (ret)
+		return ret;
+
+	eth_addr = ((*(uint64_t *)p_eth_addr) >> 16);
+
+	/* CRC calculation */
+	crc = get_mac_addr_hash_code(eth_addr);
+	/* Take 9 MSB bits */
+	hash = (crc >> TGEC_HASH_MCAST_SHIFT) & TGEC_HASH_ADR_MSK;
+
+	list_for_each(p_pos, &p_tgec->p_multicast_addr_hash->p_lsts[hash]) {
+		p_hash_entry = ETH_HASH_ENTRY_OBJ(p_pos);
+		if (p_hash_entry->addr == eth_addr) {
+			list_del_init(&p_hash_entry->node);
+			kfree(p_hash_entry);
+			break;
+		}
+	}
+	if (list_empty(&p_tgec->p_multicast_addr_hash->p_lsts[hash]))
+		fman_tgec_set_hash_table(p_tgec->p_mem_map,
+					 (hash & ~TGEC_HASH_MCAST_EN));
+
+	return 0;
+}
+
+static int tgec_get_id(void *h_tgec,
+		       uint32_t __maybe_unused *mac_id)
+{
+	struct tgec_t __maybe_unused *p_tgec = (struct tgec_t *)h_tgec;
+	int ret;
+
+	ret = is_init_done(p_tgec->p_tgec_drv_param);
+	if (ret)
+		return ret;
+
+	pr_warn("tgec_get_id not supported\n");
+	return -ENOSYS;
+}
+
+static int tgec_get_version(void *h_tgec, uint32_t *mac_version)
+{
+	struct tgec_t *p_tgec = (struct tgec_t *)h_tgec;
+	int ret;
+
+	ret = is_init_done(p_tgec->p_tgec_drv_param);
+	if (ret)
+		return ret;
+
+	*mac_version = fman_tgec_get_revision(p_tgec->p_mem_map);
+
+	return 0;
+}
+
+static int tgec_set_excpetion(void *h_tgec,
+			      enum fm_mac_exceptions exception,
+				  bool enable)
+{
+	struct tgec_t *p_tgec = (struct tgec_t *)h_tgec;
+	uint32_t bit_mask = 0;
+	int ret;
+
+	ret = is_init_done(p_tgec->p_tgec_drv_param);
+	if (ret)
+		return ret;
+
+	bit_mask = get_exception_flag(exception);
+	if (bit_mask) {
+		if (enable)
+			p_tgec->exceptions |= bit_mask;
+		else
+			p_tgec->exceptions &= ~bit_mask;
+	} else {
+		pr_err("Undefined exception\n");
+		return -EDOM;
+	}
+	if (enable)
+		fman_tgec_enable_interrupt(p_tgec->p_mem_map, bit_mask);
+	else
+		fman_tgec_disable_interrupt(p_tgec->p_mem_map, bit_mask);
+
+	return 0;
+}
+
+static uint16_t tgec_get_max_frame_length(void *h_tgec)
+{
+	struct tgec_t *p_tgec = (struct tgec_t *)h_tgec;
+	int ret;
+
+	ret = is_init_done(p_tgec->p_tgec_drv_param);
+	if (ret)
+		return 0;
+
+	return fman_tgec_get_max_frame_len(p_tgec->p_mem_map);
+}
+
+#ifdef FM_TX_ECC_FRMS_ERRATA_10GMAC_A004
+static int tgec_tx_ecc_workaround(struct tgec_t *p_tgec)
+{
+	int err;
+
+	pr_info("Applying 10G TX ECC workaround (10GMAC-A004) ... ");
+
+	/* enable and set promiscuous */
+	fman_tgec_enable(p_tgec->p_mem_map, true, true);
+	fman_tgec_set_promiscuous(p_tgec->p_mem_map, true);
+	err =
+	    fm_10g_tx_ecc_workaround(p_tgec->fm_mac_ctrl_drv.h_fm,
+				     p_tgec->mac_id);
+	/* disable */
+	fman_tgec_set_promiscuous(p_tgec->p_mem_map, false);
+	fman_tgec_enable(p_tgec->p_mem_map, false, false);
+	fman_tgec_reset_stat(p_tgec->p_mem_map);
+	fman_tgec_ack_event(p_tgec->p_mem_map, 0xffffffff);
+
+	if (err)
+		pr_err("FAILED!\n");
+	else
+		pr_info("done.\n");
+
+	return err;
+}
+#endif /* FM_TX_ECC_FRMS_ERRATA_10GMAC_A004 */
+
+/* FM Init&Free API */
+
+static int tgec_init(void *h_tgec)
+{
+	struct tgec_t *p_tgec = (struct tgec_t *)h_tgec;
+	struct tgec_cfg *p_tgec_drv_param;
+	enet_addr_t eth_addr;
+	int err, ret, ret_err;
+
+	ret = is_init_done(p_tgec->p_tgec_drv_param);
+	if (!ret)
+		return -ENOSYS;
+
+	fm_get_revision(p_tgec->fm_mac_ctrl_drv.h_fm,
+			&p_tgec->fm_mac_ctrl_drv.fm_rev_info);
+	ret_err = check_init_parameters(p_tgec);
+	if (ret_err)
+		return ret_err;
+
+	p_tgec_drv_param = p_tgec->p_tgec_drv_param;
+
+	MAKE_ENET_ADDR_FROM_UINT64(p_tgec->addr, eth_addr);
+	fman_tgec_set_mac_address(p_tgec->p_mem_map, (uint8_t *)eth_addr);
+
+	/* interrupts */
+#ifdef FM_10G_REM_N_LCL_FLT_EX_10GMAC_ERRATA_SW005
+	{
+		if (p_tgec->fm_mac_ctrl_drv.fm_rev_info.major_rev <= 2)
+			p_tgec->exceptions &=
+			    ~(TGEC_IMASK_REM_FAULT | TGEC_IMASK_LOC_FAULT);
+	}
+#endif /* FM_10G_REM_N_LCL_FLT_EX_10GMAC_ERRATA_SW005 */
+
+#ifdef FM_TX_ECC_FRMS_ERRATA_10GMAC_A004
+	if (!p_tgec->p_tgec_drv_param->skip_fman11_workaround) {
+		err = tgec_tx_ecc_workaround(p_tgec);
+		if (err != 0) {
+			free_init_resources(p_tgec);
+			pr_warn("tgec_tx_ecc_workaround failed\n");
+		}
+	}
+#endif /* FM_TX_ECC_FRMS_ERRATA_10GMAC_A004 */
+
+	err =
+	    fman_tgec_init(p_tgec->p_mem_map, p_tgec_drv_param,
+			   p_tgec->exceptions);
+	if (err) {
+		free_init_resources(p_tgec);
+		pr_err("TGEC version doesn't support this i/f mode\n");
+		return err;
+	}
+
+	/* Max Frame Length */
+	err = fm_set_mac_max_frame(p_tgec->fm_mac_ctrl_drv.h_fm,
+				   FM_MAC_10G,
+				   p_tgec->fm_mac_ctrl_drv.mac_id,
+				   p_tgec_drv_param->max_frame_length);
+	if (err) {
+		pr_err("Setting max frame length FAILED\n");
+		free_init_resources(p_tgec);
+		return -EINVAL;
+	}
+
+#ifdef FM_TX_FIFO_CORRUPTION_ERRATA_10GMAC_A007
+	if (p_tgec->fm_mac_ctrl_drv.fm_rev_info.major_rev == 2)
+		fman_tgec_set_erratum_tx_fifo_corruption_10gmac_a007(p_tgec->
+								     p_mem_map);
+#endif /* FM_TX_FIFO_CORRUPTION_ERRATA_10GMAC_A007 */
+
+	p_tgec->p_multicast_addr_hash = alloc_hash_table(HASH_TABLE_SIZE);
+	if (!p_tgec->p_multicast_addr_hash) {
+		free_init_resources(p_tgec);
+		pr_err("allocation hash table is FAILED\n");
+		return -ENOMEM;
+	}
+
+	p_tgec->p_unicast_addr_hash = alloc_hash_table(HASH_TABLE_SIZE);
+	if (!p_tgec->p_unicast_addr_hash) {
+		free_init_resources(p_tgec);
+		pr_err("allocation hash table is FAILED\n");
+		return -ENOMEM;
+	}
+
+	fm_register_intr(p_tgec->fm_mac_ctrl_drv.h_fm,
+			 FM_MOD_MAC,
+			 p_tgec->mac_id,
+			 FM_INTR_TYPE_ERR, tgec_err_exception, p_tgec);
+
+	kfree(p_tgec_drv_param);
+	p_tgec->p_tgec_drv_param = NULL;
+
+	return 0;
+}
+
+static int tgec_free(void *h_tgec)
+{
+	struct tgec_t *p_tgec = (struct tgec_t *)h_tgec;
+
+	free_init_resources(p_tgec);
+
+	if (p_tgec->p_tgec_drv_param)
+		p_tgec->p_tgec_drv_param = NULL;
+
+	kfree(p_tgec->p_tgec_drv_param);
+	kfree(p_tgec);
+
+	return 0;
+}
+
+static void init_fm_mac_ctrl_drv(struct fm_mac_ctrl_drv_t *
+					  p_fm_mac_ctrl_drv)
+{
+	p_fm_mac_ctrl_drv->f_fm_mac_init = tgec_init;
+	p_fm_mac_ctrl_drv->f_fm_mac_free = tgec_free;
+
+	p_fm_mac_ctrl_drv->f_fm_mac_set_statistics = NULL;
+	p_fm_mac_ctrl_drv->f_fm_mac_cfg_lb = tgec_cfg_lb;
+	p_fm_mac_ctrl_drv->f_fm_mac_cfg_max_frame_len = tgec_cfg_max_frame_len;
+
+	p_fm_mac_ctrl_drv->f_fm_mac_cfg_wan = tgec_cfg_wan;
+	/* tgec always works with pad+crc */
+	p_fm_mac_ctrl_drv->f_fm_mac_cfg_pad_and_crc = NULL;
+	/* half-duplex is not supported in xgec */
+	p_fm_mac_ctrl_drv->f_fm_mac_cfg_half_duplex = NULL;
+	p_fm_mac_ctrl_drv->f_fm_mac_cfg_len_check = tgec_cfg_len_check;
+	p_fm_mac_ctrl_drv->f_fm_mac_cfg_exception = tgec_cfg_exception;
+	p_fm_mac_ctrl_drv->f_fm_mac_cfg_reset_on_init = NULL;
+
+#ifdef FM_TX_ECC_FRMS_ERRATA_10GMAC_A004
+	p_fm_mac_ctrl_drv->f_fm_mac_cfg_skip_fman11_wa =
+	    tgec_cfg_skip_fman11_wa;
+#endif /* FM_TX_ECC_FRMS_ERRATA_10GMAC_A004 */
+
+	p_fm_mac_ctrl_drv->f_fm_mac_set_exception = tgec_set_excpetion;
+
+	p_fm_mac_ctrl_drv->f_fm_mac_enable_1588_ts = tgec_enable_1588_ts;
+	p_fm_mac_ctrl_drv->f_fm_mac_disable_1588_ts = tgec_disable_1588_ts;
+
+	p_fm_mac_ctrl_drv->f_fm_mac_set_promiscuous = tgec_set_promiscuous;
+	p_fm_mac_ctrl_drv->f_fm_mac_adjust_link = NULL;
+	p_fm_mac_ctrl_drv->f_fm_mac_set_wake_on_lan = NULL;
+	p_fm_mac_ctrl_drv->f_fm_mac_restart_autoneg = NULL;
+
+	p_fm_mac_ctrl_drv->f_fm_mac_enable = tgec_enable;
+	p_fm_mac_ctrl_drv->f_fm_mac_disable = tgec_disable;
+
+	p_fm_mac_ctrl_drv->f_fm_mac_set_tx_auto_pause_frames =
+	tgec_tx_mac_pause;
+	p_fm_mac_ctrl_drv->f_fm_mac_set_tx_pause_frames =
+	    tgec_set_tx_pause_frames;
+	p_fm_mac_ctrl_drv->f_fm_mac_set_rx_ignore_pause_frames =
+	    tgec_rx_ignore_mac_pause;
+
+	p_fm_mac_ctrl_drv->f_fm_mac_reset_counters = tgec_reset_counters;
+	p_fm_mac_ctrl_drv->f_fm_mac_get_statistics = tgec_get_statistics;
+
+	p_fm_mac_ctrl_drv->f_fm_mac_modify_mac_addr = tgec_modify_mac_address;
+	p_fm_mac_ctrl_drv->f_fm_mac_add_hash_mac_addr =
+	    tgec_add_hash_mac_address;
+	p_fm_mac_ctrl_drv->f_fm_mac_remove_hash_mac_addr =
+	    tgec_del_hash_mac_address;
+	p_fm_mac_ctrl_drv->f_fm_mac_add_exact_match_mac_addr =
+	    tgec_add_exact_match_mac_address;
+	p_fm_mac_ctrl_drv->f_fm_mac_removel_exact_match_mac_addr =
+	    tgec_del_exact_match_mac_address;
+	p_fm_mac_ctrl_drv->f_fm_mac_get_id = tgec_get_id;
+	p_fm_mac_ctrl_drv->f_fm_mac_get_version = tgec_get_version;
+	p_fm_mac_ctrl_drv->f_fm_mac_get_max_frame_length =
+	    tgec_get_max_frame_length;
+}
+
+/*  tgec config  main entry */
+
+void *tgec_config(struct fm_mac_params_t *p_fm_mac_param)
+{
+	struct tgec_t *p_tgec;
+	struct tgec_cfg *p_tgec_drv_param;
+	uintptr_t base_addr;
+
+	base_addr = p_fm_mac_param->base_addr;
+	/* allocate memory for the UCC GETH data structure. */
+	p_tgec = kzalloc(sizeof(*p_tgec), GFP_KERNEL);
+	if (!p_tgec)
+		return NULL;
+
+	init_fm_mac_ctrl_drv(&p_tgec->fm_mac_ctrl_drv);
+
+	/* allocate memory for the 10G MAC driver parameters data structure. */
+	p_tgec_drv_param = kzalloc(sizeof(*p_tgec_drv_param), GFP_KERNEL);
+	if (!p_tgec_drv_param) {
+		tgec_free(p_tgec);
+		return NULL;
+	}
+
+	/* Plant parameter structure pointer */
+	p_tgec->p_tgec_drv_param = p_tgec_drv_param;
+
+	fman_tgec_defconfig(p_tgec_drv_param);
+
+	p_tgec->p_mem_map = (struct tgec_regs __iomem *)UINT_TO_PTR(base_addr);
+	p_tgec->p_mii_mem_map = (struct tgec_mii_access_mem_map_t *)
+		UINT_TO_PTR(base_addr + TGEC_TO_MII_OFFSET);
+	p_tgec->addr = ENET_ADDR_TO_UINT64(p_fm_mac_param->addr);
+	p_tgec->enet_mode = p_fm_mac_param->enet_mode;
+	p_tgec->mac_id = p_fm_mac_param->mac_id;
+	p_tgec->exceptions = DEFAULT_exceptions;
+	p_tgec->f_exception = p_fm_mac_param->f_exception;
+	p_tgec->f_event = p_fm_mac_param->f_event;
+	p_tgec->h_app = p_fm_mac_param->h_app;
+
+	return p_tgec;
+}
diff --git a/drivers/soc/fsl/fman/mac/tgec.h b/drivers/soc/fsl/fman/mac/tgec.h
new file mode 100644
index 0000000..f839250
--- /dev/null
+++ b/drivers/soc/fsl/fman/mac/tgec.h
@@ -0,0 +1,112 @@
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
+/* TGEC MAC ... */
+#ifndef __TGEC_H
+#define __TGEC_H
+
+#include "service.h"
+#include "enet_ext.h"
+
+#include "tgec_mii_acc.h"
+#include "fm_mac.h"
+
+#define DEFAULT_exceptions\
+	((uint32_t)(TGEC_IMASK_MDIO_SCAN_EVENT     |\
+		TGEC_IMASK_REM_FAULT           |\
+		TGEC_IMASK_LOC_FAULT           |\
+		TGEC_IMASK_TX_ECC_ER           |\
+		TGEC_IMASK_TX_FIFO_UNFL        |\
+		TGEC_IMASK_TX_FIFO_OVFL        |\
+		TGEC_IMASK_TX_ER               |\
+		TGEC_IMASK_RX_FIFO_OVFL        |\
+		TGEC_IMASK_RX_ECC_ER           |\
+		TGEC_IMASK_RX_JAB_FRM          |\
+		TGEC_IMASK_RX_OVRSZ_FRM        |\
+		TGEC_IMASK_RX_RUNT_FRM         |\
+		TGEC_IMASK_RX_FRAG_FRM         |\
+		TGEC_IMASK_RX_CRC_ER           |\
+		TGEC_IMASK_RX_ALIGN_ER))
+
+#define MAX_PACKET_ALIGNMENT        31
+#define MAX_INTER_PACKET_GAP        0x7f
+#define MAX_INTER_PALTERNATE_BEB    0x0f
+#define MAX_RETRANSMISSION          0x0f
+#define MAX_COLLISION_WINDOW        0x03ff
+
+/* number of pattern match registers (entries) */
+#define TGEC_NUM_OF_PADDRS          1
+
+/* Group address bit indication */
+#define GROUP_ADDRESS               0x0000010000000000LL
+
+#define HASH_TABLE_SIZE             512	/* Hash table size (= 32 bits*8 regs)*/
+
+/* Offset from the MEM map to the MDIO mem map */
+#define TGEC_TO_MII_OFFSET          0x1030
+
+struct tgec_t {
+	/* Upper Mac control block */
+	struct fm_mac_ctrl_drv_t fm_mac_ctrl_drv;
+	/* Handle to the upper layer application  */
+	void *h_app;
+	/* pointer to 10G memory mapped registers. */
+	struct tgec_regs __iomem *p_mem_map;
+	/* pointer to MII memory mapped registers. */
+	struct tgec_mii_access_mem_map_t *p_mii_mem_map;
+	/* MAC address of device; */
+	uint64_t addr;
+	/* Ethernet physical interface  */
+	enum e_enet_mode enet_mode;
+	fm_mac_exception_cb *f_exception;
+	fm_mac_exception_cb *f_event;
+	/* Whether a particular individual address recognition
+	 * register is being used
+	 */
+	bool ind_addr_reg_used[TGEC_NUM_OF_PADDRS];
+	/* MAC address for particular individual address
+	 * recognition register
+	 */
+	uint64_t paddr[TGEC_NUM_OF_PADDRS];
+	/* Number of individual addresses in registers for this station. */
+	uint8_t num_of_ind_addr_in_regs;
+	/* pointer to driver's global address hash table  */
+	struct eth_hash_t *p_multicast_addr_hash;
+	/* pointer to driver's individual address hash table  */
+	struct eth_hash_t *p_unicast_addr_hash;
+	bool debug_mode;
+	uint8_t mac_id;
+	uint32_t exceptions;
+	struct tgec_cfg *p_tgec_drv_param;
+};
+
+#endif /* __TGEC_H */
diff --git a/drivers/soc/fsl/fman/mac/tgec_mii_acc.h b/drivers/soc/fsl/fman/mac/tgec_mii_acc.h
new file mode 100644
index 0000000..4ea9b35
--- /dev/null
+++ b/drivers/soc/fsl/fman/mac/tgec_mii_acc.h
@@ -0,0 +1,66 @@
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
+#ifndef __TGEC_MII_ACC_H
+#define __TGEC_MII_ACC_H
+
+#include "service.h"
+
+/* MII  Management Command Register */
+#define MIIMCOM_READ_POST_INCREMENT 0x00004000
+#define MIIMCOM_READ_CYCLE          0x00008000
+#define MIIMCOM_SCAN_CYCLE          0x00000800
+#define MIIMCOM_PREAMBLE_DISABLE    0x00000400
+
+#define MIIMCOM_MDIO_HOLD_1_REG_CLK 0
+#define MIIMCOM_MDIO_HOLD_2_REG_CLK 1
+#define MIIMCOM_MDIO_HOLD_3_REG_CLK 2
+#define MIIMCOM_MDIO_HOLD_4_REG_CLK 3
+
+#define MIIMCOM_DIV_MASK            0x0000ff00
+#define MIIMCOM_DIV_SHIFT           8
+
+/* MII Management Indicator Register */
+#define MIIMIND_BUSY                0x00000001
+#define MIIMIND_READ_ERROR          0x00000002
+
+#define MIIDATA_BUSY                0x80000000
+
+/* MII Configuration Control Memory Map Registers     */
+struct tgec_mii_access_mem_map_t {
+	uint32_t mdio_cfg_status;	/* 0x030  */
+	uint32_t mdio_command;		/* 0x034  */
+	uint32_t mdio_data;		/* 0x038 */
+	uint32_t mdio_regaddr;		/* 0x03c */
+} __attribute__((__packed__));
+
+#endif /* __TGEC_MII_ACC_H */
-- 
1.7.9.5
