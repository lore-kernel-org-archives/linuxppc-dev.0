Return-Path: <afleming@gmail.com>
Received: from mail-oi0-x241.google.com (mail-oi0-x241.google.com
 [IPv6:2607:f8b0:4003:c06::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sTGS90lw5zDrpK
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Sep 2016 05:12:09 +1000 (AEST)
Received: by mail-oi0-x241.google.com with SMTP id w78so10911917oie.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Sep 2016 12:12:09 -0700 (PDT)
From: Andy Fleming <afleming@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	scottwood@freescale.com
Cc: aperez@alexperez.com
Subject: [PATCH 2/3] corenet: Support gpio power/reset for corenet
Date: Tue,  6 Sep 2016 14:11:58 -0500
Message-Id: <1473189119-29458-3-git-send-email-afleming@gmail.com>
In-Reply-To: <1473189119-29458-1-git-send-email-afleming@gmail.com>
References: <1473189119-29458-1-git-send-email-afleming@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Boards can implement power and reset functionality over gpio using
these drivers:
  drivers/power/reset/gpio-poweroff.c
  drivers/power/reset/gpio-restart.c

While not all corenet boards use gpio for power/reset, this
support can be added without interfering with boards that do not
use this functionality.

If a board's device tree has the related nodes, they are now probed.
Also, gpio-poweroff uses the global pm_power_off callback to implement
the shutdown. However, pm_power_off was not invoked when the kernel
halted, although that is usually the desired behavior. If the board
provides gpio power and reset support, it is reasonable to assume that
halting should also power down the system, unless it has chosen to
pass those calls on to hypervisor.

Signed-off-by: Andy Fleming <afleming@gmail.com>
---
 arch/powerpc/platforms/85xx/corenet_generic.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc/platforms/85xx/corenet_generic.c
index 3a6a84f..17b8ebb 100644
--- a/arch/powerpc/platforms/85xx/corenet_generic.c
+++ b/arch/powerpc/platforms/85xx/corenet_generic.c
@@ -59,6 +59,16 @@ void __init corenet_gen_pic_init(void)
 	}
 }
 
+/* If someone has registered a poweroff callback, invoke it */
+static void __noreturn corenet_generic_halt(void)
+{
+	if (pm_power_off)
+		pm_power_off();
+
+	/* Should not return */
+	for(;;);
+}
+
 /*
  * Setup the architecture
  */
@@ -127,6 +137,12 @@ static const struct of_device_id of_device_ids[] = {
 	{
 		.name		= "handles",
 	},
+	{
+		.name		= "gpio-poweroff",
+	},
+	{
+		.name		= "gpio-restart",
+	},
 	{}
 };
 
@@ -176,6 +192,8 @@ static int __init corenet_generic_probe(void)
 	extern struct smp_ops_t smp_85xx_ops;
 #endif
 
+	ppc_md.halt = corenet_generic_halt;
+
 	if (of_device_compatible_match(of_root, boards))
 		return 1;
 
-- 
1.9.1
