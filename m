Message-ID: <C7FFFEA58B43D311920D0004ACE5333F0F53583F@amer25.avnet.com>
From: "Kerl, John" <John.Kerl@Avnet.com>
To: "'Charles Lockhart'" <lockhart@jeans.ifa.hawaii.edu>,
	linuxppc-embedded@lists.linuxppc.org
Subject: RE: Linux on the Virtex II Pro?- ELDK?
Date: Fri, 11 Jul 2003 09:42:45 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Charles,

Yes, this also can be done.  In fact, I use ELDK's
ppc_[48]xx-gcc to build the kernel, Linux apps, and standalone
apps.  In particuar, I use ppc_[48]xx-gcc to build the firmware
that loads the OS.  And of course ppc_8xx-gcc/ppc_4xx-gcc
is used to build U-Boot.

Your biggest whangup will probably be the C library
-- strcpy() et al. are easy to code up, but most people
find that making a printf() takes a bit more work.
If you don't already have such library routines written,
you might take a peek a U-Boot.  And you want a simple
crt0.S which zero-fills the BSS (_edata to _end), sets
the stack pointer and jumps into main.

Also you are responsible for direct access to the
UART hardware etc. but the good news is that a simple
polled-mode driver for a standalone application is generally
an order of magnitude simpler than a "real" driver for an
OS in which you would need to think about interrupts,
context switching, etc.

[Virtex-II Pro note:  If you want to build a standalone
app using Xilinx libgen'ed libraries, (1) you might use
their powerpc-eabi-gcc instead.  Or, (2) you might use ELDK's
ppc_4xx-gcc but include XPS's lib binaries; I haven't tried
that.  (3) You can use libgen'ed source code, & compile
with ELDK.  (4) You can dispense with the libgen'ed
stuff and write your own drivers.  This latter might be
preferable for simple devices such as UART lite and the
INTC.]

Having said that ... due to size restrictions, I won't
attach a sample makefile to everyone on the list.
However, I'll forward it to you separately, and will
send a copy to anyone else who requests it.

The essence, though, is:

ppc_4xx-ld -s -Bstatic -Ttext 0x00500000 $(OBJS) -o myfile.elf -Lwherever

Then

ppc_4xx-objcopy -O binary myfile.elf myfile.mem

if you want a plain binary.


-----Original Message-----
From: Charles Lockhart [mailto:lockhart@jeans.ifa.hawaii.edu]
Sent: Thursday, July 10, 2003 6:02 PM
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux on the Virtex II Pro?- ELDK?



Is it possible to use the ELDK to compile a simple stand alone
executable that I could download and start using my jtag interface?  I
tried compiling a really trivial piece of code with the "-static"
option, and it created a file that looks large enough to have included
everything it needs but when I download and start it, I don't see any of
the break points I'm setting being triggered.

I'd just like to do this as kind of a litmus test to show that I can
build something at least that'll execute.

-Charles Lockhart


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
