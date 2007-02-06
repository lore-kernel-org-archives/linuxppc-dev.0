Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D1BE9DDEE2
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  7 Feb 2007 03:37:20 +1100 (EST)
In-Reply-To: <003b01c749cb$03998550$1601a8c0@wata>
References: <003b01c749cb$03998550$1601a8c0@wata>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <1C8918CC-4D53-4939-9694-DA299753AE39@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: How to access MPC8555 DMA register ?
Date: Tue, 6 Feb 2007 10:36:23 -0600
To: Shinji Watanabe <watashin@mvision.co.jp>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Feb 6, 2007, at 2:44 AM, Shinji Watanabe wrote:

> Hi, all.
>
> I used MPC8555CDS.
>
> How to access DMA registers of MPC8555 ?
>
> I can't read/write these registers on LINUX.
>
> I called request_mem_region( 0xE0000000, LENGTH, ... ) in my device  
> driver.
>
> When I set LENGTH 0x21100, this function call succeded.
>
> But When I set LENGTH 0x21200, this function call failed.
>
> "e0021100-e002117f : fsl-dma0" is part of /proc/iomem log.
>
> I guess my driver can't access fsl-dma0 area.
>
> But fsl-dma0 area encompassed DMA registers I want to access.
>
> I must find remove simbols like fsl-dma0.
> Or I must find how to use modules encompass fsl-dma0.
>
> Counld you give me some help/hint/tips ?

You need to have your driver bind to the fsl-dma0 device.  The  
platform code is setting up a device for each dma channel (fsl-dma0,  
fsl-dma1, ..) and you need to have your driver be setup to bind to  
that device.

Take a look at drivers/i2c/busses/i2c-mpc.c, drivers/net/gianfar.c  
for an examples of how drivers are setup to do the binding.

- k
