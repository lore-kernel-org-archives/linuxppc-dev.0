In-Reply-To: <19990213205355.A1456@wogglebug.cygnus.com>
Date: Sun, 14 Feb 1999 15:22:29 +0100
To: Michael Meissner <meissner@cygnus.com>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Bootstrap code with egcs
Message-Id: <19990214152229.011973@smtp.calvacom.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Feb 13, 1999, Michael Meissner <meissner@cygnus.com> wrote:

Thanks for the reply !

>Using the standard PowerPC GCC Linux compiler, if you use the -mrelocatable
>switch, and call __eabi immediately in the startup code after setting up the
>stack, it will generate position independent code.  The -mrelocatable switch
>tells the compiler to put all non-call addresses used in a table, that the
>__eabi function fixes up to the appropriate address.  The text and data
>section
>must be loaded at the same relative location to each other.  If you
configured
>the compiler for powerpc-eabi instead of powerpc-linux, it would generate the
>__eabi call automatically for the main function, but since the Linux compiler
>doesn't do this, you need to do it by hand.

Ok. That is what I need.

>Note, all modules linked together must be compiled with the -mrelocatable
>option, including those being assembled (and the assembler will check whether
>you did any relocations that can't be fixed up).  For libraries there is the
>-mrelocatable-lib that allow the modules to be linked with either normal code
>or -mrelocatable code (but I think there are some bfd/linker changes that
>haven't been released yet that affect the linking of -mrelocatable-lib
>modules).

I won't link against any existing library, just a couple of .c files and
eventually some assembly code.

-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>




[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
