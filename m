Date: Sat, 13 Feb 1999 20:53:55 -0500
From: Michael Meissner <meissner@cygnus.com>
To: Benjamin Herrenschmidt <bh40@calva.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Bootstrap code with egcs
Message-ID: <19990213205355.A1456@wogglebug.cygnus.com>
References: <19990213052326.032488@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <19990213052326.032488@mail.mipsys.com>; from Benjamin Herrenschmidt on Sat, Feb 13, 1999 at 05:23:26AM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Feb 13, 1999 at 05:23:26AM +0100, Benjamin Herrenschmidt wrote:
> 
> Hi !
> 
> I'm in the process of improving the way BootX boots and adding support
> for NuBus PowerMacs. However, I need to write some PPC bootstrap code
> that will take control before the kernel is actually entered. Part of it
> is PPC asm, but I want some C code too.

Using the standard PowerPC GCC Linux compiler, if you use the -mrelocatable
switch, and call __eabi immediately in the startup code after setting up the
stack, it will generate position independent code.  The -mrelocatable switch
tells the compiler to put all non-call addresses used in a table, that the
__eabi function fixes up to the appropriate address.  The text and data section
must be loaded at the same relative location to each other.  If you configured
the compiler for powerpc-eabi instead of powerpc-linux, it would generate the
__eabi call automatically for the main function, but since the Linux compiler
doesn't do this, you need to do it by hand.

Note, all modules linked together must be compiled with the -mrelocatable
option, including those being assembled (and the assembler will check whether
you did any relocations that can't be fixed up).  For libraries there is the
-mrelocatable-lib that allow the modules to be linked with either normal code
or -mrelocatable code (but I think there are some bfd/linker changes that
haven't been released yet that affect the linking of -mrelocatable-lib
modules).

-- 
Michael Meissner, Cygnus Solutions (Massachusetts office)
4th floor, 955 Massachusetts Avenue, Cambridge, MA 02139, USA
meissner@cygnus.com,	617-354-5416 (office),	617-354-7161 (fax)

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
