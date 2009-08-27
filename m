Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 44D3AB7DE1
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 28 Aug 2009 03:30:22 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id C7C4ADDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Aug 2009 03:30:21 +1000 (EST)
Date: Thu, 27 Aug 2009 21:30:17 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 2/5] powerpc/qe: Make qe_reset() code path safe for
	repeated invocation
Message-ID: <20090827173017.GB739@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/sysdev/cpm_common.c |    3 +++
 arch/powerpc/sysdev/qe_lib/qe.c  |   10 ++++++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/sysdev/cpm_common.c b/arch/powerpc/sysdev/cpm_common.c
index e4b6d66..ddfca52 100644
--- a/arch/powerpc/sysdev/cpm_common.c
+++ b/arch/powerpc/sysdev/cpm_common.c
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
index b06564f..f485d5a 100644
--- a/arch/powerpc/sysdev/qe_lib/qe.c
+++ b/arch/powerpc/sysdev/qe_lib/qe.c
@@ -317,16 +317,18 @@ EXPORT_SYMBOL(qe_put_snum);
 static int qe_sdma_init(void)
 {
 	struct sdma __iomem *sdma = &qe_immr->sdma;
-	unsigned long sdma_buf_offset;
+	static unsigned long sdma_buf_offset;
 
 	if (!sdma)
 		return -ENODEV;
 
 	/* allocate 2 internal temporary buffers (512 bytes size each) for
 	 * the SDMA */
- 	sdma_buf_offset = qe_muram_alloc(512 * 2, 4096);
-	if (IS_ERR_VALUE(sdma_buf_offset))
-		return -ENOMEM;
+	if (!sdma_buf_offset) {
+		sdma_buf_offset = qe_muram_alloc(512 * 2, 4096);
+		if (IS_ERR_VALUE(sdma_buf_offset))
+			return -ENOMEM;
+	}
 
 	out_be32(&sdma->sdebcr, (u32) sdma_buf_offset & QE_SDEBCR_BA_MASK);
  	out_be32(&sdma->sdmr, (QE_SDMR_GLB_1_MSK |
-- 
1.6.3.3
