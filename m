Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 45502B70AA
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 26 Sep 2010 06:22:43 +1000 (EST)
Date: Sat, 25 Sep 2010 22:22:44 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] powerpc/5121: pdm360ng: fix touch irq if 8xxx gpio
	driver is enabled
Message-ID: <20100925222244.2fad5ff6@wker>
In-Reply-To: <20100916023823.GB7049@angua.secretlab.ca>
References: <1284581577-2217-1-git-send-email-agust@denx.de>
	<20100916023823.GB7049@angua.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 15 Sep 2010 20:38:23 -0600
Grant Likely <grant.likely@secretlab.ca> wrote:

> On Wed, Sep 15, 2010 at 10:12:57PM +0200, Anatolij Gustschin wrote:
> > Enabling the MPC8xxx GPIO driver with MPC512x GPIO extension
> > breaks touch screen support on this board since the GPIO
> > interrupt will be mapped to 8xxx GPIO irq host resulting in
> > a not requestable interrupt in the touch screen driver. Fix
> > it by mapping the touch interrupt on 8xxx GPIO irq host.
> 
> This looks wrong to me.  The touchscreen code should not go mucking
> about in the GPIO controller registers; that is the job of the gpio
> driver.

But if there is no GPIO driver (as it was the case before adding
mpc512x support in the 8xxx gpio driver) or if the driver is not
enabled in the kernel configuration? Then the platform specific
callback (called from touchscreen driver) returns the pin state
and acknowlegdes the interrupt.

>  What is the reason that the touch interrupt isn't
> requestable?

The 8xxx gpio driver sets up gpio irq host and installs
the chained irq handler for GPIO interrupt 78 using
set_irq_chained_handler() which sets the status field of
the irq_desc structure to IRQ_NOREQUEST | IRQ_NOPROBE.
Other drivers can't request this GPIO interrupt any more,
request_threaded_irq() checks the IRQ_NOREQUEST status
flag and returns -EINVAL if it is set. The gpio interrupts
for each gpio pin are now handled by the
mpc8xxx_gpio_irq_cascade() handler as they should.

>  It looks like the 8xxx gpio driver is designed to hand
> out a separate virq number for each gpio pin (I've not had time to dig
> into details, so you'll need to educate me on the problem details)

Yes, exactly. This patch adds code to request the
board's pen_down gpio pin and to use it's virq number in
the touchscreen driver. The touchscreen driver can
request this virq interrupt and it is now properly handled
by the chained handler in the gpio driver.

Anatolij
