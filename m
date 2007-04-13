Return-Path: <sshtylyov@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 39DE2DDF4B
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Apr 2007 06:27:30 +1000 (EST)
Message-ID: <461FE7E8.9030500@ru.mvista.com>
Date: Sat, 14 Apr 2007 00:28:24 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] add reg and stack dump to booke WD handler
References: <20070413173524.GA17890@blade.az.mvista.com>
	<461FCB6F.7010504@ru.mvista.com>
	<20070413200659.GA21588@blade.az.mvista.com>
	<B8CF9F53-9F51-4DD5-9CB6-16C69502A1CA@kernel.crashing.org>
In-Reply-To: <B8CF9F53-9F51-4DD5-9CB6-16C69502A1CA@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Kumar Gala wrote:

>> Have the booke watchdog dump some useful information when  triggered. 
>> Hopefully
>> that'll give the user some hint of what happened rather than just a  
>> mysterious
>> reboot.
 
>>  Ok here's try 2. Modified the watchdog driver instead per Sergei's  
>> suggestion.
 
> I'm against having a WatchdogHandler in booke_wdt.c.  The idea behind  
> the weak symbol in traps.c is to allow platform code to override the  
> behavior.

   Hmm, to do what?

>  I'm ok if we put the spew in the generic case.

   Well, I was mostly against putting there while(1) cpu_relax();

> Also, how are you testing this?

   By enabling the watchdog and not then pinging it, I guess...

>>  drivers/char/watchdog/booke_wdt.c |   37 ++++++++++++++++++++++++++ 
>> +++++++++++
>>  1 files changed, 37 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/char/watchdog/booke_wdt.c b/drivers/char/ 
>> watchdog/booke_wdt.c
>> index 0e23f29..90e5301 100644
>> --- a/drivers/char/watchdog/booke_wdt.c
>> +++ b/drivers/char/watchdog/booke_wdt.c
>> @@ -23,6 +23,7 @@
>>  #include <asm/reg_booke.h>
>>  #include <asm/uaccess.h>
>>  #include <asm/system.h>
>> +#include <asm/machdep.h>
>>
>>  /* If the kernel parameter wdt_enable=1, the watchdog will be  
>> enabled at boot.
>>   * Also, the wdt_period sets the watchdog timer period timeout.
>> @@ -47,6 +48,42 @@ u32 booke_wdt_period = WDT_PERIOD_DEFAULT;
>>  #define WDTP(x)        (TCR_WP(x))
>>  #endif
>>
>> +void WatchdogHandler(struct pt_regs *regs)
>> +{
>> +    unsigned long flags;
>> +
>> +    mtspr(SPRN_TCR, mfspr(SPRN_TCR) & ~TCR_WIE);
>> +    oops_enter();
>> +
>> +    console_verbose();
>> +    bust_spinlocks(1);
>> +    local_save_flags(flags);
>> +
>> +#ifdef CONFIG_PREEMPT
>> +    printk("PREEMPT ");
>> +#endif
>> +#ifdef CONFIG_SMP
>> +    printk("SMP NR_CPUS=%d ", NR_CPUS);
>> +#endif
>> +#ifdef CONFIG_DEBUG_PAGEALLOC
>> +    printk("DEBUG_PAGEALLOC ");
>> +#endif
>> +#ifdef CONFIG_NUMA
>> +    printk("NUMA ");
>> +#endif
>> +    printk("%s\n", ppc_md.name ? ppc_md.name : "");
>> +
>> +    print_modules();
>> +    show_regs(regs);
>> +
>> +    bust_spinlocks(0);
>> +
>> +    printk(KERN_EMERG "Waiting for hardware watchdog reset...\n");
>> +    /* spin until hardware reset */
>> +    while(1)
>> +        cpu_relax();
>> +}
>> +
>>  /*
>>   * booke_wdt_ping:
>>   */

WBR, Sergei
