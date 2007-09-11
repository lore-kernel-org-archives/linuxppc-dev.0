Return-Path: <nickpiggin@yahoo.com.au>
Received: from smtp109.mail.mud.yahoo.com (smtp109.mail.mud.yahoo.com
	[209.191.85.219]) by ozlabs.org (Postfix) with SMTP id 0CD67DDD0A
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Sep 2007 03:49:30 +1000 (EST)
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Greg KH <greg@kroah.com>
Subject: Re: SYSFS: need a noncaching read
Date: Wed, 12 Sep 2007 05:19:39 +1000
References: <1189503798.6674.46.camel@Zeus.EmbLux>
	<20070912053207.GH23573@pengutronix.de>
	<20070912100123.GA23182@kroah.com>
In-Reply-To: <20070912100123.GA23182@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709120519.39960.nickpiggin@yahoo.com.au>
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

On Wednesday 12 September 2007 20:01, Greg KH wrote:
> On Wed, Sep 12, 2007 at 07:32:07AM +0200, Robert Schwebel wrote:
> > On Tue, Sep 11, 2007 at 11:43:17AM +0200, Heiko Schocher wrote:
> > > I have developed a device driver and use the sysFS to export some
> > > registers to userspace.
> >
> > Uuuh, uggly. Don't do that. Device drivers are there to abstract things,
> > not to play around with registers from userspace.
> >
> > > I opened the sysFS File for one register and did some reads from this
> > > File, but I alwas becoming the same value from the register, whats not
> > > OK, because they are changing. So I found out that the sysFS caches
> > > the reads ... :-(
> >
> > Yes, it does. What you can do is close()ing the file handle between
> > accesses, which makes it work but is slow.
>
> Do an lseek back to 0 and then re-read, you will get called in your
> driver again.

Can you do a pread with offset 0 to avoid the two syscalls? (which some
people seem to be concerned about)
