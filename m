Return-Path: <mylinux@udp143655uds.ap.freescale.net>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 70B02B6F71
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Aug 2011 20:12:54 +1000 (EST)
From: Liu Gang <b34182@freescale.com>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] fsl-rio: Correct IECSR register clear value
Date: Mon, 8 Aug 2011 18:13:39 +0800
Message-ID: <1312798419-3912-1-git-send-email-b34182@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: r58472@freescale.com, Liu Gang <b34182@freescale.com>, r61911@freescale.com,
	Liu Gang <Gang.Liu@freescale.com>, akpm@linux-foundation.org,
	B11780@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The RETE bit in IECSR is cleared by writing a 1 to it.

Signed-off-by: Liu Gang <Gang.Liu@freescale.com>
---
 arch/powerpc/sysdev/fsl_rio.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_rio.c b/arch/powerpc/sysdev/fsl_rio.c
index b3fd081..cdd765b 100644
--- a/arch/powerpc/sysdev/fsl_rio.c
+++ b/arch/powerpc/sysdev/fsl_rio.c
@@ -54,6 +54,7 @@
 #define ODSR_CLEAR		0x1c00
 #define LTLEECSR_ENABLE_ALL	0xFFC000FC
 #define ESCSR_CLEAR		0x07120204
+#define IECSR_CLEAR		0x80000000
 
 #define RIO_PORT1_EDCSR		0x0640
 #define RIO_PORT2_EDCSR		0x0680
@@ -1089,11 +1090,11 @@ static void port_error_handler(struct rio_mport *port, int offset)
 
 	if (offset == 0) {
 		out_be32((u32 *)(rio_regs_win + RIO_PORT1_EDCSR), 0);
-		out_be32((u32 *)(rio_regs_win + RIO_PORT1_IECSR), 0);
+		out_be32((u32 *)(rio_regs_win + RIO_PORT1_IECSR), IECSR_CLEAR);
 		out_be32((u32 *)(rio_regs_win + RIO_ESCSR), ESCSR_CLEAR);
 	} else {
 		out_be32((u32 *)(rio_regs_win + RIO_PORT2_EDCSR), 0);
-		out_be32((u32 *)(rio_regs_win + RIO_PORT2_IECSR), 0);
+		out_be32((u32 *)(rio_regs_win + RIO_PORT2_IECSR), IECSR_CLEAR);
 		out_be32((u32 *)(rio_regs_win + RIO_PORT2_ESCSR), ESCSR_CLEAR);
 	}
 }
-- 
1.7.3.1
