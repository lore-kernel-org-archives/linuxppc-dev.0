Return-Path: <clg@kaod.org>
Received: from 1.mo177.mail-out.ovh.net (1.mo177.mail-out.ovh.net
 [178.33.107.143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xS3Q61BFFzDqyS
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Aug 2017 17:52:13 +1000 (AEST)
Received: from player779.ha.ovh.net (b9.ovh.net [213.186.33.59])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id 3CF5F71475
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Aug 2017 09:12:35 +0200 (CEST)
Subject: Re: [PATCH 03/10] powerpc/xive: rename xive_poke_esb in xive_esb_read
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>
References: <1502182579-990-1-git-send-email-clg@kaod.org>
 <1502182579-990-4-git-send-email-clg@kaod.org>
 <20170809035534.GD13670@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <05dee6ec-8478-579e-3cdb-0a180a114dc6@kaod.org>
Date: Wed, 9 Aug 2017 09:12:29 +0200
MIME-Version: 1.0
In-Reply-To: <20170809035534.GD13670@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/09/2017 05:55 AM, David Gibson wrote:
> On Tue, Aug 08, 2017 at 10:56:13AM +0200, Cédric Le Goater wrote:
>> xive_poke_esb() is performing a load/read so it is better named as
>> xive_esb_read().
> 
> Uh, patch seems to mismatch the comment here, calling it
> xive_peek_esb() instead.

euh yes. oops. 

> Does reading the ESB had a side effect on the hardware?  If so "poke"
> might be an appropriate name.

ok. I want to introduce a 'write' method. should I name them
load and store ? 

Thanks,

C. 

>> Also introduce a XIVE_ESB_LOAD_EOI read when EOI'ing
>> LSI interrupts.
>>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>>  arch/powerpc/sysdev/xive/common.c | 20 ++++++++++----------
>>  1 file changed, 10 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
>> index 6595462b1fc8..e6b245bb9602 100644
>> --- a/arch/powerpc/sysdev/xive/common.c
>> +++ b/arch/powerpc/sysdev/xive/common.c
>> @@ -190,7 +190,7 @@ static u32 xive_scan_interrupts(struct xive_cpu *xc, bool just_peek)
>>   * This is used to perform the magic loads from an ESB
>>   * described in xive.h
>>   */
>> -static u8 xive_poke_esb(struct xive_irq_data *xd, u32 offset)
>> +static u8 xive_peek_esb(struct xive_irq_data *xd, u32 offset)
>>  {
>>  	u64 val;
>>  
>> @@ -227,7 +227,7 @@ void xmon_xive_do_dump(int cpu)
>>  	xive_dump_eq("IRQ", &xc->queue[xive_irq_priority]);
>>  #ifdef CONFIG_SMP
>>  	{
>> -		u64 val = xive_poke_esb(&xc->ipi_data, XIVE_ESB_GET);
>> +		u64 val = xive_peek_esb(&xc->ipi_data, XIVE_ESB_GET);
>>  		xmon_printf("  IPI state: %x:%c%c\n", xc->hw_ipi,
>>  			val & XIVE_ESB_VAL_P ? 'P' : 'p',
>>  			val & XIVE_ESB_VAL_P ? 'Q' : 'q');
>> @@ -326,9 +326,9 @@ void xive_do_source_eoi(u32 hw_irq, struct xive_irq_data *xd)
>>  		 * properly.
>>  		 */
>>  		if (xd->flags & XIVE_IRQ_FLAG_LSI)
>> -			in_be64(xd->eoi_mmio);
>> +			xive_peek_esb(xd, XIVE_ESB_LOAD_EOI);
>>  		else {
>> -			eoi_val = xive_poke_esb(xd, XIVE_ESB_SET_PQ_00);
>> +			eoi_val = xive_peek_esb(xd, XIVE_ESB_SET_PQ_00);
>>  			DBG_VERBOSE("eoi_val=%x\n", offset, eoi_val);
>>  
>>  			/* Re-trigger if needed */
>> @@ -383,12 +383,12 @@ static void xive_do_source_set_mask(struct xive_irq_data *xd,
>>  	 * ESB accordingly on unmask.
>>  	 */
>>  	if (mask) {
>> -		val = xive_poke_esb(xd, XIVE_ESB_SET_PQ_01);
>> +		val = xive_peek_esb(xd, XIVE_ESB_SET_PQ_01);
>>  		xd->saved_p = !!(val & XIVE_ESB_VAL_P);
>>  	} else if (xd->saved_p)
>> -		xive_poke_esb(xd, XIVE_ESB_SET_PQ_10);
>> +		xive_peek_esb(xd, XIVE_ESB_SET_PQ_10);
>>  	else
>> -		xive_poke_esb(xd, XIVE_ESB_SET_PQ_00);
>> +		xive_peek_esb(xd, XIVE_ESB_SET_PQ_00);
>>  }
>>  
>>  /*
>> @@ -768,7 +768,7 @@ static int xive_irq_retrigger(struct irq_data *d)
>>  	 * To perform a retrigger, we first set the PQ bits to
>>  	 * 11, then perform an EOI.
>>  	 */
>> -	xive_poke_esb(xd, XIVE_ESB_SET_PQ_11);
>> +	xive_peek_esb(xd, XIVE_ESB_SET_PQ_11);
>>  
>>  	/*
>>  	 * Note: We pass "0" to the hw_irq argument in order to
>> @@ -803,7 +803,7 @@ static int xive_irq_set_vcpu_affinity(struct irq_data *d, void *state)
>>  		irqd_set_forwarded_to_vcpu(d);
>>  
>>  		/* Set it to PQ=10 state to prevent further sends */
>> -		pq = xive_poke_esb(xd, XIVE_ESB_SET_PQ_10);
>> +		pq = xive_peek_esb(xd, XIVE_ESB_SET_PQ_10);
>>  
>>  		/* No target ? nothing to do */
>>  		if (xd->target == XIVE_INVALID_TARGET) {
>> @@ -832,7 +832,7 @@ static int xive_irq_set_vcpu_affinity(struct irq_data *d, void *state)
>>  		 * for sure the queue slot is no longer in use.
>>  		 */
>>  		if (pq & 2) {
>> -			pq = xive_poke_esb(xd, XIVE_ESB_SET_PQ_11);
>> +			pq = xive_peek_esb(xd, XIVE_ESB_SET_PQ_11);
>>  			xd->saved_p = true;
>>  
>>  			/*
> 
