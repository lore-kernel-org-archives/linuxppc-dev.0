Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by ozlabs.org (Postfix) with ESMTP id 81252DDE1B
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 14 Jun 2008 00:30:57 +1000 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1K7AIg-0004zs-M4
	for linuxppc-embedded@ozlabs.org; Fri, 13 Jun 2008 14:30:46 +0000
Received: from fw-emea.rohde-schwarz.com ([80.246.32.33])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Fri, 13 Jun 2008 14:30:46 +0000
Received: from euphoria by fw-emea.rohde-schwarz.com with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Fri, 13 Jun 2008 14:30:46 +0000
To: linuxppc-embedded@ozlabs.org
From: Florian Boelstler <euphoria@arcor.de>
Subject: Re: Reserving small amounts of memory with mem= (MPC85xx,   2.6.15
	arch/ppc)
Date: Fri, 13 Jun 2008 16:30:37 +0200
Message-ID: <g2u0ae$238$1@ger.gmane.org>
References: <g2ri8j$qlk$1@ger.gmane.org>
	<d194b8ce0806121214w2ac2edf6n7f222eb51463a989@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
In-Reply-To: <d194b8ce0806121214w2ac2edf6n7f222eb51463a989@mail.gmail.com>
Sender: news <news@ger.gmane.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

thanks for your response.

Sylvain Joyeau wrote:
> Residual memory size is what Linux couldn't map with its three CAM
> entries. The main figure you can check is the sum of the three first
> CAMs   plus residual is what you specified (CAM0+CAM1+CAM2+residuak ==
> 'mem'). It's not weird to get a residual != 0 when specified memory
> size isn't a good combination of power of 2.

Again I tried mem=508M together with initrd_high @ 10000000. This time 
the kernel booted.
Shown mapping is: CAM0=256Mb, CAM1=64Mb, CAM2=64Mb residual: 124Mb, 
which is == 'mem'.

Available system memory is only 384 MB (CAM0+CAM1+CAM2), which explains 
why Linux "removed" the ramdisk, when it has been copied right below 
508M by U-Boot. Because at that time I was using initrd_high @ 1FC00000, 
which is outside of mapped RAM.

Is there an option to map less than 64M by a CAM entry?

> Stupid question: have you tried mem=512M and a correct RAM disk address ?
> No more comments...

I just did that (I don't get what you wanted to achieve with these 
settings, since this the default):

=> setenv bootargs console=ttyS0,115200 mem=512M
=> setenv initrd_high 20000000
=> bootm 0x02100000

## Booting image at 02100000 ...
    Image Name:   Linux 2.6.15
    Image Type:   PowerPC Linux Multi-File Image (gzip compressed)
    Data Size:    6965022 Bytes =  6.6 MB
    Load Address: 00000000
    Entry Point:  00000000
    Contents:
    Image 0:  1099550 Bytes =  1 MB
    Image 1:  5865458 Bytes =  5.6 MB
    Verifying Checksum ... OK
    Uncompressing Multi-File Image ... OK
## Current stack ends at 0x1FFAECB8 => set upper limit to 0x00800000
[...]

## initrd at 0x0220C76C ... 0x027A475D (len=5865458=0x597FF2)
    Loading Ramdisk to 1fa16000, end 1ffadff2 ... OK
## Transferring control to Linux (at address 00000000) ...
Memory CAM mapping: CAM0=256Mb, CAM1=256Mb, CAM2=0Mb residual: 0Mb
Linux version 2.6.15 (flo@escape) (gcc version 3.4.3) #21 PREEMPT Fri 
Nov 30 16:47:32 CET 2007
[...]

Have a nice weekend,

   Florian
