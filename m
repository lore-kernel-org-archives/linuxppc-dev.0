Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C2E47DDDFD
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2007 22:37:16 +1000 (EST)
Subject: Re: [PATCH 1/2] Enable SPU switch notification to detect currently
	active SPU tasks.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20070713101233.GA12426@lst.de>
References: <1184283940.16584.5.camel@bnelson60.rchland.ibm.com>
	<20070713101233.GA12426@lst.de>
Content-Type: text/plain
Date: Fri, 13 Jul 2007 22:34:50 +1000
Message-Id: <1184330090.6059.219.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc <linuxppc-dev@ozlabs.org>,
	Andrew Morton <akpm@linuxfoundation.org>,
	Bob Nelson <rrnelson@linux.vnet.ibm.com>,
	oprofile <oprofile-list@lists.sourceforge.net>,
	Philippe Elie <phil.el@wanadoo.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > +		if (unlikely(test_bit(SPU_SCHED_NOTIFY_ACTIVE,
> > +				      &ctx->sched_flags))) {
> > +			clear_bit(SPU_SCHED_NOTIFY_ACTIVE, &ctx->sched_flags);
> 
> this should use test_and_clear_bit

This also looks like an abuse of atomics to effectively implement a lock
or did I miss something ?

Ben.
