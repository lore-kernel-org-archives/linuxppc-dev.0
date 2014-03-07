Return-Path: <chenhui.zhao@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe002.messaging.microsoft.com [65.55.88.12])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2554C2C0349
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Mar 2014 15:58:36 +1100 (EST)
From: Chenhui Zhao <chenhui.zhao@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 5/9] powerpc/85xx: disable irq by hardware when suspend for
 64-bit
Date: Fri, 7 Mar 2014 12:58:01 +0800
Message-ID: <1394168285-32275-5-git-send-email-chenhui.zhao@freescale.com>
In-Reply-To: <1394168285-32275-1-git-send-email-chenhui.zhao@freescale.com>
References: <1394168285-32275-1-git-send-email-chenhui.zhao@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com, linux-kernel@vger.kernel.org,
 Jason.Jin@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In 64-bit mode, kernel just clears the irq soft-enable flag
in struct paca_struct to disable external irqs. But, in
the case of suspend, irqs should be disabled by hardware.
Therefore, hook a function to ppc_md.suspend_disable_irqs
to really disable irqs.

Signed-off-by: Chenhui Zhao <chenhui.zhao@freescale.com>
---
 arch/powerpc/platforms/85xx/corenet_generic.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc/platforms/85xx/corenet_generic.c
index 3fdf9f3..983d81f 100644
--- a/arch/powerpc/platforms/85xx/corenet_generic.c
+++ b/arch/powerpc/platforms/85xx/corenet_generic.c
@@ -32,6 +32,13 @@
 #include <sysdev/fsl_pci.h>
 #include "smp.h"
 
+#if defined(CONFIG_PPC64) && defined(CONFIG_SUSPEND)
+static void fsl_suspend_disable_irqs(void)
+{
+	__hard_irq_disable();
+}
+#endif
+
 void __init corenet_gen_pic_init(void)
 {
 	struct mpic *mpic;
@@ -58,6 +65,11 @@ void __init corenet_gen_setup_arch(void)
 
 	fsl_rcpm_init();
 
+#if defined(CONFIG_PPC64) && defined(CONFIG_SUSPEND)
+	/* physically disable irq for 64-bit mode when suspend */
+	ppc_md.suspend_disable_irqs = fsl_suspend_disable_irqs;
+#endif
+
 	pr_info("%s board from Freescale Semiconductor\n", ppc_md.name);
 }
 
-- 
1.7.3
