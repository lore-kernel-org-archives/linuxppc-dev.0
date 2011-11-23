Return-Path: <mtosatti@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id D89BFB70B2
 for <linuxppc-dev@ozlabs.org>; Thu, 24 Nov 2011 11:01:02 +1100 (EST)
Date: Wed, 23 Nov 2011 21:59:07 -0200
From: Marcelo Tosatti <mtosatti@redhat.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [RFC PATCH 0/11] KVM: PPC: Update Book3S HV memory handling
Message-ID: <20111123235907.GC8125@amt.cnet>
References: <20111116225055.GA26985@bloggs.ozlabs.ibm.com>
 <AA9CC080-B96B-41C7-A054-8286CF8BC3FE@suse.de>
 <20111118215424.GA24455@bloggs.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111118215424.GA24455@bloggs.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, kvm list <kvm@vger.kernel.org>,
 Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org,
 Avi Kivity <avi@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Nov 19, 2011 at 08:54:24AM +1100, Paul Mackerras wrote:
> On Fri, Nov 18, 2011 at 02:57:11PM +0100, Alexander Graf wrote:
> > 
> > This touches areas that I'm sure non-PPC people would want to see as
> > well. Could you please CC kvm@vger too next time?
> > 
> > Avi, Marcelo, mind to review some of the bits in this patch set? :)
> 
> I did cc the last patch (the one that adds barriers in the MMU
> notifier sequence/count logic) to kvm@vger.  Do you mean I should cc
> the whole series?  The only other thing touching generic code is the
> addition of the KVM_MEMSLOT_IO flag in the first patch.

I don't see such flag anywhere in the patches in this thread?

> I'm hoping the extra barriers will be OK since they are no-ops on
> x86.  In fact I now think that the smp_wmbs I added to
> kvm_mmu_notifier_invalidate_page and kvm_mmu_notifier_change_pte
> aren't in fact necessary, since it's only necessary to ensure that the
> sequence number increase is visible before the point where
> kvm_unmap_hva or kvm_set_spte_hva unlock the bitlock on the first rmap
> chain they look at, which will be ensured anyway by the barrier before
> the unlock.
> 
> Paul.
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
