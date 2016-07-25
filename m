Return-Path: <sjitindarsingh@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ryMyB1ZcTzDqRX
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 10:46:26 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id y134so10853436pfg.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Jul 2016 17:46:26 -0700 (PDT)
Subject: Re: [PATCH V5 5/5] powerpc/kvm/stats: Implement existing and add new
 halt polling vcpu stats
To: David Matlack <dmatlack@google.com>
References: <1469158863-28518-1-git-send-email-sjitindarsingh@gmail.com>
 <1469158863-28518-5-git-send-email-sjitindarsingh@gmail.com>
 <CALzav=cYY0YMhPOuU7rzimPJhg5ofcwK=1aqCnb6NPw783O=6A@mail.gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 mpe@ellerman.id.au, paulus@samba.org, benh@kernel.crashing.org,
 Paolo Bonzini <pbonzini@redhat.com>, agraf@suse.com,
 =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Message-ID: <5795615A.7080104@gmail.com>
Date: Mon, 25 Jul 2016 10:46:18 +1000
MIME-Version: 1.0
In-Reply-To: <CALzav=cYY0YMhPOuU7rzimPJhg5ofcwK=1aqCnb6NPw783O=6A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 23/07/16 07:53, David Matlack wrote:
> On Thu, Jul 21, 2016 at 8:41 PM, Suraj Jitindar Singh
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
>> Also add new vcpu stats: halt_poll_success_ns, halt_poll_fail_ns and
>> halt_wait_ns to be used to accumulate the total time spend polling
>> successfully, polling unsuccessfully and waiting respectively, and
>> halt_successful_wait to accumulate the number of times the vcpu waits.
>> Given that halt_poll_success_ns, halt_poll_fail_ns and halt_wait_ns are
>> expressed in nanoseconds it is necessary to represent these as 64-bit
>> quantities, otherwise they would overflow after only about 4 seconds.
>>
>> Given that the total time spend either polling or waiting will be known and
>> the number of times that each was done, it will be possible to determine
>> the average poll and wait times. This will give the ability to tune the kvm
>> module parameters based on the calculated average wait and poll times.
>>
>> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
>> Reviewed-by: David Matlack <dmatlack@google.com>
>>
>> ---
>> Change Log:
>>
>> V3 -> V4:
>>         - Instead of accounting just wait and poll time, separate these
>>           into successful_poll_time, failed_poll_time and wait_time.
>> V4 -> V5:
>>         - Add single_task_running() check to polling loop
> I was expecting to see this in PATCH 3/5 with the halt-polling
> implementation. But otherwise, looks good, and the net effect is the
> same

That would have made more sense, obviously that was my Friday afternoon brain.

> .
>
>> ---
>>  arch/powerpc/include/asm/kvm_host.h |  4 ++++
>>  arch/powerpc/kvm/book3s.c           |  4 ++++
>>  arch/powerpc/kvm/book3s_hv.c        | 38 +++++++++++++++++++++++++++++++------
>>  3 files changed, 40 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
>> index f6304c5..f15ffc0 100644
>> --- a/arch/powerpc/include/asm/kvm_host.h
>> +++ b/arch/powerpc/include/asm/kvm_host.h
>> @@ -114,8 +114,12 @@ struct kvm_vcpu_stat {
>>         u64 emulated_inst_exits;
>>         u64 dec_exits;
>>         u64 ext_intr_exits;
>> +       u64 halt_poll_success_ns;
>> +       u64 halt_poll_fail_ns;
>> +       u64 halt_wait_ns;
>>         u64 halt_successful_poll;
>>         u64 halt_attempted_poll;
>> +       u64 halt_successful_wait;
>>         u64 halt_poll_invalid;
>>         u64 halt_wakeup;
>>         u64 dbell_exits;
>> diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
>> index 47018fc..71eb8f3 100644
>> --- a/arch/powerpc/kvm/book3s.c
>> +++ b/arch/powerpc/kvm/book3s.c
>> @@ -52,8 +52,12 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
>>         { "dec",         VCPU_STAT(dec_exits) },
>>         { "ext_intr",    VCPU_STAT(ext_intr_exits) },
>>         { "queue_intr",  VCPU_STAT(queue_intr) },
>> +       { "halt_poll_success_ns",       VCPU_STAT(halt_poll_success_ns) },
>> +       { "halt_poll_fail_ns",          VCPU_STAT(halt_poll_fail_ns) },
>> +       { "halt_wait_ns",               VCPU_STAT(halt_wait_ns) },
>>         { "halt_successful_poll", VCPU_STAT(halt_successful_poll), },
>>         { "halt_attempted_poll", VCPU_STAT(halt_attempted_poll), },
>> +       { "halt_successful_wait",       VCPU_STAT(halt_successful_wait) },
>>         { "halt_poll_invalid", VCPU_STAT(halt_poll_invalid) },
>>         { "halt_wakeup", VCPU_STAT(halt_wakeup) },
>>         { "pf_storage",  VCPU_STAT(pf_storage) },
>> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
>> index a9de1d4..b1d9e88 100644
>> --- a/arch/powerpc/kvm/book3s_hv.c
>> +++ b/arch/powerpc/kvm/book3s_hv.c
>> @@ -2679,15 +2679,16 @@ static int kvmppc_vcore_check_block(struct kvmppc_vcore *vc)
>>   */
>>  static void kvmppc_vcore_blocked(struct kvmppc_vcore *vc)
>>  {
>> +       ktime_t cur, start_poll, start_wait;
>>         int do_sleep = 1;
>> -       ktime_t cur, start;
>>         u64 block_ns;
>>         DECLARE_SWAITQUEUE(wait);
>>
>>         /* Poll for pending exceptions and ceded state */
>> -       cur = start = ktime_get();
>> +       cur = start_poll = ktime_get();
>>         if (vc->halt_poll_ns) {
>> -               ktime_t stop = ktime_add_ns(start, vc->halt_poll_ns);
>> +               ktime_t stop = ktime_add_ns(start_poll, vc->halt_poll_ns);
>> +               ++vc->runner->stat.halt_attempted_poll;
>>
>>                 vc->vcore_state = VCORE_POLLING;
>>                 spin_unlock(&vc->lock);
>> @@ -2698,13 +2699,15 @@ static void kvmppc_vcore_blocked(struct kvmppc_vcore *vc)
>>                                 break;
>>                         }
>>                         cur = ktime_get();
>> -               } while (ktime_before(cur, stop));
>> +               } while (single_task_running() && ktime_before(cur, stop));
>>
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
>> @@ -2712,9 +2715,14 @@ static void kvmppc_vcore_blocked(struct kvmppc_vcore *vc)
>>         if (kvmppc_vcore_check_block(vc)) {
>>                 finish_swait(&vc->wq, &wait);
>>                 do_sleep = 0;
>> +               /* If we polled, count this as a successful poll */
>> +               if (vc->halt_poll_ns)
>> +                       ++vc->runner->stat.halt_successful_poll;
>>                 goto out;
>>         }
>>
>> +       start_wait = ktime_get();
>> +
>>         vc->vcore_state = VCORE_SLEEPING;
>>         trace_kvmppc_vcore_blocked(vc, 0);
>>         spin_unlock(&vc->lock);
>> @@ -2723,11 +2731,29 @@ static void kvmppc_vcore_blocked(struct kvmppc_vcore *vc)
>>         spin_lock(&vc->lock);
>>         vc->vcore_state = VCORE_INACTIVE;
>>         trace_kvmppc_vcore_blocked(vc, 1);
>> +       ++vc->runner->stat.halt_successful_wait;
>>
>>         cur = ktime_get();
>>
>>  out:
>> -       block_ns = ktime_to_ns(cur) - ktime_to_ns(start);
>> +       block_ns = ktime_to_ns(cur) - ktime_to_ns(start_poll);
>> +
>> +       /* Attribute wait time */
>> +       if (do_sleep) {
>> +               vc->runner->stat.halt_wait_ns +=
>> +                       ktime_to_ns(cur) - ktime_to_ns(start_wait);
>> +               /* Attribute failed poll time */
>> +               if (vc->halt_poll_ns)
>> +                       vc->runner->stat.halt_poll_fail_ns +=
>> +                               ktime_to_ns(start_wait) -
>> +                               ktime_to_ns(start_poll);
>> +       } else {
>> +               /* Attribute successful poll time */
>> +               if (vc->halt_poll_ns)
>> +                       vc->runner->stat.halt_poll_success_ns +=
>> +                               ktime_to_ns(cur) -
>> +                               ktime_to_ns(start_poll);
>> +       }
>>
>>         /* Adjust poll time */
>>         if (halt_poll_max_ns) {
>> --
>> 2.5.5
>>
