Message-ID: <407E42F9.1060201@imc-berlin.de>
Date: Thu, 15 Apr 2004 10:08:25 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: problem with queue_task() and mark_bh()...
References: <407BF458.5080408@imc-berlin.de>
In-Reply-To: <407BF458.5080408@imc-berlin.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I wrote:

> I have a problem with queue_task() and mark_bh().
> ...
> At a later point (namely in the interrupt service rountine this happens:
>
>  /* If we have interrupts pending, then put them on a system task queue.*/
>  if( events == HCF_INT_PENDING ) {
>     /* Schedule the ISR handler as a bottom-half task in the
>      * tq_immediate queue
>      */
>     printk( "Schedule the ISR handler %#lx...\n", lp->task.routine);
>
>     queue_task( &( lp->task ), &tq_immediate );
>     mark_bh( IMMEDIATE_BH );
> }
>
> The problem is now that the queued task lp->task (i.e. wl_isr_handler)
> never get's called! And thus the driver does not work.

When I call run_task_queue(&tq_immediate) right after mark_bh(IMMEDIATE_BH)
then it works.

But I though "run_task_queue(&tq_immediate)" gets called by the kernel
(after every timer interrupt)...


--
Steven Scholz

imc Measurement & Control               imc Meﬂsysteme GmbH
Voltastr. 5                             Voltastr. 5
13355 Berlin                            13355 Berlin
Germany                                 Deutschland

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
