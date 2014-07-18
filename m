Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 334951A01EA
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jul 2014 14:10:23 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Thu, 17 Jul 2014 22:10:21 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 1CA421FF0045
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jul 2014 22:10:18 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08026.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6I496dN7405972
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jul 2014 06:09:06 +0200
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6I4AI1S000753
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jul 2014 22:10:18 -0600
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v3] Use the POWER8 Micro Partition Prefetch Engine in KVM
 HV on POWER8
In-Reply-To: <20140717235214.GB8513@iris.ozlabs.ibm.com>
References: <1404795988-9892-1-git-send-email-stewart@linux.vnet.ibm.com>
 <1405567197-23333-1-git-send-email-stewart@linux.vnet.ibm.com>
 <20140717235214.GB8513@iris.ozlabs.ibm.com>
Date: Fri, 18 Jul 2014 14:10:14 +1000
Message-ID: <m3lhrrmhnd.fsf@oc8180480414.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org, Alexander Graf <agraf@suse.de>,
 kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paul Mackerras <paulus@samba.org> writes:
> On Thu, Jul 17, 2014 at 01:19:57PM +1000, Stewart Smith wrote:
>
>> The POWER8 processor has a Micro Partition Prefetch Engine, which is
>> a fancy way of saying "has way to store and load contents of L2 or
>> L2+MRU way of L3 cache". We initiate the storing of the log (list of
>> addresses) using the logmpp instruction and start restore by writing
>> to a SPR.
>> 
>> The logmpp instruction takes parameters in a single 64bit register:
>> - starting address of the table to store log of L2/L2+L3 cache contents
>>   - 32kb for L2
>>   - 128kb for L2+L3
>>   - Aligned relative to maximum size of the table (32kb or 128kb)
>> - Log control (no-op, L2 only, L2 and L3, abort logout)
>> 
>> We should abort any ongoing logging before initiating one.
>
> Do we ever want to wait for ongoing logging to finish?

*Probably* not... but as far as I can see the hardware doesn't expose a
way to find out if there is any ongoing logging or a way to be notified
when it's done.

>> +#if defined(CONFIG_PPC_64K_PAGES)
>> +#define MPP_BUFFER_ORDER	0
>> +#elif defined(CONFIG_PPC_4K_PAGES)
>> +#define MPP_BUFFER_ORDER	4
>
> Why 4 not 3?  You only need 32kB, don't you?

Correct. whoops.

>> +static struct kvmppc_vcore *kvmppc_vcore_create(struct kvm *kvm, int core)
>> +{
>> +	struct kvmppc_vcore *vcore;
>> +
>> +	vcore = kzalloc(sizeof(struct kvmppc_vcore), GFP_KERNEL);
>> +
>> +	if (vcore == NULL)
>> +		return NULL;
>> +
>> +	INIT_LIST_HEAD(&vcore->runnable_threads);
>> +	spin_lock_init(&vcore->lock);
>> +	init_waitqueue_head(&vcore->wq);
>> +	vcore->preempt_tb = TB_NIL;
>> +	vcore->lpcr = kvm->arch.lpcr;
>> +	vcore->first_vcpuid = core * threads_per_core;
>> +	vcore->kvm = kvm;
>
> Is there a particular reason why you need to pull this code out into a
> separate function?  If so, it would be a little nicer if you did that
> in a separate patch, to make it easier to see that the code motion
> changes nothing.

ack, done.

>> @@ -1590,9 +1645,16 @@ static void kvmppc_run_core(struct kvmppc_vcore *vc)
>>  
>>  	srcu_idx = srcu_read_lock(&vc->kvm->srcu);
>>  
>> +	if (vc->mpp_buffer_is_valid)
>> +		ppc_start_restoring_l2_cache(vc);
>> +
>>  	__kvmppc_vcore_entry();
>>  
>>  	spin_lock(&vc->lock);
>> +
>> +	if (vc->mpp_buffer)
>> +		ppc_start_saving_l2_cache(vc);
>
> I wonder if we would get better performance improvements if we kicked
> this off earlier, for instance before we save all the FP/VSX state and
> switch the MMU?  I guess that could be a subsequent patch.

Possibly, yes. Maybe something to look at in future patch, along with if
also doing the L3 save/restore is a benefit.
