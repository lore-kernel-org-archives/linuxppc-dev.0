Return-Path: <david-b@pacbell.net>
Received: from smtp119.sbc.mail.sp1.yahoo.com (smtp119.sbc.mail.sp1.yahoo.com
	[69.147.64.92]) by ozlabs.org (Postfix) with SMTP id CE600DDED6
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Jun 2008 14:10:28 +1000 (EST)
From: David Brownell <david-b@pacbell.net>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/4] spi: split up spi_new_device() to allow two stage
	registration.
Date: Sun, 29 Jun 2008 21:10:25 -0700
References: <20080516193054.28030.35126.stgit@trillian.secretlab.ca>
	<fa686aa40805232343x20031560j5659d203e25f494@mail.gmail.com>
	<fa686aa40806170028t2ccb679k22d2d3cea793ebc1@mail.gmail.com>
In-Reply-To: <fa686aa40806170028t2ccb679k22d2d3cea793ebc1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200806292110.25793.david-b@pacbell.net>
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

On Tuesday 17 June 2008, Grant Likely wrote:
> >>> This patch splits the allocation and registration portions of code out
> >>> of spi_new_device() and creates three new functions; spi_alloc_device(),
> >>> spi_register_device(), and spi_device_release().
> >>
> >> I have no problem with the first two, but why the last?
> >>
> >> If the devices are always allocated by spi_alloc_device() as
> >> they should be -- probably through an intermediary -- the
> >> only public function necessary for that cleanup should be
> >> the existing spi_dev_put().
> >
> > Ah, okay.  I'm still a bit fuzzy on the device model conventions.
> > I'll remove that then.
> 
> I've dug into this some more.  spi_alloc_device only allocates the
> memory.  It doesn't call device_initialize() to initialize the kref.

Well, the driver model idiom is initialize() then add(), with
register() calls combining the two.  An alloc() is just a bit
outside those core idioms ...

But one alloc() example is platform_device_alloc(), which does
the device_initialize() call ... followed by platform_device_add().

The spi_new_device() call does a bunch of stuff beyond a register(),
but it also calls device_register().


> All of that behaviour is handled within device_register().  Therefore
> if a driver uses spi_alloc_device() and then if a later part of the
> initialization fails before spi_register_device() is called, then the
> alloc'd memory needs to be freed, but spi_dev_put() won't work because
> the kobj isn't set up so I need another function to handle freeing it
> in on a failure path.

I see ...

 
> Should I switch things around to do device_initialize() in the alloc
> function 

Yes.


> and call device_add() instead of device_register() in the 
> spi_register_device() function?

You should also rename it to spi_add_device(), since register()
calls always do the initialize() rather than having it done for
them in advance.  People rely on those names supporting that
pattern (as they should).


> Is that sufficient to make put_device() work?

Looks like it to me.  Calling device_initialize() will
do a kobject_init(), which is documented as requiring
a kobject_put() to clean up ... that's all put_device()
will ever do.

- Dave
