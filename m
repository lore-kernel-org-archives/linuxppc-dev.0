Return-Path: <bsingharora@gmail.com>
Received: from mail-vk0-x241.google.com (mail-vk0-x241.google.com
 [IPv6:2607:f8b0:400c:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40gqGR43TfzF2MT
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 May 2018 18:27:11 +1000 (AEST)
Received: by mail-vk0-x241.google.com with SMTP id m144-v6so21326096vke.4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 May 2018 01:27:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180509174356.361abdba@roar.ozlabs.ibm.com>
References: <20180509065152.14213-1-npiggin@gmail.com>
 <20180509065152.14213-2-npiggin@gmail.com>
 <CAKTCnzmeTiSK8naAz32PAcCdq3Nu3tb02DY4Kn0V+pG593tgOg@mail.gmail.com>
 <20180509174356.361abdba@roar.ozlabs.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Wed, 9 May 2018 18:27:07 +1000
Message-ID: <CAKTCnznPYt-8SdP81vnpev5c5Cu9a95RoSCP7WaF+LxnrZv2Ng@mail.gmail.com>
Subject: Re: [PATCH 1/2] powerpc/64s/radix: do not flush TLB when relaxing
 access
To: Nicholas Piggin <npiggin@gmail.com>
Cc: "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>, Alistair Popple <alistair@popple.id.au>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 9, 2018 at 5:43 PM, Nicholas Piggin <npiggin@gmail.com> wrote:
> On Wed, 9 May 2018 17:07:47 +1000
> Balbir Singh <bsingharora@gmail.com> wrote:
>
>> On Wed, May 9, 2018 at 4:51 PM, Nicholas Piggin <npiggin@gmail.com> wrote:
>> > Radix flushes the TLB when updating ptes to increase permissiveness
>> > of protection (increase access authority). Book3S does not require
>> > TLB flushing in this case, and it is not done on hash. This patch
>> > avoids the flush for radix.
>> >
>> > From Power ISA v3.0B, p.1090:
>> >
>> >     Setting a Reference or Change Bit or Upgrading Access Authority
>> >     (PTE Subject to Atomic Hardware Updates)
>> >
>> >     If the only change being made to a valid PTE that is subject to
>> >     atomic hardware updates is to set the Reference or Change bit to 1
>> >     or to add access authorities, a simpler sequence suffices because
>> >     the translation hardware will refetch the PTE if an access is
>> >     attempted for which the only problems were reference and/or change
>> >     bits needing to be set or insufficient access authority.
>> >
>> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> > ---
>> >  arch/powerpc/mm/pgtable-book3s64.c | 1 -
>> >  arch/powerpc/mm/pgtable.c          | 3 ++-
>> >  2 files changed, 2 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-book3s64.c
>> > index 518518fb7c45..6e991eaccab4 100644
>> > --- a/arch/powerpc/mm/pgtable-book3s64.c
>> > +++ b/arch/powerpc/mm/pgtable-book3s64.c
>> > @@ -40,7 +40,6 @@ int pmdp_set_access_flags(struct vm_area_struct *vma, unsigned long address,
>> >         if (changed) {
>> >                 __ptep_set_access_flags(vma->vm_mm, pmdp_ptep(pmdp),
>> >                                         pmd_pte(entry), address);
>> > -               flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
>>
>> The comment states that this can be used for missing execution
>> permissions as well. I am not convinced we can skip a flush in those
>> cases
>
> Why not? Execute is part of the access authority. And they're already no
> ops on hash. What am I missing?

I have not reviewed the hash code, but if relaxing access means
allowing the code to provide execute permission, won't this result in
spurious faults? A simple test might be to run a JIT workload and see
if the number of faults go up with and without the patch?

Balbir
