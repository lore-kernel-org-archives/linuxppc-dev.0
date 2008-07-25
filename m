Return-Path: <sebastien.dugue@bull.net>
Received: from ecfrec.frec.bull.fr (ecfrec.frec.bull.fr [129.183.4.8])
	by ozlabs.org (Postfix) with ESMTP id E2065DE3EF
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jul 2008 18:47:00 +1000 (EST)
Date: Fri, 25 Jul 2008 10:47:30 +0200
From: Sebastien Dugue <sebastien.dugue@bull.net>
To: benh@kernel.crashing.org
Subject: Re: [PATCH 2/2][RT] powerpc - Make the irq reverse mapping radix
	tree lockless
Message-ID: <20080725104730.2211e057@bull.net>
In-Reply-To: <1216975221.11188.102.camel@pasglop>
References: <20080724122352.3bc76bda@bull.net>
	<20080724125044.53b604cb@bull.net>
	<200807242111.35338.nickpiggin@yahoo.com.au>
	<20080724141839.477de30b@bull.net>
	<1216972177.7257.351.camel@twins>
	<1216974440.11188.100.camel@pasglop>
	<20080725103601.2dbcd7e8@bull.net>
	<1216975221.11188.102.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Tim Chavez <tinytim@us.ibm.com>,
	Linux-rt <linux-rt-users@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Jean Pierre Dion <jean-pierre.dion@bull.net>,
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

On Fri, 25 Jul 2008 18:40:21 +1000 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Fri, 2008-07-25 at 10:36 +0200, Sebastien Dugue wrote:
> > On Fri, 25 Jul 2008 18:27:20 +1000 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > 
> > > On Fri, 2008-07-25 at 09:49 +0200, Peter Zijlstra wrote:
> > > > 
> > > > 
> > > > The only advantage of the concurrent radix tree over this model is that
> > > > it can potentially do multiple modification operations at the same time.
> > > 
> > > Yup, we do not need that for the irq revmap... concurrent lookup is all we need.
> > > 
> > 
> >   Shouldn't we care about concurrent insertion and deletion in the tree? I agree
> > that concern might be a bit artificial but in theory that can happen.
> 
> Yes, we just need to protect it with a big hammer, like a spinlock, it's
> not a performance critical code path.

  Agreed. Will look into this in the next few days.

  Thanks,

  Sebastien.
