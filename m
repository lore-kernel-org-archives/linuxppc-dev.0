Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F1376DE447
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Apr 2009 00:41:11 +1000 (EST)
Message-ID: <49F1CF7B.2080703@freescale.com>
Date: Fri, 24 Apr 2009 09:40:59 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: lhthanh <lhthanh@kobekara.com>
Subject: Re: MPC8349E's DMA controller like ISA controller but with more
	feature?
References: <49EC6CB5.2020300@kobekara.com>
	<20090420155511.GA25470@ld0162-tx32.am.freescale.net>
	<49EFEA26.2010602@kobekara.com>
	<20090423154311.GA19717@ld0162-tx32.am.freescale.net>
	<49F08FBC.9010903@freescale.com> <49F15831.9080507@kobekara.com>
In-Reply-To: <49F15831.9080507@kobekara.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

lhthanh wrote:

> Thanks for your explaination! So if I want to transfer a buffer of data 
> from a single I/O port,  will not DMA framework
> also be able ?

No.

> Have I to write aother driver?

Yes.

> Actually, I don't want write all because there are  serveral DMA code at 
> hand. I only want to use a framework instead of re-writing.

There is no framework for what you want to do.  There is only one other
driver that does what you want (sound/soc/fsl/fsl_dma.c), and that is a
complicated driver that does many things besides transferring data to an
I/O port.

> And I afraid that I can not write code which assure sharing DMA channels.

Look at arch/powerpc/boot/dts/mpc8610_hpcd.dts.  The DMA channels that
are needed by the 8610 audio driver have a different 'compatible'
property.  This is how you prevent the generic DMA driver from using a
channel that you want.

I'm afraid that you're going to have to study the DMA programming model,
and my device driver, and write a brand new driver from scratch.

-- 
Timur Tabi
Linux kernel developer at Freescale
