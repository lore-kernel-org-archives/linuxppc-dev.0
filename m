Message-Id: <200004040601.IAA00488@piglet.grunz.lu>
Date: Tue, 4 Apr 2000 08:01:51 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: LongTrail PCI resource assignment
To: schmitz@opal.biophys.uni-duesseldorf.de
cc: geert@linux-m68k.org, michdaen@iiic.ethz.ch, paubert@iram.es,
        bh40@calva.net, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.LNX.4.10.10004031854280.15106-200000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi there,

On   3 Apr, this message from Michael Schmitz echoed through cyberspace:
>> > - OF reports two base addresses for the Mach64, one of which is the I/O
>> > region (according to the PCI BAR values) at 0xc00. OF reports its address
>>                                               ^^^^^
>> Where does that address come from? I'm missing something here..
>
> Straight from the BAR for region 1, with the resource type bits masked
> off. BTW lspci also reports this.

Ahhh... ok. In that case, it's a possible value.

>> > as 0x80881000 or some such. Does this mean the I/O registers are
>> > accessible at 0x80881000, or did OF probing get some bogus values there?

When looking at what OF assigned, always check the BAR value in OF's
properties; they are not necessarily all in the same order all the
time. Here's for example what I have on my machine for my Matrox:

[mlan@piglet /proc/device-tree/bandit/MTRX,Millennium@F]$ hexdump reg
0000000 0000 7800 0000 0000 0000 0000 0000 0000
0000010 0000 0000 0200 7810 0000 0000 0000 0000
0000020 0000 0000 0000 4000 4200 7814 0000 0000
0000030 0000 0000 0000 0000 0080 0000
000003c
[mlan@piglet /proc/device-tree/bandit/MTRX,Millennium@F]$ hexdump assigned-addresses
0000000 c200 7814 0000 0000 8100 0000 0000 0000
0000010 0080 0000 8200 7810 0000 0000 8080 0000
0000020 0000 0000 0000 4000
0000028

The reg property has 3 entries, where the second and third represent
BARs at 0x10 and 0x14; however, assigned-addresses has these in reverse
order...

If you look at your properties, here is their meaning:

 <flags> <bus-hi> <bus-lo> <processor> <size>

All elements are 32 bits; the BAR value is in the last byte of <flags>.
You'll see that in reg, <processor> is not set; that's because reg
represents the address requests of the device before attribution.

<bus-hi> and <bus-lo> form a 64-bit PCI bus address; on 32-bit systems,
<bus-hi> is zero. assigned-addresses is what OF gave your device.

> 0xfe000000 is what pmac_pci.c uses for my machine (processor physical as
> well as virtual). I'm not trying to change that, I just didn't understand
> the address reported by OF for that region. I still don't understand it.

Can you verify your OF properties, to check whether OF _really_ assigned
a region for the IO ports at 0xc00? I doubt it...

>> If you remap the MMIO range, you need to do two things:
>>
>> 2. change the values stored in struct pci_dev, so that the kernel at
>> large (that includes other drivers, and the interface used by lspci)
>> knows about it.
>
> That's what I missed. I changed the value in the OF tree but forgot the
> PCI side.

Changing the OF device tree is nice, but probably too much hassle.
The struct pci_dev, on the other hand, is vital.

Have fun!

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
