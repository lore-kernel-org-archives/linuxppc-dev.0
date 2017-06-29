Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wz1MT0807zDr4l
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 23:53:08 +1000 (AEST)
Message-ID: <1498744380.3651.45.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/powernv: Tell OPAL about our MMU mode
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc dev list
 <linuxppc-dev@lists.ozlabs.org>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, Michael Neuling
 <michael.neuling@au1.ibm.com>
Date: Thu, 29 Jun 2017 08:53:00 -0500
In-Reply-To: <87efu3bc2z.fsf@concordia.ellerman.id.au>
References: <1498421118.31581.110.camel@kernel.crashing.org>
 <87a84sd72z.fsf@concordia.ellerman.id.au>
 <1498655175.3651.43.camel@kernel.crashing.org>
 <87efu3bc2z.fsf@concordia.ellerman.id.au>
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

On Thu, 2017-06-29 at 15:24 +1000, Michael Ellerman wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> 
> > On Wed, 2017-06-28 at 15:17 +1000, Michael Ellerman wrote:
> > > Which doesn't really make sense. FSP says it's running (runtime).
> > > 
> > > The end of the OPAL log is below.
> > > 
> > > I think your patch means we're now calling slw_reinit(), whereas
> > > previously we would skip it?
> > 
> > Ugh... and slw_reinit() is somewhat broken I suppose these days. Drat.
> > 
> > Mikey, we probably need to key that off arch 300 or check for a DT prop
> > skiboot would put in that tells Linux it can do this.
> 
> DT prop of accepted reinit flags seems like it would work.
> 
> No prop means HILE_LE/HILE_BE

Maybe... The bug is only with p8 (and I'm changing skiboot to fix
even that) so I think I may just key off ARCH300... we'll see when I
get back to it, got bogged down with other things.

Ben.
