Return-Path: <david-b@pacbell.net>
Received: from smtp127.sbc.mail.sp1.yahoo.com (smtp127.sbc.mail.sp1.yahoo.com
	[69.147.65.186]) by ozlabs.org (Postfix) with SMTP id 9D0A0DDEFB
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Oct 2008 17:06:09 +1100 (EST)
From: David Brownell <david-b@pacbell.net>
To: benh@kernel.crashing.org
Subject: Re: [PATCH 4/7] gpiolib: implement dev_gpiochip_{add,remove} calls
Date: Wed, 22 Oct 2008 23:06:01 -0700
References: <20081016171222.GA24812@oksana.dev.rtsoft.ru>
	<200810221404.52798.david-b@pacbell.net>
	<1224737145.7654.387.camel@pasglop>
In-Reply-To: <1224737145.7654.387.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200810222306.01661.david-b@pacbell.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, i2c@lm-sensors.org,
	Jean Delvare <khali@linux-fr.org>, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 22 October 2008, Benjamin Herrenschmidt wrote:
> On Wed, 2008-10-22 at 14:04 -0700, David Brownell wrote:
> > > So if we register the board infos after 
> > > the controller registered, then nobody will probe the board infos.
> > 
> > See above.  If you're doing it right, there's no problem.
> > That is, scan the OF tables early.  Just like PNP tables
> > get scanned early, for example.
> 
> It's still pretty yucky in that case to scan the device-tree to convert
> it into some kind of fugly board info ... I'd rather have the end
> drivers that actually use those GPIOs scan the device-tree directly.

Keep in mind that these problems are not specific to GPIOs.

And, very important!!, most of the drivers run without OF...

Pretty much any little device that needs board-specific
customization has the same class of problems:  drivers
will need a variety of parameters that may are often not
sharable with other devices, with idiosyncratic usage.
And they hook up to other drivers in arbitrary ways.

When PCs have such issues, ACPI hides them from Linux.

If those parameters -- potentially including callbacks
that escape to FORTH -- are stored in the OF device tree,
so be it.  But "fugly" sounds like part of that problem
domain, so it's no surprise that it maps onto the solution
space too...


Specifically with respect to GPIOs ... what do you mean
by "end driver" though?  I previously pointed at one
example (Davinci EVM) where one bank of GPIOs is used
by about six different drivers ... none of which have
any reason to know they're using a pcf8574a vs any other
kind of GPIO.  Is the "end driver" the IDE/CF driver?
The USB OTG driver?  The driver sitting the next layer
above of one of those?  *Some* of the drivers need to
touch the GPIOs.  Others don't.

 
> But then, I'm not a believer in generic drivers for things
> like GPIOs, i2c devices, etc.. :-)

I kind of like being able to re-use code myself.  ;)

It's a win to have *one* pcf8574/5 driver that can be
reused -- with a bit of care configuring it into the
system -- instead of having every board contribute yet
another board-specific hack in drivers/i2c/chips ...

And I think such stuff can be done even with OF.

- Dave
