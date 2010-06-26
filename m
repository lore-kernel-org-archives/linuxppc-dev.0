Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 047C1B6EFE
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 27 Jun 2010 08:58:46 +1000 (EST)
Subject: Re: [PATCH 1/2] KVM: PPC: Add generic hpte management functions
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Avi Kivity <avi@redhat.com>
In-Reply-To: <4C20AA9B.8000807@redhat.com>
References: <1277127841-32704-1-git-send-email-agraf@suse.de>
	<4C20A64D.2070805@redhat.com> <4C20A6C8.4070002@suse.de>
	<4C20A795.6040607@redhat.com> <4C20A836.2010908@suse.de>
	<4C20A890.9040806@redhat.com> <4C20A91A.1080607@suse.de>
	<4C20AA9B.8000807@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 27 Jun 2010 08:58:38 +1000
Message-ID: <1277593118.4200.122.camel@pasglop>
Mime-Version: 1.0
Cc: kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Alexander Graf <agraf@suse.de>, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2010-06-22 at 15:20 +0300, Avi Kivity wrote:
> On 06/22/2010 03:14 PM, Alexander Graf wrote:
> > Avi Kivity wrote:
> >    
> >> On 06/22/2010 03:10 PM, Alexander Graf wrote:
> >>      
> >>> If you have more performance hints, I'll gladly take them :).
> >>>
> >>>        
> >> Using a cpu that virtualizes the mmu in hardware helps tremendously.
> >>
> >>      
> > PPC never does that. Even with the virtualization extensions the MMU is
> > still software managed.
> 
> Then mmu intensive loads can expect to be slow.

Well, depends. ppc64 indeed requires the hash to be managed by the
hypervisor, so inserting or invalidating translations will mean a
roundtrip to the hypervisor, though there are ways at least the
insertion could be alleviated (for example, the HV could service the
hash misses directly walking the guest page tables).

But that's due in part to a design choice (whether it's a good one or
not I'm not going to argue here) which favors huge reasonably static
workloads where the hash is expected to contain all translations for
everything.

However, note that BookE (the embedded variant of the architecture) uses
a different model for virtualization, including options in its latest
variant for a HW logical->real translation (via a small dedicated TLB)
and direct access to some TLB ops from the guest.

> > I was also more thinking of hints like
> > "kmem_cache_zalloc is slow" or so ;).
> >    
> 
> Stuff like that is usually worthless.  To give real feedback I need to 
> understand the hardware, so I'm reduced to coding style and indentation 
> review.

In that case, I'd say that BAT manipulation is rare enough (mostly only
at boot time) to warrant indeed speeding up the normal PTE operations &
invalidations at the expense of the BAT change case.

Cheers,
Ben.
