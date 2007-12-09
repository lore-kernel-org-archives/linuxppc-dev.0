Return-Path: <jonsmirl@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.179])
	by ozlabs.org (Postfix) with ESMTP id BCC28DDDF7
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Dec 2007 08:46:20 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so3114174wag
	for <linuxppc-dev@ozlabs.org>; Sun, 09 Dec 2007 13:46:19 -0800 (PST)
Message-ID: <9e4733910712091346vb09ce54s2d56838ca34a9ca1@mail.gmail.com>
Date: Sun, 9 Dec 2007 16:46:19 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: benh@kernel.crashing.org
Subject: Re: [i2c] [PATCH 0/4] Series to add device tree naming to i2c
In-Reply-To: <1197236326.6563.22.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071203212032.23543.3453.stgit@terra.home>
	<9e4733910712091224mcb43f0ci69f578d221505ba7@mail.gmail.com>
	<1197233208.6563.14.camel@pasglop>
	<9e4733910712091257x4ba5e07aue55934fb6898aa2d@mail.gmail.com>
	<1197234799.6563.19.camel@pasglop>
	<9e4733910712091335g534d9248gcd920850f9f679a1@mail.gmail.com>
	<1197236326.6563.22.camel@pasglop>
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

The "rs5c372a" is unrelated to the device tree changes. In the
existing i2c driver code the driver is named rtc-rs5c372. But this
driver supports five different devices. A secondary i2c parameter
(driver_name, name) is used to tell the rtc-rs5c372 driver that it is
being loaded for use on a rs5c372a, rv5c387a, etc. When I fixed i2c to
support device tree name aliases I also fixed it to use kernel
aliasing to support these drivers that support multiple devices.

>
> I would argue that we should keep only the later...
>
> Cheers,
> Ben.
>
>
>


-- 
Jon Smirl
jonsmirl@gmail.com
