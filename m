Subject: Re: PPC405GP: Spurious interrupt during handing level triggered
	interrupts
From: Kenneth Johansson <kenneth.johansson@etx.ericsson.se>
To: "listmember@orkun.us" <listmember@orkun.us>
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <16763.216.110.51.8.1078873137.squirrel@www.orkun.us>
References: <16763.216.110.51.8.1078873137.squirrel@www.orkun.us>
Content-Type: text/plain
Message-Id: <1078936213.16427.27.camel@spawn.uab.ericsson.se>
Mime-Version: 1.0
Date: Wed, 10 Mar 2004 17:30:14 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 2004-03-09 at 23:58, listmember@orkun.us wrote:

> Now, to prevent the second spurious branching, I used ack_irq() call
> (actuall macro) to manually ack the interrupt (before enabling interrupts
> again in ioctl). It works this way.
>
> Is this OK to use or is there a preferred way to do this?

That's mainly what I do also.

I had this comment in the cvs log.
--
The status register was not reset by enable_irq so it
remembered the last one resulting in every interrupt
getting reported twice.
--
and the code that I used was

/* We have to do this manually as enable do not do this for us */
void mask_SR(int dev_irq){

	int bit;
	bit = (dev_irq-17) +25;

	mtdcr(DCRN_UIC_SR(UIC0), (1 << (31 - bit)));
}
--
basically parts of what irq_ack would do (dev_irq is a privat number
local to this driver)

Perhaps the enable code should reset this bit also?? everyone that dose
this type of userspace driver is going to hit this problem.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
