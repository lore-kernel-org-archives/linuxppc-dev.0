Return-Path: <david-b@pacbell.net>
Received: from smtp120.sbc.mail.sp1.yahoo.com (smtp120.sbc.mail.sp1.yahoo.com
	[69.147.64.93]) by ozlabs.org (Postfix) with SMTP id 80280DDF10
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Jun 2008 14:08:18 +1000 (EST)
From: David Brownell <david-b@pacbell.net>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/4] spi: split up spi_new_device() to allow two stage
	registration.
Date: Sun, 29 Jun 2008 21:08:15 -0700
References: <20080516193054.28030.35126.stgit@trillian.secretlab.ca>
	<fa686aa40805232343x20031560j5659d203e25f494@mail.gmail.com>
	<fa686aa40805232354g147acfcdx4753fce1a448ceb7@mail.gmail.com>
In-Reply-To: <fa686aa40805232354g147acfcdx4753fce1a448ceb7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200806292108.15909.david-b@pacbell.net>
Cc: linuxppc-dev@ozlabs.org, fabrizio.garetto@gmail.com,
	linux-kernel@vger.kernel.org, spi-devel-general@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 23 May 2008, Grant Likely wrote:
> Question:  spi_alloc_device() (and the original code) does a
> spi_master_get() on the spi_master device.  Doesn't spi_master_put()
> need to be called when the device is discarded?  spi_dev_put() doesn't
> do that explicitly; is it an implicit operation after a device has
> been deregistered from the spi_master?

Depends whether or not the add() has been done to hook things into
the driver model tree, as I recall.  The add() presumes things are
properly refcounted.  When you make a driver model tree node vanish,
its associated refcounts get updated too.

- Dave
