Return-Path: <khali@linux-fr.org>
Date: Tue, 1 Jul 2008 20:24:54 +0200
From: Jean Delvare <khali@linux-fr.org>
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH 2/2] Add the of_find_i2c_device_by_node function, V4
Message-ID: <20080701202454.688fd7d7@hyperion.delvare>
In-Reply-To: <9e4733910807011006t20c7689ctfe26931f96c84092@mail.gmail.com>
References: <20080630230126.12482.87927.stgit@terra>
	<20080630230128.12482.79570.stgit@terra>
	<20080701170544.72051418@hyperion.delvare>
	<9e4733910807010812h30e49144v5b3012e6c156ecca@mail.gmail.com>
	<20080701182949.12119d6e@hyperion.delvare>
	<20080701164518.GG6918@secretlab.ca>
	<20080701190151.76782bbd@hyperion.delvare>
	<9e4733910807011006t20c7689ctfe26931f96c84092@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 1 Jul 2008 13:06:37 -0400, Jon Smirl wrote:
> On 7/1/08, Jean Delvare <khali@linux-fr.org> wrote:
> > On Tue, 1 Jul 2008 10:45:18 -0600, Grant Likely wrote:
> >  > But the other side of the coin is that each driver must have
> >  > driver-specific OF code to translate data in the device tree to data
> >  > usable by the driver.  It doesn't make any sense to me for that stuff to
> >  > live anywhere other that with the driver that it supports.
> >
> >
> > This code is glue between OF and subsystems. As with any glue code, you
> >  can argue forever on which side you want to push the code to. Both
> >  answers are valid.
> >
> >  All I see on my personal side is that I don't have any system using OF
> >  and no knowledge about it either, so I can't maintain of_i2c. So having
> >  that file in drivers/of rather than drivers/i2c will make my life
> >  easier for sure. While I'd guess that most (all?) OF-based systems have
> >  an I2C bus, so whoever is responsible for drivers/of should be able to
> >  maintain of_i2c.
> 
> We could modify the Makefile for i2c core to get the source out of
> drivers/of and link it into i2c-core. That would remove the need to
> export symbols.

That might be a bit confusing, but could be done. I still don't know
what problem you are trying to solve though. As I repeated, exporting
i2c_bus_type is perfectly fine. All other bus types are always
exported. So if it's all you need from i2c-core, there's no problem and
we can stop the discussion here.

> Or you could move the file into the i2c directory and just put a note
> on it that Grant is the maintainer.

Assuming that developers will read the source code to find out who the
maintainer is, when we have told everyone to search for this
information in MAINTAINERS. I'd rather add an entry in MAINTAINERS, but
even then I have a doubt that people will get it. My experience is that
people map maintainer names to directories and that's about it. That's
one of the reasons why I wanted to move the i2c device drivers from
drivers/i2c/chips to drivers/hwmon, drivers/rtc, drivers/gpio, etc.

-- 
Jean Delvare
