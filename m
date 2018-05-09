Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40gpJx0kC4zF23B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 May 2018 17:44:17 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id a13-v6so22298882pgu.4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 May 2018 00:44:16 -0700 (PDT)
Date: Wed, 9 May 2018 17:43:56 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>, Alistair Popple <alistair@popple.id.au>
Subject: Re: [PATCH 1/2] powerpc/64s/radix: do not flush TLB when relaxing
 access
Message-ID: <20180509174356.361abdba@roar.ozlabs.ibm.com>
In-Reply-To: <CAKTCnzmeTiSK8naAz32PAcCdq3Nu3tb02DY4Kn0V+pG593tgOg@mail.gmail.com>
References: <20180509065152.14213-1-npiggin@gmail.com>
 <20180509065152.14213-2-npiggin@gmail.com>
 <CAKTCnzmeTiSK8naAz32PAcCdq3Nu3tb02DY4Kn0V+pG593tgOg@mail.gmail.com>
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

On Wed, 9 May 2018 17:07:47 +1000
Balbir Singh <bsingharora@gmail.com> wrote:

> On Wed, May 9, 2018 at 4:51 PM, Nicholas Piggin <npiggin@gmail.com> wrote:
> > Radix flushes the TLB when updating ptes to increase permissiveness
> > of protection (increase access authority). Book3S does not require
> > TLB flushing in this case, and it is not done on hash. This patch
> > avoids the flush for radix.
> >
> > From Power ISA v3.0B, p.1090:
> >
> >     Setting a Reference or Change Bit or Upgrading Access Authority
> >     (PTE Subject to Atomic Hardware Updates)
> >
> >     If the only change being made to a valid PTE that is subject to
> >     atomic hardware updates is to set the Reference or Change bit to 1
> >     or to add access authorities, a simpler sequence suffices because
> >     the translation hardware will refetch the PTE if an access is
> >     attempted for which the only problems were reference and/or change
> >     bits needing to be set or insufficient access authority.
> >
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >  arch/powerpc/mm/pgtable-book3s64.c | 1 -
> >  arch/powerpc/mm/pgtable.c          | 3 ++-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-book3s64.c
> > index 518518fb7c45..6e991eaccab4 100644
> > --- a/arch/powerpc/mm/pgtable-book3s64.c
> > +++ b/arch/powerpc/mm/pgtable-book3s64.c
> > @@ -40,7 +40,6 @@ int pmdp_set_access_flags(struct vm_area_struct *vma, unsigned long address,
> >         if (changed) {
> >                 __ptep_set_access_flags(vma->vm_mm, pmdp_ptep(pmdp),
> >                                         pmd_pte(entry), address);
> > -               flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);  
> 
> The comment states that this can be used for missing execution
> permissions as well. I am not convinced we can skip a flush in those
> cases

Why not? Execute is part of the access authority. And they're already no
ops on hash. What am I missing?

Thanks,
Nick
