Date: Thu, 23 Aug 2001 13:01:49 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Robert E Brose II <bob@kunk.jriver.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.4.9-benh0 problems and kudos
Message-ID: <20010823130149.X14302@cpe-24-221-152-185.az.sprintbbd.net>
References: <20010823095805.I14302@cpe-24-221-152-185.az.sprintbbd.net> <20010823194337.10575.qmail@kunk.jriver.com> <20010823124853.V14302@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010823124853.V14302@cpe-24-221-152-185.az.sprintbbd.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Aug 23, 2001 at 12:48:53PM -0700, Tom Rini wrote:
>
> On Thu, Aug 23, 2001 at 02:43:37PM -0500, Robert E Brose II wrote:
> > User Tom Rini says:
> > > On Thu, Aug 23, 2001 at 11:42:56AM -0500, Robert E Brose II wrote:
> >
> > > > Next, when pppoe, ax25 or netrom are compiled as modules, trying to
> > > > insmod them gives the following...
> > >
> > > Don't use insmod.  Use modprobe.
> > > --
> > > Tom Rini (TR1265)
> > > http://gate.crashing.org/~trini/
> >
> > #/sbin/modprobe pppoe
> > /lib/modules/2.4.9-benh0/kernel/drivers/net/pppoe.o: unresolved symbol sk_run_filter
> > /lib/modules/2.4.9-benh0/kernel/drivers/net/pppoe.o: insmod /lib/modules/2.4.9-benh0/kernel/drivers/net/pppoe.o failed
> > /lib/modules/2.4.9-benh0/kernel/drivers/net/pppoe.o: insmod pppoe failed
> >
> > Same thing with respect to sk_run_filter
>
> Did you mean sk_chk_filter?  The problem is that sk_{chk,run}_filter are
> only exported on CONFIG_FILTER.  Congrats, you found a bug. :)  Go email
> Dave S. Miller <davem@redhat.com> about this.  In the mean time, edit
> net/netsyms.c, search for the symbols and remove the #ifdef CONFIG_FILTER/#endif
> around them.  Re-run make dep and recompile.

Er, wait a second...  drivers/net/pppoe.c doesn't call sk_run_filter...

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
