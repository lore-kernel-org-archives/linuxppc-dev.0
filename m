Subject: Re: multiple separate pci bridges ...
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
	Rob Baxter <robb@synergymicro.com>
In-Reply-To: <20040118121507.GB4603@iliana>
References: <1073252724.780.5.camel@gaston> <20040104220608.GA1667@iliana>
	 <20040105164038.GA16158@iliana> <1073338095.9497.70.camel@gaston>
	 <20040105214239.GA20252@iliana> <1073340725.9497.105.camel@gaston>
	 <20040106073955.GF735@iliana> <1073376024.26508.220.camel@gaston>
	 <20040106081143.GA1644@iliana>
	 <Pine.GSO.4.58.0401061533510.5752@waterleaf.sonytel.be>
	 <20040118121507.GB4603@iliana>
Content-Type: text/plain
Message-Id: <1074468291.812.31.camel@gaston>
Mime-Version: 1.0
Date: Mon, 19 Jan 2004 10:24:52 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Ok, i have done this. I have followed the recomendations of the hardware
> guy, and did the following :
>
>   device 0, function 0 : read access to bytes 0-15, read returns 0 on
>   regs > 15. Write access fails silently.

Show the code (just in case...)

>   device 0, function 1-7 : both read and writes fail with
>   PCIBIOS_DEVICE_NOT_FOUND.
>
> Additionnally, i have nullified the ressources with :
> 	dev->resource[i].flags = 0;
> 	dev->resource[i].start = 0;
> 	dev->resource[i].end = 0;
> from the pcibios_fixup (not the right place, but i don't know where it
> should be done instead).

A quirk is one of the functions in the table in pci.c but you can
use the fixup too at this point...

> This allows me to see the host bridge on both buses, and radeonfb works
> fine :
>
> $ lspci
> 00:00.0 Host bridge: Galileo Technology Ltd.: Unknown device 6460 (rev 03)
> 00:01.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 46)
> 00:05.0 SCSI storage controller: LSI Logic / Symbios Logic 53c810 (rev 23)
> 00:0c.0 ISA bridge: VIA Technologies, Inc. VT8231 [PCI-to-ISA Bridge] (rev 10)
> 00:0c.1 IDE interface: VIA Technologies, Inc.  VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 06)
> 00:0c.2 USB Controller: VIA Technologies, Inc. USB (rev 1e)
> 00:0c.3 USB Controller: VIA Technologies, Inc. USB (rev 1e)
> 00:0c.4 Non-VGA unclassified device: VIA Technologies, Inc. VT8235 ACPI (rev 10)
> 00:0c.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 AC97 Audio Controller (rev 40)
> 00:0c.6 Communication controller: VIA Technologies, Inc. Intel 537 [AC97 Modem] (rev 20)
> 00:0d.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 51)
> 10:00.0 Host bridge: Galileo Technology Ltd.: Unknown device 6460 (rev 03)
> 10:08.0 VGA compatible controller: ATI Technologies Inc: Unknown device 5964 (rev 01)
>
> But :
>
> $ hexdump /proc/bus/pci/10/00.0
> 0000000 ab11 6064 0700 b022 0300 0006 2000 0000
> 0000010 20df 85cf 20df 85cf 20df 85cf 20df 85cf
> *
> 0000040
>
> Why in hell do i have 0x20df85cf on all four bars of the config space
> addresses 0x10 to 0x1f ?

I don't know, make sure you are "filtering" things properly... You
should return 0xff on anything after 0x10 I suppose (though you
may want to return 0 for the BARs, I have to dbl check).

> Finally, X works, altough DRI freezes after a second or two with my
> radeon 9200SE, while it works for a Radeon 7500, but this is probably a
> DRI issue.

Which version of DRI ? Do you have the interrupt routing working
properly ?

> What makes me wonder, is that X needs around 20 seconds to launch, which
> could not be something normal. It usually takes 5-8 seconds only.
> Something strange is going on.

Yah, XFree log could be useful.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
