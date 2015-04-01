Return-Path: <Igal.Liberman@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0133.outbound.protection.outlook.com [207.46.100.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E560A1A0BE1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Apr 2015 02:39:10 +1100 (AEDT)
From: Igal.Liberman <igal.liberman@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: [RFC,v2,07/12] soc/fman: Add FMan MURAM support
Date: Wed, 1 Apr 2015 14:36:54 +0300
Message-ID: <1427888214-24311-1-git-send-email-igal.liberman@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com, Igal Liberman <Igal.Liberman@freescale.com>,
 madalin.bucur@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Igal Liberman <Igal.Liberman@freescale.com>

Add Frame Manager Multi-User RAM support.

Signed-off-by: Igal Liberman <Igal.Liberman@freescale.com>
---
 drivers/soc/fsl/fman/Kconfig            |    1 +
 drivers/soc/fsl/fman/Makefile           |    5 +-
 drivers/soc/fsl/fman/fm_muram.c         |  174 +++++++++++++++++++++++++++++++
 drivers/soc/fsl/fman/inc/fm_muram_ext.h |   98 +++++++++++++++++
 4 files changed, 276 insertions(+), 2 deletions(-)
 create mode 100644 drivers/soc/fsl/fman/fm_muram.c
 create mode 100644 drivers/soc/fsl/fman/inc/fm_muram_ext.h

diff --git a/drivers/soc/fsl/fman/Kconfig b/drivers/soc/fsl/fman/Kconfig
index af42c3a..58104e4 100644
--- a/drivers/soc/fsl/fman/Kconfig
+++ b/drivers/soc/fsl/fman/Kconfig
@@ -1,6 +1,7 @@
 config FSL_FMAN
 	bool "FMan support"
 	depends on FSL_SOC || COMPILE_TEST
+	select PPC_LIB_RHEAP
 	default n
 	help
 		Freescale Data-Path Acceleration Architecture Frame Manager
diff --git a/drivers/soc/fsl/fman/Makefile b/drivers/soc/fsl/fman/Makefile
index 5abd6c4..408c0cf 100644
--- a/drivers/soc/fsl/fman/Makefile
+++ b/drivers/soc/fsl/fman/Makefile
@@ -1,8 +1,9 @@
-subdir-ccflags-y += -I$(srctree)/drivers/soc/fsl/fman/flib
+subdir-ccflags-y += -I$(srctree)/drivers/soc/fsl/fman/flib \
+				     -I$(srctree)/drivers/soc/fsl/fman/inc
 
 obj-y		+= fsl_fman.o
 
-fsl_fman-objs			:= fman.o
+fsl_fman-objs	:= fman.o fm_muram.o
 
 obj-y	+= port/
 obj-y	+= mac/
diff --git a/drivers/soc/fsl/fman/fm_muram.c b/drivers/soc/fsl/fman/fm_muram.c
new file mode 100644
index 0000000..2a67a2e
--- /dev/null
+++ b/drivers/soc/fsl/fman/fm_muram.c
@@ -0,0 +1,174 @@
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
+/* FM MURAM ... */
+#include "fm_muram_ext.h"
+
+#include <linux/io.h>
+#include <linux/string.h>
+#include <linux/slab.h>
+
+struct muram_info {
+	rh_block_t	fm_boot_muram_rh_block[16];
+	rh_info_t	*fm_muram_info;
+	void __iomem *fm_muram_vbase;
+	/* Spinlock for MURAM accesses */
+	spinlock_t	fm_muram_lock;
+	uint64_t	size;
+};
+
+static void __iomem *fm_muram_addr(struct muram_info *p_muram,
+				   unsigned long offset)
+{
+	return p_muram->fm_muram_vbase + offset;
+}
+
+static unsigned long fm_muram_offset(struct muram_info *p_muram,
+				     void __iomem *addr)
+{
+	return addr - p_muram->fm_muram_vbase;
+}
+
+void fm_muram_clear(struct muram_info *p_muram)
+{
+	memset_io(p_muram->fm_muram_vbase, 0, p_muram->size);
+}
+
+struct muram_info *fm_muram_init(phys_addr_t base_address, uint64_t size)
+{
+	int ret;
+	struct muram_info *p_muram;
+
+	p_muram = kzalloc(sizeof(*p_muram), GFP_KERNEL);
+	if (!p_muram)
+		return NULL;
+	/* Create remote heap */
+	p_muram->fm_muram_info = rh_create(sizeof(unsigned int));
+
+	/* Spinlock for MURAM accesses */
+	spin_lock_init(&p_muram->fm_muram_lock);
+
+	/* Initialize the info header */
+	rh_init(p_muram->fm_muram_info, 1,
+		sizeof(p_muram->fm_boot_muram_rh_block) /
+		sizeof(p_muram->fm_boot_muram_rh_block[0]),
+		p_muram->fm_boot_muram_rh_block);
+
+	/* Attach region */
+	ret = rh_attach_region(p_muram->fm_muram_info,
+			       0,
+			       size);
+	if (ret) {
+		pr_err("Cannot attach region\n");
+		return NULL;
+	}
+
+	/* Save MURAM size */
+	p_muram->size = size;
+
+	/* ioremap physical address */
+	p_muram->fm_muram_vbase = ioremap(base_address, size);
+	if (!p_muram->fm_muram_vbase) {
+		pr_err("Cannot map FM MURAM\n");
+		return NULL;
+	}
+
+	return p_muram;
+}
+
+int fm_muram_free(struct muram_info *p_muram)
+{
+	/* Detach region */
+	rh_detach_region(p_muram->fm_muram_info, 0, (int)p_muram->size);
+	/* Destroy remote heap */
+	rh_destroy(p_muram->fm_muram_info);
+	/* Unmap memory */
+	iounmap(p_muram->fm_muram_vbase);
+	/* Free pointer */
+	kfree(p_muram);
+
+	return 0;
+}
+
+void __iomem *fm_muram_alloc(struct muram_info *p_muram, uint32_t size,
+			     uint32_t align)
+{
+	unsigned long start;
+	unsigned long flags;
+
+	spin_lock_irqsave(&p_muram->fm_muram_lock, flags);
+	p_muram->fm_muram_info->alignment = align;
+	start = rh_alloc(p_muram->fm_muram_info, size, "fman");
+
+	if (IS_ERR((void *)start)) {
+		pr_err("FM MURAM cannot allocate memory\n");
+		spin_unlock_irqrestore(&p_muram->fm_muram_lock, flags);
+		return NULL;
+	}
+
+	memset(fm_muram_addr(p_muram, start), 0, size);
+	spin_unlock_irqrestore(&p_muram->fm_muram_lock, flags);
+
+	return fm_muram_addr(p_muram, start);
+}
+
+void __iomem *fm_muram_alloc_fixed(struct muram_info *p_muram, uint32_t offset,
+				   uint32_t size)
+{
+	unsigned long start;
+	unsigned long flags;
+
+	spin_lock_irqsave(&p_muram->fm_muram_lock, flags);
+	p_muram->fm_muram_info->alignment = 1;
+	start = rh_alloc_fixed(p_muram->fm_muram_info, offset, size, "fman");
+
+	if (IS_ERR((void *)start)) {
+		spin_unlock_irqrestore(&p_muram->fm_muram_lock, flags);
+		return NULL;
+	}
+
+	memset(fm_muram_addr(p_muram, start), 0, size);
+	spin_unlock_irqrestore(&p_muram->fm_muram_lock, flags);
+
+	return fm_muram_addr(p_muram, start);
+}
+
+int fm_muram_free_mem(struct muram_info *p_muram, void __iomem *ptr)
+{
+	int ret;
+	unsigned long flags;
+
+	spin_lock_irqsave(&p_muram->fm_muram_lock, flags);
+	ret = rh_free(p_muram->fm_muram_info, fm_muram_offset(p_muram, ptr));
+	spin_unlock_irqrestore(&p_muram->fm_muram_lock, flags);
+	return ret;
+}
diff --git a/drivers/soc/fsl/fman/inc/fm_muram_ext.h b/drivers/soc/fsl/fman/inc/fm_muram_ext.h
new file mode 100644
index 0000000..57bb502
--- /dev/null
+++ b/drivers/soc/fsl/fman/inc/fm_muram_ext.h
@@ -0,0 +1,98 @@
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
+/* File          fm_muram_ext.h
+ * Description   FM MURAM Application Programming Interface.
+ */
+#ifndef __FM_MURAM_EXT
+#define __FM_MURAM_EXT
+
+#include "asm/rheap.h"
+
+/* Structure for FM MURAM information */
+struct muram_info;
+
+/* FM MURAM initialization API functions, definitions and enums */
+
+/* Function	fm_muram_init
+ * Description	Creates partition in the MURAM.
+ *		The routine returns a pointer to the MURAM partition.
+ *		This pointer must be passed as first parameter to all other
+ *		FM-MURAM function calls.
+ *		No actual initialization or configuration of FM_MURAM hardware
+ *		is done by this routine.
+ * Param[in]	base_address - Pointer to base of memory mapped FM-MURAM.
+ * Param[in]	size        - Size of the FM-MURAM partition.
+ * Return	pointer to FM-MURAM object, or NULL for Failure.
+ */
+struct muram_info *fm_muram_init(phys_addr_t base_address, uint64_t size);
+
+/*Function	fm_muram_free
+ *Description	Frees all resources that were assigned to FM-MURAM module.
+ *		Calling this routine invalidates the pointer.
+ *Param[in]	p_muram - FM-MURAM module pointer.
+ *Return	0 on success; Error code otherwise.
+ */
+int fm_muram_free(struct muram_info *p_muram);
+
+/* FM MURAM control API functions, definitions and enums */
+
+/*Function	fm_muram_alloc
+ *Description	Allocate some memory from FM-MURAM partition.
+ *Param[in]	p_muram   - FM-MURAM module pointer.
+ *Param[in]	size      - size of the memory to be allocated.
+ *Param[in]	align     - Alignment of the memory.
+ *Return	address of the allocated memory; NULL otherwise.
+ */
+void __iomem *fm_muram_alloc(struct muram_info *p_muram, uint32_t size,
+			     uint32_t align);
+
+/*Function	fm_muram_alloc_fixed
+ *Description	Allocate some specific memory from FM-MURAM partition (according
+ *		to base).
+ *Param[in]	p_muram    - FM-MURAM module pointer.
+ *Param[in]	offset     - the desired base-address to be allocated.
+ *Param[in]	size       - size of the memory to be allocated.
+ *Return	address of the allocated memory; NULL otherwise.
+ */
+void __iomem *fm_muram_alloc_fixed(struct muram_info *p_muram, uint32_t offset,
+				   uint32_t size);
+
+/*Function	fm_muram_free_mem
+ *Description	Free an allocated memory from FM-MURAM partition.
+ *Param[in]	p_muram   - FM-MURAM module pointer.
+ *Param[in]	ptr       - A pointer to an allocated memory.
+ *Return	0 on success; Error code otherwise.
+ */
+int fm_muram_free_mem(struct muram_info *p_muram, void __iomem *ptr);
+
+#endif /* __FM_MURAM_EXT */
-- 
1.7.9.5
