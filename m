Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8351ADDE2C
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Jan 2007 02:41:40 +1100 (EST)
In-Reply-To: <20070115110509.GA25974@localhost.localdomain>
References: <528646bc0701131555n3249b503i3b6e8c37db41dd52@mail.gmail.com>
	<528646bc0701141429q577f87f1oe65aa7033c09b62b@mail.gmail.com>
	<20070115110509.GA25974@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <5378f4dcd28423047dc3cfb1404f08e1@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Discussion on SOC device tree bindings
Date: Mon, 15 Jan 2007 16:42:18 +0100
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	Sven Luther <sven@genesi-usa.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> How about always specifying the exact name and only the exact name
> in the device tree, i.e. mpc5200-fec on mpc5200, mpc5200b-fec on
> mpc5200b and so on.

No :-)

> This way the driver can decide whether or not it's
> compatible to a device

It already can.

> and we can be sure not to overlook any
> incompatibilities. We could even decide in later kernel versions that
> two devices are too incompatible and split the driver into two.

You can already; say you have a driver that will only work
on 5200b, is will match on that, and the "plain" 5200 driver
won't get a chance to grab the device.  You have to match
for the most specific first, of course.

> There may be incompatibilities between 5200 and 5200b which we simply 
> did
> not discover yet.

If that is so, than such a 5200b-specific driver can be
created (possibly just as some special cases in the
existing 5200 driver).

Listing something in the "compatible" property doesn't mean
the device is 100% compatible, just that it's mostly compatible.
Earlier entries in there are "more compatible" ;-)


Segher
