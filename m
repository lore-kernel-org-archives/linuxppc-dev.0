Return-Path: <david-b@pacbell.net>
Received: from smtp105.sbc.mail.mud.yahoo.com (smtp105.sbc.mail.mud.yahoo.com
	[68.142.198.204]) by ozlabs.org (Postfix) with SMTP id 13FBADDFA5
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 13:45:09 +1000 (EST)
From: David Brownell <david-b@pacbell.net>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH 3/4] spi: Add OF binding support for SPI busses
Date: Wed, 21 May 2008 18:16:10 -0700
References: <20080516193054.28030.35126.stgit@trillian.secretlab.ca>
	<20080516224916.GA16702@zarina>
	<fa686aa40805162202m336aade4qd6cfa5b17d6f3892@mail.gmail.com>
In-Reply-To: <fa686aa40805162202m336aade4qd6cfa5b17d6f3892@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200805211816.10753.david-b@pacbell.net>
Cc: linuxppc-dev@ozlabs.org, spi-devel-general@lists.sourceforge.net,
	fabrizio.garetto@gmail.com, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 16 May 2008, Grant Likely wrote:
> In my mind; platform_data and the device tree are all about the same
> thing: representation.  In other words, how to describe the
> configuration of the hardware independent of the driver itself.

Platform_data isn't what I'd call independent of drivers.

The reason the data is there in the first place is that
the driver needs it ... and chose not to hard-wire it.


> One of the things I find rather interesting is just how frequently
> drivers using platform data structures have a big block of code which
> simply copy pdata fields into identically named fields in the device
> private data... 

... because platform data was designed as a partial template
for that driver, letting it do that.  (Sometimes without even
doing scale conversions.)  As drivers grow functionally, they
sometimes end up needing more platform data fields, to expose
data that previously didn't matter.

Whether that data can usefully be stored in flash (or ROM)
and handed out through the bootloader is something of a
manufacturing issue.

- Dave
