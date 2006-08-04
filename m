Return-Path: <mporter@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 932A6679E7
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Aug 2006 02:40:17 +1000 (EST)
Received: from gate.crashing.org (localhost [127.0.0.1])
	by gate.crashing.org (8.12.8/8.12.8) with ESMTP id k74Gi1iH005436
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Aug 2006 11:44:01 -0500
Received: (from mporter@localhost)
	by gate.crashing.org (8.12.8/8.12.8/Submit) id k74Gi1Rm005435
	for linuxppc-dev@ozlabs.org; Fri, 4 Aug 2006 11:44:01 -0500
Date: Fri, 4 Aug 2006 11:44:01 -0500
From: Matt Porter <mporter@embeddedalley.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Fix powerpc 44x_mmu build
Message-ID: <20060804164401.GB4959@gate.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The PIN_SIZE definition name changed, update 44x_mmu.c accordingly.

Signed-off-by: Matt Porter <mporter@embeddedalley.com>

diff --git a/arch/powerpc/mm/44x_mmu.c b/arch/powerpc/mm/44x_mmu.c
index 3d79ce2..e0152a9 100644
--- a/arch/powerpc/mm/44x_mmu.c
+++ b/arch/powerpc/mm/44x_mmu.c
@@ -104,7 +104,7 @@ unsigned long __init mmu_mapin_ram(void)
 
 	/* Determine number of entries necessary to cover lowmem */
 	pinned_tlbs = (unsigned int)
-		(_ALIGN(total_lowmem, PPC44x_PIN_SIZE) >> PPC44x_PIN_SHIFT);
+		(_ALIGN(total_lowmem, PPC_PIN_SIZE) >> PPC44x_PIN_SHIFT);
 
 	/* Write upper watermark to save location */
 	tlb_44x_hwater = PPC44x_LOW_SLOT - pinned_tlbs;
@@ -112,7 +112,7 @@ unsigned long __init mmu_mapin_ram(void)
 	/* If necessary, set additional pinned TLBs */
 	if (pinned_tlbs > 1)
 		for (i = (PPC44x_LOW_SLOT-(pinned_tlbs-1)); i < PPC44x_LOW_SLOT; i++) {
-			unsigned int phys_addr = (PPC44x_LOW_SLOT-i) * PPC44x_PIN_SIZE;
+			unsigned int phys_addr = (PPC44x_LOW_SLOT-i) * PPC_PIN_SIZE;
 			ppc44x_pin_tlb(i, phys_addr+PAGE_OFFSET, phys_addr);
 		}
 
