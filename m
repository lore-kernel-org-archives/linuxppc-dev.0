Return-Path: <jochen@scram.de>
Received: from mail0.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail0.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 8CA15DEFAA
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 02:19:16 +1100 (EST)
Message-ID: <4798AC65.9000203@scram.de>
Date: Thu, 24 Jan 2008 16:19:01 +0100
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: [PATCHv3 5/7] [POWERPC] Get rid of conditional includes of board
	specific setup
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Cc: Scott Wood <scottwood@freescale.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>, "Kernel,
	Linux" <linux-kernel@vger.kernel.org>
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
 arch/powerpc/platforms/8xx/m8xx_setup.c      |    3 +--
 arch/powerpc/platforms/8xx/mpc885ads_setup.c |    1 +
 include/asm-powerpc/mpc8xx.h                 |   20 --------------------
 3 files changed, 2 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/platforms/8xx/m8xx_setup.c b/arch/powerpc/platforms/8xx/m8xx_setup.c
index 1867a07..184f998 100644
--- a/arch/powerpc/platforms/8xx/m8xx_setup.c
+++ b/arch/powerpc/platforms/8xx/m8xx_setup.c
@@ -16,6 +16,7 @@
 #include <linux/init.h>
 #include <linux/time.h>
 #include <linux/rtc.h>
+#include <linux/fsl_devices.h>
 
 #include <asm/io.h>
 #include <asm/mpc8xx.h>
@@ -28,9 +29,7 @@
 
 #include "mpc8xx.h"
 
-#ifdef CONFIG_PCMCIA_M8XX
 struct mpc8xx_pcmcia_ops m8xx_pcmcia_ops;
-#endif
 
 extern int cpm_pic_init(void);
 extern int cpm_get_irq(void);
diff --git a/arch/powerpc/platforms/8xx/mpc885ads_setup.c b/arch/powerpc/platforms/8xx/mpc885ads_setup.c
index bdceb57..3be115e 100644
--- a/arch/powerpc/platforms/8xx/mpc885ads_setup.c
+++ b/arch/powerpc/platforms/8xx/mpc885ads_setup.c
@@ -40,6 +40,7 @@
 #include <asm/fs_pd.h>
 #include <asm/udbg.h>
 
+#include "mpc885ads.h"
 #include "mpc8xx.h"
 
 static u32 __iomem *bcsr, *bcsr5;
diff --git a/include/asm-powerpc/mpc8xx.h b/include/asm-powerpc/mpc8xx.h
index 2be014b..98f3c4f 100644
--- a/include/asm-powerpc/mpc8xx.h
+++ b/include/asm-powerpc/mpc8xx.h
@@ -4,29 +4,9 @@
  * file that has to include MPC8xx configuration, they all include
  * this one and the configuration switching is done here.
  */
-#ifdef __KERNEL__
 #ifndef __CONFIG_8xx_DEFS
 #define __CONFIG_8xx_DEFS
 
-
-#ifdef CONFIG_8xx
-
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
-#ifdef CONFIG_PCMCIA_M8XX
 extern struct mpc8xx_pcmcia_ops m8xx_pcmcia_ops;
-#endif
 
-#endif /* CONFIG_8xx */
 #endif /* __CONFIG_8xx_DEFS */
-#endif /* __KERNEL__ */
-- 
1.5.3.8
