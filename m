From: phandel@cise.ufl.edu
Date: Sat, 07 Apr 2001 13:56:25 -0700 (PDT)
Subject: Re: DMASOUND->rev6  (2.4.3)(attn: Xine, MOL, PowerComputing,  ibook,
 Tumbler)
In-reply-to: <20010407105610.94080DBA03@atlas.valhalla.net>
To: Iain Sandoe <iain@sandoe.co.uk>
Cc: linuxppc-dev@lists.linuxppc.org
Message-id: <Pine.LNX.4.21.0104071342330.1988-100000@like.mine.nu>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 7 Apr 2001, Iain Sandoe wrote:

>
> >>  - fix bug where TX stops when dbdma status comes up "DEAD"
> >>    so far only reported on PowerComputing clones ... but.
> >>    (PowerComputing clones - NOT TESTED - please let me know what happens).
> >
> > Nope, I can still kill sound by merely moving the mouse.  Here is the new
> > line from the console:
> >
> > Apr  7 03:31:13 like kernel: dmasound_pmac: tx-irq: xfer died - patching
> > it up...
> >
> > ...but sound is dead, along with the player app, just as before.
>
> damn... so much for the dbdma manual... :-(
>
> what do you _have_ to do to re-start the sound?
> kill & re-start the app?
> close & re-open /dev/dsp?
> un-load & re-load the module?
> - or reboot?

The application is wedged (at least the sound-playing thread) - ie. in
xmms, I can still use the menus etc. but the timer itself has stopped.
If I try to quit xmms, xmms will freeze completely.  I then *have to* kill
xmms (so that I can unload the two sound modules dmasound_{pmac,core}),
unload the two modules, and then reload the two modules.  Rebooting is not
required.

Here is the message after the insmod:

Apr  7 13:46:55 like kernel: dmasound_pmac: Awacs/Screamer Codec Mfct: 2 Rev 2
Apr  7 13:46:55 like kernel: PowerMac AWACS rev 2  DMA sound driver rev
016 installed
Apr  7 13:46:55 like kernel: Core driver edition 01.06 : PowerMac Built-in
Sound driver edition 00.06
Apr  7 13:46:55 like kernel: Write will use    4 fragments of   32768
bytes as default
Apr  7 13:46:55 like kernel: Read  will use    4 fragments of   32768
bytes as default


> can you make sure it's not the app that's stopping?
> (or is this equally the case with _any_ app?)

Yes, it happens with any app.

> If you have a big-ish file (although it doesn't sound like you need very
> big) then my stest program would do to test it... it's *very* simple and
> therefore should eliminate lots of other possibilities ;-)

I can kill sound with xmms, mpg123, realplay, etc. although I can't kill
it with realplay at low bitrates.

Another datapoint: It seems as if I can kill sound more easily when I play
mp3s that reside on my fast drive -> I can kill it within 30sec from the
IBM 7200rpm UltraSCSI drive, but it takes a few minutes of playing from
the Seagate 5400rpm UltraSCSI drive.


Thanks,
Peter


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
