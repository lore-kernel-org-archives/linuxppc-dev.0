Return-Path: <jacmet@gmail.com>
To: Sven Luther <sven@genesi-usa.com>
Subject: Re: USB support on mpc5200 broken
References: <9e4733910809241451x7492d2a9s56b4cb4ee0fe0244@mail.gmail.com>
	<9e4733910809241809r58bddc2ax4759b70c3f07f6cf@mail.gmail.com>
	<1222307447.8277.147.camel@pasglop> <48E02FD0.8000809@genesi-usa.com>
	<20080929034329.GB8694@yookeroo.seuss>
	<20080929151854.GA29375@powerlinux.fr>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Mon, 29 Sep 2008 19:05:34 +0200
In-Reply-To: <20080929151854.GA29375@powerlinux.fr> (Sven Luther's message of
	"Mon\, 29 Sep 2008 17\:18\:54 +0200")
Message-ID: <87iqseopb5.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Peter Korsgaard <jacmet@gmail.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> "Sven" == Sven Luther <sven@genesi-usa.com> writes:

Hi,

 >> This, of course, is exactly why I *don't* recommend embedded platforms
 >> move to including the device tree in the flashed firmware.  Keeping
 >> the device tree in the bootwrapper means that it *is* updated with the
 >> kernel and we don't have to mess around with as much backwards
 >> compatibility junk.

 Sven> This completely defeats the purpopse of having a separate
 Sven> device tree though, no ? I mean, we could just as well hardcode
 Sven> the device-tree info in the kernel in this case ?

Well, yes and no. The device tree brings a number of advantages (and a
few disadvantages as well), one of those being the potential
decoupling of kernel and DT. Even if you don't make use of that
feature in a production build you still have the other advantages
(E.G. easy compile test of multiple boards, limited
repeated-these-are-my-platform-devices code in board files, ...).

 Sven> (In embedded cases, the kernel is usyually in the flash as
 Sven> well, so you just upgrade both at the same time :)

Sure, but if you do that you might as well include them in a single
uImage because:

- They are always in sync
- You don't waste flash space (E.G. the DT is very small, but you
  waste a complete flash sector)

With uImage.<platform> U-Boot can still fix up the tree before booting
the kernel, so you don't lose any functionality (E.G. if you
enable/disable certain nodes based on what option boards are
available).

-- 
Bye, Peter Korsgaard
