Date: Fri, 7 Dec 2001 14:01:14 +0100 (CET)
From: Gabriel Paubert <paubert@iram.es>
To: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Cc: Tom Rini <trini@kernel.crashing.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Corey Minyard <minyard@acm.org>,
	Franz Sirl <Franz.Sirl-ppc@lauterbach.com>,
	<linuxppc-dev@lists.linuxppc.org>, <paulus@samba.org>
Subject: Re: Changes to PPC Linux required for GCC 3.1
In-Reply-To: <200112052124.4573@enzo.bigblue.local>
Message-ID: <Pine.LNX.4.33.0112071346210.2808-100000@gra-lx1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 5 Dec 2001, Franz Sirl wrote:

>
> On Wednesday 05 December 2001 20:45, Tom Rini wrote:
> > On Wed, Dec 05, 2001 at 06:50:38PM +0100, Benjamin Herrenschmidt wrote:
> > > >I think the reason this wasn't applied is that Paul said something about
> > > >thiws being horriyingly ugly.  Corey, can you post a patch that changes
> > > >RELOC(x) into a function and nothing else? :)
> > >
> > > I prefer this beeing resolved at compile time. The reason Paul didn't
> > > want it at first is because he didn't want a workaround for a pre-release
> > > gcc bug. Since this is becoming a "feature", it makes sense to get the
> > > workaround. Paulus will confirm or not what I'm saying though...
> >
> > This was actually being hit by a 3.0.x release at the time I think (and
> > we worked around it another way).  I'd prefer a clean function over an
> > ugly macro any day :)
>
> I don't understand how my patch makes the RELOC hack uglier than it is
> already by itself ;-). The few affected files should really be reworked to be
> compiled with something like -fPIC -mrelocateable (maybe with -msdata and
> setup r12 accordingly).

I agree, RELOC should die. Actually my bootloader for PreP machines is
compiled with -mrelocatable (that's sufficient). The only trick is that I
sacrificed a register (r13) to hold a pointer to a structure which
contains the few most heavily used variables.

Actually I'm almost certain that -msdata and similar options are
incompatible with -mrelocatable, or at least were 3 years ago. Not many
things have changes in this area in GCC since then AFAICT. That's why I
had to resort to this trick (easily hidden in macros if you want to) to
limit code growth, but you should realize that I'm an absolute fanatic of
minimal code size. Actually code size is not that important in a loader
that is thrown away early (OTOH current PPC kernels are so incredibly
bloated that it's not even funny).

Nevertheless, I found it very nice to have a system which does not have
any hardwired address (except for exception vectors).  It only needs a few
big enough contiguous chunks of memory.

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
