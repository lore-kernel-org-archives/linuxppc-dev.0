Message-ID: <3ADCC874.F018278D@wanadoo.fr>
Date: Wed, 18 Apr 2001 00:49:25 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Iain Sandoe <iain@sandoe.co.uk>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: XF4, SysRq, VT, mouse buttons, Keymaps and all that
References: <20010417211637.DEDEEDBA73@atlas.valhalla.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Iain Sandoe wrote:
[]
> I may be going blind - but I can't see _any_ locale-specific mac keycode
> tables in the X11R6 tree...

Two (not helpful) answers: 1. The linux-keycodes stuff was supposed to
let Mac users use localised PC keymaps. A pious wish that didn't work.
For French Mac keyboards there is a XF4 (+console) keymap at
linux-france.fr in RPM form. I don't know about others, but 2. SuSE-ppc
is reported to contain working localised keymaps, but I haven't seen
them with my own eyes.

> So the next question set is...
>
> 1/ Is there a description anywhere of the flow of keycode translation
>    adb -> linux_keycodes -> X  (there isn't in linux/Documentation AFAICT).
> Especially:
>     where to look for the tables to edit at each stage - and
>     what exists to examine the codes.

I strongly suspect that the last guy who tried such a documentation had
to be put away into a safe institution :-) As for the tables to edit,
there is not much choice. For the console, everything is contained in
/usr/lib/kbd, and for X, in /usr/X11R6/lib/X11/xkb. After staring at
what's there for a while, you see some sort of logic at work that can be
used for modifications. All this, of course, is the layer above the
kernel keymaps that translate things several times back and forth before
userspace gets to see them. Except for the SysRq key, you probably don't
want to touch the latter.

> 2/ the (ISO Mac Keyboard) SysRq key is no longer a single value (according
> to showkey it sends two codes) but this needs to be caught earlier on (in
> the kernel) - so is this supposed to be before or after the translation
> adb->linux_keycodes? ... or how can I find the value to modify the match
> code in the kernel?  AFAICT SysRq is not working.

Can't help there, NoSuchKey(TM) on my iBook.

> 3/ how does one find the keycode values for <option>-key combinations so
> that the mouse_button2 & 3 keycodes can be re-assigned (it is really
> irritating losing them)...  [the kernel build has this emulation enabled]

The option key doesn't modify the keycode, only (if configured
correctly) the symbol associated with this keycode. The easiest way to
find the keycodes to put into the /proc/...*button*emulate slots is to
look them up in include/input.h in the kernel sources. This is the
console keycode, i.e. what you get from showkey. For most keys, it is
the X keycode (i.e. what you get from xev) minus 8. Used to be *all*
keys, but this is no longer so.

> 4/ Notwithstanding the PMac-specific nature of some of these questions - Is
> there a HOW-to on creating a keymap (I'm happy to do one for the UK keyboard
> if someone can point at the mechanism).

In XFree, there are always about 25 (conservative estimate) different
ways to achieve the same goal, so such a HOWTO would require some
lengthy explanations :-)
OTOH, you probably installed a dozen megabytes worth of XFree-doc, so
there might be something hidden in there for example
/usr/doc/XFree86-doc-4.0.99.1/XKB/XKBproto.ps.gz or similar.

> 5/ num-lock never worked for me (even under 3.3.6 - it put the keyboard
> light on but made no difference to the retured codes) I'd like to get this
> fixed because some apps (like cdp) use the keypad.

WorksForMe(TM).

> any pointers appreciated and thanks again for the help so far,
> Iain.

Sorry for not helping much.

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
