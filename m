Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f196.google.com (mail-yw0-f196.google.com
	[209.85.211.196]) by ozlabs.org (Postfix) with ESMTP id 4D882B7D55
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Apr 2010 15:30:03 +1000 (EST)
Received: by ywh34 with SMTP id 34so2087243ywh.17
	for <linuxppc-dev@ozlabs.org>; Fri, 09 Apr 2010 22:30:02 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4BBF7E9C.80604@billgatliff.com>
References: <4BBF7E9C.80604@billgatliff.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 9 Apr 2010 23:29:42 -0600
Message-ID: <i2zfa686aa41004092229l97b83ebdqba6aece45419dc0@mail.gmail.com>
Subject: Re: A better way to sequence driver initialization?
To: Bill Gatliff <bgat@billgatliff.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	linux-embedded <linux-embedded@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Apr 9, 2010 at 1:23 PM, Bill Gatliff <bgat@billgatliff.com> wrote:
> Guys:
>
>
> My recent post, "Requesting a GPIO that hasn't been registered yet", and
> Anton's reply thereto (thanks, Anton!) on linuxppc-dev got me thinking
> about the problem of dependencies between devices in different =A0classes=
,
> and/or between drivers/devices in general. =A0I'd like to float an idea t=
o
> see if it's worth pursuing.
>
> Changing the link order to get drivers to initialize in the right order
> will always be a problem for someone--- the order will be right for some
> people, but exactly wrong for others. =A0And the problem is made worse fo=
r
> Device Tree-based systems, where just about everything including IRQ
> descriptors are created on a demand and/or as-available basis. =A0What if
> we let the kernel sort those dependencies out for us, at runtime? =A0I
> think it's possible, and I can't be the only one who would like to see
> this happen.
>
> There are two parts to my idea for a solution. =A0First part is to modify
> do_initcalls() so that it launches each initcall function in its own
> kernel thread. =A0Wait, don't panic yet!

Is initcall the right granularity?  Shouldn't it be that each .probe()
hook gets its own thread?  Otherwise one device missing its resources
could block another device using the same driver (whose resources are
available) from probing.  Regardless, parallel probe has be attempted
and failed before.  There are lots of fiddly bits to get right.

In fact, there *used* to be code in the kernel that does exactly that.
 It was put in 2.6.20, but removed in 2.6.21-rc1.  Here's the relevant
commits, and a very interesting thread discussing the issues:

http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dcomm=
itdiff;h=3D21c7f30b1d3f8a3de3128478daca3ce203fc8733
http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dcomm=
itdiff;h=3D5adc55da4a7758021bcc374904b0f8b076508a11
http://lkml.indiana.edu/hypermail/linux/kernel/0705.1/0205.html

It is pointed out in that thread that a big part of the problem is
that a large number of drivers in the tree just aren't safe for
multithreaded probing which is kind of a showstopper.  Now, maybe
doing it at the initcall level makes it less scary and more sane, but
I suspect that it will still expose a lot of broken code that assumes
things are already set up because it has always been that way.

> Second, we create/modify functions like gpio_request() so that if they
> fail, they can optionally stop in a wait queue until the call could
> succeed. =A0Then gpiochip_add() would signal that queue each time a new
> gpiochip was added. Functions like request_irq() and clk_get()--- and
> probably many others--- would do the same thing, but with their own wait
> queues.

You could take a look at the bus notifier code too.  I made an attempt
at solving a similar problem between Ethernet MAC drivers and binding
against the correct phy.  I ended up solving the problem in a
different way, but the experimenting I did convince me that it is a
viable concept.

Basically, if the driver depends on another resource/device then it
can register a callback to be notified when a new device becomes
available.  Once the needed device shows up (or immediately if the
device is already there), the driver gets called back and it can
complete registration.

Not quite the same model that you are talking about here, but it would
solve the problem on a per-driver basis.

> Something like this:
>
> =A0 =A0static wait_queue_head_t requestor_wq;
>
> =A0 =A0int gpiochip_add(struct gpio_chip *chip)
> =A0 =A0{
> =A0 =A0 =A0 =A0...
> =A0 =A0 =A0 =A0wake_up_interruptible(&requestor_wq);
> =A0 =A0 =A0 =A0return status;
> =A0 =A0}
>
> =A0 =A0int gpio_request_wait(unsigned gpio, const char *label)
> =A0 =A0{
> =A0 =A0 =A0 =A0return wait_event_interruptible(&requestor_wq,
> !gpio_request(gpio, label));
> =A0 =A0}
>
>
> Or we might want to make the above code be the actual gpio_request(),
> and bury the wait_event_interruptible() inside of that. =A0Doing so would
> prevent having to touch a lot of code, but would definitely change the
> behavior of gpio_request(). =A0Not sure which approach is best.
>
> Finally, I think that do_initcalls() would turn into something like this:
>
> =A0 =A0static void __init do_initcalls(void)
> =A0 =A0{
> =A0 =A0 =A0 =A0 =A0 =A0initcall_t *fn;
>
> =A0 =A0 =A0 =A0 =A0 =A0for (fn =3D __early_initcall_end; fn < __initcall_=
end; fn++)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0kthread_create(do_one_initcall, *f=
n, "do_initcalls");
>
> =A0 =A0 =A0 =A0 =A0 =A0flush_scheduled_work();
> =A0 =A0}
>
>
> If someone doesn't tell me this is a stupid idea, I might post it to
> lkml. =A0Now's your chance! =A0:)

Have you dug into the Arjan's asynchronous function call infrastructure?

http://lwn.net/Articles/314808/

g.
