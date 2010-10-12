Return-Path: <jwboyer@linux.vnet.ibm.com>
Date: Tue, 12 Oct 2010 18:19:17 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] v2 476: Set CCR2[DSTI] to prevent isync from
	flushing shadow TLB
Message-ID: <20101012221917.GA7260@zod.rchland.ibm.com>
References: <1285351297-9999-1-git-send-email-shaggy@linux.vnet.ibm.com>
	<1285351297-9999-2-git-send-email-shaggy@linux.vnet.ibm.com>
	<20100927150434.GA2888@zod.rchland.ibm.com>
	<1285601205.17411.23.camel@shaggy-w500>
	<1285621852.14081.62.camel@pasglop>
	<1285622128.17411.29.camel@shaggy-w500>
	<1285624606.17411.31.camel@shaggy-w500>
	<1286912413.3688.33.camel@shaggy-w500>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1286912413.3688.33.camel@shaggy-w500>
Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 12, 2010 at 02:40:13PM -0500, Dave Kleikamp wrote:
>Josh,
>Please pull this patch.  I just found a bone-headed mistake that makes
>the whole patch a no-op.  I'll need to fix it and put it through a bit
>of testing before I can re-submit it.

OK.  I should have looked more closely myself.  I did think it odd that
it was changing head_44x.S but didn't follow up.

Ben, since you haven't pulled my -next branch yet, don't ;).  I'll fix
this up in my tree and resend a request tomorrow.

josh

>
>The other patch in this series should be okay.
>
>Thanks,
>Shaggy
>
>On Mon, 2010-09-27 at 16:56 -0500, Dave Kleikamp wrote:
>> When the DSTI (Disable Shadow TLB Invalidate) bit is set in the CCR2
>> register, the isync command does not flush the shadow TLB (iTLB & dTLB).
>> 
>> However, since the shadow TLB does not contain context information, we
>> want the shadow TLB flushed in situations where we are switching context.
>> In those situations, we explicitly clear the DSTI bit before performing
>> isync, and set it again afterward.  We also need to do the same when we
>> perform isync after explicitly flushing the TLB.
>> 
>> Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/include/asm/reg_booke.h  |    4 ++++
>>  arch/powerpc/kernel/head_44x.S        |   25 +++++++++++++++++++++++++
>>  arch/powerpc/mm/tlb_nohash_low.S      |   14 +++++++++++++-
>>  arch/powerpc/platforms/44x/misc_44x.S |   26 ++++++++++++++++++++++++++
>>  4 files changed, 68 insertions(+), 1 deletions(-)
>> 
>
>   --- snip ---
>
>> --- a/arch/powerpc/kernel/head_44x.S
>> +++ b/arch/powerpc/kernel/head_44x.S
>
>Not only is this in the wrong place (non-47x initialization) but ...
>
>> @@ -861,6 +877,15 @@ skpinv:	addi	r4,r4,1				/* Increment */
>>  	isync
>>  #endif /* CONFIG_PPC_EARLY_DEBUG_44x */
>> 
>> +BEGIN_MMU_FTR_SECTION
>> +	mfspr   r3,SPRN_CCR2_476
>> +	/* With CCR2(DSTI) set, isync does not invalidate the shadow TLB */
>> +	oris	r3,r3,CCR2_476_DSTI@h
>> +	rlwinm	r3,r3,0,~CCR2_476_DSTI
>
>^^^ This instruction doesn't belong at all.  It clears the bit right
>after setting it.  This one was just introduced removing the config
>option, but it was in the wrong place all along.
>
>> +	mtspr   SPRN_CCR2_476,r3
>> +	isync
>> +END_MMU_FTR_SECTION_IFSET(MMU_FTR_TYPE_47x)
>> +
>>  	/* Establish the interrupt vector offsets */
>>  	SET_IVOR(0,  CriticalInput);
>>  	SET_IVOR(1,  MachineCheck);
>
>I wasn't diligent enough checking a year-old patch that I got back to
>work on.  The code is very similar in two places and the patch applied
>to the wrong section.
>
>Thanks,
>Shaggy
>-- 
>Dave Kleikamp
>IBM Linux Technology Center
>
