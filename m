Return-Path: <david-b@pacbell.net>
Received: from smtp105.sbc.mail.mud.yahoo.com (smtp105.sbc.mail.mud.yahoo.com
	[68.142.198.204]) by ozlabs.org (Postfix) with SMTP id A7FF8DDE01
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Dec 2007 10:25:26 +1100 (EST)
From: David Brownell <david-b@pacbell.net>
To: Arnd Bergmann <arnd@arndb.de>,
 avorontsov@ru.mvista.com
Subject: Re: CPM2 USB host driver
Date: Fri, 30 Nov 2007 15:18:42 -0800
References: <200711301145.52926.laurentp@cse-semaphore.com>
	<20071130161136.GA27760@localhost.localdomain>
	<200711302332.21864.arnd@arndb.de>
In-Reply-To: <200711302332.21864.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200711301518.43044.david-b@pacbell.net>
Cc: linuxppc-dev@ozlabs.org, gregkh@suse.de,
	linux-usb-devel@lists.sourceforge.net, mike@compulab.co.il
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 30 November 2007, Arnd Bergmann wrote:
> 6100 lines means it's still the second-largest hcd driver in the kernel,
> only drivers/usb/host/u132-hcd.c has even more.

~/kernel/g26/drivers/usb/host$ wc -l ohci*[hc] |grep total
  9485 total
~/kernel/g26/drivers/usb/host$ wc -l ehci*[hc] |grep total
  8709 total
~/kernel/g26/drivers/usb/host$ wc -l uhci*[hc] |grep total
  4211 total
~/kernel/g26/drivers/usb/host$ wc -l sl811*[hc] |grep total
 2472 total
~/kernel/g26/drivers/usb/host$ 

Of course a lot of the OHCI stuff is various flavors of bus glue
(with more in the queue).  And for one nyet-merged driver:

~/kernel/omap-2.6/drivers/usb/musb$ wc -l *[hc] |  grep total
 15223 total
~/kernel/omap-2.6/drivers/usb/musb$ 

That's an OTG driver so it includes both host and peripheral
sides, plus currently bus glue for three different chunks of
silicon (DaVinci, OMAP, TUSB6010 ... Blackfin on the way)
with three different DMA engines (sigh).

So it's not that big; larger than UHCI or sl811-hcd though.  ;)


> My experience with other drivers moved into the kernel is that you
> end up rewriting it completely anyway. I can also recommend starting
> from scratch, and taking one of the in-kernel drivers as an example.

Start-from-scratch vs Incremental-rewrite ... there are advantages
to each approach.


> Maybe Greg or David can give you a suggestion which one of them
> serves as the best example for a new host driver.

I don't even know what a CPM2 is, or what kind of host it has.
(Wasn't CPM the predecessor of MS-DOS?)

Suggestions would be futile.

- Dave
