From: Ruedi.Hofer@ascom.ch
Date: Wed, 27 Sep 2000 16:34:37 +0100 (CED)
Subject: Antwort: Re: Limon & PowerQUICC II, Booting the kernel
To: linuxppc-embedded@lists.linuxppc.org
Cc: caret@c-side.com
Message-id: <0G1J00L0QV5UHQ@pmdf-it.hasler.ascom.ch>
MIME-version: 1.0
Content-type: MULTIPART/MIXED; BOUNDARY="Boundary_(ID_YnTro7TSdsP8ig3cqqMrNQ)"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--Boundary_(ID_YnTro7TSdsP8ig3cqqMrNQ)
Content-type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT

Hi Neil

I don't call you lazy! You did a great job so far!

I tried to convert the kernel exactly the way you wrote below.

For the binary conversion of vmlinux I use ppc_82xx-objcopy
which should be ok. Afterwards mklimon adds the header.

... but unfortunately, the kernel still crashes!

Question:

1.  Do you load the kernel to 0x900000 as Dan mentions?

2. Is there something wrong with the boot arguments?

3. What is your exact procedure when loading the kernel?

4. Where did you get the kernel from? How is it configured?

5. Is the kernel CPU frequency dependent?


---------------- Linux Monitor 1.4.2-SBC-8260 ----------------
limon>
limon>
limon>
limon> l
BOOTP/TFTP from server 10.1.20.2; our IP address is 10.1.20.1.
Filename '/usr/src/nfs/limonZImage'.
Loading: >.................................................................<
done.
limon>
limon> debug
limon> dw 400000
00400000   6e6a725e  00000000  0012c58c  6b657230  njr^........ker0
00400010   0012c5a0  60000000  60000000  60000000  ....`...`...`...
00400020   7c7f1b78  7c9e2378  7cbd2b78  7cdc3378  |..x|.#x|.+x|.3x
00400030   7cfb3b78  3b000000  4800bd19  48003759  |.;x;...H...H.7Y
00400040   480036e5  48003739  48003775  48008825  H.6.H.79H.7uH..%
00400050   7c7a1b78  3c83c000  2c040000  41820020  |z.x<...,...A..
00400060   38600000  7c0000a6  70000010  41823394  8`..|...p...A.3.
limon>
limon>
limon> run

 I'm using the kernel from HHL1.2, standard config but initrd disabled!
Limon runs in the 8Bit flash on a 200/133/66 MHz CPU.


Thank you

Ruedi






caret@c-side.com on 26.09.2000 18:12:05
An: Ruedi.Hofer@ascom.ch @ MailGate, linuxppc-embedded@lists.linuxppc.org @ MailGate
Kopie: kernel@linux01.hasler.ascom.ch @ MailGate
Thema: Re: Limon & PowerQUICC II, Booting the kernel

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



--Boundary_(ID_YnTro7TSdsP8ig3cqqMrNQ)--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
