Message-ID: <407BF458.5080408@imc-berlin.de>
Date: Tue, 13 Apr 2004 16:08:24 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: problem with queue_task() and mark_bh()...
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi there,

I have a problem with queue_task() and mark_bh().

In a driver for the wireless HERMES-II chipset I found the code snippets

/* Register the ISR handler information here... */
  lp->task.routine = (void (*)(void *))wl_isr_handler;
  lp->task.data = lp;
  printk("wl_isr_handler is @ %#lx\n", lp->task.routine);

At a later point (namely in the interrupt service rountine this happens:

  /* If we have interrupts pending, then put them on a system task queue.*/
  if( events == HCF_INT_PENDING ) {
	/* Schedule the ISR handler as a bottom-half task in the
	 * tq_immediate queue
	 */
	printk( "Schedule the ISR handler %#lx...\n", lp->task.routine);

	queue_task( &( lp->task ), &tq_immediate );
	mark_bh( IMMEDIATE_BH );
}

The problem is now that the queued task lp->task (i.e. wl_isr_handler) never
get's called! And thus the driver does not work.

If I call the function directly using

	lp->task.routine(lp);

instead of queue_task() and mark_bh() the function wl_isr_handler() gets
called and the driver works.

Any idea why queue_task() and mark_bh() do not work as expected?
How could I debug this problem?
(The two printk's show the same address.)

I am using linuxppc-2.4.25 from DENX CVS.

Thanks a million!!!

--
Steven Scholz

imc Measurement & Control               imc Meﬂsysteme GmbH
Voltastr. 5                             Voltastr. 5
13355 Berlin                            13355 Berlin
Germany                                 Deutschland

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
