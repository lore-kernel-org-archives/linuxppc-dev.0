Subject: RE: PCI scanning and devices initialization
To: "Juergen.Beisert" <Juergen.Beisert@windriver.com>
Cc: "tnt" <tnt@246tnt.com>,
	"Stefano.Gaiotto" <Stefano.Gaiotto@marconi.com>,
	"linuxppc-embedded" <linuxppc-embedded@lists.linuxppc.org>
Message-ID: <OFF26F8F49.DBE7C455-ONC1256EF6.003F44A2@uk.marconicomms.com>
From: "Stefano Gaiotto" <Stefano.Gaiotto@marconi.com>
Date: Fri, 20 Aug 2004 13:40:26 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks Juergen,

I don't know exactly what is a "PCI to anything" bridge, anyway u-boot
bridge (60x/PCI) initilaization code seems to be almost identical to that
in Linux.
Anyway, I get the same result both in u-boot and Linux...


Linux:

# cat iomem
80000000-9fffffff : PCI prefetchable memory
a0000000-afffffff : PCI memory
#
# cat ioports
00000000-00ffffff : PCI I/O
#
# cat pci
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Motorola MPC8265A/MPC8266 (rev 32).
      Master Capable.  Latency=248.
      Non-prefetchable 32 bit memory at 0x0 [0x1ffff].
      Prefetchable 32 bit memory at 0x0 [0x3ffffff].
#


u-boot:

...
PCI Autoconfig: Memory region: [80000000-8fffffff]
PCI Autoconfig: I/O region: [a0000000-afffffff]
...



=> pci
Scanning PCI devices on bus 0
BusDevFun  VendorId   DeviceId   Device Class       Sub-Class
_____________________________________________________________
00.00.00   0x1057     0x18c0     Bridge device           0x00
00.00.01   0x1057     0x18c0     Bridge device           0x00
00.00.02   0x1057     0x18c0     Bridge device           0x00
00.00.03   0x1057     0x18c0     Bridge device           0x00
00.00.04   0x1057     0x18c0     Bridge device           0x00
00.00.05   0x1057     0x18c0     Bridge device           0x00
00.00.06   0x1057     0x18c0     Bridge device           0x00
00.00.07   0x1057     0x18c0     Bridge device           0x00
=>


Regards,
      Stefano Gaiotto





Juergen.Beisert@windriver.com on 18/08/2004 15:28:11

To:    tnt@246tnt.com, Stefano.Gaiotto@marconi.com
cc:    linuxppc-embedded@lists.linuxppc.org

Subject:    RE: PCI scanning and devices initialization


Hi,

> Yes, there may be something wrong with your hardware.

This could only be _one_ reason

> At the PCI init, PCI devices don't yet have an address, so the host
> detects them using configuration cycles. Theses uses a different
> addressing scheme, using each address line as a kind of "chip select".
> So the devices know the host is "talking" to it just by
> looking at it's
> IDSEL line going asserted. If on your board the IDSEL isn't wired
> properly then it won't work. Hopefully if that's the case,
> you can just
> wire it by hand, it's not a high speed signal.

Does the U-Boot PCI setup routine handles PCI devices behind a "PCI to
anything" bridge? Sometimes simple code ignores bridges. Don't know the
current U-Boot implementation. If not, there is no chance to access any
devices behind it (even if the hardware is correct).

JB


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
