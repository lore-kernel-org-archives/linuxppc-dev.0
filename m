Message-ID: <3C6AADBE.79D5D018@mvista.com>
Date: Wed, 13 Feb 2002 12:17:34 -0600
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: "David Marqvar (DAM)" <DAM@tt.dk>
Cc: "Embedded Linux PPC List (E-mail)" <linuxppc-embedded@lists.linuxppc.org>,
	"Laurits Lassen Petersen (LLP)" <LLP@tt.dk>
Subject: Re: target=powerpc-linux, powerpc-eabi, powerpc-elf
References: <E8F83D6D2A6AD3118E0300902786A20502371419@NTEX>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"David Marqvar (DAM)" wrote:
>
> What is the difference between the 3 (?) types og targets for powerpc?
> ELF = Extended Linker Format
> EABI = Embedded Application Binary Interface
> Linux = ?

ELF is the type used by Linux.  Linux is not a binary type.

> Is it 3 different layouts for the binary file?
>
> The machine-type in GCC is stated as:
> i386-redhat-linux
> powerpc-elf
> powerpc-unknown-linux
> powerpc-unknown-linux-gnu
>
> What does these parts define (*-*-* = processor-binaryformat-system, or?) ?

The canonical name (what you call the machine-type) is in the format of
"architecture"-"vendor"-"operating system".  linux and linux-gnu are the
same thing (they fill out the third operating system field.)

> Which target will you suggest using when working with a MPC823 using PPCBoot
> ?

Whatever PPCBoot uses....

> We want to build our own kernel for the MPC823 - can we use Newlib for that?
> - from the documentation to Newlib it seems as if there is missing some
> hardware-specific parts in newlib which is needed by Linux...?
> We will only be running normal/simple apps with the kernel and don't need
> some "almost-never-user" functions from the libary.

Newlib can not be used to create applications for PowerPC Linux.
However it can be used to "bootstrap" the compiler if you only require
the ability to compile a kernel.  The correct canonical name when
building the compiler are "power-unknown-linux" (you can add in the -gnu
if you want...)

> If we can use newlib (hope so since it is smaller) - should we compile the
> cross-gcc with the option --with-newlib ?

To build a compiler only capable of building a kernel you can use
--with-newlib and this removes the requirement to have a valid glibc.
Just keep in mind this compiler can build glibc, but can not build user
apps.

BTW Why are you building your own gcc compilers?  There are many free
and commerical resources for compilers that are tailored towards MPC 823
work.

--Mark

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
