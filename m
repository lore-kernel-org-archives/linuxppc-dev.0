Message-Id: <200011020712.IAA00710@piglet.grunz.lu>
Date: Thu, 2 Nov 2000 08:12:55 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Keyboard trouble with XF 4.0.1
To: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <39F33A92.751C5F@wanadoo.fr>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

My keyboard finally works again as expected, so I figured I'd tell the
list so my research work ends up in the archives ;-)

My setup is still the same basically:

>> My setup:
>>
>> - Apple Extended Keyboard II (dmesg shows handler 3:
>> ADB keyboard at 2, handler set to 3
>> Detected ADB keyboard, type ISO, swapping keys.)

- a recent 2.2 kernel (to get the new input stuff, which is enabled)

>> - XF 4.0.1 rpms from Franz (XFree86-4.0.1-0.36a)
>> - XKB enabled

What I'm saying below works only with ADB keycodes. As far as I can
tell, with Linux keycodes, only the 'keycodes' part of the XKB config
needs to be changed.

Why not use Linux keycodes? Because MOL doesn't work with them.

First, a few words about how XKB works.

XKB defines a way to handle keyboards under X, via a definition of all
aspects of a keyboard (this goes as far as specifying the physical
appearance, so an image of the keyboard can be printed). Everything
related to XKB can be found below /usr/X11R6/lib/X11/xkb.

A complete keyboard definition is called a keymap, and contains a few
different components. Have a look at keymap/macintosh, as distributed
with XF4:

// $XConsortium: macintosh /main/11 1996/03/07 13:42:13 kaleb $
// $XFree86: xc/programs/xkbcomp/keymap/macintosh,v 1.1 1999/05/23 05:27:51 dawes Exp $
default xkb_keymap "macintosh" {
    xkb_keycodes        { include "macintosh"                           };
    xkb_types           { include "default"                             };
    xkb_compatibility   { include "default"                             };
    xkb_symbols         { include "macintosh/us(extended)"              };
    xkb_geometry        { include "macintosh"                           };
};

So a keymap has these five components. The keycodes tell what numeric
code the keyboard (& driver) send back on a specific keypress. The
reference is the geographical location of the keys on the keyboard. Some
keys have names (like <ESC>, <TAB>), others coordinates like <AE01>
(first alpha key in the top (5th = 'E') row, etc.

Since we're using ADB keycodes, and XF4 uses Linux keycodes by default,
the keycode part needs to be specified. I started with
keycodes/macintosh, but made these changes:

> In keycodes/macintosh, besides the usual definition of keycode 18, the
> following swap:

+    <LSGT> = 18;

> -    <LMTA> = 66;
> +    <LMTA> = 63;
> -    <LALT> = 63;
> +    <LALT> = 66;

That's because ALT and META are swapped, and the key between left shift
and 'y' (or 'z') is missing.

> Otherwise, in keymap/macintosh:
>
> -    xkb_symbols                { include "macintosh/us(extended)" };
> +    xkb_symbols                { include "macintosh/fr" };

Now, this is the symbols part of the map, which defines what letter,
number or other symbol a specific key sends back, depending on the
modifier keys that are depressed.

The symbols/macintosh/us file is standard XF4; the fr part is not.
Therefore I used the us part, but with the following changes to get the
modifier keys to work as expected:

>     key <LMTA> {       [  Meta_L               ]       };
>     key <LFSH> {       [  Shift_L              ]       };
>     key <LCTL> {       [  Control_L            ]       };
>     key <LALT> {       [  Mode_switch          ]       };
>     key <RMTA> {       [  Meta_R               ]       };
>     key <RTSH> {       [  Shift_R              ]       };
>     key <RCTL> {       [  Control_R            ]       };
>     key <RALT> {       [  Alt_R                ]       };
> and
>     modifier_map Shift  { Shift_L,   Shift_R   };
>     modifier_map Lock   { Caps_Lock            };
>     modifier_map Control{ Control_L, Control_R };
>     modifier_map Mod1   { Meta_L, Meta_R       };
>     modifier_map Mod3   { Mode_switch          };

Now, since I don't have a us keyboard, but rather Swiss-French, I
changed the 'wrong' keys with xmodmap (since I always had that part
working ok). However, there is no problem (and that's the better way),
to add these changes in symbols/macintosh as well, maybe by adding a
separate file. Keep in mind however, that that file needs to be added to
symbols.dir.

Now, for XF86config:

For some reason, specifying the complete macintosh keymap didn't work.
Therefore, I specified the components I needed to change (keycodes and
symbols):

Section "InputDevice"
        Identifier      "Keyboard0"
        Driver          "keyboard"
        Option          "XkbModel"      "macintosh_old"
        Option          "XkbKeycodes"   "macintosh"
        Option          "XkbSymbols"    "macintosh/us(extended)"
EndSection

As you can see, the five components in the keymap/macintosh file have
their equivalent XFree options. Remember that "XkbModel" "macintosh_old"
selects ADB keycodes; but I don't know what that exactly means for XF4.
Anybody care to comment?

With this in place, everything works as expected, with these exceptions:

- the us symbols are active while not logged in, that is in xdm's login
  screen. The solution is to modify the symbols/macintosh/us part,
  instead of relying on xmodmap.

- the 'Apple' key doesn't work for switching back to console. I'll hunt
  that down ASAP.

Have fun

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
