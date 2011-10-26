Return-Path: <B29882@freescale.com>
Received: from VA3EHSOBE003.bigfish.com (va3ehsobe003.messaging.microsoft.com
 [216.32.180.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 11CC3B6F94
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Oct 2011 05:47:15 +1100 (EST)
From: Matthew McClintock <msm@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <kumar.gala@freescale.com>
Subject: [PATCH v4 1/5] powerpc/85xx: issue 15 EOI after core reset for FSL
 CoreNet devices
Date: Wed, 26 Oct 2011 13:46:57 -0500
Message-ID: <1319654817-14087-1-git-send-email-msm@freescale.com>
In-Reply-To: <1319654028-30478-1-git-send-email-msm@freescale.com>
References: <1319654028-30478-1-git-send-email-msm@freescale.com>
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
 v4: Check for MPIC_FSL in mpic->flags to determine if we need 15 EOIs

 arch/powerpc/sysdev/mpic.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 9678081..0842c6f 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -1748,6 +1748,7 @@ void mpic_reset_core(int cpu)
 	struct mpic *mpic = mpic_primary;
 	u32 pir;
 	int cpuid = get_hard_smp_processor_id(cpu);
+	int i;
 
 	/* Set target bit for core reset */
 	pir = mpic_read(mpic->gregs, MPIC_INFO(GREG_PROCESSOR_INIT));
@@ -1759,6 +1760,15 @@ void mpic_reset_core(int cpu)
 	pir &= ~(1 << cpuid);
 	mpic_write(mpic->gregs, MPIC_INFO(GREG_PROCESSOR_INIT), pir);
 	mpic_read(mpic->gregs, MPIC_INFO(GREG_PROCESSOR_INIT));
+
+	/* Perform 15 EOI on each reset core to clear pending interrupts.
+	 * This is required for FSL CoreNet based devices */
+	if (mpic->flags & MPIC_FSL) {
+		for (i = 0; i < 15; i++) {
+			_mpic_write(mpic->reg_type, &mpic->cpuregs[cpuid],
+				      MPIC_CPU_EOI, 0);
+		}
+	}
 }
 #endif /* CONFIG_SMP */
 
-- 
1.7.6.1
