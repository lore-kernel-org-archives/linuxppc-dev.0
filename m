Return-Path: <B07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 87554B7CB7
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 15 Jan 2010 08:47:13 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o0ELl9pH026692 for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 14 Jan 2010 14:47:09 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id o0ELrWXI013032
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 14 Jan 2010 15:53:32 -0600 (CST)
Message-ID: <4B4F9059.9050705@freescale.com>
Date: Thu, 14 Jan 2010 15:44:57 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Andres Marquez <amarquez@edgeaccess.net>
Subject: Re: Problem dtb file booting Kernel 2.6.32
References: <1263501641.12055.9.camel@localhost.localdomain>
In-Reply-To: <1263501641.12055.9.camel@localhost.localdomain>
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

Andres F Marquez wrote:
> Hello,
> 
> I am working on a MPC8265 board which I have successfully ported Linux
> Kernel 2.6.25 to. I am trying to upgrade the Kernel but have not got
> good results (I am able to compile the Kernel for my powerpc, but not to
> boot it). The problem appears to be something related to the interaction
> between the dtb and the Kernel. I am not sure if the syntax for the dts
> file may have changed from Kernel 2.6.25 to newer versions (I have tried
> 2.6.27.43 - 2.6.32.2 and 2.6.31.11 getting very similar results).

Can you bisect between 2.6.25 and 2.6.27 to see which commit may have 
broken it?

What sort of changes did you make to get 2.6.25 to work?

> When I build the dtb file from the /arch/powerpc/boot/dts/MPC8272ADS.dts
> file that comes with the new Kernel, the booting process gets stuck
> after trying to load the device tree:
> 
> 	## Booting image at ff810000 ...
>    		Image Name:   Linux-2.6.27.43
>    		Image Type:   PowerPC Linux Kernel Image (gzip  
> 			compressed)
> 		Data Size:    1365263 Bytes =  1.3 MB
>    		Load Address: 00000000
>    		Entry Point:  00000000
>    		Verifying Checksum ... OK
>    		Uncompressing Kernel Image ... OK
>    		Booting using the fdt at 0xff802000
>    		Loading Device Tree to 007fc000, end 007fefff ... OK
> 
> 
>    However, when I boot the new Kernel with the old compiled dtb file
> (the one that works with the Kernel 2.6.25) the process moves forward
> but stops at a time when displaying information about IRQ 40 line
> (related to the Programmable Interrup Controller (PIC)):

Decompile that device tree blob using dtc -I dtb -O dts, and look for 
differences.

-Scott
