Return-Path: <jonsmirl@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.178])
	by ozlabs.org (Postfix) with ESMTP id 8F379DDEE4
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Nov 2007 00:30:59 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so581484wag
	for <linuxppc-dev@ozlabs.org>; Sun, 25 Nov 2007 05:30:58 -0800 (PST)
Message-ID: <9e4733910711250530r454c01ecoe8867a7f492b8704@mail.gmail.com>
Date: Sun, 25 Nov 2007 08:30:58 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Robin H. Johnson" <robbat2@gentoo.org>,
	"Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Subject: Re: Access to PCI Expansion ROMs on PPC
In-Reply-To: <20071125114919.GC14557@curie-int.orbis-terrarum.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071125015707.GO3174@curie-int.orbis-terrarum.net>
	<9e4733910711241813r3412d459l95fb3b84cbee1d8a@mail.gmail.com>
	<20071125111535.GB14557@curie-int.orbis-terrarum.net>
	<20071125114919.GC14557@curie-int.orbis-terrarum.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/25/07, Robin H. Johnson <robbat2@gentoo.org> wrote:
> On Sun, Nov 25, 2007 at 03:15:35AM -0800, Robin H. Johnson wrote:
> > I started in there from that, and ended up in pci-sysfs.c...
> > The ROM memcpy in drivers/pci/pci-sysfs.c:pci_read_rom() is never running.
> ...
> > [  306.396743] drivers/pci/pci-sysfs.c:577:pci_read_rom: size=0x0 rom=0xd000080082580000 off=0x0
> > [  306.396764] drivers/pci/pci-sysfs.c:579:pci_read_rom: off >= size!
> ...
> > So next, why is it failing to decode the ROM size correctly?
> > pci_get_rom_size(), here I come.
> Instead of the expected value of 0x55, 0xAA at the start of the ROM
> size decode in pci_get_rom_size(), the first two readb() calls both
> return either 0xFF or 0x00 so the size check fails right away.
>
> The two cards with x86 firmware return 0xFF for those two readb()
> instructions, while the X1900 with OF returns 0x00 for the readb().
>
> Could one of the more knowledgeable folk for PPC intricacies suggest why
> those readb calls are returning the wrong data?

I don't know PPC at this low of level but it may be a problem with non
word-aligned access to memory. I thought readb() was supposed to work
on all archs and alignment issues are handled inside readb(). Also,
the readw() may have an endian bug.

It might be prudent to add this check at the end of the rom size routine.
if (image == rom)
    return size;
That would ensure a non-zero size is returned for non-standard ROMs.

If you add that at the end, can you read the ROM from user space?

BenH, has source code for an x86 emulator that will run on PPC. That
will let you run the ROMs. The original plan was for the kernel to
generate a uevent that would have triggered the x86 emulator to run.

Progress along that path was blocked by the X developers. The X server
contains code for enabling the PCI ROM and reading it from user space.
I wanted to move this code out of X and into the kernel.

Because the path was blocked things like the PCI ROM API were never
throughly tested. It works most of the time but the occasional problem
is still turning up. Once we identify the PPC problem we can fix it in
the kernel.

>
> --
> Robin Hugh Johnson
> Gentoo Linux Developer & Infra Guy
> E-Mail     : robbat2@gentoo.org
> GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85
>
>


-- 
Jon Smirl
jonsmirl@gmail.com
