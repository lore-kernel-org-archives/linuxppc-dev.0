Message-ID: <33774.216.110.51.8.1078964058.squirrel@www.orkun.us>
In-Reply-To: <1078936213.16427.27.camel@spawn.uab.ericsson.se>
References: <16763.216.110.51.8.1078873137.squirrel@www.orkun.us>
    <1078936213.16427.27.camel@spawn.uab.ericsson.se>
Date: Wed, 10 Mar 2004 18:14:18 -0600 (CST)
Subject: Re: PPC405GP: Spurious interrupt during handing level triggered
     interrupts
From: "listmember@orkun.us" <listmember@orkun.us>
To: "Kenneth Johansson" <kenneth.johansson@etx.ericsson.se>
Cc: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Kenneth,

Thanks for replying. I was happy to find your earlier thread during my
list archive search. I though about using something like your sequence
below but finally settled in ack_irq().

> /* We have to do this manually as enable do not do this for us */
> void mask_SR(int dev_irq){
>
> 	int bit;
> 	bit = (dev_irq-17) +25;
>
> 	mtdcr(DCRN_UIC_SR(UIC0), (1 << (31 - bit)));
> }
> --
> basically parts of what irq_ack would do (dev_irq is a privat number
> local to this driver)
>
> Perhaps the enable code should reset this bit also?? everyone that dose
> this type of userspace driver is going to hit this problem.

I think for edge triggered interrupts this would not be desirable if a
driver has sections that it cannot handle interrupts safely and disables
interrupts during such processing. If an interrupt arrived when interrupts
were disabled and enable actually reset the bit the interrupt would be
lost.

However, I think, code could be enhanced to reset the SR bit, "only" for
level triggered interrupts and leave edge triggered interrupts alone. This
would require looking at UIC0_TR register as well.

Best regards,
Tolunay

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
