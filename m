Message-Id: <200003052129.PAA46273@congo.borg.umn.edu>
Subject: Re: HELP: Power Mac G3 PCI Strangeness in 2.2 and 2.3
Date: Sun, 5 Mar 2000 13:30:46 -0800
From: Grant Erickson <grant@borg.umn.edu>
To: "Ani Joshi" <ajoshi@shell.unixbox.com>
cc: <linuxppc-dev@lists.linuxppc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 3/3/2000 7:39 PM, Ani Joshi wrote:
>On Fri, 3 Mar 2000, Grant Erickson wrote:
>
>>
>>         for (i = 0; i < 10000000; i++) {
>>                 pci_read_config_word(dp, PCI_VENDOR_ID, &data);
>>                 if (data != 0xFFFF)
>>                         break;
>>                 pci_read_config_word(dp, PCI_DEVICE_ID, &data);
>>                 if (data != 0x0000)
>>                         break;
>>         }
>>
>>         for (i = 0; i < 100000000; i++)
>>                 readl(chip);
>
>	why do you do these loops 100000000 times?

So I can  capture traces on the logic analyzer. Sure, I could just
trigger on a one-time event, but this allows me to do an on-the-fly
capture and get some data.

>> 	if (readl(chip) != 0x00000103)
>> 		printk("Bad Chip ID!\n");
>
>	have you tried printking readl(chip)?  what you're expeciting it
>to be may not be correct or you may have to use a slightly different load
>instruction.  btw, you can use pci_resource_{start,end,len}(pdev, res)
>instead of computing length and all.

Yes. I actually ended up figuring all this out not long after I sent out
the e-mail on Friday.

As reported earlier, after instrumenting the PowerPC machine's PCI bus
with a logic analyzer and running a series of tests, I noticed the
following things:

        1) PCI configuration accesses function normally and within spec
           as evidenced by both correct software operation and waveform
           analysis on the logic analyzer.

        2) With the chip's memory space enable bit activated, read
           accesses to the Chip ID register failed to generate any
           PCI bus traffic of any sort and most definitely resulted
           in failed software operation.

After modifying the Linux kernel to accept PCI devices with the invalid
vendor/device ID combination of 0xffff/0x0000, I noticed something odd
about the way the system PROM (and to a lesser extent Linux) configured
the chip's base addresses. Looking at a number of other devices in the
system:

        grant@marathon% cat /proc/iomem
        81800000-8180001f : PCI device 1022:2000 AMD Lance Ethernet
        81900000-819fffff : PCI device 1022:2000 AMD Lance Ethernet
        82000000-82ffffff : PCI device 1002:4754 ATI Mach 128
        f3000000-f307ffff : PCI device 106b:0010 Apple Heathrow I/O
        fffc0000-ffffffff : PCI device ffff:0000 ???

Clue 1: The address range programmed for the chip looks suspiciously like
the state it might be left in after determining how much address space it
needs.

Before Linux does this address space sizing, it saves the base address.
In the case of my chip, it would have read "0x0" since nothing was
programmed there previously. If Linux does find 0x0, it just leaves the
result of the address sizing there and moves on.

So, that led me to wonder where the addresses in the other devices were
coming from...

I found that even before Linux executes a single line of code, all the
other devices above have valid addresses programmed into their base
address registers. Who's doing this?

I believe that the Open Firmware PROM in the PowerPC system probes all
PCI devices in the system at power up. It then assigns valid base
addresses to those devices with VALID vendor and device IDs.

Because my chip uses an invalid vendor ID of 0xFFFF, Open Firmware must
just ignore it and never programs in a valid base address! Therefore,
when we go and try to access the chip at 0xFFFC0000 (which is outside the
valid PCI address space on PReP/CHRP/PowerMac systems?) we're off probing
never-never land. The PCI controller never assumes the transaction!

So, if I fixup the chip's base address register to something like
0x83000000 beforehand, everything works fine! The problem is that I'm not
sure I can unilaterally guarantee 0x83000000 will be available every time
as I don't know the boot ROM's mapping strategy.

 Grant Erickson                       University of Minnesota Alumni
  o mail:grant@borg.umn.edu                               1996 BSEE
  o http://www.tc.umn.edu/~erick205                       1998 MSEE


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
