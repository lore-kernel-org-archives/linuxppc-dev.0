Date: Sat, 16 Mar 2002 08:15:05 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Michael Sokolov <msokolov@ivan.Harhan.ORG>
Cc: linux-galileo@source.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] My GT-64260 enhancements
Message-ID: <20020316151505.GA713@opus.bloom.county>
References: <20020315170433.GA691@opus.bloom.county> <0203160821.AA28474@ivan.Harhan.ORG>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0203160821.AA28474@ivan.Harhan.ORG>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Mar 16, 2002 at 12:21:51AM -0800, Michael Sokolov wrote:
>
> Tom Rini <trini@kernel.crashing.org> wrote:
>
> > Don't need to #ifdef externs..
>
> OK, changed this in the revised patch.
>
> > >  if [ "$CONFIG_EV64260" = "y" ]; then
> > >    define_bool CONFIG_GT64260 y
> > >    define_int CONFIG_SERIAL_CONSOLE_BAUD 115200
> > >  fi
> > >
> > > -if [ "$CONFIG_GT64260" = "y" ]; then
> > > +if [ "$CONFIG_EV64260" = "y" ]; then
> >
> > If you're going to use the same test here as above, don't make it two
> > cases.
>
> Ditto. BTW, do you really want that 115200 thing in there? I've axed it in my
> personal tree, but didn't include that in my posted patch to reduce the patch
> scare factor.

I'd be willing to bet $5 it's from Troy.  IMHO, 9600 is the defacto
default rate, but Troy likes 'fast' serial consoles.

> > > +   comment 'EV-64260-BP zImage Wrapper Options'
> > > +   string 'Ethernet 0 MAC Address' CONFIG_EV64260_ETH_0_MACADDR "feffff000000"
> > > +   string 'Ethernet 1 MAC Address' CONFIG_EV64260_ETH_1_MACADDR "feffff000001"
> > > +   string 'Ethernet 2 MAC Address' CONFIG_EV64260_ETH_2_MACADDR "feffff000002"
> >
> > I think this is semi-wrong, or at least the comment is.
>
> No, my comment is correct, as with my patch these options exist only for
> EV-64260-BP, not for other boards, and affect only the zImage wrapper, no
> effect if you make vmlinux.

Right, And boards other than the EV-64260-BP use the zImage wrapper,
like the Motorola MVP.

> > Troy is working
> > on the Motorola MVP and is confined to DINK.
>
> So what are you suggesting? With my patch everything that worked before still
> works exactly the same way, except that there is a new possibility of booting
> vmlinux directly and configuring it via bi_recs. People who used hard-coded MAC
> addresses previously can still do so if they want.

I'm saying that if nothing else the comment is wrong or slightly
misleading, as it's not 'just' for the EV-64260-BP, it's for the
Motorola MVP as well, and possibly other boards in the future which have
to use !(StarMON || PPCBoot).

> > > -	-o "$CONFIG_4xx" = "y" -o "$CONFIG_GT64260" = "y" ]; then
> > > +	-o "$CONFIG_4xx" = "y" -o "$CONFIG_EV64260" = "y" ]; then
> > >    bool 'Support for early boot texts over serial port' CONFIG_SERIAL_TEXT_DEBUG
> >
> > I think this is also wrong for the same reasons, and iirc this should
> > just work, or should.
>
> No, I think this is right. Whether a board port supports
> CONFIG_SERIAL_TEXT_DEBUG or not is entirely up to the person doing the port and
> has nothing to do with what chips happen to be on the board.

Well, (and I do need to check out the _galileo tree) iirc the stuff to
support that option is in one of the generic files.  Or generic to the
work currently in there.  If that's the case, and you're explicitly not
going to support it in your files (and ports) then add a -a
"$CONFIG_xxx" = "n" .

> > Aside from that, it looks quite good and removes the horribly ugly
> > setting of MAC addrs, for the most part.
>
> The revised patch is below. How about pushing it?

Looks better, but I still want to see Troy and/or Marks comments on it.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
