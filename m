Mime-Version: 1.0
Message-Id: <p04330100b640f3ea5e75@[192.168.0.1]>
Date: Tue, 21 Nov 2000 23:20:57 -0500
To: linuxppc-dev@lists.linuxppc.org
From: Stefan Jeglinski <jeglin@4pi.com>
Subject: whacked out 2.2.18preX - slot summary
Cc: Benjamin Herrenschmidt <bh40@calva.net>
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Quick summary: linux-pmac-stable-2.2.17 works fine in 6-slot
PowerTowerPro with 6 cards, one of which is a 2940UW. Every pmac
version of 2.2.18 fails to boot. PCI devices installed, top to
bottom, are:

Adaptec 2940UW
Farallon ethernet 10/100
OrangeLink firewire/usb combo
Matrox Mystique card
ixMicro TV card
ixMicro Twin Turbo card [aka imstt]


Removed all cards except 2940UW and imstt, and then tried the 2940UW
in every slot. I've always had the 2940UW in the top 3 slots. This is
the first time I've ever tried the lower slots. To my surprise,
-neither- kernel works in with the 2940 in the lower slots, but it's
because the 2940UW is not even -seen- there.

Results:

2940UW       2.2.18        2.2.17

slot 1         x             ok    (imstt in slot 6)
slot 2         x             ok    (imstt in slot 6)
slot 3         x             ok    (imstt in slot 6)
slot 4         *             *     (imstt in slot 6)
slot 5         *             *     (imstt in slot 6)
slot 6         *             *     (imstt in slot 5)
slot 6         *             *     (imstt in slot 2)
slot 6         *             *     (imstt in slot 1) [&&]


The legend is:

x:  at boot, machine check (unknown value in srr1), kernel panic
     due to crash in ioremap when called by aic7xxx driver.

*:  2940UW card not even recognized. IOW, no messages regarding
     2940UW, boot jumps straight to detecting the internal and external
     SCSI, then cannot mount root device. This is the same result as
     when I leave the aic7xxx driver out of the compile.

I've never been able to detect the matrox card in the lower slots
where it normally resides. This appears to not be surprising.
However, I've always had the imstt in slot 6, and it is detected fine.

Clearly for now, my 2940UW must remain in the top 3 slots. If anyone
has any clues on why 2.2.18 no longer works, I'd greatly appreciate
it (wanting to get the Orangelink+USB going).

P.S. to BenH: I sent you the complete MacOS name registry file for
all 6 cards earlier today. I also have a name registry file for the
case marked [&&] above, if it will help.


Stefan Jeglinski

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
