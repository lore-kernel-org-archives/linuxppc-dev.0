Return-Path: <abounine@ott.idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D78B31A003D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Feb 2016 01:37:59 +1100 (AEDT)
From: Alexandre Bounine <alexandre.bounine@idt.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexandre Bounine <alexandre.bounine@idt.com>,
 Matt Porter <mporter@kernel.crashing.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Aurelien Jacquiot <a-jacquiot@ti.com>,
 Andre van Herk <andre.van.herk@prodrive-technologies.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/fsl_rio: update for port-write interface change
Date: Thu, 11 Feb 2016 09:37:41 -0500
Message-Id: <1455201461-598-1-git-send-email-alexandre.bounine@idt.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Platform-specific update following changes in port-write handler interface.

This is a follow-up patch for
    [PATCH 22/30] rapidio: add global inbound port write interfaces

Signed-off-by: Alexandre Bounine <alexandre.bounine@idt.com>
Cc: Matt Porter <mporter@kernel.crashing.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Aurelien Jacquiot <a-jacquiot@ti.com>
Cc: Andre van Herk <andre.van.herk@prodrive-technologies.com>
Cc: linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/sysdev/fsl_rio.c |    1 +
 arch/powerpc/sysdev/fsl_rio.h |    1 +
 arch/powerpc/sysdev/fsl_rmu.c |   16 ++++++++++------
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_rio.c b/arch/powerpc/sysdev/fsl_rio.c
index 385371a..f5bf38b9 100644
--- a/arch/powerpc/sysdev/fsl_rio.c
+++ b/arch/powerpc/sysdev/fsl_rio.c
@@ -726,6 +726,7 @@ int fsl_rio_setup(struct platform_device *dev)
 		fsl_rio_inbound_mem_init(priv);
 
 		dbell->mport[i] = port;
+		pw->mport[i] = port;
 
 		if (rio_register_mport(port)) {
 			release_resource(&port->iores);
diff --git a/arch/powerpc/sysdev/fsl_rio.h b/arch/powerpc/sysdev/fsl_rio.h
index d53407a..12dd18f 100644
--- a/arch/powerpc/sysdev/fsl_rio.h
+++ b/arch/powerpc/sysdev/fsl_rio.h
@@ -97,6 +97,7 @@ struct fsl_rio_dbell {
 };
 
 struct fsl_rio_pw {
+	struct rio_mport *mport[MAX_PORT_NUM];
 	struct device *dev;
 	struct rio_pw_regs __iomem *pw_regs;
 	struct rio_port_write_msg port_write_msg;
diff --git a/arch/powerpc/sysdev/fsl_rmu.c b/arch/powerpc/sysdev/fsl_rmu.c
index b48197a..176acfc 100644
--- a/arch/powerpc/sysdev/fsl_rmu.c
+++ b/arch/powerpc/sysdev/fsl_rmu.c
@@ -481,14 +481,14 @@ pw_done:
 static void fsl_pw_dpc(struct work_struct *work)
 {
 	struct fsl_rio_pw *pw = container_of(work, struct fsl_rio_pw, pw_work);
-	u32 msg_buffer[RIO_PW_MSG_SIZE/sizeof(u32)];
+	union rio_pw_msg msg_buffer;
+	int i;
 
 	/*
 	 * Process port-write messages
 	 */
-	while (kfifo_out_spinlocked(&pw->pw_fifo, (unsigned char *)msg_buffer,
+	while (kfifo_out_spinlocked(&pw->pw_fifo, (unsigned char *)&msg_buffer,
 			 RIO_PW_MSG_SIZE, &pw->pw_fifo_lock)) {
-		/* Process one message */
 #ifdef DEBUG_PW
 		{
 		u32 i;
@@ -496,15 +496,19 @@ static void fsl_pw_dpc(struct work_struct *work)
 		for (i = 0; i < RIO_PW_MSG_SIZE/sizeof(u32); i++) {
 			if ((i%4) == 0)
 				pr_debug("\n0x%02x: 0x%08x", i*4,
-					 msg_buffer[i]);
+					 msg_buffer.raw[i]);
 			else
-				pr_debug(" 0x%08x", msg_buffer[i]);
+				pr_debug(" 0x%08x", msg_buffer.raw[i]);
 		}
 		pr_debug("\n");
 		}
 #endif
 		/* Pass the port-write message to RIO core for processing */
-		rio_inb_pwrite_handler((union rio_pw_msg *)msg_buffer);
+		for (i = 0; i < MAX_PORT_NUM; i++) {
+			if (pw->mport[i])
+				rio_inb_pwrite_handler(pw->mport[i],
+						       &msg_buffer);
+		}
 	}
 }
 
-- 
1.7.8.4
