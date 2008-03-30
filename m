Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F2316DDDEF
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 31 Mar 2008 03:21:19 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1Jg1DW-0005dk-FN
	for linuxppc-embedded@ozlabs.org; Sun, 30 Mar 2008 10:21:14 -0700
Message-ID: <16384525.post@talk.nabble.com>
Date: Sun, 30 Mar 2008 10:21:14 -0700 (PDT)
From: Mirek23 <miroslaw.dach@psi.ch>
To: linuxppc-embedded@ozlabs.org
Subject: Re: U-boot + Linux 2.6 + Avnet FX12 MM (based on ML403 config)
In-Reply-To: <10201070.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <10201070.post@talk.nabble.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi Guillaume,

I was facing the same problem with my Avent (virtex 4 FX12) evaluation
board. Originally I have built successfully u-boot 1.2.0  and linux 2.6.21
but I was not able to boot kernel 2.6.21 from u-boot 1.2.0. Kernel 2.6.22
(uImage) onwards can be booted with u-boot 1.2 and higher. Currently I use
u-boot 1.2.0 and kernel 2.6.23 without any problems. My recommendation is to
use at least the kernel version 2.6.22 otherwise you will have kernel panic
problem.

Best Regards

Mirek


Guillaume Berthelom wrote:
> 
> Hi,
> 
> I'm trying to port Linux 2.6 on Avnet FX12 MM board with U-Boot and the
> help of xilinx ML403 config.
> 
> I have generate my costum xparameters.h file with EDK 8.2i.
> I use ELDK 4.1 and Linux 2.6.20.x.
> I have modified ml403.h u-boot's config file to adapt it for my board and
> I have no problem to boot u-boot.
> I use the right board_info structure from <asm/ppcboot.h> and not the one
> in xilinx_ml403.h.
> 
> When I load the zImage directly with xilinx xmd debugger, the kernel start
> without problem (if I don't have KGDB or SERIAL_TEXT_DEBUG option in my
> kernel config). But when I try to load the uImage with u-boot, the kernel
> start but crach befor I can see something on output.
> 
> The kernel start because I debug it and the platform_init is ok,
> setup_arch too and it crach after ppc4xx_setup_arch at  printk(KERN_INFO
> "Xilinx ML403 Reference System (Virtex-4 FX)\n") line  when the kernel
> access in printk.c.
> 
> I suppose the serial init have problem but I have no idea what is the
> cause of the problem. I use the opb_uart16550 IP in my Xilinx design and
> the associat drivers in u-boot and linux.
> 
> Thanks,
> Guillaume Berthelom
> 
> 

-- 
View this message in context: http://www.nabble.com/U-boot-%2B-Linux-2.6-%2B-Avnet-FX12-MM-%28based-on-ML403-config%29-tp10201070p16384525.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
