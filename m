Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xCcPr5NVXzDrCw
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 11:53:52 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id o88so1234448pfk.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 18:53:52 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <masriniv@in.ibm.com>,
 Anton Blanchard <anton@samba.org>, Michael Neuling <mikey@neuling.org>,
 Gautham R Shenoy <ego@linux.vnet.ibm.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Subject: [PATCH] POWER9 PMU stops after idle workaround
Date: Thu, 20 Jul 2017 11:53:22 +1000
Message-Id: <20170720015322.24307-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

POWER9 DD2 PMU can stop after a state-loss idle in some conditions.

A solution is to set then clear MMCRA[60] after wake from state-loss
idle.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/idle_book3s.S | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index 516ebef905c0..e6252c5a57a4 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -460,11 +460,17 @@ pnv_restore_hyp_resource_arch300:
 	/*
 	 * Workaround for POWER9, if we lost resources, the ERAT
 	 * might have been mixed up and needs flushing. We also need
-	 * to reload MMCR0 (see comment above).
+	 * to reload MMCR0 (see comment above). We also need to set
+	 * then clear bit 60 in MMCRA to ensure the PMU starts running.
 	 */
 	blt	cr3,1f
 	PPC_INVALIDATE_ERAT
 	ld	r1,PACAR1(r13)
+	mfspr	r4,SPRN_MMCRA
+	ori	r4,r4,(1 << (63-60))
+	mtspr	SPRN_MMCRA,r4
+	xori	r4,r4,(1 << (63-60))
+	mtspr	SPRN_MMCRA,r4
 	ld	r4,_MMCR0(r1)
 	mtspr	SPRN_MMCR0,r4
 1:
-- 
2.11.0
