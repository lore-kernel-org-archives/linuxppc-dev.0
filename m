Return-Path: <Baohua.WANG@alcatel-sbell.com.cn>
Received: from mail.alcatel-sbell.com.cn (nat1.alcatel-sbell.com.cn
	[202.96.203.177]) by ozlabs.org (Postfix) with ESMTP id 71A2D67DC7
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Jul 2005 18:28:14 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset=gb2312
Date: Fri, 29 Jul 2005 16:27:06 +0800
Message-ID: <A9DE2BAF233E444FA9C5E77A5825A01E86504E@ydmail.sbell.com.cn>
From: "FCG WANG Baohua" <Baohua.WANG@alcatel-sbell.com.cn>
To: "John W. Linville" <linville@tuxdriver.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: =?gb2312?b?tPC4tDogSG93IHRvIGxvYWQgYSBsaW51eCBrZXJuZWwgdW5kZXIg?=
	=?gb2312?b?dnh3b3JrcyBib290bG9hZGVyIChQUEM4NjAgYm9hcmQp?=
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear linville:
  I found that the vxWorks bootrom is load to RAM 0x2800100 address, but =
different address with the different kernel file downloading to the RAM.
   For example: the ppcboot ELF file is downloaded to the 0x2800000 and =
only 150256 bytes is downloaded (total file size is 989064 bytes)
                           the zImage kernel file  is downloaded to the =
0x380000 and only 533004 bytes is downloaded (total file size is 591899 =
bytes)
  What's the reason for explain it? Does the vxWorks bootloader =
uncompressed the file with its own algorithm?=20
  How to download the U-Boot ELF file correctly? Thanks!=20
  The right way is to find the right entry points of U-Boot, but =
whatever I change the configure of U-Boot, it doesn't work at all. That =
is, the entry point is=20
  forever 0x2800000 for U-Boot and 0x380000  for zImage.=20
 =20

-----=D4=AD=CA=BC=D3=CA=BC=FE-----
=B7=A2=BC=FE=C8=CB: John W. Linville [mailto:linville@tuxdriver.com]
=B7=A2=CB=CD=CA=B1=BC=E4: 2005=C4=EA7=D4=C229=C8=D5 0:58
=CA=D5=BC=FE=C8=CB: FCG WANG Baohua
=D6=F7=CC=E2: Re: How to load a linux kernel under vxworks bootloader =
(PPC860
board)


On Thu, Jul 28, 2005 at 01:02:04PM +0800, FCG WANG Baohua wrote:
>  Dear linville:
>    I want to boot a linux 2.4.25 kernel under vxworks
>  bootloader. When I using flat mode(0x200000 -->  0x10000)
>  kernel  uncompressed ELF format ( vmlinux ),
>   and download it using TFTP of vxworks, it print the "starting
>  at 0x1000 ...." and  freeze.  No input or output on serial port.
>   The version of vxworks is 5.3.1.=20
>   can you give me some detail advice or give me a tool to slove
>  it? thanks !

It looks like Guy Streeter gave you as good advice as I could give.
Be sure to read his post on linuxppc-embedded.

In the past there was an issue in that the VxWorks boot loader only
loaded .text and .data sections from ELF images.  At that time,
zImage files packed the "real" kernel image into an extra section
in the ELF file, and the VxWorks loader would not load it.  The fix
then was to hack the ELF header to make the extra section appear to
be part of the .data section.

Thankfully, I recall that later kernel versions did not have that
problem.  I think using a zImage (or zImage.initrd) file that has
been properly modified to support your board should be all that
is necessary.  Using a zImage is necessary because it includes a
"shim" that knows how to communicate critical information to the
actual Linux kernel.  The VxWorks boot loader does not provide this
information to Linux.

As someone else suggested, your best bet would be to use U-Boot or some
other loader that understands Linux.  U-Boot ports are fairly simple.
If you don't want to do one, you probably could convince me to do
a U-Boot port if you wanted to send me a board (and possibly some
reasonably compensation)... :-)

Good luck!

John
--=20
John W. Linville
linville@tuxdriver.com
