Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 2DF0BDE073
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 03:52:10 +1100 (EST)
Date: Wed, 12 Dec 2007 19:55:14 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH RFC 0/7] "NAND on UPM" and related patches
Message-ID: <20071212165513.GA30981@localhost.localdomain>
References: <20071210204705.GA31263@localhost.localdomain>
	<20071212164035.GB4329@loki.buserror.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20071212164035.GB4329@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Dec 12, 2007 at 10:40:35AM -0600, Scott Wood wrote:
> On Mon, Dec 10, 2007 at 11:47:05PM +0300, Anton Vorontsov wrote:
> > 5 - FSL UPM infrastructure:
> > ---------------------------
> > UPM address register is shared among UPMs, so we have to do
> > proper locking. On the other hand, if we know that specific
> > board using only one UPM we could bypass locking, and gain some
> > performance win.
> 
> Not enough to be worth the complexity compared to the overhead of NAND
> access -- especially in the likely case of a non-SMP build.

I'm allowing UPM access from the IRQ handlers (because nothing prevents
this, so why deny?). Thus locks are needed even on non-SMP build, on
UP they aren't thrown away. Lockless variant occupy less than 30 lines of
code, so I'd rather keep it.

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
