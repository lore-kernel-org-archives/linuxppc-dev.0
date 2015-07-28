Return-Path: <alistair@popple.id.au>
Received: from ipmail04.adl6.internode.on.net (ipmail04.adl6.internode.on.net
 [150.101.137.141])
 by lists.ozlabs.org (Postfix) with ESMTP id 46AC11A1DDB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2015 15:39:35 +1000 (AEST)
From: Alistair Popple <alistair@popple.id.au>
To: Daniel Axtens <dja@axtens.net>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: eeh-powernv.c: Unbalanced IRQ warning
Date: Tue, 28 Jul 2015 15:39:30 +1000
Message-ID: <1443175.d713kqLmp2@mexican>
In-Reply-To: <1438048591.26043.11.camel@axtens.net>
References: <1437982623.6262.56.camel@axtens.net>
 <20150728012832.GA26199@gwshan> <1438048591.26043.11.camel@axtens.net>
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

On Tue, 28 Jul 2015 11:56:31 Daniel Axtens wrote:
> Hi Alistair and Gavin,
> 
> The patch from Alistair fixes my issue. Thanks heaps!
> 
> Alistair, are you right to post that formally?

Yep. I'll post it tomorrow morning.

> Regards,
> Daniel
> 
> On Tue, 2015-07-28 at 11:28 +1000, Gavin Shan wrote:
> > On Tue, Jul 28, 2015 at 11:14:51AM +1000, Alistair Popple wrote:
> > >Hi Daniel,
> > >
> > >I see the problem - pnv_eeh_next_error() re-enables the interrupt but it gets 
> > >called from a loop if there are more outstanding events to process. The most 
> > >obvious solution would be to do this check before enabling interrupts:
> > >
> > >        if (ret == EEH_NEXT_ERR_NONE && eeh_enabled())
> > >
> > >instead of:
> > >
> > >        if (eeh_enabled())
> > >
> > >This should work fine so long as pnv_eeh_next_error() is called continuously 
> > >until is returns either EEH_NEXT_ERR_NONE or another value which signals that 
> > >pnv_eeh_next_error() should never be called again. As far as I can tell this 
> > >looks to be true (perhaps Gavin can confirm?)
> > >
> > 
> > Yeah, I confirmed. The way that Alistair fixes the issue is simple and more
> > precise. Please try his fix and ignore the one I sent couple of minutes
> > before.
> > 
> > Thanks,
> > Gavin
> > 
> > >Would you mind trying the below patch and seeing if it fixes the problem? 
> > >Thanks!
> > >
> > >-- >8 --
> > >>From 6eeed1d6dd25e8cf6bfe3423dc50ff855d1cbc42 Mon Sep 17 00:00:00 2001
> > >From: Alistair Popple <alistair@popple.id.au>
> > >
> > >---
> > > arch/powerpc/platforms/powernv/eeh-powernv.c | 2 +-
> > > 1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > >diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
> > >index ca825ec..ff41c03 100644
> > >--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
> > >+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
> > >@@ -1478,7 +1478,7 @@ static int pnv_eeh_next_error(struct eeh_pe **pe)
> > > 	}
> > >
> > > 	/* Unmask the event */
> > >-	if (eeh_enabled())
> > >+	if (ret == EEH_NEXT_ERR_NONE && eeh_enabled())
> > > 		enable_irq(eeh_event_irq);
> > >
> > > 	return ret;
> > 
> 
> 
