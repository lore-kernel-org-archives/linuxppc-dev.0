In-Reply-To: <E12AhzC-0000Cl-00@puetz.penguinpowered.com>
Date: Wed, 19 Jan 2000 10:36:14 +0100
To: Kevin Puetz <puetzk@iastate.edu>, debian-powerpc@lists.debian.org
CC: linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Kernel 2.2.14
Message-Id: <20000119103614.026738@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Jan 18, 2000, Kevin Puetz <puetzk@iastate.edu> wrote:

>--- arch/ppc/kernel/head.S.bak  Tue Jan 18 14:40:12 2000
>+++ arch/ppc/kernel/head.S      Tue Jan 18 17:15:57 2000
>@@ -139,15 +139,16 @@
>        .text
>        .globl  _start
> _start:
>+       .long   TOPHYS(__start),0,0
>        /*
>         * These are here for legacy reasons, the kernel used to
>         * need to look like a coff function entry for the pmac
>         * but we're always started by some kind of bootloader now.
>         *  -- Cort
>         */
>-       nop
>-       nop
>-       nop
>+/*     nop */
>+/*     nop */
>+/*     nop */
>
> /* PMAC
>  * Enter here with the kernel text, data and bss loaded starting at

Hum... We wanted to get rid off this no-longer-needed coff entry point,
but it looks like there's still bootloaders out there that don't handle
things right. Please remind me which bootloader (&version) you are using.
Is it the old quik ?. The bootloader needs fixing, not the kernel, in
this case.

>I don't however know enough to make this change intelligently - I just backed
>out that bit of the patch, and now 2.2.14 boots fine (and has been up for a
>couple of hours with X, net traffic, etc.). I assume it's related to
yaboot or
>BootX? quik and/or my beige Rev 1 G3's firmware don't like the nops
though, and
>wants the ".long   TOPHYS(__start),0,0". Should I cc paul with this? It's not
>your patch that's broken, it's his tree, but you were the one helping me
>before, so...

I think Cort or Paul removed the coff entry point. I'll check if the
latest quik is fixed (there was a bug in quik 2.0 the last time I checked
which prevented the userland "quik" app from finding the partition number).

>> You can try, at first, to edit macserial.c and change
>> #define SUPPORT_SERIAL_DMA
>> to
>> #undef SUPPORT_SERIAL_DMA

>That helped, though the behavior is still flakey. Now it works
'sometimes' for
>some definitions of sometimes :-). I'll work on it some more, now that I can
>make 2.2.14 boot.

I'd be interested in more tests. If the DMA serial driver is broken on
some machine, then we should consider adding a command line option (or a
module option) to the driver to be able to disable it at boot time until
we have a fix. I'll try to find again the infos I had about the beige G3s
DMA issues. I _think_ it's a problem with the ESCC register that controls
the recovery time, but I'm not completely sure.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
