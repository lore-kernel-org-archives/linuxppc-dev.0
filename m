Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yyjsR5y9vzDrmx
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Dec 2017 19:15:07 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id b18so5307358pgv.10
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Dec 2017 00:15:07 -0800 (PST)
From: Balbir Singh <bsingharora@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: npiggin@gmail.com, mpe@ellerman.id.au, Balbir Singh <bsingharora@gmail.com>
Subject: [PATCH v4 1/2] powerpc/crash: Remove the test for cpu_online in the
 IPI callback
Date: Fri, 15 Dec 2017 19:14:54 +1100
Message-Id: <20171215081455.11941-1-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Our check was extra cautious, we've audited crash_send_ipi
and it sends an IPI only to online CPU's. Removal of this
check should have not functional impact on crash kdump.

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/powerpc/kernel/crash.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/powerpc/kernel/crash.c b/arch/powerpc/kernel/crash.c
index cbabb5adccd9..29c56ca2ddfd 100644
--- a/arch/powerpc/kernel/crash.c
+++ b/arch/powerpc/kernel/crash.c
@@ -69,9 +69,6 @@ static void crash_ipi_callback(struct pt_regs *regs)
 
 	int cpu = smp_processor_id();
 
-	if (!cpu_online(cpu))
-		return;
-
 	hard_irq_disable();
 	if (!cpumask_test_cpu(cpu, &cpus_state_saved)) {
 		crash_save_cpu(regs, cpu);
-- 
2.13.6
