Message-ID: <39A8379C.E4EBB33A@wanadoo.fr>
Date: Sat, 26 Aug 2000 23:33:16 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <bh40@calva.net>
CC: linuxppc-dev@lists.linuxppc.org, paulus@linuxcare.com.au
Subject: Re: Patches for 2.4.0-test7
References: <39A7C246.7BB137EB@wanadoo.fr> <20000826164101.5951@192.168.1.10>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:

> >- The patch for drivers/macintosh/Makefile is necessary for successful
> >compilation if you have CONFIG_ADBMOUSE, but not CONFIG_ADB_KEYBOARD,
> >which is possible with the latest version of the new input layer. (Not
> >that the adbmouse works for me if I choose CONFIG_INPUT_ADBHID=y, but
> >that's another story).
>
> AFAIK, CONFIG_ADBMOUSE cannot be selected without CONFIG_ADB_KEYBOARD in
> the current bk tree. I'm also doing additional config fixes, so that ADB-
> less pmacs can remove all the ADB stuffs and keep the PMU for example.
> CONFIG_ADB_KEYBOARD is not displayed when CONFIG_INPUT_ADBHID is, etc...

Someone recently wrote that one could have both /dev/adbmouse and
/dev/input/mice working at the same time, so I tried this, too. And I
*could* select CONFIG_ADBMOUSE without CONFIG_ADB_KEYBOARD, only it
didn't compile due to undefined variables. My patch fixes these, but
indeed it is probably better to change the config.in files to forbid
this choice.

> >I have 3 other pet peeves that I would like to recall:
> >
> >- I think the new input layer with CONFIG_INPUT_ADBHID=y and
> >CONFIG_MAC_ADBKEYCODES=y on an ISO (=European) ADB keyboard gives the
> >wrong keycodes for the 2 keys with codes 10 and 50. Wrong in the sense
> >that they differ from what all other kernels from the oldest times up to
> >linux-pmac-devel before yesterday were giving. The tables,
> >mac_keycodes[]
> >in drivers/input/keybdev.c and adb_to_linux_keycodes[] in
> >drivers/macintosh/adbhid.c, are probably correct. But then
> >adbhid_input_register() in drivers/macintosh/adbhid.c swaps the 2 keys
> >if it detects an ISO ADB keyboard. IMHO the swapping should occur for
> >USB
> >keyboards and not for ADB keyboards. I had some discussion with Franz
> >which was not conclusive.
>
> They need to be fixed in the userland keymaps. We had it wrong at first.
> Some keyboards have those actually swapped, and Franz cold should be ok
> (it was tested with all sorts of keyboards, AFAIK, and now, a fixed
> keymap should give good results everywhere).

I wouldn't mind changing the keymaps, but I really would like to use the
same keymaps for 2.2.x kernels, for 2.4.0-test kernels with
CONFIG_ADB_KEYBOARD and with CONFIG_INPUT_ADBHID.

> >- Paul's pmac-devel kernel still eats the LD_LIBRARY_PATH environment
> >variable, therefore stopping Mozilla from running. This is so weird (but
> >consistent since several months) that I have not the faintest idea where
> >it could come from. It is a feature of linux-pmac-devel, not present in
> >linux-bk-devel.
>
> The two kernels are now in sync. Do you still have the problem ?

Yes, it is still there, I just verified. There must be some difference
between Paul's kernel and the bitkeeper tree that causes this. Here is
another strange observation:

I type "printenv", and LD_LIBARY_PATH is listed with the other env
variables (with "env", it does not get listed). Now I use the newly
recovered strace (see below) to try to understand what printenv does
differently from env. Well, "strace printenv" does not show
LD_LIBARY_PATH any more!

> >- Finally: The ptrace code in 2.4.0-testX has a bug that prevents strace
> >from working. I have no idea what's wrong, but it would be nice to have
> >a working strace again.
>
> AFAIK, Paul pushed a fix for that in bk a couple of days ago.

Yes, sorry, you are right. strace works again. I had tried it with a
kernel from 2 days ago. I see now Paul's yesterday's 1-line fix in
arch/ppc/kernel/entry.S. Very good!
>
> Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
