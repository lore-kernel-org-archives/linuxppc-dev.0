Return-Path: <mmporter@cox.net>
Date: Mon, 27 Sep 2004 22:13:23 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: David Gardiner <daveg@sonartech.com.au>
Message-ID: <20040927221323.A30581@home.com>
References: <4153A362.8010604@sonartech.com.au>
	<AE8972FB-0E3A-11D9-BC8B-000A95A4DC02@kernel.crashing.org>
	<4158DD68.2060707@sonartech.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4158DD68.2060707@sonartech.com.au>;
	from daveg@sonartech.com.au on Tue, Sep 28, 2004 at 01:41:28PM
	+1000
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: powerpc with gigabit card hanging
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

[Followups to linuxppc-embedded, this is an embedded port question]

On Tue, Sep 28, 2004 at 01:41:28PM +1000, David Gardiner wrote:
> 
> > It's not the platform; I've run both e1000 and tg3 successfully
> > on PowerPC systems, no problems getting it to work at all.
> >
> What kernel are you using? it's just that the irq's I'm getting for the 
> gigabit devices are zero (dual gigabit ethernet card) for the 2.6.9-rc2 
> plus patchs kernel but for the 2.4 series I was getting 12 and 9 as can 
> be seen below and configuring the devices worked fine. I've also noticed 
> that there have been recent changes made to the irq routing in the 
> kernel so this may have something to do with it so I'll try one the 
> i386's with gigabit with the 2.6.9-rc2 and see what I get!

What "changes made to the irq routing" have you noticed? Hopefully
not the i386-specific ACPI ones...

irqs for PCI devices do not come from the driver, they are platform
specific.  If you are having problems with the interrupt reported
by xyz PCI driver then that is something wrong with your platform.
On pmac, interrupt routing is retrieved from OF. On prep, it's
retrieved from either residual data or in-kernel tables. If
embedded, then this is on the wrong list. Oops, looking at your
original message this appears to be the case (PowerPlus). Sounds
like the interrupt routing table for your board is wrong.

FWIW, e1000 works great here on my PowerPC platforms and 2.6.9-rc2

-Matt
