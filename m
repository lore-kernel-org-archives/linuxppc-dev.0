Return-Path: <kernelfans@gmail.com>
Received: from mail-yh0-x230.google.com (mail-yh0-x230.google.com
 [IPv6:2607:f8b0:4002:c01::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ED24E1A01EF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jul 2014 18:07:04 +1000 (EST)
Received: by mail-yh0-f48.google.com with SMTP id i57so5479865yha.35
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jul 2014 01:07:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1406617022.4935.79.camel@pasglop>
References: <1406527744-25316-1-git-send-email-pingfank@linux.vnet.ibm.com>
 <1406529741.4935.48.camel@pasglop>
 <CAFgQCTvC1MX8fN26-KHWRMmpN_zk82LX1=RYn3j61PWo7kvwBQ@mail.gmail.com>
 <1406617022.4935.79.camel@pasglop>
Date: Tue, 29 Jul 2014 16:07:01 +0800
Message-ID: <CAFgQCTuJu_kOSAHay=PDtNmLzD5r2ODKO_ayR-AH+avBOFcM_w@mail.gmail.com>
Subject: Re: [PATCH] powerpc: kvm: make the setup of hpte under the protection
 of KVMPPC_RMAP_LOCK_BIT
From: Liu ping fan <kernelfans@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Alexander Graf <agraf@suse.de>, kvm-ppc <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 29, 2014 at 2:57 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Mon, 2014-07-28 at 15:58 +0800, Liu ping fan wrote:
>> Hope I am right.  Take the following seq as an example
>>
>> if (hptep[0] & HPTE_V_VALID) {
>> /* HPTE was previously valid, so we need to invalidate it */
>> unlock_rmap(rmap);
>> hptep[0] |= HPTE_V_ABSENT;
>> kvmppc_invalidate_hpte(kvm, hptep, index);
>> /* don't lose previous R and C bits */
>> r |= hptep[1] & (HPTE_R_R | HPTE_R_C);
>> } else {
>> kvmppc_add_revmap_chain(kvm, rev, rmap, index, 0);
>> }
>>   ---------------------------------------------> if we try_to_unmap on
>> pfn at here, then @r contains a invalid pfn
>> hptep[1] = r;
>> eieio();
>> hptep[0] = hpte[0];
>> asm volatile("ptesync" : : : "memory");
>
> If that was the case we would have the same race in kvmppc_do_h_enter().
>
> I think the fact that the HPTE is locked will prevent the race, ie,
> HPTE_V_HVLOCK is set until hptep[0] is written to.
>
> If I look at at the unmap case, my understanding is that it uses
> kvm_unmap_rmapp() which will also lock the HPTE (try_lock_hpte)
> and so shouldn't have a race vs the above code.
>
Yes, you are right :)

Thx,
Fan


> Or do you see a race I don't ?
>
> Cheers,
> Ben.
>
>> Thx.
>> Fan
>>
>> On Mon, Jul 28, 2014 at 2:42 PM, Benjamin Herrenschmidt
>> <benh@kernel.crashing.org> wrote:
>> > On Mon, 2014-07-28 at 14:09 +0800, Liu Ping Fan wrote:
>> >> In current code, the setup of hpte is under the risk of race with
>> >> mmu_notifier_invalidate, i.e we may setup a hpte with a invalid pfn.
>> >> Resolve this issue by sync the two actions by KVMPPC_RMAP_LOCK_BIT.
>> >
>> > Please describe the race you think you see. I'm quite sure both Paul and
>> > I went over that code and somewhat convinced ourselves that it was ok
>> > but it's possible that we were both wrong :-)
>> >
>> > Cheers,
>> > Ben.
>> >
>> >> Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
>> >> ---
>> >>  arch/powerpc/kvm/book3s_64_mmu_hv.c | 15 ++++++++++-----
>> >>  1 file changed, 10 insertions(+), 5 deletions(-)
>> >>
>> >> diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
>> >> index 8056107..e6dcff4 100644
>> >> --- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
>> >> +++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
>> >> @@ -754,19 +754,24 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
>> >>
>> >>       if (hptep[0] & HPTE_V_VALID) {
>> >>               /* HPTE was previously valid, so we need to invalidate it */
>> >> -             unlock_rmap(rmap);
>> >>               hptep[0] |= HPTE_V_ABSENT;
>> >>               kvmppc_invalidate_hpte(kvm, hptep, index);
>> >>               /* don't lose previous R and C bits */
>> >>               r |= hptep[1] & (HPTE_R_R | HPTE_R_C);
>> >> +
>> >> +             hptep[1] = r;
>> >> +             eieio();
>> >> +             hptep[0] = hpte[0];
>> >> +             asm volatile("ptesync" : : : "memory");
>> >> +             unlock_rmap(rmap);
>> >>       } else {
>> >> +             hptep[1] = r;
>> >> +             eieio();
>> >> +             hptep[0] = hpte[0];
>> >> +             asm volatile("ptesync" : : : "memory");
>> >>               kvmppc_add_revmap_chain(kvm, rev, rmap, index, 0);
>> >>       }
>> >>
>> >> -     hptep[1] = r;
>> >> -     eieio();
>> >> -     hptep[0] = hpte[0];
>> >> -     asm volatile("ptesync" : : : "memory");
>> >>       preempt_enable();
>> >>       if (page && hpte_is_writable(r))
>> >>               SetPageDirty(page);
>> >
>> >
>
>
