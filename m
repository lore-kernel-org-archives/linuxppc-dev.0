Date: Mon, 30 Jul 2001 17:44:59 +0100
Subject: 2.4.8-p1 crash on startup (was Clock problem)
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Martin Costabel <costabel@wanadoo.fr>,
	Bastien Nocera <hadess@hadess.net>
Cc: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010730164850.104E02EFD8@apollo.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> 2.4.8-pre1 boots if I don't let it find its modules. If it finds them,
> then something (probably dmasound_awacs) writes garbage into the
> framebuffer and produces a crash complete with zapped PRAM.

You need to apply the latest set of patches to 2.4.8p1 if you intend using
dmasound - AFAIK the BK version has a reference to an obsolete function.

Ben's tree has the latest patches (apart from the Power Computing stuff -
but that doesn't affect you).

If all those are 'true' as it were - can you confirm it is dmasound_pmac() ?

with the latest set of patches it is *supposed* to be much more friendly to
non-awacs chips (doesn't make them work, but is supposed to ignore stuff it
doesn't understand...).

If that's not the case I want to fix it...

It's also puzzling in a way because dmasound_pmac doesn't try to do DMA
unless you do SysBeep() or output a sound.  Until then the only regs it
should touch are in mac-io.

----

2.4.8-p1 is fine on 9600/233, g3/beige & g4/500/sawtooth (but these all have
AWACS or Screamer).  Haven't tied the Lombard yet (but don't expect any
difference really).

ciao,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
