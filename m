Message-ID: <40AB03EB.7040105@fh-landshut.de>
Date: Wed, 19 May 2004 08:51:23 +0200
From: Oliver Korpilla <okorpil@fh-landshut.de>
Reply-To: okorpil@fh-landshut.de
MIME-Version: 1.0
To: "Heater, Daniel (GE Infrastructure)" <Daniel.Heater@gefanuc.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Differing PCI layouts trigger porting driver problem [Was: Memory
 layout question]
References: <DB1DE297F535B340AEAE1E51B221C3D0016B3DCB@FTWMLVEM02.e2k.ad.ge.com>
In-Reply-To: <DB1DE297F535B340AEAE1E51B221C3D0016B3DCB@FTWMLVEM02.e2k.ad.ge.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello, Daniel!

I think I very much erred when trying to identify the error - the
problem is a memory layout one, but a PCI related one.

The driver works on x86 because the PCI bus and the CPU physical
addresses match - the Universe Master Window Base Register (LSI_BSx) is
given the start address of the address range to map (the set of
addresses on the PCI bus the Tundra Universe chip will try to answer
to). In the driver the Universe is till now given the CPU physical address.

But the Tundra Universe is a PCI device. All the addresses it sees need
to be bus addresses, not CPU physical ones. This is - if I figured it
out correctly - because of the host-to-PCI-bridge mapping. All physical
addresses dereferenced by the CPU will correctly translate to their
corresponding mapped PCI bus addresses because of the host bridge, but
if you want the Universe chip to catch those addresses, it needs to have
the bus address stored in its registers (the address matching the
original physical address after the host-bridge translation).

So I hope this can actually resolved by converting the address to a bus
address and storing that. Doing this will keep the module portable,
because the mapping would resolve to identity on x86, or at least I
think so.

I guess the correct new order would be:
allocate_resource(&iomem_resource, ... ) to obtain a range of physical
addresses, ioremap_nocache that physical start address to obtain virtual
addresses for the ->virt pointer in the master window structure (now
done in vme_master_window_map() I think), and then use virt_to_bus () to
obtain the address to store in the master window base register. Then the
driver should work both on (nearly) arbitrary setups for x86 and PPC.

Of course I have to try that out first (I'm still home now), and let you
know if that produced any results. Did VMIC run into similar problems
when trying to run the driver module on the VMIVME7050 (750FX/GX IBM
PowerPC board)? Because it is not yet in the list of supported boards?

Thanks for the reply!

With kind regards,
Oliver Korpilla

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
