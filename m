Message-ID: <4008471A.5070903@mvista.com>
Date: Fri, 16 Jan 2004 13:18:34 -0700
From: Randy Vinson <rvinson@mvista.com>
MIME-Version: 1.0
To: Jeff Angielski <jeff@theptrgroup.com>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: ppc826x BAD interrupts
References: <1074268973.4323.13.camel@localhost.localdomain> <20040116163545.GA8577@synergymicro.com>
In-Reply-To: <20040116163545.GA8577@synergymicro.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Jeff,
   Like Rob, I've seen the same behavior, especially if the interrupting
device is located behind a PCI to PCI bridge. However, I think the true
cause is actually propagation delays though the bridge(s). I've seen a
recommendation that interrupt service routines should always perform a
read as the last transaction with the device to ensure that the
interrupt clearing write has been flushed though the bridge and has
reached the device. I think this comes from the PCI spec or the PCI
bridge spec, but I'm not certain. Most of the interrupt service routines
that I've seen have some sort of loop that reads interrupt status
register from the device, services the events indicated and the loops
around to check for additional events that have ocurred during the
interrupt service routine. This approach satifies the recommendation,
because the read that shows no outstanding events will flush the bridge(s).

   The addition of a "sync" instruction in the interrupt controller
routine is simply adding a delay. This was noted in the post referenced
by Muhammad Sarwar
(http://www.geocrawler.com/archives/3/8358/2002/11/100/10173445/).

  I took a look at the interrupt service routine (fcc_enet_interrupt in
arch/ppc/8260_io/fcc_enet.c) and it does not perform a read-back before
exiting. It would would be interesting to add a readback operation in
the interrupt routine and see if that also fixes the problem. If it
works, I think it would be better than adding a sync delay to every
interrupt.

   A temporary hack would be something like:

	.
	.
	.
	/* Get the interrupt events that caused us to be here.
         */
         int_events = cep->fccp->fcc_fcce;
         cep->fccp->fcc_fcce = int_events;
	{
		ushort temp;
		temp = cep->fccp->fcc_fcce;
	}
         must_restart = 0;
	.
	.
	.


			Randy Vinson
			MontaVist Software


Rob Baxter wrote:

> Hi Jeff,
>
> Yes, I have seen this on a PowerPC platform.  And what I have noticed is
> that faster (i.e., internal core frequency) the processor the more
> likelihood of this happening.  However, it is highly dependent upon the
> platform (e.g., interrupting devices, interrupt controller).
>
> A good example is an interrupt request from a PCI bus device.  Many device
> driver interrupt handlers will clear the source of the interrupt by either
> reading or writing some register within the device, perform some necessary
> actions, and return from the handler.  The PCI device is slow to negate its
> interrupt request and the interrupt controller sees the interrupt request
> from the device again.  With the platforms that I'm associated with I've
> seen this happen more frequently (i.e., BAD interrupts) as processor
> internal core frequencies increase, especially with the 7457.
>
> --
> Rob Baxter
>
>
>
>

Muhammad Sarwar wrote:
 > This problem was discussed on mailing list before also and you can
 > eliminate this problem by inserting a sync instruction at a certain
 > place in the 8260 interrupt handling code. See, for example,
 > http://www.geocrawler.com/archives/3/8358/2002/11/100/10173445/
 >
 > Add a __asm__ volatile("sync"); at the end of the m8260_mask_and_ack
 > function in arch/ppc/kernel/ppc8260_pic.c to fix it.
 >
 >
 > Regards,
 >
 > Muhammad Sarwar
 > Mangrove Systems Inc.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
