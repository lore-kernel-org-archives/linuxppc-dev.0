Message-ID: <3B65A007.DD2A96BB@wanadoo.fr>
Date: Mon, 30 Jul 2001 19:57:27 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Iain Sandoe <iain@sandoe.co.uk>
Cc: Bastien Nocera <hadess@hadess.net>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.4.8-p1 crash on startup (was Clock problem)
References: <20010730164850.104E02EFD8@apollo.valhalla.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Iain Sandoe wrote:
>
> > 2.4.8-pre1 boots if I don't let it find its modules. If it finds them,
> > then something (probably dmasound_awacs) writes garbage into the
> > framebuffer and produces a crash complete with zapped PRAM.
>
> You need to apply the latest set of patches to 2.4.8p1 if you intend using
> dmasound - AFAIK the BK version has a reference to an obsolete function.

I can live without sound if it just boots without crash. The version of
2.4.8-pre1 I tried (a vger cvs tree), has CONFIG_DMASOUND_AWACS, not
_PMAC. I haven't yet tried your patches.

> Ben's tree has the latest patches (apart from the Power Computing stuff -
> but that doesn't affect you).
>
> If all those are 'true' as it were - can you confirm it is dmasound_pmac() ?

In Ben's 2.4.7, I don't know who is responsible for the crash.
dmasound_pmac is compiled as a module and the crash happens before these
modules are loaded (I'm not sure, however). What is strange, too, is
that this kernel doesn't compile unless CONFIG_SMP=y.

> with the latest set of patches it is *supposed* to be much more friendly to
> non-awacs chips (doesn't make them work, but is supposed to ignore stuff it
> doesn't understand...).

In Ben's 2.4.6 with dmasound_pmac as module, I get various gnome system
sounds correctly. No mixer, no volume control, no audio CD, however. And
no system sounds after sleep/wake up.

> If that's not the case I want to fix it...
>
> It's also puzzling in a way because dmasound_pmac doesn't try to do DMA
> unless you do SysBeep() or output a sound.  Until then the only regs it
> should touch are in mac-io.
>
> ----
>
> 2.4.8-p1 is fine on 9600/233, g3/beige & g4/500/sawtooth (but these all have
> AWACS or Screamer).  Haven't tied the Lombard yet (but don't expect any
> difference really).

This is iBook1 with DACA. BTW, Apple don't know how to initialise this,
either: In MacOSX it is also not working correctly (No sound from audio
CD or iTunes unless the volume button F3 is pressed first, and then it
starts with maximal loudness. Very annoying. The volume control by
software has no relation to the volume control by F3/F4).

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
