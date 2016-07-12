Return-Path: <sjitindarsingh@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rpYLv0xkPzDqDT
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 17:22:14 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id g202so570007pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 00:22:14 -0700 (PDT)
Subject: Re: [PATCH V2 5/5] powerpc/kvm/stats: Implement existing and add new
 halt polling vcpu stats
To: David Matlack <dmatlack@google.com>
References: <1468220912-22828-1-git-send-email-sjitindarsingh@gmail.com>
 <1468220912-22828-5-git-send-email-sjitindarsingh@gmail.com>
 <CALzav=ep=8DJixnnoT3czrjZB7WFNxFbnjE1VOX6So3bywAtcA@mail.gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 mpe@ellerman.id.au, paulus@samba.org, benh@kernel.crashing.org,
 kvm list <kvm@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 agraf@suse.com, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Message-ID: <57848B93.7050808@gmail.com>
Date: Tue, 12 Jul 2016 16:17:55 +1000
MIME-Version: 1.0
In-Reply-To: <CALzav=ep=8DJixnnoT3czrjZB7WFNxFbnjE1VOX6So3bywAtcA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/07/16 02:49, David Matlack wrote:
> On Mon, Jul 11, 2016 at 12:08 AM, Suraj Jitindar Singh
> <sjitindarsingh@gmail.com> wrote:
>> vcpu stats are used to collect information about a vcpu which can be viewed
>> in the debugfs. For example halt_attempted_poll and halt_successful_poll
>> are used to keep track of the number of times the vcpu attempts to and
>> successfully polls. These stats are currently not used on powerpc.
>>
>> Implement incrementation of the halt_attempted_poll and
>> halt_successful_poll vcpu stats for powerpc. Since these stats are summed
>> over all the vcpus for all running guests it doesn't matter which vcpu
>> they are attributed to, thus we choose the current runner vcpu of the
>> vcore.
>>
>> Also add new vcpu stats: halt_poll_time and halt_wait_time to be used to
>> accumulate the total time spend polling and waiting respectively, and
>> halt_successful_wait to accumulate the number of times the vcpu waits.
>> Given that halt_poll_time and halt_wait_time are expressed in nanoseconds
>> it is necessary to represent these as 64-bit quantities, otherwise they
>> would overflow after only about 4 seconds.
>>
>> Given that the total time spend either polling or waiting will be known and
>> the number of times that each was done, it will be possible to determine
>> the average poll and wait times. This will give the ability to tune the kvm
>> module parameters based on the calculated average wait and poll times.
>>
>> ---
>> Change Log:
>>
>> V1 -> V2:
>>         - Nothing
>>
>> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
>> ---
>>  arch/powerpc/include/asm/kvm_host.h |  3 +++
>>  arch/powerpc/kvm/book3s.c           |  3 +++
>>  arch/powerpc/kvm/book3s_hv.c        | 14 +++++++++++++-
>>  3 files changed, 19 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
>> index 610f393..66a7198 100644
>> --- a/arch/powerpc/include/asm/kvm_host.h
>> +++ b/arch/powerpc/include/asm/kvm_host.h
>> @@ -114,8 +114,11 @@ struct kvm_vcpu_stat {
>>         u32 emulated_inst_exits;
>>         u32 dec_exits;
>>         u32 ext_intr_exits;
>> +       u64 halt_poll_time;
>> +       u64 halt_wait_time;
>>         u32 halt_successful_poll;
>>         u32 halt_attempted_poll;
>> +       u32 halt_successful_wait;
>>         u32 halt_poll_invalid;
>>         u32 halt_wakeup;
>>         u32 dbell_exits;
>> diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
>> index ed9132b..6217bea 100644
>> --- a/arch/powerpc/kvm/book3s.c
>> +++ b/arch/powerpc/kvm/book3s.c
>> @@ -53,8 +53,11 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
>>         { "dec",         VCPU_STAT(dec_exits) },
>>         { "ext_intr",    VCPU_STAT(ext_intr_exits) },
>>         { "queue_intr",  VCPU_STAT(queue_intr) },
>> +       { "halt_poll_time_ns",          VCPU_STAT_U64(halt_poll_time) },
>> +       { "halt_wait_time_ns",          VCPU_STAT_U64(halt_wait_time) },
>>         { "halt_successful_poll", VCPU_STAT(halt_successful_poll), },
>>         { "halt_attempted_poll", VCPU_STAT(halt_attempted_poll), },
>> +       { "halt_successful_wait",       VCPU_STAT(halt_successful_wait) },
>>         { "halt_poll_invalid", VCPU_STAT(halt_poll_invalid) },
>>         { "halt_wakeup", VCPU_STAT(halt_wakeup) },
>>         { "pf_storage",  VCPU_STAT(pf_storage) },
>> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
>> index 0d8ce14..a0dae63 100644
>> --- a/arch/powerpc/kvm/book3s_hv.c
>> +++ b/arch/powerpc/kvm/book3s_hv.c
>> @@ -2688,6 +2688,7 @@ static void kvmppc_vcore_blocked(struct kvmppc_vcore *vc)
>>         cur = start = ktime_get();
>>         if (vc->halt_poll_ns) {
>>                 ktime_t stop = ktime_add_ns(start, vc->halt_poll_ns);
>> +               ++vc->runner->stat.halt_attempted_poll;
>>
>>                 vc->vcore_state = VCORE_POLLING;
>>                 spin_unlock(&vc->lock);
>> @@ -2703,8 +2704,10 @@ static void kvmppc_vcore_blocked(struct kvmppc_vcore *vc)
>>                 spin_lock(&vc->lock);
>>                 vc->vcore_state = VCORE_INACTIVE;
>>
>> -               if (!do_sleep)
>> +               if (!do_sleep) {
>> +                       ++vc->runner->stat.halt_successful_poll;
>>                         goto out;
>> +               }
>>         }
>>
>>         prepare_to_swait(&vc->wq, &wait, TASK_INTERRUPTIBLE);
>> @@ -2712,6 +2715,9 @@ static void kvmppc_vcore_blocked(struct kvmppc_vcore *vc)
>>         if (kvmppc_vcore_check_block(vc)) {
>>                 finish_swait(&vc->wq, &wait);
>>                 do_sleep = 0;
>> +               /* If we polled, count this as a successful poll */
>> +               if (vc->halt_poll_ns)
>> +                       ++vc->runner->stat.halt_successful_poll;
>>                 goto out;
>>         }
>>
>> @@ -2723,12 +2729,18 @@ static void kvmppc_vcore_blocked(struct kvmppc_vcore *vc)
>>         spin_lock(&vc->lock);
>>         vc->vcore_state = VCORE_INACTIVE;
>>         trace_kvmppc_vcore_blocked(vc, 1);
>> +       ++vc->runner->stat.halt_successful_wait;
>>
>>         cur = ktime_get();
>>
>>  out:
>>         block_ns = ktime_to_ns(cur) - ktime_to_ns(start);
>>
>> +       if (do_sleep)
>> +               vc->runner->stat.halt_wait_time += block_ns;
> It's possible to poll and wait in one halt, conflating this stat with
> polling time. Is it useful to split out a third stat,
> halt_poll_fail_ns which counts how long we polled which ended up
> sleeping? Then halt_wait_time only counts the time the VCPU spent on
> the wait queue. The sum of all 3 is still the total time spent halted.
>
I see what you're saying. I would say that in the event that you do wait
then the most useful number is going to be the total block time (the sum
of the wait and poll time) as this is the minimum value you would have to
set the halt_poll_max_ns module parameter in order to ensure you poll
for long enough (in most circumstances) to avoid waiting, which is the main 
use case I envision for this statistic. That being said this is definitely
a source of ambiguity and splitting this into two statistics would make the
distinction clearer without any loss of data, you could simply sum the two
stats to get the same number.

Either way I don't think it really makes much of a difference, but in the
interest of clarity I think I'll split the statistic.

>> +       else if (vc->halt_poll_ns)
>> +               vc->runner->stat.halt_poll_time += block_ns;
>> +
>>         if (halt_poll_max_ns) {
>>                 if (block_ns <= vc->halt_poll_ns)
>>                         ;
>> --
>> 2.5.5
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe kvm" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
