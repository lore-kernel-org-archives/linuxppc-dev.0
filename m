Return-Path: <glikely@secretlab.ca>
Received: from mail-ww0-f41.google.com (mail-ww0-f41.google.com [74.125.82.41])
	by ozlabs.org (Postfix) with ESMTP id 78783B7043
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 28 Oct 2010 00:40:46 +1100 (EST)
Received: by wwb17 with SMTP id 17so2614025wwb.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 27 Oct 2010 06:40:44 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
Date: Wed, 27 Oct 2010 14:40:34 +0100
From: Grant Likely <grant.likely@secretlab.ca>
To: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH] powerpc/5121: pdm360ng: fix touch irq if 8xxx gpio
	driver is enabled
Message-ID: <20101027134034.GA9556@angua.secretlab.ca>
References: <1284581577-2217-1-git-send-email-agust@denx.de>
	<20100916023823.GB7049@angua.secretlab.ca>
	<20100925222244.2fad5ff6@wker>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100925222244.2fad5ff6@wker>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Sep 25, 2010 at 10:22:44PM +0200, Anatolij Gustschin wrote:
> On Wed, 15 Sep 2010 20:38:23 -0600
> Grant Likely <grant.likely@secretlab.ca> wrote:
> 
> > On Wed, Sep 15, 2010 at 10:12:57PM +0200, Anatolij Gustschin wrote:
> > > Enabling the MPC8xxx GPIO driver with MPC512x GPIO extension
> > > breaks touch screen support on this board since the GPIO
> > > interrupt will be mapped to 8xxx GPIO irq host resulting in
> > > a not requestable interrupt in the touch screen driver. Fix
> > > it by mapping the touch interrupt on 8xxx GPIO irq host.
> > 
> > This looks wrong to me.  The touchscreen code should not go mucking
> > about in the GPIO controller registers; that is the job of the gpio
> > driver.
> 
> But if there is no GPIO driver (as it was the case before adding
> mpc512x support in the 8xxx gpio driver) or if the driver is not
> enabled in the kernel configuration? Then the platform specific
> callback (called from touchscreen driver) returns the pin state
> and acknowlegdes the interrupt.

So, basically the touchscreen device node has an interrupts property
which does not use the gpio controller as the interrupt controller,
but instead points directly and the interrupt controller that the gpio
controller is cascaded from.

Really it sounds like the device tree data is broken.  The preferred
solution is be to fix the device tree to declare the gpio node as
an interrupt controller.

> 
> >  What is the reason that the touch interrupt isn't
> > requestable?
> 
> The 8xxx gpio driver sets up gpio irq host and installs
> the chained irq handler for GPIO interrupt 78 using
> set_irq_chained_handler() which sets the status field of
> the irq_desc structure to IRQ_NOREQUEST | IRQ_NOPROBE.
> Other drivers can't request this GPIO interrupt any more,
> request_threaded_irq() checks the IRQ_NOREQUEST status
> flag and returns -EINVAL if it is set. The gpio interrupts
> for each gpio pin are now handled by the
> mpc8xxx_gpio_irq_cascade() handler as they should.
> 
> >  It looks like the 8xxx gpio driver is designed to hand
> > out a separate virq number for each gpio pin (I've not had time to dig
> > into details, so you'll need to educate me on the problem details)
> 
> Yes, exactly. This patch adds code to request the
> board's pen_down gpio pin and to use it's virq number in
> the touchscreen driver. The touchscreen driver can
> request this virq interrupt and it is now properly handled
> by the chained handler in the gpio driver.

...but it does so by hard coding the irq number (via the GPIO number)
into the board code; a situation which I've tried very hard to avoid.
This is what I'm not okay with.

Another solution is to modify the 8xxx gpio driver to cascade off the
normal request_irq() path instead of via set_irq_chained_handler(),
but that *might* have unacceptable performance impact for other users.

Unfortunately, I've been slow on this patch, so I cannot get anything
into 2.6.37 (sorry).  However, I've not asked Linus to pull the 8xxx
gpio driver changes either so nothing in mainline will get broken.

g.
