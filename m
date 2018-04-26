Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40WsgW4FLbzF24d
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Apr 2018 19:47:51 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc: Fix smp_send_stop NMI IPI handling
In-Reply-To: <20180425135104.3e9e3812@roar.ozlabs.ibm.com>
References: <20180425021753.26275-1-npiggin@gmail.com>
 <87fu3k563t.fsf@concordia.ellerman.id.au>
 <20180425135104.3e9e3812@roar.ozlabs.ibm.com>
Date: Thu, 26 Apr 2018 19:47:46 +1000
Message-ID: <87a7tq5mf1.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicholas Piggin <npiggin@gmail.com> writes:
> On Wed, 25 Apr 2018 13:15:34 +1000
> Michael Ellerman <mpe@ellerman.id.au> wrote:
>> Nicholas Piggin <npiggin@gmail.com> writes:
>> 
>> > The NMI IPI handler for a receiving CPU increments nmi_ipi_busy_count
>> > over the handler function call, which causes later smp_send_nmi_ipi()
>> > callers to spin until the call is finished.
>> >
>> > The smp_send_stop function never returns, so the busy count is never
>> > decremeted, which can cause the system to hang in some cases. For
>> > example panic() will call smp_send_stop early on, then later in the
>> > reboot path, pnv_restart will call smp_send_stop again, which hangs.
>> >
>> > Fix this by adding a special case to the smp_send_stop handler to
>> > decrement the busy count, because it will never return.
>> >
>> > Fixes: 6bed3237624e3 ("powerpc: use NMI IPI for smp_send_stop")
>> > Reported-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
>> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> > ---
>> >  arch/powerpc/kernel/smp.c | 11 ++++++++++-
>> >  1 file changed, 10 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
>> > index e16ec7b3b427..250fccf04c6e 100644
>> > --- a/arch/powerpc/kernel/smp.c
>> > +++ b/arch/powerpc/kernel/smp.c
>> > @@ -567,10 +567,19 @@ void crash_send_ipi(void (*crash_ipi_callback)(struct pt_regs *))
>> >  
>> >  #ifdef CONFIG_NMI_IPI
>> >  static void stop_this_cpu(struct pt_regs *regs)
>> > +{
>> > +	/*
>> > +	 * This is a special case because it never returns, so the NMI IPI
>> > +	 * handling would never mark it as done, which makes any later
>> > +	 * smp_send_nmi_ipi() call spin forever. Mark it done now.
>> > +	 */
>> > +	nmi_ipi_lock();
>> > +	nmi_ipi_busy_count--;
>> > +	nmi_ipi_unlock();
>> >  #else
>> >  static void stop_this_cpu(void *dummy)
>> > -#endif
>> >  {
>> > +#endif  
>> 
>> I don't love this ifdef/endif business.
>> 
>> Can we do it this way instead?
>
> Yeah that's better. Does stop_this_cpu give you an unused function warning
> if you compile with NMI though? I think we need an #if/#else

No because it's called from nmi_stop_this_cpu():

>> +#ifdef CONFIG_NMI_IPI
>> +static void nmi_stop_this_cpu(struct pt_regs *regs)
>> +{
>> +	/*
>> +	 * This is a special case because it never returns, so the NMI IPI
>> +	 * handling would never mark it as done, which makes any later
>> +	 * smp_send_nmi_ipi() call spin forever. Mark it done now.
>> +	 */
>> +	nmi_ipi_lock();
>> +	nmi_ipi_busy_count--;
>> +	nmi_ipi_unlock();
>> +
>> +	stop_this_cpu(NULL);
>> +}
>> +#endif

cheers
