Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 898C21400A0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 May 2014 19:11:59 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Sun, 11 May 2014 05:11:56 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id ED30D6E8041
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 May 2014 05:11:46 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp22034.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4B9BsYb196982
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 May 2014 09:11:54 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4B9Brej016636
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 May 2014 05:11:54 -0400
Message-ID: <536F3DD5.8070503@linux.vnet.ibm.com>
Date: Sun, 11 May 2014 14:37:33 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: irq work racing with timer interrupt can result
 in timer interrupt hang
References: <20140509174712.55fe72d0@kryten>
 <536CA561.8010803@linux.vnet.ibm.com> <1399695993.4481.47.camel@pasglop>
 <536E477F.2070009@linux.vnet.ibm.com> <1399760754.17624.21.camel@pasglop>
 <536F3192.2050004@linux.vnet.ibm.com> <1399797477.17624.40.camel@pasglop>
 <536F384C.3070409@linux.vnet.ibm.com> <1399799008.17624.43.camel@pasglop>
In-Reply-To: <1399799008.17624.43.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
Cc: paulmck@linux.vnet.ibm.com, paulus@samba.org,
 Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/11/2014 02:33 PM, Benjamin Herrenschmidt wrote:
> On Sun, 2014-05-11 at 14:13 +0530, Preeti U Murthy wrote:
>>
>> Isn't this patch required too?
>>
>> @@ -503,12 +503,13 @@ void __timer_interrupt(void)
>>                 now = *next_tb - now;
>>                 if (now <= DECREMENTER_MAX)
>>                         set_dec((int)now);
>> -               /* We may have raced with new irq work */
>> -               if (test_irq_work_pending())
>> -                       set_dec(1);
>>                 __get_cpu_var(irq_stat).timer_irqs_others++;
>>         }
>>
>> +       /* We may have raced with new irq work */
>> +       if (test_irq_work_pending())
>> +               set_dec(1);
>> +
>>
>> The event_handler cannot be relied upon to call
>> decrementer_set_next_event() all the time. This is in the case where
>> there are no pending timers. In that case we need to have the check on
>> irq work pending at the end of __timer_interrupt() no?
> 
> I don't think we need to move the test no. If there's a pending
> irq_work, at that point, it will have done set_dec when being queued up.
> So we only care about cases where we might change the decrementer.
> 
> If the event handler doesn't call decrementer_set_next_event() then
> nothing will modify the decrementer and it will still trigger soon.

Hmm ok. Then Anton's patch covers all cases :)

Thanks!

Reviewed-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>

Regards
Preeti U Murthy
> 
> Cheers,
> Ben.
> 
> 
