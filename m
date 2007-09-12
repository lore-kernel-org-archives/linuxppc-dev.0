Return-Path: <greg@kroah.com>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D117CDDE46
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 21:39:32 +1000 (EST)
Date: Wed, 12 Sep 2007 04:39:07 -0700
From: Greg KH <greg@kroah.com>
To: Heiko Schocher <hs@denx.de>
Subject: Re: SYSFS: need a noncaching read
Message-ID: <20070912113907.GA24087@kroah.com>
References: <1189503798.6674.46.camel@Zeus.EmbLux>
	<20070912053207.GH23573@pengutronix.de>
	<20070912100123.GA23182@kroah.com>
	<1189595612.6659.23.camel@Zeus.EmbLux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1189595612.6659.23.camel@Zeus.EmbLux>
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

On Wed, Sep 12, 2007 at 01:13:32PM +0200, Heiko Schocher wrote:
> Hello Greg
> 
> Am Mittwoch, den 12.09.2007, 03:01 -0700 schrieb Greg KH:
> > On Wed, Sep 12, 2007 at 07:32:07AM +0200, Robert Schwebel wrote:
> > > On Tue, Sep 11, 2007 at 11:43:17AM +0200, Heiko Schocher wrote:
> > > > I have developed a device driver and use the sysFS to export some
> > > > registers to userspace.
> > > 
> > > Uuuh, uggly. Don't do that. Device drivers are there to abstract things,
> > > not to play around with registers from userspace.
> > > 
> > > > I opened the sysFS File for one register and did some reads from this
> > > > File, but I alwas becoming the same value from the register, whats not
> > > > OK, because they are changing. So I found out that the sysFS caches
> > > > the reads ... :-(
> > > 
> > > Yes, it does. What you can do is close()ing the file handle between
> > > accesses, which makes it work but is slow.
> > 
> > Do an lseek back to 0 and then re-read, you will get called in your
> > driver again.
> 
> No thats not true. I thought this too, but if I make a:
> 
> seek (fd, 0L, SEEK_SET);
> 
> in Userspace, there is no retrigger in the sysFS, my driver is *not*
> called again. So I made a own sysfs_seek function, which does retrigger
> the driver ...

Hm, are you sure?  Otherwise the poll() stuff would not work at all.

> Is this really wanted in the sysFS, that there is no way to retrigger a
> read?

Yes, use the sysfs poll/select stuff to do that.

And "sysfs" has no upper-case letters :)

thanks,

greg k-h
