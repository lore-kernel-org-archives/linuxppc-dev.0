To: "David Marqvar (DAM)" <DAM@tt.dk>
Cc: "Embedded Linux PPC List (E-mail)" <linuxppc-embedded@lists.linuxppc.org>,
	"Laurits Lassen Petersen (LLP)" <LLP@tt.dk>
Subject: Re: Kernel 2.4.4 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 11 Feb 2002 11:56:38 +0100."
             <E8F83D6D2A6AD3118E0300902786A20502371417@NTEX>
Date: Mon, 11 Feb 2002 16:18:42 +0100
Message-Id: <20020211151847.8F215109D7@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear David,

in message <E8F83D6D2A6AD3118E0300902786A20502371417@NTEX> you wrote:
>
> I've downloaded the Linux kernel 2.4.4-2002-01-19 from ftp.denx.de.
> I want to compile it for a custom MPC823-based board.
>
> I'm a newbie with Linux. Maybe someone have a comment at my problems and
> fixes.... :)
>
> I'm using:
> gcc-3.0.3, cross-compiling for "powerpc-elf".
> binutils-2.11.2
> newlib-1.10.0

If you're new to embedded Linux, I  strongly  recommend  NOT  to  use
bleeding   edge  tools,  but  some  more  stable  softweare  instead.
Especially GCC-3.0.3 is probably not a good choice here...

> During the compilation (last step) I've encountered the following problems:

These are probably all because of problems with your setup  of  cross
develpment tools, especially GCC-3.x

> 4) I had to stop enabling "Magic SysRq Key" in Kernel hacking in menuconfig.
> Error: m8xx_setup.c:851: structure has no member named  'kbd_sysrq_xlate'.

This option is not supported on 8xx.

> Where do I find the zImage file - it is compressed, right? I've located the
> vmlinux, but as far as I know this is the uncompressed kernel-image.

You probably want to build a "pImage"  file  (make  pImage)  instead,
which  can  be used with PPCBoot - for older kernels it gets built in
arch/ppc/mbxboot/, now it's in arch/ppc/boot/images/ .

> I want to compile SASH for powerpc too. Does anyone know a place with
> powerpc-ready source for this? I've tried to compile it from the latest
> source, but I'm missing some kind of way to make i compile for powerpc - the
> Makefile keeps compiling for i386 (working fine by the way).

Replace "cc" by "$(CC)" in the Makefile, and make sure CC  points  to
your   cross   compiler.  You  may  also  have  to  add  a  "#include
<linux/fs.h>" to cmds.c .

> My next step is to find a simple bootloader..

PPCBoot?

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
See us @ Embedded Systems Nuremberg, Feb 19-21, Hall 12 K01 (with TQ)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
