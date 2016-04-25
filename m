Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qtgvm3HRLzDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Apr 2016 19:31:16 +1000 (AEST)
Subject: Re: [PATCH] powerpc: Fix definition of SIAR register
To: Thomas Huth <thuth@redhat.com>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
References: <1460130851-29021-1-git-send-email-thuth@redhat.com>
 <571DD072.6040305@linux.vnet.ibm.com>
 <182287E9-40B9-4774-A932-08A0AA499AE3@suse.de> <571DE05C.8080805@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
From: Alexander Graf <agraf@suse.de>
Message-ID: <571DE3DF.9070506@suse.de>
Date: Mon, 25 Apr 2016 11:31:11 +0200
MIME-Version: 1.0
In-Reply-To: <571DE05C.8080805@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/25/2016 11:16 AM, Thomas Huth wrote:
> On 25.04.2016 10:15, Alexander Graf wrote:
>>
>>> Am 25.04.2016 um 10:08 schrieb Madhavan Srinivasan <maddy@linux.vnet.ibm.com>:
>>>
>>>
>>>
>>>> On Friday 08 April 2016 09:24 PM, Thomas Huth wrote:
>>>> The SIAR register is available twice, one time as SPR 780 (unprivileged,
>>>> but read-only), and one time as SPR 796 (privileged, but read and write).
>>>> The Linux kernel code currently uses SPR 780 - and while this is OK for
>>>> reading, writing to that register of course does not work.
>>>> Since the KVM code tries to write to this register, too (see the mtspr
>>>> in book3s_hv_rmhandlers.S), the contents of this register sometimes get
>>>> lost for the guests, e.g. during migration of a VM.
>>>> To fix this issue, simply switch to the other SPR numer 796 instead.
>>> IIUC, SIAR and SDAR are updated by hardware when we take
>>> a pmu exception with sampling mode enabled (based on instr).
>>> And these register contents are mainly for OS consumption.
>>> So, we dont need to restore these register values at all,
>>> kindly correct me if I missing something here.
>> What if you migrate between a pmu event firing and the os reading siar? Or what if the host gets pmu events? Or we migrate the guest to a different pcpu? In all those cases we need to ensure the register contents are consistent.
> Right. Or a guest could use the SIAR as a temporary scratch register
> while not using the performance monitoring stuff. In that case the
> contents of the register of course have to be preserved, too.
>
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>> ---
>>>> Note: The perf code in core-book3s.c also seems to write to the SIAR
>>>>        SPR, so that might be affected by this issue, too - but I did
>>>>        not test the perf code, so I'm not sure about that part.
>> Please write a small unit test that fires off pmu events constantly and checks whtether they arrive correctly. Run perf in parallel on the host to increase the chance for breakage.
> I'm not very familiar with that PMU stuff yet, but I can have a try...
>
>>>> arch/powerpc/include/asm/reg.h | 2 +-
>>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
>>>> index f5f4c66..6630420 100644
>>>> --- a/arch/powerpc/include/asm/reg.h
>>>> +++ b/arch/powerpc/include/asm/reg.h
>>>> @@ -752,13 +752,13 @@
>>>> #define SPRN_PMC6    792
>>>> #define SPRN_PMC7    793
>>>> #define SPRN_PMC8    794
>>>> -#define SPRN_SIAR    780
>>>> #define SPRN_SDAR    781
>>>> #define SPRN_SIER    784
>>>> #define   SIER_SIPR        0x2000000    /* Sampled MSR_PR */
>>>> #define   SIER_SIHV        0x1000000    /* Sampled MSR_HV */
>>>> #define   SIER_SIAR_VALID    0x0400000    /* SIAR contents valid */
>>>> #define   SIER_SDAR_VALID    0x0200000    /* SDAR contents valid */
>>>> +#define SPRN_SIAR    796
>> I'm sure there's a reason (iSeries?) we used the r/o version before. Better introduce a new constant that gives us rw access and use that in the kvm entry/exit code.
> Sure. Any suggestions on the naming? I could either rename the current
> SPRN_SIAR to SPRN_USIAR (so that it is named similar to other registers
> that behave that way, like SPRN_USPRG3 - and also QEMU uses USIAR for
> this already). Or I could leave the old name untouched and use something
> like "SPRN_SIAR_WR" for the 796 register. What do you prefer?

I'd defer that decision to Michael :).

> By the way, I just noticed that SPRN_SDAR (781) seems to suffer from the
> same problem, too!

Great! The more the merrier :)


Alex
