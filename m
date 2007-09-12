Return-Path: <greg@kroah.com>
Received: from canuck.infradead.org (canuck.infradead.org [209.217.80.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8B118DDDF3
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 20:01:35 +1000 (EST)
Date: Wed, 12 Sep 2007 03:01:23 -0700
From: Greg KH <greg@kroah.com>
To: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: SYSFS: need a noncaching read
Message-ID: <20070912100123.GA23182@kroah.com>
References: <1189503798.6674.46.camel@Zeus.EmbLux>
	<20070912053207.GH23573@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070912053207.GH23573@pengutronix.de>
Cc: linuxppc-dev@ozlabs.org, Heiko Schocher <hs@denx.de>,
	linux-kernel@vger.kernel.org, Detlev Zundel <dzu@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Sep 12, 2007 at 07:32:07AM +0200, Robert Schwebel wrote:
> On Tue, Sep 11, 2007 at 11:43:17AM +0200, Heiko Schocher wrote:
> > I have developed a device driver and use the sysFS to export some
> > registers to userspace.
> 
> Uuuh, uggly. Don't do that. Device drivers are there to abstract things,
> not to play around with registers from userspace.
> 
> > I opened the sysFS File for one register and did some reads from this
> > File, but I alwas becoming the same value from the register, whats not
> > OK, because they are changing. So I found out that the sysFS caches
> > the reads ... :-(
> 
> Yes, it does. What you can do is close()ing the file handle between
> accesses, which makes it work but is slow.

Do an lseek back to 0 and then re-read, you will get called in your
driver again.

Not that this is a good thing to do for this kind of thing, as others
have already said.

thanks,

greg k-h
