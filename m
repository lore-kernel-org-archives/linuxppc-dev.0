Return-Path: <B29882@freescale.com>
Received: from DB3EHSOBE001.bigfish.com (db3ehsobe001.messaging.microsoft.com
 [213.199.154.139])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id DA62F1007DA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Oct 2011 05:33:59 +1100 (EST)
From: Matthew McClintock <msm@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <kumar.gala@freescale.com>
Subject: [PATCH v3 1/5] powerpc/85xx: issue 15 EOI after core reset for FSL
 CoreNet devices
Date: Wed, 26 Oct 2011 13:33:48 -0500
Message-ID: <1319654028-30478-1-git-send-email-msm@freescale.com>
In-Reply-To: <08F58B37-0825-4C07-91B3-1040A7E70528@freescale.com>
References: <08F58B37-0825-4C07-91B3-1040A7E70528@freescale.com>
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

This is listed as a requirement for Freescale CoreNet based devices  (e.g
p4080ds with MPIC v4.x) after issuing a core reset to properly clear pending
interrupts.

Signed-off-by: Matthew McClintock <msm@freescale.com>
---
 v2: Updated commit message
 v3: Added detail in code comment as well

arch/powerpc/sysdev/mpic.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 9678081..d641481 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -1748,6 +1748,7 @@ void mpic_reset_core(int cpu)
 	struct mpic *mpic = mpic_primary;
 	u32 pir;
 	int cpuid = get_hard_smp_processor_id(cpu);
+	int i;
 
 	/* Set target bit for core reset */
 	pir = mpic_read(mpic->gregs, MPIC_INFO(GREG_PROCESSOR_INIT));
@@ -1759,6 +1760,13 @@ void mpic_reset_core(int cpu)
 	pir &= ~(1 << cpuid);
 	mpic_write(mpic->gregs, MPIC_INFO(GREG_PROCESSOR_INIT), pir);
 	mpic_read(mpic->gregs, MPIC_INFO(GREG_PROCESSOR_INIT));
+
+	/* Perform 15 EOI on each reset core to clear pending interrupts.
+	 * This is required for FSL CoreNet based devices */
+	for (i = 0; i < 15; i++) {
+		_mpic_write(mpic->reg_type, &mpic->cpuregs[cpuid],
+				      MPIC_CPU_EOI, 0);
+	}
 }
 #endif /* CONFIG_SMP */
 
-- 
1.7.6.1
