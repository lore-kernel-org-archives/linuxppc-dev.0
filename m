From: Benjamin Herrenschmidt <bh40@calva.net>
To: Martin Costabel <costabel@wanadoo.fr>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Keyboard trouble with XF 4.0.1
Date: Mon, 23 Oct 2000 14:32:46 +0200
Message-Id: <19340917060430.2614@192.168.1.2>
In-Reply-To: <39F36680.65D1BF06@wanadoo.fr>
References: <39F36680.65D1BF06@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>OK, this argument is relevant for the case of "linux" keycodes, where
>the same keymaps are now supposedly used on PCs and on Pmacs.
>
>For the case of ADB keycodes, this argument is empty. Or are there other
>machines than Pmacs that now use the mac_keycodes[] translation table
>and macintosh keymaps and that didn't use macintosh keymaps before? It
>is in this case that the backwards compatibility problem appears. For
>the "old" input layer, one needed different keymaps for ADB and USB
>keyboards (differing by swapping those 2 keys).

That's more complicated. Some ADB keyboard have the same layout as
equivalent PC keyboard. Some have not. (Depending on the country). The
"swapping" of the corner key depends on ISO vs. ANSI keyboard and is now
handled by the driver, so an identical keymap should be used in both cases.
With the Linux keycodes, a "standard" keymap should work for any USB
keyboard or any ADB keyboard with a "standard" layout. For those having a
specific "Apple" layout, you still need a specific keymap (like French),
but one single keymap should now handle all cases for the "corner" key.

>Now with the new input layer one needs the same keymap, and the decision
>is whether this is the old ADB keymap or the old USB keymap. Right now,
>it is the old USB keymap. If I understand this correctly, it suffices to
>swap the numbers "10" and "50" in the mac_keycodes[] table in
>drivers/input/keybdev.c to obtain compatibility with the old ADB
>keymaps. Or maybe one additionally needs to swap the positions 10 and 50
>(the numbers "41" and "86") in adb_to_linux_keycodes[] in
>drivers/macintosh/adbhid.c? I am too tired now to understand this.

The linux keycodes are completely different keycodes. (based on PS/2
keycodes currently). The "old" keycodes are ADB keycodes as they used to
be. When enabling ADB keycodes, both ADB and USB keycodes are converted
to Linux keycodes and then back to ADB keycodes with the abdhid.c. That's
a bit hackish, but it ensures consistency, and we expect everybody to
switch to linux keycodes over time.

>Anyway, there are more important problems to solve :-)

Yup ;)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
