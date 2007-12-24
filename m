Return-Path: <greg@kroah.com>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6B8A7DDE34
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Dec 2007 16:01:03 +1100 (EST)
Date: Sun, 23 Dec 2007 21:01:13 -0800
From: Greg KH <greg@kroah.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: drivers/net/iseries_veth.c dubious sysfs usage
Message-ID: <20071224050113.GA10835@kroah.com>
References: <20071205093054.GA23229@kroah.com>
	<1196853031.6759.7.camel@concordia>
	<20071205214103.GA7074@kroah.com>
	<1196912898.14754.13.camel@concordia>
	<20071213070829.GA13764@kroah.com>
	<20071224135208.2a29ffc0.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071224135208.2a29ffc0.sfr@canb.auug.org.au>
Cc: linux-kernel@vger.kernel.org, David Gibson <dwg@au1.ibm.com>,
	linuxppc-dev@ozlabs.org, "Kyle A. Lucke" <klucke@us.ibm.com>,
	paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Dec 24, 2007 at 01:52:08PM +1100, Stephen Rothwell wrote:
> Hi Greg,
> 
> On Wed, 12 Dec 2007 23:08:29 -0800 Greg KH <greg@kroah.com> wrote:
> >
> > Hm, ok, it's odd as you are the only driver in the whole tree doing
> > something like this, but it seems semi-resonable, so I can't complain :)
> > 
> > I'll fix the core up to allow you to do this, thanks for the
> > explanation.
> 
> So if this "seems semi-reasonable", why was the result
> gregkh-driver-driver-add-driver_add_kobj-for-looney-iseries_veth-driver
> containing "Hopefully no one uses this function in the future and the
> iseries_veth driver authors come to their senses so I can remove this
> hack..." as part of its comment.  If you expect respect, you need to
> treat others the same way ...

Well, sarcasm doesn't come accross very easily in changelog comments it
seems :)

> If what the driver writers are doing is "looney" (in your opinion), then
> please describe a better way of doing what they are trying to do.
> Sometimes, if people have to abuse the infrastructure, it is possible that
> the infrastructure is lacking?

In thinking about this some more, no, I think you all are abusing the
infrastructure here.  This is the ONLY driver in the entire kernel tree
that thinks it is acceptable to hang kobjects off of the driver
structure.  For some reason, no one else does this either because they
never would think of doing such a thing, or that they are not as unique
as this driver.

So I take back the "semi-resonable" statement above.  Please prove to me
that:
	- it is ok to hang kobjects off of a driver when:
		- no userspace tool will ever be notified that they have
		  been created
		- no known userspace library knows how to find such
		  attributes (libsysfs can't do that last I looked, and
		  it's no longer maintained.)
		- there is no documentation in the Documentation/ABI/
		  explaining this usage.
	- this can not be just a easily expressed in debugfs, or some
	  other representation (netlink for configuration, configfs,
	  some other location in sysfs, a driver-specific filesystem,
	  etc.)
	- that there is a tool out there using this current interface.

I don't like this usage of sysfs as it is very abnormal, and we are
trying very hard to fix up the rough edges here, to:
	- make it easier to program to and not get things incorrect
	  within the kernel
	- present a unified, semi-sane interface that is documented well
	  to userspace so users don't get even madder then they
	  currently are.


thanks,

greg k-h
