Date: Thu, 27 Jun 2002 10:41:44 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Anderson <scott_anderson@mvista.com>
Cc: Tom Rini <trini@kernel.crashing.org>,
	Armin Kuster <akuster@mvista.com>,
	linuxppc-embedded@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>
Subject: Re: Trivial cleanup in ocp_uart.c
Message-ID: <20020627004144.GR9087@zax>
References: <20020620073440.GC20689@zax> <20020620155026.GE16052@opus.bloom.county> <20020621005216.GH20689@zax> <20020621143903.GO16052@opus.bloom.county> <20020624074019.GA9087@zax> <3D19F965.86668872@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3D19F965.86668872@mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Jun 26, 2002 at 10:27:01AM -0700, Scott Anderson wrote:
>
> David Gibson wrote:
> > Basically there are two quite distinct approaches either of which
> > would make sense (for any given peripheral/bus type):
> >         a) Register each device as it is discovered.  Register each
> > driver as the appropriate module loads.  Whenever either event happens
> > the common code calls init or probe callbacks in a driver to connect
> > it to any devices of appropriate type.
> >         b) No registration.  When a driver loads, it searches for all
> > devices of appropriate type, and initializes each of them in turn.
> >
> > Examples of (a) include the new PCI interface, PCMCIA, and the 2.5
> > unified device model.  Examples of (b) include the old PCI interface
> > (pci_find_device()) and (some?/all?) non-PCI devices on OF machines
> > (e.g. Airport).
> >
> > Approach (a) is clearly needed to handle hotplug.  But that's not an
> > issue for OCPs (indeed device (not driver) registration will always be
> > degenerate) so either approach would do.  Frankly (a) seems overkill
> > for OCPs, but it does have the advantage of being easily integrated
> > into the unified device model.
>
> I wouldn't be quite so quick to dismiss the issue of hotplug from OCP.
> I have heard rumblings of people having FPGAs with on-chip processors
> wanting to reprogram the FPGAs on the fly with different sets of
> peripherals.

Eek, wibble.  It still seems somewhat unlikely to me that you'd be
changing the peripherals "on the fly" in a real life embedded
application.  Especially considering that reboots are likely to be
much less of an issue on an embedded system than on a big server.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
