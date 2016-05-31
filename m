Return-Path: <oohall@gmail.com>
Received: from mail-qg0-x243.google.com (mail-qg0-x243.google.com
 [IPv6:2607:f8b0:400d:c04::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rJkz51Cy1zDqbD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 May 2016 17:05:37 +1000 (AEST)
Received: by mail-qg0-x243.google.com with SMTP id l75so10285481qgd.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 May 2016 00:05:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1464675936.30958.22.camel@neuling.org>
References: <1462856240-20648-1-git-send-email-oohall@gmail.com>
 <1464675936.30958.22.camel@neuling.org>
Date: Tue, 31 May 2016 17:05:34 +1000
Message-ID: <CAOSf1CHc30sp_DTrKepCS7WvA6DpFxqRSya6XgShQeBc218XUg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] powerpc/timer - large decrementer support
From: oliver <oohall@gmail.com>
To: Michael Neuling <mikey@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org, Jack Miller <jack@codezen.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 31, 2016 at 4:25 PM, Michael Neuling <mikey@neuling.org> wrote:
> On Tue, 2016-05-10 at 14:57 +1000, Oliver O'Halloran wrote:
>>  static int decrementer_set_next_event(unsigned long evt,
>>                                     struct clock_event_device *dev);
>> @@ -503,7 +504,7 @@ static void __timer_interrupt(void)
>>               __this_cpu_inc(irq_stat.timer_irqs_event);
>>       } else {
>>               now = *next_tb - now;
>> -             if (now <= DECREMENTER_MAX)
>> +             if (now <= decrementer_max)
>>                       set_dec((int)now);
>
> You can remove the int cast here now since set_dec() takes a u64.

I thought I had fixed this, but it looks like I squashed the change to
into the second patch by accident, whoops.

>> +/* enables the large decrementer for the current CPU */
>> +static void enable_large_decrementer(void)
>> +{
>> +     /* do we have a large decrementer? */
>> +     if (!cpu_has_large_dec())
>> +             return;
>> +
>> +     /* do we need a large decrementer? */
>> +     if (decrementer_max <= DECREMENTER_DEFAULT_MAX)
>> +             return;
>> +
>> +     mtspr(SPRN_LPCR, mfspr(SPRN_LPCR) | LPCR_LD);
>> +
>> +     if (!large_dec_enabled()) {
>> +             decrementer_max = DECREMENTER_DEFAULT_MAX;
>> +
>> +             pr_warn("time_init: Failed to enable large decrementer on CPU %d\n",
>> +                     smp_processor_id());
>
> Can you make this pr_warn_once() since every CPU is going to call this?

Sure.
