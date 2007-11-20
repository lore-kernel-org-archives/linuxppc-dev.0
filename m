Return-Path: <dgibson@ozlabs.org>
Date: Tue, 20 Nov 2007 11:59:41 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Revisited, audio codec device tree entries.
Message-ID: <20071120005941.GC3126@localhost.localdomain>
References: <9e4733910711181010q50c08d2ek8413af74d58cf0ce@mail.gmail.com>
	<4741A56D.9050808@freescale.com>
	<fa686aa40711190733vd1ffac0k62bf32186eb57aff@mail.gmail.com>
	<9e4733910711190800t5dc9bc40q1b58feae4ff364d0@mail.gmail.com>
	<fa686aa40711190831s2e59ab05h63d10ec8a24eaad5@mail.gmail.com>
	<9e4733910711190851g3e1f2ef9k5f87c7c2dae929ef@mail.gmail.com>
	<fa686aa40711190933r3cbeb51bw7b9073a40f8396ed@mail.gmail.com>
	<9e4733910711191120l45d9257bwf4ccf8c7365393d0@mail.gmail.com>
	<fa686aa40711191128i59245403g3e15e3b6c545b6ee@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fa686aa40711191128i59245403g3e15e3b6c545b6ee@mail.gmail.com>
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Nov 19, 2007 at 12:28:02PM -0700, Grant Likely wrote:
> On 11/19/07, Jon Smirl <jonsmirl@gmail.com> wrote:
> > On 11/19/07, Grant Likely <grant.likely@secretlab.ca> wrote:
> > > You might be stuck with using either a platform_device or an
> > > of_platform_device as a stepping stone to creating the device on the
> > > ALSA fabric driver.
> >
> > I also concluded that I need a of_platform stepping stone.
> >
> > There are several ways this could be done, which one is the right one?
> > a) fabric is global, create a global device node for it and implement
> > it as a of_platform device
> 
> This is really board level description stuff.  I'd make the node
> global off the root myself and use whatever linkage you think
> appropriate to get you to the codec nodes (phandle's most likely)

No.  I think this is the whole damn point we've been spiralling
around.

An of_platform device is appropriate *only* if there is an OF node for
the device.  There should be an OF node for the device only if it it
really is a well-defined hardware component which implements it.

As far as I can understand, the "fabric" driver is really just a
catchall to cover whatever various interconnections there are between
audio components on the board.

Those interconnections could (and probably should) be described in the
OF tree.  But that description would be to describe each of those
interconnections individually e.g. codecs have links to "sound PHY"
devices (speakers) or whatever, codecs, i2s AC97 and so forth devices
have links between them appropriate to the type of device.  Not as
some imaginary "fabric device".

Therefore the fabric driver cannot be instantiated as an of_platfornm
device.

Therfore arch code will have to instantiate the fabric driver some
other way.  There are a couple of options here:

	1) We have a "universal" device-tree-based fabric driver which
parses all the above-described interconnection information in the
device tree and handles any situation.  Cool, but probably a lot of
work and fiddly to get right.

	2) Or, the platform code instantiates an appopriate fabric
driver for the board (which will probably make assumptions about how
things are interconnected).  Platform code can optionally examine
board level model properties or other device information to select the
correct fabric driver and/or options.  The fabric driver can
optionally look at some parts of the device tree information to
configure details of its operation.

Option (2) is a hack, but it's a reasonably well-contained hack.  It
works for now, and doesn't preclude switching to option (1) later -
without changes to the device tree, and on a board-by-board basis.  It
can also handle the (almost inevitable) case of device trees with
missing or incorrect detailed audio interconnection information.

The basic thing is that we have a mismatch between the Linux driver
model and the device tree model.  Rather than hacking the device tree
to match the Linux model, we should provide whatever glue code is
necessary to instantiate the necessary Linux drivers from the device
tree information we have.  This is, essentially, the exact purpose for
which platform code exists.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
