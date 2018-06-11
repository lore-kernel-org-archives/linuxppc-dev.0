Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 413xZd5z7czF3G9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jun 2018 12:20:57 +1000 (AEST)
Message-ID: <cade6efff10d9d016b90536365b2ea89acc9d642.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH] powerpc/64s: remove POWER9 DD1 support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nicholas Piggin <npiggin@gmail.com>, Michal =?ISO-8859-1?Q?Such=E1nek?=
 <msuchanek@suse.de>
Cc: linuxppc-dev@lists.ozlabs.org
Date: Mon, 11 Jun 2018 12:20:46 +1000
In-Reply-To: <20180611113734.136fce95@roar.ozlabs.ibm.com>
References: <20180610133027.16819-1-npiggin@gmail.com>
 <20180610225811.35006b61@naga.suse.cz>
 <20180611113734.136fce95@roar.ozlabs.ibm.com>
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

On Mon, 2018-06-11 at 11:37 +1000, Nicholas Piggin wrote:
> 
> > > -
> > >  	/* Perform the acknowledge OS to register cycle. */
> > >  	ack = be16_to_cpu(__x_readw(__x_tima + TM_SPC_ACK_OS_REG));
> > >  
> > > @@ -105,7 +93,7 @@ static void GLUE(X_PFX,source_eoi)(u32 hw_irq,
> > > struct xive_irq_data *xd) *
> > >  		 * For LSIs, using the HW EOI cycle works around a
> > > problem
> > >  		 * on P9 DD1 PHBs where the other ESB accesses don't
> > > work
> > > -		 * properly.
> > > +		 * properly. XXX: can this be removed?
> > >  		 */
> > >  		if (xd->flags & XIVE_IRQ_FLAG_LSI)
> > >  			__x_readq(__x_eoi_page(xd) +  
> > 
> > Maybe this should be really removed or the comment changed to why it is
> > still useful?
> 
> Good point, I meant to ask Ben about that.

We should just update the comment, the game with PQ bits is not useful
for LSIs are they are automatically re-triggered in HW when still
pending. So even with no errata to work around, it's still the right
thing to do.

Cheers,
Ben.
