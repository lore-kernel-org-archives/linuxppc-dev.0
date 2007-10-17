Return-Path: <dgibson@ozlabs.org>
Date: Wed, 17 Oct 2007 10:37:08 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH 2/2] i2c: Add devtree-aware iic support for PPC4xx
Message-ID: <20071017003708.GC28260@localhost.localdomain>
References: <200710151529.11485.sr@denx.de>
	<20071015163216.GA8127@gate.ebshome.net>
	<fa686aa40710150957s74693835g257b376adfdb4e90@mail.gmail.com>
	<20071015185340.GB4474@loki.buserror.net>
	<fa686aa40710151213r670bea49i63fa5f5402aa150d@mail.gmail.com>
	<20071016032041.GN26787@localhost.localdomain>
	<fa686aa40710152121o2fe0d7c9m156170901fd3bf98@mail.gmail.com>
	<20071016211939.250c2da4@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071016211939.250c2da4@hyperion.delvare>
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Oct 16, 2007 at 09:19:39PM +0200, Jean Delvare wrote:
> On Mon, 15 Oct 2007 22:21:38 -0600, Grant Likely wrote:
> > On 10/15/07, David Gibson <david@gibson.dropbear.id.au> wrote:
> > > In fact I think it may be acceptle to do the idx++ thing in this
> > > situation.  Bus numbers are ugly, but it's not the worst ugliness in
> > > the horrible mess that is the Linux i2c subsystem.  It means that bus
> > > numbers are theoretically unstable, but that's increasingly true of
> > > devices of all sorts - it's up to udev to assign meaningful labels at
> > > the user level.
> 
> David, after such a rant against the Linux i2c subsystem, I sure hope
> that you're going to contribute patches to make it better (whatever you
> think needs to be improved, as you didn't say.)

I've frequently contemplated it.  In the unlikely event that it ever
bubbles to the top of my priorities, I might well.

> > I think the real problem here comes into play when there are 2 types
> > of i2c busses in the system.  If they both maintain their own idx++
> > values; then they will conflict.  If an auto assigned bus number is
> > used; then it needs to be assigned by the i2c infrastructure; not by
> > the driver.
> 
> Very true. If you aren't going to define the i2c bus numbers at
> platform data level, then you shouldn't be defining them _at all_.
> Don't use i2c_add_numbered_adapter, use i2c_add_adapter and let
> i2c-core choose an appropriate a bus number.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
