Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 4F9DADDFC8
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Mar 2007 01:55:36 +1100 (EST)
Message-ID: <45EED260.80109@ru.mvista.com>
Date: Wed, 07 Mar 2007 17:55:28 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: v2.6.19-rt6, yum/rpm
References: <20061205171114.GA25926@elte.hu> <4582CAD6.9040404@ru.mvista.com>
	<20061215161952.GA29191@elte.hu> <45C20CC6.2070201@ru.mvista.com>
	<20070201173855.GA29309@elte.hu> <20070201174900.GA31866@elte.hu>
	<45C22AFF.6060102@ru.mvista.com>
In-Reply-To: <45C22AFF.6060102@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello, I wrote:

>>>>> could you resend them to me please?

>>>>   Seeing that GENERIC_TIME has been thrown out from the -rt patch, 
>>>> [...]

>>> hm, i did that accidentally during a rebase. That was certainly not 
>>> meant to be a persistent condition.

>> ok, the delta below is what i've managed to restore from your PPC 
>> patches so far. Looks like this was truly a comedy of errors: i 
>> accidentally dropped the big ppc-gtod patch,

[...]

>>     Ingo

>> Index: linux/arch/powerpc/platforms/cell/interrupt.c
>> ===================================================================
>> --- linux.orig/arch/powerpc/platforms/cell/interrupt.c
>> +++ linux/arch/powerpc/platforms/cell/interrupt.c
>> @@ -90,6 +90,7 @@ static struct irq_chip iic_chip = {
>>      .typename = " CELL-IIC ",
>>      .mask = iic_mask,
>>      .unmask = iic_unmask,
>> +    .ack = iic_eoi,
>>      .eoi = iic_eoi,
>>  };
>>  
>> Index: linux/arch/powerpc/platforms/iseries/irq.c
>> ===================================================================
>> --- linux.orig/arch/powerpc/platforms/iseries/irq.c
>> +++ linux/arch/powerpc/platforms/iseries/irq.c
>> @@ -279,6 +279,7 @@ static struct irq_chip iseries_pic = {
>>      .shutdown    = iseries_shutdown_IRQ,
>>      .unmask        = iseries_enable_IRQ,
>>      .mask        = iseries_disable_IRQ,
>> +    .ack        = iseries_end_IRQ,
>>      .eoi        = iseries_end_IRQ
>>  };
>>  
>> Index: linux/arch/powerpc/platforms/pseries/xics.c
>> ===================================================================
>> --- linux.orig/arch/powerpc/platforms/pseries/xics.c
>> +++ linux/arch/powerpc/platforms/pseries/xics.c
>> @@ -456,6 +456,7 @@ static struct irq_chip xics_pic_direct =
>>      .startup = xics_startup,
>>      .mask = xics_mask_irq,
>>      .unmask = xics_unmask_irq,
>> +    .ack = xics_eoi_direct,
>>      .eoi = xics_eoi_direct,
>>      .set_affinity = xics_set_affinity
>>  };
>> @@ -466,6 +467,7 @@ static struct irq_chip xics_pic_lpar = {
>>      .startup = xics_startup,
>>      .mask = xics_mask_irq,
>>      .unmask = xics_unmask_irq,
>> +    .ack = xics_eoi_lpar,
>>      .eoi = xics_eoi_lpar,
>>      .set_affinity = xics_set_affinity
>>  };
>> Index: linux/arch/powerpc/sysdev/mpic.c
>> ===================================================================
>> --- linux.orig/arch/powerpc/sysdev/mpic.c
>> +++ linux/arch/powerpc/sysdev/mpic.c
>> @@ -767,6 +767,7 @@ static int mpic_set_irq_type(unsigned in
>>  static struct irq_chip mpic_irq_chip = {
>>      .mask        = mpic_mask_irq,
>>      .unmask        = mpic_unmask_irq,
>> +    .ack        = mpic_end_irq,
>>      .eoi        = mpic_end_irq,
>>      .set_type    = mpic_set_irq_type,
>>  };

>    These changes have been refused in favor of "fasetoi" flow fix.

    Ugh, seeing them 2.6.20-rt8 still -- *please* remove, they're now useless 
and quite ugly...

>> Index: linux/kernel/latency_trace.c
>> ===================================================================
>> --- linux.orig/kernel/latency_trace.c
>> +++ linux/kernel/latency_trace.c
>> @@ -1774,8 +1774,8 @@ check_critical_timing(int cpu, struct cp
>>  #ifndef CONFIG_CRITICAL_LATENCY_HIST
>>      if (!preempt_thresh && preempt_max_latency > delta) {
>>          printk("bug: updating %016Lx > %016Lx?\n",
>> -            preempt_max_latency, delta);
>> -        printk("  [%016Lx %016Lx %016Lx]\n", T0, T1, T2);
>> +            (u64)preempt_max_latency, (u64)delta);
>> +        printk("  [%016Lx %016Lx %016Lx]\n", (u64)T0, (u64)T1, (u64)T2);
>>      }
>>  #endif

>    IIRC, this is a fragment of my another refused patch (maybe the first 
> take on it?)... Should be outdated now.

    Ugh, I'm seeing this one in 2.6.20-rt8 still... *Please* remove it -- it's 
*useless* with the current -rt code.

WBR, Sergei
