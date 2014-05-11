Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7E27B14009C
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 May 2014 18:49:16 +1000 (EST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Sun, 11 May 2014 02:49:14 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id B73E63E4003B
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 May 2014 02:49:10 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp07028.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4B8lvI660621030
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 May 2014 10:48:06 +0200
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4B8mbDR005991
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 May 2014 02:48:38 -0600
Message-ID: <536F384C.3070409@linux.vnet.ibm.com>
Date: Sun, 11 May 2014 14:13:56 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: irq work racing with timer interrupt can result
 in timer interrupt hang
References: <20140509174712.55fe72d0@kryten>
 <536CA561.8010803@linux.vnet.ibm.com> <1399695993.4481.47.camel@pasglop>
 <536E477F.2070009@linux.vnet.ibm.com> <1399760754.17624.21.camel@pasglop>
 <536F3192.2050004@linux.vnet.ibm.com> <1399797477.17624.40.camel@pasglop>
In-Reply-To: <1399797477.17624.40.camel@pasglop>
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

On 05/11/2014 02:07 PM, Benjamin Herrenschmidt wrote:
> On Sun, 2014-05-11 at 13:45 +0530, Preeti U Murthy wrote:
>>  +       /* Don't adjust the decrementer if some irq work is pending
>> */
>>  +       if (!test_irq_work_pending())
>>  +               set_dec(evt);
>>  +       else
>>  +               set_dec(1);
>>
>>                   ^^^^^ your patch currently does not have this
>> explicit
>> set_dec(1) here. Will that create a problem? 
>>
>> If there is any irq work pending at this point, will someone set the
>> decrementer to fire immediately after this point? The current code in
>> decrementer_set_next_event() sets set_dec(1) explicitly in case of
>> pending irq work.
> 
> Hrm, actually this is an interesting point. The problem isn't that
> *someone* will do a set_dec, nobody else should that matters.
> 
> The problem is that irq_work can be triggered typically by NMIs or
> similar, which means that it might be queued between the
> test_irq_work_pending() and the set_dec(), thus causing a race.
> 
> So basically Anton's original patch is fine :-) I had missed that
> we did a post-set_dec() test already in decrementer_next_event()
> so as far as I can tell, removing the pre-test, which is what Anton
> does, is really all we need.

Isn't this patch required too?

@@ -503,12 +503,13 @@ void __timer_interrupt(void)
                now = *next_tb - now;
                if (now <= DECREMENTER_MAX)
                        set_dec((int)now);
-               /* We may have raced with new irq work */
-               if (test_irq_work_pending())
-                       set_dec(1);
                __get_cpu_var(irq_stat).timer_irqs_others++;
        }

+       /* We may have raced with new irq work */
+       if (test_irq_work_pending())
+               set_dec(1);
+

The event_handler cannot be relied upon to call
decrementer_set_next_event() all the time. This is in the case where
there are no pending timers. In that case we need to have the check on
irq work pending at the end of __timer_interrupt() no?

Regards
Preeti U Murthy
> 
> Cheers,
> Ben.
> 
> 
