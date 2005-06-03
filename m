Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao07.cox.net (fed1rmmtao07.cox.net [68.230.241.32])
	by ozlabs.org (Postfix) with ESMTP id 7130E67B32
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  4 Jun 2005 07:35:51 +1000 (EST)
Date: Fri, 3 Jun 2005 14:35:48 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Greg KH <greg@kroah.com>
Message-ID: <20050603143548.B32392@cox.net>
References: <20050602140359.B24818@cox.net> <20050603072027.GD30292@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050603072027.GD30292@kroah.com>;
	from greg@kroah.com on Fri, Jun 03, 2005 at 12:20:27AM -0700
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
	linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH][1/5] RapidIO support: core
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Jun 03, 2005 at 12:20:27AM -0700, Greg KH wrote:
> On Thu, Jun 02, 2005 at 02:03:59PM -0700, Matt Porter wrote:
> > +static struct device rio_bus = {
> > +	.bus_id = "rapidio",
> > +};
> 
> Why do you need this device?  You shouldn't have a static struct device
> to start with.  Or you just don't like having your root rio device
> showing up in /sys/devices/ ?

Exactly. There's no hierarchy in this interconnect. So it seemed
that having a static rio_bus device made the most sense. Everything
exists as peers since it works more like a network than a hierarchical
bus like PCI. Right now, you can't see the endpoint which actually
implements your port into the switch fabric...there's no device
created for it. I'm still trying to determine if that should change
but it's not critical to usability with the current generation
hardware.

One argument I have _for_ it is that it would be easy to show
and manipulate a network from userspace if all nodes had a device
associated with them.  That's not a real world problem yet so
I decided not to complicate things yet.

> If so, just create a kobject and put it there, and then base your
> devices off of it, no need for a real device.
> 
> Oh wait, that's what the platform and system code does.  bah,
> nevermind...

Ok. I did pull this part right from the platform code, in fact.

-Matt
