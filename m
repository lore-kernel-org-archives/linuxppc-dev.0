Mime-Version: 1.0
Message-Id: <p04330100b63f9bce42dd@[192.168.0.1]>
Date: Mon, 20 Nov 2000 23:03:43 -0500
To: linuxppc-dev@lists.linuxppc.org
From: Stefan Jeglinski <jeglin@4pi.com>
Subject: whacked out 2.2.18preX - last gasp
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


[refer to all previous whacked out posts]


In deference to BenH's necessary suggestion, I removed all of the 6
cards I could from my PowerTowerPro. It's now down to the only 2 I
need: a video card (imstt running the OFfb just fine like it always
has) and the 2940UW card, connected to my 2 9Gig atlas drives. I
can't do fewer cards than these, and I've tried them in different
slots.

Thanks to Hollis, I learned how to determine that a kernel panic at
boot occurs in ioremap, called by the aic7xxx driver (backtrace
posted the other day). If I compile without the aic7xxx driver, the
panic does not occur but of course I cannot mount the root device.

The following kernels fail identically:

ppc.samba.org::linux-pmac-stable-2.2.18preX
ppc.linuxcare.com:: linux-pmac-stable-2.2.18preX
penguinppc.org:: linux-pmac-stable-2.2.18preX
bk://bitkeeper.fsmlabs.com:5001 (2.2.18preX)

(yes, every X I've tried for about a month now)

The following kernels work fine:
linux-pmac-stable (2.2.17)
penguinppc.org::linux-pmac-benh (2.2.18pre17)

I want 2.2.18 because it appears to have the full USB backport
(according to linux-usb.org). Also AFAICT, the "backports" on
linux-usb.org are really patches to take 2.2.17 to 2.2.18preX - they
don't really "add USB to 2.2.17."

I don't know why Ben's 2.2.18pre17 alone works, but it appears to be
irrelevant because of Ben's statement that all his rsync trees are
inactive. The only clue I have is both odd and almost totally
irrelevant: the only kernels that work (both 2.2.17 and 2.2.18) are
the ones that create a

	ERROR - Attempting to write value for
	unconfigured variable (CONFIG_SERIAL_CONSOLE).

when using make xconfig. I can't see how this could be related, but it is true.

It's frankly hard at this point to buy that one of my PCI devices is
walking over the kernel. Or if it is, it looks like the end of the
Linux line for my PowerTowerPro with the 2940 card. I think this is
either a bug in the aic7xxx driver that has been exposed by 2.2.18
changes (highly doubtful, there are too many 2940s out there for it
to have been missed), or a linux-pmac bug. I just don't know enough
yet to prove it, much less find it.



c-ya



Stefan Jeglinski

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
