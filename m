Message-ID: <40B3112A.30605@fh-landshut.de>
Date: Tue, 25 May 2004 11:26:02 +0200
From: Oliver Korpilla <okorpil@fh-landshut.de>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: How to get a safe range of PCI addresses?
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello!

I'm currently doing development for basic support of a MVME2100 with a
MPC8240 CPU on it, but my question is more general for the PowerPC.

How do I get a range of safe PCI addresses?

By safe I mean:

All these addresses should resolve to PCI bus cycles when accessed, but
not conflict with any device present in the system. Or the other way
round: These addresses must not (!) correspond to any device present.

The purpose is generating cycles a PCI-VME bridge can catch (it stores
in its registers to which addresses it will respond to by satisfying the
requests from VME bus transfers).

I tried allocate_resource(&iomem_resource, ...); , but it does not
actually provide what needed. In order to give meaningful results it
needs to be properly bounded - at least I guess so.

What I am needing is:
1.) a way to discover ranges of addresses, that resolve to PCI accesses,
without a device already occupying that range
2.) a way to reserve and free parts of that space
3.) either the physical address of that space to ioremap_nocache() it or
the virtual address if present
4.) the bus address of that space to store it in the the device registers

Can somebody please explain to me, what the PCI I/O Space is? Does this
correspond to I/O memory?

I attached some /proc info (mostly showing the Ethernet (Tulip) and the
bridge (Tundra Universe)).

Thanks in advance,
Oliver Korpilla

# cat /proc/pci
PCI devices found:
   Bus  0, device  13, function  0 (10e3:0000):
     Bridge: Tundra Semiconductor Corp. CA91C042 [Universe] (rev 2).
       IRQ 21.
       Master Capable.  Latency=128.  Min Gnt=3.
       Non-prefetchable 32 bit memory at 0xbffff000 [0xbfffffff].
       I/O at 0xbff000 [0xbfffff].
   Bus  0, device  14, function  0 (1011:0019):
     Ethernet controller: Digital Equipment Corporation DECchip 21142/43
(rev 65).
       IRQ 16.
       Master Capable.  Latency=128.  Min Gnt=20.Max Lat=40.
       I/O at 0xbfef80 [0xbfefff].
       Non-prefetchable 32 bit memory at 0xbfffec00 [0xbfffefff].
# cat proc/iomem
80000000-ffffffff : PCI host bridge
   bfffec00-bfffefff : Digital Equipment Corporation DECchip 21142/43
     bfffec00-bfffefff : tulip
   bffff000-bfffffff : Tundra Semiconductor Corp. CA91C042 [Universe]
# cat proc/ioports
00000000-00bfffff : PCI host bridge
   00bfef80-00bfefff : Digital Equipment Corporation DECchip 21142/43
     00bfef80-00bfefff : tulip
   00bff000-00bfffff : Tundra Semiconductor Corp. CA91C042 [Universe]
ffe10000-ffe10007 : serial(auto)


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
