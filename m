Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AEA801A0FEA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2015 16:55:07 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: dja@axtens.net,
	alistair@popple.id.au
Subject: [PATCH] powerpc/powernv: Fix unbalanced IRQ warning in eeh-powernv.c
Date: Thu, 30 Jul 2015 16:55:03 +1000
Message-Id: <1438239303-25488-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

To avoid EEH getting invoked repeatedly for the same error, the OPAL
interrupt that invokes EEH is masked at the start of the process.

Currently, pnv_eeh_next_error() re-enables the interrupt but it gets
called from a loop if there are more outstanding events to process.
This causes an unbalanced enable warning.

Check that there are no more errors before enabling interrupts.

Fixed-by: Alistair Popple <alistair@popple.id.au>
Tested-by: Daniel Axtens <dja@axtens.net> [and changelog]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/powernv/eeh-powernv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 5cf5e6ea213b..7cf0df859d05 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -1478,7 +1478,7 @@ static int pnv_eeh_next_error(struct eeh_pe **pe)
 	}
 
 	/* Unmask the event */
-	if (eeh_enabled())
+	if (ret == EEH_NEXT_ERR_NONE && eeh_enabled())
 		enable_irq(eeh_event_irq);
 
 	return ret;
-- 
2.1.4
