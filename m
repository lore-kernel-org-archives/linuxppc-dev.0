Date: Tue, 6 Aug 2002 21:02:50 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: PCI/SCSI help
To: acurtis@directvinternet.com
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <NCBBIINEHIPFGJPLBEIFIEGCDKAA.acurtis@directvinternet.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Message-Id: <E17c9bc-00006u-00@piglet.grunz.lu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On   5 Aug, this message from acurtis@directvinternet.com echoed through cyberspace:
>> > PCI Autoconfig: Device 15, Vendor 0x1000, Class 0x1000001
>> > PCI Autoconfig: Found Bus 0, Device 15, Function 0
>> > PCI Autoconfig: BAR 0x10, I/O, size=0x100, address=0x7ffff00
>> > PCI Autoconfig: BAR 0x14, Mem size=0x400, address=0x7fffc00
>>                             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> These two overlap. Firmware in Intel mode with separate IO and mem
>> spaces?
>
> It would appear that these overlap but since we are talking about base
> addresses on the PCI bus and different types of bus cycles, it is ok.

Yes, as long as the bridge maps memory and IO to different,
non-ovrlapping memory ranges on the CPU side...

>> > sym53c8xx: at PCI bus 0, device 15, function 0
>> > sym53c8xx: 0x07fffc00 = pci_get_base_address(base)
>> > sym53c8xx: 0x07ffc000 = pci_get_base_address(base_2)
>>
>> What's it doing with these values? Where does it get them from? Those
>> are the original, un-moved addresses. Both BAR and pci_dev should have
>> been changed by pcibios_fixup_resources(). Have a look at that code and
>> see why the corrected base addresses are not written back.
>
> On the PCI bus itself the Memory and I/O addresses are 0 based so these BAR
> values are ok. From the host bus the addresses are 0x4ffffc00 and
> 0x4fffc000.

Hmm, wondering who is supposed to adjust for the offset between CPU and
PCI bus....

>> > sym53c8xx: 53c895a detected
>> > sym53c895a-0: rev 0x1 on pci bus 0 device 15 function 0 irq 19
>> > sym53c8xx: device->slot.base = 0x07fffc00
>> > sym53c8xx: device->slot.base_2 = 0x07ffc000
>>                                  ^^^^^^^^^^^^
>> Nope, wrong again.
>
> Yup, these are the BAR's. The host addresses to the PCI bus are translated
> into 0 based addresses on the bus.

OK, but the driver should not use PCI-view addresses, but CPU-view ones.

>> > sym53c8xx: ncr_script_copy_and_bind(src 0xc04f7ce0, dst 0xc04be054)
>> > sym53c8xx: ncr_script_copy_and_bind(src 0xc04f7ce0, dst 0xc04be054)
>> > sym53c8xx: 0xf0ccff07 = cpu_to_scr(0x07ffccf0) /* just byte swapping */
>>              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> I hope it's not byteswapping an address here?
>
> That is a good question. PCI is little-endian, PowerPC is big-endian. When
> should the addresses be swapped. When aren't they swapped by the lower
> levels?

You _never_ swap addresses. It's not the address that's different on
little- or big-endian systems, it's the ordering of multi-byte data
values.

Cheers

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
