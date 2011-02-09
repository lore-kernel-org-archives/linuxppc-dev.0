Return-Path: <dmitry.torokhov@gmail.com>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4E759B7124
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Feb 2011 10:42:41 +1100 (EST)
Received: by gxk21 with SMTP id 21so363281gxk.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 09 Feb 2011 15:42:37 -0800 (PST)
Date: Wed, 9 Feb 2011 15:42:31 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
Subject: Re: [PATCH 1/2] misc: add CARMA DATA-FPGA Access Driver
Message-ID: <20110209234231.GA5707@core.coreip.homeip.net>
References: <1297208267-27087-1-git-send-email-iws@ovro.caltech.edu>
	<1297208267-27087-2-git-send-email-iws@ovro.caltech.edu>
	<20110209083325.GA7256@core.coreip.homeip.net>
	<20110209173532.GB21766@ovro.caltech.edu>
	<20110209182740.GC23867@core.coreip.homeip.net>
	<20110209233544.GA5303@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110209233544.GA5303@ovro.caltech.edu>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 09, 2011 at 03:35:45PM -0800, Ira W. Snyder wrote:
> On Wed, Feb 09, 2011 at 10:27:40AM -0800, Dmitry Torokhov wrote:
> 
> [ snip stuff I've already fixed in the next version ]
> 
> > > 
> > > The requirement is that the device stay open during reconfiguration.
> > > This provides for that. Readers just block for as long as the device is
> > > not producing data.
> > 
> > OK, you still need to make sure you do not touch free/used buffer while
> > device is disabled. Also, you need to kick readers if you unbind the
> > driver, so maybe a new flag priv->exists should be introduced and
> > checked.
> > 
> 
> I don't understand what you mean by "kick readers if you unbind the
> driver". The kernel automatically increases the refcount on a module
> when a process is using the module. This shows up in the "Used by"
> column of lsmod's output.
> 
> The kernel will not let you rmmod a module with a non-zero refcount. You
> cannot get into the situation where you have rmmod'ed the module and a
> reader is still blocking in read()/poll().

However you can still unbind the driver from the device by writing into
driver's sysfs 'unbind' attribute.

See drivers/base/bus.c::driver_unbind().

Thanks.

-- 
Dmitry
