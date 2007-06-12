Return-Path: <rzhan@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id BB0AADDEE1
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jun 2007 16:04:22 +1000 (EST)
Subject: RE: [PATCH 5/6]: 82xx: Add the support of Wind River SBC
	PowerQUICCII 82xx
From: Mark Zhan <rongkai.zhan@windriver.com>
To: Li Yang-r58472 <LeoLi@freescale.com>
In-Reply-To: <989B956029373F45A0B8AF0297081890D2AA5B@zch01exm26.fsl.freescale.net>
References: <989B956029373F45A0B8AF0297081890D2AA5B@zch01exm26.fsl.freescale.net>
Content-Type: text/plain
Date: Tue, 12 Jun 2007 14:03:59 +0800
Message-Id: <1181628239.25503.15.camel@mark>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Li Yang,

On Mon, 2007-06-11 at 21:51 +0800, Li Yang-r58472 wrote:

> Shouldn't these come from device tree too?
> 
> Moreover, you can no longer use the hard coded IRQ numbers.  They need
> to be mapped to virtual irq, and the driver needs to use the virtual irq
> number.
> 

Actually this is a fake interrupt. Please see my code comment:

/*
 * For SBCPQ2 board, the interrupt of M48T59 RTC chip
 * will generate a machine check exception. We use a
 * fake irq to give the platform machine_check_exception() hook
 * a chance to call the driver ISR. If IRQ_HANDLED is returned,
 * then we will survive from the machine check exception.
 */


> I don't believe the following are necessary.  New MTD mapping should be
> defined in device tree.
> 

Oh, here I just want to document the memory mapping for this board. I
think, even we already have devtree, it is a good idea that we always
document the H/W setting in platform header file, which will definitely
make life easier.


> > +/*
> > + * Wind River SBC PowerQUICCII 82xx Physical Memory Map (CS0 for
> > OnBoard Flash)
> > + *
......
> 
> Use < &interrupt-controller > as interrupt-parent instead.
> 

Got it. 

> - Leo

Thanks
Mark Zhan
