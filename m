Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8D1271A0729
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2015 11:29:35 +1000 (AEST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 28 Jul 2015 11:29:33 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 929313578053
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2015 11:29:30 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6S1TLZs43974694
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2015 11:29:30 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6S1SvfY021759
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2015 11:28:57 +1000
Date: Tue, 28 Jul 2015 11:28:32 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alistair Popple <alistair@popple.id.au>
Cc: Daniel Axtens <dja@axtens.net>, linuxppc-dev@lists.ozlabs.org,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: eeh-powernv.c: Unbalanced IRQ warning
Message-ID: <20150728012832.GA26199@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1437982623.6262.56.camel@axtens.net> <2661799.peC5JiyMCl@mexican>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2661799.peC5JiyMCl@mexican>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 28, 2015 at 11:14:51AM +1000, Alistair Popple wrote:
>Hi Daniel,
>
>I see the problem - pnv_eeh_next_error() re-enables the interrupt but it gets 
>called from a loop if there are more outstanding events to process. The most 
>obvious solution would be to do this check before enabling interrupts:
>
>        if (ret == EEH_NEXT_ERR_NONE && eeh_enabled())
>
>instead of:
>
>        if (eeh_enabled())
>
>This should work fine so long as pnv_eeh_next_error() is called continuously 
>until is returns either EEH_NEXT_ERR_NONE or another value which signals that 
>pnv_eeh_next_error() should never be called again. As far as I can tell this 
>looks to be true (perhaps Gavin can confirm?)
>

Yeah, I confirmed. The way that Alistair fixes the issue is simple and more
precise. Please try his fix and ignore the one I sent couple of minutes
before.

Thanks,
Gavin

>Would you mind trying the below patch and seeing if it fixes the problem? 
>Thanks!
>
>-- >8 --
>>From 6eeed1d6dd25e8cf6bfe3423dc50ff855d1cbc42 Mon Sep 17 00:00:00 2001
>From: Alistair Popple <alistair@popple.id.au>
>
>---
> arch/powerpc/platforms/powernv/eeh-powernv.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
>index ca825ec..ff41c03 100644
>--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
>+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
>@@ -1478,7 +1478,7 @@ static int pnv_eeh_next_error(struct eeh_pe **pe)
> 	}
>
> 	/* Unmask the event */
>-	if (eeh_enabled())
>+	if (ret == EEH_NEXT_ERR_NONE && eeh_enabled())
> 		enable_irq(eeh_event_irq);
>
> 	return ret;
>-- 
>1.8.3.2
>
>
