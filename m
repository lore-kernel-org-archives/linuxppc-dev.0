Date: Mon, 25 Oct 1999 22:36:13 +0200
To: linuxppc-dev@lists.linuxppc.org
CC: jmb@montana.edu
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: iBook/UMA pre3
Message-Id: <19991025223613.011624@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I updated the patches and kernel to a new version. PCI config is fully
working now, USB works too. I'n now running MacOS under mac-on-linux (the
new version that doesn't require you to patch the kernel) on linux on the
iBook ;)

I had to hack horribly in the arch/ppc/kernel/prom.c code that parses the
"interrupt-map" property, I'll do a cleaner fix later this week.

The PCI code looks good (but I'd prefer using RTAS) and should support
bridges on the "middle" bus of uni-north (the one at f2000000 - if you
have a better idea to identify this one, tell me !). So PCI should work
on G4 and new iMac's too.

I didn't fix the ADB interrupt yet (and I'm wondering if my timer is the
cause of the large amount of BAD interrupts I'm getting all the time),
I'll look into this later too.

The kernel seems stable. Things are slow, especially with X, since the
hard disk is very slow (1.1Mb/sec). This will be better once I have
figured out how to set it to a better PIO mode, use DMA on it, and
eventually use this new Ultra/ATA feature (are there specs for this ?
Mine are still ATA-3 specs).

Have fun !

Benjamin.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
