Return-Path: <chenhui.zhao@nxp.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0082.outbound.protection.outlook.com [207.46.100.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qmbNm3LDlzDqP7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Apr 2016 21:46:48 +1000 (AEST)
From: Chenhui Zhao <chenhui.zhao@nxp.com>
To: <linuxppc-dev@lists.ozlabs.org>, <oss@buserror.net>
CC: <jason.jin@nxp.com>, <chenhui.zhao@nxp.com>
Subject: [PATCH v2 5/5] powerpc/pm: save and restore registers during deep
 sleep
Date: Fri, 15 Apr 2016 19:13:17 +0800
Message-ID: <1460718797-21744-6-git-send-email-chenhui.zhao@nxp.com>
In-Reply-To: <1460718797-21744-1-git-send-email-chenhui.zhao@nxp.com>
References: <1460718797-21744-1-git-send-email-chenhui.zhao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some CCSR registers will lost during deep sleep. Therefore,
should save them before entering deep sleep, and restore them
when resuming from deep sleep.

Signed-off-by: Tang Yuantian <yuantian.tang@nxp.com>
Signed-off-by: Chenhui Zhao <chenhui.zhao@nxp.com>
---
 arch/powerpc/include/asm/fsl_pm.h       |   2 +
 arch/powerpc/platforms/85xx/deepsleep.c | 108 +++++++++++++++++++++++++++++++-
 2 files changed, 109 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/fsl_pm.h b/arch/powerpc/include/asm/fsl_pm.h
index 48c2631..95601fb 100644
--- a/arch/powerpc/include/asm/fsl_pm.h
+++ b/arch/powerpc/include/asm/fsl_pm.h
@@ -61,7 +61,9 @@ extern void fsl_dp_enter_low(void *priv);
 extern void fsl_booke_deep_sleep_resume(void);
 
 struct fsl_iomap {
+	void *ccsr_lcc_base;
 	void *ccsr_scfg_base;
+	void *ccsr_dcfg_base;
 	void *ccsr_rcpm_base;
 	void *ccsr_ddr_base;
 	void *ccsr_gpio1_base;
diff --git a/arch/powerpc/platforms/85xx/deepsleep.c b/arch/powerpc/platforms/85xx/deepsleep.c
index 347c588..26f3640 100644
--- a/arch/powerpc/platforms/85xx/deepsleep.c
+++ b/arch/powerpc/platforms/85xx/deepsleep.c
@@ -23,6 +23,8 @@
 
 #include "sleep_fsm.h"
 
+#define CCSR_LAW_OFFSET		0xC00
+
 #define CPC_CPCHDBCR0		0x0f00
 #define CPC_CPCHDBCR0_SPEC_DIS	0x08000000
 
@@ -42,6 +44,17 @@
 #define QORIQ_CPLD_MISCCSR		0x17
 #define QORIQ_CPLD_MISCCSR_SLEEPEN	0x40
 
+#define CCSR_LCC_BSTRH	0x20
+#define CCSR_LCC_BSTRL	0x24
+#define CCSR_LCC_BSTAR	0x28
+
+#define CCSR_DCFG_BRR	0xE4
+
+#define CCSR_RCPM_PCTBENR	0x1A0
+
+/* the target id for the memory complex 1 (MC1) */
+#define MC1_TRGT_ID		0x10
+
 /* 128 bytes buffer for restoring data broke by DDR training initialization */
 #define DDR_BUF_SIZE	128
 static u8 ddr_buff[DDR_BUF_SIZE] __aligned(64);
@@ -50,6 +63,23 @@ static void fsl_dp_iounmap(void);
 
 static struct fsl_iomap fsl_dp_priv;
 
+struct fsl_ccsr_law {
+	u32	lawbarh;	/* LAWn base address high */
+	u32	lawbarl;	/* LAWn base address low */
+	u32	lawar;		/* LAWn attributes */
+	u32	reserved;
+};
+
+static struct fsl_regs_buffer {
+	u32 bstrh;
+	u32 bstrl;
+	u32 bstar;
+	u32 brr;
+	u32 pctbenr;
+	u32 law_count;
+	void *law_regs;
+} fsl_dp_buffer;
+
 static const struct of_device_id fsl_dp_cpld_ids[] __initconst = {
 	{ .compatible = "fsl,t1024-cpld", },
 	{ .compatible = "fsl,t1040rdb-cpld", },
@@ -65,6 +95,60 @@ static const struct of_device_id fsl_dp_fpga_ids[] __initconst = {
 	{}
 };
 
+static void fsl_regs_save(struct fsl_iomap *base,
+			  struct fsl_regs_buffer *buffer)
+{
+	int i;
+	struct fsl_ccsr_law *src = base->ccsr_lcc_base + CCSR_LAW_OFFSET;
+	struct fsl_ccsr_law *dst = buffer->law_regs;
+
+	buffer->bstrh = in_be32(base->ccsr_lcc_base + CCSR_LCC_BSTRH);
+	buffer->bstrl = in_be32(base->ccsr_lcc_base + CCSR_LCC_BSTRL);
+	buffer->bstar = in_be32(base->ccsr_lcc_base + CCSR_LCC_BSTAR);
+	buffer->brr = in_be32(base->ccsr_dcfg_base + CCSR_DCFG_BRR);
+	buffer->pctbenr = in_be32(base->ccsr_rcpm_base + CCSR_RCPM_PCTBENR);
+
+	for (i = 0; i < buffer->law_count; i++) {
+		dst->lawbarh = in_be32(&src->lawbarh);
+		dst->lawbarl = in_be32(&src->lawbarl);
+		dst->lawar = in_be32(&src->lawar);
+		dst++;
+		src++;
+	}
+}
+
+static void fsl_regs_restore(struct fsl_iomap *base,
+			     struct fsl_regs_buffer *buffer)
+{
+	int i;
+	u32 attr;
+	struct fsl_ccsr_law *src = buffer->law_regs;
+	struct fsl_ccsr_law *dst = base->ccsr_lcc_base + CCSR_LAW_OFFSET;
+
+	out_be32(base->ccsr_lcc_base + CCSR_LCC_BSTRH, buffer->bstrh);
+	out_be32(base->ccsr_lcc_base + CCSR_LCC_BSTRL, buffer->bstrl);
+	out_be32(base->ccsr_lcc_base + CCSR_LCC_BSTAR, buffer->bstar);
+	out_be32(base->ccsr_dcfg_base + CCSR_DCFG_BRR, buffer->brr);
+	out_be32(base->ccsr_rcpm_base + CCSR_RCPM_PCTBENR, buffer->pctbenr);
+
+	for (i = 0; i < buffer->law_count; i++) {
+		/*
+		 * If the LAW with the target id of MC1 has been set,
+		 * skip. Because changing it here causes memory
+		 * access error.
+		 */
+		attr = in_be32(&dst->lawar);
+		if (((attr >> 20) & 0xff) == MC1_TRGT_ID)
+			continue;
+		out_be32(&dst->lawar, 0);
+		out_be32(&dst->lawbarl, src->lawbarl);
+		out_be32(&dst->lawbarh, src->lawbarh);
+		out_be32(&dst->lawar, src->lawar);
+		src++;
+		dst++;
+	}
+}
+
 static void fsl_dp_set_resume_pointer(void)
 {
 	u32 resume_addr;
@@ -133,6 +217,8 @@ int fsl_enter_deepsleep(void)
 
 	fsl_dp_set_resume_pointer();
 
+	fsl_regs_save(&fsl_dp_priv, &fsl_dp_buffer);
+
 	/*  enable Warm Device Reset request. */
 	setbits32(fsl_dp_priv.ccsr_scfg_base + CCSR_SCFG_DPSLPCR,
 					CCSR_SCFG_DPSLPCR_WDRR_EN);
@@ -153,6 +239,8 @@ int fsl_enter_deepsleep(void)
 
 	fsl_dp_enter_low(&fsl_dp_priv);
 
+	fsl_regs_restore(&fsl_dp_priv, &fsl_dp_buffer);
+
 	/* disable Warm Device Reset request */
 	clrbits32(fsl_dp_priv.ccsr_scfg_base + CCSR_SCFG_DPSLPCR,
 					CCSR_SCFG_DPSLPCR_WDRR_EN);
@@ -194,6 +282,11 @@ static int __init fsl_dp_iomap(void)
 			goto err;
 	}
 
+	fsl_dp_priv.ccsr_dcfg_base =
+			fsl_of_iomap("fsl,qoriq-device-config-2.0");
+	if (!fsl_dp_priv.ccsr_dcfg_base)
+		goto err;
+
 	fsl_dp_priv.ccsr_scfg_base = fsl_of_iomap("fsl,t1040-scfg");
 	if (!fsl_dp_priv.ccsr_scfg_base) {
 		fsl_dp_priv.ccsr_scfg_base = fsl_of_iomap("fsl,t1023-scfg");
@@ -234,8 +327,21 @@ static int __init fsl_dp_iomap(void)
 	if (!fsl_dp_priv.dcsr_rcpm_base)
 		goto err;
 
-	return 0;
+	fsl_dp_priv.ccsr_lcc_base = fsl_of_iomap("fsl,corenet-law");
+	if (!fsl_dp_priv.ccsr_lcc_base)
+		goto err;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,corenet-law");
+	if (of_property_read_u32(np, "fsl,num-laws",
+					&fsl_dp_buffer.law_count))
+		goto err;
 
+	fsl_dp_buffer.law_regs = kcalloc(fsl_dp_buffer.law_count,
+				sizeof(struct fsl_ccsr_law), GFP_KERNEL);
+	if (!fsl_dp_buffer.law_regs)
+		goto err;
+
+	return 0;
 err:
 	fsl_dp_iounmap();
 	return -1;
-- 
1.9.1
