Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 593162BF12
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Jan 2005 20:36:20 +1100 (EST)
Date: Wed, 5 Jan 2005 10:26:59 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jim Nelson <james4765@cwazy.co.uk>
Message-ID: <20050105092659.GA27103@lst.de>
References: <20050104214048.21749.85722.89116@localhost.localdomain>
	<41DB4E99.3060200@didntduck.org> <41DB5476.9040103@cwazy.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <41DB5476.9040103@cwazy.co.uk>
Cc: linuxppc-dev@ozlabs.org, Brian Gerst <bgerst@didntduck.org>,
	paulus@samba.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] ppc: remove cli()/sti() from arch/ppc/*
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jan 04, 2005 at 09:44:06PM -0500, Jim Nelson wrote:
> Brian Gerst wrote:
> 
> >James Nelson wrote:
> >
> >>This series of patches is to remove the last cli()/sti() function 
> >>calls in arch/ppc.
> >>
> >>These are the only instances in active code that grep could find.
> >
> >
> >Are you sure none of these need real spinlocks instead of just 
> >disabling interrupts?
> >
> >-- 
> >                Brian Gerst
> >
> These are for single-processor systems, mostly evaluation boards and 
> embedded processors.  I coudn't find any reference to multiprocessor 
> setups for the processors in question after a peruse of the code or a 
> quick google on the boards in question.

think CONFIG_PREEMPT.  In either case a spinlock becomes
lock_irq_disable in the !SMP, !PREEMPT case but it documents the
intention a whole lot better.

Also you're locking only in a single plpace which is a ***BIG*** warning
sign.  At least look at the other users of the data structure, it's
extremly likely they'll need locking aswell.
