Message-Id: <5.1.0.14.2.20011203165059.01c83e20@falcon.si.com>
Date: Mon, 03 Dec 2001 17:11:50 -0500
To: linuxppc-embedded@lists.linuxppc.org
From: Jerry Van Baren <vanbaren_gerald@si.com>
Subject: Re: programming ppcboot onto an sbc8260 with a vision ice
In-Reply-To: <3C0BE2DA.53C39E1B@seranoa.com>
References: <3C0BD4F1.DB6591F3@seranoa.com>
 <3C0BDBB4.68EB3E72@chinook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Your PPCBoot image is linked at 0x40000000 and your convert defaults are
converting from 0xfe000000..0xfe020000 (this is where EST puts the boot
memory unless you've changed the HRCW to ORG it at 0x00000000 -- glossing
over quite a few details here).  Anyway, there ain't no data in that range,
which is exactly what the error message is telling you.

The EST convert utility doesn't allow you to relocate the code, only to set
the lower and upper boundaries of the conversion.  You can use an elf tool
(objcopy) to re-org the code or change your link mechanism to re-org your
code.  You can also leave it at 0x40000000 and change your visionICE setup
to map the ROM into that memory area (hmm, isn't that the secondary
flash?  Maybe you just need to program it and switch your CS0/CS6 jumper).

By the way, PPCBoot will load a new HRCW which will ORG the boot memory at
0x00000000 (first instruction at 0x100) instead of 0xFFF00000 (first
instruction at 0xFFF00100).  There are benefits and drawbacks to either
start up location and PPCBoot can be configured to boot high as well as low.

gvb


At 03:38 PM 12/3/2001 -0500, Andrew Dixon wrote:

>Peter Desnoyers wrote:
> >
> > You need to take the ELF file, ppcboot, and convert it into a .bin file
> > using the vision ICE convert utility.
> >
> > The file format referred to as "BIN" in the visionICE documentation
> > isn't a real binary image - it has a special header.
> >
>
>OK.  When I try that it tells me:
>
>Conversion Failed: no data was extracted from the selected address
>range.
>
>Where the address ranges are:
>/var/opt/visionXD/bin/convert  -w ppcboot -b
>convert v7.8A Copyright (c) 1996-2001 Wind River HSI
>convert ELF file ppcboot to BDX file ppcboot.bdx
>Extracting image from 'ppcboot'
>Writing binary download image to 'ppcboot.bdx'
>Maximum packet size: 0x100
>Lower address: 0x0
>Upper address: 0xffffffff
>Execution address: 0x40000000
>Image written
>Processing time: 0.011 seconds
>
>Lower Image Address: 0xfe000000
>Upper Image Address: 0xfe020000
>
>
>I also tried:
>
>/var/opt/visionXD/bin/convert  -w ppcboot -b
>convert v7.8A Copyright (c) 1996-2001 Wind River HSI
>convert ELF file ppcboot to BDX file ppcboot.bdx
>Extracting image from 'ppcboot'
>Writing binary download image to 'ppcboot.bdx'
>Maximum packet size: 0x100
>Lower address: 0x0
>Upper address: 0xffffffff
>Execution address: 0x40000000
>Image written
>Processing time: 0.011 seconds
>
>which gives me a file "ppcboot.bdx".  VisionXD still complains that it's
>not a flat binary though.
>
>Any thoughts?
>
>Thanks,
>Andy
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
