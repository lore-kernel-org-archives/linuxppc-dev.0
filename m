Message-ID: <3940614D.5BB18EF9@embeddededge.com>
Date: Thu, 08 Jun 2000 23:15:25 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Daniel Wu <Daniel.Wu@alcatel.com.au>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Using zImage.initrd
References: <00Jun9.083821est.115346@border.alcanet.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Daniel Wu wrote:

> .... Here is my output:
>
> loaded at:     00200000 0020B1E4
> relocated to:  00600000 0060B1E4
> board data at: 00600190 006001B8
> relocated to:  001F0100 001F0128
> zimage at:     00206000 00275065
> avail ram:     0060B1E4 02000000

It would be really nice if you weren't changing the link/load addresses.
I am not sure this is causing any problem, but it doesn't help.  The
code in the mbxboot directory makes assumptions about where things
were loaded.

The Makefile in this directory should contain the line:
	ZLINKFLAGS = -T ../vmlinux.lds -Ttext 0x00100000

In the 2.4 kernel this changed to:
	ZLINKFLAGS = -T ../vmlinux.lds -Ttext 0x00180000

because the kernel is larger.  If you have this problem in 2.2.xx, change
it like this.

The zImage bits should be loaded somewhere >= 0x200000.  If this
doesn't work for you, post a message explaining why and lets find
a solution.  These addresses are based upon lots of board samples,
and if yours doesn't fit, let's try to find something that works for
everything.

> Linux/PPC load: root=/dev/nfs rw

> VFS: Cannot open root device 00:00
> Kernel panic: VFS: Unable to mount root fs on 00:00
> Rebooting in 180 seconds..

In this case, you are trying to use NFS root disk without a network
device configured.  You need to enable one of the Ethernet (SCC or FEC)
options.


> Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
> NIP: C000D23C XER: 2000E32F LR: C00B8474 REGS: c00e6a90 TRAP: 0300

This is really early in the initialization, and something is really
messed up.  What processor are you running and what is the silicon
revision?  Do you have caches enabled?  Where did you get the kernel
sources?  What have you changed?


> C00FF71B C00B8474 C00B8648 C00FA2B4 C00F7774 C000221C

What is the rest of this backtrace?


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
