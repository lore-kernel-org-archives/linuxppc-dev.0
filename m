From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ira Weiny <iweiny@acm.org>
Cc: <andre@linux-ide.org>,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: IDE 1Gig Microdrive (Working!!)
Date: Wed, 19 Sep 2001 15:38:06 +0200
Message-Id: <20010919133806.12982@smtp.adsl.oleane.com>
In-Reply-To: <3BA82D10.5694BC63@acm.org>
References: <3BA82D10.5694BC63@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>I have Ben H's 2.4.9 kernel and I have hacked up something which allows
>the 1Gig Microdrive PCCard to work.
>
>What I am wondering is, does my patch stand a chance of making it into
>the tree?
>
>From what I can tell there is already some code to disable the IRQ on
>the Card but I guess the 1Gig drive does not honor this.  So I am
>disabling the IRQ at the processor.  It is my understanding that the IDE
>maintainer will not accept this.  Of course I would put this flag into
>the hwif or drive structure and not use a global like this but if I am
>going to have to apply this patch for every kernel upgrade I will leave
>it this way.
>
>These are against Ben's latest rsync.  Any thoughts, would be
>appreciated.

Well, it's a problem of both broken devices (shame on those drive
manufacturers that don't honor specs), and the linux IDE driver which
isn't prepared to deal with such situations (well, I wouldn't blame
it, but I beleive it might be possible to just clear the interrupt
condition by reading the status register when no handler is installed,
issuing a warning printk). Eventually, moving the request_irq in the
driver to after the probe may work as well...

The code you see in my tree that already sets nIEN is not in the
main Linus tree. It's a workaround for other broken PCCard IDE devices
that was adapted by Paul Mackerras. It's a hack, I hope a solution can
be found that fixes cleanly  the problem for all cases.

In theory, the interrupt is masked until request_irq() is called.
So if the linux IDE code was ready to accept and clear interrupt conditions
when it calls request_irq, things would work... But... in pratice that
is not the case.

The problem is when your interrupt is shared with another device, this
is rarely the case on macs, more frequent on x86 hardware, but in our
case, it does happen as the PCCard controller shares his interrupt with
the PCCard device interrupt. It _might_ be possible to mask the
PCCard interrupt at the controller level, but that would be a mess and
add some more special cases to the already complex IDE layer.

Andre, what do you think would be a good solution ?

Temporarily masking out the interrupt with disable_irq(), even if it's
shared, would be acceptable ? (Provided that it's only masked for a short
period of time obviously). Can the problem be worked around by
doing the request_irq earlier, and making sure the IDE handler always
clear the interrupt condition even when no handler is attached when it's
doing the probe ?

Regards,
Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
