Date: Sun, 24 Oct 1999 18:45:08 +0200
To: linuxppc-dev@lists.linuxppc.org
CC: paulus@linuxcare.com, avatar@amdbox.calvacom.fr
From: BenH <bh40@calva.net>
Subject: iBook / UMA
Message-Id: <19991024184508.021611@smtp.calvacom.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've posted a first set of patches with a binary kernel at:

http://calvaweb.calvacom.fr/bh40/test.html

This one still contains obvious hacks and my iBook's PMU is shutting down
the machine on me way too often, but I managed to boot and use the
LinuxPPC Q3 installer with it.

 - There are big problems with the PMU. It seems to work with the same
basic protocol, but: I get occasional "ack still high" errors, I never
get the CB1 interrupt, and it began shutting the machine down on me
randomly when probing IDE or USB at boot since this evening. (It worked
with no changes from this morning to this evening though). I plan to look
into this later tonight.
Basically, I hacked to attach the ADB autopoll to the reception of the
0x40 bit in IFR in addition to the never coming CB1. This bit is
theorically a timer, and is asserted approximately every 10ms to my
testings. This one is probably the cause for the crash. I[m wondering if
the new PMU would be timing sensitive enough to break when interrupts are
disabled for too long while the PMU was inside a transaction. If this is
the case, we might have to revert to an old-style driver doing the PMU
request synchronously...
I've also disabled most of the keyboard/mouse probing stuff which seemed
to cause more trouble, the ADB trackpad emulation in the new PMU doesn't
like the probing code at all.
It's possible that the ADB interrupt (CB1) no longer exist on this new
PMU (which would be stupid) but it's also possible that it either
requires a specific command to be enabled (it could be disabled during
the BootX shutdown process) or that it goes to one of the new GPIO interrupts.

 - The interrupt routing and OpenPIC initialisation requires booting from
BootX with the PIC already initialized by MacOS. I'll fix that later,
this requires correct handling of the OF interrupt tree and cannot be
done when booting with BootX due to lack of phandle in the device tree
(MacOS doesn't keep them). That's the reason why I use the new
APPL.interrupt-vectors when available (they are created by MacOS). The
PIC is an IBM MPIC (it answers with the openpic 8 bits vendorID/deviceID
defined for the IBM MPIC2) but apparently either lacks the timer, or the
time is not correctly initialized (base set to 0x80000000).

 - The FCR management is not done yet (three FCR registers plus
still-to-be understood gpio registers).

 - PCI config space management is weird but Apple's bridge is weird too.
I really need to get rid of this hard-coded 0xf2000000 in the init code,
and we should use RTAS when OF-booting.

 - The IDE works, but I suggest you use noautotune for the HD.
Apparently, they have a new controller (Ultra/ATA ?) which doesn't like
the way we do DBDMA (it works but gives you a few errors first, then
resets the disk, and goes). The CD worked fine until it began giving me
all sort of errors, but it might be my distro CD beeing dirty.

 - Ethernet is not done at all yet. There are plenty of OF methods to be
decrypted here, it looks like an ordinary tulip-like or pcnet-like ring
buffer based controller, se we mostly need to figure out the ring entry
format, the OWN bit (and error bits) and enough registers to configure
the ring, start it, and kick it.

 - I've not tried the serial ports (which are detected) yet, but I
beleive the lack of FCR management will prevent the modem from working.

 - Sound is not done yet (we need to figure out what I2S is and how it works).

 - Video works only with offb, I've not looked in details however.

That's all for now,

Benjamin.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
