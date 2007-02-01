Return-Path: <sb@thebackend.de>
Received: from mail.thebackend.de (www.thebackend.de [217.20.114.244])
	by ozlabs.org (Postfix) with ESMTP id BA5F5DDDE9
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Feb 2007 02:31:00 +1100 (EST)
In-Reply-To: <20070201121352.28102.qmail@farnsworth.org>
References: <20070201121352.28102.qmail@farnsworth.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E3523AA0-A707-438A-8212-9891360D5F61@thebackend.de>
From: =?ISO-8859-1?Q?Sebastian_Br=FCckner?= <sb@thebackend.de>
Subject: Re: MV64360 ethernet controller
Date: Thu, 1 Feb 2007 16:29:20 +0100
To: Dale Farnsworth <dale@farnsworth.org>
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

Hi Dale,

with these files it just works. Thank you very much! :-)
It seems I messed up the interrupt setup. At least I learned a few  
things about the kernel and PCI as well...

But now that the CPU module does as its told I got the next problem:  
Lack of documentation for the Prodrive MCCB-3 carrier board. Always  
the same...

Sebastian

Am 01.02.2007 um 13:13 schrieb Dale Farnsworth:

> Hi Sebastian,
>
> Yes, the driver needs receive and transmit interrupts.  However, the
> same irq number is used for PHY status change as well as for packet
> receive and transmit.  I don't see how you could see PHY status change
> interrupts and not rx/tx interrupts.  mv643xx_eth_int_handler() should
> be called for all ethernet-related interrupts*.  Are you certain that
> you're not seeing rx and tx interrupts?
>
> * You may not see an interrupt on every packet because of the
> transmit irq coalescing mechanism and the use of NAPI on receive.
>
> Mark Greer and I are starting on arch/powerpc support for the mv64x60
> and ppmc280.  We will submit it as when we have something useful.
> In the meantime, the arch/ppc code below may serve as a hint.
> (Just to be clear, I didn't write this code and don't mean to take
> credit for it.)
>
> -Dale
