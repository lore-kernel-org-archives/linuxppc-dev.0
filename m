Date: Thu, 21 Nov 2002 11:25:40 -0700
From: Matt Porter <porter@cox.net>
To: Hollis Blanchard <hollis@austin.ibm.com>
Cc: devel list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: ppc_irq_dispatch_handler and unhandled interrupts
Message-ID: <20021121112540.A8766@home.com>
References: <1037897936.10521.89.camel@granite.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1037897936.10521.89.camel@granite.austin.ibm.com>; from hollis@austin.ibm.com on Thu, Nov 21, 2002 at 10:58:55AM -0600
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Nov 21, 2002 at 10:58:55AM -0600, Hollis Blanchard wrote:
> Here's the failure mode:
> On a 405LP (using ppc405_pic), an irq is becoming unmasked[1] (in
> UIC0_ER). ppc_irq_dispatch_handler sees irq_desc[0].action == NULL, and
> correctly complains of an unhandled interrupt and masks it off. However
> at the end of the same function (label "out"), the irq is unmasked again
> because irq_desc[0].handler == ppc405_pic (irq_desc[0..NR_IRQS] =
> ppc405_pic; see ppc4xx_init_IRQ() ). So the irq is unmasked, occurs
> again, is masked, is unmasked, occurs again...
>
> The attached patch fixes the problem by checking desc->action as well as
> desc->handler - there is no sense unmasking an interrupt if we already
> know there are no drivers ready to handle it.
>
> [1] In my particular case, UIC0_ER is being modified by BIOS when waking
> from sleep (the BIOS later returns control to Linux), which could be
> worked around in wakeup code. However in the interest of handling as
> many unexpected hardware and software errors as possible, I believe this
> patch should be applied.

As I mentioned on IRC, I think this is a Good Thing(tm).  This cleanly
handles the case where somebody leaves an unhooked interrupt unmasked.
It's another good example of hardening the kernel by handling error
conditions smartly.  Unless anybody has serious objections to this
additional check, I'd like to push it in.

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
