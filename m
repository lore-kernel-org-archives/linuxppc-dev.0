Message-ID: <39F33A92.751C5F@wanadoo.fr>
Date: Sun, 22 Oct 2000 21:05:54 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: mlan@cpu.lu
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Keyboard trouble with XF 4.0.1
References: <200010221630.SAA01006@piglet.grunz.lu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Michel,

I can tell you what is working for me. I have been using Franz's XF4
RPMs for quite a while without major problems (some minor ones still
persist, but since the RPMs are 3 months old, I won't repeat them here).
I am not using, however, the "linux" keycodes. Only the ADB codes.

Michel Lanners wrote:
>
> Hi all,
>
> I finally found the time to upgrade to Franz Sirl's XF 4.0.1 rpms. I
> hoped to solve some of my keyboard problems, but it got worse :-((
>
> My setup:
>
> - Apple Extended Keyboard II (dmesg shows handler 3:
> ADB keyboard at 2, handler set to 3
> Detected ADB keyboard, type ISO, swapping keys.)

I have the same keyboard, French (azerty) keys.

> - kernel 2.2.17pre20-ben3 (the source tarball from benh's site) (to get
> the new input stuff, which is enabled)

I mostly use 2.4.0-test kernels, but it works for 2.2.17+ in the same
way.

> - XF 4.0.1 rpms from Franz (XFree86-4.0.1-0.36a)
> - XKB enabled

Same here.

>               (but I couldn't get a decent map loaded... went back to
>   xmodmap)

I am using the same keymaps as I have for years with the "old" input
layer. The only problem are those 2 swapped keys "@#" vs "<>". In
/usr/lib/X11/xkb, I changed the following:

In keycodes/macintosh, besides the usual definition of keycode 18, the
following swap:

-    <LMTA> = 66;
+    <LMTA> = 63;
-    <LALT> = 63;
+    <LALT> = 66;

Otherwise, in keymap/macintosh:

-    xkb_symbols                { include "macintosh/us(extended)" };
+    xkb_symbols                { include "macintosh/fr" };

The modifiers in symbols/macintosh/fr are defined as (and this is
exactly as I had it before in XF3.3.6)

    key <LMTA> {       [  Meta_L               ]       };
    key <LFSH> {       [  Shift_L              ]       };
    key <LCTL> {       [  Control_L            ]       };
    key <LALT> {       [  Mode_switch          ]       };
    key <RMTA> {       [  Meta_R               ]       };
    key <RTSH> {       [  Shift_R              ]       };
    key <RCTL> {       [  Control_R            ]       };
    key <RALT> {       [  Alt_R                ]       };
and
    modifier_map Shift  { Shift_L,   Shift_R   };
    modifier_map Lock   { Caps_Lock            };
    modifier_map Control{ Control_L, Control_R };
    modifier_map Mod1   { Meta_L, Meta_R       };
    modifier_map Mod3   { Mode_switch          };

In symbols.dir, there is an added line
+-------- -------- macintosh/fr(extended)

In XF86Config, I have

#    Option "XkbDisable"
    Option "XkbRules"   "xfree86"
    Option "XkbModel"   "macintosh_old"
    Option "XkbLayout"  "fr"
    Option "XkbCompat"  ""

With this, everything works. At startx, I get a warning in the console:

(II) Using deprecated Macintosh keycodes.
The XKEYBOARD keymap compiler (xkbcomp) reports:
> Error:            Meta_R added to symbol map for multiple modifiers
>                   Using Mod1, ignoring Mod4.
> Error:            Meta_L added to symbol map for multiple modifiers
>                   Using Mod1, ignoring Mod4.
Errors from xkbcomp are not fatal to the X server

I did not try to fix this, because it ain't broken.

> First question: does anybody have pointers or info about how to setup
> XKB? I've looked around a fair bit, but found nothing of value. Nothing
> that specifies how to change the layout without blindly relying on some
> undocumented options...
>
> Second, my Alt'ed or Shift-Alt'ed keys still don't work. Under Linux
> keycodes, there is no difference whether Alt is pressed or not; the
> resulting key is the same, and xev shows the same old keycode as without
> Alt.
>
> Under ADB keycodes, there is a reaction to Alt, but it seems to be to
> _turn_off_ the highest bit in the resulting keysym. The keycode is
> right, though....
>
> Then, with ADB keycodes, the key left of '1' and the one right to
> 'Shift_L' are swapped vs. my previous setup. Is it now 'the right way'?
> Could be, since the default US map I got with X was right... So I guess
> those keys have been swapped in the 'old' code for ages.

Looks to me like an arbitrary decision. But since it is Franz and Ben
who have decided that the kernels and maps that we have used for years
were wrong, we will have to accept this decision.

> Anybody got any help? Especially the the Alt problem is _really_
> annoying, since I have many usefull keys on an Alt'ed binding (like @,
> #, \ and |).

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
