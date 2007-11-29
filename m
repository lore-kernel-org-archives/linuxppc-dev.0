Return-Path: <gorcunov@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.168])
	by ozlabs.org (Postfix) with ESMTP id 13B0DDDE43
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 06:45:58 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so2140057uge
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2007 11:45:58 -0800 (PST)
Date: Thu, 29 Nov 2007 22:46:39 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: PPCML <linuxppc-dev@ozlabs.org>
Subject: [PATCH 4/5] PPC cleanup: celleb - do use for_each macro
Message-ID: <20071129194639.GE12123@cvg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Cyrill Gorcunov <gorcunov@gmail.com>

Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>
---

 arch/powerpc/platforms/celleb/scc_sio.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/celleb/scc_sio.c b/arch/powerpc/platforms/celleb/scc_sio.c
index 6100082..5e43bac 100644
--- a/arch/powerpc/platforms/celleb/scc_sio.c
+++ b/arch/powerpc/platforms/celleb/scc_sio.c
@@ -42,14 +42,13 @@ static struct {
 static int __init txx9_serial_init(void)
 {
 	extern int early_serial_txx9_setup(struct uart_port *port);
-	struct device_node *node = NULL;
+	struct device_node *node;
 	int i;
 	struct uart_port req;
 	struct of_irq irq;
 	struct resource res;
 
-	while ((node = of_find_compatible_node(node,
-				"serial", "toshiba,sio-scc")) != NULL) {
+	for_each_compatible_node(node, "serial", "toshiba,sio-scc") {
 		for (i = 0; i < ARRAY_SIZE(txx9_scc_tab); i++) {
 			if (!(txx9_serial_bitmap & (1<<i)))
 				continue;
-- 
1.5.3.5
