Return-Path: <haokexin@gmail.com>
Received: from mail-pa0-x22d.google.com (mail-pa0-x22d.google.com
 [IPv6:2607:f8b0:400e:c03::22d])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6A2F72C0330
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Sep 2013 11:43:06 +1000 (EST)
Received: by mail-pa0-f45.google.com with SMTP id rd3so597766pab.18
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Sep 2013 18:43:03 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: [PATCH v4 2/3] powerpc/85xx: rename the corenet_ds.c to
 corenet_generic.c
Date: Thu, 26 Sep 2013 09:42:27 +0800
Message-Id: <1380159748-10559-3-git-send-email-haokexin@gmail.com>
In-Reply-To: <1380159748-10559-1-git-send-email-haokexin@gmail.com>
References: <1380159748-10559-1-git-send-email-haokexin@gmail.com>
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This file is also used by some RDB and QDS boards. So the name seems
not so accurate. Rename it to corenet_generic.c. Also update the
function names in this file according to the change.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
v4: No change.

v3: No change.

v2: A new patch in v2.

 arch/powerpc/platforms/85xx/Makefile                         |  2 +-
 .../platforms/85xx/{corenet_ds.c => corenet_generic.c}       | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)
 rename arch/powerpc/platforms/85xx/{corenet_ds.c => corenet_generic.c} (93%)

diff --git a/arch/powerpc/platforms/85xx/Makefile b/arch/powerpc/platforms/85xx/Makefile
index a6c281d..dd4c0b5 100644
--- a/arch/powerpc/platforms/85xx/Makefile
+++ b/arch/powerpc/platforms/85xx/Makefile
@@ -18,7 +18,7 @@ obj-$(CONFIG_P1010_RDB)   += p1010rdb.o
 obj-$(CONFIG_P1022_DS)    += p1022_ds.o
 obj-$(CONFIG_P1022_RDK)   += p1022_rdk.o
 obj-$(CONFIG_P1023_RDS)   += p1023_rds.o
-obj-$(CONFIG_CORENET_GENERIC)   += corenet_ds.o
+obj-$(CONFIG_CORENET_GENERIC)   += corenet_generic.o
 obj-$(CONFIG_STX_GP3)	  += stx_gp3.o
 obj-$(CONFIG_TQM85xx)	  += tqm85xx.o
 obj-$(CONFIG_SBC8548)     += sbc8548.o
diff --git a/arch/powerpc/platforms/85xx/corenet_ds.c b/arch/powerpc/platforms/85xx/corenet_generic.c
similarity index 93%
rename from arch/powerpc/platforms/85xx/corenet_ds.c
rename to arch/powerpc/platforms/85xx/corenet_generic.c
index 8e0285a..fbd871e 100644
--- a/arch/powerpc/platforms/85xx/corenet_ds.c
+++ b/arch/powerpc/platforms/85xx/corenet_generic.c
@@ -32,7 +32,7 @@
 #include <sysdev/fsl_pci.h>
 #include "smp.h"
 
-void __init corenet_ds_pic_init(void)
+void __init corenet_gen_pic_init(void)
 {
 	struct mpic *mpic;
 	unsigned int flags = MPIC_BIG_ENDIAN | MPIC_SINGLE_DEST_CPU |
@@ -50,7 +50,7 @@ void __init corenet_ds_pic_init(void)
 /*
  * Setup the architecture
  */
-void __init corenet_ds_setup_arch(void)
+void __init corenet_gen_setup_arch(void)
 {
 	mpc85xx_smp_init();
 
@@ -91,7 +91,7 @@ static const struct of_device_id of_device_ids[] = {
 	{}
 };
 
-int __init corenet_ds_publish_devices(void)
+int __init corenet_gen_publish_devices(void)
 {
 	return of_platform_bus_probe(NULL, of_device_ids, NULL);
 }
@@ -159,8 +159,8 @@ static int __init corenet_generic_probe(void)
 define_machine(corenet_generic) {
 	.name			= "CoreNet Generic",
 	.probe			= corenet_generic_probe,
-	.setup_arch		= corenet_ds_setup_arch,
-	.init_IRQ		= corenet_ds_pic_init,
+	.setup_arch		= corenet_gen_setup_arch,
+	.init_IRQ		= corenet_gen_pic_init,
 #ifdef CONFIG_PCI
 	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
 #endif
@@ -175,7 +175,7 @@ define_machine(corenet_generic) {
 #endif
 };
 
-machine_arch_initcall(corenet_generic, corenet_ds_publish_devices);
+machine_arch_initcall(corenet_generic, corenet_gen_publish_devices);
 
 #ifdef CONFIG_SWIOTLB
 machine_arch_initcall(corenet_generic, swiotlb_setup_bus_notifier);
-- 
1.8.3.1
