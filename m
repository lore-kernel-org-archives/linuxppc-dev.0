Return-Path: <kernelfans@gmail.com>
Received: from mail-yk0-x22e.google.com (mail-yk0-x22e.google.com
 [IPv6:2607:f8b0:4002:c07::22e])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5FFB51A017A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Nov 2014 16:24:44 +1100 (AEDT)
Received: by mail-yk0-f174.google.com with SMTP id 10so1837376ykt.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Nov 2014 21:24:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <544DCDD0.2080508@linux.vnet.ibm.com>
References: <1413487800-7162-1-git-send-email-kernelfans@gmail.com>
 <1413487800-7162-5-git-send-email-kernelfans@gmail.com>
 <544DCDD0.2080508@linux.vnet.ibm.com>
Date: Tue, 18 Nov 2014 13:24:41 +0800
Message-ID: <CAFgQCTvvVZ-thFVvr1P0AYMpqRyEXZebpcrc7_kviY7eLx9niQ@mail.gmail.com>
Subject: Re: [RFC 04/11] powerpc: kvm: introduce a kthread on primary thread
 to anti tickless
From: Liu ping fan <kernelfans@gmail.com>
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Alexander Graf <agraf@suse.de>, kvm-ppc <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 27, 2014 at 12:45 PM, Preeti U Murthy
<preeti@linux.vnet.ibm.com> wrote:
> On 10/17/2014 12:59 AM, kernelfans@gmail.com wrote:
>> (This patch is a place holder.)
>>
>> If there is only one vcpu thread is ready(the other vcpu thread can
>> wait for it to execute), the primary thread can enter tickless mode,
>
> We do not configure NOHZ_FULL to y by default. Hence no thread would
> enter tickless mode.
>
But NOHZ_FULL can be chosen by user, and we should survive from it :)

>> which causes the primary keeps running, so the secondary has no
>> opportunity to exit to host, even they have other tsk on them.
>
> The secondary threads can still get scheduling ticks. The decrementer of
> the secondary threads is still active. So as long as secondary threads
> are busy, scheduling ticks will fire and try to schedule a new task on them.
>
No. As my original thought, after enable KVM on core, the HDEC on
secondary is disabled, otherwise the host exit will be too frequent.
Any suggestion?

Thx,
Fan

> Regards
> Preeti U Murthy
>>
>> Introduce a kthread (anti_tickless) on primary, so when there is only
>> one vcpu thread on primary, the secondary can resort to anti_tickless
>> to keep the primary out of tickless mode.
>> (I thought that anti_tickless thread can goto NAP, so we can let the
>> secondary run).
>>
>> Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/kernel/sysfs.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
>> index a2595dd..f0b110e 100644
>> --- a/arch/powerpc/kernel/sysfs.c
>> +++ b/arch/powerpc/kernel/sysfs.c
>> @@ -575,9 +575,11 @@ static ssize_t __used store_kvm_enable(struct device *dev,
>>       if (!test_bit(core, &kvm_on_core))
>>               for (thr = 1; thr< threads_per_core; thr++)
>>                       if (cpu_online(thr * threads_per_core + thr))
>> -                             cpumask_set_cpu(thr * threads_per_core + thr, &stop_cpus);
>> +                             cpumask_set_cpu(core * threads_per_core + thr, &stop_cpus);
>>
>>       stop_machine(xics_migrate_irqs_away_secondary, NULL, &stop_cpus);
>> +     /* fixme, create a kthread on primary hwthread to handle tickless mode */
>> +     //kthread_create_on_cpu(prevent_tickless, NULL, core * threads_per_core, "ppckvm_prevent_tickless");
>>       set_bit(core, &kvm_on_core);
>>       return count;
>>  }
>>
>
