Date: Wed, 11 Oct 2000 12:04:02 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Josh Huber <huber@mclx.com>
Cc: Linux/PowerPC Devel List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: dual head r128
Message-ID: <20001011120402.B28179@opus.bloom.county>
References: <20001011141722.A1437@missioncriticallinux.com> <39E4B4D0.FA62D929@student.ethz.ch> <20001011145249.B1437@missioncriticallinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20001011145249.B1437@missioncriticallinux.com>; from huber@mclx.com on Wed, Oct 11, 2000 at 02:52:49PM -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Oct 11, 2000 at 02:52:49PM -0400, Josh Huber wrote:
> On Wed, Oct 11, 2000 at 08:43:28PM +0200, Michel D?nzer wrote:
> > I don't think that's the cause, it fails much later.
>
> That is true, but I thought that if perhaps int10 wasn't able to init
> the card fully, that it might cause problems later.  Let's assume
> that's not a problem for the moment though :)
>
> > Have you built X yourself? If yes, you need patches from Ani Joshi. The memory
> > and clock values it probes are obviously bogus.
>
> > Wait a minute, I see you are using debs, which should contain Ani's stuff.
> > Does aty128fb work on the second card? If yes, try Option "UseFBDev".
>
> Yeah, I'm using the debs, but it looks like the latest xserver-xfree86
> ppc packages are still at phase2v5, while the other packages are up to
> phase2v15.  Perhaps the code is just a little too old?

> BTW, no...I don't have aty128fb working on the secondary head -- is
> there some option to tell the driver to scan for all cards?  does it
> do this by default?

I _think_ the problem here is aty128fb cannot setup an uninitalized card.
2.4 _might_ be able to help in this area.

> The secondary card is a PC card, so it's not initialized by OF, but I
> think the r128 fb driver does a proper initialization of the card, so
> that shouldn't be the problem.

You can check this 1st by seeing if dmesg mentions two cards.  If it does
try video=map:000111 (tty1-3 on fb0, 4-6 on fb1).  If you don't have two
cards showing up this will panic (!!!)

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
