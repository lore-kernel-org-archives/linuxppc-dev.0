Message-ID: <3A028FD1.854BC65A@mpifr-bonn.mpg.de>
Date: Fri, 03 Nov 2000 11:13:37 +0100
From: Albrecht Dre_ <ad@mpifr-bonn.mpg.de>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <bh40@calva.net>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Lombard Sleep Crash (Was: 2.2.18pre17 again)
References: <3A01882C.9C16CC60@mpifr-bonn.mpg.de> <19340927114124.27454@192.168.1.2>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:
> Can you lookup the panic PC, LR and backtrace in your System.map ? Also,
> if you could try to figure out what's up with /dev/adb... I suggest
> enabling the CONFIG_ALL_PPC (Prep/chrp/pmac). I beleive the problem could

PC=c00d11f4 		 -> c00d11dc t idepmac_wake_device
LR=c00d19d0 		 -> c00d1648 t idepmac_notify_sleep
Backtrace:	C01A99C8 -> c01a99a0 t pmac_unmask_irq
		C00D19D0 -> c00d1648 t idepmac_notify_sleep
		C0111AFC -> c0111ac0 t broadcast_wak
		C01B4904 -> c01b450c T powerbook_sleep_G3
		C011208C -> c0111fd8 t pmu_ioctl
		C003C49C -> c003c200 T sys_ioctl
		C000392C -> c000392c T syscall_ret_1

I recompiled with CONFIG_ALL_PPC=y in .config, but this did not change anything.
Was there a change of the major device number for /dev/adb? In
/var/log/messages, the startup of results in the following:

pmud[333]: pmud [treshold = 420, margin = 15] started
modprobe: modprobe: Can't locate module char-major-56
pmud[333]: Couldn't open /dev/adb
pmud[333]: daemon stopped (Couldn't open /dev/adb)

Thanks, Albrecht.

--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
