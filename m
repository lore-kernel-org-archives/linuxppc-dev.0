Return-Path: <npiggin@suse.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 6F9C8B70AD
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 20 Jul 2009 20:38:45 +1000 (EST)
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 04E8BDDD01
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Jul 2009 20:38:45 +1000 (EST)
Date: Mon, 20 Jul 2009 12:38:35 +0200
From: Nick Piggin <npiggin@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC/PATCH] mm: Pass virtual address to [__]p{te, ud,
	md}_free_tlb()
Message-ID: <20090720103835.GB7070@wotan.suse.de>
References: <20090715074952.A36C7DDDB2@ozlabs.org>
	<20090715135620.GD7298@wotan.suse.de>
	<1247709255.27937.5.camel@pasglop>
	<20090720081054.GH7298@wotan.suse.de>
	<1248084041.30899.7.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1248084041.30899.7.camel@pasglop>
Cc: Linux-Arch <linux-arch@vger.kernel.org>,
	Linux Memory Management <linux-mm@kvack.org>,
	Hugh Dickins <hugh@tiscali.co.uk>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 20, 2009 at 08:00:41PM +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2009-07-20 at 10:10 +0200, Nick Piggin wrote:
> > 
> > Maybe I don't understand your description correctly. The TLB contains
> > PMDs, but you say the HW still logically performs another translation
> > step using entries in the PMD pages? If I understand that correctly,
> > then generic mm does not actually care and would logically fit better
> > if those entries were "linux ptes". 
> 
> They are :-)
> 
> > The pte invalidation routines
> > give the virtual address, which you could use to invalidate the TLB.
> 
> For PTEs, yes, but not for those PMD entries. IE. I need the virtual
> address when destroying PMDs so that I can invalidate those "indirect"
> pages. PTEs are already taken care of by existing mechanisms.

Hmm, so even after having invalidated all the pte translations
then you still need to invalidate the empty indirect page? (or
maybe you don't even invalidate the ptes if they're not cached
in a TLB).

I believe x86 is also allowed to cache higher level page tables
in non-cache coherent storage, and I think it just avoids this
issue by flushing the entire TLB when potentially tearing down
upper levels. So in theory I think your patch could allow x86 to
use invlpg more often as well (in practice the flush-all case
and TLB refills are so fast in comparison with invlpg that it
probably doesn't gain much especially when talking about
invalidating upper levels). So making the generic VM more
flexible like that is no problem for me.
