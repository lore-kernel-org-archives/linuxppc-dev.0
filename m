Return-Path: <benh@kernel.crashing.org>
Subject: Re: shared config registers and locking
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Eugene Surovegin <ebs@ebshome.net>
In-Reply-To: <20061206060625.GA30005@gate.ebshome.net>
References: <1165381847.5469.70.camel@localhost.localdomain>
	<1165382189.5469.76.camel@localhost.localdomain>
	<20061206060625.GA30005@gate.ebshome.net>
Content-Type: text/plain
Date: Wed, 06 Dec 2006 17:36:23 +1100
Message-Id: <1165386983.5469.94.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> No, it's not simpler. This just does not handle the problem this 
> workaround was implemented for.

Quite possibly I didn't fully understand it as there is little
explanation in the code about what is going on except that the RX clock
from the PHY is dropping and that is causing TX timeouts...

> You don't understand what this workaround does. It has nothing to do 
> with TX path at all. It deals with RX one and the fact that in that 
> particular MAC design whole RX domain is clocked from this clock, 
> meaning some parts of EMAC just simply stop working.

Ok. Up to what extent ? Enough so that MDIO stops working ?

> For some modes (e.g. SMII) this problem will not arise as this clock is always 
> present, there are other cases when it's not needed (like sane PHY).
>
> For example, how do you handle PHY detection if you cannot talk to the 
> PHY?

Ok, so MDIO is going down... Do you have some examples of which PHYs are
causing this ? (for my own curiosity/education)

> Ben, my suggestion, before you start "forking" and "cleaning up" this 
> code, understand what it does.

That is gratuituously mean.

I'm forking it to make everybody's (including yours) life easy as I had
to do major changes to the driver to handle SMP safety, OF platform
probing, and other things like that and I'm trying to avoid disrupting
the existing working driver while I am doing that.

This is more a "branch" than a "fork" per-se and is, I think, the
appropriate thing to do when changes of that magnitude are needed.

I'm not planning to do more "cleanups" than the obvious things that will
naturally result from the changes, like removing ifdef's whenever
possible as the driver becomes multiplatform capable, etc...

Your attack about not understanding what it does is low, since it
concern specifically a workaround for a problem that isn't clearly
explained in the code, and  I was specifically asking you about it
before changing things exactly because I wasn't sure about my
understanding of it !

Besides, I don't understand your bitterness about the situation as, as I
said, I'm trying hard to do things in a way that will be easier to deal
with for everybody, and I've tried to discuss my choices with you on IRC
pretty much every time, to be mostly received with harsh words if not
insults.

Now, regarding that clocking problem, I wonder if it is related to Apple
disabling the automatic low power mode on some PHYs on GEM ... I think
that mode causes that stopping of the RX clock when the link is down and
this is disrupting the chip. (Just wondering if it's a similar isssue).

Now back to this workaround, there is still the issue that you noticed
that on some chips, the only way to tweak the clocks is globally for all
EMACs (440GX). Does that mean that on such a setup, removing the link
after probe will be fatal to the driver ? I suppose switching to
internal clocks of all EMACs is not an option as it will disrupt
activity on all the other ones....

Ben.
