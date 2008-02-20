Return-Path: <greg@kroah.com>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 73078DDDEF
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Feb 2008 05:36:10 +1100 (EST)
Date: Wed, 20 Feb 2008 10:29:53 -0800
From: Greg KH <greg@kroah.com>
To: David Brownell <david-b@pacbell.net>
Subject: Re: [patch v7 3/4] USB: add Cypress c67x00 OTG controller HCD driver
Message-ID: <20080220182953.GA13037@kroah.com>
References: <20080219150916.263032000@sunsite.dk>
	<874pc3efbx.fsf@macbook.be.48ers.dk>
	<20080220170300.GB3453@kroah.com>
	<200802201007.01907.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200802201007.01907.david-b@pacbell.net>
Cc: dbrownell@users.sourceforge.net, linux-usb@vger.kernel.org,
	linuxppc-dev@ozlabs.org, stern@rowland.harvard.edu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Feb 20, 2008 at 10:07:01AM -0800, David Brownell wrote:
> On Wednesday 20 February 2008, Greg KH wrote:
> > > ?Greg> Can you move the files under the hcd/ subdir
> > 
> > Oops, I ment "host/" not, "hcd/".
> > 
> > > Sorry, I don't think that's a good idea as the hardware can do
> > > peripheral as well, and as you can see in patch 4, a gadget driver is
> > > on it's way.
> > 
> > Ok, that's fine, why can't the gadget stuff go into the gadget/
> > directory then also? ?As this device is a host controller, it makes
> > sense to me to keep it in the host-controller subdirectory.
> 
> FWIW we did the same thing with drivers/usb/musb (for the Mentor
> highspeed OTG core) ... the basic issue is that the host and
> peripheral sides of the hardware aren't split like that.  There
> would be lots of code sharing (FIFO access, IRQ handling, DMA,
> initialization, come quickly to mind) between HCD and gadget
> sides.  Enough that trying to create an artificial split between
> those -- and let it coordinate properly in OTG modes -- seemed
> like a waste of effort.

Ah, but I don't see that directory in the current tree on kernel.org, so
I haven't see this kind of driver before :)

And isn't the whole OTG code base still in flux as to where it lives?
Or so I thought a thread last week showed.

thanks,

greg k-h
