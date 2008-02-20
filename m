Return-Path: <david-b@pacbell.net>
Received: from smtp118.sbc.mail.sp1.yahoo.com (smtp118.sbc.mail.sp1.yahoo.com
	[69.147.64.91]) by ozlabs.org (Postfix) with SMTP id CF1B0DDF38
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Feb 2008 05:20:54 +1100 (EST)
From: David Brownell <david-b@pacbell.net>
To: Greg KH <greg@kroah.com>
Subject: Re: [patch v7 3/4] USB: add Cypress c67x00 OTG controller HCD driver
Date: Wed, 20 Feb 2008 10:07:01 -0800
References: <20080219150916.263032000@sunsite.dk>
	<874pc3efbx.fsf@macbook.be.48ers.dk>
	<20080220170300.GB3453@kroah.com>
In-Reply-To: <20080220170300.GB3453@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200802201007.01907.david-b@pacbell.net>
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

On Wednesday 20 February 2008, Greg KH wrote:
> >  Greg> Can you move the files under the hcd/ subdir
> 
> Oops, I ment "host/" not, "hcd/".
> 
> > Sorry, I don't think that's a good idea as the hardware can do
> > peripheral as well, and as you can see in patch 4, a gadget driver is
> > on it's way.
> 
> Ok, that's fine, why can't the gadget stuff go into the gadget/
> directory then also?  As this device is a host controller, it makes
> sense to me to keep it in the host-controller subdirectory.

FWIW we did the same thing with drivers/usb/musb (for the Mentor
highspeed OTG core) ... the basic issue is that the host and
peripheral sides of the hardware aren't split like that.  There
would be lots of code sharing (FIFO access, IRQ handling, DMA,
initialization, come quickly to mind) between HCD and gadget
sides.  Enough that trying to create an artificial split between
those -- and let it coordinate properly in OTG modes -- seemed
like a waste of effort.

- Dave
