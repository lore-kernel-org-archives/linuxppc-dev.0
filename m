Date: Mon, 2 Jun 2003 11:55:44 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Adrian Cox <adrian@humboldt.co.uk>
Cc: "Mark A. Greer" <mgreer@mvista.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Internal interrupts on the MPC107
Message-ID: <20030602185544.GD4689@ip68-0-152-218.tc.ph.cox.net>
References: <1054119003.23151.23.camel@newt> <3ED7EFB4.2050400@mvista.com> <1054554408.20568.86.camel@newt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1054554408.20568.86.camel@newt>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Jun 02, 2003 at 12:46:37PM +0100, Adrian Cox wrote:

> On Sat, 2003-05-31 at 00:56, Mark A. Greer wrote:
>
> > [snip]
> >  My guess is
> > that your board's fw (or early kernel init code) is setting it up with
> > the correct value but on the other systems you mentioned, the fw doesn't
> > (and the reset value of 0x00 is returned).  Basically, if I'm
> > interpreting the manual correctly, you probably need to do something
> > other than count on the fw setting up that field in that reg correctly.
>
> For boards derived from the linuxppc_2_4_devel tree, everything works.
> I've now done kernel ports for several MPC107 based boards, all derived
> from that tree, which use the "new way" you describe below.
>
> > [description of "old way" snipped]
>
> I think I may force the driver to run in polled mode on kernels which
> use the "old way". Many of them fail to initialise the vector in the
> EPIC.
>
> > The "new way" of initializing the openpic uses the openpic_set_sources()
> > routine which allows you to select just the vectors you want to
> > initialize and assign them the IRQ values that you want (independent of
> > their offset).  Much nicer and it doesn't write to vectors/locations
> > that you don't want written.
> >
> > The problem for an I2C driver is that the IRQ is now board specific.
> >
> > So what to do?  Well, the board-specific file needs to initialize the
> > I2C vector.  Also, there has to be some mechanism for the board-specific
> > file to tell your driver what the IRQ is.  Maybe the best solution is to
> > have the board-specific code set up the vector field in the IIVPR0 reg
> > with the proper IRQ and then your driver won't need to change.  Seems
> > fairly clean but you'll have to hack the board-specific code of any
> > boards that will use the I2C driver.
>
> If there's any interest I could tidy up the driver and submit it into
> linuxppc_2_4_devel along with a patch that collects MPC107 configuration
> into one place.

Please do.  Don't forget to send the I2C driver to the I2C folks as
well.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
