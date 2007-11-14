Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp02.au.ibm.com (E23SMTP02.au.ibm.com [202.81.18.163])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp02.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 48FD7DDDDB
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2007 13:19:04 +1100 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp02.au.ibm.com (8.13.1/8.13.1) with ESMTP id lAE2J0vu018680
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2007 13:19:00 +1100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.6) with ESMTP id
	lAE2MbTG249122
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2007 13:22:37 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lAE2IiO2028604
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2007 13:18:45 +1100
Date: Wed, 14 Nov 2007 13:14:28 +1100
From: David Gibson <dwg@au1.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/2] PowerPC: 4xx uic updates
Message-ID: <20071114021428.GC19378@localhost.localdomain>
References: <20071113201559.GA26172@ru.mvista.com>
	<20071113200514.72d03792@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071113200514.72d03792@zod.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Nov 13, 2007 at 08:05:14PM -0600, Josh Boyer wrote:
> On Tue, 13 Nov 2007 23:15:59 +0300
> Valentine Barshak <vbarshak@ru.mvista.com> wrote:
> 
> > These patches update 4xx uic code. The first one
> > fixes a minor issue with edge-triggered interrupts,
> > while the second one makes it use generic level and edge irq
> > handlers. I've added irq ack'ing to the unmask callback for
> > level-triggered interrupts, because to de-assert them we have
> > to do 2 things is the exact order as below:
> > 1. de-assert the external source in the ISR.
> > 2. ack the IRQ on the UIC.
> > So, ack'ing level interrupts before unmasking them makes possible
> > to use generic level irq handler and it doesn't hurt, cause
> > we can never miss a level-triggered interrupt. It always stays
> > asserted untill the external source is removed and ack'ed on UIC.
> > 
> > These have been tested on Sequoia PowerPC 440EPx board.
> 
> Is my mail server slow, or did patch 2 of 2 never make it out?

It reached me eventually, but only to my ibm address, not via the
list (whereas I got both copies of 0 and 1).

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
