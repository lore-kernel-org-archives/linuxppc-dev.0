Return-Path: <jochen@scram.de>
Received: from mail0.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail0.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 6FB0CDDEDE
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Nov 2007 04:25:05 +1100 (EST)
Message-ID: <4745BB5F.6060002@scram.de>
Date: Thu, 22 Nov 2007 18:24:47 +0100
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [RFC/PATCH] powerpc: Move CPM command handling into the cpm drivers
Content-Type: text/plain; charset=ISO-8859-15
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch moves the CPM command handling into commproc.c
for CPM1 and cpm2_common.c. This is yet another preparation
to get rid of drivers accessing the CPM via the global cpmp.

Signed-off-by: Jochen Friedrich <jochen@scram.de>
---
 arch/powerpc/sysdev/commproc.c          |   20 ++++++++++++++++++++
 arch/powerpc/sysdev/cpm2_common.c       |   17 +++++++++++++++++
 drivers/net/fs_enet/mac-fcc.c           |   10 +---------
 drivers/net/fs_enet/mac-scc.c           |   11 +----------
 drivers/serial/cpm_uart/cpm_uart_cpm1.c |    6 +-----
 drivers/serial/cpm_uart/cpm_uart_cpm2.c |    8 +-------
 include/asm-powerpc/cpm.h               |    1 +
 7 files changed, 42 insertions(+), 31 deletions(-)

diff --git a/arch/powerpc/sysdev/commproc.c b/arch/powerpc/sysdev/commproc.c
index f6a6378..2bddbde 100644
--- a/arch/powerpc/sysdev/commproc.c
+++ b/arch/powerpc/sysdev/commproc.c
@@ -240,6 +240,26 @@ void __init cpm_reset(void)
 #endif
 }

+#define MAX_CR_CMD_LOOPS        10000
+
+int cpm_command(u32 command, u8 opcode)
+{
+	int i;
+
+	if (command & 0xffffff0f)
+		return -EINVAL;
+
+	out_be16(&cpmp->cp_cpcr, command | CPM_CR_FLG | (opcode << 8));
+	for (i = 0; i < MAX_CR_CMD_LOOPS; i++)
+		if ((in_be16(&cpmp->cp_cpcr) & CPM_CR_FLG) == 0)
+			return 0;
+
+	printk(KERN_ERR "%s(): Not able to issue CPM command\n",
+		__FUNCTION__);
+	return -EIO;
+}
+EXPORT_SYMBOL(cpm_command);
+
 /* We used to do this earlier, but have to postpone as long as possible
  * to ensure the kernel VM is now running.
  */
diff --git a/arch/powerpc/sysdev/cpm2_common.c b/arch/powerpc/sysdev/cpm2_common.c
index 859362f..9e36b6b 100644
--- a/arch/powerpc/sysdev/cpm2_common.c
+++ b/arch/powerpc/sysdev/cpm2_common.c
@@ -83,6 +83,23 @@ cpm2_reset(void)
 	cpmp = &cpm2_immr->im_cpm;
 }

+#define MAX_CR_CMD_LOOPS        10000
+
+int cpm_command(u32 command, u8 opcode)
+{
+	int i;
+
+	out_be32(&cpmp->cp_cpcr, command | opcode | CPM_CR_FLG);
+	for (i = 0; i < MAX_CR_CMD_LOOPS; i++)
+		if ((in_be32(&cpmp->cp_cpcr) & CPM_CR_FLG) == 0)
+			return 0;
+
+	printk(KERN_ERR "%s(): Not able to issue CPM command\n",
+		__FUNCTION__);
+	return -EIO;
+}
+EXPORT_SYMBOL(cpm_command);
+
 /* Set a baud rate generator.  This needs lots of work.  There are
  * eight BRGs, which can be connected to the CPM channels or output
  * as clocks.  The BRGs are in two different block of internal
diff --git a/drivers/net/fs_enet/mac-fcc.c b/drivers/net/fs_enet/mac-fcc.c
index da4efbc..e363211 100644
--- a/drivers/net/fs_enet/mac-fcc.c
+++ b/drivers/net/fs_enet/mac-fcc.c
@@ -81,16 +81,8 @@
 static inline int fcc_cr_cmd(struct fs_enet_private *fep, u32 op)
 {
 	const struct fs_platform_info *fpi = fep->fpi;
-	int i;
-
-	W32(cpmp, cp_cpcr, fpi->cp_command | op | CPM_CR_FLG);
-	for (i = 0; i < MAX_CR_CMD_LOOPS; i++)
-		if ((R32(cpmp, cp_cpcr) & CPM_CR_FLG) == 0)
-			return 0;

-	printk(KERN_ERR "%s(): Not able to issue CPM command\n",
-	       __FUNCTION__);
-	return 1;
+	return cpm_command(fpi->cp_command, op);
 }

 static int do_pd_setup(struct fs_enet_private *fep)
diff --git a/drivers/net/fs_enet/mac-scc.c b/drivers/net/fs_enet/mac-scc.c
index 03134f4..5ff856d 100644
--- a/drivers/net/fs_enet/mac-scc.c
+++ b/drivers/net/fs_enet/mac-scc.c
@@ -89,21 +89,12 @@
  * Delay to wait for SCC reset command to complete (in us)
  */
 #define SCC_RESET_DELAY		50
-#define MAX_CR_CMD_LOOPS	10000

 static inline int scc_cr_cmd(struct fs_enet_private *fep, u32 op)
 {
 	const struct fs_platform_info *fpi = fep->fpi;
-	int i;
-
-	W16(cpmp, cp_cpcr, fpi->cp_command | CPM_CR_FLG | (op << 8));
-	for (i = 0; i < MAX_CR_CMD_LOOPS; i++)
-		if ((R16(cpmp, cp_cpcr) & CPM_CR_FLG) == 0)
-			return 0;

-	printk(KERN_ERR "%s(): Not able to issue CPM command\n",
-		__FUNCTION__);
-	return 1;
+	return cpm_command(fpi->cp_command, op);
 }

 static int do_pd_setup(struct fs_enet_private *fep)
diff --git a/drivers/serial/cpm_uart/cpm_uart_cpm1.c b/drivers/serial/cpm_uart/cpm_uart_cpm1.c
index 52fb044..6ea0366 100644
--- a/drivers/serial/cpm_uart/cpm_uart_cpm1.c
+++ b/drivers/serial/cpm_uart/cpm_uart_cpm1.c
@@ -52,11 +52,7 @@
 #ifdef CONFIG_PPC_CPM_NEW_BINDING
 void cpm_line_cr_cmd(struct uart_cpm_port *port, int cmd)
 {
-	u16 __iomem *cpcr = &cpmp->cp_cpcr;
-
-	out_be16(cpcr, port->command | (cmd << 8) | CPM_CR_FLG);
-	while (in_be16(cpcr) & CPM_CR_FLG)
-		;
+	cpm_command(port->command, cmd);
 }
 #else
 void cpm_line_cr_cmd(struct uart_cpm_port *port, int cmd)
diff --git a/drivers/serial/cpm_uart/cpm_uart_cpm2.c b/drivers/serial/cpm_uart/cpm_uart_cpm2.c
index 882dbc1..def0158 100644
--- a/drivers/serial/cpm_uart/cpm_uart_cpm2.c
+++ b/drivers/serial/cpm_uart/cpm_uart_cpm2.c
@@ -52,13 +52,7 @@
 #ifdef CONFIG_PPC_CPM_NEW_BINDING
 void cpm_line_cr_cmd(struct uart_cpm_port *port, int cmd)
 {
-	cpm_cpm2_t __iomem *cp = cpm2_map(im_cpm);
-
-	out_be32(&cp->cp_cpcr, port->command | cmd | CPM_CR_FLG);
-	while (in_be32(&cp->cp_cpcr) & CPM_CR_FLG)
-		;
-
-	cpm2_unmap(cp);
+	cpm_command(port->command, cmd);
 }
 #else
 void cpm_line_cr_cmd(struct uart_cpm_port *port, int cmd)
diff --git a/include/asm-powerpc/cpm.h b/include/asm-powerpc/cpm.h
index 48df9f3..fae83b1 100644
--- a/include/asm-powerpc/cpm.h
+++ b/include/asm-powerpc/cpm.h
@@ -10,5 +10,6 @@ int cpm_muram_free(unsigned long offset);
 unsigned long cpm_muram_alloc_fixed(unsigned long offset, unsigned long size);
 void __iomem *cpm_muram_addr(unsigned long offset);
 dma_addr_t cpm_muram_dma(void __iomem *addr);
+int cpm_command(u32 command, u8 opcode);

 #endif
-- 
1.5.3.4
