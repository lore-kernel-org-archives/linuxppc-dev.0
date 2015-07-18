Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0130.outbound.protection.outlook.com [157.56.110.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A5FB31A1917
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Jul 2015 06:09:28 +1000 (AEST)
From: Scott Wood <scottwood@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
CC: Tiejun Chen <tiejun.chen@intel.com>, <kexec@lists.infradead.org>, "Tiejun
 Chen" <tiejun.chen@windriver.com>, Scott Wood <scottwood@freescale.com>
Subject: [RFC PATCH 06/17] powerpc/85xx: Implement 64-bit kexec support
Date: Sat, 18 Jul 2015 15:08:43 -0500
Message-ID: <1437250134-307-7-git-send-email-scottwood@freescale.com>
In-Reply-To: <1437250134-307-1-git-send-email-scottwood@freescale.com>
References: <1437250134-307-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Tiejun Chen <tiejun.chen@windriver.com>

Unlike 32-bit 85xx kexec, we don't do a core reset.

Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
[scottwood: edit changelog, and cleanup]
Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/platforms/85xx/smp.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
index a0763be..2e46684 100644
--- a/arch/powerpc/platforms/85xx/smp.c
+++ b/arch/powerpc/platforms/85xx/smp.c
@@ -351,6 +351,7 @@ struct smp_ops_t smp_85xx_ops = {
 };
 
 #ifdef CONFIG_KEXEC
+#ifdef CONFIG_PPC32
 atomic_t kexec_down_cpus = ATOMIC_INIT(0);
 
 void mpc85xx_smp_kexec_cpu_down(int crash_shutdown, int secondary)
@@ -370,9 +371,18 @@ static void mpc85xx_smp_kexec_down(void *arg)
 	if (ppc_md.kexec_cpu_down)
 		ppc_md.kexec_cpu_down(0,1);
 }
+#else
+void mpc85xx_smp_kexec_cpu_down(int crash_shutdown, int secondary)
+{
+	local_irq_disable();
+	hard_irq_disable();
+	mpic_teardown_this_cpu(secondary);
+}
+#endif
 
 static void mpc85xx_smp_machine_kexec(struct kimage *image)
 {
+#ifdef CONFIG_PPC32
 	int timeout = INT_MAX;
 	int i, num_cpus = num_present_cpus();
 
@@ -393,6 +403,7 @@ static void mpc85xx_smp_machine_kexec(struct kimage *image)
 		if ( i == smp_processor_id() ) continue;
 		mpic_reset_core(i);
 	}
+#endif
 
 	default_machine_kexec(image);
 }
-- 
2.1.4
