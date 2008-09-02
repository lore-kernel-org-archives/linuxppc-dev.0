Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 76E26DE000
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  2 Sep 2008 20:11:01 +1000 (EST)
Message-ID: <48BD112C.6080902@denx.de>
Date: Tue, 02 Sep 2008 12:10:52 +0200
From: Anatolij Gustschin <agust@denx.de>
MIME-Version: 1.0
To: SETTE AGOSTINO - technolabs <Agostino.Sette@technolabs.it>
Subject: Re: MPC8568MDS RAMDISK Problem
References: <F1F6EC0C8B75034F9E3A79FC85122E8E01000FD1@aquib01a>
In-Reply-To: <F1F6EC0C8B75034F9E3A79FC85122E8E01000FD1@aquib01a>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Agostino,

SETTE AGOSTINO - technolabs wrote:

> First of all thanks for your help. I modified the mpc8568mds_defconfig
> 
>>> cat kernel/linux/arch/powerpc/configs/mpc8568mds_defconfig
> #

<snip>

> 
> But now I face this problem
> 
> ## Checking Image at 02000100 ...
>    Image Name:   Linux-2.6.25.5
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>    Data Size:    1354578 Bytes =  1.3 MB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
> ## Booting image at 02000100 ...
>    Image Name:   Linux-2.6.25.5
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>    Data Size:    1354578 Bytes =  1.3 MB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ... OK
> ## Loading RAMDisk Image at 02200100 ...
>    Image Name:   initrd
>    Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
>    Data Size:    3658110 Bytes =  3.5 MB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
>    Booting using the fdt at 0x21f0100
>    Loading Ramdisk to 00482000, end 007ff17e ... OK
>    Loading Device Tree to 007fa000, end 007fcfff ... OK

Ramdisk image is partially overwritten while loading the
Device Tree: Ramdisk ends at 0x007ff17e, Device Tree starts
at 0x007fa000. You probably need to update U-Boot to recent
version to solve this issue.

> Using MPC85xx MDS machine description
> Memory CAM mapping: CAM0=16Mb, CAM1=16Mb, CAM2=16Mb residual: 15Mb
> Linux version 2.6.25.5 (ity10223@aqlbl05x) (gcc version 4.2.2) #1 Mon Sep 1 10:44:44 CEST 2008
> Found initrd at 0xc0482000:0xc07ff17e

<snip>

> RAMDISK: Compressed image found at block 0
> invalid compressed format (err=1)

Ramdisk decompression failed, it's expected as ramdisk was
overwritten by DTB while booting.

Try to update U-Boot to v1.3.4.

Best regards,
Anatolij

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
