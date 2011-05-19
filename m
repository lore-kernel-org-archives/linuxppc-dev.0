Return-Path: <B04825@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BDE52B718E
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 20 May 2011 00:11:21 +1000 (EST)
From: Timur Tabi <timur@freescale.com>
To: <kumar.gala@freescale.com>, <benh@kernel.crashing.org>, <greg@kroah.com>,
	<akpm@kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <linux-console@vger.kernel.org>
Subject: [PATCH 4/7] powerpc: add Freescale hypervisor partition control
	functions
Date: Thu, 19 May 2011 08:54:29 -0500
Message-ID: <1305813272-31826-5-git-send-email-timur@freescale.com>
In-Reply-To: <1305813272-31826-1-git-send-email-timur@freescale.com>
References: <1305813272-31826-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add functions to restart and halt the current partition when running under
the Freescale hypervisor.  These functions should be assigned to various
function pointers of the ppc_md structure during the .probe() function for
the board:

	ppc_md.restart = fsl_hv_restart;
	ppc_md.power_off = fsl_hv_halt;
	ppc_md.halt = fsl_hv_halt;

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 arch/powerpc/sysdev/fsl_soc.c |   27 +++++++++++++++++++++++++++
 arch/powerpc/sysdev/fsl_soc.h |    3 +++
 2 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index 19e5015..265313e 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -41,6 +41,7 @@
 #include <sysdev/fsl_soc.h>
 #include <mm/mmu_decl.h>
 #include <asm/cpm2.h>
+#include <asm/fsl_hcalls.h>	/* For the Freescale hypervisor */
 
 extern void init_fcc_ioports(struct fs_platform_info*);
 extern void init_fec_ioports(struct fs_platform_info*);
@@ -252,3 +253,29 @@ void fsl_rstcr_restart(char *cmd)
 struct platform_diu_data_ops diu_ops;
 EXPORT_SYMBOL(diu_ops);
 #endif
+
+/*
+ * Restart the current partition
+ *
+ * This function should be assigned to the ppc_md.restart function pointer,
+ * to initiate a partition restart when we're running under the Freescale
+ * hypervisor.
+ */
+void fsl_hv_restart(char *cmd)
+{
+	pr_info("hv restart\n");
+	fh_partition_restart(-1);
+}
+
+/*
+ * Halt the current partition
+ *
+ * This function should be assigned to the ppc_md.power_off and ppc_md.halt
+ * function pointers, to shut down the partition when we're running under
+ * the Freescale hypervisor.
+ */
+void fsl_hv_halt(void)
+{
+	pr_info("hv exit\n");
+	fh_partition_stop(-1);
+}
diff --git a/arch/powerpc/sysdev/fsl_soc.h b/arch/powerpc/sysdev/fsl_soc.h
index 5360948..2ece02b 100644
--- a/arch/powerpc/sysdev/fsl_soc.h
+++ b/arch/powerpc/sysdev/fsl_soc.h
@@ -36,5 +36,8 @@ struct platform_diu_data_ops {
 extern struct platform_diu_data_ops diu_ops;
 #endif
 
+void fsl_hv_restart(char *cmd);
+void fsl_hv_halt(void);
+
 #endif
 #endif
-- 
1.7.3.4
