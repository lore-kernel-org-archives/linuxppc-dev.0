Message-ID: <39D60B3C.297B12A@mvista.com>
Date: Sat, 30 Sep 2000 11:48:12 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Ruedi.Hofer@ascom.ch
CC: linuxppc-embedded@lists.linuxppc.org, kernel@linux01.hasler.ascom.ch
Subject: Re: Antwort: Re: VxWorks bootloader & PowerQUICC II, Booting the kernel
References: <0G1N00BGQJM2C8@pmdf-it.hasler.ascom.ch>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ruedi.Hofer@ascom.ch wrote:

> The gdb tells me:
>
>   75         shp = (Elf32_Shdr *) dbuf;
>   76         sp = (char *)shp;
>   77         for (i=0; i<nsscns; i++) {
> > 78                 if (shp->sh_addr)
>   79                         shp->sh_addr += 0x500000;
>   80                 if (i == 5)
>   81                         imagesize = shp->sh_size;
>
> Program received signal SIGSEGV, Segmentation fault.

I don't know why this happened, but I discovered that line 80 should
be:
	if (i== 6)

> I tried to play around with vxhack.c but I didn't succeed...

It's a pretty trivial program.  All it does is update the vma/lma
in the headers and add the image size to the data section of the
file.  A nice addition would be to locate the "image" by name instead
of just knowing the header number.  When I originally wrote it, I
needed it _now_, and didn't care about what it looked like :-).  Just
use it as an example of what needs to be done, not as the way to do it.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
