From: "Chuck Meade" <chuck@theptrgroup.com>
To: "LinuxPPC" <linuxppc-embedded@lists.linuxppc.org>,
	"Ing.Gianfranco Morandi" <gianfranco.morandi@euro-studio.it>
Cc: "Chuck Meade (PTR Group)" <chuck@theptrgroup.com>
Subject: RE: HHL 2.1 preview kit
Date: Sun, 6 Oct 2002 19:04:07 -0400
Message-ID: <IIEEICKJLNEPBBDJICNGAEMICIAA.chuck@ThePTRGroup.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <001701c26c5f$647b72a0$0700a8c0@pc005>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Gianfranco,

I recently did something similar on an 860 board.  I see that you
are using an 82xx so these issues may be similar.  I do not think
that anything I encountered in bringing up the more recent version
of Linux was 860-related.

First, look at the board info struct in your Linux tree in
include/asm-ppc/<board-specific-name>.h.  This struct must
be compatible with PPCBoot's board info struct, which is in
the PPCBoot tree under include/ppcboot.h.  I used a modified
version of the Linux header file mbx.h to make it compatible.
Also, under the PPCBoot command shell, if the version of Linux
you are booting is more recent than 2.4.5-pre5, you need to get
rid of the PPCBoot environment variable clocks_in_mhz.
Like this:

=> setenv clocks_in_mhz
=> saveenv

Having nothing to the right of the variable name will delete
the variable altogether.  Doing these steps allowed me to
boot Linux 2.4.18.

I was not using HHL 2.1, just a downloaded Linux 2.4.18 with
ppc patches, this time.  That probably has nothing to do with
what you are seeing though.

Hope that helps,
Chuck Meade
chuck@ThePTRGroup.com

> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of
> Ing.Gianfranco Morandi
> Sent: Saturday, October 05, 2002 7:07 AM
> To: LinuxPPC
> Subject: Fw: HHL 2.1 preview kit
>
>
>
> Thanks for the answer, I have got the image.
>
> Unfortunately the Image doesn' t run. The problem is derived from the
> loading the image file.
> The boot loader is PPCboot 1.0.5 and the "vmlinux.gz" has been converted
> with the "mkimage" utility. The bootloader is able to download the image
> generated with the CDK 1.2 (kernel 2.4.0-test2) but when it downloads the
> image which is the result of new compilation (HHL 2.1), program is stuck
> after the decompression.
>
> Anybody has some suggestions to give me?
>
>
> Thanks
> Gianfranco
>
> ----- Original Message -----
> From: "Yu Bo-BOYU1" <Bo.Yu@motorola.com>
> To: "'Ing.Gianfranco Morandi'" <gianfranco.morandi@euro-studio.it>;
> "LinuxPPC" <linuxppc-embedded@lists.linuxppc.org>
> Sent: Thursday, October 03, 2002 4:20 PM
> Subject: RE: HHL 2.1 preview kit
>
>
> > you need to change some definitions in makefile
> >
> > ARCH := ppc
> > CROSS_COMPILE = ppc_82xx-
> >
> > Bo
> >
> > -----Original Message-----
> > From: Ing.Gianfranco Morandi [mailto:gianfranco.morandi@euro-studio.it]
> > Sent: Thursday, October 03, 2002 9:11 AM
> > To: LinuxPPC
> > Subject: HHL 2.1 preview kit
> >
> >
> >
> > Hi to all,
> >
> > I have a question regarding the preview kit of Montavista.
> >
> > I have downloaded the CD Image and installed the tools for the Sandpoint
> > 8240 (which should be an 82xx architecture).
> >
> > When I try to configure the kernel with "make config" command, no
> processor
> > other than x86 can be selected.
> > In other word I cannot select the Power PC architecture.
> >
> > I would like to install the kit for the EST8260 board and I thought that
> > such installation was a good base to start.
> >
> > Anybody has suggestions to give me?
> >
> > Any help is appreciated.
> >
> > Gianfranco
> >
> >
>
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
