Date: Wed, 7 Jan 2004 10:56:01 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
	Rob Baxter <robb@synergymicro.com>,
	Sven Luther <sven.luther@wanadoo.fr>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: multiple separate pci bridges ...
Message-ID: <20040107095601.GB24780@iliana>
References: <Pine.LNX.4.44.0401071000001.8608-100000@opal.biophys.uni-duesseldorf.de> <1073467436.5753.102.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1073467436.5753.102.camel@gaston>
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Jan 07, 2004 at 08:23:57PM +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2004-01-07 at 20:02, Michael Schmitz wrote:
> > > note that there's still a problem with XFree which will "see"  those
> > > BARs and, according to the log posted by Sven, shoke. Sven, can you
> > > try "hiding" the host bridge completely from the config ops and see
> > > if that helps with XFree ? That's not a very good solution though,
> > > we'll have to do something different about it. Now if only XFree
> > > stopped mucking with the PCI bus...
> >
> > Is this a problem with overlapping PCI resources again (thought that was
> > fixed in 2.4 anyway)? Resolving the overlap helped there. What does XFree
> > do, simply disable resources?
>
> There should be no overlap.... Let me check the log ...
>
> (II) Host-to-PCI bridge:
> (II) Bus 16: bridge is at (0:0:0), (-1,16,0), BCTRL: 0x0008 (VGA_EN is
> set)
> (II) Bus 16 I/O range:
>         [0] -1  0       0x00000000 - 0x0000ffff (0x10000) IX[B]
> (II) Bus 16 non-prefetchable memory range:
>         [0] -1  0       0x00000000 - 0xffffffff (0x0) MX[B]
> (II) Bus 16 prefetchable memory range:
>         [0] -1  0       0x00000000 - 0xffffffff (0x0) MX[B]
>
> The problem is on the host bridge BARs again. I don't know what they
> are supposed to do, you need to look at the bridge spec, but you
> definitely need to hide them some way...

What i don't know is why X looks at them, even if it didn't appear on
the pci devices list. i am currently building X 4.4 out of CVS to follow
up on where exactly the problem is.

Friendly,

Sven Luther

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
