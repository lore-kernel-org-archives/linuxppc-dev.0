Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sG0Sw2w2szDqd7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 21:03:44 +1000 (AEST)
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
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <8dfe92cf-fff2-44a9-26a7-25ae37bfc254@c-s.fr>
Date: Fri, 19 Aug 2016 13:03:38 +0200
MIME-Version: 1.0
In-Reply-To: <3e83483a-ea1f-978d-5772-d2135a58cbb7@keymile.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 17/08/2016 à 17:27, Holger Brunck a écrit :
> On 16/08/16 19:27, christophe leroy wrote:
>>
>>
>> Le 15/08/2016 à 18:19, Dave Hansen a écrit :
>>> On 08/15/2016 07:35 AM, Holger Brunck wrote:
>>>> I tried this but unfortunately the error only occurs while remote debugging.
>>>> Locally with gdb everything works fine. BTW we double-checked with a 85xx ppc
>>>> target which is also 32-bit and it ends up with the same behaviour.
>>>>
>>>> I was also investigating where I have to move the line in the struct task_struct
>>>> and it turns out to be like this (diff to 4.7 kernel):
>>>>
>>>> diff --git a/include/linux/sched.h b/include/linux/sched.h
>>>> index 253538f..4868874 100644
>>>> --- a/include/linux/sched.h
>>>> +++ b/include/linux/sched.h
>>>> @@ -1655,7 +1655,9 @@ struct task_struct {
>>>>         struct signal_struct *signal;
>>>>         struct sighand_struct *sighand;
>>>>
>>>> +       // struct thread_struct thread;   // until here everything is fine
>>>>         sigset_t blocked, real_blocked;
>>>> +       struct thread_struct thread;      // from here it's broken
>>>>         sigset_t saved_sigmask; /* restored if set_restore_sigmask() was used */
>>>>         struct sigpending pending;
>>>
>>> Wow, thanks for all the debugging here!
>>>
>>> So, we know it has to do with signals, thread_info, and probably only
>>> affects 32-bit powerpc.  Seems awfully weird.  Have you checked with any
>>> of the 64-bit powerpc guys to see if they have any ideas?
>>>
>>> I went grepping around for a bit.
>>>
>>> Where is the task_struct stored?  Is it on-stack on ppc32 or something?
>>>  The thread_info is, I assume, but I see some THREAD_INFO vs. THREAD
>>> (thread struct) math happening in here, which confuses me:
>>>
>>>         .globl  ret_from_debug_exc
>>> ret_from_debug_exc:
>>>         mfspr   r9,SPRN_SPRG_THREAD
>>>         lwz     r10,SAVED_KSP_LIMIT(r1)
>>>         stw     r10,KSP_LIMIT(r9)
>>>         lwz     r9,THREAD_INFO-THREAD(r9)
>>>         CURRENT_THREAD_INFO(r10, r1)
>>>         lwz     r10,TI_PREEMPT(r10)
>>>         stw     r10,TI_PREEMPT(r9)
>>>         RESTORE_xSRR(SRR0,SRR1);
>>>         RESTORE_xSRR(CSRR0,CSRR1);
>>>         RESTORE_MMU_REGS;
>>>         RET_FROM_EXC_LEVEL(SPRN_DSRR0, SPRN_DSRR1, PPC_RFDI)
>>>
>>> But, I'm really at a loss to explain this.  It still seems like a deeply
>>> ppc-specific issue.  We can obviously work around it with an #ifdef for
>>> your platform, but that's awfully hackish and hides the real bug,
>>> whatever it is.
>>>
>>> My suspicion is that there's a bug in the 32-bit ppc assembly somewhere.
>>>  I don't see any references to 'blocked' or 'real_blocked' in assembly
>>> though.  You could add a bunch of padding instead of moving the
>>> thread_struct and see if that does anything, but that's really a stab in
>>> the dark.
>>>
>>
>> Just to let you know, I'm not sure it is the same issue, but I also get
>> my 8xx target stuck when I try to use gdbserver.
>>
>> If I debug a very small app, it gets stuck quickly after the app has
>> stopped: indeed, the console seems ok but as soon as I try to execute
>> something simple, like a ps or top, it get stuck. The target still
>> responds to pings, but nothing else.
>>
>> If I debug a big app, it gets stuck soon after the start of debug: I set
>> a bpoint at main(), do a 'continue', get breaked at main(), do some
>> steps with 'next' then it gets stuck.
>>
>> I have tried moving the struct thread_struct thread but it has no impact.
>>
>
> that sounds a bit different to what I see. Is your program also mutli-threaded?
>
> Maybe you could try with the program I use to reproduce the error:
>
> --- snip -----
> #include <pthread.h>
> #include <stdio.h>
> #include <unistd.h>
>
> void * th_1_func()
> {
>    while (1) {
>      sleep(2);
>      printf("Hello from thread function 1)\n");
>    }
> }
>
> int main() {
>   int err;
>   pthread_t th_1, th_2, th_3;
>
>   err = pthread_create(&th_1, NULL, th_1_func, NULL);
>   if (err != 0)
>     printf("pthread_create\n");
>   err = pthread_create(&th_2, NULL, th_1_func, NULL);
>   if (err != 0)
>     printf("pthread_create\n");
>   err = pthread_create(&th_3, NULL, th_1_func, NULL);
>   if (err != 0)
>     printf("pthread_create\n");
>   while(1) {}
>   return 0;
> }
> --- snap ---
>
> Then copy it to your target and start it with the gdbserver. If you let it run
> from your host with gdb and try to stop it e.g in the sleep call and then try to
> single step it you might see the error. But as I said in this thread the
> behaviour might be different depending on your kernel configuration as I
> encountered different behaviour when enabling FTRACE or SCHED_STAT.
>
> Best regards
> Holger
>

Hi

I just tried it on an 885 and on an 8323, it work properly on both targets.

You can see below the Debug Option that are active on my 8323 target.

Christophe

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
# CONFIG_DYNAMIC_DEBUG is not set

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_GDB_SCRIPTS is not set
CONFIG_ENABLE_WARN_DEPRECATED=y
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=1024
# CONFIG_STRIP_ASM_SYMS is not set
# CONFIG_READABLE_ASM is not set
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_PAGE_OWNER is not set
CONFIG_DEBUG_FS=y
# CONFIG_HEADERS_CHECK is not set
# CONFIG_DEBUG_SECTION_MISMATCH is not set
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_DEBUG_KERNEL=y

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_MEMORY_INIT is not set
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Lockups and Hangs
#
# CONFIG_LOCKUP_DETECTOR is not set
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=120
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=0
# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=0
CONFIG_SCHED_DEBUG=y
# CONFIG_SCHED_INFO is not set
# CONFIG_SCHEDSTATS is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
# CONFIG_DEBUG_TIMEKEEPING is not set
# CONFIG_TIMER_STATS is not set
CONFIG_DEBUG_PREEMPT=y

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_ATOMIC_SLEEP is not set
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
# CONFIG_STACKTRACE is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
# CONFIG_DEBUG_LIST is not set
# CONFIG_DEBUG_PI_LIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
# CONFIG_PROVE_RCU is not set
# CONFIG_SPARSE_RCU_POINTER is not set
# CONFIG_TORTURE_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=21
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
# CONFIG_FAULT_INJECTION is not set
# CONFIG_LATENCYTOP is not set
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
# CONFIG_FUNCTION_TRACER is not set
# CONFIG_IRQSOFF_TRACER is not set
# CONFIG_PREEMPT_TRACER is not set
# CONFIG_SCHED_TRACER is not set
# CONFIG_ENABLE_DEFAULT_TRACERS is not set
# CONFIG_FTRACE_SYSCALLS is not set
# CONFIG_TRACER_SNAPSHOT is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_PROFILE_ALL_BRANCHES is not set
# CONFIG_STACK_TRACER is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
# CONFIG_UPROBE_EVENT is not set
# CONFIG_PROBE_EVENTS is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
# CONFIG_RING_BUFFER_BENCHMARK is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
CONFIG_TRACING_EVENTS_GPIO=y

#
# Runtime Testing
#
# CONFIG_LKDTM is not set
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_PRINTF is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_UDELAY is not set
# CONFIG_MEMTEST is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
# CONFIG_PPC_DISABLE_WERROR is not set
CONFIG_PPC_WERROR=y
# CONFIG_STRICT_MM_TYPECHECKS is not set
CONFIG_PRINT_STACK_DEPTH=64
# CONFIG_PPC_EMULATED_STATS is not set
# CONFIG_CODE_PATCHING_SELFTEST is not set
# CONFIG_FTR_FIXUP_SELFTEST is not set
# CONFIG_MSI_BITMAP_SELFTEST is not set
# CONFIG_XMON is not set
CONFIG_BDI_SWITCH=y
# CONFIG_BOOTX_TEXT is not set
# CONFIG_PPC_EARLY_DEBUG is not set
CONFIG_STRICT_DEVMEM=y
