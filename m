Message-ID: <3C114C63.3050102@embeddededge.com>
Date: Fri, 07 Dec 2001 18:10:27 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Steve Rossi <srossi@labs.mot.com>
Cc: Embedded Linux PPC List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: high priority interrupts disabled
References: <3C112297.6DE37608@labs.mot.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Steve Rossi wrote:

> .....IRQ2 gets asserted and remains asserted (without
> being serviced) in excess of 10ms during which IRQ6 (hard disk) is
> asserted and quickly serviced over 120 times, and IRQ1 is also asserted
> and quickly serviced several times in that 10ms. IRQ2 doesn't get
> serviced until the disk activity completes

That's interesting.  We read the SIVEC, which gives us the highest priority
unmasked pending interrupt.  We don't read and parse bitmasks.  Since IRQ1
is getting serviced, I wonder if IRQ2 is being masked.  It is possible
to mask an irq, service others, then unmask the irq again, so ensure your
driver isn't doing this.  Of course, we are also doing a mask_and_ack in
the 8xx interrupt handler, which may not be the right thing either.

You could try changing the mask_and_ack function in the ppc8xx_pic.c to
just ack the interrupt and let us know what happens.

> .... IRQ1 is requested with the SA_INTERRUPT flag,
> while IRQ2 is not - should this matter?

I didn't think this flag had any effect anymore.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
