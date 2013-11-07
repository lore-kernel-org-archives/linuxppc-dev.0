Return-Path: <haokexin@gmail.com>
Received: from mail-pd0-x234.google.com (mail-pd0-x234.google.com
 [IPv6:2607:f8b0:400e:c02::234])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7E0902C00BD
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Nov 2013 18:18:13 +1100 (EST)
Received: by mail-pd0-f180.google.com with SMTP id p10so191388pdj.11
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Nov 2013 23:18:09 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: [PATCH] powerpc/85xx: don't init the mpic ipi for the SoC which has
 doorbell support
Date: Thu,  7 Nov 2013 15:17:17 +0800
Message-Id: <1383808637-26769-1-git-send-email-haokexin@gmail.com>
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It makes no sense to initialize the mpic ipi for the SoC which has
doorbell support. So set the smp_85xx_ops.probe to NULL for this
case. Since the smp_85xx_ops.probe is also used in function
smp_85xx_setup_cpu() to check if we need to invoke
mpic_setup_this_cpu(), we introduce a new setup_cpu function
smp_85xx_basic_setup() to remove this dependency.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---

Boot test on p2020rdb and p5020ds.

 arch/powerpc/platforms/85xx/smp.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
index 281b7f01df63..d3b310f87ce9 100644
--- a/arch/powerpc/platforms/85xx/smp.c
+++ b/arch/powerpc/platforms/85xx/smp.c
@@ -388,15 +388,18 @@ static void mpc85xx_smp_machine_kexec(struct kimage *image)
 }
 #endif /* CONFIG_KEXEC */
 
-static void smp_85xx_setup_cpu(int cpu_nr)
+static void smp_85xx_basic_setup(int cpu_nr)
 {
-	if (smp_85xx_ops.probe == smp_mpic_probe)
-		mpic_setup_this_cpu();
-
 	if (cpu_has_feature(CPU_FTR_DBELL))
 		doorbell_setup_this_cpu();
 }
 
+static void smp_85xx_setup_cpu(int cpu_nr)
+{
+	mpic_setup_this_cpu();
+	smp_85xx_basic_setup(cpu_nr);
+}
+
 static const struct of_device_id mpc85xx_smp_guts_ids[] = {
 	{ .compatible = "fsl,mpc8572-guts", },
 	{ .compatible = "fsl,p1020-guts", },
@@ -411,13 +414,14 @@ void __init mpc85xx_smp_init(void)
 {
 	struct device_node *np;
 
-	smp_85xx_ops.setup_cpu = smp_85xx_setup_cpu;
 
 	np = of_find_node_by_type(NULL, "open-pic");
 	if (np) {
 		smp_85xx_ops.probe = smp_mpic_probe;
+		smp_85xx_ops.setup_cpu = smp_85xx_setup_cpu;
 		smp_85xx_ops.message_pass = smp_mpic_message_pass;
-	}
+	} else
+		smp_85xx_ops.setup_cpu = smp_85xx_basic_setup;
 
 	if (cpu_has_feature(CPU_FTR_DBELL)) {
 		/*
@@ -426,6 +430,7 @@ void __init mpc85xx_smp_init(void)
 		 */
 		smp_85xx_ops.message_pass = NULL;
 		smp_85xx_ops.cause_ipi = doorbell_cause_ipi;
+		smp_85xx_ops.probe = NULL;
 	}
 
 	np = of_find_matching_node(NULL, mpc85xx_smp_guts_ids);
-- 
1.8.3.1
