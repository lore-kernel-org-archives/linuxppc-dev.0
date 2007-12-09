Return-Path: <jonsmirl@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.180])
	by ozlabs.org (Postfix) with ESMTP id 01003DDE21
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Dec 2007 08:35:10 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so3108396wag
	for <linuxppc-dev@ozlabs.org>; Sun, 09 Dec 2007 13:35:08 -0800 (PST)
Message-ID: <9e4733910712091335g534d9248gcd920850f9f679a1@mail.gmail.com>
Date: Sun, 9 Dec 2007 16:35:05 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: benh@kernel.crashing.org
Subject: Re: [i2c] [PATCH 0/4] Series to add device tree naming to i2c
In-Reply-To: <1197234799.6563.19.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071203212032.23543.3453.stgit@terra.home>
	<9e4733910712091224mcb43f0ci69f578d221505ba7@mail.gmail.com>
	<1197233208.6563.14.camel@pasglop>
	<9e4733910712091257x4ba5e07aue55934fb6898aa2d@mail.gmail.com>
	<1197234799.6563.19.camel@pasglop>
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

On 12/9/07, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
> On Sun, 2007-12-09 at 15:57 -0500, Jon Smirl wrote:
> >
> > Are there technical concerns with this series? The white space can be
> > fixed in a few minutes.
> >
> > Adding a tag to differentiate matching types has implications that are
> > broader than just i2c. Shouldn't we do this first with the existing
> > scheme and then change the tagging process with later patches?
>
> No, we should decide on what to do with the tagging process (or not do)
> first, don't you think ? (If we need a tagging process, Scott had a
> concern but it might be moot, let's discuss that first).

Right now the tags are simply strings. The second parameter is driver specific.

+static struct i2c_device_id rs5c372_id[] = {
+       {"rtc-rs5c372", rtc_rs5c372a},
+       {"rs5c372a", rtc_rs5c372a},
+       {"rs5c372b", rtc_rs5c372b},
+       {"rv5c386", rtc_rv5c386},
+       {"rv5c387a", rtc_rv5c387a},
+       {"ricoh,rs5c372a", rtc_rs5c372a},
+       {"ricoh,rs5c372b", rtc_rs5c372b},
+       {"ricoh,rv5c386", rtc_rv5c386},
+       {"ricoh,rv5c387a", rtc_rv5c387a},
+       {},
+};

The current mechanism is simple string matching there are no platform
specific namespaces.

We could wrap the device tree style names in a macro that adds a
non-printable character to the front.

Something like this:
#define DT_NAMESPACE "\1"
#define DT_NAME(x) (DT_NAMESPACE x)
+       {DT_NAME("ricoh,rv5c386"), rtc_rv5c386},

And then modify the mpc i2c driver to insert the DT_NAMESPACE in front
of the string.

Another solution would be to make the names disappear on non-device
tree platforms

in mod_devicetable.h:
#ifdef USING_DEVICE_TREES
#define DT_NAME(x) x
#else
#define DTNAME(x)
#endif

+static struct i2c_device_id rs5c372_id[] = {
+       {"rtc-rs5c372", rtc_rs5c372a},
+       {"rs5c372a", rtc_rs5c372a},
+       {"rs5c372b", rtc_rs5c372b},
+       {"rv5c386", rtc_rv5c386},
+       {"rv5c387a", rtc_rv5c387a},
+       DT_NAME({"ricoh,rs5c372a", rtc_rs5c372a},)
+       DT_NAME({"ricoh,rs5c372b", rtc_rs5c372b},)
+       DT_NAME({"ricoh,rv5c386", rtc_rv5c386},)
+       DT_NAME({"ricoh,rv5c387a", rtc_rv5c387a},)
+       {},

But what's the point in making these names specific to device trees?
They are perfectly valid names for the devices that could be used from
any platform.

-- 
Jon Smirl
jonsmirl@gmail.com
