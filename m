Message-ID: <3896BF04.55AD7C4F@ctam.com.au>
Date: Tue, 01 Feb 2000 22:09:56 +1100
From: Brendan John Simon <Brendan.Simon@ctam.com.au>
Reply-To: Brendan.Simon@ctam.com.au
MIME-Version: 1.0
CC: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: mpc8xx-2.2.13 kernel hangs during boot.
References: <3896AEAE.B261AAAD@ctam.com.au> <38961D55.C544EB7A@netx4.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek wrote:

> > ....  It was suggested to me that the UPM was probably incorrect and
> > that's why it fails with the caches enabled.
>
> I was the one that probably suggested that.  If all of the
> memory mapping is correct (IMMR > 0xd0000000, and such) this
> is usually where I start looking, since the code is known to
> operate on other platforms.

I based my port on the BSEIP board as it is the simplest.
The IMMR is at 0xff000000 and all peripherals are mapped above 0x80000000
except for DRAM which is mapped at 0x00000000.


> > ....  I have tried with 4 different UPM settings for a 25MHz bus
> > with 60ns EDO DRAM.
>
> Although others may be more talented, I have never been able
> to program the UPM without the actual DRAM specifications,
> schematics and a logic analyzer connected to the processor bus.
> Guessing at UPM values is kind of like playing the lottery.

I think I have to agree with you :(


> > ....  Is there anything else the kernel expects to be setup
> > ?
>
> Not much.  Obviously the DRAM must be configured because the
> kernel is loaded there.  Beyond that it just reads the IMMR
> and maps it.

I didn't think so.  The embedded-2.2.5 kernel works fine with the same
bootloader.  I forgot to mention the the embedded-2.2.5 kernel is compiled
with binutils-2.9.1.0.19a/egcs-1.1.2 and the mpc8xx-2.2.12 kernel is
compiled with binutils-2.9.5.0.24/gcc-2.95.2.  I'm not sure if it makes any
difference.  I'm recompiling the embedded-2.2.5 kernel with my new tools to
see if that makes any difference ?  The embedded-2.2.5 does not having an
floating point emulation where as the mpc8xx-2.2.13 does.  I will also try
without the floating point emulation patches to see if that makes any
difference.


> > How can I tell where it is failing ?  I don't think I can use printk as
> > the console is not setup yet.  Is this correct ?
>
> Here is a hint.  Look at the symbol table from System.map and
> convert the address of log_buf to a physical address (mask the
> upper couple of bits).  Dump this area of memory, as all of the
> printk() messages end up in this buffer before they are sent to
> the console.

How can I look at this memory area ?  With a BDM debugger ?  I thought BDM
can't be used.
Can a serial debugger be used ?


> > Getting a little desperate now.
>
> Are those ready-for-production boards looking any better yet :-)?
> The world is passing you by........

No pain, no gain :)
Yes I know the off the shelf boards will get me going on the application
sides of things, but I still need to get it running on our custom board/s
too.

Brendan Simon.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
