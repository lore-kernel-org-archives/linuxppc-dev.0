Message-ID: <005201c1d9ac$d00056d0$64d4047e@research.liebert.com>
From: "Ed Brady" <mailinglist@ebrady.net>
To: <linuxppc-embedded@lists.linuxppc.org>
References: <20020327210215.3A202109F4@denx.denx.de> <021901c1d615$62ffe7c0$0202a8c0@ebrady.net>
Subject: Re: Compiling 2.4.18 for Motorola MBX board 
Date: Mon, 1 Apr 2002 13:41:14 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This problem seems to have been caused by an incorrectly configured gcc
cross-compiler.    Originally the compiler was built to target
powerpc-unknown-eabi.

The compiler was rebuilt to target powerpc-linux, and the problem was
solved, (however I have not had time to download the image to an MBX board
and actually see it run as of yet.)

Thanks to all that helped.


----- Original Message -----
From: "Ed Brady" <mailinglist@ebrady.net>
To: "Wolfgang Denk" <wd@denx.de>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sent: Wednesday, March 27, 2002 11:59 PM
Subject: Re: Compiling 2.4.18 for Motorola MBX board


>
> Wolfgang,
>
> Thank you for the reply....
>
> I was able to perform the following functions
>
> make mbx_config
> make oldconfig
> make dep
> make zImage
>
> Using make zImage, the kernel itself would build, but I got the following
> errors when attempting to link the original boot code.
>
> -------
> powerpc-eabi-objcopy -O elf32-powerpc \
>         --add-section=.image=../images/vmlinux.gz \
>         --set-section-flags=.image=contents,alloc,load,readonly,data \
>         ../common/dummy.o image.o
> powerpc-eabi-ld -T ../ld.script -Ttext 0x00180000 -Bstatic -o zvmlinux
> head.o ../common/relocate.o  misc-embedded.o ../common/misc-common.o
> ../common/string.o ../common/util.o embed_config.o iic.o m8xx_tty.o
image.o
> ../lib/zlib.a
> image.o: In function `main':
> image.o(.text+0xc): undefined reference to `__eabi'
> make[2]: *** [zvmlinux] Error 1
> make[2]: Leaving directory `/usr/src/ppc/linux/arch/ppc/boot/simple'
> make[1]: *** [zImage] Error 2
> make[1]: Leaving directory `/usr/src/ppc/linux/arch/ppc/boot'
> make: *** [zImage] Error 2
> -----
>
> Could this error be related to an incorrectly built cross-compiler?
Using
> some information that I found on the web, I build the ppc cross compiler,
as
> ppc-unknown-eabi,  which I interpret to mean ppc eabi on unknown O.S.
> Should I have built the cross-compiler as ppc-linux-eabi?
>
> I have not yet tried the 'make pImage' build yet, however I have noticed
> that 'make pImage' command can not be performed at the Top Level directory
> with the standard makefile.  In order to run it I have to export TOPDIR to
> be the linux ppc source directory, and then CD to the arch/ppc/boot
> directory first.  I will give more details on this once I have given it a
> try.
>
> Ed Brady
>
>
>
> ----- Original Message -----
> From: "Wolfgang Denk" <wd@denx.de>
> To: "Ed Brady" <mailinglist@ebrady.net>
> Sent: Wednesday, March 27, 2002 4:02 PM
> Subject: Re: Compiling 2.4.18 for Motorola MBX board
>
>
> > Ed,
> >
> > in message <015601c1d5d0$b0278b60$64d4047e@research.liebert.com> you
> wrote:
> > >
> > > I am trying to cross compile the latest 2.4.18 kernel to run on an MBX
> board
> > > (MPC 860).  However, I consistently run into problems whenever the
final
> > > link is performed.    See error text below....
> >
> > It seems your kernel configuration is broken. You better restart with
> > the default configuration fro the  MBX  board;  check  that  this  is
> > compiling fine, and then start modifying according to your needs:
> >
> > $ make mbx_config
> > $ make oldconfig
> > $ make dep
> > $ make pImage # with PPCBoot firmware
> > $ make zImage # with old bootstrap loader code
> >
> > If this works, you can start modifying the configuration
> > using
> >
> > $ make menuconfig
> >
> > etc.
> >
> > Hope this helps,
> >
> > Wolfgang Denk
> >
> > --
> > Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
> > Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
> > The trouble with our times is that the future is not what it used  to
> > be.                                                     - Paul Valery
> >
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
