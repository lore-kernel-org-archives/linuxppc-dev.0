Return-Path: <sebastien.dugue@bull.net>
Received: from ecfrec.frec.bull.fr (ecfrec.frec.bull.fr [129.183.4.8])
	by ozlabs.org (Postfix) with ESMTP id 1B3ADDE014
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jul 2008 21:07:38 +1000 (EST)
Date: Thu, 24 Jul 2008 13:08:07 +0200
From: Sebastien Dugue <sebastien.dugue@bull.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 0/2][RT] powerpc - fix bug in irq reverse mapping radix
	tree
Message-ID: <20080724130807.23d5252b@bull.net>
In-Reply-To: <1216851458.11027.346.camel@pasglop>
References: <20080723165932.57e3ada2@bull.net>
	<1216851458.11027.346.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Tim Chavez <tinytim@us.ibm.com>,
	Linux RT Users <linux-rt-users@vger.kernel.org>,
	Jean Pierre Dion <jean-pierre.dion@bull.net>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	Gilles Carry <Gilles.Carry@ext.bull.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 24 Jul 2008 08:17:38 +1000 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> >   The root cause of this bug lies in the fact that the XICS interrupt controller
> > uses a radix tree for its reverse irq mapping and that we cannot allocate the tree
> > nodes (even GFP_ATOMIC) with preemption disabled.
> 
> Is that yet another caes of -rt changing some basic kernel semantics ?

  Ahem, not really new: http://lkml.org/lkml/2007/11/12/211

> 
> >   In fact, we have 2 nested preemption disabling when we want to allocate
> > a new node:
> > 
> >   - setup_irq() does a spin_lock_irqsave() before calling xics_startup() which
> >     then calls irq_radix_revmap() to insert a new node in the tree
> > 
> >   - irq_radix_revmap() also does a spin_lock_irqsave() (in irq_radix_wrlock())
> >     before the radix_tree_insert()
> > 
> >   The first patch moves the call to irq_radix_revmap() from xics_startup() out to
> > xics_host_map_direct() and xics_host_map_lpar() which are called with preemption
> > enabled.
> 
> I suppose that would work.

  It should indeed. Instead of inserting the new mapping at request_irq() time,
we do it a bit before at create_irq_mapping time.

> 
> >   The second patch is a little more involved in that it takes advantage of
> > the concurrent radix tree to simplify the locking requirements and allows
> > to allocate a new node outside a preemption disabled section.
> > 
> >   I just hope I've correctly understood the concurrent radix trees semantic
> > and got the (absence of) locking right.
> 
> Hrm, that will need some scrutinity.

  Yep, that will need a few more pair of eyes along with brains behind those ;-)

  Thanks,

  Sebastien.

> 
> Thanks for looking at this.
> 
> Cheers,
> Ben.
> 
> 
> 
