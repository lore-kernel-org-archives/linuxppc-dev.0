Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 93E2BDDF69
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 07:43:54 +1000 (EST)
Message-ID: <46F2E977.7040608@freescale.com>
Date: Thu, 20 Sep 2007 16:43:19 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Alan Bennett <embedded@akb.net>
Subject: Re: device tree question
References: <bfa0697f0709181343m1fc9f9b9u8acd429663d1adae@mail.gmail.com>	
	<46F052EE.1040004@freescale.com>	
	<bfa0697f0709181604i5758824foad67a86455f45d8e@mail.gmail.com>	
	<46F05BF7.6020906@freescale.com>	
	<bfa0697f0709190638r6894fab6gd31a5672a997e97@mail.gmail.com>	
	<46F16BD4.2000207@freescale.com>	
	<bfa0697f0709191420x5a6aed9dx499fe4a8cf6b1b2d@mail.gmail.com>	
	<46F19326.7050507@freescale.com>	
	<bfa0697f0709201053s3643523eid42ea60dae53af84@mail.gmail.com>	
	<46F2BC7D.3070908@freescale.com>
	<bfa0697f0709201438y7a74d1c8u85b9a2edfc825e32@mail.gmail.com>
In-Reply-To: <bfa0697f0709201438y7a74d1c8u85b9a2edfc825e32@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Alan Bennett wrote:
> Device Tree and BRG?
>   The SMC1 uses BRG7 and the SCC1 uses BRG1, should we have both BRGs
> configured in the .dts?  ( BRG1 is configured).

They should both be specified, and either in the firmware or in the 
platform code you need to set CMXSMR.

> Device Tree and Chosen?
>   Adding a chosen block and I end up off in the weeds.  removing the
> chosen block and I die within cpm_uart_console_write
>         chosen {
>                 linux,stdout-path = "/soc/cpm/serial@11a80";
>         };

If you remove the chosen node, you won't get any output from the 
bootwrapper, but it shouldn't crash.

>   In arch/boot/ep8248e, there is a call to:
> planetcore_set_stdout_path(table) is this why there is no
> chosen/stdout-path element in the device tree?

The ep8248e bootwrapper platform is for planetcore (as that's what the 
board ships with).  If you're using u-boot, it's the cuboot-pq2 platform 
that you want to use.  Just make zImage and boot the cuImage.pq2 file.

-Scott
