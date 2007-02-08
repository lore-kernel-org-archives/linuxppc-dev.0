Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AAE9EDDEDF
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Feb 2007 09:30:39 +1100 (EST)
Subject: Re: [PATCH] Celleb: improve htab lock
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20070208202802.GA2579@lst.de>
References: <200702080618.l186InGM014774@toshiba.co.jp>
	<200702080751.45278.arnd@arndb.de>  <20070208202802.GA2579@lst.de>
Content-Type: text/plain
Date: Fri, 09 Feb 2007 09:30:08 +1100
Message-Id: <1170973808.2620.379.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> But I think the issue here is that we don't want to disable irqs because
> we want to protect against IRQ context, but rather because the
> hypervisor expects it.

No not really. The problem here is that we get a spinlock re-entrancy if
we don't disable IRQs so it's a typical textbook usage of
spin_lock_irqsave.

The problem is that if you don't disable IRQs, you can take an irq or a
decrementer exception causing some code to hit vmalloc or ioremap space
which might cause a hash fault, thus you may deadlock on the spinlock
via htab_insert.

Ben.
