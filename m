Message-ID: <20000926091205.A22470@lx.c-side.com>
Date: Tue, 26 Sep 2000 09:12:05 -0700
From: Neil Russell <caret@c-side.com>
To: Ruedi.Hofer@ascom.ch, linuxppc-embedded@lists.linuxppc.org
Cc: kernel@linux01.hasler.ascom.ch
Subject: Re: Limon & PowerQUICC II, Booting the kernel
References: <0G1H00EA2SVED4@pmdf-it.hasler.ascom.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0G1H00EA2SVED4@pmdf-it.hasler.ascom.ch>; from Ruedi.Hofer@ascom.ch on Tue, Sep 26, 2000 at 01:49:46PM +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Sep 26, 2000 at 01:49:46PM +0100, Ruedi.Hofer@ascom.ch wrote:
> Question:
>
> 1. Do I have to strip off the elf header from my kernel file?

Yes.  Call me lazy, but I haven't yet written code to handle ELF (but I will).
You need to convert the kernel to a straight binary file with something like:

	objcopy -O binary vmlinux vmlinux.bin

then encode it as you have done with something like:

	mklimon -o vmlinix.limon -k vmlinux.bin

The downloaded kernel can be 4M-1K (0x3ffc00) in size, so I don't bother
with compressing it.

The kernel size limit, load address issues and the lack of handling of ELF
will all go away in the near future (now that I have time to work on limon
again).

> 2. Does the run command relocate the kernel at addr 0?

mklimon allows several images to be combined.  The kernel get moved to 0,
and initrd gets moved to the top of memory.

> 3. Some data are transferred from limon to the kernel.
>  - Does Limon handle this correctly?
>  - Where are these data located?

limon uses an enhanced version of the bootinfo structure (not the same as
bd_info).  It is currently set up at 0x3ffe00 by the run command (this will
change in the next version).

> 4. Why does it crash?

limon doesn't handle ELF (yet).


Neil.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
