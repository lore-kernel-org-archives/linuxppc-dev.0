Return-Path: <bgat@billgatliff.com>
Received: from mail-pw0-f42.google.com (mail-pw0-f42.google.com
	[209.85.160.42]) by ozlabs.org (Postfix) with ESMTP id 73C58B7CFA
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Apr 2010 05:22:01 +1000 (EST)
Received: by pwi8 with SMTP id 8so2983863pwi.15
	for <linuxppc-dev@ozlabs.org>; Fri, 09 Apr 2010 12:22:00 -0700 (PDT)
Message-ID: <4BBF7E9C.80604@billgatliff.com>
Date: Fri, 09 Apr 2010 14:23:08 -0500
From: Bill Gatliff <bgat@billgatliff.com>
MIME-Version: 1.0
To: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	linux-embedded <linux-embedded@vger.kernel.org>
Subject: A better way to sequence driver initialization?
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Guys:


My recent post, "Requesting a GPIO that hasn't been registered yet", and
Anton's reply thereto (thanks, Anton!) on linuxppc-dev got me thinking
about the problem of dependencies between devices in different  classes,
and/or between drivers/devices in general.  I'd like to float an idea to
see if it's worth pursuing.

Changing the link order to get drivers to initialize in the right order
will always be a problem for someone--- the order will be right for some
people, but exactly wrong for others.  And the problem is made worse for
Device Tree-based systems, where just about everything including IRQ
descriptors are created on a demand and/or as-available basis.  What if
we let the kernel sort those dependencies out for us, at runtime?  I
think it's possible, and I can't be the only one who would like to see
this happen.

There are two parts to my idea for a solution.  First part is to modify
do_initcalls() so that it launches each initcall function in its own
kernel thread.  Wait, don't panic yet!

Second, we create/modify functions like gpio_request() so that if they
fail, they can optionally stop in a wait queue until the call could
succeed.  Then gpiochip_add() would signal that queue each time a new
gpiochip was added. Functions like request_irq() and clk_get()--- and
probably many others--- would do the same thing, but with their own wait
queues.

Something like this:

    static wait_queue_head_t requestor_wq;

    int gpiochip_add(struct gpio_chip *chip)
    {
        ...
        wake_up_interruptible(&requestor_wq);
        return status;
    }

    int gpio_request_wait(unsigned gpio, const char *label)
    {
        return wait_event_interruptible(&requestor_wq,
!gpio_request(gpio, label));
    }


Or we might want to make the above code be the actual gpio_request(),
and bury the wait_event_interruptible() inside of that.  Doing so would
prevent having to touch a lot of code, but would definitely change the
behavior of gpio_request().  Not sure which approach is best.

Finally, I think that do_initcalls() would turn into something like this:

    static void __init do_initcalls(void)
    {
            initcall_t *fn;

            for (fn = __early_initcall_end; fn < __initcall_end; fn++)
                    kthread_create(do_one_initcall, *fn, "do_initcalls");

            flush_scheduled_work();
    }


If someone doesn't tell me this is a stupid idea, I might post it to
lkml.  Now's your chance!  :)


b.g.

-- 
Bill Gatliff
bgat@billgatliff.com
