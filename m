Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sG42H03TkzDqCb
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 23:44:22 +1000 (AEST)
Subject: Re: debug problems on ppc 83xx target due to changed struct
 task_struct
To: Holger Brunck <holger.brunck@keymile.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <dc38afe9-6b78-f3f5-666b-986939e40fc6@keymile.com>
 <57ADE7E6.9030900@linux.intel.com>
 <4e16aad4-80d3-ffcc-d183-681b48d4751b@keymile.com>
 <57ADF4A0.5040807@linux.intel.com>
 <41e00d07-d7ce-0198-acce-ac25db8c9df3@keymile.com>
 <57B1EBAE.6030503@linux.intel.com>
 <3f1dff88-cd24-b36e-da9a-e84627929975@c-s.fr>
 <3e83483a-ea1f-978d-5772-d2135a58cbb7@keymile.com>
 <8dfe92cf-fff2-44a9-26a7-25ae37bfc254@c-s.fr>
 <1624e6b7-f797-da23-7c34-e0f903526c9c@keymile.com>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <64742682-140b-6daa-6d38-6107f2d7ecf3@c-s.fr>
Date: Fri, 19 Aug 2016 15:44:18 +0200
MIME-Version: 1.0
In-Reply-To: <1624e6b7-f797-da23-7c34-e0f903526c9c@keymile.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 19/08/2016 à 13:14, Holger Brunck a écrit :
> On 19/08/16 13:03, Christophe Leroy wrote:
>>
>>
>> Le 17/08/2016 à 17:27, Holger Brunck a écrit :
>>> On 16/08/16 19:27, christophe leroy wrote:
>>>>
>>>>
>>>> Le 15/08/2016 à 18:19, Dave Hansen a écrit :
>>>>> On 08/15/2016 07:35 AM, Holger Brunck wrote:
>>>>>> I tried this but unfortunately the error only occurs while remote debugging.
>>>>>> Locally with gdb everything works fine. BTW we double-checked with a 85xx ppc
>>>>>> target which is also 32-bit and it ends up with the same behaviour.
>>>>>>
>>>>>> I was also investigating where I have to move the line in the struct task_struct
>>>>>> and it turns out to be like this (diff to 4.7 kernel):
>>>>>>
>>>>>> diff --git a/include/linux/sched.h b/include/linux/sched.h
>>>>>> index 253538f..4868874 100644
>>>>>> --- a/include/linux/sched.h
>>>>>> +++ b/include/linux/sched.h
>>>>>> @@ -1655,7 +1655,9 @@ struct task_struct {
>>>>>>         struct signal_struct *signal;
>>>>>>         struct sighand_struct *sighand;
>>>>>>
>>>>>> +       // struct thread_struct thread;   // until here everything is fine
>>>>>>         sigset_t blocked, real_blocked;
>>>>>> +       struct thread_struct thread;      // from here it's broken
>>>>>>         sigset_t saved_sigmask; /* restored if set_restore_sigmask() was used */
>>>>>>         struct sigpending pending;
>>>>>
>>>>> Wow, thanks for all the debugging here!
>>>>>
>>>>> So, we know it has to do with signals, thread_info, and probably only
>>>>> affects 32-bit powerpc.  Seems awfully weird.  Have you checked with any
>>>>> of the 64-bit powerpc guys to see if they have any ideas?
>>>>>
>>>>> I went grepping around for a bit.
>>>>>
>>>>> Where is the task_struct stored?  Is it on-stack on ppc32 or something?
>>>>>  The thread_info is, I assume, but I see some THREAD_INFO vs. THREAD
>>>>> (thread struct) math happening in here, which confuses me:
>>>>>
>>>>>         .globl  ret_from_debug_exc
>>>>> ret_from_debug_exc:
>>>>>         mfspr   r9,SPRN_SPRG_THREAD
>>>>>         lwz     r10,SAVED_KSP_LIMIT(r1)
>>>>>         stw     r10,KSP_LIMIT(r9)
>>>>>         lwz     r9,THREAD_INFO-THREAD(r9)
>>>>>         CURRENT_THREAD_INFO(r10, r1)
>>>>>         lwz     r10,TI_PREEMPT(r10)
>>>>>         stw     r10,TI_PREEMPT(r9)
>>>>>         RESTORE_xSRR(SRR0,SRR1);
>>>>>         RESTORE_xSRR(CSRR0,CSRR1);
>>>>>         RESTORE_MMU_REGS;
>>>>>         RET_FROM_EXC_LEVEL(SPRN_DSRR0, SPRN_DSRR1, PPC_RFDI)
>>>>>
>>>>> But, I'm really at a loss to explain this.  It still seems like a deeply
>>>>> ppc-specific issue.  We can obviously work around it with an #ifdef for
>>>>> your platform, but that's awfully hackish and hides the real bug,
>>>>> whatever it is.
>>>>>
>>>>> My suspicion is that there's a bug in the 32-bit ppc assembly somewhere.
>>>>>  I don't see any references to 'blocked' or 'real_blocked' in assembly
>>>>> though.  You could add a bunch of padding instead of moving the
>>>>> thread_struct and see if that does anything, but that's really a stab in
>>>>> the dark.
>>>>>
>>>>
>>>> Just to let you know, I'm not sure it is the same issue, but I also get
>>>> my 8xx target stuck when I try to use gdbserver.
>>>>
>>>> If I debug a very small app, it gets stuck quickly after the app has
>>>> stopped: indeed, the console seems ok but as soon as I try to execute
>>>> something simple, like a ps or top, it get stuck. The target still
>>>> responds to pings, but nothing else.
>>>>
>>>> If I debug a big app, it gets stuck soon after the start of debug: I set
>>>> a bpoint at main(), do a 'continue', get breaked at main(), do some
>>>> steps with 'next' then it gets stuck.
>>>>
>>>> I have tried moving the struct thread_struct thread but it has no impact.
>>>>
>>>
>>> that sounds a bit different to what I see. Is your program also mutli-threaded?
>>>
>>> Maybe you could try with the program I use to reproduce the error:
>>>
>>> --- snip -----
>>> #include <pthread.h>
>>> #include <stdio.h>
>>> #include <unistd.h>
>>>
>>> void * th_1_func()
>>> {
>>>    while (1) {
>>>      sleep(2);
>>>      printf("Hello from thread function 1)\n");
>>>    }
>>> }
>>>
>>> int main() {
>>>   int err;
>>>   pthread_t th_1, th_2, th_3;
>>>
>>>   err = pthread_create(&th_1, NULL, th_1_func, NULL);
>>>   if (err != 0)
>>>     printf("pthread_create\n");
>>>   err = pthread_create(&th_2, NULL, th_1_func, NULL);
>>>   if (err != 0)
>>>     printf("pthread_create\n");
>>>   err = pthread_create(&th_3, NULL, th_1_func, NULL);
>>>   if (err != 0)
>>>     printf("pthread_create\n");
>>>   while(1) {}
>>>   return 0;
>>> }
>>> --- snap ---
>>>
>>> Then copy it to your target and start it with the gdbserver. If you let it run
>>> from your host with gdb and try to stop it e.g in the sleep call and then try to
>>> single step it you might see the error. But as I said in this thread the
>>> behaviour might be different depending on your kernel configuration as I
>>> encountered different behaviour when enabling FTRACE or SCHED_STAT.
>>>
>>> Best regards
>>> Holger
>>>
>>
>> Hi
>>
>> I just tried it on an 885 and on an 8323, it work properly on both targets.
>>
>> You can see below the Debug Option that are active on my 8323 target.
>>
>
>
> thanks for trying it.
>
> Could you completely disable FTRACE? As it also works on my side when I have
> FTRACE enabled.
>
> Best regards
> Holger
>

I have now disabled completly FTRACE, the behaviour is still OK.

Christophe
