Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp2.wanadoo.fr (smtp2.wanadoo.fr [193.252.22.29])
	by ozlabs.org (Postfix) with ESMTP id 39F692BF07
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Jan 2005 19:54:57 +1100 (EST)
Date: Wed, 5 Jan 2005 10:03:18 +0100
To: Leigh Brown <leigh@solinno.co.uk>
Message-ID: <20050105090318.GA12317@pegasos>
References: <33721.82.10.231.190.1104781370.squirrel@82.10.231.190>
	<200501032211.j03MB7A1021340@arbas.nms.ulrich-teichert.org>
	<20050104222854.GA30919@pegasos>
	<33151.82.10.231.190.1104878355.squirrel@82.10.231.190>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <33151.82.10.231.190.1104878355.squirrel@82.10.231.190>
From: Sven Luther <sven.luther@wanadoo.fr>
Cc: Ulrich Teichert <krypton@ulrich-teichert.org>, linuxppc-dev@ozlabs.org,
	mikemartin@linux.ca, debian-powerpc@lists.debian.org
Subject: Re: 43p-140 install issues
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jan 04, 2005 at 10:39:15PM -0000, Leigh Brown wrote:
> Sven Luther said:
> > On Mon, Jan 03, 2005 at 11:11:06PM +0100, Ulrich Teichert wrote:
> >> Hi,
> >>
> >> >Delete the "console=tty0", so you end up with:
> >> >
> >> > Linux/PPC load: console=ttyS0,9600 root=/dev/ram
> >> >
> >> >and try again!
> >> [del]
> >>
> >> Right, then the installer knows what to do. I think this should go into
> >> the Debian installation docs, there are a lot of boxes with graphic
> >> cards
> >> out which are not supported by Linux.
> >
> > Err, it should default to vga tedxt mode if the graphic card fbdev is not
> > builtin, at least it does it here.
> 
> The PReP specs says that the cards should be initialised to a
> minimum resolution of 640x480 iirc.  The boot loader has code to
> manually reprogram the card *back* into VGA text mode, but only
> for a very limited number of cards.  So, if your card is not
> supported by fbdev, and isn't one of the very few supported
> cards in the boot loader, it simply won't work under PReP.

Ah, ok ... Well i have a cirrus logic card also, and it seems to work. I have
anot yet tried the matrox cards though. Do they need to be special cards with
forth rom, or will any do ? 

BTW, i have another question. I am trying to fix debian-installer to create
the prep partition, but i would like to have some info on the expected
constraints of said partition. Some tell it has to be entirely in the first
8MB, others the first 5MB, and my powerstack has a 17MB boot partition right
now.

I guess it is really not all that important what the size of the partition is,
it just needs to be first, and the kernel needs to fit in what the firmware
supports.

This goes for various prep boxes, but also for later IBM chrp machines,
including current pseries. It may be problematic, though if the size is too
small, as debian uses an initrd kernel, and altough the kernel itself is
rather small (around 1MB compressed), the current initrd generation method is
not all that fine-grained.

Ah, another thing. I am about to make a new kernel upload, which fixes the
powerstack II (utah) pci irq issue (backported from 2.6.10), but i hear about
problems with other systems, among them the popular 43p-140. Do you know of
any other patch that needs to be applied ? We use a 2.6.8 kernel as basis, so
the stuff will need to be backported, and i think i saw a bunch of prep fixes
in 2.6.9. What about the patches which enables prep-tool ? 

Friendly,

Sven Luther
