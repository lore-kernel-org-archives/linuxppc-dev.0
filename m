Return-Path: <jhautbois@gmail.com>
Received: from mail-ew0-f20.google.com (mail-ew0-f20.google.com
	[209.85.219.20]) by ozlabs.org (Postfix) with ESMTP id B70F5DE3D1
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Jan 2009 04:53:27 +1100 (EST)
Received: by ewy13 with SMTP id 13so2434576ewy.9
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jan 2009 09:53:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <8cad0aa0901160944l48bd0e99wa13f23907838376d@mail.gmail.com>
References: <8cad0aa0901150342s2362e53bqf9472c1dc239636c@mail.gmail.com>
	<496F318D.6010302@denx.de>
	<8cad0aa0901150510o7a8146f1m2045e252c5e1cf24@mail.gmail.com>
	<496F4760.1010007@denx.de>
	<8cad0aa0901150706u72538941rbc22655d5a8905ea@mail.gmail.com>
	<8cad0aa0901160406l3db9c025ubdcac40b4b464d23@mail.gmail.com>
	<20090116172903.GA722@ld0162-tx32.am.freescale.net>
	<8cad0aa0901160944l48bd0e99wa13f23907838376d@mail.gmail.com>
Date: Fri, 16 Jan 2009 18:53:25 +0100
Message-ID: <8cad0aa0901160953te6c7d1cg3a4df7de7da7d182@mail.gmail.com>
Subject: Re: [MPC8272ADS]Cannot start my Linux Kernel
From: Jean-Michel Hautbois <jhautbois@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

2009/1/16 Jean-Michel Hautbois <jhautbois@gmail.com>:
> 2009/1/16 Scott Wood <scottwood@freescale.com>:
>> On Fri, Jan 16, 2009 at 01:06:06PM +0100, Jean-Michel Hautbois wrote:
>>> Could it be a problem in my bootargs command line ?
>>> I mean, maybe the console=3DttyS0,11500 wrong ?
>>> Because my "Run" LED is on...
>>>
>>> I tried ttyS0, ttyCPM0, tty0.
>>
>> It should be ttyCPM0, or just leave it out and make sure that
>> /chosen/linux,stdout-path is set properly.
>>
>> Have you tried enabling early CPM debugging output?
>>
>> -Scott
>>
>
> Well, I have to say, yes, I tried:
> CONFIG_PPC_EARLY_DEBUG_CPM=3Dy
> CONFIG_PPC_EARLY_DEBUG_CPM_ADDR=3D0xf0001ff8
>
> I have also tried without specifying the console outp=FBt:
> setenv bootargs root=3D/dev/ram rw
>
> Nothing more...
>
> JM
>

OK, I just tried a make of my kernel (already compiled yesterday), and
it generated a cuImage.mpc8272ads kernel image (which it didn't do
yesterday).
I don't know why this image was generated, but I tried to reboot using this=
 one.

And I am going further !

Hit any key to stop autoboot:  0
## Booting kernel from Legacy Image at 01000000 ...
   Image Name:   Linux-2.6.29-rc1-01197-g5a7b6e7-
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1529877 Bytes =3D  1.5 MB
   Load Address: 00400000
   Entry Point:  00400b94
   Verifying Checksum ... OK
## Loading init Ramdisk from Legacy Image at ff980000 ...
   Image Name:   Simple Embedded Linux Framework
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    1730966 Bytes =3D  1.7 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
## Flattened Device Tree blob at 02000000
   Booting using the fdt blob at 0x2000000
   Uncompressing Kernel Image ... OK
   Loading Ramdisk to 039d7000, end 03b7d996 ... OK
   Loading Device Tree to 007fb000, end 007ff159 ... OK
Memory <- <0xd00dfeed 0x2000> (0MB)
ENET0: local-mac-address <- 00:00:00:00:00:7f
ENET1: local-mac-address <- 00:00:00:00:00:00
CPU clock-frequency <- 0x0 (0MHz)
CPU timebase-frequency <- 0x800 (0MHz)
CPU bus-frequency <- 0x2000 (0MHz)

zImage starting: loaded at 0x00400000 (sp: 0x03b7ebe0)
Allocating 0x329908 bytes for kernel ...
gunzipping (0x00000000 <- 0x0040d000:0x007591d8)...done 0x308b0c bytes

Linux/PowerPC load:
Finalizing device tree... flat tree at 0x767300
id mach(): done
MMU:enter
MMU:hw init
MMU:mapin
MMU:setio
MMU:exit

I am stuck there, with my eth LEDs blinking...

JM
