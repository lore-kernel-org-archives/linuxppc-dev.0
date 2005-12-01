Return-Path: <carl.ljungmark@sysgo.com>
Received: from mail.sysgo.com (mail.sysgo.com [62.8.134.5])
	by ozlabs.org (Postfix) with ESMTP id 79AC868865
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Dec 2005 23:45:23 +1100 (EST)
To: pritha.bhattacharya@tcs.com,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
References: <OF0098DF7F.857DE409-ON652570CA.001AA3F7-652570CA.0036DB32@tcs.com>
Message-ID: <op.s03tnrwi0c7u6q@clj.sysgo.com>
Date: Thu, 01 Dec 2005 13:15:17 +0100
From: "Carl Ljungmark" <carl.ljungmark@sysgo.com>
Content-Type: text/plain; format=flowed; delsp=yes; charset=utf-8
MIME-Version: 1.0
In-Reply-To: <OF0098DF7F.857DE409-ON652570CA.001AA3F7-652570CA.0036DB32@tcs.com>
Subject: Re: Linux hangs while Uncompressing
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Try to change your 'load address' and 'entry address' to a more sensible =
=20
value, maybe 0x30080000 or so. This is done when you create the PPCBOOT =20
image with mkimage, by passing parameters -a and -e respectively. Right =20
now, U-boot tries to uncompress the kernel into your boot flash, which =20
hopefully is hw-protected..
good luck
/Carl

On Thu, 01 Dec 2005 10:59:10 +0100, <pritha.bhattacharya@tcs.com> wrote:

>
> Hi All,
>
> I have RAM version of U-Boot which is running on a board similar to
> MPC8260. My memory map isas follows:
>
> Staring address         Device          Size                  Memory
> controller and CS
>
> 0000 0000
> 0800 0000
> FFF0 0000
> 0F00 0000
> 3000 0000
> 3800 0000
> 4200 0000
> 5000 0000
> FLASH (Boot)
> FLASH (Code)
> SSRAM
> CPU internal registers
> SDRAM
> SDRAM
> Framer
> DSP 8102
> 1MB (512Kx16)
> 4 MB (1Mx16)
> 2 MB (512Kx36)
> 128 KB
> 128 MB (16Mx72)
> 128 MB (16Mx72)
> 1 MB
> 2 MB
> BR0/OR0: CS0
> BR1/OR1: CS1
> BR2/OR2: CS2
>
> BR3/OR3: CS3
> BR4/OR4: CS4
> BR5/OR5: CS5
> BR6/OR6: CS6
>
>
> I have downloaded Linux 2.4.25 kernel image through kermit. after
> downloading the image in SDRAM location 0x30000000 and giving the comma=
nd
> bootm 0x30000000
>
>  the prompt shows a message:
>
>
> TCS-PIC-UBOOT=3D> loadb 0x30000000## Ready for binary (kermit) download=
 to
> 0x30000000 at 57600 bps...
>
> ## Total Size      =3D 0x000936f6 =3D 603894 Bytes
> ## Start Addr      =3D 0x30000000
> TCS-PIC-UBOOT=3D> bootm 0x30000000## Booting image at 30000000 ...
>    Image Name:   Linux-2.4.25
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>    Data Size:    603830 Bytes =3D 589.7 kB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ...
>
> The system hangs here and is not able to uncompress the kernel any
> further. I have checked in the FAQs provided in the denx's site, but =20
> could
> not find anything similar to my case.
>
> I would appreciate any help.
>
> Thanks & Regards,
> Pritha Bhattacharya
> Tata Consultancy Services Limited
> Mailto: pritha.bhattacharya@tcs.com
> Website: http://www.tcs.com
>
> Notice: The information contained in this e-mail message and/or =20
> attachments to it may contain confidential or privileged information.  =
 =20
> If you are not the intended recipient, any dissemination, use, review, =
=20
> distribution, printing or copying of the information contained in this =
=20
> e-mail message and/or attachments to it are strictly prohibited.   If =20
> you have received this communication in error, please notify us by repl=
y =20
> e-mail or telephone and immediately and permanently delete the message =
=20
> and any attachments.  Thank you
