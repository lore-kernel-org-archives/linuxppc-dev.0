Message-ID: <39D122E3.608630C5@mvista.com>
Date: Tue, 26 Sep 2000 18:27:47 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Neil Russell <caret@c-side.com>
CC: Ruedi.Hofer@ascom.ch, linuxppc-embedded@lists.linuxppc.org,
        kernel@linux01.hasler.ascom.ch
Subject: Re: Limon & PowerQUICC II, Booting the kernel
References: <0G1H00EA2SVED4@pmdf-it.hasler.ascom.ch> <20000926091205.A22470@lx.c-side.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Neil Russell wrote:

> The downloaded kernel can be 4M-1K (0x3ffc00) in size, so I don't bother
> with compressing it.


Yes, please bother compressing it.  Making zImage is more than just
compressing the file.  The code in arch/ppc/mbxboot will (interactively)
create the command line, properly allocate the initial ram disk, and
most importantly creates the board information structure that is
required
by the kernel.  There is also hardware initialization expected by the
kernel that is often coordinated in the various functions found in
the arch/ppc/mbxboot files.  You can't simply boot vmlinux on an
embedded
system and expect it to work (unless your boot rom is doing exactly
the functions of arch/ppc/mbxboot).

The ELF header of the resulting zImage should be removed by just
using 'dd':
	dd if=zImage bs=64k skip=1 of=zImage.bin

Using objcopy or other generic programs on zImage will likely result
in a mess, because the file isn't really a valid ELF image.

> limon uses an enhanced version of the bootinfo structure (not the same as
> bd_info).

The kernel expects a board info that matches what it was configured to
use.  Every board is different.  You should modify
arch/ppc/mbxboot/misc.c
to know it was called by limon and properly convert or discover
information
necessary for the kernel version of the structure.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
