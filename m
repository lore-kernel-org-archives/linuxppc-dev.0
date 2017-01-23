Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v6JV61NtKzDqWc
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jan 2017 15:38:38 +1100 (AEDT)
Date: Mon, 23 Jan 2017 15:38:35 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: linuxppc-dev@ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH 13/18] KVM: PPC: Book3S HV: Page table construction and
 page faults for radix guests
Message-ID: <20170123043835.GC29357@fergus.ozlabs.ibm.com>
References: <1484212046-29591-1-git-send-email-paulus@ozlabs.org>
 <1484212046-29591-14-git-send-email-paulus@ozlabs.org>
 <1485141440.8172.4.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1485141440.8172.4.camel@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 23, 2017 at 02:17:20PM +1100, Suraj Jitindar Singh wrote:
> On Thu, 2017-01-12 at 20:07 +1100, Paul Mackerras wrote:
> > This adds the code to construct the second-level ("partition-scoped"
> > in
> > architecturese) page tables for guests using the radix MMU.  Apart
> > from
> > the PGD level, which is allocated when the guest is created, the rest
> > of the tree is all constructed in response to hypervisor page faults.
> > 
> > As well as hypervisor page faults for missing pages, we also get
> > faults
> > for reference/change (RC) bits needing to be set, as well as various
> > other error conditions.  For now, we only set the R or C bit in the
> > guest page table if the same bit is set in the host PTE for the
> > backing page.
> > 
> > This code can take advantage of the guest being backed with either
> > transparent or ordinary 2MB huge pages, and insert 2MB page entries
> > into the guest page tables.  There is no support for 1GB huge pages
> > yet.

[snip]

> > diff --git a/arch/powerpc/kvm/book3s_hv.c
> > b/arch/powerpc/kvm/book3s_hv.c
> > index 6bd0f4a..4c2d054 100644
> > --- a/arch/powerpc/kvm/book3s_hv.c
> > +++ b/arch/powerpc/kvm/book3s_hv.c
> > @@ -3357,7 +3357,10 @@ static void kvmppc_core_destroy_vm_hv(struct
> > kvm *kvm)
> >  
> >  	kvmppc_free_vcores(kvm);
> >  
> > -	kvmppc_free_hpt(kvm);
> > +	if (kvm->arch.radix)
> kvm_is_radix() for consistency?

Sure, and in the other places you noted.

Thanks,
Paul.
