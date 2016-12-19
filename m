Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tj8cP06mPzDwPj
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 05:30:45 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id b1so9172604pgc.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 10:30:44 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 08/10] powerpc: add struct smp_ops_t.cause_nmi_ipi operation
Date: Tue, 20 Dec 2016 04:30:09 +1000
Message-Id: <20161219183011.28310-9-npiggin@gmail.com>
In-Reply-To: <20161219183011.28310-1-npiggin@gmail.com>
References: <20161219183011.28310-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Have the NMI IPI code use this op when the platform defines it.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/smp.h            | 1 +
 arch/powerpc/kernel/smp.c                 | 3 +++
 arch/powerpc/platforms/85xx/smp.c         | 1 +
 arch/powerpc/platforms/86xx/mpc86xx_smp.c | 1 +
 arch/powerpc/platforms/chrp/smp.c         | 1 +
 arch/powerpc/platforms/powermac/smp.c     | 1 +
 arch/powerpc/platforms/powernv/smp.c      | 1 +
 arch/powerpc/platforms/pseries/smp.c      | 1 +
 8 files changed, 10 insertions(+)

diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index 693a68f4ac8b..5b1c8f64acce 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -42,6 +42,7 @@ struct smp_ops_t {
 #ifdef CONFIG_PPC_SMP_MUXED_IPI
 	void  (*cause_ipi)(int cpu, unsigned long data);
 #endif
+	int   (*cause_nmi_ipi)(int cpu);
 	void  (*probe)(void);
 	int   (*kick_cpu)(int nr);
 	void  (*setup_cpu)(int nr);
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 81256522985d..564b7dc9e250 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -417,6 +417,9 @@ int smp_handle_nmi_ipi(struct pt_regs *regs)
 
 static void do_smp_send_nmi_ipi(int cpu)
 {
+	if (smp_ops->cause_nmi_ipi && smp_ops->cause_nmi_ipi(cpu))
+		return;
+
 	if (cpu >= 0) {
 		do_message_pass(cpu, PPC_MSG_NMI_IPI);
 	} else {
diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
index a83a6d26090d..8534bc47c38b 100644
--- a/arch/powerpc/platforms/85xx/smp.c
+++ b/arch/powerpc/platforms/85xx/smp.c
@@ -343,6 +343,7 @@ static int smp_85xx_kick_cpu(int nr)
 }
 
 struct smp_ops_t smp_85xx_ops = {
+	.cause_nmi_ipi = NULL,
 	.kick_cpu = smp_85xx_kick_cpu,
 	.cpu_bootable = smp_generic_cpu_bootable,
 #ifdef CONFIG_HOTPLUG_CPU
diff --git a/arch/powerpc/platforms/86xx/mpc86xx_smp.c b/arch/powerpc/platforms/86xx/mpc86xx_smp.c
index af09baee22cb..020e84a47a32 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx_smp.c
+++ b/arch/powerpc/platforms/86xx/mpc86xx_smp.c
@@ -105,6 +105,7 @@ smp_86xx_setup_cpu(int cpu_nr)
 
 
 struct smp_ops_t smp_86xx_ops = {
+	.cause_nmi_ipi = NULL,
 	.message_pass = smp_mpic_message_pass,
 	.probe = smp_mpic_probe,
 	.kick_cpu = smp_86xx_kick_cpu,
diff --git a/arch/powerpc/platforms/chrp/smp.c b/arch/powerpc/platforms/chrp/smp.c
index b6c9a0dcc924..14515040f7cd 100644
--- a/arch/powerpc/platforms/chrp/smp.c
+++ b/arch/powerpc/platforms/chrp/smp.c
@@ -44,6 +44,7 @@ static void smp_chrp_setup_cpu(int cpu_nr)
 
 /* CHRP with openpic */
 struct smp_ops_t chrp_smp_ops = {
+	.cause_nmi_ipi = NULL,
 	.message_pass = smp_mpic_message_pass,
 	.probe = smp_mpic_probe,
 	.kick_cpu = smp_chrp_kick_cpu,
diff --git a/arch/powerpc/platforms/powermac/smp.c b/arch/powerpc/platforms/powermac/smp.c
index c9eb7d6540ea..1d76e1567018 100644
--- a/arch/powerpc/platforms/powermac/smp.c
+++ b/arch/powerpc/platforms/powermac/smp.c
@@ -446,6 +446,7 @@ void __init smp_psurge_give_timebase(void)
 struct smp_ops_t psurge_smp_ops = {
 	.message_pass	= NULL,	/* Use smp_muxed_ipi_message_pass */
 	.cause_ipi	= smp_psurge_cause_ipi,
+	.cause_nmi_ipi	= NULL,
 	.probe		= smp_psurge_probe,
 	.kick_cpu	= smp_psurge_kick_cpu,
 	.setup_cpu	= smp_psurge_setup_cpu,
diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
index c789258ae1e1..092ec1f7b58d 100644
--- a/arch/powerpc/platforms/powernv/smp.c
+++ b/arch/powerpc/platforms/powernv/smp.c
@@ -244,6 +244,7 @@ static int pnv_cpu_bootable(unsigned int nr)
 static struct smp_ops_t pnv_smp_ops = {
 	.message_pass	= smp_muxed_ipi_message_pass,
 	.cause_ipi	= NULL,	/* Filled at runtime by xics_smp_probe() */
+	.cause_nmi_ipi	= NULL,
 	.probe		= xics_smp_probe,
 	.kick_cpu	= pnv_smp_kick_cpu,
 	.setup_cpu	= pnv_smp_setup_cpu,
diff --git a/arch/powerpc/platforms/pseries/smp.c b/arch/powerpc/platforms/pseries/smp.c
index f6f83aeccaaa..0f6522c6518b 100644
--- a/arch/powerpc/platforms/pseries/smp.c
+++ b/arch/powerpc/platforms/pseries/smp.c
@@ -209,6 +209,7 @@ static __init void pSeries_smp_probe(void)
 static struct smp_ops_t pseries_smp_ops = {
 	.message_pass	= NULL,	/* Use smp_muxed_ipi_message_pass */
 	.cause_ipi	= NULL,	/* Filled at runtime by pSeries_smp_probe() */
+	.cause_nmi_ipi	= NULL,
 	.probe		= pSeries_smp_probe,
 	.kick_cpu	= smp_pSeries_kick_cpu,
 	.setup_cpu	= smp_setup_cpu,
-- 
2.11.0
