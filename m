Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9775B1412DA
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 May 2014 17:19:48 +1000 (EST)
Message-ID: <1399360775.20388.112.camel@pasglop>
Subject: Re: [PATCH] KVM: PPC: BOOK3S: HV: Don't try to allocate from kernel
 page allocator for hash page table.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexander Graf <agraf@suse.de>
Date: Tue, 06 May 2014 17:19:35 +1000
In-Reply-To: <536889C6.1050603@suse.de>
References: <1399224322-22028-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <53677558.50900@suse.de> <87r4489ttk.fsf@linux.vnet.ibm.com>
 <20FFDF8F-1A3D-4719-B492-1E4B70F9D1B4@suse.de>
 <1399334797.20388.71.camel@pasglop> <536889C6.1050603@suse.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "paulus@samba.org" <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-05-06 at 09:05 +0200, Alexander Graf wrote:
> On 06.05.14 02:06, Benjamin Herrenschmidt wrote:
> > On Mon, 2014-05-05 at 17:16 +0200, Alexander Graf wrote:
> >> Isn't this a greater problem? We should start swapping before we hit
> >> the point where non movable kernel allocation fails, no?
> > Possibly but the fact remains, this can be avoided by making sure that
> > if we create a CMA reserve for KVM, then it uses it rather than using
> > the rest of main memory for hash tables.
> 
> So why were we preferring non-CMA memory before? Considering that Aneesh 
> introduced that logic in fa61a4e3 I suppose this was just a mistake?

I assume so.

> >> The fact that KVM uses a good number of normal kernel pages is maybe
> >> suboptimal, but shouldn't be a critical problem.
> > The point is that we explicitly reserve those pages in CMA for use
> > by KVM for that specific purpose, but the current code tries first
> > to get them out of the normal pool.
> >
> > This is not an optimal behaviour and is what Aneesh patches are
> > trying to fix.
> 
> I agree, and I agree that it's worth it to make better use of our 
> resources. But we still shouldn't crash.

Well, Linux hitting out of memory conditions has never been a happy
story :-)

> However, reading through this thread I think I've slowly grasped what 
> the problem is. The hugetlbfs size calculation.

Not really.

> I guess something in your stack overreserves huge pages because it 
> doesn't account for the fact that some part of system memory is already 
> reserved for CMA.

Either that or simply Linux runs out because we dirty too fast...
really, Linux has never been good at dealing with OO situations,
especially when things like network drivers and filesystems try to do
ATOMIC or NOIO allocs...
 
> So the underlying problem is something completely orthogonal. The patch 
> body as is is fine, but the patch description should simply say that we 
> should prefer the CMA region because it's already reserved for us for 
> this purpose and we make better use of our available resources that way.

No.

We give a chunk of memory to hugetlbfs, it's all good and fine.

Whatever remains is split between CMA and the normal page allocator.

Without Aneesh latest patch, when creating guests, KVM starts allocating
it's hash tables from the latter instead of CMA (we never allocate from
hugetlb pool afaik, only guest pages do that, not hash tables).

So we exhaust the page allocator and get linux into OOM conditions
while there's plenty of space in CMA. But the kernel cannot use CMA for
it's own allocations, only to back user pages, which we don't care about
because our guest pages are covered by our hugetlb reserve :-)

> All the bits about pinning, numa, libvirt and whatnot don't really 
> matter and are just details that led Aneesh to find this non-optimal 
> allocation.

Cheers,
Ben.
