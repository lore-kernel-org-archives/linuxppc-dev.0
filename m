Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound5-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id B1B07DDEC9
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jun 2007 07:55:07 +1000 (EST)
Message-ID: <46672D34.8010808@am.sony.com>
Date: Wed, 06 Jun 2007 14:55:00 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: michael@ellerman.id.au
Subject: Re: [patch 08/18] PS3: Kexec support
References: <20070606024407.786638029@am.sony.com> >	
	<4666233F.1080103@am.sony.com>
	<1181102510.5536.15.camel@concordia.ozlabs.ibm.com>
In-Reply-To: <1181102510.5536.15.camel@concordia.ozlabs.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Ellerman wrote:
> On Tue, 2007-06-05 at 20:00 -0700, Geoff Levand wrote:
>> Fixup the core platform parts needed for kexec to work on the PS3.
>>  - Setup ps3_hpte_clear correctly.
>>  - Mask interrupts on irq removal.
>>  - Release all hypervisor resources.
> 
> The irq changes might be kexec related, but it's a mess to review. You
> seem to moving a bunch of code around in the patch as well.


Yes, I need to move the static chip_mask routines up so they would be
defined before the irq setup/destroy routines.


>> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
>> ---
>>  arch/powerpc/platforms/ps3/htab.c      |   14 +-
>>  arch/powerpc/platforms/ps3/interrupt.c |  199 ++++++++++++++++++++-------------
>>  arch/powerpc/platforms/ps3/setup.c     |   29 ++--
>>  3 files changed, 147 insertions(+), 95 deletions(-)
>> 
>> --- a/arch/powerpc/platforms/ps3/htab.c
>> +++ b/arch/powerpc/platforms/ps3/htab.c
>> @@ -234,10 +234,18 @@ static void ps3_hpte_invalidate(unsigned
>>  
>>  static void ps3_hpte_clear(void)
>>  {
>> -	/* Make sure to clean up the frame buffer device first */
>> -	ps3fb_cleanup();
>> +	int result;
>>  
>> -	lv1_unmap_htab(htab_addr);
>> +	DBG(" -> %s:%d\n", __func__, __LINE__);
>> +
>> +	result = lv1_unmap_htab(htab_addr);
>> +	BUG_ON(result);
>> +
>> +	ps3_mm_shutdown();
>> +
>> +	ps3_mm_vas_destroy();
>> +
>> +	DBG(" <- %s:%d\n", __func__, __LINE__);
>>  }
> 
> Do you really want to be calling DBG() here? Hmm, it looks like it
> doesn't actually do anything?


Sure, it uses udbg_printf, and works OK.


>> +static void ps3_chip_mask(unsigned int virq)
>> +{
>> +	struct ps3_private *pd = get_irq_chip_data(virq);
>> +	u64 bit = 0x8000000000000000UL >> virq;
>> +	u64 *p = &pd->bmp.mask;
>> +	u64 old;
>> +	unsigned long flags;
>> +
>> +	pr_debug("%s:%d: cpu %u, virq %d\n", __func__, __LINE__, pd->cpu, virq);
>> +
>> +	local_irq_save(flags);
>> +	asm volatile(
>> +		     "1:	ldarx %0,0,%3\n"
>> +		     "andc	%0,%0,%2\n"
>> +		     "stdcx.	%0,0,%3\n"
>> +		     "bne-	1b"
>> +		     : "=&r" (old), "+m" (*p)
>> +		     : "r" (bit), "r" (p)
>> +		     : "cc" );
>> +
>> +	lv1_did_update_interrupt_mask(pd->node, pd->cpu);
>> +	local_irq_restore(flags);
> 
> How is this different from set_bit() ?  (asm-powerpc/bitops.h)
> 
> ps. now that I see you're just moving this code around someone's
> probably already asked that question.


This was contributed by Ben H as the fastest way.  I think the
reason was that we could minimize the time between local_irq_save
and local_irq_restore?


>>  static void ps3_machine_kexec(struct kimage *image)
>>  {
>> -	unsigned long ppe_id;
>> -
>>  	DBG(" -> %s:%d\n", __func__, __LINE__);
>>  
>> -	lv1_get_logical_ppe_id(&ppe_id);
>> -	lv1_configure_irq_state_bitmap(ppe_id, 0, 0);
>> -	ps3_mm_shutdown();
>> -	ps3_mm_vas_destroy();
>> -
>> -	default_machine_kexec(image);
>> +	default_machine_kexec(image); // needs ipi, never returns.
> 
> Just get rid of ps3_machine_kexec() and hook default_machine_kexec()
> directly into your ppc_md.


Right, just a debugging leftover...


-Geoff
