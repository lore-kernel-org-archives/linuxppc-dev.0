Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp04.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id ACEDD2C0095
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Feb 2013 03:45:40 +1100 (EST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Mon, 18 Feb 2013 22:13:11 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id F0A63E0050
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 22:16:29 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r1IGjV5K31719628
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 22:15:31 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r1IGjVQU021933
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 16:45:33 GMT
Message-ID: <51225A36.40600@linux.vnet.ibm.com>
Date: Mon, 18 Feb 2013 22:13:34 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michel Lespinasse <walken@google.com>
Subject: Re: [PATCH v6 08/46] CPU hotplug: Provide APIs to prevent CPU offline
 from atomic context
References: <20130218123714.26245.61816.stgit@srivatsabhat.in.ibm.com>
 <20130218123920.26245.56709.stgit@srivatsabhat.in.ibm.com>
 <CANN689HhVxDv+3Bn9UAxOMzj0egTvVp_c7oAmQ2nnQ8Xjn_aMA@mail.gmail.com>
In-Reply-To: <CANN689HhVxDv+3Bn9UAxOMzj0egTvVp_c7oAmQ2nnQ8Xjn_aMA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-doc@vger.kernel.org, peterz@infradead.org, fweisbec@gmail.com,
 linux-kernel@vger.kernel.org, mingo@kernel.org, linux-arch@vger.kernel.org,
 linux@arm.linux.org.uk, xiaoguangrong@linux.vnet.ibm.com,
 wangyun@linux.vnet.ibm.com, paulmck@linux.vnet.ibm.com,
 nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, rusty@rustcorp.com.au,
 rostedt@goodmis.org, rjw@sisk.pl, namhyung@kernel.org, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, oleg@redhat.com,
 vincent.guittot@linaro.org, sbw@mit.edu, tj@kernel.org,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/18/2013 09:53 PM, Michel Lespinasse wrote:
> On Mon, Feb 18, 2013 at 8:39 PM, Srivatsa S. Bhat
> <srivatsa.bhat@linux.vnet.ibm.com> wrote:
>> Some important design requirements and considerations:
>> -----------------------------------------------------
[...]
>> +/*
>> + * Invoked by atomic hotplug reader (a task which wants to prevent
>> + * CPU offline, but which can't afford to sleep), to prevent CPUs from
>> + * going offline. So, you can call this function from atomic contexts
>> + * (including interrupt handlers).
>> + *
>> + * Note: This does NOT prevent CPUs from coming online! It only prevents
>> + * CPUs from going offline.
>> + *
>> + * You can call this function recursively.
>> + *
>> + * Returns with preemption disabled (but interrupts remain as they are;
>> + * they are not disabled).
>> + */
>> +void get_online_cpus_atomic(void)
>> +{
>> +       percpu_read_lock_irqsafe(&hotplug_pcpu_rwlock);
>> +}
>> +EXPORT_SYMBOL_GPL(get_online_cpus_atomic);
>> +
>> +void put_online_cpus_atomic(void)
>> +{
>> +       percpu_read_unlock_irqsafe(&hotplug_pcpu_rwlock);
>> +}
>> +EXPORT_SYMBOL_GPL(put_online_cpus_atomic);
> 
> So, you made it clear why you want a recursive read side here.
> 
> I am wondering though, if you could take care of recursive uses in
> get/put_online_cpus_atomic() instead of doing it as a property of your
> rwlock:
> 
> get_online_cpus_atomic()
> {
>     unsigned long flags;
>     local_irq_save(flags);
>     if (this_cpu_inc_return(hotplug_recusion_count) == 1)
>         percpu_read_lock_irqsafe(&hotplug_pcpu_rwlock);
>     local_irq_restore(flags);
> }
> 
> Once again, the idea there is to avoid baking the reader side
> recursive properties into your rwlock itself, so that it won't be
> impossible to implement reader/writer fairness into your rwlock in the
> future (which may be not be very important for the hotplug use, but
> could be when other uses get introduced).
> 

Hmm, your proposal above looks good to me, at first glance.
(Sorry, I had mistaken your earlier mails to mean that you were against
recursive reader-side, while you actually meant that you didn't like
implementing the recursive reader-side logic using the recursive property
of rwlocks).

While your idea above looks good, it might introduce more complexity
in the unlock path, since this would allow nesting of heterogeneous readers
(ie., if hotplug_recursion_count == 1, you don't know whether you need to
simply decrement the counter or unlock the rwlock as well).

But I'll give this some more thought to see if we can implement this
without making it too complex. Thank you!

Regards,
Srivatsa S. Bhat
