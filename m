Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v2TKm6dFDzDqmC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jan 2017 10:03:08 +1100 (AEDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id v0GN2Hbg017307
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jan 2017 17:02:22 -0600
Message-ID: <1484607744.24294.15.camel@kernel.crashing.org>
Subject: [PATCH] powerpc: Disable HFSCR:TM if TM not supported
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Date: Mon, 16 Jan 2017 17:02:24 -0600
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
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
index 6824157..31d7071 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -245,6 +245,16 @@ static void cpu_ready_for_interrupts(void)
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
