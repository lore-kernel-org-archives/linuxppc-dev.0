Message-ID: <39F36680.65D1BF06@wanadoo.fr>
Date: Mon, 23 Oct 2000 00:13:20 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <bh40@calva.net>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Keyboard trouble with XF 4.0.1
References: <39F33A92.751C5F@wanadoo.fr> <19340916142445.23209@192.168.1.10>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:

> That's not that we decided our keymaps were wrong (well, they had a few
> things wrong). No, the major issue is to have keycode consistency among
> various archs and various PPC machines. There's no reason why the same
> USB keyboard would give different keycodes depending if your machine is
> considered as a pmac or not.

OK, this argument is relevant for the case of "linux" keycodes, where
the same keymaps are now supposedly used on PCs and on Pmacs.

For the case of ADB keycodes, this argument is empty. Or are there other
machines than Pmacs that now use the mac_keycodes[] translation table
and macintosh keymaps and that didn't use macintosh keymaps before? It
is in this case that the backwards compatibility problem appears. For
the "old" input layer, one needed different keymaps for ADB and USB
keyboards (differing by swapping those 2 keys).

Now with the new input layer one needs the same keymap, and the decision
is whether this is the old ADB keymap or the old USB keymap. Right now,
it is the old USB keymap. If I understand this correctly, it suffices to
swap the numbers "10" and "50" in the mac_keycodes[] table in
drivers/input/keybdev.c to obtain compatibility with the old ADB
keymaps. Or maybe one additionally needs to swap the positions 10 and 50
(the numbers "41" and "86") in adb_to_linux_keycodes[] in
drivers/macintosh/adbhid.c? I am too tired now to understand this.

Anyway, there are more important problems to solve :-)

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
