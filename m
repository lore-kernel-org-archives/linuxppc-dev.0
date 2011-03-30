Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 19EBBB6F01
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 31 Mar 2011 07:54:11 +1100 (EST)
Date: Wed, 30 Mar 2011 13:53:32 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: mmotm threatens ppc preemption again
Message-Id: <20110330135332.9c322e40.akpm@linux-foundation.org>
In-Reply-To: <1300674150.2402.207.camel@pasglop>
References: <alpine.LSU.2.00.1103192041390.1592@sister.anvils>
	<1300665188.2402.64.camel@pasglop>
	<alpine.LSU.2.00.1103201814320.7035@sister.anvils>
	<1300672207.2402.205.camel@pasglop>
	<alpine.LSU.2.00.1103201901340.7257@sister.anvils>
	<1300674150.2402.207.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org, Jeremy Fitzhardinge <jeremy@goop.org>,
	Hugh Dickins <hughd@google.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 21 Mar 2011 13:22:30 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Sun, 2011-03-20 at 19:20 -0700, Hugh Dickins wrote:
> > > As long as the races to avoid are between map/unmap vs. access, yes, it
> > > -should- be fine, and we used to not do demand faulting on kernel space
> > > (but for how long ?). I'm wondering why we don't just stick a ptl in
> > > there or is there a good reason why we can't ?
> > 
> > We can - but we usually prefer to avoid unnecessary locking.
> > An arch function which locks init_mm.page_table_lock on powerpc,
> > but does nothing on others? 
> 
> That still means gratuitous differences between how the normal and
> kernel page tables are handled. Maybe that's not worth bothering ...

So what will we do here?  I still have

mm-remove-unused-token-argument-from-apply_to_page_range-callback.patch
mm-add-apply_to_page_range_batch.patch
ioremap-use-apply_to_page_range_batch-for-ioremap_page_range.patch
vmalloc-use-plain-pte_clear-for-unmaps.patch
vmalloc-use-apply_to_page_range_batch-for-vunmap_page_range.patch
vmalloc-use-apply_to_page_range_batch-for-vmap_page_range_noflush.patch
vmalloc-use-apply_to_page_range_batch-in-alloc_vm_area.patch
xen-mmu-use-apply_to_page_range_batch-in-xen_remap_domain_mfn_range.patch
xen-grant-table-use-apply_to_page_range_batch.patch

floating around and at some stage they may cause merge problems.
