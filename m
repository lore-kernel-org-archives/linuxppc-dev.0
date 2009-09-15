Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id F3EACB7BAC
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Sep 2009 07:43:57 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 39B65DDD04
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Sep 2009 07:43:57 +1000 (EST)
Date: Wed, 16 Sep 2009 01:43:55 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 3/7] powerpc/qe: Implement QE driver for handling resume on
	MPC85xx
Message-ID: <20090915214355.GC24821@oksana.dev.rtsoft.ru>
References: <20090915214321.GA19377@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20090915214321.GA19377@oksana.dev.rtsoft.ru>
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

So far the driver is used to reset QE upon resume, which is needed on
85xx. Later we can move some QE initialization steps into probe().

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/sysdev/qe_lib/qe.c |   34 ++++++++++++++++++++++++++++++++++
 1 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/qe_lib/qe.c b/arch/powerpc/sysdev/qe_lib/qe.c
index 4eaf2a9..149393c 100644
--- a/arch/powerpc/sysdev/qe_lib/qe.c
+++ b/arch/powerpc/sysdev/qe_lib/qe.c
@@ -27,6 +27,8 @@
 #include <linux/delay.h>
 #include <linux/ioport.h>
 #include <linux/crc32.h>
+#include <linux/mod_devicetable.h>
+#include <linux/of_platform.h>
 #include <asm/irq.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
@@ -647,3 +649,35 @@ unsigned int qe_get_num_of_snums(void)
 	return num_of_snums;
 }
 EXPORT_SYMBOL(qe_get_num_of_snums);
+
+#if defined(CONFIG_SUSPEND) && defined(CONFIG_PPC_85xx)
+static int qe_resume(struct of_device *ofdev)
+{
+	if (!qe_alive_during_sleep())
+		qe_reset();
+	return 0;
+}
+
+static int qe_probe(struct of_device *ofdev, const struct of_device_id *id)
+{
+	return 0;
+}
+
+static const struct of_device_id qe_ids[] = {
+	{ .compatible = "fsl,qe", },
+	{ },
+};
+
+static struct of_platform_driver qe_driver = {
+	.driver.name = "fsl-qe",
+	.match_table = qe_ids,
+	.probe = qe_probe,
+	.resume = qe_resume,
+};
+
+static int __init qe_drv_init(void)
+{
+	return of_register_platform_driver(&qe_driver);
+}
+device_initcall(qe_drv_init);
+#endif /* defined(CONFIG_SUSPEND) && defined(CONFIG_PPC_85xx) */
-- 
1.6.3.3
