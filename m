Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 64EECB70EA
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Feb 2011 11:11:00 +1100 (EST)
Date: Wed, 9 Feb 2011 16:10:55 -0800
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] misc: add CARMA DATA-FPGA Access Driver
Message-ID: <20110210001055.GB5303@ovro.caltech.edu>
References: <1297208267-27087-1-git-send-email-iws@ovro.caltech.edu>
	<1297208267-27087-2-git-send-email-iws@ovro.caltech.edu>
	<20110209083325.GA7256@core.coreip.homeip.net>
	<20110209173532.GB21766@ovro.caltech.edu>
	<20110209182740.GC23867@core.coreip.homeip.net>
	<20110209233544.GA5303@ovro.caltech.edu>
	<20110209234231.GA5707@core.coreip.homeip.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110209234231.GA5707@core.coreip.homeip.net>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 09, 2011 at 03:42:31PM -0800, Dmitry Torokhov wrote:
> On Wed, Feb 09, 2011 at 03:35:45PM -0800, Ira W. Snyder wrote:
> > On Wed, Feb 09, 2011 at 10:27:40AM -0800, Dmitry Torokhov wrote:
> > 
> > [ snip stuff I've already fixed in the next version ]
> > 
> > > > 
> > > > The requirement is that the device stay open during reconfiguration.
> > > > This provides for that. Readers just block for as long as the device is
> > > > not producing data.
> > > 
> > > OK, you still need to make sure you do not touch free/used buffer while
> > > device is disabled. Also, you need to kick readers if you unbind the
> > > driver, so maybe a new flag priv->exists should be introduced and
> > > checked.
> > > 
> > 
> > I don't understand what you mean by "kick readers if you unbind the
> > driver". The kernel automatically increases the refcount on a module
> > when a process is using the module. This shows up in the "Used by"
> > column of lsmod's output.
> > 
> > The kernel will not let you rmmod a module with a non-zero refcount. You
> > cannot get into the situation where you have rmmod'ed the module and a
> > reader is still blocking in read()/poll().
> 
> However you can still unbind the driver from the device by writing into
> driver's sysfs 'unbind' attribute.
> 
> See drivers/base/bus.c::driver_unbind().
> 

I was completely unaware of that "feature". I hunch that many drivers
are incapable of dealing with an unbind while they are still open.

Matter of fact, I don't see how this can EVER be safe. The driver core
automatically calls the data_of_remove() routine while there are still
blocked readers. This kfree()s the private data structure, which
contains the suggested priv->exists flag. What happens if the memory
allocator re-allocates that memory to a different driver before the
reader process is woken up to check the priv->exists flag?

The only way to solve this is to count the number of open()s and
close()s, and block the unbind until all users have close()d the device.

Thanks,
Ira
