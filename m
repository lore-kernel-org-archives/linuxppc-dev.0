Return-Path: <B04825@freescale.com>
Received: from VA3EHSOBE005.bigfish.com (va3ehsobe005.messaging.microsoft.com
	[216.32.180.31]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 74391B6F92
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Jun 2011 09:04:43 +1000 (EST)
Received: from mail158-va3 (localhost.localdomain [127.0.0.1])	by
	mail158-va3-R.bigfish.com (Postfix) with ESMTP id 54E3F19B8224	for
	<linuxppc-dev@ozlabs.org>; Tue, 14 Jun 2011 23:04:38 +0000 (UTC)
Received: from VA3EHSMHS030.bigfish.com (unknown [10.7.14.244])	by
	mail158-va3.bigfish.com (Postfix) with ESMTP id 0FBC3163004E	for
	<linuxppc-dev@ozlabs.org>; Tue, 14 Jun 2011 23:04:38 +0000 (UTC)
From: Timur Tabi <timur@freescale.com>
To: <kumar.gala@freescale.com>, <scottwood@freescale.com>,
	<B29882@freescale.com>, <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc/85xx: disable timebase synchronization under the
	hypervisor
Date: Tue, 14 Jun 2011 18:04:33 -0500
Message-ID: <1308092673-13045-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The Freescale hypervisor does not allow guests to write to the timebase
registers (virtualizing the timebase register was deemed too complicated),
so don't try to synchronize the timebase registers when we're running
under the hypervisor.

This typically happens when kexec support is enabled.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 arch/powerpc/platforms/85xx/p3041_ds.c |   11 +++++++++++
 arch/powerpc/platforms/85xx/p4080_ds.c |   11 +++++++++++
 arch/powerpc/platforms/85xx/p5020_ds.c |   11 +++++++++++
 3 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/p3041_ds.c b/arch/powerpc/platforms/85xx/p3041_ds.c
index c0242bc..8b651dfe 100644
--- a/arch/powerpc/platforms/85xx/p3041_ds.c
+++ b/arch/powerpc/platforms/85xx/p3041_ds.c
@@ -40,6 +40,9 @@
 static int __init p3041_ds_probe(void)
 {
 	unsigned long root = of_get_flat_dt_root();
+#ifdef CONFIG_SMP
+	extern struct smp_ops_t smp_85xx_ops;
+#endif
 
 	if (of_flat_dt_is_compatible(root, "fsl,P3041DS"))
 		return 1;
@@ -51,6 +54,14 @@ static int __init p3041_ds_probe(void)
 		ppc_md.restart = fsl_hv_restart;
 		ppc_md.power_off = fsl_hv_halt;
 		ppc_md.halt = fsl_hv_halt;
+#ifdef CONFIG_SMP
+		/*
+		 * Disable the timebase sync operations because we can't write
+		 * to the timebase registers under the hypervisor.
+		  */
+		smp_85xx_ops.give_timebase = NULL;
+		smp_85xx_ops.take_timebase = NULL;
+#endif
 		return 1;
 	}
 
diff --git a/arch/powerpc/platforms/85xx/p4080_ds.c b/arch/powerpc/platforms/85xx/p4080_ds.c
index 32ea5eb..ae859ab 100644
--- a/arch/powerpc/platforms/85xx/p4080_ds.c
+++ b/arch/powerpc/platforms/85xx/p4080_ds.c
@@ -39,6 +39,9 @@
 static int __init p4080_ds_probe(void)
 {
 	unsigned long root = of_get_flat_dt_root();
+#ifdef CONFIG_SMP
+	extern struct smp_ops_t smp_85xx_ops;
+#endif
 
 	if (of_flat_dt_is_compatible(root, "fsl,P4080DS"))
 		return 1;
@@ -50,6 +53,14 @@ static int __init p4080_ds_probe(void)
 		ppc_md.restart = fsl_hv_restart;
 		ppc_md.power_off = fsl_hv_halt;
 		ppc_md.halt = fsl_hv_halt;
+#ifdef CONFIG_SMP
+		/*
+		 * Disable the timebase sync operations because we can't write
+		 * to the timebase registers under the hypervisor.
+		  */
+		smp_85xx_ops.give_timebase = NULL;
+		smp_85xx_ops.take_timebase = NULL;
+#endif
 		return 1;
 	}
 
diff --git a/arch/powerpc/platforms/85xx/p5020_ds.c b/arch/powerpc/platforms/85xx/p5020_ds.c
index 2ea9ccc..d951618 100644
--- a/arch/powerpc/platforms/85xx/p5020_ds.c
+++ b/arch/powerpc/platforms/85xx/p5020_ds.c
@@ -40,6 +40,9 @@
 static int __init p5020_ds_probe(void)
 {
 	unsigned long root = of_get_flat_dt_root();
+#ifdef CONFIG_SMP
+	extern struct smp_ops_t smp_85xx_ops;
+#endif
 
 	if (of_flat_dt_is_compatible(root, "fsl,P5020DS"))
 		return 1;
@@ -51,6 +54,14 @@ static int __init p5020_ds_probe(void)
 		ppc_md.restart = fsl_hv_restart;
 		ppc_md.power_off = fsl_hv_halt;
 		ppc_md.halt = fsl_hv_halt;
+#ifdef CONFIG_SMP
+		/*
+		 * Disable the timebase sync operations because we can't write
+		 * to the timebase registers under the hypervisor.
+		  */
+		smp_85xx_ops.give_timebase = NULL;
+		smp_85xx_ops.take_timebase = NULL;
+#endif
 		return 1;
 	}
 
-- 
1.7.3.4
