Date: Wed, 28 Apr 1999 13:11:19 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Christian Bauer <Christian.Bauer@uni-mainz.de>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Endianess problems in linuxppc kernel
In-Reply-To: <199904280958.LAA24884@student.physik.uni-mainz.de>
Message-ID: <Pine.LNX.4.10.9904281305310.12292-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 28 Apr 1999, Christian Bauer wrote:
> kernel 2.2.6 from ftp.kernel.org, egcs-1.1.2 used to compile the kernel.
> Linux is booted with BootX 1.0.6. No extra kernel arguments given.
> X11 server is XF68_FBDev (atyfb).

>   Bus  0, device  16, function  0:
>     Unknown class: Apple Unknown device (rev 1).
>       Vendor id=106b. Device id=7.
>       Medium devsel.  Master Capable.  Latency=32.  
>       Non-prefetchable 32 bit memory at 0xf3000000 [0xf3000000].

Do you know which Apple chip is this, so it can be added to the pciutils
database?

> When the MacOS is set to 8 or 32 bit color depth:
> 
>  - console (8 bit): works fine
>  - X11 in 8 bit: works fine
>  - X11 in 16 bit: colors are right, but everything not drawn by the
>    blitter (mainly icons and some text) looks like every two pixels
>    are swapped (i.e. the byte order looks like it's "3412" when it should
>    be "1234")
>  - X11 in 32 bit: pixel order is right, but colors are wrong. Red and green
>    are swapped, blue is missing. Here, it looks like we have a byte order of
>    "4321". As in 16 bit, things drawn by the blitter are not affected.
> 
> When the MacOS is set to 16 bit color depth:
> 
>  - console (8 bit): colors are right, but the font is garbled. Every two
>    neighbouring pixels are swapped (as in the 16 bit mode described above)
>  - X11 in 8 bit: the same "pixel swap" problems as in the console (again,
>    only with things drawn by the CPU). Moving the mouse pointer or moving
>    windows leaves "droppings" on the screen.
>  - X11 in 16 bit: pixel order is right, but colors are psychedelic. Looks
>    like a byte order of "2143".
>  - X11 in 32 bit: pixel order is right, colors are wrong. Red and blue are
>    swapped, green is missing. Byte order seems to be "3412". Moving the
>    mouse pointer or windows leaves "droppings" as in 8 bit mode.
> 
> Most interesting for me is that the behavour depends on what color depth
> was displayed in MacOS before booting Linux. Clearly, Linux is not
> initializing something neccessary.

You are using atyfb? What kind of ATI Mach64 chip do you have?

I'd say the wrong values are written to MEM_CNTL. But atyfb always writes the
same values to MEM_CNTL, i.e. it doesn't depend on what MacOS did before?!?

> 3. Sound output
> ---------------
> 
> Playing a module with "mikmod" results in rhythmic noise (16 bit) or silence
> (8 bit). When I change every instance of
> 
>   out_le32(&awacs->byteswap, sound.hard.format != AFMT_S16_BE);
> 
> to
> 
>   out_le32(&awacs->byteswap, sound.hard.format == AFMT_S16_BE);
> 
> in "drivers/sound/dmasound.c", both 8 and 16 bit output work fine.

Most module players are not endianness clean. I remember I had to patch mikmod
to make it work on the Amiga, too.

Greetings,

						Geert

--
Geert Uytterhoeven                     Geert.Uytterhoeven@cs.kuleuven.ac.be
Wavelets, Linux/{m68k~Amiga,PPC~CHRP}  http://www.cs.kuleuven.ac.be/~geert/
Department of Computer Science -- Katholieke Universiteit Leuven -- Belgium


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
