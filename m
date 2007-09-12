Return-Path: <rsc@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EC292DDDFC
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 15:32:18 +1000 (EST)
Date: Wed, 12 Sep 2007 07:32:07 +0200
From: Robert Schwebel <r.schwebel@pengutronix.de>
To: Heiko Schocher <hs@denx.de>
Message-ID: <20070912053207.GH23573@pengutronix.de>
References: <1189503798.6674.46.camel@Zeus.EmbLux>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <1189503798.6674.46.camel@Zeus.EmbLux>
Subject: Re: SYSFS: need a noncaching read
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	Detlev Zundel <dzu@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 11, 2007 at 11:43:17AM +0200, Heiko Schocher wrote:
> I have developed a device driver and use the sysFS to export some
> registers to userspace.

Uuuh, uggly. Don't do that. Device drivers are there to abstract things,
not to play around with registers from userspace.

> I opened the sysFS File for one register and did some reads from this
> File, but I alwas becoming the same value from the register, whats not
> OK, because they are changing. So I found out that the sysFS caches
> the reads ... :-(

Yes, it does. What you can do is close()ing the file handle between
accesses, which makes it work but is slow.

> Is there a way to retrigger the reads (in that way, that the sysFS
> rereads the values from the driver), without closing and opening the
> sysFS Files? Or must I better use the ioctl () Driver-interface for
> exporting these registers?

What kind of problem do you want to solve? Userspace is for
applications, and applications usually don't have to know about hardware
details like registers. So if you have to do something every 10 ms from
userspace, your design is probably wrong.

If you absolutely need to do such things from userspace, have a look at
uio. But in most cases the answer is: make a proper abstraction for the
problem you wanna solve and write a proper driver.

Robert
-- 
Pengutronix - Linux Solutions for Science and Industry
Entwicklungszentrum Nord     http://www.pengutronix.de
