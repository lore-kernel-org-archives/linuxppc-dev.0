Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40s5RY3fG4zF1PV
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 20:37:12 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id f189-v6so669803pfa.7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 03:37:12 -0700 (PDT)
Date: Thu, 24 May 2018 20:37:00 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 1/7] powerpc/64s/radix: do not flush TLB on spurious
 fault
Message-ID: <20180524203700.63bf7ed8@roar.ozlabs.ibm.com>
In-Reply-To: <87efi5y23v.fsf@linux.vnet.ibm.com>
References: <20180520004347.19508-1-npiggin@gmail.com>
 <20180520004347.19508-2-npiggin@gmail.com>
 <87efi5y23v.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 21 May 2018 11:36:12 +0530
"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> wrote:

> Nicholas Piggin <npiggin@gmail.com> writes:
> 
> > In the case of a spurious fault (which can happen due to a race with
> > another thread that changes the page table), the default Linux mm code
> > calls flush_tlb_page for that address. This is not required because
> > the pte will be re-fetched. Hash does not wire this up to a hardware
> > TLB flush for this reason. This patch avoids the flush for radix.
> >
> > From Power ISA v3.0B, p.1090:
> >
> >     Setting a Reference or Change Bit or Upgrading Access Authority
> >     (PTE Subject to Atomic Hardware Updates)
> >
> >     If the only change being made to a valid PTE that is subject to
> >     atomic hardware updates is to set the Refer- ence or Change bit to
> >     1 or to add access authorities, a simpler sequence suffices
> >     because the translation hardware will refetch the PTE if an access
> >     is attempted for which the only problems were reference and/or
> >     change bits needing to be set or insufficient access authority.
> >
> > The nest MMU on POWER9 does not re-fetch the PTE after such an access
> > attempt before faulting, so address spaces with a coprocessor
> > attached will continue to flush in these cases.
> >
> > This reduces tlbies for a kernel compile workload from 0.95M to 0.90M.
> >
> > fork --fork --exec benchmark improved 0.5% (12300->12400).
> >  
> 
> 
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> 
> Do you want to use flush_tlb_fix_spurious_fault in
> ptep_set_access_flags() also?. That would bring it closer to generic version?

I'm not sure it adds much, it does bring it closer to generic version
and they do happen to do the same thing, but it's not really fixing a
spurious fault in ptep_set_access_flags(). I think adding that just
means you would have to follow another indirection to work out what it
does.

Thanks,
Nick
