Date: Mon, 3 Jul 2000 11:45:02 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Wolfgang Denk <wd@denx.de>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: (Manually) relocate PPC code?
In-Reply-To: <200007011839.UAA29375@denx.local.net>
Message-ID: <Pine.HPX.4.10.10007031122370.5670-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 1 Jul 2000, Wolfgang Denk wrote:

>
> Hi,
>
> I need to write some C code on PPC which must stay relocatable, resp.
> I must relocate it myself (all of code and data etc.). I'm using GNU
> tools.

Do you know about the -mrelocatable gcc and gas option ? Granted that it
generates slightly larger code, but it helps a lot to solve this kind of
problems.

> This is for a standalone application, _NOT_ running under Linux.

Fine.

> Where can I find documentation about things like the format of the
> GOT etc., or ideally existing _simple_ (read: small) example code?

Well, prepboot does this (with many more things): download a pristine
2.2.12 and apply the mvme2600 patches that you'll find at
ftp://vlab1.iram.es/pub/linux-2.2/. You'll then find a medium size example
in arch/ppc/prepboot. Actually it could be used to load a standalone
program or be integrated with it (except that you'll have to modify the
Makefile and the linker script which imports a couple of kernel symbols).

Actually prepboot may even be more complex than what you need since it
first relocates itself whereever it happens to be loaded by firmware and
then analyzes the memory map and setup of the machine before moving itself
and relocating again. The part between both relocations is easy to break
(there are many things you can't do like accessing the bss since it may
extend past the end of memory or whatever, and you can't easily use
pointers since they would not be relocated properly in the second pass),
but once the final relocation is done, the environment is reasonably
friendly (don't expect a full libc either but console I/O and a simple
memory management layer are available).

No interrupts however, this is left as an exercise for the reader. The MMU
exception handlers can be used as a starting point (especially the only
part which must be written in assembler for entry and exit).

> All hints, pointers, ideas appreciated - TIA!

Hope this helps....

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
