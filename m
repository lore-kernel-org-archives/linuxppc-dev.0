Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: devicetree-discuss@lists.ozlabs.org
Subject: Re: Deprecating of_platform, the path from here...
Date: Fri, 11 Dec 2009 16:25:29 +0100
References: <fa686aa40912091406i2ef4e1b2u25c9f46b20786245@mail.gmail.com>
	<20091209.162121.256573183.davem@davemloft.net>
	<fa686aa40912101247k55d56783ge0163dd1da073b49@mail.gmail.com>
In-Reply-To: <fa686aa40912101247k55d56783ge0163dd1da073b49@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200912111625.29674.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, David Miller <davem@davemloft.net>, jk@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday 10 December 2009, Grant Likely wrote:
> On Wed, Dec 9, 2009 at 5:21 PM, David Miller <davem@davemloft.net> wrote:
> > From: David Miller <davem@davemloft.net>
> > Date: Wed, 09 Dec 2009 16:15:50 -0800 (PST)
> >> What a shame, it's one of the cleanest driver probing models
> >> in the tree.
> >
> > And BTW, have you folks who "decided" this considered at all the fact
> > that it is much easier to describe represent platform devices using
> > of OF devices rather than the other way around?
> 
> Yup.  I also think of_platform is a cleaner implementation than
> platform, but the fact remains that there are far more platform
> drivers than there are of_platform.  So, as nice as of_platform is, it
> still does pretty much exactly the same job as platform.  I'd rather
> see of_platform features migrated to platform than creating drivers
> with dual registrations to be used on both OF and non-OF platforms.

As far as I can tell, there is another path to allow unifying the drivers
that currently need to register to both platform_bus and of_bus, without
destroying the features we currently have in those two.

> Trying to go the other way around (deprecate platform and encouraging
> of_platform instead) I don't think will gain much traction; whereas I
> think bringing of_platform features into platform will be an easier
> sell.  I'm trying to be pragmatic here.

The key to the solution IMHO is the ability to create an of_platform_device
in a hardcoded way without data from a device tree, like we create a
platform_device today. All these static of_devices would then be rooted
in /sys/platform by default, while those that come from a device tree are
in the hierarchy defined there.

With your generalized device tree support, you have come most of
the way there, so the next step could be to create an
of_platform_device_register or of_platform_device_{alloc,add} function
that behaves like platform_device_register but adds an of_device
instead.

Something along the lines of

struct of_platform_device {
	of_device dev;			  /* this is what gets registered */
	struct device_node node; /* can't point to the device tree */
	struct property compatible;
};

int of_platform_device_register(struct of_platform_device *ofpdev,
					const char *name,	struct property *properties,
					struct device *parent)
{
	/* fill out the of_device */
	ofpdev->dev.node = &ofpdev->node;
	ofpdev->dev.dev.bus = &of_platform_bus_type;
	ofpdev->dev.dev.parent = parent;
	ofpdev->dev.dev.archdata.of_node = &ofpdev->node;

	/* fill out only the parts of the node that are absolutely required */
	ofpdev->node.name = name;
	if (!ofpdev->node.type)
		ofpdev->node.type = "platform"; /* not sure */
	ofpdev->node.properties = &ofpdev->compatible;
	kref_init(&ofpdev->node.kref);

	/* add properties that we always want */
	ofpdev->compatible.name = "compatible";
	ofpdev->compatible.length = strlen(name);
	ofpdev->compatible.value = name;

	/* add any user-specified properties and chain them */
	ofpdev->compatible.next = properties;
	while (properties->name)
		properties->next = ++properties;


	return of_device_register(&ofpdev->dev);
}

There are obviously detailed that need to be worked out for this,
but it should give you an easy way of defining of_platform_devices.
All existing platform_drivers can stay unchanged, but if any driver
should deal with both of_device and platform_device, you just
kill the platform_driver in there and transform the platform_device
definitions for this driver to of_platform_device definitions.

	Arnd
