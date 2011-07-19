Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 968DBB6F80
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 19 Jul 2011 18:39:19 +1000 (EST)
Date: Tue, 19 Jul 2011 10:39:17 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] powerpc/5200: add GPIO functions for simple interrupt
	GPIOs
Message-ID: <20110719103917.7ece50c4@wker>
In-Reply-To: <20110715200801.GJ2833@ponder.secretlab.ca>
References: <1306142730-7528-1-git-send-email-agust@denx.de>
	<20110706175245.GL5805@ponder.secretlab.ca>
	<20110709121409.4ee9249e@wker>
	<20110715200801.GJ2833@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org, Detlev Zundel <dzu@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 15 Jul 2011 14:08:01 -0600
Grant Likely <grant.likely@secretlab.ca> wrote:

> On Sat, Jul 09, 2011 at 12:14:09PM +0200, Anatolij Gustschin wrote:
> > On Wed, 6 Jul 2011 11:52:45 -0600
> > Grant Likely <grant.likely@secretlab.ca> wrote:
> > 
> > > On Mon, May 23, 2011 at 11:25:30AM +0200, Anatolij Gustschin wrote:
> > > > The mpc52xx_gpio driver currently supports 8 wakeup GPIOs and 32
> > > > simple GPIOs. Extend it to also support GPIO function of 8 simple
> > > > interrupt GPIOs controlled in the standard GPIO register module.
> > > > 
> > > > Signed-off-by: Anatolij Gustschin <agust@denx.de>
> > > > ---
> > > >  arch/powerpc/platforms/52xx/mpc52xx_gpio.c |  117 ++++++++++++++++++++++++++++
> > > 
> > > I don't want to merge more open coded MMIO gpio driver code.  This whole driver really needs to be converted to use GENERIC_GPIO.
> > 
> > I'm not sure I understand what you mean. Do you mean
> > the conversion to drop of_mm_* stuff?
> 
> No, I mean conversion to use the generic gpio register access
> functions instead of creating new ones.

Could you please explain which functions exactly should be
generalized? All functions (32-bit gpio register access and
8-bit gpio register access for wakeup and simple interrupt gpio
registers) by providing an access function and doing all
simple/wakeup/simple-interrupt gpio specific stuff in it? Or only
providing generic functions for 8-bit gpio registers and use them
for both wakeup and simple-interrupt gpios? Which struct should be
used for register offset calculation in accessors then? Should a
generic 8-bit gpio register description struct be added for this
purpose? Or some defines for generic register offsets? How to
differentiate between shadow registers for wakeup and simple-
interrupt gpios in generic accessors? By adding a type field
to mpc52xx_gpiochip struct and checking for it in generic
accessors?

Thanks,
Anatolij
