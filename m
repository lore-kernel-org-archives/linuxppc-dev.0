Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0A80EDDE9E
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Oct 2007 15:46:34 +1000 (EST)
Subject: Re: [PATCH] synchronize_irq needs a barrier
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Maxim Levitsky <maximlevitsky@gmail.com>
In-Reply-To: <200710200736.22129.maximlevitsky@gmail.com>
References: <1192670742.12879.5.camel@pasglop>
	<200710200624.58261.maximlevitsky@gmail.com>
	<1192856675.6745.5.camel@pasglop>
	<200710200736.22129.maximlevitsky@gmail.com>
Content-Type: text/plain
Date: Sat, 20 Oct 2007 15:46:24 +1000
Message-Id: <1192859184.6745.8.camel@pasglop>
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



> I probably need to add this synchronize_irq() logic in dmfe.c too, but I probably do it later,
> I think I am overestimating this race, since most drivers don't do dev->insuspend checks in IRQ handler.
> Maybe even just use free_irq() after all....

Most drivers are probably underestimating the race :-)

free_irq() would work provided that you did the masking on chip before
(and unmask only after request_irq on the way back in). But it's a bit
like using a 10 tons truck to crush an ant... 

Ben.
