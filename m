Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 07E441A045E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Mar 2016 13:14:08 +1100 (AEDT)
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 2 Mar 2016 12:14:06 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id A71FB2CE805D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Mar 2016 13:14:00 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u222Dq8K54460536
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Mar 2016 13:14:00 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u222DSwH026045
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Mar 2016 13:13:28 +1100
Date: Wed, 2 Mar 2016 13:13:03 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Russell Currey <ruscur@russell.cc>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 3/3] powerpc/eeh: Synchronize recovery in host/guest
Message-ID: <20160302021303.GA17916@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1456445092-18337-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1456445092-18337-4-git-send-email-gwshan@linux.vnet.ibm.com>
 <1456880600.4528.3.camel@russell.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1456880600.4528.3.camel@russell.cc>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 02, 2016 at 12:03:20PM +1100, Russell Currey wrote:
>On Fri, 2016-02-26 at 11:04 +1100, Gavin Shan wrote:
>> When passing through SRIOV VFs to guest, we possibly encounter EEH
>> error on PF. In this case, the VF PEs are put into frozen state.
>> The error could be reported to guest before it's captured by the
>> host. That means the guest could attempt to recover errors on VFs
>> before host gets chance to recover errors on PFs. The VFs won't be
>> recovered successfully.
>> 
>> This enforces the recovery order for above case: the recovery on
>> child PE in guest is hold until the recovery on parent PE in host
>> is completed.
>> 
>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/kernel/eeh.c | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>> 
>> diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
>> index fd9c782..42bd546 100644
>> --- a/arch/powerpc/kernel/eeh.c
>> +++ b/arch/powerpc/kernel/eeh.c
>> @@ -1541,6 +1541,17 @@ int eeh_pe_get_state(struct eeh_pe *pe)
>>  	if (!eeh_ops || !eeh_ops->get_state)
>>  		return -ENOENT;
>>  
>> +	/*
>> +	 * If the parent PE, which is owned by host kernel, is
>> experiencing
>> +	 * error recovery. We should return temporarily unavailable PE
>> state
>> +	 * so that the recovery on guest side is suspended until the
>> error
>> +	 * recovery is completed on host side.
>> +	 */
>
>Hi Gavin,
>
>I think this could be worded a little better.  For example:
>
>/*
> * If the parent PE is owned by the host kernel and is undergoing
> * error recovery, we should return the PE state as temporarily
> * unavailable so that the error recovery on the guest is suspended
> * until the recovery completes on the host.
> */
>

Yes, it will be integrated to v2. Thanks for review.

>> +	if (pe->parent &&
>> +	    !(pe->state & EEH_PE_REMOVED) &&
>> +	    (pe->parent->state & (EEH_PE_ISOLATED | EEH_PE_RECOVERING)))
>> +		return EEH_PE_STATE_UNAVAIL;
>> +
>>  	result = eeh_ops->get_state(pe, NULL);
>>  	rst_active = !!(result & EEH_STATE_RESET_ACTIVE);
>>  	dma_en = !!(result & EEH_STATE_DMA_ENABLED);
>

Thanks,
Gavin
