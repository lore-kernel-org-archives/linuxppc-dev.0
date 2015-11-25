Return-Path: <warrier@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 64F101A0337
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2015 06:27:34 +1100 (AEDT)
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id AB3821402D4
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Nov 2015 06:27:33 +1100 (AEDT)
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <warrier@linux.vnet.ibm.com>;
 Wed, 25 Nov 2015 12:27:31 -0700
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id F137E19D8048
 for <linuxppc-dev@ozlabs.org>; Wed, 25 Nov 2015 12:15:32 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAPJRQDm30933240
 for <linuxppc-dev@ozlabs.org>; Wed, 25 Nov 2015 12:27:26 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAPJRPvG010375
 for <linuxppc-dev@ozlabs.org>; Wed, 25 Nov 2015 12:27:26 -0700
Subject: Re: [2/2] powerpc/smp: Add smp_muxed_ipi_rm_message_pass
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
References: <20151116055359.76B0314145B@ozlabs.org>
 <564A4BF8.7070205@linux.vnet.ibm.com>
Cc: paulus@samba.org
From: "Suresh E. Warrier" <warrier@linux.vnet.ibm.com>
Message-ID: <56560B9C.5070900@linux.vnet.ibm.com>
Date: Wed, 25 Nov 2015 13:27:24 -0600
MIME-Version: 1.0
In-Reply-To: <564A4BF8.7070205@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Mike,

After looking at this a little more, I think it would perhaps
be better to define the real-mode function that causes IPI in 
book3s_hv_rm_xics.c along with other real-mode functions that 
operate on the xics.

Hope this is acceptable to you. If not, we can discuss when
I re-submit the patch.

Thanks.
-suresh


On 11/16/2015 03:34 PM, Suresh E. Warrier wrote:
> Hi Mike,
> 
> The changes you proposed look nicer than what I have here.
> I will get that coded and tested and re=submit.
> 
> Thanks.
> -suresh
> 
> On 11/15/2015 11:53 PM, Michael Ellerman wrote:
>> Hi Suresh,
>>
>> On Thu, 2015-29-10 at 23:40:45 UTC, "Suresh E. Warrier" wrote:
>>> This function supports IPI message passing for real
>>> mode callers.
>>>
>>> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
>>> index a53a130..8c07bfad 100644
>>> --- a/arch/powerpc/kernel/smp.c
>>> +++ b/arch/powerpc/kernel/smp.c
>>> @@ -235,6 +238,33 @@ void smp_muxed_ipi_message_pass(int cpu, int msg)
>>>  	smp_ops->cause_ipi(cpu, info->data);
>>>  }
>>>  
>>> +#if defined(CONFIG_KVM_XICS) && defined(CONFIG_KVM_BOOK3S_HV_POSSIBLE)
>>> +/*
>>> + * Message passing code for real mode callers. It does not use the
>>> + * smp_ops->cause_ipi function to cause an IPI, because those functions
>>> + * access the MFFR through an ioremapped address.
>>> + */
>>> +void smp_muxed_ipi_rm_message_pass(int cpu, int msg)
>>> +{
>>> +	struct cpu_messages *info = &per_cpu(ipi_message, cpu);
>>> +	char *message = (char *)&info->messages;
>>> +	unsigned long xics_phys;
>>> +
>>> +	/*
>>> +	 * Order previous accesses before accesses in the IPI handler.
>>> +	 */
>>> +	smp_mb();
>>> +	message[msg] = 1;
>>> +
>>> +	/*
>>> +	 * cause_ipi functions are required to include a full barrier
>>> +	 * before doing whatever causes the IPI.
>>> +	 */
>>> +	xics_phys = paca[cpu].kvm_hstate.xics_phys;
>>> +	out_rm8((u8 *)(xics_phys + XICS_MFRR), IPI_PRIORITY);
>>> +}
>>> +#endif
>>
>>
>> I'm not all that happy with this. This function does two things, one of which
>> belongs in this file (setting message), and the other which definitely does
>> not (the XICs part).
>>
>> I think the end result would be cleaner if we did something like:
>>
>> void smp_muxed_ipi_set_message(int cpu, int msg)
>> {
>> 	struct cpu_messages *info = &per_cpu(ipi_message, cpu);
>> 	char *message = (char *)&info->messages;
>> 	unsigned long xics_phys;
>>
>> 	/*
>> 	 * Order previous accesses before accesses in the IPI handler.
>> 	 */
>> 	smp_mb();
>> 	message[msg] = 1;
>> }
>>
>> Which would be exported, and could also be used by smp_muxed_ipi_message_pass().
>>
>> Then in icp_rm_set_vcpu_irq(), you would do something like:
>>
>> 	if (hcore != -1) {
>> 		hcpu = hcore << threads_shift;
>> 		kvmppc_host_rm_ops_hv->rm_core[hcore].rm_data = vcpu;
>> 		smp_muxed_ipi_set_message(hcpu, PPC_MSG_RM_HOST_ACTION);
>> 		icp_native_cause_ipi_real_mode();
>> 	}
>>
>> Where icp_native_cause_ipi_real_mode() is a new hook you define in icp_native.c
>> which does the real mode write to MFRR.
>>
>> cheers
>>
