Return-Path: <clombard@linux.vnet.ibm.com>
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qpzs212p2zDq60
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 19:16:05 +1000 (AEST)
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clombard@linux.vnet.ibm.com>;
 Tue, 19 Apr 2016 10:16:02 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id EA0062190046
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 10:15:34 +0100 (BST)
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
 [9.149.37.228])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3J9FuXW2949508
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 09:15:56 GMT
Received: from d06av02.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av02.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3J9FuGJ031500
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 03:15:56 -0600
Subject: Re: [PATCH] cxl: Add a kernel thread to check the coherent platform
 function's state
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>, imunsie@au1.ibm.com,
 fbarrat@linux.vnet.ibm.com
References: <1460984701-21490-1-git-send-email-clombard@linux.vnet.ibm.com>
 <57159A87.70705@au1.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: christophe lombard <clombard@linux.vnet.ibm.com>
Message-ID: <5715F74B.8000405@linux.vnet.ibm.com>
Date: Tue, 19 Apr 2016 11:15:55 +0200
MIME-Version: 1.0
In-Reply-To: <57159A87.70705@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 19/04/2016 04:40, Andrew Donnellan wrote:
> On 18/04/16 23:05, Christophe Lombard wrote:
>> In the POWERVM environement, the PHYP CoherentAccel component manages
>
> environment
>
>> the state of the Coherant Accelerator Processor Interface adapter and
>
> Coherent
>
>> virtualizes CAPI resources, handles CAPP, PSL, PSL Slice errors - and
>> interrupts - and provides a new set of HCALLs for the OS APIs to utilize
>> AFUs.
>>
>> During the course of operation, a coherent platform function can
>> encounter errors. Some possible reason for errors are:
>> • Hardware recoverable and unrecoverable errors
>> • Transient and over-threshold correctable errors
>>
>> PHYP implements its own state model for the coherent platform function.
>> The current state of this Acclerator Fonction Unit (AFU) is available
>
> Accelerator Function Unit
>
>> through a hcall.
>>
>> In case of low-level troubles (or error injection), The PHYP component
>
> the
>
>> may reset the card and change the AFU state. The PHYP interface doesn't
>> provide any way to be notified when that happens.
>>
>> The current implementation of the cxl driver, for the POWERVM
>> environment, follows the general error recovery procedures required to
>> reset operation of the coherent platform function. The platform firmware
>> resets and reconfigures hardware when an external action is required -
>> attach/detach a process, link ok, ....
>>
>> The purpose of this patch is to interact with the external driver
>> (where the AFU is shown) even if no action is required. A kernel thread
>> is needed to check every x seconds the current state of the AFU to see
>> if we need to enter an error recovery path.
>>
>> Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
>
> A few minor issues below.
>
>> diff --git a/drivers/misc/cxl/guest.c b/drivers/misc/cxl/guest.c
>> index 8213372..06dfe7f 100644
>> --- a/drivers/misc/cxl/guest.c
>> +++ b/drivers/misc/cxl/guest.c
>> @@ -19,6 +19,10 @@
>>   #define CXL_SLOT_RESET_EVENT        2
>>   #define CXL_RESUME_EVENT        3
>>
>> +#define CXL_KTHREAD             "cxl_kthread"
>> +
>> +void stop_state_thread(struct cxl_afu *afu);
>
> static?
>
> [...]
>
>> -static int afu_do_recovery(struct cxl_afu *afu)
>> +static int handle_state_thread(void *data)
>>   {
>> -    int rc;
>> +    struct cxl_afu *afu;
>> +    int rc = 0;
>
> It looks like we don't use rc (see also comment below).
>
>>
>> -    /* many threads can arrive here, in case of detach_all for example.
>> -     * Only one needs to drive the recovery
>> -     */
>> -    if (mutex_trylock(&afu->guest->recovery_lock)) {
>> -        rc = afu_update_state(afu);
>> -        mutex_unlock(&afu->guest->recovery_lock);
>> -        return rc;
>> +    pr_devel("in %s\n", __func__);
>> +
>> +    afu = (struct cxl_afu*)data;
>
> CodingStyle: space between cxl_afu and *
>
>> +    do {
>> +        set_current_state(TASK_INTERRUPTIBLE);
>> +
>> +        if (afu) {
>> +            afu_update_state(afu);
>
> Should we be checking the retval here?

Right, We have to check the retval here. Thanks


>
>> +            if (afu->guest->previous_state == H_STATE_PERM_UNAVAILABLE)
>> +                goto out;
>> +        } else
>> +            return -ENODEV;
>> +        schedule_timeout(msecs_to_jiffies(3000));
>> +    } while(!kthread_should_stop());
>
> CodingStyle: space between while and (
>
>> +
>> +out:
>> +    afu->guest->kthread_tsk = NULL;
>> +    return rc;
>> +}
>> +
>> +void start_state_thread(struct cxl_afu *afu)
>
> static?
>
>> +{
>> +    if (afu->guest->kthread_tsk)
>> +        return;
>> +
>> +    /* start kernel thread to handle the state of the afu */
>> +    afu->guest->kthread_tsk = kthread_run(&handle_state_thread,
>> +                  (void *)afu, CXL_KTHREAD);
>> +    if (IS_ERR(afu->guest->kthread_tsk)) {
>> +        pr_devel("cannot start state kthread\n");
>> +        afu->guest->kthread_tsk = NULL;
>>       }
>> -    return 0;
>> +}
>> +
>> +void stop_state_thread(struct cxl_afu *afu)
>
> static?
>

Thanks for the review. I will send a patch update.
