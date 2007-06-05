Return-Path: <sshtylyov@ru.mvista.com>
Message-ID: <4665C8F4.2090502@ru.mvista.com>
Date: Wed, 06 Jun 2007 00:35:00 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH] powerpc: Create "rom" (MTD) device prpmc2800
References: <20070601232022.GA21237@mag.az.mvista.com>
	<20070604205646.GD10612@mag.az.mvista.com>
In-Reply-To: <20070604205646.GD10612@mag.az.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mark A. Greer wrote:

> For your reference, the exiting DT:
> -----------------------------------
> 
> 	mv64x60@f1000000 { /* Marvell Discovery */
> 		#address-cells = <1>;
> 		#size-cells = <1>;
> 		#interrupt-cells = <1>;
> 		model = "mv64360";			/* Default */
> 		compatible = "marvell,mv64x60";
> 		clock-frequency = <7f28155>;		/* 133.333333 MHz */
> 		reg = <f1000000 00010000>;
> 		virtual-reg = <f1000000>;
> 		ranges = <88000000 88000000 01000000	/* PCI 0 I/O Space */
> 			  80000000 80000000 08000000	/* PCI 0 MEM Space */
> 			  a0000000 a0000000 04000000	/* User FLASH */
> 			  00000000 f1000000 00010000	/* Bridge's regs */
> 			  f2000000 f2000000 00040000>;	/* Integrated SRAM */
> 
> 		flash@a0000000 {
> 			device_type = "rom";
> 			compatible = "direct-mapped";
> 			reg = <a0000000 4000000>; /* Default (64MB) */
> 			probe-type = "CFI";
> 			bank-width = <4>;
> 			partitions = <00000000 00100000 /* RO */
> 				      00100000 00040001 /* RW */
> 				      00140000 00400000 /* RO */
> 				      00540000 039c0000 /* RO */
> 				      03f00000 00100000>; /* RO */

    Hm, this should have been the other way around -- ones with odd size are 
RO, ones with even size are RW.

> 			partition-names = "FW Image A", "FW Config Data", "Kernel Image", "Filesystem", "FW Image B";
> 		};

> So, what should the DT look like for this thing?  And, what should
> phymap_of.c be doing?

> Mark

WBR, Sergei
