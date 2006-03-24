Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: Kill machine numbers
Date: Fri, 24 Mar 2006 09:46:50 +0100
References: <1143178947.4257.78.camel@localhost.localdomain>
	<20060324062624.GA16815@pb15.lixom.net>
	<1143187298.3710.3.camel@localhost.localdomain>
In-Reply-To: <1143187298.3710.3.camel@localhost.localdomain>
MIME-Version: 1.0
Message-Id: <200603240946.51793.arnd@arndb.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Cc: Paul Mackerras <paulus@samba.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 24 March 2006 09:01, Benjamin Herrenschmidt wrote:
> > > -struct machdep_calls __initdata cell_md = {
> > > +define_machine(cell) {
> > >     .probe                  = cell_probe,
> > >     .setup_arch             = cell_setup_arch,
> > >     .init_early             = cell_init_early,
> > 
> > You forgot to add a .name value here.
> 
> Yup, thanks. I think this should become cpb instead of cell, other cell
> based boards would then have different ppc_md's though they could share
> various routines.

The cpb name come from an outdated code name for what we currently
call the cell blade. My current understanding is that we try to keep
a common machine description for at least those machines that are
running without a hypervisor underneath them but based on rtas,
while then adding new machine descriptions for others.

However I really want to avoid having to add a new machine description
every time a company comes up with a new board design. As long
as they get everything right in the device tree, it should just
work (as long as all device drivers are there).

One thing I have been wondering about is what should be the right way
to check whether we're running on something based on the
Cell Broadband Engine Architecture, if that is needed somewhere.
My original idea was to make this the platform number, but this
seems impractical now.

	Arnd <><
