Return-Path: <B29882@freescale.com>
Received: from VA3EHSOBE005.bigfish.com (va3ehsobe005.messaging.microsoft.com
 [216.32.180.31]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id D81441007DB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Oct 2011 09:54:13 +1100 (EST)
Received: from mail48-va3 (localhost [127.0.0.1])	by mail48-va3-R.bigfish.com
 (Postfix) with ESMTP id 1D28F2400C6	for
 <linuxppc-dev@lists.ozlabs.org>; Tue,
 25 Oct 2011 22:54:05 +0000 (UTC)
Received: from VA3EHSMHS017.bigfish.com (unknown [10.7.14.238])	by
 mail48-va3.bigfish.com (Postfix) with ESMTP id ED76022004A	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Oct 2011 22:54:04 +0000 (UTC)
From: Matthew McClintock <msm@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <kumar.gala@freescale.com>
Subject: [PATCH 1/5] powerpc/85xx: issue 15 EOI after core reset
Date: Tue, 25 Oct 2011 17:54:02 -0500
Message-ID: <1319583246-6120-1-git-send-email-msm@freescale.com>
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

This is listed as a requirement after issuing a core reset to
properly clear pending interrupts

Signed-off-by: Matthew McClintock <msm@freescale.com>
---
 arch/powerpc/sysdev/mpic.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 9678081..f5b83f0 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -1748,6 +1748,7 @@ void mpic_reset_core(int cpu)
 	struct mpic *mpic = mpic_primary;
 	u32 pir;
 	int cpuid = get_hard_smp_processor_id(cpu);
+	int i;
 
 	/* Set target bit for core reset */
 	pir = mpic_read(mpic->gregs, MPIC_INFO(GREG_PROCESSOR_INIT));
@@ -1759,6 +1760,12 @@ void mpic_reset_core(int cpu)
 	pir &= ~(1 << cpuid);
 	mpic_write(mpic->gregs, MPIC_INFO(GREG_PROCESSOR_INIT), pir);
 	mpic_read(mpic->gregs, MPIC_INFO(GREG_PROCESSOR_INIT));
+
+	/* Perform 15 EOI on each reset core to clear pending interrupts */
+	for (i = 0; i < 15; i++) {
+		_mpic_write(mpic->reg_type, &mpic->cpuregs[cpuid],
+				      MPIC_CPU_EOI, 0);
+	}
 }
 #endif /* CONFIG_SMP */
 
-- 
1.7.6.1
