Message-ID: <37850CB5.53C7193D@broadlink.com>
Date: Thu, 08 Jul 1999 13:40:21 -0700
From: Scott Wood <scott@broadlink.com>
MIME-Version: 1.0
To: Dan Malek <dmalek@jlc.net>
CC: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: RPX Lite kernel
References: <378248CD.E3174193@broadlink.com> <3784C7D7.2EC6C451@jlc.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dan Malek wrote:
> 
> Hi Scott.
> 
> What type of board and processor do you have?  What is the version
> of the RPX utility program?

The CPU model is MPC850SRZT50.  Version: RPX-Lite BW 850SR 50Mhz/8Mhz Ic ~Dc RPXU v1.39

I finally got the cross-compiler stuff setup (x86->ppc), but in the final linking stage of compiling the kernel, I get a whole
bunch of 'undefined reference to...' errors (whether or not I have 'Set version information on all symbols for modules' defined). 
I found that commenting out the offending symbol EXPORT lines in arch/ppc/kernel/ppc_ksyms.c got rid of most of the errors (mostly
isa/pci stuff and a few other things that it seems the RPX board doesn't support, and I also tweaked a Makefile to exclude ADB
support).  The only error left is:

arch/ppc/kernel/kernel.o(__ksymtab+0x0): undefined reference to `request_irq'

I also get:

uart.c: In function `serial_console_setup':
uart.c:2705: warning: zero-length format string

which doesn't seem critical, but makes me wonder whether console on serial port will work correctly.

I am using the embedded-2.2.5 sources I got from the linuxppc.org ftp site.  I guess they're not completely setup to compile
cleanly for the RPX-Lite (on my x86 RH5.2 system anyway).  I'll try booting your kernel, but in the end I've got to be able to
compile my own.  If all else fails, if I gave you my .config could you build a kernel for me?  

> 
> Scott Wood wrote:
> 
> > I'm trying to load the zImage.rpcg.srec-2.1.127 kernel...
> 
> That's a pretty old kernel too.  Download the 2.2.5 sources and
> build a newer one.
> 
> > Is it possible for you to post a v2.2 kernel in SREC format,
> 
> I have a 2.2.5 kernel for the RPX-Lite 823 board that I will
> upload to the linuxppc.cs.nmt.edu server.  If that matches your
> board, give it a try.  I am just on a slow telephone line right now,
> so it may be a while before it is up there :-).
> 
> > ... and/or the program you used to convert the binary kernel to SREC
> > format so I can compile a custom kernel?
> 
> I attached the program "zsrec.c", which is a simple S-record
> generator I use for the kernel.  To run it is pretty simple,
> "zsrec zImage > /tftpboot/zi.rpx".  It creates the S-records
> to load at 0x200000, which works nicely on the RPX.  You can
> also get objcopy to do the same thing, but it took less time for
> me to write this program than to figure out what command line
> parameters I needed :-).
> 
> Good Luck.  Have fun.
> 
>         -- Dan
> 
>  
-- 
+---------------------+----------------------+
|     Scott Wood      |   Systems  Engineer  |
|=====================+======================|
|           BroadLink Communications         |
+--------------------------------------------+

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
