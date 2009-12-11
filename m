Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D6A42B6EDD
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Dec 2009 02:54:27 +1100 (EST)
In-Reply-To: <200912111625.29674.arnd@arndb.de>
References: <fa686aa40912091406i2ef4e1b2u25c9f46b20786245@mail.gmail.com>	<20091209.162121.256573183.davem@davemloft.net>
	<fa686aa40912101247k55d56783ge0163dd1da073b49@mail.gmail.com>
	<200912111625.29674.arnd@arndb.de>
Subject: Re: Deprecating of_platform, the path from here...
To: Arnd Bergmann <arnd@arndb.de>
Message-ID: <OF923C4598.A28E30EF-ONC1257689.0056B139-C1257689.00574ED8@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Fri, 11 Dec 2009 16:53:38 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@lists.ozlabs.org,
	David Miller <davem@davemloft.net>, jk@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>
> On Thursday 10 December 2009, Grant Likely wrote:
> > On Wed, Dec 9, 2009 at 5:21 PM, David Miller <davem@davemloft.net> wrote:
> > > From: David Miller <davem@davemloft.net>
> > > Date: Wed, 09 Dec 2009 16:15:50 -0800 (PST)
> > >> What a shame, it's one of the cleanest driver probing models
> > >> in the tree.
> > >
> > > And BTW, have you folks who "decided" this considered at all the fact
> > > that it is much easier to describe represent platform devices using
> > > of OF devices rather than the other way around?
> >
> > Yup.  I also think of_platform is a cleaner implementation than
> > platform, but the fact remains that there are far more platform
> > drivers than there are of_platform.  So, as nice as of_platform is, it
> > still does pretty much exactly the same job as platform.  I'd rather
> > see of_platform features migrated to platform than creating drivers
> > with dual registrations to be used on both OF and non-OF platforms.
>
> As far as I can tell, there is another path to allow unifying the drivers
> that currently need to register to both platform_bus and of_bus, without
> destroying the features we currently have in those two.
>
> > Trying to go the other way around (deprecate platform and encouraging
> > of_platform instead) I don't think will gain much traction; whereas I
> > think bringing of_platform features into platform will be an easier
> > sell.  I'm trying to be pragmatic here.
>
> The key to the solution IMHO is the ability to create an of_platform_device
> in a hardcoded way without data from a device tree, like we create a
> platform_device today. All these static of_devices would then be rooted
> in /sys/platform by default, while those that come from a device tree are
> in the hierarchy defined there.

Yes, please. I don't like the direction some drivers are heading, namely OF only.
I always tried to view OF as an layer on top of generic methods. If
you look at spi_mpc83xx.c, it is actually less capable today since
platform has been declared legacy.

    Jocke
