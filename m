Return-Path: <xtfeng@gmail.com>
Received: from mail-px0-f188.google.com (mail-px0-f188.google.com
	[209.85.216.188]) by ozlabs.org (Postfix) with ESMTP id 5C0B1B6F08
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Dec 2009 18:57:57 +1100 (EST)
Received: by pxi26 with SMTP id 26so569463pxi.17
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Dec 2009 23:57:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1260947890.8023.1281.camel@laptop>
References: <4B2224C7.1020908@in.ibm.com>
	<7b6bb4a50912152225p4f5dde13re83c439407c16eaf@mail.gmail.com>
	<4B288131.2050306@in.ibm.com>
	<7b6bb4a50912152245v61a7f1ebgb41f4857134f3476@mail.gmail.com>
	<4B288413.2070704@in.ibm.com> <1260947890.8023.1281.camel@laptop>
Date: Wed, 16 Dec 2009 15:57:56 +0800
Message-ID: <7b6bb4a50912152357m75aea5dfl6fe063d716517baf@mail.gmail.com>
Subject: Re: [Next] CPU Hotplug test failures on powerpc
From: Xiaotian Feng <xtfeng@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset=UTF-8
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
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

On Wed, Dec 16, 2009 at 3:18 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Wed, 2009-12-16 at 12:24 +0530, Sachin Sant wrote:
>> Xiaotian Feng wrote:
>> > On Wed, Dec 16, 2009 at 2:41 PM, Sachin Sant <sachinp@in.ibm.com> wrote:
>> >
>> >> Xiaotian Feng wrote:
>> >>
>> >>> Does this testcase hotplug cpu 0 off?
>> >>>
>> >>>
>> >> No, i don't think so. It skips cpu0 during online/offline
>> >> process.
>> >>
>> >
>> > Then how could this happen ? Looks like cpu 0 is offline ....
>> > 0:mon> <4>IRQ 17 affinity broken off cpu 0
>> > <4>IRQ 18 affinity broken off cpu 0
>> > <4>IRQ 19 affinity broken off cpu 0
>> > <4>IRQ 264 affinity broken off cpu 0
>> > <4>cpu 0 (hwid 0) Ready to die...
>> > <7>clockevent: decrementer mult[83126e97] shift[32] cpu[0]
>> >
>> Sorry i was looking at only one script. Looking more closely
>> at the test there are 6 different sub tests. The rest of the
>> tests do seem to hotplug CPU 0.
>
> Ooh, cute, so you can actually hotplug cpu 0.. no wonder that didn't get
> exposed on x86.
>
> Still, the only time cpu_active_mask should not be equal to
> cpu_online_mask is when we're in the middle of a hotplug, we clear
> active early and set it late, but its all done under the hotplug mutex,
> so we can at most have 1 cpu differences with online mask.
>

Could follow be possible?  We know there's cpu 0 and cpu 1,

offline cpu1 > done
offline cpu0 > false

consider this in cpu_down code,


int __ref cpu_down(unsigned int cpu)
{
<snip>
        set_cpu_active(cpu, false); // here, we set cpu 0 to inactive

        synchronize_sched();

        err = _cpu_down(cpu, 0);
out:
<snip>
}

Then in _cpu_down code:

static int __ref _cpu_down(unsigned int cpu, int tasks_frozen)
{
<snip>
        if (num_online_cpus() == 1)        // if we're trying to
offline cpu0, num_online_cpus will be 1
                return -EBUSY;                    // after return back
to cpu_down, we didn't change cpu 0 back to active

        if (!cpu_online(cpu))
                return -EINVAL;

        if (!alloc_cpumask_var(&old_allowed, GFP_KERNEL))
                return -ENOMEM;
<snip>
}

Then cpu 0 is not active, but online, then we try to offline cpu1, .......
This can not be exposed because x86 does not have
/sys/devices/system/cpu0/online.
I guess following patch fixes this bug.

---
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 291ac58..21ddace 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -199,14 +199,18 @@ static int __ref _cpu_down(unsigned int cpu, int
tasks_frozen)
                .hcpu = hcpu,
        };

-       if (num_online_cpus() == 1)
+       if (num_online_cpus() == 1) {
+               set_cpu_active(cpu, true);
                return -EBUSY;
+       }

        if (!cpu_online(cpu))
                return -EINVAL;

-       if (!alloc_cpumask_var(&old_allowed, GFP_KERNEL))
+       if (!alloc_cpumask_var(&old_allowed, GFP_KERNEL)) {
+               set_cpu_active(cpu, true);
                return -ENOMEM;
+       }

        cpu_hotplug_begin();
        err = __raw_notifier_call_chain(&cpu_chain, CPU_DOWN_PREPARE | mod,


> Unless of course, I messed up, which appears to be rather likely given
> these problems ;-)
>
>
