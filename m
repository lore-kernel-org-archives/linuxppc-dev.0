Return-Path: <greg@kroah.com>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 05A1DDDE17
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Dec 2007 08:38:36 +1100 (EST)
Date: Wed, 5 Dec 2007 13:41:03 -0800
From: Greg KH <greg@kroah.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: drivers/net/iseries_veth.c dubious sysfs usage
Message-ID: <20071205214103.GA7074@kroah.com>
References: <20071205093054.GA23229@kroah.com>
	<1196853031.6759.7.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1196853031.6759.7.camel@concordia>
Cc: linuxppc-dev@ozlabs.org, "Kyle A. Lucke" <klucke@us.ibm.com>,
	paulus@samba.org, linux-kernel@vger.kernel.org,
	David Gibson <dwg@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Dec 05, 2007 at 10:10:31PM +1100, Michael Ellerman wrote:
> On Wed, 2007-12-05 at 01:30 -0800, Greg KH wrote:
> > In doing a massive kobject cleanup of the kernel tree, I ran across the
> > iseries_veth.c driver.
> > 
> > It looks like the driver is creating a number of subdirectories under
> > the driver sysfs directory.  This is odd and probably wrong.  You want
> > these virtual connections to show up in the main sysfs device tree, not
> > under the driver directory.
> > 
> > I'll be glad to totally guess and try to move it around in the sysfs
> > tree, but odds are I'll get it all wrong as I can't really test this
> > out :)
> > 
> > Any hints on what this driver is trying to do in this sysfs directories?
> 
> I wrote the code, I think, but it's been a while - I'll have a look at
> it tomorrow.

Yes, can you send me the sysfs tree output of the driver directory, and
what exactly the different files in there are supposed to be used for?

> Why is it "odd and probably wrong" to create subdirectories under the
> driver in sysfs?

Because a driver does not have "devices" under it in the sysfs tree.
All devices liven in the /sys/devices/ tree so we can properly manage
them that way.  A driver will then bind to a device, and the driver core
will set up the linkages in sysfs properly so that everthing looks
uniform.

By creating subdirectories associated with a driver, this breaks the
model that the entire rest of the kernel is using, which is something
that you really don't want to be doing :)

How about describing what you were trying to achieve with these
directories and files?

thanks,

greg k-h
