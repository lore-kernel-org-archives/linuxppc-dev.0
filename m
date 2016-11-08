Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tCrb04376zDt1n
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Nov 2016 01:01:48 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id y68so19673287pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Nov 2016 06:01:48 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Alistair Popple <alistair@popple.id.au>
Subject: [PATCH 3/3] powerpc/pseries: implement nmi ipi with H_SIGNAL_SYS_RESET
Date: Wed,  9 Nov 2016 01:01:25 +1100
Message-Id: <20161108140125.21455-4-npiggin@gmail.com>
In-Reply-To: <20161108140125.21455-1-npiggin@gmail.com>
References: <20161108140125.21455-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

H_SIGNAL_SYS_RESET can provide a hard NMI (it is not recoverable if
raised when the target has MSR_RI clear).

This patch makes a couple of changes to generic system_reset_exception
handler, which should be split out and platforms defining a handler
audited.
---
 arch/powerpc/kernel/traps.c          |  7 +++++--
 arch/powerpc/platforms/pseries/ras.c |  4 ++++
 arch/powerpc/platforms/pseries/smp.c | 12 +++++++++++-
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 023a462..d1d7fd4 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -275,19 +275,22 @@ void _exception(int signr, struct pt_regs *regs, int code, unsigned long addr)
 
 void system_reset_exception(struct pt_regs *regs)
 {
+	nmi_enter();
+
 	/* See if any machine dependent calls */
 	if (ppc_md.system_reset_exception) {
 		if (ppc_md.system_reset_exception(regs))
-			return;
+			goto done;
 	}
 
 	die("System Reset", regs, SIGABRT);
 
+done:
 	/* Must die if the interrupt is not recoverable */
 	if (!(regs->msr & MSR_RI))
 		panic("Unrecoverable System Reset");
 
-	/* What should we do here? We could issue a shutdown or hard reset. */
+	nmi_exit();
 }
 
 #ifdef CONFIG_PPC64
diff --git a/arch/powerpc/platforms/pseries/ras.c b/arch/powerpc/platforms/pseries/ras.c
index 904a677..bb70b26 100644
--- a/arch/powerpc/platforms/pseries/ras.c
+++ b/arch/powerpc/platforms/pseries/ras.c
@@ -386,6 +386,10 @@ int pSeries_system_reset_exception(struct pt_regs *regs)
 		}
 		fwnmi_release_errinfo();
 	}
+
+	if (smp_handle_nmi_ipi(regs))
+		return 1;
+
 	return 0; /* need to perform reset */
 }
 
diff --git a/arch/powerpc/platforms/pseries/smp.c b/arch/powerpc/platforms/pseries/smp.c
index 0f6522c..4534c5a 100644
--- a/arch/powerpc/platforms/pseries/smp.c
+++ b/arch/powerpc/platforms/pseries/smp.c
@@ -196,6 +196,16 @@ static void pSeries_cause_ipi_mux(int cpu, unsigned long data)
 		xics_cause_ipi(cpu, data);
 }
 
+static int pseries_cause_nmi_ipi(int cpu, int type)
+{
+	if (type == SMP_OP_NMI_TYPE_HARD) {
+		if (plapr_signal_sys_reset(cpu) == H_SUCCESS)
+			return 1;
+	}
+
+	return 0;
+}
+
 static __init void pSeries_smp_probe(void)
 {
 	xics_smp_probe();
@@ -209,7 +219,7 @@ static __init void pSeries_smp_probe(void)
 static struct smp_ops_t pseries_smp_ops = {
 	.message_pass	= NULL,	/* Use smp_muxed_ipi_message_pass */
 	.cause_ipi	= NULL,	/* Filled at runtime by pSeries_smp_probe() */
-	.cause_nmi_ipi	= NULL,
+	.cause_nmi_ipi	= pseries_cause_nmi_ipi,
 	.probe		= pSeries_smp_probe,
 	.kick_cpu	= smp_pSeries_kick_cpu,
 	.setup_cpu	= smp_setup_cpu,
-- 
2.10.2
