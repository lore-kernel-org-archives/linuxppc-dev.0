Date: Fri, 14 Sep 2001 10:01:54 +0200
From: Xavier Grave <grave@ipno.in2p3.fr>
To: embarque ppc <linuxppc-embedded@lists.linuxppc.org>
Subject: driver for the mvme5100
Message-ID: <20010914100154.A7161@ipnpcu5.in2p3.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

Sorry if somebody already read this question on linuxppc-dev.

I have written a module driver for the tundra chip universe (widely
inspired from
Gariel Paubert's one), it run's without problem on a mvme2303 but not on a
mvme5100.
The main difference is the hawk vs raven chip.
a cat /proc/iomem on the mvme5100 gives :
00000000-ffffffff : <BAD>
  f3f00000-f3f1ffff : Intel Corporation 82559ER (#2)
  f3f3d000-f3f3dfff : Intel Corporation 82559ER (#2)
    f3f3d000-f3f3dfff : eepro100
  f3f3e000-f3f3efff : Symbios Logic Inc. (formerly NCR) 53c895
  f3f3ff00-f3f3ffff : Symbios Logic Inc. (formerly NCR) 53c895
  f3f40000-f3f5ffff : Intel Corporation 82559ER
  f3f7e000-f3f7efff : Intel Corporation 82559ER
    f3f7e000-f3f7efff : eepro100
  f3f7f000-f3f7ffff : Tundra Semiconductor Corp. CA91C042 [Universe]
on the mvme2303 :
c0000000-feffffff : PCI host bridge
  effeef80-effeefff : Digital Equipment Corporation DECchip 21140
[FasterNet]
  effef000-effeffff : Tundra Semiconductor Corp. CA91C042 [Universe]
  fc000000-fc03ffff : Motorola Raven

in the driver there is two code lines :
pci_read_config_dword(carte.pci,PCI_BASE_ADDRESS_0,&tmp);
carte.bus_delta = carte.pci->resource[0].start - tmp;
on the mvme2303 it gives 0xc000 0000 which is the prep offset.
on the mvme5100 it gives 0. Since the mvme5100 is chrp-like I wait
for a 0x4000000 value or something different from zero ?

Does anybody have an idea ?

Thanks in advance, xavier

--
33 (0) 1 69 15 79 59
De chacun selon ses forces, a chacun selon ses besoins

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
