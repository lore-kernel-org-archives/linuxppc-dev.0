Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 2DBA3DE027
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jan 2009 01:25:38 +1100 (EST)
Message-ID: <496F4760.1010007@denx.de>
Date: Thu, 15 Jan 2009 15:25:36 +0100
From: Anatolij Gustschin <agust@denx.de>
MIME-Version: 1.0
To: Jean-Michel Hautbois <jhautbois@gmail.com>
Subject: Re: [MPC8272ADS]Cannot start my Linux Kernel
References: <8cad0aa0901150342s2362e53bqf9472c1dc239636c@mail.gmail.com>	
	<496F318D.6010302@denx.de>
	<8cad0aa0901150510o7a8146f1m2045e252c5e1cf24@mail.gmail.com>
In-Reply-To: <8cad0aa0901150510o7a8146f1m2045e252c5e1cf24@mail.gmail.com>
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

Jean-Michel Hautbois wrote:
> I just tried. I created a dtb from the file
> arch/powerpc/boot/dst/mpc8272ads.dts file.
> It is not rebboting, but handling (my "run" led is switching off).
> 
> => tftp 2000000 mpc8272ads.dtb
> Using FCC1 ETHERNET device
> TFTP from server 10.0.0.1; our IP address is 10.0.0.2
> Filename 'mpc8272ads.dtb'.
> Load address: 0x2000000
> Loading: #
> done
> Bytes transferred = 4442 (115a hex)
> => bootm FF800000 FF980000 2000000
> ## Booting kernel from Legacy Image at ff800000 ...
>    Image Name:   Linux-2.6.29-rc1-01197-g5a7b6e7-
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>    Data Size:    1487167 Bytes =  1.4 MB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
> ## Loading init Ramdisk from Legacy Image at ff980000 ...
>    Image Name:   Simple Embedded Linux Framework
>    Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
>    Data Size:    1730966 Bytes =  1.7 MB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
> ## Flattened Device Tree blob at 02000000
>    Booting using the fdt blob at 0x2000000
>    Uncompressing Kernel Image ... OK
>    Loading Ramdisk to 039d7000, end 03b7d996 ... OK
>    Loading Device Tree to 007fb000, end 007ff159 ... OK
> Unable to update property /cpus/cpu@0:bus-frequency, err=FDT_ERR_NOTFOUND
> Unable to update property /cpus/cpu@0:timebase-frequency,
> err=FDT_ERR_NOTFOUND
> Unable to update property /cpus/cpu@0:clock-frequency, err=FDT_ERR_NOTFOUND

try to fix "ft_cpu_setup()" in your u-boot source for mpc8272ads
and use "PowerPC,8272@0" as cpu_path instead of "cpu@0".

Best regards,
Anatolij
