In-Reply-To: <40E5D609.6090201@246tNt.com>
References: <40E5D609.6090201@246tNt.com>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <DE336CD5-CC79-11D8-BA44-000393C30512@freescale.com>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: IRQ Level / Edge
Date: Fri, 2 Jul 2004 17:47:59 -0500
To: Sylvain Munaut <tnt@246tnt.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Level sensitive Interrupts will continue to fire until the interrupt is
cleared.  Essentially, the hardware device causing the interrupt will
bring the interrupt line up (or down, depending on the polarity), and
keep it at that level until the condition disappears.  By setting the
IRQ controller to consider that interrupt level-sensitive, the
controller knows that the interrupt is still firing, and if you unmask
the interrupt while the signal is high, it will fire again.

Edge sensitive means that the interrupt only fires on a transition (low
to high for positive, high to low for negative).  Thus you don't have
to worry about clearing the interrupt before unmasking it.

I'm not sure if that's clear, but to summarize: Level and edge are
descriptions of how the interrupt is detected (by the "level" of the
interrupt, or by a transition *to* that level).  As for where to find
out which it is, the manual for the device should specify whether the
interrupt signal is level or edge sensitive.

On Jul 2, 2004, at 16:39, Sylvain Munaut wrote:

>
> Hello
>
> I don't really understand what setting an IRQ as Level or Edge really
> implies. (  I mean in irq_desc[i] )
> And how to know what to put.
>
> Can some one explain me or give me some pointers.
>
>
> Sylvain Munaut
>
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
