Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vC23735blzDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2017 08:05:07 +1100 (AEDT)
Date: Tue, 31 Jan 2017 08:05:03 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH v2 13/20] KVM: PPC: Book3S HV: Page table construction
 and page faults for radix guests
Message-ID: <20170130210503.GB26021@fergus.ozlabs.ibm.com>
References: <1485771713-24801-1-git-send-email-paulus@ozlabs.org>
 <1485771713-24801-14-git-send-email-paulus@ozlabs.org>
 <8737g0w9gu.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8737g0w9gu.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 31, 2017 at 07:58:57AM +1100, Michael Ellerman wrote:
> Paul Mackerras <paulus@ozlabs.org> writes:
> 
> > This adds the code to construct the second-level ("partition-scoped" in
> > architecturese) page tables for guests using the radix MMU.  Apart from
> > the PGD level, which is allocated when the guest is created, the rest
> > of the tree is all constructed in response to hypervisor page faults.
> >
> > As well as hypervisor page faults for missing pages, we also get faults
> > for reference/change (RC) bits needing to be set, as well as various
> > other error conditions.  For now, we only set the R or C bit in the
> > guest page table if the same bit is set in the host PTE for the
> > backing page.
> >
> > This code can take advantage of the guest being backed with either
> > transparent or ordinary 2MB huge pages, and insert 2MB page entries
> > into the guest page tables.  There is no support for 1GB huge pages
> > yet.
> > ---
> >  arch/powerpc/include/asm/kvm_book3s.h  |   8 +
> >  arch/powerpc/kvm/book3s.c              |   1 +
> >  arch/powerpc/kvm/book3s_64_mmu_hv.c    |   7 +-
> >  arch/powerpc/kvm/book3s_64_mmu_radix.c | 385 +++++++++++++++++++++++++++++++++
> >  arch/powerpc/kvm/book3s_hv.c           |  17 +-
> >  5 files changed, 415 insertions(+), 3 deletions(-)
> 
> You didn't sign-off this patch. I assume that's just an accident and
> will add it?

Oops, yes, just an oversight.  I'll add it.

Paul.
