Date: Fri, 3 Nov 2000 22:51:04 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Albrecht Dreﬂ <ad@mpifr-bonn.mpg.de>
cc: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Lombard Sleep Crash (Was: 2.2.18pre17 again)
In-Reply-To: <3A02B060.4C470BFB@mpifr-bonn.mpg.de>
Message-ID: <Pine.LNX.4.10.10011032246590.26034-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > Did all your kernels that crash lack ADB support, or just the latest you
> > built with CONFIG_ALL_PPC=y ?
>
> Just the latest rsync'ed linux-pmac-stable from penguinppc.org. Before, I always
> used Ben's (rsync'ed) kernels, and configured them for PowerMac's only. No
> problems with starting pmud. Now, both configuring for PowerMac only and for
> ALL_PPC have no /dev/adb. I'm afraid I have to dig into the sources...SIGH!

The reason is simple: adbdev_init() is now declared as module_init, and no
longer called from drivers/char/mem.c (which used to call all chardev init
functions). However, the adbdev code is not built as a module, rather
compiled in. What were you trying to achieve here, Paul?

I guess just adding back the adbdev_init() call to mem.c should restore
pmud to function. Or try forcing a build of adb.o as module.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
