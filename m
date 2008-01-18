Return-Path: <jochen@scram.de>
Received: from mail0.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail0.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 92F53DE7F8
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Jan 2008 01:32:22 +1100 (EST)
Message-ID: <4790B891.3050106@scram.de>
Date: Fri, 18 Jan 2008 15:32:49 +0100
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: [PATCH 6/7] [POWERPC] Get rid of conditional includes of board
	specific setup
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Cc: Scott Wood <scottwood@freescale.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Directly include mpc885ads.h from mpc885ads_setup.c. Now we can get rid
of the arch dependent includes in mpc8xx.h.

Signed-off-by: Jochen Friedrich <jochen@scram.de>
---
 arch/powerpc/platforms/8xx/mpc885ads_setup.c |    2 +
 include/asm-powerpc/mpc8xx.h                 |   29 ++++++++-----------------
 2 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/platforms/8xx/mpc885ads_setup.c b/arch/powerpc/platforms/8xx/mpc885ads_setup.c
index ae69e93..426b897 100644
--- a/arch/powerpc/platforms/8xx/mpc885ads_setup.c
+++ b/arch/powerpc/platforms/8xx/mpc885ads_setup.c
@@ -40,6 +40,8 @@
 #include <asm/fs_pd.h>
 #include <asm/udbg.h>
 
+#include "mpc885ads.h"
+
 static u32 __iomem *bcsr, *bcsr5;
 
 #ifdef CONFIG_PCMCIA_M8XX
diff --git a/include/asm-powerpc/mpc8xx.h b/include/asm-powerpc/mpc8xx.h
index 2af9fcb..afdb89f 100644
--- a/include/asm-powerpc/mpc8xx.h
+++ b/include/asm-powerpc/mpc8xx.h
@@ -1,14 +1,16 @@
-/* This is the single file included by all MPC8xx build options.
- * Since there are many different boards and no standard configuration,
- * we have a unique include file for each.  Rather than change every
- * file that has to include MPC8xx configuration, they all include
- * this one and the configuration switching is done here.
+/*
+ * Prototypes, etc. for the Freescale MPC8xx embedded cpu chips
+ * May need to be cleaned as the port goes on ...
+ *
+ * Copyright (C) 2008 Jochen Friedrich <jochen@scram.de>
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
  */
-#ifdef __KERNEL__
 #ifndef __CONFIG_8xx_DEFS
 #define __CONFIG_8xx_DEFS
 
-
 #ifdef CONFIG_8xx
 
 extern void mpc8xx_restart(char *cmd);
@@ -18,22 +20,9 @@ extern void mpc8xx_get_rtc_time(struct rtc_time *tm);
 extern void mpc8xx_pics_init(void);
 extern unsigned int mpc8xx_get_irq(void);
 
-#ifdef CONFIG_FADS
-#include <platforms/fads.h>
-#endif
-
-#if defined(CONFIG_MPC86XADS)
-#include <platforms/8xx/mpc86xads.h>
-#endif
-
-#if defined(CONFIG_MPC885ADS)
-#include <platforms/8xx/mpc885ads.h>
-#endif
-
 #ifdef CONFIG_PCMCIA_M8XX
 extern struct mpc8xx_pcmcia_ops m8xx_pcmcia_ops;
 #endif
 
 #endif /* CONFIG_8xx */
 #endif /* __CONFIG_8xx_DEFS */
-#endif /* __KERNEL__ */
-- 
1.5.3.8
