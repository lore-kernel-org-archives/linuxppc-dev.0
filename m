Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 66DC6DE0E0
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Dec 2007 07:38:13 +1100 (EST)
Subject: Re: [i2c] [PATCH 0/4] Series to add device tree naming to i2c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910712101006s37829df4w676eea54a98b282d@mail.gmail.com>
References: <20071203212032.23543.3453.stgit@terra.home>
	<9e4733910712091224mcb43f0ci69f578d221505ba7@mail.gmail.com>
	<1197233208.6563.14.camel@pasglop>
	<9e4733910712091257x4ba5e07aue55934fb6898aa2d@mail.gmail.com>
	<1197234799.6563.19.camel@pasglop>
	<9e4733910712091335g534d9248gcd920850f9f679a1@mail.gmail.com>
	<1197236326.6563.22.camel@pasglop>
	<20071210164255.GA4497@loki.buserror.net>
	<9e4733910712101006s37829df4w676eea54a98b282d@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 11 Dec 2007 07:35:29 +1100
Message-Id: <1197318929.8692.10.camel@pasglop>
Mime-Version: 1.0
Cc: Jean Delvare <khali@linux-fr.org>, i2c@lm-sensors.org,
	linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2007-12-10 at 13:06 -0500, Jon Smirl wrote:
> 
> I can't see an easy way to do this. The basic problem is that the i2c
> drivers are assumed to be cross platform. I would need to add a path
> through the i2c core for getting a void pointer from the bus to the
> device But then when the device code gets this pointer it has no way
> of knowing what it was. Assuming the void is a pointer to an of_node
> would make the driver for the i2c device platform specific.

As I said, there's an arch data structure that can be added to -any-
struct device and that we use for, among others, an optional device tree
node pointer on ppc64. We should do that on ppc32 too (and will soon for
other reasons). In this case, the i2c core can be modified on powerpc so
that when it instanciate an i2c device from the device-tree, it fills
that field.

Some device drivers can have powerpc specific code that make good use of
that for things like calibration infos etc...

Ben.
