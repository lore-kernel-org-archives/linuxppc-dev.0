Date: Mon, 31 Jul 2000 22:54:17 +0200 (CEST)
From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
To: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
cc: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        Martin Costabel <costabel@wanadoo.fr>,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: CONFIG_PPC != Mac
In-Reply-To: <4.3.2.7.2.20000731184833.00ce9900@mail.lauterbach.com>
Message-ID: <Pine.LNX.4.10.10007312212160.14120-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> >ADB keyboard and mouse work (and button emulation works as well) with
> >CONFIG_NEW_INPUT_LAYER not set. What doesn't work for me anymore is the
> >USB mouse. The 2.2.17 kernel (rsynced last Thursday) only compiled after I
> >added a #ifdef CONFIG_MOUSEDEV somewhere in mac_keyb.c as a consequence of
> >not having CONFIG_NEW_INPUT_LAYER defined. I'd look it up on the Lombard
> >but the box just crashed on me the second time in a row today. 2.2.17 sure
> >is exciting.
>
> I'll try myself without CONFIG_NEW_INPUT_LAYER set later. But I wonder why
> your USB mouse would no longer work. It certainly works for me in console
> and XF4. X or console? Xpmac (which rev?) or XFree? Did you link
> /dev/usbmouse to /dev/input/mice?

OK, I've tried with CONFIG_NEW_INPUT_LAYER set in the meantime, here's
what I got (on 2.2.17pre13-ben2, to be precise):

- USB mouse works as before both in X and for gpm when I link
/dev/usbmouse to /dev/input/mouse2. OK so far.

- gpm takes input from trackpad, USB mouse and emulation buttons without a
hitch if I use /dev/input/mice as the device. I can most definitely live
with that. No serious, this is a major improvement over the previous
scheme (including Paul's idea to copy all USB mouse packets to the
adbmouse channel, too). I think can see where the new input layer is
heading, and think it was about time for a major rewrite of the keyboard
driver mess, plus it obsoletes the ADB device hack I sent to Paul so that
saves me patching it up for 2.4. I'm mostly for it, but:

- the showstopper: In order to keep my X config backwards compatible with
older kernels, I need /dev/adbmouse as busmouse protocol device. It's dead
now ... but can reactivated if you remove the #ifndef CONFIG_INPUT_MOUSEDEV
conditionals. Even the old way of mouse button emulation via /dev/adbmouse
still works, so why the #ifndef CONFIG_INPUT_MOUSEDEV to remove a fully
functional feature that doesn't even interfere with the new input layer
for all I can see?

Side note: if you use /dev/input/mouse1 to get the trackpad data you will
miss the mouse emulation packets that are on /dev/input/mouse0. That may
be why emulation appeared broken to some.

	Michael

P.S.: the list seems broken right now, any idea who should be notified?


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
