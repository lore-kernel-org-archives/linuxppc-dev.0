In-Reply-To: <Pine.HPX.4.10.10002111800210.1866-100000@gra-ux1.iram.es>
Date: Fri, 11 Feb 2000 18:31:23 +0100
To: Gabriel Paubert <paubert@iram.es>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Latest OpenPic changes
Message-Id: <20000211183123.028211@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Feb 11, 2000, Gabriel Paubert <paubert@iram.es> wrote:

>Please use ISU[irq - open_pic_irq_offset] everywhere. You are not reading
>the interrupt you are modifying probably. On the other hand I'm using a
>completely different solution, and I don't read back when enabling the
>IRQ. I can't see why you could need it, this will go to the bus sooner or
>later, why wait one or several microseconds while the interrupts are being
>acttually enabled in the controller ?

Hum... I must have broken that ISU stuff when moving my 2.2.x stuff to
2.3.x. I'll look at fixing this in Cort's tree this week-end. There's
nothing like that in 2.2.x, all offseting is made outside of openpic.c.

I read back the interrupt until it's actually changed in the controller
for the simple reason that if I don't do that, I sometimes get bogus
interrupts. It looks like the calling path from driver code calling
disable_irq() and the actual disabling of the irq is short enough to
cause the interrupt to fall when unexpected in some cases, or to arrive
after beeing masked (more frequent with IDE). I've seen this behaviour
with the old pmac pic (which was known to be slow). I used to have tons
of bogus interrupts on the ibook & G4 (OpenPIC based), and I got rid of
most of them by adding this code and by implementing an ack_and_mask
function that actually masks the interrupt (which is, I think, not done
on CHRP). I still get some when PMU/ADB doing synchronous requests however.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
