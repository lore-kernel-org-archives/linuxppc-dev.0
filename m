Message-Id: <4.3.2.7.2.20000731152113.03e44d60@mail.lauterbach.com>
Date: Mon, 31 Jul 2000 15:37:18 +0200
To: Martin Costabel <costabel@wanadoo.fr>
From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Subject: Re: CONFIG_PPC != Mac
Cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <39857AE8.766DC3C3@wanadoo.fr>
References: <39821DD7.ED0DA0A2@embeddededge.com>
 <39821DD7.ED0DA0A2@embeddededge.com>
 <v04003a00b5a8c0b923e3@[24.66.67.194]>
 <v04003a01b5a8c8c70822@[24.66.67.194]>
 <4.3.2.7.2.20000731140051.0351ff00@mail.munich.netsurf.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 15:11 31.07.00, Martin Costabel wrote:
>Franz Sirl wrote:
>[]
> > What still uses CONFIG_ADB_KEYBOARD in bitkeeper? I thought I catched all
> > PPC uses of it? mac_keyb.c and adbmouse.c are obsolete now for PPC. The
> > input layer Makefile setup in drivers/macintosh needs some refinement vs.
> > m68k though (hopefully m68k people will use my new stuff too). The possible
> > selection of the obsolete CONFIG_ADBMOUSE is already fixed in my local
> > tree, I conditionalized it on CONFIG_MAC.
>
>Yes, I had CONFIG_ADBMOUSE=y, and this needed mac_keyb.c which was not
>included unless CONFIG_ADB_KEYBOARD was chosen.
>
>I am fighting with the "new input layer" right now, although I don't
>quite understand why this thing is being inflicted upon innocent ADB
>users.

2.4 users are not innocent :-). As I said, just don't turn on
CONFIG_ADBMOUSE. I'm doing that right now, cause the kernel uses linux
keycodes already internally now, and they will show up externally somewhere
during 2.5, so doing it for 2.4 with backwards compatibility on by default
is the best thing to do.

>I am trying to use it in compatibility mode, so that I can still boot
>into other kernels (if I see this right, for ADB it doesn't exist
>outside of BenH's 2.2.17 tree and the linuxppc_2_3 tree. How sure is it
>that this will be accepted into the mainstream kernel?). There are still
>some problems:
>
>After booting, some keys don't work: The "a" key that was mentioned
>before (it is the "q" here on my French keyboard), but also all the
>function keys and most keypad keys. Some of them don't produce keycodes,
>some of them weird ones.

I fixed that in my tree too, just got the condition in pmac_setup.c wrong,
it should be if (!keyboard_sends_linux_keycodes) ..., just a typo, will be
fixed later today.

>After starting X, the situation remained the same, although xev didn't
>show the same keycodes or lack of them as showkey. I then switched
>/proc/sys/dev/mac_hid/keyboard_sends_linux_keycodes on and off (had to
>learn to type "j" for <return> first to go back) and left and reentered
>X a couple of times. After a while, all keys started to work correctly.
>I'll do some more testing what makes them work.

See above, switching /proc/sys/dev/mac_hid/keyboard_sends_linux_keycodes to
1 and then back to 0 probably fixes it.

>The main problem so far is that I cannot get mouse button emulation to
>work. Has anyone tested this on an ADB keyboard/mouse? Or does it only
>work if one goes over completely to the "linux" keycodes? I don't want
>to do this yet, because it will make my system unusable with any other
>kernel (or maybe unusable at all). Last time I tried, it took me several
>hours to get a usable system back.

Mouse button emulation works for me and it works in both keycode modes, in
2.4 the adb_buttons kernel arg is gone though.

Franz.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
