Return-Path: <lvivier@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 61E211A2F51
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2015 00:54:56 +1100 (AEDT)
Subject: Re: [PATCH] powerpc: on crash, kexec'ed kernel needs all CPUs are
 online
To: Hari Bathini <hbathini@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
References: <1444935658-27319-1-git-send-email-lvivier@redhat.com>
 <5639FB4A.7020508@linux.vnet.ibm.com>
Cc: dgibson@redhat.com, thuth@redhat.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <563A0E2B.4090404@redhat.com>
Date: Wed, 4 Nov 2015 14:54:51 +0100
MIME-Version: 1.0
In-Reply-To: <5639FB4A.7020508@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 04/11/2015 13:34, Hari Bathini wrote:
> On 10/16/2015 12:30 AM, Laurent Vivier wrote:
>> On kexec, all secondary offline CPUs are onlined before
>> starting the new kernel, this is not done in the case of kdump.
>>
>> If kdump is configured and a kernel crash occurs whereas
>> some secondaries CPUs are offline (SMT=off),
>> the new kernel is not able to start them and displays some
>> "Processor X is stuck.".
>>
>> Starting with POWER8, subcore logic relies on all threads of
>> core being booted. So, on startup kernel tries to start all
>> threads, and asks OPAL (or RTAS) to start all CPUs (including
>> threads). If a CPU has been offlined by the previous kernel,
>> it has not been returned to OPAL, and thus OPAL cannot restart
>> it: this CPU has been lost...
>>
>> Signed-off-by: Laurent Vivier<lvivier@redhat.com>
> 
> 
> Hi Laurent,

Hi Hari,

> Sorry for jumping too late into this.

better late than never :)

> Are you seeing this issue even with the below patches:
> 
> pseries:
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=c1caae3de46a072d0855729aed6e793e536a4a55
> 
> 
> opal/powernv:
> https://github.com/open-power/skiboot/commit/9ee56b5

Very interesting. Is there a way to have a firmware with the fix ?

Thanks,
Laurent

> Thanks
> Hari
> 
>> ---
>>   arch/powerpc/kernel/crash.c | 20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>>
>> diff --git a/arch/powerpc/kernel/crash.c b/arch/powerpc/kernel/crash.c
>> index 51dbace..3ca9452 100644
>> --- a/arch/powerpc/kernel/crash.c
>> +++ b/arch/powerpc/kernel/crash.c
>> @@ -19,6 +19,7 @@
>>   #include <linux/delay.h>
>>   #include <linux/irq.h>
>>   #include <linux/types.h>
>> +#include <linux/cpu.h>
>>     #include <asm/processor.h>
>>   #include <asm/machdep.h>
>> @@ -299,11 +300,30 @@ int crash_shutdown_unregister(crash_shutdown_t
>> handler)
>>   }
>>   EXPORT_SYMBOL(crash_shutdown_unregister);
>>   +/*
>> + * The next kernel will try to start all secondary CPUs and if
>> + * there are not online it will fail to start them.
>> + *
>> + */
>> +static void wake_offline_cpus(void)
>> +{
>> +    int cpu = 0;
>> +
>> +    for_each_present_cpu(cpu) {
>> +        if (!cpu_online(cpu)) {
>> +            pr_info("kexec: Waking offline cpu %d.\n", cpu);
>> +            cpu_up(cpu);
>> +        }
>> +    }
>> +}
>> +
>>   void default_machine_crash_shutdown(struct pt_regs *regs)
>>   {
>>       unsigned int i;
>>       int (*old_handler)(struct pt_regs *regs);
>>   +    wake_offline_cpus();
>> +
>>       /*
>>        * This function is only called after the system
>>        * has panicked or is otherwise in a critical state.
> 
