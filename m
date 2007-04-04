Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id E2CEBDDECC
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Apr 2007 05:58:04 +1000 (EST)
Date: Wed, 04 Apr 2007 12:58:03 -0700 (PDT)
Message-Id: <20070404.125803.35507943.davem@davemloft.net>
To: rmk+lkml@arm.linux.org.uk
Subject: Re: [PATCH] Stop pmac_zilog from abusing 8250's device numbers.
From: David Miller <davem@davemloft.net>
In-Reply-To: <20070404090016.GC13134@flint.arm.linux.org.uk>
References: <20070404083803.GA13134@flint.arm.linux.org.uk>
	<20070404.014330.91315500.davem@davemloft.net>
	<20070404090016.GC13134@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org,
	dwmw2@infradead.org, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Russell King <rmk+lkml@arm.linux.org.uk>
Date: Wed, 4 Apr 2007 10:00:16 +0100

> On Wed, Apr 04, 2007 at 01:43:30AM -0700, David Miller wrote:
> > Well the "bad hack" we use on sparc gives usable serial ports,
> > properly ordered and using /dev/ttyS0, with a proper matching
> > console selection.
> 
> Well yes, but it seems to have code in the architecture's early
> command line parsing to parse the "console=" argument to set this
> magical "serial_console" variable.
> 
> Is this an approach you recommend for all architectures?

The platform should use whatever is appropriate, and matches
firmware/bios/whatever conventions, to determine this stuff.

On Sparc you get an openfirmware environment variable called
"output-device" that can point to a framebuffer or serial
console device.

The user can override this on the kernel command line, of course, and
what they ask for will get translated properly.
