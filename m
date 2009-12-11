Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <200912111625.29674.arnd@arndb.de>
References: <fa686aa40912091406i2ef4e1b2u25c9f46b20786245@mail.gmail.com>
	<20091209.162121.256573183.davem@davemloft.net>
	<fa686aa40912101247k55d56783ge0163dd1da073b49@mail.gmail.com>
	<200912111625.29674.arnd@arndb.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 11 Dec 2009 09:44:32 -0700
Message-ID: <fa686aa40912110844l5990d6fbh7c9c0928513b055d@mail.gmail.com>
Subject: Re: Deprecating of_platform, the path from here...
To: Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1
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

On Fri, Dec 11, 2009 at 8:25 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 10 December 2009, Grant Likely wrote:
>> On Wed, Dec 9, 2009 at 5:21 PM, David Miller <davem@davemloft.net> wrote=
:
>> > From: David Miller <davem@davemloft.net>
>> > Date: Wed, 09 Dec 2009 16:15:50 -0800 (PST)
>> >> What a shame, it's one of the cleanest driver probing models
>> >> in the tree.
>> >
>> > And BTW, have you folks who "decided" this considered at all the fact
>> > that it is much easier to describe represent platform devices using
>> > of OF devices rather than the other way around?
>>
>> Yup. =A0I also think of_platform is a cleaner implementation than
>> platform, but the fact remains that there are far more platform
>> drivers than there are of_platform. =A0So, as nice as of_platform is, it
>> still does pretty much exactly the same job as platform. =A0I'd rather
>> see of_platform features migrated to platform than creating drivers
>> with dual registrations to be used on both OF and non-OF platforms.
>
> As far as I can tell, there is another path to allow unifying the drivers
> that currently need to register to both platform_bus and of_bus, without
> destroying the features we currently have in those two.
>
>> Trying to go the other way around (deprecate platform and encouraging
>> of_platform instead) I don't think will gain much traction; whereas I
>> think bringing of_platform features into platform will be an easier
>> sell. =A0I'm trying to be pragmatic here.
>
> The key to the solution IMHO is the ability to create an of_platform_devi=
ce
> in a hardcoded way without data from a device tree, like we create a
> platform_device today. All these static of_devices would then be rooted
> in /sys/platform by default, while those that come from a device tree are
> in the hierarchy defined there.
>
> With your generalized device tree support, you have come most of
> the way there, so the next step could be to create an
> of_platform_device_register or of_platform_device_{alloc,add} function
> that behaves like platform_device_register but adds an of_device
> instead.

The problem remains that of_platform and platform essentially do
exactly the same job.  It's not interesting to me for it to be
'normal' to use both in the same kernel.  My goal is to have a single
bus and not have to choose between them when writing a driver.  I can
already hear the howls of protest when the first patch to migrate a
platform driver to of_platform get posted... and requires all users of
the driver to now include the of_platform infrastructure.  Basically
it means adding more code, imposing code churn, and increasing the
size of the kernel for no measurable benefit for the existing
architecture users.

platform users far outnumber of_platform users.  I actually don't care
which becomes the 'preferred' bus, just as long as one is chosen.  It
is easy to migrate features between them.  When I look at the work
required though, I think it is far more feasible to fold of_platform
features into platform bus than it is to ask current platform users to
migrate over to of_platform.

Now, if consensus can be reached among architecture maintainers to
make of_platform the preferred approach, and to deprecate platform
bus, then I'm all for it and I'll work towards it  However, I
personally don't think it will fly and so I'm not spending any effort
on that direction.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
