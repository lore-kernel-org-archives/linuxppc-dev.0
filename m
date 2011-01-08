Return-Path: <gary@mlbassoc.com>
Received: from mail.chez-thomas.org (hermes.mlbassoc.com [64.234.241.98])
	by ozlabs.org (Postfix) with ESMTP id 1F693B715B
	for <linuxppc-dev@ozlabs.org>; Sun,  9 Jan 2011 00:07:11 +1100 (EST)
Message-ID: <4D28617A.8020606@mlbassoc.com>
Date: Sat, 08 Jan 2011 06:07:06 -0700
From: Gary Thomas <gary@mlbassoc.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: PCI woes with 2.6.37
References: <4D279C90.8000006@mlbassoc.com>
	<1294472036.17779.253.camel@pasglop>
In-Reply-To: <1294472036.17779.253.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Linux PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/08/2011 12:33 AM, Benjamin Herrenschmidt wrote:
> On Fri, 2011-01-07 at 16:06 -0700, Gary Thomas wrote:
>> I just tried porting my target (MPC8347) from 2.6.28 (remember
>> that one?) to 2.6.37.  Recently I tried this with 2.6.32 without
>> a lot of success, so I thought I'd try the latest :-)  The changes
>> are very simple, pretty much just the addition of my 8347 based
>> platform DTS.
>>
>> Sadly, it fails even worse than it did on 2.6.32.
>>
>> For some reason, although everything seems to report that the
>> PCI bus is alive, MEM access fails completely.  If I try to
>> access various PCI devices via their memory space (I only have
>> memory peripherals so I can't test IO space access), I get
>> what I assume are BUS timeouts - all 0xFFFFFFFF
>>
>> My PCI bus is defined in DTS like this:
>
>>     		ranges =<0x02000000 0x0 0xC0000000 0xC0000000 0x0 0x20000000
>
> What are the #address-cells and #size-cells properties of the parent of
> the PCI controller node ?
>
> PCI has 3 cells, so that accounts for the first 3 numbers of each of
> these. That leaves only 3 numbers, so either you have #address-cells = 1
> and #size-cells = 2 or the other way around.
>
> The first sounds the most plausible and would mean that you are mapping
> c0000000 CPU space to c0000000 PCI space and the window is 512M long.
>
> Now of course, one needs to double check that the HW is configured that
> way (I suppose fsl_pci.c does the configuration based on the "ranges"
> property but I don't know for sure).
>
> So far nothing strikes me as totally odd.
>
>> 			0x01000000 0x0 0x00000000 0xB8000000 0x0 0x00100000>;
>
> This looks reasonable too with the same assumption as above.
>
>> PCI: Probing PCI hardware
>> PCI: Scanning PHB /pci@ff008500
>> PCI: PHB IO resource    = 0000000000000000-00000000000FF FFf [100]
>> PCI: PHB MEM resource 0 = 00000000c0000000-00000000dFF FFfff [200]
>
> Did you edit those by hand ? :-) They look correct tho as far as I can
> tell.

Sorry, I did a little editing of the dump below (to make it more readable,
no content changes) and "find & replace" went wild on me :-(  It should
have read:
   PCI: PHB MEM resource 0 = 00000000c0000000-00000000dfffffff [200]

>
>
>> PCI: PHB MEM offset     = 0000000000000000
>> PCI: PHB IO  offset     = 00000000
>
> And that too.
>
>>       probe mode: 0
>> PCI:0000:00:0b.0 Resource 0 0000000000001000-0000000000001007 [40101] fixup...
>> PCI:0000:00:0b.0            0000000000001000-0000000000001007
>> PCI:0000:00:0b.0 Resource 1 0000000000001008-000000000000100b [40101] fixup...
>> PCI:0000:00:0b.0            0000000000001008-000000000000100b
>> PCI:0000:00:0b.0 Resource 2 0000000000001010-0000000000001017 [40101] fixup...
>> PCI:0000:00:0b.0            0000000000001010-0000000000001017
>> PCI:0000:00:0b.0 Resource 3 0000000000001018-000000000000101b [40101] fixup...
>> PCI:0000:00:0b.0            0000000000001018-000000000000101b
>> PCI:0000:00:0b.0 Resource 4 0000000000001020-000000000000102f [40101] fixup...
>> PCI:0000:00:0b.0            0000000000001020-000000000000102f
>> PCI:0000:00:0b.0 Resource 5 0000000000100000-00000000001001ff [40200] fixup...
>> PCI:0000:00:0b.0            0000000000100000-00000000001001ff
>> PCI:0000:00:0b.0 Resource 6 0000000000000000-000000000007FF FF [4e200] is unassigned
>> PCI:0000:00:0c.0 Resource 0 0000000004000000-0000000007FF FFff [40200] fixup...
>> PCI:0000:00:0c.0            0000000004000000-0000000007FF FFff
>> PCI: Fixup bus devices 0 (PHB)
>> PCI: Try to map irq for 0000:00:0b.0...
>>    Got one, spec 2 cells (0x00000016 0x00000008...) on /soc8349@ff000000/pic@700
>>    Mapped to linux irq 22
>> PCI: Try to map irq for 0000:00:0c.0...
>>    Got one, spec 2 cells (0x00000013 0x00000008...) on /soc8349@ff000000/pic@700
>>    Mapped to linux irq 19
>> PCI: Allocating bus resources for 0000:00...
>> PCI: PHB (bus 0) bridge rsrc 0: 0000000000000000-00000000000FF FFf [0x100], parent c03b5740 (PCI IO)
>> PCI: PHB (bus 0) bridge rsrc 1: 00000000c0000000-00000000dFF FFfff [0x200], parent c03b5724 (PCI mem)
>> PCI: Allocating 0000:00:0b.0: Resource 0: 0000000000001000..0000000000001007 [40101]
>> PCI: Allocating 0000:00:0b.0: Resource 1: 0000000000001008..000000000000100b [40101]
>> PCI: Allocating 0000:00:0b.0: Resource 2: 0000000000001010..0000000000001017 [40101]
>> PCI: Allocating 0000:00:0b.0: Resource 3: 0000000000001018..000000000000101b [40101]
>> PCI: Allocating 0000:00:0b.0: Resource 4: 0000000000001020..000000000000102f [40101]
>> PCI: Allocating 0000:00:0b.0: Resource 5: 0000000000100000..00000000001001ff [40200]
>> PCI: Cannot allocate resource region 5 of device 0000:00:0b.0, will remap
>> PCI: Allocating 0000:00:0c.0: Resource 0: 0000000004000000..0000000007FF FFff [40200]
>
> That's huge, is this your "Coral" framebuffer ? It's clearly using a
> different address scheme which won't fit, so the kernel decides to remap
> it, so far so good.

Indeed, the frame buffer takes 4MB

>
>> PCI: Cannot allocate resource region 0 of device 0000:00:0c.0, will remap
>> Reserving legacy ranges for domain 0000
>> Candidate legacy IO: [io  0x0000-0x0fff]
>> hose mem offset: 0000000000000000
>> hose mem res: [mem 0xc0000000-0xdFF FFfff]
>> Local memory hole: [mem 0xc0000000-0xc01FF FFf]
>
> Now I can't grep the above string, what is it ? What is this "memory
> hole" ? It covers a good part of your PCI mapping ...
>
>> PCI: Assigning unassigned resources...
>> pci 0000:00:0c.0: BAR 0: assigned [mem 0xc4000000-0xc7FF FFff]
>> pci 0000:00:0c.0: BAR 0: set to [mem 0xc4000000-0xc7FF FFff] (PCI address [0xc4000000-0xc7FF FFff])
>
> So you fb looks like it has now landed at c4000000, which doesn't strike
> me as wrong nor strange so far...
>
>> pci 0000:00:0b.0: BAR 6: assigned [mem 0xc0200000-0xc027FF FF pref]
>> pci 0000:00:0b.0: BAR 5: assigned [mem 0xc0280000-0xc02801ff]
>> pci 0000:00:0b.0: BAR 5: set to [mem 0xc0280000-0xc02801ff] (PCI address [0xc0280000-0xc02801ff])
>>     ...
>> Coral-P FB [1024x768x24] at 0xc4000000..0xc7FF FFff [0xd1100000]
>
> I suspect 0xd1100000 is the result of ioremap ?
>
>> D1100000: FF FF FF FF FF FF FF FF  FF FF FF FF FF FF FF FF   |................|
>> D1100010: FF FF FF FF FF FF FF FF  FF FF FF FF FF FF FF FF   |................|
>> D1100020: FF FF FF FF FF FF FF FF  FF FF FF FF FF FF FF FF   |................|
>> D1100030: FF FF FF FF FF FF FF FF  FF FF FF FF FF FF FF FF   |................|
>> D1100040: FF FF FF FF FF FF FF FF  FF FF FF FF FF FF FF FF   |................|
>> D1100050: FF FF FF FF FF FF FF FF  FF FF FF FF FF FF FF FF   |................|
>> D1100060: FF FF FF FF FF FF FF FF  FF FF FF FF FF FF FF FF   |................|
>> D1100070: FF FF FF FF FF FF FF FF  FF FF FF FF FF FF FF FF   |................|
>>    ...
>> scsi0 : sata_sil
>> scsi1 : sata_sil
>> ata1: SATA max UDMA/100 mmio m512@0xc0280000 tf 0xc0280080 irq 22
>> ata2: SATA max UDMA/100 mmio m512@0xc0280000 tf 0xc02800c0 irq 22
>> ata1: failed to resume link (SControl FFFFFFFF)
>> ata1: SATA link down (SStatus FFFFFFFF SControl FFFFFFFF)
>> ata2: failed to resume link (SControl FFFFFFFF)
>> ata2: SATA link down (SStatus FFFFFFFF SControl FFFFFFFF)
>>
>> Things of note:
>>     * The 'local memory hole' is a space I have to steal from the PCI
>>       address space so that the Coral-P gets mapped to something other
>>       than PCI memory address 0x0 (relative).  This device is dirt stupid
>>       (previously discussed) and refuses to work at 0x0
>>     * The dump after the Coral-P FB line is what it sees in it's memory
>>       space.  It _should_ look something like this:
>> C4140600: FF FF FF 00 FF FF FF 00  FF FF FF 00 FF FF FF 00  |................|
>> C4140610: FF FF FF 00 FF FF FF 00  FF FF FF 00 FF FF FF 00  |................|
>> C4140620: FF FF FF 00 FF FF FF 00  FF FF FF 00 FF FF FF 00  |................|
>> C4140630: FF FF FF 00 FF FF FF 00  FF FF FF 00 FF FF FF 00  |................|
>> C4140640: FF FF FF 00 FF FF FF 00  FF FD FF 00 FF FD FF 00  |................|
>> C4140650: FF FD FF 00 FF FD FF 00  FF FD FF 00 FF FD FF 00  |................|
>>       Notice how byte 3 of every longword is 0x00?
>>     * The SATA device driver is failing along similar lines.
>>
>> Any ideas what I'm doing wrong?  or what I can look at?
>
> I can't see anything obviously wrong in what you've pasted there, but I
> am not familiar with fsl PCI or SoC's, so it's possible that there's
> something there going on ... We'll have to wait for somebody from FSL to
> have a look, unless you can find something in the doco.

The curious thing is that this exact same setup works perfectly
in 2.6.28 and near perfectly in 2.6.32.  Unless something else
changed in the PCI handling between 2.6.32 and 2.6.37, I would
hope it work work there as well.

I'll keep looking for differences between those two system versions.

Thanks

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
