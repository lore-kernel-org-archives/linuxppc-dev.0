Message-ID: <B25E2E5A003CD311B61E00902778AF2A039C3597@SERVER1>
From: Subodh Nijsure <SNijsure@SkyStream.com>
To: "'Rudolf Ladyzhenskii'" <rudolf.ladyzhenskii@act-aus.net>,
	"Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: autoboot with initial RAM disk
Date: Thu, 20 Dec 2001 21:17:48 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

Not sure if this what you want --

Create a multi-image using the ppcboot utility mkimage using command like

mkimage -n "Linux Kernel And Ramdisk" -A ppc -O linux  -T multi -C gzip \
-a 0x00000000  -e 0x00000000 -d
./arch/ppc/coffboot/vmlinux.gz:ramdisk.image.gz linux-image

This will create a file linux-image that has linux kernel and ramdisk that
ppcboot
can load.

Now in your ppcboot you set bootcommand as,

setenv bootcmd tftpboot 900000 /tftpboot/linux-image \; bootm 900000

Now the autoboot will load the linux-image from your tftpserver.

/Subodh

-----Original Message-----
From: Rudolf Ladyzhenskii [mailto:rudolf.ladyzhenskii@act-aus.net]
Sent: Thursday, December 20, 2001 8:45 PM
To: Linuxppc-Embedded (E-mail)
Subject: autoboot with initial RAM disk



Hi, all

I am using ppcboot to start my 8260 based card. At the moment, we load Linux
kernel via tftp and then start it. Linux kernel maps its root file system
over the network. This works fine qith ppcboot autoboot feature.

Now, we want to put initial RAM disk into RAM as well as compressed kernel.
Do do that, both images have to be copied into card's memory using tftp and
them bootm command will be used with two arguments to start kernel.

To continue to use ppcboot autoboot feature we have to pass two commands as
boot command (to tftp two kernels) and then issue bootm command with two
arguments. Is there any way of doing it without altering the ppcboot source
code?

Thanks,
/************************/
Rudolf Ladyzhenskii
DSP Engineer
Advanced Communication Technologies
ph.  +61 3 8080 8215
fax. +61 3 9672 8800
Level 9, 190 Queen Street,
Melbourne, 3000
Australia
/***********************/


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
