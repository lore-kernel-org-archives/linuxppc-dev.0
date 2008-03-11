Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 456DADEA58
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Mar 2008 04:24:52 +1100 (EST)
Received: from localhost (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP id 3304B8810
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2008 22:25:04 +0400 (SAMT)
Date: Tue, 11 Mar 2008 20:24:50 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 8/8] [POWERPC] qe_io: fix sparse warnings
Message-ID: <20080311172450.GH7727@localhost.localdomain>
References: <20080311172106.GA4766@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080311172106.GA4766@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/sysdev/qe_lib/qe_io.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/sysdev/qe_lib/qe_io.c b/arch/powerpc/sysdev/qe_lib/qe_io.c
index 736c1fc..93916a4 100644
--- a/arch/powerpc/sysdev/qe_lib/qe_io.c
+++ b/arch/powerpc/sysdev/qe_lib/qe_io.c
@@ -22,6 +22,7 @@
 #include <linux/ioport.h>
 
 #include <asm/io.h>
+#include <asm/qe.h>
 #include <asm/prom.h>
 #include <sysdev/fsl_soc.h>
 
@@ -41,7 +42,7 @@ struct port_regs {
 #endif
 };
 
-static struct port_regs *par_io = NULL;
+static struct port_regs __iomem *par_io;
 static int num_par_io_ports = 0;
 
 int par_io_init(struct device_node *np)
@@ -165,7 +166,7 @@ int par_io_of_config(struct device_node *np)
 	}
 
 	ph = of_get_property(np, "pio-handle", NULL);
-	if (ph == 0) {
+	if (ph == NULL) {
 		printk(KERN_ERR "pio-handle not available \n");
 		return -1;
 	}
-- 
1.5.2.2
