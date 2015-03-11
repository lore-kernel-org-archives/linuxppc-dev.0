Return-Path: <Igal.Liberman@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bbn0106.outbound.protection.outlook.com [157.56.111.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C19D71A117A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2015 20:13:27 +1100 (AEDT)
From: Igal.Liberman <igal.liberman@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: [RFC,6/8] soc/fman: Add FMan SP support
Date: Wed, 11 Mar 2015 07:08:50 +0200
Message-ID: <1426050530-12673-1-git-send-email-igal.liberman@freescale.com>
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
 drivers/soc/fsl/fman/fm_sp_common.h |  112 +++++++++
 drivers/soc/fsl/fman/sp/Makefile    |    2 +-
 drivers/soc/fsl/fman/sp/fm_sp.c     |  429 +++++++++++++++++++++++++++++++++++
 3 files changed, 542 insertions(+), 1 deletion(-)
 create mode 100644 drivers/soc/fsl/fman/fm_sp_common.h
 create mode 100644 drivers/soc/fsl/fman/sp/fm_sp.c

diff --git a/drivers/soc/fsl/fman/fm_sp_common.h b/drivers/soc/fsl/fman/fm_sp_common.h
new file mode 100644
index 0000000..3809c24
--- /dev/null
+++ b/drivers/soc/fsl/fman/fm_sp_common.h
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
+/* FM SP  ... */
+#ifndef __FM_SP_COMMON_H
+#define __FM_SP_COMMON_H
+
+#include "service.h"
+#include "fm_ext.h"
+#include "fm_pcd_ext.h"
+#include "fsl_fman.h"
+
+/* defaults */
+#define DEFAULT_FM_SP_BUFFER_PREFIX_CONTENT_PRIV_DATA_SIZE      0
+#define DEFAULT_FM_SP_BUFFER_PREFIX_CONTENT_PRIV_PASS_PRS_RESULT     false
+#define DEFAULT_FM_SP_BUFFER_PREFIX_CONTEXT_PASS_TIME_STAMP     false
+#define DEFAULT_FM_SP_BUFFER_PREFIX_CONTEXT_ALL_OTHER_PCD_INFO   false
+#define DEFAULT_FM_SP_BUFFER_PREFIX_CONTEXT_DATA_ALIGN         64
+
+/* structure for defining internal context copying */
+struct fm_sp_int_context_data_copy_t {
+	/* < Offset in External buffer to which internal
+	 *  context is copied to (Rx) or taken from (Tx, Op).
+	 */
+	uint16_t ext_buf_offset;
+	/* Offset within internal context to copy from
+	 * (Rx) or to copy to (Tx, Op).
+	 */
+	uint8_t int_context_offset;
+	/* Internal offset size to be copied */
+	uint16_t size;
+};
+
+/*  struct for defining external buffer margins */
+struct fm_sp_buf_margins_t {
+	/* Number of bytes to be left at the beginning
+	 * of the external buffer (must be divisible by 16)
+	 */
+	uint16_t start_margins;
+	/* number of bytes to be left at the end
+	 * of the external buffer(must be divisible by 16)
+	 */
+	uint16_t end_margins;
+};
+
+struct fm_sp_buffer_offsets_t {
+	uint32_t data_offset;
+	uint32_t prs_result_offset;
+	uint32_t time_stamp_offset;
+	uint32_t hash_result_offset;
+	uint32_t pcd_info_offset;
+};
+
+int fm_sp_build_buffer_structure(struct fm_sp_int_context_data_copy_t
+				 *p_fm_port_int_context_data_copy,
+				 struct fm_buffer_prefix_content_t
+				 *p_buffer_prefix_content,
+				 struct fm_sp_buf_margins_t
+				 *p_fm_port_buf_margins,
+				 struct fm_sp_buffer_offsets_t
+				 *p_fm_port_buffer_offsets,
+				 uint8_t *internal_buf_offset);
+
+int fm_sp_check_int_context_params(struct fm_sp_int_context_data_copy_t *
+				   p_fm_sp_int_context_data_copy);
+int fm_sp_check_buf_pools_params(struct fm_ext_pools_t *p_fm_ext_pools,
+				 struct fm_backup_bm_pools_t
+				 *p_fm_backup_bm_pools,
+				 struct fm_buf_pool_depletion_t
+				 *p_fm_buf_pool_depletion,
+				 uint32_t max_num_of_ext_pools,
+				 uint32_t bm_max_num_of_pools);
+int fm_sp_check_buf_margins(struct fm_sp_buf_margins_t *p_fm_sp_buf_margins);
+void fm_sp_set_buf_pools_in_asc_order_of_buf_sizes(struct fm_ext_pools_t
+						   *p_fm_ext_pools,
+						   uint8_t *ordered_array,
+						   uint16_t *sizes_array);
+
+int fm_pcd_sp_alloc_profiles(void *h_fm_pcd,
+			     uint8_t port_id,
+			     uint16_t num_of_storage_profiles,
+			     uint16_t *base, uint8_t *log2_num);
+#endif /* __FM_SP_COMMON_H */
diff --git a/drivers/soc/fsl/fman/sp/Makefile b/drivers/soc/fsl/fman/sp/Makefile
index 97e89c9..2a324ae 100644
--- a/drivers/soc/fsl/fman/sp/Makefile
+++ b/drivers/soc/fsl/fman/sp/Makefile
@@ -1,3 +1,3 @@
 obj-$(CONFIG_FSL_FMAN)	+= fsl_fman_sp.o
 
-fsl_fman_sp-objs	:= fman_sp.o
+fsl_fman_sp-objs	:= fman_sp.o fm_sp.o
diff --git a/drivers/soc/fsl/fman/sp/fm_sp.c b/drivers/soc/fsl/fman/sp/fm_sp.c
new file mode 100644
index 0000000..5bba23c
--- /dev/null
+++ b/drivers/soc/fsl/fman/sp/fm_sp.c
@@ -0,0 +1,429 @@
+/*
+ * Copyright 2008 - 2015 Freescale Semiconductor Inc.
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
+/* FM PCD Storage profile  ... */
+
+#include "service.h"
+#include "net_ext.h"
+
+#include "fm_sp_common.h"
+#include "fm_common.h"
+#include "fsl_fman_sp.h"
+
+#include <linux/string.h>
+
+/* Inter-module API routines */
+
+void fm_sp_set_buf_pools_in_asc_order_of_buf_sizes(struct fm_ext_pools_t
+						   *p_fm_ext_pools,
+						   uint8_t *ordered_array,
+						   uint16_t *sizes_array)
+{
+	uint16_t buf_size = 0;
+	int i = 0, j = 0, k = 0;
+
+	/* First we copy the external buffers pools information
+	 * to an ordered local array
+	 */
+	for (i = 0; i < p_fm_ext_pools->num_of_pools_used; i++) {
+		/* get pool size */
+		buf_size = p_fm_ext_pools->ext_buf_pool[i].size;
+
+		/* keep sizes in an array according to poolId
+		 * for direct access
+		 */
+		sizes_array[p_fm_ext_pools->ext_buf_pool[i].id] = buf_size;
+
+		/* save poolId in an ordered array according to size */
+		for (j = 0; j <= i; j++) {
+			/* this is the next free place in the array */
+			if (j == i)
+				ordered_array[i] =
+				    p_fm_ext_pools->ext_buf_pool[i].id;
+			else {
+				/* find the right place for this poolId */
+				if (buf_size < sizes_array[ordered_array[j]]) {
+					/* move the pool_ids one place ahead
+					 * to make room for this poolId
+					 */
+					for (k = i; k > j; k--)
+						ordered_array[k] =
+						    ordered_array[k - 1];
+
+					/* now k==j, this is the place for
+					 * the new size
+					 */
+					ordered_array[k] =
+					    p_fm_ext_pools->ext_buf_pool[i].id;
+					break;
+				}
+			}
+		}
+	}
+}
+
+int fm_sp_check_buf_pools_params(struct fm_ext_pools_t *p_fm_ext_pools,
+				 struct fm_backup_bm_pools_t
+				 *p_fm_backup_bm_pools,
+				 struct fm_buf_pool_depletion_t
+				 *p_fm_buf_pool_depletion,
+				 uint32_t max_num_of_ext_pools,
+				 uint32_t bm_max_num_of_pools)
+{
+	int i = 0, j = 0;
+	bool found;
+	uint8_t count = 0;
+
+	if (p_fm_ext_pools) {
+		if (p_fm_ext_pools->num_of_pools_used > max_num_of_ext_pools) {
+			pr_err("num_of_pools_used can't be larger than %d\n",
+			       max_num_of_ext_pools);
+			return -EDOM;
+		}
+		for (i = 0; i < p_fm_ext_pools->num_of_pools_used; i++) {
+			if (p_fm_ext_pools->ext_buf_pool[i].id >=
+			    bm_max_num_of_pools) {
+				pr_err("ext_buf_pools.ext_buf_pool[%d].id can't be larger than %d\n",
+				       i, bm_max_num_of_pools);
+				return -EDOM;
+			}
+			if (!p_fm_ext_pools->ext_buf_pool[i].size) {
+				pr_err("ext_buf_pools.ext_buf_pool[%d].size is 0\n",
+				       i);
+				return -EDOM;
+			}
+		}
+	}
+	if (!p_fm_ext_pools && (p_fm_backup_bm_pools ||
+				p_fm_buf_pool_depletion)) {
+		pr_err("backupBmPools ot buf_pool_depletion can not be defined without external pools\n");
+		return -EDOM;
+	}
+	/* backup BM pools indication is valid only for some chip derivatives
+	 * (limited by the config routine)
+	 */
+	if (p_fm_backup_bm_pools) {
+		if (p_fm_backup_bm_pools->num_of_backup_pools >=
+		    p_fm_ext_pools->num_of_pools_used) {
+			pr_err("p_backup_bm_pools must be smaller than ext_buf_pools.num_of_pools_used\n");
+			return -EDOM;
+		}
+		found = false;
+		for (i = 0; i < p_fm_backup_bm_pools->
+		     num_of_backup_pools; i++) {
+			for (j = 0; j < p_fm_ext_pools->
+			     num_of_pools_used; j++) {
+				if (p_fm_backup_bm_pools->pool_ids[i] ==
+				    p_fm_ext_pools->ext_buf_pool[j].id) {
+					found = true;
+					break;
+				}
+			}
+			if (!found) {
+				pr_err("All p_backup_bm_pools.pool_ids must be included in ext_buf_pools.ext_buf_pool[n].id\n");
+				return -EDOM;
+			}
+			found = false;
+		}
+	}
+
+	/* up to ext_buf_pools.num_of_pools_used pools may be defined */
+	if (p_fm_buf_pool_depletion && p_fm_buf_pool_depletion->
+	    pools_grp_mode_enable) {
+		if ((p_fm_buf_pool_depletion->num_of_pools >
+		     p_fm_ext_pools->num_of_pools_used)) {
+			pr_err("buf_pool_depletion.num_of_pools can't be larger than %d and can't be larger than num_of_pools_used\n",
+			       max_num_of_ext_pools);
+			return -EDOM;
+		}
+		if (!p_fm_buf_pool_depletion->num_of_pools) {
+			pr_err("buf_pool_depletion.num_of_pools_to_consider can not be 0 when pools_grp_mode_enable=true\n");
+			return -EDOM;
+		}
+		found = false;
+		count = 0;
+		/* for each pool that is in pools_to_consider, check if it
+		 * is defined in ext_buf_pool
+		 */
+		for (i = 0; i < bm_max_num_of_pools; i++) {
+			if (p_fm_buf_pool_depletion->pools_to_consider[i]) {
+				for (j = 0; j < p_fm_ext_pools->
+				     num_of_pools_used; j++) {
+					if (i == p_fm_ext_pools->
+					    ext_buf_pool[j].id) {
+						found = true;
+						count++;
+						break;
+					}
+				}
+				if (!found) {
+					pr_err("Pools selected for depletion are not used.\n");
+					return -ENOSYS;
+				}
+				found = false;
+			}
+		}
+		/* check that the number of pools that we have checked is
+		 * equal to the number announced by the user
+		 */
+		if (count != p_fm_buf_pool_depletion->num_of_pools) {
+			pr_err("buf_pool_depletion.num_of_pools is larger than the number of pools defined.\n");
+			return -EDOM;
+		}
+	}
+
+	if (p_fm_buf_pool_depletion && p_fm_buf_pool_depletion->
+	    single_pool_mode_enable) {
+		/* calculate vector for number of pools depletion */
+		found = false;
+		count = 0;
+		for (i = 0; i < bm_max_num_of_pools; i++) {
+			if (p_fm_buf_pool_depletion->
+			    pools_to_consider_for_single_mode[i]) {
+				for (j = 0; j < p_fm_ext_pools->
+				     num_of_pools_used;
+				     j++) {
+					if (i == p_fm_ext_pools->
+					    ext_buf_pool[j].id) {
+						found = true;
+						count++;
+						break;
+					}
+				}
+				if (!found) {
+					pr_err("Pools selected for depletion are not used.\n");
+					return -ENOSYS;
+				}
+				found = false;
+			}
+		}
+		if (!count) {
+			pr_err("No pools defined for single buffer mode pool depletion.\n");
+			return -EDOM;
+		}
+	}
+
+	return 0;
+}
+
+int fm_sp_check_int_context_params(struct fm_sp_int_context_data_copy_t *
+				  p_fm_sp_int_context_data_copy)
+{
+	/* Check that divisible by 16 and not larger than 240 */
+	if (p_fm_sp_int_context_data_copy->int_context_offset >
+	    MAX_INT_OFFSET) {
+		pr_err("int_context.int_context_offset can't be larger than %d\n",
+		       MAX_INT_OFFSET);
+		return -EDOM;
+	}
+	if (p_fm_sp_int_context_data_copy->int_context_offset %
+	      OFFSET_UNITS) {
+		pr_err("int_context.int_context_offset has to be divisible by %d\n",
+		       OFFSET_UNITS);
+		return -EDOM;
+
+	/* check that ic size+ic internal offset, does not exceed
+	 * ic block size
+	 */
+	}
+	if (p_fm_sp_int_context_data_copy->size +
+	      p_fm_sp_int_context_data_copy->int_context_offset >
+	      MAX_IC_SIZE) {
+		pr_err("int_context.size + int_context.int_context_offset has to be smaller than %d\n",
+		       MAX_IC_SIZE);
+		return -EDOM;
+	/* Check that divisible by 16 and not larger than 256 */
+	}
+	if (p_fm_sp_int_context_data_copy->size % OFFSET_UNITS) {
+		pr_err("int_context.size  has to be divisible by %d\n",
+		       OFFSET_UNITS);
+		return -EDOM;
+
+	/* Check that divisible by 16 and not larger than 4K */
+	}
+	if (p_fm_sp_int_context_data_copy->ext_buf_offset > MAX_EXT_OFFSET) {
+		pr_err("int_context.ext_buf_offset can't be larger than %d\n",
+		       MAX_EXT_OFFSET);
+		return -EDOM;
+	}
+	if (p_fm_sp_int_context_data_copy->ext_buf_offset % OFFSET_UNITS) {
+		pr_err("int_context.ext_buf_offset has to be divisible by %d\n",
+		       OFFSET_UNITS);
+		return -EDOM;
+	}
+	return 0;
+}
+
+int fm_sp_check_buf_margins(struct fm_sp_buf_margins_t
+				*p_fm_sp_buf_margins)
+{
+	/* Check the margin definition */
+	if (p_fm_sp_buf_margins->start_margins > MAX_EXT_BUFFER_OFFSET) {
+		pr_err("buf_margins.start_margins can't be larger than %d\n",
+		       MAX_EXT_BUFFER_OFFSET);
+		return -EDOM;
+	}
+	if (p_fm_sp_buf_margins->end_margins > MAX_EXT_BUFFER_OFFSET) {
+		pr_err("buf_margins.end_margins can't be larger than %d\n",
+		       MAX_EXT_BUFFER_OFFSET);
+		return -EDOM;
+	}
+	return 0;
+}
+
+int fm_sp_build_buffer_structure(struct fm_sp_int_context_data_copy_t *
+				 p_fm_sp_int_context_data_copy,
+				 struct fm_buffer_prefix_content_t *
+				 p_buffer_prefix_content,
+				 struct fm_sp_buf_margins_t
+				 *p_fm_sp_buf_margins,
+				 struct fm_sp_buffer_offsets_t
+				 *p_fm_sp_buffer_offsets,
+				 uint8_t *internal_buf_offset)
+{
+	uint32_t tmp;
+
+	/* Align start of internal context data to 16 byte */
+	p_fm_sp_int_context_data_copy->ext_buf_offset = (uint16_t)
+		((p_buffer_prefix_content->priv_data_size &
+			(OFFSET_UNITS - 1)) ?
+		((p_buffer_prefix_content->priv_data_size + OFFSET_UNITS) &
+			~(uint16_t)(OFFSET_UNITS - 1)) :
+		p_buffer_prefix_content->priv_data_size);
+
+	/* Translate margin and int_context params to FM parameters */
+	/* Initialize with illegal value. Later we'll set legal values. */
+	p_fm_sp_buffer_offsets->prs_result_offset = (uint32_t)ILLEGAL_BASE;
+	p_fm_sp_buffer_offsets->time_stamp_offset = (uint32_t)ILLEGAL_BASE;
+	p_fm_sp_buffer_offsets->hash_result_offset = (uint32_t)ILLEGAL_BASE;
+	p_fm_sp_buffer_offsets->pcd_info_offset = (uint32_t)ILLEGAL_BASE;
+
+	/* Internally the driver supports 4 options
+	 * 1. prsResult/timestamp/hashResult selection (in fact 8 options,
+	 * but for simplicity we'll
+	 * relate to it as 1).
+	 * 2. All IC context (from AD) not including debug.
+	 */
+
+	/* This 'if' covers option 2. We copy from beginning of context. */
+	if (p_buffer_prefix_content->pass_all_other_pcd_info) {
+		/* must be aligned to 16 */
+		p_fm_sp_int_context_data_copy->size = 128;
+		/* Start copying data after 16 bytes (FD) from
+		 * the beginning of the internal context
+		 */
+		p_fm_sp_int_context_data_copy->int_context_offset = 16;
+
+		if (p_buffer_prefix_content->pass_all_other_pcd_info)
+			p_fm_sp_buffer_offsets->pcd_info_offset =
+			    p_fm_sp_int_context_data_copy->ext_buf_offset;
+		if (p_buffer_prefix_content->pass_prs_result)
+			p_fm_sp_buffer_offsets->prs_result_offset =
+			    (uint32_t)
+			    (p_fm_sp_int_context_data_copy->ext_buf_offset +
+			     16);
+		if (p_buffer_prefix_content->pass_time_stamp)
+			p_fm_sp_buffer_offsets->time_stamp_offset =
+			    (uint32_t)
+			    (p_fm_sp_int_context_data_copy->ext_buf_offset +
+			     48);
+		if (p_buffer_prefix_content->pass_hash_result)
+			p_fm_sp_buffer_offsets->hash_result_offset =
+			    (uint32_t)
+			    (p_fm_sp_int_context_data_copy->ext_buf_offset +
+			     56);
+	} else {
+		/* This case covers the options under 1 */
+		/* Copy size must be in 16-byte granularity. */
+		p_fm_sp_int_context_data_copy->size =
+		    (uint16_t)((p_buffer_prefix_content->
+				 pass_prs_result ? 32 : 0) +
+				((p_buffer_prefix_content->pass_time_stamp ||
+				  p_buffer_prefix_content->
+				  pass_hash_result) ? 16 : 0));
+
+		/* Align start of internal context data to 16 byte */
+		p_fm_sp_int_context_data_copy->int_context_offset =
+		    (uint8_t)(p_buffer_prefix_content->pass_prs_result ? 32 :
+			       ((p_buffer_prefix_content->pass_time_stamp ||
+				 p_buffer_prefix_content->
+				 pass_hash_result) ? 64 : 0));
+
+		if (p_buffer_prefix_content->pass_prs_result)
+			p_fm_sp_buffer_offsets->prs_result_offset =
+			    p_fm_sp_int_context_data_copy->ext_buf_offset;
+		if (p_buffer_prefix_content->pass_time_stamp)
+			p_fm_sp_buffer_offsets->time_stamp_offset =
+			    p_buffer_prefix_content->
+			    pass_prs_result ? (p_fm_sp_int_context_data_copy->
+					     ext_buf_offset +
+					     sizeof(struct fm_prs_result_t)) :
+			    p_fm_sp_int_context_data_copy->ext_buf_offset;
+		if (p_buffer_prefix_content->pass_hash_result)
+			/* If PR is not requested, whether TS is
+			 * requested or not, IC will be copied from TS
+			 */
+			p_fm_sp_buffer_offsets->hash_result_offset =
+			    p_buffer_prefix_content->
+			    pass_prs_result ? (p_fm_sp_int_context_data_copy->
+					     ext_buf_offset +
+					     sizeof(struct fm_prs_result_t) +
+					     8) :
+					     p_fm_sp_int_context_data_copy->
+			    ext_buf_offset + 8;
+	}
+
+	if (p_fm_sp_int_context_data_copy->size)
+		p_fm_sp_buf_margins->start_margins =
+		    (uint16_t)(p_fm_sp_int_context_data_copy->ext_buf_offset +
+				p_fm_sp_int_context_data_copy->size);
+	else
+		/* No Internal Context passing, STartMargin is
+		 * immediately after private_info
+		 */
+		p_fm_sp_buf_margins->start_margins =
+		    p_buffer_prefix_content->priv_data_size;
+
+	/* align data start */
+	tmp =
+	    (uint32_t)(p_fm_sp_buf_margins->start_margins %
+			p_buffer_prefix_content->data_align);
+	if (tmp)
+		p_fm_sp_buf_margins->start_margins +=
+		    (p_buffer_prefix_content->data_align - tmp);
+	p_fm_sp_buffer_offsets->data_offset = p_fm_sp_buf_margins->
+					      start_margins;
+
+	return 0;
+}
+
+/* End of inter-module routines */
-- 
1.7.9.5
