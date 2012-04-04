Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2D1C8B6FF2
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Apr 2012 13:15:22 +1000 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: agust@denx.de
Subject: [PATCH] powerpc: Option FB_FSL_DIU is not really optional for mpc512x
Date: Tue,  3 Apr 2012 23:15:00 -0400
Message-Id: <1333509300-27066-1-git-send-email-paul.gortmaker@windriver.com>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 Paul Gortmaker <paul.gortmaker@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In powerpc randconfig builds, this keeps showing up:

  CC      arch/powerpc/platforms/512x/mpc512x_shared.o
arch/powerpc/platforms/512x/mpc512x_shared.c:70:9: warning: 'enum fsl_diu_monitor_port' declared inside parameter list
arch/powerpc/platforms/512x/mpc512x_shared.c:70:9: warning: its scope is only this definition or declaration, which is probably not what you want
arch/powerpc/platforms/512x/mpc512x_shared.c:69:56: error: parameter 1 ('port') has incomplete type
arch/powerpc/platforms/512x/mpc512x_shared.c:69:5: warning: function declaration isn't a prototype
arch/powerpc/platforms/512x/mpc512x_shared.c:84:9: warning: 'enum fsl_diu_monitor_port' declared inside parameter list
arch/powerpc/platforms/512x/mpc512x_shared.c:83:56: error: parameter 1 ('port') has incomplete type
arch/powerpc/platforms/512x/mpc512x_shared.c:83:6: warning: function declaration isn't a prototype
arch/powerpc/platforms/512x/mpc512x_shared.c:88:36: warning: 'enum fsl_diu_monitor_port' declared inside parameter list
arch/powerpc/platforms/512x/mpc512x_shared.c:88:57: error: parameter 1 ('port') has incomplete type
arch/powerpc/platforms/512x/mpc512x_shared.c:88:6: warning: function declaration isn't a prototype
arch/powerpc/platforms/512x/mpc512x_shared.c:187:54: error: parameter 1 ('port') has incomplete type
arch/powerpc/platforms/512x/mpc512x_shared.c:187:1: error: return type is an incomplete type
arch/powerpc/platforms/512x/mpc512x_shared.c:187:1: warning: function declaration isn't a prototype
arch/powerpc/platforms/512x/mpc512x_shared.c: In function 'mpc512x_valid_monitor_port':
arch/powerpc/platforms/512x/mpc512x_shared.c:189:9: error: 'FSL_DIU_PORT_DVI' undeclared (first use in this function)
arch/powerpc/platforms/512x/mpc512x_shared.c:189:9: note: each undeclared identifier is reported only once for each function it appears in
arch/powerpc/platforms/512x/mpc512x_shared.c:189:2: warning: 'return' with a value, in function returning void
make[2]: *** [arch/powerpc/platforms/512x/mpc512x_shared.o] Error 1

The reason is that mpc512x_shared.c has a couple token #ifdef
on FB_FSL_DIU/FB_FSL_DIU_MODULE, but they don't come close to
masking all the DIU dependencies, as the above fail shows.

Rather than sprinkle more pointless #ifdef in this file, just
remove the existing two, and make FB_FSL_DIU part of the
dependency.  The mpc512x_defconfig already has the line
"CONFIG_FB_FSL_DIU=y" so this change should be zero impact
on real world configs.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

diff --git a/arch/powerpc/platforms/512x/Kconfig b/arch/powerpc/platforms/512x/Kconfig
index c169998..b62508b 100644
--- a/arch/powerpc/platforms/512x/Kconfig
+++ b/arch/powerpc/platforms/512x/Kconfig
@@ -2,6 +2,7 @@ config PPC_MPC512x
 	bool "512x-based boards"
 	depends on 6xx
 	select FSL_SOC
+	select FB_FSL_DIU
 	select IPIC
 	select PPC_CLOCK
 	select PPC_PCI_CHOICE
diff --git a/arch/powerpc/platforms/512x/mpc512x_shared.c b/arch/powerpc/platforms/512x/mpc512x_shared.c
index cfe958e..1650e09 100644
--- a/arch/powerpc/platforms/512x/mpc512x_shared.c
+++ b/arch/powerpc/platforms/512x/mpc512x_shared.c
@@ -191,8 +191,6 @@ mpc512x_valid_monitor_port(enum fsl_diu_monitor_port port)
 
 static struct fsl_diu_shared_fb __attribute__ ((__aligned__(8))) diu_shared_fb;
 
-#if defined(CONFIG_FB_FSL_DIU) || \
-    defined(CONFIG_FB_FSL_DIU_MODULE)
 static inline void mpc512x_free_bootmem(struct page *page)
 {
 	__ClearPageReserved(page);
@@ -220,7 +218,6 @@ void mpc512x_release_bootmem(void)
 	}
 	diu_ops.release_bootmem	= NULL;
 }
-#endif
 
 /*
  * Check if DIU was pre-initialized. If so, perform steps
@@ -323,15 +320,12 @@ void __init mpc512x_setup_diu(void)
 		}
 	}
 
-#if defined(CONFIG_FB_FSL_DIU) || \
-    defined(CONFIG_FB_FSL_DIU_MODULE)
 	diu_ops.get_pixel_format	= mpc512x_get_pixel_format;
 	diu_ops.set_gamma_table		= mpc512x_set_gamma_table;
 	diu_ops.set_monitor_port	= mpc512x_set_monitor_port;
 	diu_ops.set_pixel_clock		= mpc512x_set_pixel_clock;
 	diu_ops.valid_monitor_port	= mpc512x_valid_monitor_port;
 	diu_ops.release_bootmem		= mpc512x_release_bootmem;
-#endif
 }
 
 void __init mpc512x_init_IRQ(void)
-- 
1.7.9.1
