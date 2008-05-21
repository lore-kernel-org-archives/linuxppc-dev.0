Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1EFB6DEA09
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 07:47:36 +1000 (EST)
Date: Wed, 21 May 2008 15:57:55 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] [POWERPC] mpic: deal with bogus NIRQ in Feature Reporting
	Register
Message-ID: <Pine.LNX.4.64.0805211557380.31707@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Some chips (like the SoCs from Freescale) report the wrong value in NIRQ
and this causes issues if its doesn't match or exceed the value of
irq_count.

Add a flag that board code can set to just use irq_count instead of
FRR[NIRQ].  Eventually we'll add a device tree property with the number
of sources.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/sysdev/mpic.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 8619f2a..4530b38 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -1144,9 +1144,9 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 	mpic->num_cpus = ((greg_feature & MPIC_GREG_FEATURE_LAST_CPU_MASK)
 			  >> MPIC_GREG_FEATURE_LAST_CPU_SHIFT) + 1;
 	if (isu_size == 0)
-		mpic->num_sources =
+		mpic->num_sources = max(mpic->irq_count,
 			((greg_feature & MPIC_GREG_FEATURE_LAST_SRC_MASK)
-			 >> MPIC_GREG_FEATURE_LAST_SRC_SHIFT) + 1;
+			 >> MPIC_GREG_FEATURE_LAST_SRC_SHIFT) + 1);

 	/* Map the per-CPU registers */
 	for (i = 0; i < mpic->num_cpus; i++) {
-- 
1.5.4.5
