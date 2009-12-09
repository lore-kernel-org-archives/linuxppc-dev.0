Return-Path: <B07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4AB44B6F19
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Dec 2009 07:00:15 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	nB9K0BhR003026 for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 9 Dec 2009 13:00:11 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id nB9K0DOY007448
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 9 Dec 2009 14:00:13 -0600 (CST)
Message-ID: <4B2001A3.9010002@freescale.com>
Date: Wed, 09 Dec 2009 13:59:31 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: =?UTF-8?B?5p6X5b+X5bmz?= <solyn123@gmail.com>
Subject: Re: Ping does not work on my MPC8544 board, using linux2.6.23
References: <8148211e0912061953n59dfbe4fsea033494ad8b6fcc@mail.gmail.com>	
	<20091207180511.GA8914@loki.buserror.net>
	<8148211e0912071825t22ffa590va2fe22272f6aaf62@mail.gmail.com>
In-Reply-To: <8148211e0912071825t22ffa590va2fe22272f6aaf62@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

林志平 wrote:
>      > Another question is that I found linux2.6.31 does not support
>      > board mpc8544ds,
> 
>     It should.  What problems do you see?
> 
> => bootm 0x1000000 0x1800000 0x800000
> ## Booting kernel from Legacy Image at 01000000 ...
>    Image Name:   Linux-2.6.31
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>    Data Size:    2185099 Bytes =  2.1 MB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
> ## Loading init Ramdisk from Legacy Image at 01800000 ...
>    Image Name:   Simple Embedded Linux Framework
>    Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
>    Data Size:    1859256 Bytes =  1.8 MB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
> ## Flattened Device Tree blob at 00800000
>    Booting using the fdt blob at 0x800000
>    Uncompressing Kernel Image ... OK
>    Loading Ramdisk to 1fca7000, end 1fe6ceb8 ... OK
> booting kernel using flat tree
> It then stops and never print any more,  I use mpc85xx_defconfig, I 
> select mpc85xxds in the menuconfig and deselect other options like 
> mpc8540ads etc.

Are you using the mpc8544ds device tree from 2.6.31, unchanged?  Try 
turning on CONFIG_PPC_EARLY_DEBUG.

No need to deselect the others, BTW.

>     Does mpc85xx_defconfig not work?
> 
> Yes mcp85xx_defconfig does not work, I can see mpc8540ads in the 
> menuconfig, but no mpc8544ds.

mpc8544ds is supported by CONFIG_MPC85xx_DS.

-Scott
