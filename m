Return-Path: <srs0=i+vg=25=kernel.crashing.org=benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vmmlf0GxnzDqYB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Mar 2017 17:49:50 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vmmld67Bdz8wHb
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Mar 2017 17:49:49 +1100 (AEDT)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vmmld1PCXz9s2x
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Mar 2017 17:49:48 +1100 (AEDT)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org
Subject: [PATCH 01/12] powerpc: Disable HFSCR:TM if TM not supported
Date: Mon, 20 Mar 2017 17:49:03 +1100
Message-Id: <20170320064914.4437-1-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Otherwise KVM guests might mess with it even when told not
to causing bad thing interrupts in the host

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/setup_64.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 9cfaa8b..b372b23 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -236,6 +236,16 @@ static void cpu_ready_for_interrupts(void)
 		mtspr(SPRN_LPCR, lpcr | LPCR_AIL_3);
 	}
 
+	/*
+	 * Fixup HFSCR:TM based on CPU features. The bit is set by our
+	 * early asm init because at that point we haven't updated our
+	 * CPU features from firmware and device-tree. Here we have,
+	 * so let's do it
+	 */
+	if (early_cpu_has_feature(CPU_FTR_HVMODE) &&
+	    !early_cpu_has_feature(CPU_FTR_TM_COMP))
+		mtspr(SPRN_HFSCR, mfspr(SPRN_HFSCR) & ~HFSCR_TM);
+
 	/* Set IR and DR in PACA MSR */
 	get_paca()->kernel_msr = MSR_KERNEL;
 }
-- 
2.9.3
