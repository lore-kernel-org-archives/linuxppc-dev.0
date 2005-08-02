Return-Path: <d.grab@hima.com>
Received: from hima.com (mail.hima.com [80.146.244.10])
	by ozlabs.org (Postfix) with SMTP id 6A0CF67E1C
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  2 Aug 2005 18:10:15 +1000 (EST)
Received: from SN7606 ([192.168.100.10])
	by hima.com (mail.hima.com [212.116.4.129]) (MDaemon.PRO.v8.1.1.R)
	with ESMTP id md50000075475.msg
	for <linuxppc-embedded@ozlabs.org>; Tue, 02 Aug 2005 10:10:16 +0200
From: "David Grab" <d.grab@hima.com>
To: "'FCG WANG Baohua'" <Baohua.WANG@alcatel-sbell.com.cn>
Date: Tue, 2 Aug 2005 10:08:40 +0200
Message-ID: <001601c59739$65549820$f201a8c0@SN7606>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0017_01C5974A.28DFD920"
In-reply-to: <A9DE2BAF233E444FA9C5E77A5825A01E865051@ydmail.sbell.com.cn>
Cc: linuxppc-embedded@ozlabs.org
Subject: AW: Bad Magic Number when boot linux kernel with ppcboot (PPC860
	board)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------=_NextPart_000_0017_01C5974A.28DFD920
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

>Dear Denk:
>  The magic number is right when using vmlinux.UBoot instead of vmlinux or
zImage, Why?

u-boot needs an u-boot image. Wolfgang did already say that vmlinux.UBoot is
that image. So use this image and nothing else. Also read the manual
especially this chapter
http://www.denx.de/twiki/bin/view/DULG/BootingEmbeddedLinux

>  Another question puzzle me:
>  The kernel print the "Transferring control to Linux (at address 00000000)
... "  then halt ,no any response 
> from serial port.

Seems for me that the serial configuration did not match. Are you sure you
chosen and cofigured the right UART? If so then debug with BDI2000. 

>  I tried ramdiak and nfs, there are the same result.
>  So why not print the 
>  "Linux version 2.4.25 (root at FedoraCore2) (gcc version 3.3.3 (DENX ELDK
3.1
>3.3.3-8)) #94 Tue Jul 5 18:59:08 PDT 2005" 

The console output has nothing to do with ramdisk or nfs. So check your
configuration of the active console. An quick check, if your u-boot did not
pass the console parameters is to set the console parameter in linux. For
that you have to activate command line to yes and set the command line
parameter to 'console=ttySx'. x=0 is UART0 and x=1 is UART1. If this not
help then debug again with BDI.

>  How to not print the "Transferring control to Linux (at address 00000000)
... "  ? Is it right ? 
>  Thanks a lot!

This print might be ok.

Best regards,

David

------=_NextPart_000_0017_01C5974A.28DFD920
Content-Type: application/ms-tnef;
	name="winmail.dat"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="winmail.dat"

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
BgAAAAAAwAAAAAAAAEYAAAAAAYUAAAAAAAALABuACCAGAAAAAADAAAAAAAAARgAAAAAOhQAAAAAA
AAMAHIAIIAYAAAAAAMAAAAAAAABGAAAAABGFAAAAAAAAAwAegAggBgAAAAAAwAAAAAAAAEYAAAAA
GIUAAAAAAAACAfgPAQAAABAAAACdDkN5VaT5R6CodZGB/tasAgH6DwEAAAAQAAAAnQ5DeVWk+Ueg
qHWRgf7WrAIB+w8BAAAAVAAAAAAAAAA4obsQBeUQGqG7CAArKlbCAABtc3BzdC5kbGwAAAAAAE5J
VEH5v7gBAKoAN9luAAAAQzpcT3V0bG9vay1EYXRlaWVuXG1haWxib3gucHN0AAMA/g8FAAAAAwAN
NP03AAACAX8AAQAAADEAAAAwMDAwMDAwMDlEMEU0Mzc5NTVBNEY5NDdBMEE4NzU5MTgxRkVENkFD
NjQ4RTBGMDEAAAAAAwAGEMc2FawDAAcQTQQAAAMAEBABAAAAAwAREAAAAAAeAAgQAQAAAGUAAABE
RUFSREVOSzpUSEVNQUdJQ05VTUJFUklTUklHSFRXSEVOVVNJTkdWTUxJTlVYVUJPT1RJTlNURUFE
T0ZWTUxJTlVYT1JaSU1BR0UsV0hZP1UtQk9PVE5FRURTQU5VLUJPT1RJAAAAAIo2

------=_NextPart_000_0017_01C5974A.28DFD920--
