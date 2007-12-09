Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 08A01DDDFF
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Dec 2007 08:41:16 +1100 (EST)
Subject: Re: [i2c] [PATCH 0/4] Series to add device tree naming to i2c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910712091335g534d9248gcd920850f9f679a1@mail.gmail.com>
References: <20071203212032.23543.3453.stgit@terra.home>
	<9e4733910712091224mcb43f0ci69f578d221505ba7@mail.gmail.com>
	<1197233208.6563.14.camel@pasglop>
	<9e4733910712091257x4ba5e07aue55934fb6898aa2d@mail.gmail.com>
	<1197234799.6563.19.camel@pasglop>
	<9e4733910712091335g534d9248gcd920850f9f679a1@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 10 Dec 2007 08:38:46 +1100
Message-Id: <1197236326.6563.22.camel@pasglop>
Mime-Version: 1.0
Cc: Jean Delvare <khali@linux-fr.org>, linuxppc-dev@ozlabs.org,
	i2c@lm-sensors.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> +static struct i2c_device_id rs5c372_id[] = {
> +       {"rtc-rs5c372", rtc_rs5c372a},
> +       {"rs5c372a", rtc_rs5c372a},
> +       {"rs5c372b", rtc_rs5c372b},
> +       {"rv5c386", rtc_rv5c386},
> +       {"rv5c387a", rtc_rv5c387a},
> +       DT_NAME({"ricoh,rs5c372a", rtc_rs5c372a},)
> +       DT_NAME({"ricoh,rs5c372b", rtc_rs5c372b},)
> +       DT_NAME({"ricoh,rv5c386", rtc_rv5c386},)
> +       DT_NAME({"ricoh,rv5c387a", rtc_rv5c387a},)
> +       {},
> 
> But what's the point in making these names specific to device trees?
> They are perfectly valid names for the devices that could be used from
> any platform.

The more I think about it, the more I tend to agree that tagging isn't
necessary and you are right. We should just match the name against the
"compatible" property of the OF nodes (which mean we need to support
multiple matches though since "compatible" is a list of strings).

Now, I have a question about your example: Why do you have both
"rs5c372a" and "ricoh,rs5c372a" ?

I would argue that we should keep only the later...

Cheers,
Ben.
