Return-Path: <meador_inge@mentor.com>
Message-ID: <4D790901.9000701@mentor.com>
Date: Thu, 10 Mar 2011 11:23:13 -0600
From: Meador Inge <meador_inge@mentor.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v4 2/2] powerpc: make MPIC honor the "pic-no-reset" device
	tree property
References: <1298671177-19572-1-git-send-email-meador_inge@mentor.com>	
	<1298671177-19572-3-git-send-email-meador_inge@mentor.com>
	<1299036140.8833.818.camel@pasglop>
In-Reply-To: <1299036140.8833.818.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Hollis Blanchard <hollis_blanchard@mentor.com>,
	devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/01/2011 09:22 PM, Benjamin Herrenschmidt wrote:
>
>> diff --git a/arch/powerpc/include/asm/mpic.h b/arch/powerpc/include/asm/mpic.h
>> index e000cce..7e1be12 100644
>> --- a/arch/powerpc/include/asm/mpic.h
>> +++ b/arch/powerpc/include/asm/mpic.h
>> @@ -325,6 +325,8 @@ struct mpic
>>   #ifdef CONFIG_PM
>>   	struct mpic_irq_save	*save_data;
>>   #endif
>> +
>> +	int cpu;
>>   };
>
> Why ? The MPIC isn't specifically associated with a CPU and whatever we
> pick as default during boot isn't relevant later on, so I don't see why
> we should have global permanent state here.

I agree.  I shouldn't have cached that.  We should probably introduce a 
helper function to get the cpuid, though.  The:

	unsigned int cpu = 0;

	if (mpic->flags & MPIC_PRIMARY)
		cpu = hard_smp_processor_id();

code is scattered in three places: '_mpic_cpu_write', '_mpic_cpu_read', 
and 'mpic_init'.

>>   /* Check if we have one of those nice broken MPICs with a flipped endian on
>> @@ -622,6 +631,14 @@ static unsigned int mpic_is_ipi(struct mpic *mpic, unsigned int irq)
>>   	return (src>= mpic->ipi_vecs[0]&&  src<= mpic->ipi_vecs[3]);
>>   }
>>
>> +/* Determine if the linux irq is a timer interrupt */
>> +static unsigned int mpic_is_timer_interrupt(struct mpic *mpic, unsigned int irq)
>> +{
>> +	unsigned int src = mpic_irq_to_hw(irq);
>> +
>> +	return (src>= mpic->timer_vecs[0]&&  src<= mpic->timer_vecs[3]);
>> +}
>> +
>>
>>   /* Convert a cpu mask from logical to physical cpu numbers. */
>>   static inline u32 mpic_physmask(u32 cpumask)
>> @@ -967,6 +984,15 @@ static int mpic_host_map(struct irq_host *h, unsigned int virq,
>>   	if (hw>= mpic->irq_count)
>>   		return -EINVAL;
>>
>> +	/* If the MPIC was reset, then all vectors have already been
>> +	 * initialized.  Otherwise, the appropriate vector needs to be
>> +	 * initialized here to ensure that only used sources are setup with
>> +	 * a vector.
>> +	 */
>> +	if (mpic->flags&  MPIC_NO_RESET)
>> +		if (!(mpic_is_ipi(mpic, hw) || mpic_is_timer_interrupt(mpic, hw)))
>> +			mpic_init_vector(mpic, hw);
>> +
>
> The above isn't useful. Of those two registers you want to initialize,
> afaik, one (the destination) will be initialized by the core calling
> into set_affinity when the interrupt is requested, and the other one is

AFAIK, we can't rely on 'set_affinity' always being called.  I don't 
think it is called at all when !defined(CONFIG_SMP) and if it was, then 
that would be an error:

	/* include/linux/irq.h */

	#else /* CONFIG_SMP */

	static inline int irq_set_affinity(unsigned int irq,
		const struct cpumask *m)
	{
		return -EINVAL;
	}

> partially initialized in set_type, I'd say just modify set_type to
> initialize the source as well, and problem solved, no ?

The priority has to be initialized as well.  They could both be done in 
'mpic_set_irq_type', but that seems like a weird place since it has 
nothing to do with actually setting the type.

Since we already have 'mpic_irq_set_priority' and 'mpic_set_vector', 
perhaps a better option is to add 'mpic_set_destination' and put the 
following in 'mpic_host_map' (using the cpuid helper function suggested 
above):

	/* Lazy source init when MPIC_NO_RESET */
	if (!mpic_is_ipi(mpic, hw) && (mpic->flags & MPIC_NO_RESET)) {
		mpic_set_vector(virq, hw);
		mpic_set_destination(virq, mpic_cpuid(mpic));
		mpic_irq_set_priority(virq, 8);
	}

It is more overhead, but it reads well.  Thoughts?

> Or is there a chance that the interrupt was left unmasked ?

There shouldn't be.  The original idea was that either the boot program 
would leave it masked or one of the AMP OSes would boot without 
'pic-no-reset', which would mask everything.  Most likely the boot program.

> I think it would be kosher to mask it in set_type unconditionally, I don't think it's ever supposed
> to be called for an enabled interrupt.

I will look into that.

Thanks,

-- 
Meador Inge     | meador_inge AT mentor.com
Mentor Embedded | http://www.mentor.com/embedded-software
