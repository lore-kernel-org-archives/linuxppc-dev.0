From: Benjamin Herrenschmidt <bh40@calva.net>
To: Martin Costabel <costabel@wanadoo.fr>
Cc: <linuxppc-dev@lists.linuxppc.org>, <paulus@linuxcare.com.au>
Subject: Re: Patches for 2.4.0-test7
Date: Sat, 26 Aug 2000 18:41:01 +0200
Message-Id: <20000826164101.5951@192.168.1.10>
In-Reply-To: <39A7C246.7BB137EB@wanadoo.fr>
References: <39A7C246.7BB137EB@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>- The patch for arch/ppc/kernel/ppc_ksyms.c is necessary if you want to
>compile rtc as a module. If you don't want it as a module, you don't
>need to EXPORT these variables at all.

I'll merge that one.

>- The patch for include/asm-ppc/mman.h is necessary so that the loop
>device ("mount -o loop") works. I suppose the values for these MCL_*
>variables have been chosen by analogy to some other architectures, but
>they are already defined by glibc in /usr/include/bits/mman.h, so you
>can't take arbitrary values.

This one is waiting for Cort or Paul ack.

>- The patch for drivers/macintosh/Makefile is necessary for successful
>compilation if you have CONFIG_ADBMOUSE, but not CONFIG_ADB_KEYBOARD,
>which is possible with the latest version of the new input layer. (Not
>that the adbmouse works for me if I choose CONFIG_INPUT_ADBHID=y, but
>that's another story).

AFAIK, CONFIG_ADBMOUSE cannot be selected without CONFIG_ADB_KEYBOARD in
the current bk tree. I'm also doing additional config fixes, so that ADB-
less pmacs can remove all the ADB stuffs and keep the PMU for example.
CONFIG_ADB_KEYBOARD is not displayed when CONFIG_INPUT_ADBHID is, etc...

I though about making adbhid.c call the appropriate hooks in adbmouse to
make it work. After more thinking, I beleive it would be only bloat. Use
either the old drivers with your old userland setup, or the new drivers
with a new userland setup, with the mice all coming from /dev/input/mice.

>I have 3 other pet peeves that I would like to recall:
>
>- I think the new input layer with CONFIG_INPUT_ADBHID=y and
>CONFIG_MAC_ADBKEYCODES=y on an ISO (=European) ADB keyboard gives the
>wrong keycodes for the 2 keys with codes 10 and 50. Wrong in the sense
>that they differ from what all other kernels from the oldest times up to
>linux-pmac-devel before yesterday were giving. The tables,
>mac_keycodes[]
>in drivers/input/keybdev.c and adb_to_linux_keycodes[] in
>drivers/macintosh/adbhid.c, are probably correct. But then
>adbhid_input_register() in drivers/macintosh/adbhid.c swaps the 2 keys
>if it detects an ISO ADB keyboard. IMHO the swapping should occur for
>USB
>keyboards and not for ADB keyboards. I had some discussion with Franz
>which was not conclusive.

They need to be fixed in the userland keymaps. We had it wrong at first.
Some keyboards have those actually swapped, and Franz cold should be ok
(it was tested with all sorts of keyboards, AFAIK, and now, a fixed
keymap should give good results everywhere).

>- Paul's pmac-devel kernel still eats the LD_LIBRARY_PATH environment
>variable, therefore stopping Mozilla from running. This is so weird (but
>consistent since several months) that I have not the faintest idea where
>it could come from. It is a feature of linux-pmac-devel, not present in
>linux-bk-devel.

The two kernels are now in sync. Do you still have the problem ?

>- Finally: The ptrace code in 2.4.0-testX has a bug that prevents strace
>from working. I have no idea what's wrong, but it would be nice to have
>a working strace again.

AFAIK, Paul pushed a fix for that in bk a couple of days ago.

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
