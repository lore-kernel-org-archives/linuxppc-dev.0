Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AF837DDE44
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Oct 2007 14:06:11 +1000 (EST)
Subject: Re: [PATCH] synchronize_irq needs a barrier
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Maxim Levitsky <maximlevitsky@gmail.com>
In-Reply-To: <200710200510.01409.maximlevitsky@gmail.com>
References: <1192670742.12879.5.camel@pasglop>
	<200710200402.43106.maximlevitsky@gmail.com>
	<alpine.LFD.0.999.0710191924520.3794@woody.linux-foundation.org>
	<200710200510.01409.maximlevitsky@gmail.com>
Content-Type: text/plain
Date: Sat, 20 Oct 2007 14:06:01 +1000
Message-Id: <1192853161.17235.34.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	akpm <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> >  - even when you ignore the interrupt (because the driver doesn't care, 
> >    it's suspending), you need to make sure the hardware gets shut up by 
> >    reading (or writing) the proper interrupt status register.
> I agree, but while device is powered off, its registers can't be accessed
> Thus, if I ack the IRQ every time the handler is called, I will access the 
> powered off device (this is probably won't hurt a lot, but a bit incorrectly)

It will actually crash your machine on some platforms. So no, best is to
-not- ack. The masking is enough, the IRQ will go down eventually.

Ben.
