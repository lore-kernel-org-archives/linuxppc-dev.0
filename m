Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id B02202C009A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jul 2013 03:44:36 +1000 (EST)
Message-ID: <51DC4C00.70509@suse.de>
Date: Tue, 09 Jul 2013 19:44:32 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/2] KVM: PPC: Book3E: Get vcpu's last instruction for
 emulation
References: <1373390018.8183.194@snotra>
In-Reply-To: <1373390018.8183.194@snotra>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Mihai Caraman <mihai.caraman@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/09/2013 07:13 PM, Scott Wood wrote:
> On 07/08/2013 08:39:05 AM, Alexander Graf wrote:
>>
>> On 28.06.2013, at 11:20, Mihai Caraman wrote:
>>
>> > lwepx faults needs to be handled by KVM and this implies additional 
>> code
>> > in DO_KVM macro to identify the source of the exception originated 
>> from
>> > host context. This requires to check the Exception Syndrome Register
>> > (ESR[EPID]) and External PID Load Context Register (EPLC[EGS]) for 
>> DTB_MISS,
>> > DSI and LRAT exceptions which is too intrusive for the host.
>> >
>> > Get rid of lwepx and acquire last instuction in 
>> kvmppc_handle_exit() by
>> > searching for the physical address and kmap it. This fixes an 
>> infinite loop
>>
>> What's the difference in speed for this?
>>
>> Also, could we call lwepx later in host code, when 
>> kvmppc_get_last_inst() gets invoked?
>
> Any use of lwepx is problematic unless we want to add overhead to the 
> main Linux TLB miss handler.

What exactly would be missing?

I'd also still like to see some performance benchmarks on this to make 
sure we're not walking into a bad direction.

>
>> > +        return;
>> > +    }
>> > +
>> > +    mas3 = mfspr(SPRN_MAS3);
>> > +    pr = vcpu->arch.shared->msr & MSR_PR;
>> > +    if ((pr && (!(mas3 & MAS3_UX))) || ((!pr) && (!(mas3 & 
>> MAS3_SX)))) {
>> > +         /*
>> > +         * Another thread may rewrite the TLB entry in parallel, 
>> don't
>> > +         * execute from the address if the execute permission is 
>> not set
>>
>> Isn't this racy?
>
> Yes, that's the point.  We want to access permissions atomically with 
> the address.  If the guest races here, the unpredictable behavior is 
> its own fault, but we don't want to make it worse by assuming that the 
> new TLB entry is executable just because the old TLB entry was.

I see.

>
> There's still a potential problem if the instruction at the new TLB 
> entry is valid but not something that KVM emulates (because it 
> wouldn't have trapped).  Given that the guest is already engaging in 
> unpredictable behavior, though, and that it's no longer a security 
> issue (it'll just cause the guest to exit), I don't think we need to 
> worry too much about it.

No, that case is fine. It's the same as book3s pr.

>
>> > +         */
>> > +        vcpu->arch.fault_esr = 0;
>> > +        *exit_nr = BOOKE_INTERRUPT_INST_STORAGE;
>> > +        return;
>> > +    }
>> > +
>> > +    /* Get page size */
>> > +    if (MAS0_GET_TLBSEL(mfspr(SPRN_MAS0)) == 0)
>> > +        psize_shift = PAGE_SHIFT;
>> > +    else
>> > +        psize_shift = MAS1_GET_TSIZE(mas1) + 10;
>> > +
>> > +    mas7_mas3 = (((u64) mfspr(SPRN_MAS7)) << 32) |
>> > +            mfspr(SPRN_MAS3);
>>
>> You're non-atomically reading MAS3/MAS7 after you've checked for 
>> permissions on MAS3. I'm surprised there's no handler that allows 
>> MAS3/7 access through the new, combined SPR for 64bit systems.
>
> There is, but then we'd need to special-case 64-bit systems.

Oh, what I was trying to say is that I'm surprised there's nothing in 
Linux already like

static inline u64 get_mas73(void) {
#ifdef CONFIG_PPC64
     return mfspr(SPRN_MAS73)
#else
     return ((u64)mfspr(SPRN_MAS7) << 32) | mfspr(SPRN_MAS3);
#endif
}

>   Why does atomicity matter here?  The MAS registers were filled in 
> when we did the tlbsx.  They are thread-local.  They don't magically 
> change just because the other thread rewrites the TLB entry that was 
> used to fill them.

Yeah, it doesn't matter.

>
>> > +    addr = (mas7_mas3 & (~0ULL << psize_shift)) |
>> > +           (geaddr & ((1ULL << psize_shift) - 1ULL));
>> > +
>> > +    /* Map a page and get guest's instruction */
>> > +    page = pfn_to_page(addr >> PAGE_SHIFT);
>>
>> So it seems to me like you're jumping through a lot of hoops to make 
>> sure this works for LRAT and non-LRAT at the same time. Can't we just 
>> treat them as the different things they are?
>>
>> What if we have different MMU backends for LRAT and non-LRAT? The 
>> non-LRAT case could then try lwepx, if that fails, fall back to read 
>> the shadow TLB. For the LRAT case, we'd do lwepx, if that fails fall 
>> back to this logic.
>
> This isn't about LRAT; it's about hardware threads.  It also fixes the 
> handling of execute-only pages on current chips.

On non-LRAT systems we could always check our shadow copy of the guest's 
TLB, no? I'd really like to know what the performance difference would 
be for the 2 approaches.


Alex
