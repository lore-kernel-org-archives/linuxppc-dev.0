Date: Tue, 27 Nov 2001 05:07:54 -0700
From: Matt Porter <mporter@mvista.com>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Simon Winwood <sjw@cse.unsw.edu.au>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: More walnut boottime "fun"
Message-ID: <20011127050754.B15728@cx258813-a.chnd1.az.home.com>
References: <20011127103042.A11612@cse.unsw.edu.au> <20011126221728.D13091@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20011126221728.D13091@cpe-24-221-152-185.az.sprintbbd.net>; from trini@kernel.crashing.org on Mon, Nov 26, 2001 at 10:17:28PM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Nov 26, 2001 at 10:17:28PM -0700, Tom Rini wrote:
>
> On Tue, Nov 27, 2001 at 10:30:42AM +1100, Simon Winwood wrote:
>
> > 	Apart from NFS not working, it looks like the bootloader is
> > clobbering itself when the image is reasonably large (> 1M?).
>
> There's certain dead-zones now.  Check out

Deadzone. Singular.

> arch/ppc/boot/common/relocate.S for the constraints.  Tomorrow I plan on
> implementing a slightly smarter relocate that moves the text, jumps
> there and then relocates data, which should bring us back to the same
> size deadzones that the original code had.

I don't think you understand what happened.  The relocate.S code
changed simply in terms of direction of copy.  It used to copy
from low->high now it copies from high->low.  This eliminated one
constraint from the original code and does not add any additional
ones.  I simply documented the remaining constraint since nobody
bothered to do that in the past.

That said, the two stage relocator is "The Right Thing To Do(tm)".
It only needs to be two stage, though when the load point > -Ttext.

Why doesn't walnut simply call mktree with the option to load at
it's -Ttext to avoid the original problem?  That's why I added the
parameter to mktree and use it on the Spruce build...no need to
do an extra copy if we control the load point.

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
