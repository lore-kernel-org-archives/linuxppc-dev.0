Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 33CBCDDEC6
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Dec 2007 08:48:19 +1100 (EST)
Date: Sun, 9 Dec 2007 15:53:07 -0600
From: Olof Johansson <olof@lixom.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [i2c] [PATCH 0/4] Series to add device tree naming to i2c
Message-ID: <20071209215307.GC26651@lixom.net>
References: <20071203212032.23543.3453.stgit@terra.home>
	<9e4733910712091224mcb43f0ci69f578d221505ba7@mail.gmail.com>
	<1197233208.6563.14.camel@pasglop>
	<9e4733910712091257x4ba5e07aue55934fb6898aa2d@mail.gmail.com>
	<1197234799.6563.19.camel@pasglop>
	<9e4733910712091335g534d9248gcd920850f9f679a1@mail.gmail.com>
	<1197236326.6563.22.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1197236326.6563.22.camel@pasglop>
Cc: Jean Delvare <khali@linux-fr.org>, linuxppc-dev@ozlabs.org,
	i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Dec 10, 2007 at 08:38:46AM +1100, Benjamin Herrenschmidt wrote:
> 
> > +static struct i2c_device_id rs5c372_id[] = {
> > +       {"rtc-rs5c372", rtc_rs5c372a},
> > +       {"rs5c372a", rtc_rs5c372a},
> > +       {"rs5c372b", rtc_rs5c372b},
> > +       {"rv5c386", rtc_rv5c386},
> > +       {"rv5c387a", rtc_rv5c387a},
> > +       DT_NAME({"ricoh,rs5c372a", rtc_rs5c372a},)
> > +       DT_NAME({"ricoh,rs5c372b", rtc_rs5c372b},)
> > +       DT_NAME({"ricoh,rv5c386", rtc_rv5c386},)
> > +       DT_NAME({"ricoh,rv5c387a", rtc_rv5c387a},)
> > +       {},
> > 
> > But what's the point in making these names specific to device trees?
> > They are perfectly valid names for the devices that could be used from
> > any platform.
> 
> The more I think about it, the more I tend to agree that tagging isn't
> necessary and you are right. We should just match the name against the
> "compatible" property of the OF nodes (which mean we need to support
> multiple matches though since "compatible" is a list of strings).
> 
> Now, I have a question about your example: Why do you have both
> "rs5c372a" and "ricoh,rs5c372a" ?
> 
> I would argue that we should keep only the later...

I think existing platforms register with the simpler name, so they would
need to be changed. Having both shouldn't do harm though, we tend to
sometimes do the same with of_platform drivers for legacy reasons.

Unless someone adds a ridicously simple match name (by mistake or
whatever), it shouldn't be a problem. And if someone does it to some
dts/firmware, then we'll just need to add device tree fixups to set the
"vendor,product" string instead, yet again similar to how we have to do
sometimes with other drivers/devices.


-Olof
