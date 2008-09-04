Return-Path: <s104259@yahoo.it>
Date: Thu, 4 Sep 2008 13:08:06 +0000 (GMT)
From: Angelo <s104259@yahoo.it>
Subject: Re: Boot 2.6.26 (or similar) on mpc5200 using powerpc
To: Detlev Zundel <dzu@denx.de>
In-Reply-To: <m28wu8f753.fsf@ohwell.denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <90069.85628.qm@web23105.mail.ird.yahoo.com>
Cc: Linuxppc-embedded@ozlabs.org
Reply-To: s104259@yahoo.it
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--- Gio 4/9/08, Detlev Zundel <dzu@denx.de> ha scritto:

> Da: Detlev Zundel <dzu@denx.de>
> Oggetto: Re: Boot 2.6.26 (or similar) on mpc5200 using powerpc
> A: linuxppc-embedded@ozlabs.org
> Data: Gioved=EC 4 settembre 2008, 14:05
> Hi Angelo,
>=20
> > Does anyone boots on mpc5200 board, the linux kernel
> 2.6.26 (or .24 .25) using
> > ARCH=3Dpowerpc?
>=20
> Sure, many people do this successfully.
>=20
> > Looking on web i known that it's very different
> from ppc mode and the right
> > procedure to follow is:
> >
> > 1 - make lite5200b_defconfig ARCH=3Dpowerpc
> CROSS_COMPILE=3Dpowerpc-linux-gnu-
>=20
> Note that this changes to "make
> 52xx/lite5200b_defconfig ..." in recent kernels.

Ok. I use 52xx/lite5200b_defconfig.

>=20
> > 2 - make cuImage.lite5200b ARCH=3Dpowerpc
> CROSS_COMPILE=3Dpowerpc-linux-gnu-
>=20
> Well, this is debatable.  Here you explicitely request a
> backward
> compatability wrapped uImage (for firmwares being FDT
> ignorant):
>=20

Can i use also $ make uImage ... ?! Or only cuImage!?

> > The output of second command is:
> > ...
> >   CHK     include/linux/version.h
> >   CHK     include/linux/utsrelease.h
> >   CALL    scripts/checksyscalls.sh
> >   CHK     include/linux/compile.h
> >   CALL    arch/powerpc/kernel/systbl_chk.sh
> >   CALL    arch/powerpc/kernel/prom_init_check.sh
> > arch/powerpc/boot/dtc -O dtb -o
> arch/powerpc/boot/lite5200b.dtb -b 0  /home/
> >
> asimmini/Scrivania/linux-2.6.26.3/arch/powerpc/boot/dts/lite5200b.dts
> > DTC: dts->dtb  on file
> "/home/asimmini/Scrivania/linux-2.6.26.3/arch/powerpc/
> > boot/dts/lite5200b.dts"
> >   WRAP    arch/powerpc/boot/cuImage.lite5200b
>=20
>     ^----  Here the wrapper gets added.
>=20
> > Image Name:   Linux-2.6.26.3
> > Created:      Wed Sep  3 15:56:16 2008
> > Image Type:   PowerPC Linux Kernel Image (gzip
> compressed)
> > Data Size:    1597696 Bytes =3D 1560.25 kB =3D 1.52 MB
> > Load Address: 0x00400000
> > Entry Point:  0x00400550
> > rm arch/powerpc/boot/lite5200b.dtb
> >
> > But, at this point, if i crosscompile in ppc mode i
> had to modify the Load
> > Address wiht the mkimage tool because the SDRAM at the
> Bootloader time starts
> > from 0xF8000000, while the uImage has a Load Address
> and Entry Point at
> > 0x00000000.
>=20
> Well still in newer kernels, uImage has load and entry
> address 0.  Its
> only the cuImage.lite5200b (and I presume other wrapped
> kernels) that
> have this load address.
>=20
> > What should i do in powerpc mode??
>=20
> I suggest that you use a recent U-Boot on your board which
> can
> explicitely pass a .dtb to the kernel and use a plain
> uImage + flat
> device tree blob.  I gather this is the best tested
> combination.  I
> myself saw problems with the wrapped image that went away
> when passing
> the device tree explicitely.
>=20
> So in 2.6.26 I'd advise you to do a "make
> uImage" + "make lite5200b.dtb"
> and use the results in a recent U-Boot.

But lite5200b.dtb doesn't exist. So i'm looking for it and i known that i h=
ad to generate it using this command:

$ arch/powerpc/boot/dtc -b0 -Idts -Odtb -V16 arch/powerpc/boot/dts/lite5200=
b.dts > lite5200b.dtb
I'm wrong?!

So at this point i've got dtb, but somwhere i saw that it's necessary to do=
wnload lite5200.dtb to the system...

And at this point I try to boot the board:

1. usb start
2. usb scan
3. fatload usb 0 0xfc000000 cuImage.lite5200b
(3. fatload usb 0 0xfc000000 uImage - if i use make uImage)
4. fatload usb 0 0xfd000000 rootfs.uimage
5. fatload usb 0 0x???????? lite5200b.dtb
6. bootm 0xfc000000 0x????????

However my uboot version is 1.2.0.=20

Many thanks.
=0A=0A__________________________________________________=0ADo You Yahoo!?=
=0APoco spazio e tanto spam? Yahoo! Mail ti protegge dallo spam e ti da tan=
to spazio gratuito per i tuoi file e i messaggi =0Ahttp://mail.yahoo.it 
