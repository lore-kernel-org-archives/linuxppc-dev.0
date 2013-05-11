Return-Path: <haokexin@gmail.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5CE722C0110
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 May 2013 09:26:41 +1000 (EST)
From: Kevin Hao <haokexin@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>
Subject: [PATCH 4/4] powerpc/fsl-book3e: enable the external_input_edge
 exception handler
Date: Sun, 12 May 2013 07:26:24 +0800
Message-ID: <1368314784-971-5-git-send-email-haokexin@gmail.com>
In-Reply-To: <1368314784-971-1-git-send-email-haokexin@gmail.com>
References: <1368314784-971-1-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>,
 linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Enable the external_input_edge exception handler for the fsl ppc64
board when external proxy is enabled. This will leave the irq still
hard enabled when a interrupt occurs with irq soft disabled.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 arch/powerpc/platforms/85xx/corenet_ds.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/85xx/corenet_ds.c b/arch/powerpc/platforms/85xx/corenet_ds.c
index c59c617..ad688bf 100644
--- a/arch/powerpc/platforms/85xx/corenet_ds.c
+++ b/arch/powerpc/platforms/85xx/corenet_ds.c
@@ -25,6 +25,9 @@
 #include <asm/prom.h>
 #include <asm/udbg.h>
 #include <asm/mpic.h>
+#ifdef CONFIG_PPC64
+#include <asm/code-patching.h>
+#endif
 
 #include <linux/of_platform.h>
 #include <sysdev/fsl_soc.h>
@@ -37,8 +40,12 @@ void __init corenet_ds_pic_init(void)
 	unsigned int flags = MPIC_BIG_ENDIAN | MPIC_SINGLE_DEST_CPU |
 		MPIC_NO_RESET;
 
-	if (ppc_md.get_irq == mpic_get_coreint_irq)
+	if (ppc_md.get_irq == mpic_get_coreint_irq) {
 		flags |= MPIC_ENABLE_COREINT;
+#ifdef CONFIG_PPC64
+		patch_exception(0x0a0, exc_external_input_edge_book3e);
+#endif
+	}
 
 	mpic = mpic_alloc(NULL, 0, flags, 0, 512, " OpenPIC  ");
 	BUG_ON(mpic == NULL);
-- 
1.8.1.4
