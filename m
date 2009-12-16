Return-Path: <xtfeng@gmail.com>
Received: from mail-pw0-f50.google.com (mail-pw0-f50.google.com
	[209.85.160.50]) by ozlabs.org (Postfix) with ESMTP id F1DA1B6F04
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Dec 2009 20:07:12 +1100 (EST)
Received: by pwi20 with SMTP id 20so521698pwi.9
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Dec 2009 01:07:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4B289955.2010705@in.ibm.com>
References: <4B2224C7.1020908@in.ibm.com>
	<7b6bb4a50912152225p4f5dde13re83c439407c16eaf@mail.gmail.com>
	<4B288131.2050306@in.ibm.com>
	<7b6bb4a50912152245v61a7f1ebgb41f4857134f3476@mail.gmail.com>
	<4B288413.2070704@in.ibm.com> <1260947890.8023.1281.camel@laptop>
	<7b6bb4a50912152357m75aea5dfl6fe063d716517baf@mail.gmail.com>
	<4B289955.2010705@in.ibm.com>
Date: Wed, 16 Dec 2009 17:07:11 +0800
Message-ID: <7b6bb4a50912160107j1c8348b6p235844193e3ee977@mail.gmail.com>
Subject: Re: [Next] CPU Hotplug test failures on powerpc
From: Xiaotian Feng <xtfeng@gmail.com>
To: Sachin Sant <sachinp@in.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: Peter Zijlstra <peterz@infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	linux-next@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Dec 16, 2009 at 4:24 PM, Sachin Sant <sachinp@in.ibm.com> wrote:
> Xiaotian Feng wrote:
>>
>> Could follow be possible? =C2=A0We know there's cpu 0 and cpu 1,
>>
>> offline cpu1 > done
>> offline cpu0 > false
>>
>> consider this in cpu_down code,
>>
>>
>> int __ref cpu_down(unsigned int cpu)
>> {
>> <snip>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0set_cpu_active(cpu, false); // here, we set c=
pu 0 to inactive
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0synchronize_sched();
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D _cpu_down(cpu, 0);
>> out:
>> <snip>
>> }
>>
>> Then in _cpu_down code:
>>
>> static int __ref _cpu_down(unsigned int cpu, int tasks_frozen)
>> {
>> <snip>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (num_online_cpus() =3D=3D 1) =C2=A0 =C2=A0=
 =C2=A0 =C2=A0// if we're trying to
>> offline cpu0, num_online_cpus will be 1
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EBUSY; =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0// aft=
er return back
>> to cpu_down, we didn't change cpu 0 back to active
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!cpu_online(cpu))
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!alloc_cpumask_var(&old_allowed, GFP_KERN=
EL))
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM;
>> <snip>
>> }
>>
>> Then cpu 0 is not active, but online, then we try to offline cpu1, .....=
..
>> This can not be exposed because x86 does not have
>> /sys/devices/system/cpu0/online.
>> I guess following patch fixes this bug.
>>
>
> Just tested this one on the POWER box and the test passed.
> I did not observe the hang.

Thanks for confirm, I will send formatted patch to upstream then:-)

>
> Thanks
> -Sachin
>
>> ---
>> diff --git a/kernel/cpu.c b/kernel/cpu.c
>> index 291ac58..21ddace 100644
>> --- a/kernel/cpu.c
>> +++ b/kernel/cpu.c
>> @@ -199,14 +199,18 @@ static int __ref _cpu_down(unsigned int cpu, int
>> tasks_frozen)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.hcpu =3D hcpu,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0};
>>
>> - =C2=A0 =C2=A0 =C2=A0 if (num_online_cpus() =3D=3D 1)
>> + =C2=A0 =C2=A0 =C2=A0 if (num_online_cpus() =3D=3D 1) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set_cpu_active(cpu, t=
rue);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EBUSY;
>> + =C2=A0 =C2=A0 =C2=A0 }
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!cpu_online(cpu))
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;
>>
>> - =C2=A0 =C2=A0 =C2=A0 if (!alloc_cpumask_var(&old_allowed, GFP_KERNEL))
>> + =C2=A0 =C2=A0 =C2=A0 if (!alloc_cpumask_var(&old_allowed, GFP_KERNEL))=
 {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set_cpu_active(cpu, t=
rue);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM;
>> + =C2=A0 =C2=A0 =C2=A0 }
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0cpu_hotplug_begin();
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D __raw_notifier_call_chain(&cpu_chain,=
 CPU_DOWN_PREPARE | mod,
>>
>>
>>
>>>
>>> Unless of course, I messed up, which appears to be rather likely given
>>> these problems ;-)
>>>
>>>
>>>
>>
>>
>
>
> --
>
> ---------------------------------
> Sachin Sant
> IBM Linux Technology Center
> India Systems and Technology Labs
> Bangalore, India
> ---------------------------------
>
>
