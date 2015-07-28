Return-Path: <alistair@popple.id.au>
Received: from ipmail05.adl6.internode.on.net (ipmail05.adl6.internode.on.net
 [150.101.137.143])
 by lists.ozlabs.org (Postfix) with ESMTP id B5AE41A076A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2015 11:15:31 +1000 (AEST)
From: Alistair Popple <alistair@popple.id.au>
To: Daniel Axtens <dja@axtens.net>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: eeh-powernv.c: Unbalanced IRQ warning
Date: Tue, 28 Jul 2015 11:14:51 +1000
Message-ID: <2661799.peC5JiyMCl@mexican>
In-Reply-To: <1437982623.6262.56.camel@axtens.net>
References: <1437982623.6262.56.camel@axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Daniel,

I see the problem - pnv_eeh_next_error() re-enables the interrupt but it gets 
called from a loop if there are more outstanding events to process. The most 
obvious solution would be to do this check before enabling interrupts:

        if (ret == EEH_NEXT_ERR_NONE && eeh_enabled())

instead of:

        if (eeh_enabled())
 
This should work fine so long as pnv_eeh_next_error() is called continuously 
until is returns either EEH_NEXT_ERR_NONE or another value which signals that 
pnv_eeh_next_error() should never be called again. As far as I can tell this 
looks to be true (perhaps Gavin can confirm?)

Would you mind trying the below patch and seeing if it fixes the problem? 
Thanks!

-- >8 --
>From 6eeed1d6dd25e8cf6bfe3423dc50ff855d1cbc42 Mon Sep 17 00:00:00 2001
From: Alistair Popple <alistair@popple.id.au>

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
