From: Simon Winwood <sjw@cse.unsw.edu.au>
To: Tom Rini <trini@kernel.crashing.org>
Date: Thu, 22 Nov 2001 07:04:13 +1100
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Walnut boottime issues
Message-ID: <20011122070413.C26819@cse.unsw.edu.au>
References: <20011121104517.A12111@cse.unsw.edu.au> <20011120173502.D821@cpe-24-221-152-185.az.sprintbbd.net> <20011122054437.A26819@cse.unsw.edu.au> <20011121115344.H3436@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20011121115344.H3436@cpe-24-221-152-185.az.sprintbbd.net>; from trini@kernel.crashing.org on Wed, Nov 21, 2001 at 11:53:44AM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Nov 21, 2001 at 11:53:44AM -0700, Tom Rini wrote:
> On Thu, Nov 22, 2001 at 05:44:37AM +1100, Simon Winwood wrote:

[...]

> >
> > 	After some slight hacking --- basically, I added
> >
> > 	#include <asm/bootmem.h>
> >
> > and
> > 	avail_ram = 0x600000
> > 	end_avail = 0x800000
>
> Yeah, I noticed when I tried to compile it.
>
> > 	The only problem is that you can only boot with an empty command line,
> > otherwise it locks up after 'Now booting the kernel' (as far as I can tell)
>
> Hmm..  How's this go?
>

	Nope ... added:

	cp = cmd_line
	timer = 0

	which was missing (and was causing various problems), however
it freezes after 'Uncompressing kernel'.

loaded at:     00500000 0058A900
relocated to:  00400000 0048A900
board data at: 00487830 00487870
relocated to:  00200100 00200140
zimage at:     00406000 0048648A
avail ram:     00487000 08000000

	avail ram is less than where the image is relocated to ... found the
bug --- you need to use _end rather than __ramdisk_end as there is stuff after
the ramdisk.

	So with those changes, it boots OK for me.

	Simon

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
