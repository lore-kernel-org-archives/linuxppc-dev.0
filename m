Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 69A9EB72CE
	for <linuxppc-dev@ozlabs.org>; Fri, 20 May 2011 16:09:44 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 08/14] powerpc/85xx: Set up doorbells even with no mpic
Date: Fri, 20 May 2011 01:09:25 -0500
Message-Id: <1305871771-16334-8-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1305871771-16334-7-git-send-email-galak@kernel.crashing.org>
References: <1305871771-16334-1-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-2-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-3-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-4-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-5-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-6-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-7-git-send-email-galak@kernel.crashing.org>
Cc: Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Scott Wood <scottwood@freescale.com>

In cases like when the platform is used under hypervisor we will NOT
have an MPIC controller but still want doorbells setup.

Signed-off-by: Scott Wood <scottwood@freescale.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/platforms/85xx/smp.c |   21 ++++++++++++---------
 1 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
index d6a93a1..eebb08f1 100644
--- a/arch/powerpc/platforms/85xx/smp.c
+++ b/arch/powerpc/platforms/85xx/smp.c
@@ -111,14 +111,6 @@ smp_85xx_kick_cpu(int nr)
 	return 0;
 }
 
-static void __init
-smp_85xx_setup_cpu(int cpu_nr)
-{
-	mpic_setup_this_cpu();
-	if (cpu_has_feature(CPU_FTR_DBELL))
-		doorbell_setup_this_cpu();
-}
-
 struct smp_ops_t smp_85xx_ops = {
 	.kick_cpu = smp_85xx_kick_cpu,
 #ifdef CONFIG_KEXEC
@@ -224,14 +216,25 @@ static void mpc85xx_smp_machine_kexec(struct kimage *image)
 }
 #endif /* CONFIG_KEXEC */
 
+static void __init
+smp_85xx_setup_cpu(int cpu_nr)
+{
+	if (smp_85xx_ops.probe == smp_mpic_probe)
+		mpic_setup_this_cpu();
+
+	if (cpu_has_feature(CPU_FTR_DBELL))
+		doorbell_setup_this_cpu();
+}
+
 void __init mpc85xx_smp_init(void)
 {
 	struct device_node *np;
 
+	smp_85xx_ops.setup_cpu = smp_85xx_setup_cpu;
+
 	np = of_find_node_by_type(NULL, "open-pic");
 	if (np) {
 		smp_85xx_ops.probe = smp_mpic_probe;
-		smp_85xx_ops.setup_cpu = smp_85xx_setup_cpu;
 		smp_85xx_ops.message_pass = smp_mpic_message_pass;
 	}
 
-- 
1.7.3.4
