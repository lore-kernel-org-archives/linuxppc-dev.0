Date: Tue, 12 Aug 2003 14:54:20 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Gary Thomas <gary@mlbassoc.com>
Cc: Dan Malek <dan@embeddededge.com>,
	linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Build issues with 2.6.0-test3
Message-ID: <20030812215420.GN807@ip68-0-152-218.tc.ph.cox.net>
References: <3F33BC10.8060407@imc-berlin.de> <3F33EADE.4010908@embeddededge.com> <3F38DEC4.8050708@imc-berlin.de> <1060696614.31273.419.camel@hermes> <20030812152503.GK807@ip68-0-152-218.tc.ph.cox.net> <1060702819.31273.534.camel@hermes> <20030812154642.GL807@ip68-0-152-218.tc.ph.cox.net> <1060715616.31273.759.camel@hermes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1060715616.31273.759.camel@hermes>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Aug 12, 2003 at 01:13:37PM -0600, Gary Thomas wrote:
> On Tue, 2003-08-12 at 09:46, Tom Rini wrote:
> > On Tue, Aug 12, 2003 at 09:40:20AM -0600, Gary Thomas wrote:
> > > On Tue, 2003-08-12 at 09:25, Tom Rini wrote:
> > > > On Tue, Aug 12, 2003 at 07:56:55AM -0600, Gary Thomas wrote:
> > > > > Index: arch/ppc/8260_io/uart.c
> > > > > ===================================================================
> > > > > RCS file: /home/gthomas/my_cvs/develop/linuxppc-2.5/arch/ppc/8260_io/uart.c,v
> > > > > retrieving revision 1.1
> > > > > diff -u -5 -p -r1.1 uart.c
> > > > > --- arch/ppc/8260_io/uart.c	12 Aug 2003 12:18:15 -0000	1.1
> > > > > +++ arch/ppc/8260_io/uart.c	12 Aug 2003 13:30:40 -0000
> > > > > @@ -2389,11 +2389,11 @@ void kgdb_map_scc(void)
> > > > >  	up->smc_mrblr = RX_BUF_SIZE;		/* receive buffer length */
> > > > >  	up->smc_maxidl = RX_BUF_SIZE;
> > > > >  }
> > > > >  #endif
> > > > >
> > > > > -static kdev_t serial_console_device(struct console *c)
> > > > > +static struct tty_driver *serial_console_device(struct console *c, int *index)
> > > > >  {
> > > > >  	*index = c->index;
> > > > >  	return serial_driver;
> > > > >  }
> > > >
> > > > After looking at the similar code in drivers/serial, I don't think this
> > > > is sufficient.  But I didn't dig too far into seee what c->data was
> > > > there.
> > >
> > > It seems to be [virtually] the same as in
> > >   arch/ppc/8xx_io/uart.c
> > >   drivers/char/amiserial.c
> > >   drivers/char/serial_tx3912.c
> > >   drivers/char/sh-sci.c
> > >   drivers/macintosh/macserial.c
> >
> > Those are all of the obsolete, and probably broken drivers.
> > drivers/serial is where all of the 'new' and working serial drivers are.
> > If you've got some time, the 8260 serial driver really should be
> > re-written as a driver inside of drivers/serial. :)
>
> I'll look into this.  Can you suggest a good driver to use as guidance?

For the conversion? Not off-hand.  But there should be some docs on how
to write these drivers on the ARM pages (RMK wrote this driver /
abstraction set), or just skim a few of the non-'core' files under
drivers/serial to see what's needed on the driver-specific part.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
