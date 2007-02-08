Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 11F4ADDED5
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Feb 2007 09:32:14 +1100 (EST)
Subject: Re: [PATCH] Celleb: improve htab lock
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200702082143.10213.arnd@arndb.de>
References: <200702080618.l186InGM014774@toshiba.co.jp>
	<200702080751.45278.arnd@arndb.de> <20070208202802.GA2579@lst.de>
	<200702082143.10213.arnd@arndb.de>
Content-Type: text/plain
Date: Fri, 09 Feb 2007 09:32:07 +1100
Message-Id: <1170973927.2620.382.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-02-08 at 21:43 +0100, Arnd Bergmann wrote:
> On Thursday 08 February 2007 21:28, Christoph Hellwig wrote:
> >  Also if we're sure that this is
> > always called from process context and with irqs enabled we should
> > be using local_irq_disable/local_irq_enable and avoid saving the
> > flags word.
> 
> Right, that's what I meant, I was a little confused here.

I prefer saving for now. We can be called whenever there is a
flush_tlb_pending() called for flushing a pending batch and that is in
quite a few places including deep in the context switching code, I
wouldn't make assumption on the irq state on entry.

I do intend at one point to move the local_irq_save/restore up a level
though, so that all the htab functions have the same semantic of being
called with IRQs off. Right now, the invalidate ones are sort-of an
exception.

Ben.
