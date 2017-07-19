Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xCG3t4blXzDrW3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 22:07:06 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH 1/2] powernv/powerpc:Save/Restore additional SPRs for
 stop4 cpuidle
In-Reply-To: <20170719190323.42a0c509@roar.ozlabs.ibm.com>
References: <cover.1500452107.git.ego@linux.vnet.ibm.com>
 <d4dfb8e8daca3af2a2451c6f39f7352852c51f48.1500452107.git.ego@linux.vnet.ibm.com>
 <20170719190323.42a0c509@roar.ozlabs.ibm.com>
Date: Wed, 19 Jul 2017 22:07:05 +1000
Message-ID: <8760eoiqae.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicholas Piggin <npiggin@gmail.com> writes:

> On Wed, 19 Jul 2017 13:48:49 +0530
> "Gautham R. Shenoy" <ego@linux.vnet.ibm.com> wrote:
>
>> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
>> 
>> The stop4 idle state on POWER9 is a deep idle state which loses
>> hypervisor resources, but whose latency is low enough that it can be
>> exposed via cpuidle.
>> 
>> Until now, the deep idle states which lose hypervisor resources (eg:
>> winkle) were only exposed via CPU-Hotplug.  Hence currently on wakeup
>> from such states, barring a few SPRs which need to be restored to
>> their older value, rest of the SPRS are reinitialized to their values
>> corresponding to that at boot time.
>> 
>> When stop4 is used in the context of cpuidle, we want these additional
>> SPRs to be restored to their older value, to ensure that the context
>> on the CPU coming back from idle is same as it was before going idle.
>> 
>> In this patch, we define a SPR save area in PACA (since we have used
>> up the volatile register space in the stack) and on POWER9, we restore
>> SPRN_PID, SPRN_LDBAR, SPRN_FSCR, SPRN_HFSCR, SPRN_MMCRA, SPRN_MMCR1,
>> SPRN_MMCR2 to the values they had before entering stop.
>> 
>> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/include/asm/paca.h   |  7 ++++++
>>  arch/powerpc/kernel/asm-offsets.c | 12 ++++++++++
>>  arch/powerpc/kernel/idle_book3s.S | 46 +++++++++++++++++++++++++++++++++++++--
>>  3 files changed, 63 insertions(+), 2 deletions(-)
>> 
>> diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
>> index dc88a31..a6b9ea6 100644
>> --- a/arch/powerpc/include/asm/paca.h
>> +++ b/arch/powerpc/include/asm/paca.h
>> @@ -48,6 +48,7 @@
>>  #define get_lppaca()	(get_paca()->lppaca_ptr)
>>  #define get_slb_shadow()	(get_paca()->slb_shadow_ptr)
>>  
>> +#define MAX_STOP_SPRS     7
>>  struct task_struct;
>>  
>>  /*
>> @@ -183,6 +184,12 @@ struct paca_struct {
>>  	struct paca_struct **thread_sibling_pacas;
>>  	/* The PSSCR value that the kernel requested before going to stop */
>>  	u64 requested_psscr;
>> +
>> +	/*
>> +	 * Save area for additional SPRs that need to be
>> +	 * saved/restored during cpuidle stop.
>> +	 */
>> +	u64 stop_spr_save_area[MAX_STOP_SPRS];
>>  #endif
>>  
>>  #ifdef CONFIG_PPC_STD_MMU_64
>> diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
>> index a7b5af3..0262283 100644
>> --- a/arch/powerpc/kernel/asm-offsets.c
>> +++ b/arch/powerpc/kernel/asm-offsets.c
>> @@ -743,6 +743,18 @@ int main(void)
>>  	OFFSET(PACA_SUBCORE_SIBLING_MASK, paca_struct, subcore_sibling_mask);
>>  	OFFSET(PACA_SIBLING_PACA_PTRS, paca_struct, thread_sibling_pacas);
>>  	OFFSET(PACA_REQ_PSSCR, paca_struct, requested_psscr);
>> +
>> +	OFFSET(PACA_PID, paca_struct, stop_spr_save_area[0]);
>> +	OFFSET(PACA_LDBAR, paca_struct, stop_spr_save_area[1]);
>> +	OFFSET(PACA_FSCR, paca_struct, stop_spr_save_area[2]);
>> +	OFFSET(PACA_HFSCR, paca_struct, stop_spr_save_area[3]);
>> +
>> +	/* On POWER9, we are already saving MMCR0 for ESL=EC=1 */
>> +	OFFSET(PACA_MMCRA, paca_struct, stop_spr_save_area[4]);
>> +	OFFSET(PACA_MMCR1, paca_struct, stop_spr_save_area[5]);
>> +	OFFSET(PACA_MMCR2, paca_struct, stop_spr_save_area[6]);
>
> Don't these offset names go against convention?
>
> Look at e.g., how PACA_EXGEN is used. I would prefer using that
> convention. You could make the name slightly shorter too, e.g.,
> just stop_sprs or so.

Yes please.

If I see PACA_MMCRA I'm expecting that's paca->mmcra.

Also if the same values always go in the same place then please use a
proper struct, rather than an array. ie.

struct stop_sprs
{
	u64 pid;
        u64 ldbar;
        ...
}

cheers
