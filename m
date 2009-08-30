Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 896BCB7B61
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 31 Aug 2009 05:37:17 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id BF923DDD04
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Aug 2009 05:37:16 +1000 (EST)
Date: Sun, 30 Aug 2009 23:37:15 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 1/5] powerpc/qe: Make qe_reset() code path safe for
	repeated invocation
Message-ID: <20090830193715.GA17519@oksana.dev.rtsoft.ru>
References: <20090830193625.GA14693@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20090830193625.GA14693@oksana.dev.rtsoft.ru>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For MPC8569 CPUs we'll need to reset QE after each suspend, so make
qe_reset() code path suitable for repeated invocation, that is:

- Don't initialize rheap structures if already initialized;
- Don't allocate muram for SDMA if already allocated, just reinitialize
  registers with previously allocated muram offset;
- Remove __init attributes from qe_reset() and cpm_muram_init();

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/include/asm/qe.h    |    2 +-
 arch/powerpc/sysdev/cpm_common.c |    5 ++++-
 arch/powerpc/sysdev/qe_lib/qe.c  |   12 +++++++-----
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/qe.h b/arch/powerpc/include/asm/qe.h
index e8232bb..2f44754 100644
--- a/arch/powerpc/include/asm/qe.h
+++ b/arch/powerpc/include/asm/qe.h
@@ -87,7 +87,7 @@ extern spinlock_t cmxgcr_lock;
 
 /* Export QE common operations */
 #ifdef CONFIG_QUICC_ENGINE
-extern void __init qe_reset(void);
+extern void qe_reset(void);
 #else
 static inline void qe_reset(void) {}
 #endif
diff --git a/arch/powerpc/sysdev/cpm_common.c b/arch/powerpc/sysdev/cpm_common.c
index e4b6d66..9de72c9 100644
--- a/arch/powerpc/sysdev/cpm_common.c
+++ b/arch/powerpc/sysdev/cpm_common.c
@@ -72,7 +72,7 @@ static phys_addr_t muram_pbase;
 /* Max address size we deal with */
 #define OF_MAX_ADDR_CELLS	4
 
-int __init cpm_muram_init(void)
+int cpm_muram_init(void)
 {
 	struct device_node *np;
 	struct resource r;
@@ -81,6 +81,9 @@ int __init cpm_muram_init(void)
 	int i = 0;
 	int ret = 0;
 
+	if (muram_pbase)
+		return 0;
+
 	spin_lock_init(&cpm_muram_lock);
 	/* initialize the info header */
 	rh_init(&cpm_muram_info, 1,
diff --git a/arch/powerpc/sysdev/qe_lib/qe.c b/arch/powerpc/sysdev/qe_lib/qe.c
index b06564f..4eaf2a9 100644
--- a/arch/powerpc/sysdev/qe_lib/qe.c
+++ b/arch/powerpc/sysdev/qe_lib/qe.c
@@ -91,7 +91,7 @@ phys_addr_t get_qe_base(void)
 
 EXPORT_SYMBOL(get_qe_base);
 
-void __init qe_reset(void)
+void qe_reset(void)
 {
 	if (qe_immr == NULL)
 		qe_immr = ioremap(get_qe_base(), QE_IMMAP_SIZE);
@@ -317,16 +317,18 @@ EXPORT_SYMBOL(qe_put_snum);
 static int qe_sdma_init(void)
 {
 	struct sdma __iomem *sdma = &qe_immr->sdma;
-	unsigned long sdma_buf_offset;
+	static unsigned long sdma_buf_offset = (unsigned long)-ENOMEM;
 
 	if (!sdma)
 		return -ENODEV;
 
 	/* allocate 2 internal temporary buffers (512 bytes size each) for
 	 * the SDMA */
- 	sdma_buf_offset = qe_muram_alloc(512 * 2, 4096);
-	if (IS_ERR_VALUE(sdma_buf_offset))
-		return -ENOMEM;
+	if (IS_ERR_VALUE(sdma_buf_offset)) {
+		sdma_buf_offset = qe_muram_alloc(512 * 2, 4096);
+		if (IS_ERR_VALUE(sdma_buf_offset))
+			return -ENOMEM;
+	}
 
 	out_be32(&sdma->sdebcr, (u32) sdma_buf_offset & QE_SDEBCR_BA_MASK);
  	out_be32(&sdma->sdmr, (QE_SDMR_GLB_1_MSK |
-- 
1.6.3.3
