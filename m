Return-Path: <paul.gortmaker@windriver.com>
Received: from yow-pgortmak-d1.corp.ad.wrs.com (unknown [67.71.254.34])
	by ozlabs.org (Postfix) with ESMTP id 61B64DDF25
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 05:13:30 +1100 (EST)
Date: Thu, 15 Feb 2007 12:43:06 -0500
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Fix compile failure in cpm_uart_cpm2
Message-ID: <20070215174305.GA2820@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: p_gortmaker@yahoo.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fix bug that exists in kernel.org since 2.6.17rc4 - compiles fail if
CONFIG_SERIAL_CPM_SMC is defined.  Tested on a board using SMC1 console.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---

--- linux-2.6.20/drivers/serial/cpm_uart/cpm_uart_cpm2.c~	2007-02-07 14:07:47.778573326 -0500
+++ linux-2.6.20/drivers/serial/cpm_uart/cpm_uart_cpm2.c	2007-02-07 14:07:58.248391885 -0500
@@ -285,7 +285,7 @@
 int __init cpm_uart_init_portdesc(void)
 {
 #if defined(CONFIG_SERIAL_CPM_SMC1) || defined(CONFIG_SERIAL_CPM_SMC2)
-	u32 addr;
+	u16 *addr;
 #endif
 	pr_debug("CPM uart[-]:init portdesc\n");
 
