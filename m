Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 17AFCB7B7D
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Sep 2009 04:52:40 +1000 (EST)
Date: Wed, 23 Sep 2009 22:52:38 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 1/3] powerpc/fsl: Make fsl_deep_sleep() usable w/ modules
	and non-83xx builds
Message-ID: <20090923185238.GA18755@oksana.dev.rtsoft.ru>
References: <20090923185158.GA29065@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20090923185158.GA29065@oksana.dev.rtsoft.ru>
Cc: Jerry Huang <Chang-Ming.Huang@freescale.com>, linux-usb@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Export is needed for modular builds, and a static inline stub is needed
for non-MPC83xx builds.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/platforms/83xx/suspend.c |    1 +
 include/linux/fsl_devices.h           |    4 ++++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/suspend.c b/arch/powerpc/platforms/83xx/suspend.c
index 08e65fc..d306f07 100644
--- a/arch/powerpc/platforms/83xx/suspend.c
+++ b/arch/powerpc/platforms/83xx/suspend.c
@@ -96,6 +96,7 @@ int fsl_deep_sleep(void)
 {
 	return deep_sleeping;
 }
+EXPORT_SYMBOL(fsl_deep_sleep);
 
 static int mpc83xx_change_state(void)
 {
diff --git a/include/linux/fsl_devices.h b/include/linux/fsl_devices.h
index 39fd946..47188d5 100644
--- a/include/linux/fsl_devices.h
+++ b/include/linux/fsl_devices.h
@@ -90,6 +90,10 @@ struct mpc8xx_pcmcia_ops {
  * lead to a deep sleep (i.e. power removed from the core,
  * instead of just the clock).
  */
+#if defined(CONFIG_PPC_83xx) && defined(CONFIG_SUSPEND)
 int fsl_deep_sleep(void);
+#else
+static inline int fsl_deep_sleep(void) { return 0; }
+#endif
 
 #endif /* _FSL_DEVICE_H_ */
-- 
1.6.3.3
