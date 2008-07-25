Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 45F5DDDE00
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jul 2008 15:14:27 +1000 (EST)
Subject: Re: [PATCH 2/2][RT] powerpc - Make the irq reverse mapping radix
	tree lockless
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
In-Reply-To: <200807242111.35338.nickpiggin@yahoo.com.au>
References: <20080724122352.3bc76bda@bull.net>
	<20080724125044.53b604cb@bull.net>
	<200807242111.35338.nickpiggin@yahoo.com.au>
Content-Type: text/plain
Date: Fri, 25 Jul 2008 15:13:39 +1000
Message-Id: <1216962819.11188.82.camel@pasglop>
Mime-Version: 1.0
Cc: Tim Chavez <tinytim@us.ibm.com>, Linux-rt <linux-rt-users@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Jean Pierre Dion <jean-pierre.dion@bull.net>,
	linux-ppc <linuxppc-dev@ozlabs.org>,
	Sebastien Dugue <sebastien.dugue@bull.net>,
	Paul Mackerras <paulus@samba.org>, Gilles Carry <Gilles.Carry@ext.bull.net>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> >   Concurrency between readers and writers are handled by the intrinsic
> > properties of the concurrent radix tree. Concurrency between the tree
> > initialization which is done asynchronously with readers and writers access
> > is handled via an atomic variable (revmap_trees_allocated) set when the
> > tree has been initialized and checked before any reader or writer access
> > just like we used to check for tree.gfp_mask != 0 before.
> 
> Hmm, RCU radix tree is in mainline too for quite a while. I thought
> Ben had already converted this code over ages ago...
> 
> Nothing against the -rt patch, but mainline should probably be updated
> to use RCU as well?

No, I haven't updated that code yet, and yes, we should do it :-)

Cheers,
Ben.
