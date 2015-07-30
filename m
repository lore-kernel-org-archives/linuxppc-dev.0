Return-Path: <apopple@au1.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DC2771A1BE8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2015 16:55:17 +1000 (AEST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <apopple@au1.ibm.com>;
 Thu, 30 Jul 2015 16:55:14 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id C06242BB0052
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2015 16:55:10 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6U6t2NF6095074
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2015 16:55:10 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6U6sbgc030301
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2015 16:54:38 +1000
From: Alistair Popple <alistair@popple.id.au>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, dja@axtens.net, gwshan@linux.vnet.ibm.com,
 Alistair Popple <alistair@popple.id.au>
Subject: [PATCH] powerpc/eeh-powernv: Fix unbalanced IRQ warning
Date: Thu, 30 Jul 2015 16:53:54 +1000
Message-Id: <1438239234-29480-1-git-send-email-alistair@popple.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

pnv_eeh_next_error() re-enables the eeh opal event interrupt but it
gets called from a loop if there are more outstanding events to
process, resulting in a warning due to enabling an already enabled
interrupt. Instead the interrupt should only be re-enabled once the
last outstanding event has been processed.

Tested-by: Daniel Axtens <dja@axtens.net>
Reported-by: Daniel Axtens <dja@axtens.net>
Signed-off-by: Alistair Popple <alistair@popple.id.au>
Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-powernv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index ca825ec..ff41c03 100644
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
1.8.3.2
