Return-Path: <david-b@pacbell.net>
Received: from smtp124.sbc.mail.sp1.yahoo.com (smtp124.sbc.mail.sp1.yahoo.com
	[69.147.64.97]) by ozlabs.org (Postfix) with SMTP id D5352DE013
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Sep 2008 06:47:58 +1000 (EST)
From: David Brownell <david-b@pacbell.net>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: [PATCH 0/3] Patches to support QE USB Host Controller
Date: Wed, 24 Sep 2008 13:04:24 -0700
References: <20080808161717.GA19095@polina.dev.rtsoft.ru>
	<200808141415.42109.laurentp@cse-semaphore.com>
In-Reply-To: <200808141415.42109.laurentp@cse-semaphore.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200809241304.24878.david-b@pacbell.net>
Cc: Greg Kroah-Hartman <greg@kroah.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Li Yang <leoli@freescale.com>, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 14 August 2008, Laurent Pinchart wrote:
> 
> > David, could you bear with gpio_to_chip() exported function, just as
> > a stopgap for a proper api?
> 
> I need gpio_to_chip() (or another 'proper API') as well for RTS/CTS
> based flow control in the CPM/CPM2 UART driver. 

I'l still say "proper".  This should be straightforward; along
the lines of

	struct qe_pin {
		struct ... *qe_ports;	/* includes gpio_chip */
		unsigned offset;
	};

And instead of having the driver look up a "gpio" for such
non-GPIO usage, have it call something that sets up a qe_pin.
All that infrastructure exists already...

Then drivers can use calls which mux the pin into its "normal"
mode (QE function of some kind), or into its "gpio" mode.

The gpio number would be gpio_chip->base + offset, and the
gpio_chip is visible -- in a fully typesafe manner! -- from
the qe_ports structure.

No type-unsafe interfaces.  No confusion between roles of a
given pin.  No hidden assumption there's only one kind of GPIO
(backed by QE ports).  And ... no need to change any core
structural assumptions of the GPIO framework.

- Dave
