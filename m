Return-Path: <edfuchs@uni-kassel.de>
Received: from hrz-ws39.hrz.uni-kassel.de (smtp.hrz.uni-kassel.de
	[141.51.12.230]) by ozlabs.org (Postfix) with ESMTP id C1059DDDA0
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Mar 2009 02:35:05 +1100 (EST)
Received: from ws-87.localnet (rs-pc1.rs.eecs.uni-kassel.de [141.51.112.154])
	by hrz-ws39.hrz.uni-kassel.de (8.14.0/8.14.0) with ESMTP id
	n2KFZ1Lh012683
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Mar 2009 16:35:01 +0100
From: Eduard Fuchs <edfuchs@uni-kassel.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: Problem with radeonfb on PowerPC 7448&MV64560
Date: Fri, 20 Mar 2009 16:35:02 +0100
References: <200903171630.25340.edfuchs@uni-kassel.de>
	<200903191051.37875.edfuchs__31387.3780928136$1237456433$gmane$org@uni-kassel.de>
	<m2bprw79i8.fsf@ohwell.denx.de>
In-Reply-To: <m2bprw79i8.fsf@ohwell.denx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200903201635.03017.edfuchs@uni-kassel.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Am Freitag 20 M=C3=A4rz 2009 11:51:11 schrieb Detlev Zundel:
> Hi Eduard,
>
> > Am Mittwoch 18 M=C3=A4rz 2009 00:05:00 schrieb Benjamin Herrenschmidt:
> >> On Tue, 2009-03-17 at 16:30 +0100, Eduard Fuchs wrote:
> >> > Hi all,
> >> >
> >> > since several days I'm trying to run an ATI 9250 (PCI) graphic card
> >> > under Linux Kernel 2.6.27.19. Nevertheless without success. The kern=
el
> >> > shows the following message:
> >> >
> >> > videoboot: Booting PCI video card bus 0, function 0, device 7
> >> > biosEmu: undefined interrupt 15h called!
> >> > biosEmu/bios.int42: unknown function AH=3D0x0, AL=3D0x7, BL=3D0x0
> >>
> >> The above comes from some patches you added to the kernel ? You should
> >> probably do the softboot in the firmware instead...
> >
> > Yes. I'm using the videoboot-2.6x.patch (this patch contain also the
> > xf86emu from www.scitechsoft.com). With this pach the radeon card work
> > properly with 2.6.12 kernel version. On the 2.6.27 kernel the "videoboo=
t"
> > fetch the bios from the video card and start them in the xf86emu.
> >
> > Can I initialize the video card in uboot too?
>
> Yes, indeed you can.  In a recent version of U-Boot, search for
> 'CONFIG_BIOSEMU' in include/configs/*.  We tested this on a sequoia
> board, so include/configs/sequoia.h should be a good start for this.

Thanks.

I tried to include BIOSEMU and RADEON_FB in my u-boot. Bios emulator seems =
to=20
be properly loaded, but when u-boot attempt to read or write Radeon's=20
registers, the board freezes.

What means exactly the value of "VIDEO_IO_OFFSET" in the config file?=20

There is a u-boot's output when I init the VIDEO_IO_OFFSET with PCI's I/O b=
ase=20
address:


INFO : PCI0_IO : base - 0xd8000000 size - 1M bytes
INFO : PCI0_MEM0: base - 0x80000000 size - 1024M bytes
INFO : PCI0_MEM1: base - 0xc0000000 size - 128M bytes
INFO : PCI0_MEM2: base - 0xc8000000 size - 128M bytes
INFO : PCI0_MEM3: base - 0xd0000000 size - 128M bytes
=2E....
PCI Scan: Found Bus 0, Device 7, Function 0
PCI Scan: Found Bus 0, Device 7, Function 1
PCI Scan: Found Bus 0, Device 9, Function 0
PCI Scan: Found Bus 0, Device 10, Function 0
Video: ATI Radeon video card (1002, 5960) found @(0:7:0)
videoboot: Booting PCI video card bus 0, function 0, device 7
E 0000 0 F00P0F000NI00PMS0EG 0F00

and after that follows board reset.

Best regards.

Eduard Fuchs
