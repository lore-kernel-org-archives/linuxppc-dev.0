From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: <mlan@cpu.lu>, <acurtis@onz.com>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: PCI enlightenment follow-up
Date: Tue, 6 Aug 2002 23:09:17 +0200
Message-Id: <20020806210917.13103@192.168.4.1>
In-Reply-To: <E17cK7s-000080-00@piglet.grunz.lu>
References: <E17cK7s-000080-00@piglet.grunz.lu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>sym should _not_ play with these bus-view addresses. Have a look at the
>driver where it gets these from.

I think it has to. From what I remember the author of the driver told
me, the card need to be programmed to point to it's own memory
or something like that.

>> sym53c8xx: setting PCI_COMMAND_PARITY...(fix-up)
>> sym53c8xx: 53c895a detected
>> sym53c895a-0: rev 0x1 on pci bus 0 device 15 function 0 irq 19
>> sym53c8xx: device->slot.base = 0x07fffc00
>> sym53c8xx: device->slot.base_2 = 0x07ffc000
>
>Should contain the offset from host to PCI bus. With these addresses,
>there's no way to access the SCSI card from the driver.
>
>> sym53c895a-0: ID 7, Fast-40, Parity Checking
>> /* vtobus() mapping looks ok */
>> sym53c8xx: 0x404ba000 = vtobus(0xc04ba000)
>> sym53c8xx: 0x404bd800 = vtobus(0xc04bd800)
>
>Where do these come from? Is that DMA memory?

Looks like. It's correct provided the infos Allen gave us regarding
his bridge setup are correct.

>> sym53c8xx: np->base2_ba = 0x07ffc000
>> /* 1-to-1 BAT mapping */
>> sym53c8xx: 0x4fffc000 = remap_pci_mem(0x4fffc000, 0x00002000)
>
>This looks good indeed.
>
>> sym53c8xx: ncr_script_copy_and_bind(src 0xc04f7ce0, dst 0xc04be054)
>> sym53c8xx: ncr_script_copy_and_bind(src 0xc04f7ce0, dst 0xc04be054)
>> sym53c8xx: 0xf0ccff07 = cpu_to_scr(0x07ffccf0)
>             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>Nope, reversed address. That will not work. Don't touch the address,
>touch the data if necessary. What needs to be swapped is data going
>_over_ the little-endian PCI bus. Addreses don't go _over_ the bus, they
>address resources _on_ the bus.

Sure of that ? First let's look at what the driver actually does in that
routine. I know that the NCR chips are have bus-masterers ;)

Ben.

>Cheers


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
