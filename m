Date: Thu, 12 Oct 2000 16:09:47 +0300 (EEST)
From: Kostas Gewrgiou <gewrgiou@imbc.gr>
To: Josh Huber <huber@mclx.com>
cc: Linux/PowerPC Devel List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: dual head r128
In-Reply-To: <20001011145249.B1437@missioncriticallinux.com>
Message-ID: <Pine.LNX.4.21.0010121542340.18328-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 11 Oct 2000, Josh Huber wrote:

> On Wed, Oct 11, 2000 at 08:43:28PM +0200, Michel D?nzer wrote:
> > I don't think that's the cause, it fails much later.
>
> That is true, but I thought that if perhaps int10 wasn't able to init
> the card fully, that it might cause problems later.  Let's assume
> that's not a problem for the moment though :)

Since the card is a x86 one int10 is needed to initialize it, don't expect
the int10 code to work under linux/ppc though, it needs ISA IO and memory
access which don't work.
I have code to fix PIO for machines with only one iobase, but it
doesn't work with Uni-N machines (i have no idea how to handle code like
inb(0x3C3) in this machines and until someone figures out how to handle it
don't expect int10 to work....)

> > Have you built X yourself? If yes, you need patches from Ani Joshi. The memory
> > and clock values it probes are obviously bogus.
>
> > Wait a minute, I see you are using debs, which should contain Ani's stuff.
> > Does aty128fb work on the second card? If yes, try Option "UseFBDev".
>
> The secondary card is a PC card, so it's not initialized by OF, but I
> think the r128 fb driver does a proper initialization of the card, so
> that shouldn't be the problem.

Kevin Hendricks patches from Ani's tree will fix the memory/clock values
for OF cards only, the patch breaks the calculations for the x86 cards
(thats the reason why its not in the xfree cvs), so don't expect to get
sane values for the x86 card. (aty128fb has the same problem as well btw)
The correct fix will be to check that the ROM is a x86 one and then read
the values from it and if not use the OF values. Unfortunately i don't
have access to a machine with a r128 card anymore so i never managed to
fix this.

  Kostas


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
