Message-Id: <200004041653.SAA08051@denx.local.net>
To: Stephane Laroche <stephane.laroche@sympatico.ca>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Basic questions about PPC embedded developement under Linux 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 04 Apr 2000 11:15:34 EDT."
             <38EA0716.47AA17BA@sympatico.ca>
Date: Tue, 04 Apr 2000 18:53:23 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <38EA0716.47AA17BA@sympatico.ca> you wrote:
>
> What do you gain by "understanding" the linux image?

On the MPC8xx a Linux kernel image is usually an ELF binary file with
several sections, for instance like that:

Sections:
Idx Name          Size      VMA       LMA       File off  Algn
  0 .text         00004854  00180000  00180000  00010000  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
  1 .rodata       000007bc  00184860  00184860  00014860  2**4
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  2 .data         0000031c  00186000  00186000  00016000  2**2
                  CONTENTS, ALLOC, LOAD, DATA
  3 .data.init    00000000  00187000  00187000  00017000  2**0
                  CONTENTS
  4 .bss          000031f8  00187000  00187000  00017000  2**2
                  ALLOC
  5 image         0007135d  00000000  00000000  00017000  2**0
                  CONTENTS, READONLY
  6 initrd        0008a502  00000000  00000000  0008835d  2**0
                  CONTENTS, READONLY

Most BDM debuggers I know will load only those sections  into  memory
(RAM or FLASH) that have the LOAD flag set (which is perfectly OK for
normal  binaries).  So  they will load only the text, rodata and data
sections which just contain the boot loader code - they will not load
the kernel image, nor the initial ramdisk image.

There are several tricks to work around this  (for  instance  packing
everything  into another ELF file where everything appears to be part
of the text segment, or stripping the ELF header and load as "unknown
binary format" when your tool supports it),  but  I  find  it  really
"nice"  that  the  Abatron  loads  the  whole Linux image without any
further tricks on my side.

> Another question, how useful is the BDM interface once the kernel has
> started running?  Can you leave GDB/BDI2000 connected to the target

That depends on what you want to do. You will probably NOT be able to
use it for source level kernel debigging - as soon as the MMU  is  on
(which happens really early) you need to know what your addresses are
"by hand".

> while the linux kernel is running?  I've seen in previous messages on
> the mailing list (by Dan Malek I believe) that a BDM debugger could
> interfere with the kernel operation.

This depends only on the configuration of the DER  register.  If  you
set it to a sensible value (for instance, 0x2002000F) it is perfectly
fine to keep the BDM debugger attached while running Linux (I'm doing
this all the time).

> I'm asking because I'd like to get a BDM debugger to help with writing
> the boot code of a custom MPC860 platform and I'm wondering if the BDM
> could thereafter be used to help debugging the linux kernel and user
> mode modules.  Today, I'm assuming that the BDM can only be used for
> boot code debugging and that a combination of xmon/gdbserver is better
> for the rest.
>
> Am I right?

Probably yes. However, you still have a  few  options  with  the  BDM
debugger  like  setting  breakpoints on whole ranges of addresses you
might want to "watch", etc.

IMHO both approaches have their advantages, so I get best  efficiency
by using both.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Real programmers don't comment their code. It was hard to  write,  it
should be hard to understand.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
