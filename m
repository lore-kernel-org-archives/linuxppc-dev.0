Message-Id: <199906181427.KAA06605@linus.mitre.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: debugging ideas wanted
Date: Fri, 18 Jun 1999 10:27:34 -0400
From: Charles Frederick Lepple <clepple@linus.mitre.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I am still in the process of getting LinuxPPC ported to a Dy4
SVME-177 card, and so far, the card boots to the point where an
initial console would be opened. The network driver (a variation of
sonic.c) works enough to get an IP address, and to mount the root
filesystem over NFS. For debugging output, I have a simple polled
I/O routine for the serial console. This works nicely before the
ttyS0 device (on the same serial channel) is opened.

The problem is that the board locks up hard _after_ the console is
opened, and I cannot seem to trace exactly where it is dying. The
general symptoms include a lack of network responsiveness, and an
all-around unresponsiveness to interrupts (including the
decrementer, which I hacked to blink the front-panel LED every so
often a la APUS).

This being a VME-based system, I can use another VME card to do
memory dumps even while the system is hung (the VME bridge doesn't
seem to care much), but with over a megabyte of code and data to
sift through, I don't know where to look for any signs of where it
locked up.

So I'm open to suggestions from people who have had to track down
this kind of weirdness. Specifically, does anyone have any tips to
pass along about kgdb, xmon and the like? There is an 8530 SCC chip
on board; if this will talk to xmon, great (all I know about xmon is
what I can see in the kernel source, so forgive my ignorance on this
one).

Thanks in advance,

--Charles Lepple
clepple@mitre.org

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
