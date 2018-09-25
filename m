Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42KKlv3kp8zF27h
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Sep 2018 22:15:39 +1000 (AEST)
Subject: Re: [RFC PATCH v1 1/9] timer: fix circular header dependency
To: Mark Rutland <mark.rutland@arm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 aneesh.kumar@linux.vnet.ibm.com, npiggin@gmail.com,
 Thomas Gleixner <tglx@linutronix.de>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 John Stultz <john.stultz@linaro.org>, Stephen Boyd <sboyd@kernel.org>,
 linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <cover.1537802981.git.christophe.leroy@c-s.fr>
 <72d3e8c38f729dc22cb3235319b72f96190e01ee.1537802981.git.christophe.leroy@c-s.fr>
 <5c9530da-f5c8-e0b2-61ab-294a0da7f3fc@c-s.fr>
 <20180925121104.zrz4m45sbnt5h2ht@lakrids.cambridge.arm.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <d22dc0e6-13ff-2abe-6536-a7b14bb285db@c-s.fr>
Date: Tue, 25 Sep 2018 14:15:34 +0200
MIME-Version: 1.0
In-Reply-To: <20180925121104.zrz4m45sbnt5h2ht@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 25/09/2018 à 14:11, Mark Rutland a écrit :
> On Tue, Sep 25, 2018 at 07:34:15AM +0200, Christophe LEROY wrote:
>>
>>
>> Le 24/09/2018 à 17:52, Christophe Leroy a écrit :
>>> When switching powerpc to CONFIG_THREAD_INFO_IN_TASK, include/sched.h
>>> has to be included in asm/smp.h for the following change, in order
>>> to avoid uncomplete definition of task_struct:
>>>
>>> -#define raw_smp_processor_id() (current_thread_info()->cpu)
>>> +#define raw_smp_processor_id() (current->cpu)
>>>
>>> But this generates the following compilation error, due to circular
>>> header dependency.
>>>
>>>     CC      kernel/time/alarmtimer.o
>>> In file included from ./arch/powerpc/include/asm/smp.h:31,
>>>                    from ./include/linux/smp.h:64,
>>>                    from ./include/linux/percpu.h:7,
>>>                    from ./include/linux/hrtimer.h:22,
>>>                    from kernel/time/alarmtimer.c:19:
>>> ./include/linux/sched.h:558:19: error: field 'dl_timer' has incomplete type
>>>     struct hrtimer   dl_timer;
>>>                      ^~~~~~~~
>>> ./include/linux/sched.h:567:17: error: field 'inactive_timer' has incomplete type
>>>     struct hrtimer inactive_timer;
>>>                    ^~~~~~~~~~~~~~
>>> make[1]: *** [kernel/time/alarmtimer.o] Error 1
>>> make: *** [kernel/time/alarmtimer.o] Error 2
>>>
>>>     CC      fs/timerfd.o
>>> In file included from ./arch/powerpc/include/asm/smp.h:31,
>>>                    from ./include/linux/smp.h:64,
>>>                    from ./include/linux/percpu.h:7,
>>>                    from ./include/linux/hrtimer.h:22,
>>>                    from ./include/linux/alarmtimer.h:6,
>>>                    from fs/timerfd.c:12:
>>> ./include/linux/sched.h:558:19: error: field 'dl_timer' has incomplete type
>>>     struct hrtimer   dl_timer;
>>>                      ^~~~~~~~
>>> ./include/linux/sched.h:567:17: error: field 'inactive_timer' has incomplete type
>>>     struct hrtimer inactive_timer;
>>>                    ^~~~~~~~~~~~~~
>>> make[1]: *** [fs/timerfd.o] Error 1
>>> make: *** [fs/timerfd.o] Error 2
>>>
>>> This patch fixes it by including linux/hrtimer.h after linux/sched.h
>>>
>>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>>> ---
>>>    Should it be fixed in powerpc instead ? In that case, how ? Any idea ?
>>
>>
>> Looks like there are several other places where the problem occurs, so it
>> has to be fixed in the powerpc headers instead.
>>
>> Seems like RISC arch faced the same issue, and fixed it the following way:
>>
>> /*
>>   * This is particularly ugly: it appears we can't actually get the
>> definition
>>   * of task_struct here, but we need access to the CPU this task is running
>> on.
>>   * Instead of using C we're using asm-offsets.h to get the current processor
>>   * ID.
>>   */
>> #define raw_smp_processor_id() (*((int*)((char*)get_current() +
>> TASK_TI_CPU)))
>>
>>
>> Unless someone has a better idea, I'll fixed it that way.
> 
> To solve this on arm64 we made the cpu number a percpu variable; see
> commit:
> 
>    57c82954e77fa12c ("arm64: make cpu number a percpu variable")

Thanks, I'll have a look

> IIUC, you could do that by placing it in paca_struct.

By the way, it is already in PACA struct for PPC64.
The issue is with PPC32, up to now it was in current_thread_info:

#ifdef CONFIG_PPC64
#define raw_smp_processor_id()	(local_paca->paca_index)
#define hard_smp_processor_id() (get_paca()->hw_cpu_id)
#else
/* 32-bit */
extern int smp_hw_index[];

#define raw_smp_processor_id()	(current_thread_info()->cpu)
#define hard_smp_processor_id() 	(smp_hw_index[smp_processor_id()])

[..]

#endif


Christophe
