Return-Path: <akira2.iguchi@toshiba.co.jp>
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 75064DDE48
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Feb 2007 17:43:22 +1100 (EST)
Received: from tsb-wall.toshiba.co.jp ([133.199.160.134])
	by inet-tsb5.toshiba.co.jp  with ESMTP id l196hI8N014428
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Feb 2007 15:43:18 +0900 (JST)
Received: (from root@localhost) by tsb-wall.toshiba.co.jp  id l196hIhr016635
	for linuxppc-dev@ozlabs.org; Fri, 9 Feb 2007 15:43:18 +0900 (JST)
Received: from mx12.toshiba.co.jp (localhost [127.0.0.1])
	by ovp1.toshiba.co.jp  with ESMTP id l196hHMl021469
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Feb 2007 15:43:18 +0900 (JST)
Message-Id: <200702090643.l196hHks016742@toshiba.co.jp>
MIME-Version: 1.0
Date: Fri, 09 Feb 2007 15:44:12 +0900
From: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
To: benh@kernel.crashing.org
In-Reply-To: <1170973927.2620.382.camel@localhost.localdomain>
Subject: Re: [PATCH] Celleb: improve htab lock
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ben-san,

> On Thu, 2007-02-08 at 21:43 +0100, Arnd Bergmann wrote:
> > On Thursday 08 February 2007 21:28, Christoph Hellwig wrote:
> > >  Also if we're sure that this is
> > > always called from process context and with irqs enabled we should
> > > be using local_irq_disable/local_irq_enable and avoid saving the
> > > flags word.
> > 
> > Right, that's what I meant, I was a little confused here.

> I prefer saving for now. We can be called whenever there is a
> flush_tlb_pending() called for flushing a pending batch and that is in
> quite a few places including deep in the context switching code, I
> wouldn't make assumption on the irq state on entry.

We prefer saving flags, too.

> I do intend at one point to move the local_irq_save/restore up a level
> though, so that all the htab functions have the same semantic of being
> called with IRQs off. Right now, the invalidate ones are sort-of an
> exception.

We need to turn IRQs off when calling htab functions if and only
if it is non-atomic, so the "pSeries with LPAR" htab function have
no spin_lock or local_irq_save/restore. We think tweaking EE bit
locally gives a way to decrease times to be IRQs off and on again
(yes, it's smallthing to compare with calling HV),
so we prefer current implementation.

We have a small patch to replace "local_irq_save" and "spin_lock"
pair to "spin_lock_irqsave". It is not necessary to apply, but if
it's possible, please apply.

Cheers,
Akira Iguchi
