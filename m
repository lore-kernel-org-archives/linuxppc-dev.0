Date: Sat, 16 Oct 1999 19:14:21 +0200
To: linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: need Open PIC infos
Message-Id: <19991016191421.027499@smtp.calvacom.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi !

I'm working on support for new UMA machines (beginning with iBook). I
have already figured out a lot of things and am now coding a very
preliminary support (I'm not sure yet the PMU99 will work out of the box
or not, but it looks similar to the old PMU from an interface point of view).

However, the new Apple ASICs contains an Open PIC interrupt controller
(advertised as beeing a "chrp,open-pic" controller). After looking at the
various docs I have and a quick search on Altavista, I couldn't find any
relevant documentation on the chip.
There's already some OpenPIC support in the kernel, but I'll have to
change it a little bit since, for example, Apple hardware is not a good
place to search for a 8259 master ;)
I'd like some docs in order to have better understanding of the chip.

Anyone knows if such a doc exist ? Apparently, if the register map is not
completely bogus, the current code returns an OpenPIC versio 1.2, and the
timer freq is 0x80000000 (ouch !). 

Side note: the Keylargo IC contains the open-pic and the SCC cells at the
exact same location as Hydra, things don't change so much ;) But the new
chip contains a lot new things.

The Uni-North is a rather weird beast. It appears in the device tree as 4
devices on the root level:

 /uni-n (the memory controller part)
 /pci
    /agp stuffs
    /ATI
 /pci
    /mac-io (KeyLargo is here)
    /usb
    (/slots ?)
 /pci
    /ethernet
    (/firewire on some machines)

All 3 "pci" nodes corresponding apparently to the various internal
busses: the AGP, the ethernet/firewire, and the mac-io/usb, I beleive the
external pci is on the mac-io/usb part).
The annoying thing is that all the 3 pci nodes have the same bus number.
(devices below those have various non-conflicting device number) but all
3 has different pairs of registers to access config space. This makes the
config access code a bit weird since it has to lookup the OF node of the
device in the device tree, get the parent "pci" node, etc... but It
should work this way.

-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
