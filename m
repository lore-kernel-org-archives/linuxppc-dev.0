Return-Path: <david-b@pacbell.net>
Received: from smtp115.sbc.mail.sp1.yahoo.com (smtp115.sbc.mail.sp1.yahoo.com
	[69.147.64.88]) by ozlabs.org (Postfix) with SMTP id E2A80DDEE7
	for <linuxppc-dev@ozlabs.org>; Sun, 25 Nov 2007 06:39:26 +1100 (EST)
From: David Brownell <david-b@pacbell.net>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/5] USB: Add Cypress c67x00 low level interface code
Date: Sat, 24 Nov 2007 11:39:23 -0800
References: <20071124001203.25361.99294.stgit@trillian.cg.shawcable.net>
	<20071124002436.25361.50445.stgit@trillian.cg.shawcable.net>
In-Reply-To: <20071124002436.25361.50445.stgit@trillian.cg.shawcable.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200711241139.23803.david-b@pacbell.net>
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, gregkh@suse.de,
	linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 23 November 2007, Grant Likely wrote:
> +/* These functions could also be implemented with SPI of HSS.
> + * This is currently not supported */

Give that this "HPI" interface seems to use a parallel bus
with irq-safe synchronous accesses, and SPI is a serial bus
where synchronous accesses can't be done in IRQ context ...
that comment doesn't seem accurate.

Surely a more correct statement would be that while the chip
can also be accessed using SPI, that would require updating
the driver structure to stop assuming register accesses can
always be done from IRQ context?

If that's not the case, then those spinlocks are overkill,
and they should become mutexes.  :)

- Dave
