Date: Fri, 3 Nov 2000 13:22:10 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Albrecht Dreﬂ <ad@mpifr-bonn.mpg.de>
cc: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Lombard Sleep Crash (Was: 2.2.18pre17 again)
In-Reply-To: <3A028FD1.854BC65A@mpifr-bonn.mpg.de>
Message-ID: <Pine.LNX.4.10.10011031315320.2558-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> PC=c00d11f4 		 -> c00d11dc t idepmac_wake_device

Can you disassemble the kernel and look up where approximately in
idepmac_wake_device the panic happens?

> I recompiled with CONFIG_ALL_PPC=y in .config, but this did not change anything.
> Was there a change of the major device number for /dev/adb? In
> /var/log/messages, the startup of results in the following:
>
> pmud[333]: pmud [treshold = 420, margin = 15] started
> modprobe: modprobe: Can't locate module char-major-56
> pmud[333]: Couldn't open /dev/adb
> pmud[333]: daemon stopped (Couldn't open /dev/adb)

Nope, /dev/adb remains unchanged, just ADB mice aren't necessarily read
via the adbmouse device anymore (but that was misc minor 10, the patch to
handle keyboard and mouse data as separate ADB devices in the ADB major
range never made it in).

Make sure you the core adb support is compiled in. It currently is, unless
CONFIG_MBX is set ... if CONFIG_ALL_PPC=y implies CONFIG_MBX=y, someone
better fix this.

Did all your kernels that crash lack ADB support, or just the latest you
built with CONFIG_ALL_PPC=y ?

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
