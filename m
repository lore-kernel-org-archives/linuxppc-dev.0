Date: Tue, 27 Nov 01 10:27:58 PST
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0111271827.AA24645@ivan.Harhan.ORG>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: VT82C686B IDE and Linux/PPC woes
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Adrian Cox <adrian@humboldt.co.uk> wrote:

> You're probably lacking the other IDE setup functions as well, then.
> Take a look at the sandpoint code as an example.

No, the problem turned out to be elsewhere. I just got it to work, and I didn't
need any more IDE functions in my board port except the ppcmd.ide_init_hwif I
posted. It saw the drive when I removed the pciauto_bus_scan() calls from my
adir_find_bridges, i.e., let it inherit the PCI enumeration from StarMON and
not re-enumerate it again. I have to admit that the Adirondack memory map is
fragile. It works as we've made it work in our firmware, and my hardware/
firmware manual warns against changing it. I can see how Linux redoing its own
PCI enumeration turns out not good in this case.

Now to change the Adirondack port to not use pciauto_bus_scan() I'll have to
make a few other changes to its memory map, and I'd rather do it all at once.
I'll post the patch when I have it.

MS

P.S. When I took the pciauto_bus_scan() calls out, it saw the drive, but hung
on the partition check. Disabling the VIA82CXXX support .config and leaving
only the generic PCI IDE support made it really work. I guess the VIA82CXXX
fast modes code still has issues to be worked out. Maybe it's because it
assumes there is a BIOS and in my case there isn't one. (My minimalist firmware
does not touch any VT82C686B IDE stuff at all, and yet if I want I can pull the
IDE register addresses out of the BARs and see the drive there using ancient
WD100x code.)

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
