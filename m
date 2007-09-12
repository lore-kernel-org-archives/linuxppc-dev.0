Return-Path: <neilb@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F1E81DDDE9
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Sep 2007 03:58:39 +1000 (EST)
From: Neil Brown <neilb@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Date: Wed, 12 Sep 2007 19:57:13 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18152.10361.790323.494668@notabene.brown>
Subject: Re: SYSFS: need a noncaching read
In-Reply-To: message from Nick Piggin on Wednesday September 12
References: <1189503798.6674.46.camel@Zeus.EmbLux>
	<20070912053207.GH23573@pengutronix.de>
	<20070912100123.GA23182@kroah.com>
	<200709120519.39960.nickpiggin@yahoo.com.au>
Cc: Detlev Zundel <dzu@denx.de>, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Heiko Schocher <hs@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday September 12, nickpiggin@yahoo.com.au wrote:
> On Wednesday 12 September 2007 20:01, Greg KH wrote:
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
> Can you do a pread with offset 0 to avoid the two syscalls? (which some
> people seem to be concerned about)

No.
Looking in fs/sysfs/file.c, we notice the field "needs_read_fill" in
struct sysfs_buffer.

sysfs_read_file will only call fill_read_buffer  (which calls the
->show routine) if this is 1;

It is cleared by fill_read_buffer and set to 1:
 - at open
 - by fill_write_buffer (i.e. if you write to the file descriptor)
 - by sysfs_poll when an event was detected.

So currently you cannot simply open a sysfs file an read multiple
times.

One option would be to call fill_read_buffer if *ppos == 0.
I cannot see that being a problem in practice, but maybe there is a
reason why it wasn't done that way.
Another option might be to call fill_read_buffer also if 
	buffer->event != atomic_read(&attr_sd->s_event)
and require drivers to call sysfs_notify when they make a change that
should be noticed.  But I doubt that is really important.

NeilBrown
