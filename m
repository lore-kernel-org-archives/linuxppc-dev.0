Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BBA09DDE07
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2007 13:05:39 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id lAE25apb011355
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Nov 2007 21:05:36 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.6) with ESMTP id
	lAE25aQl113566
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Nov 2007 21:05:36 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lAE25apx027254
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Nov 2007 21:05:36 -0500
Date: Tue, 13 Nov 2007 20:05:14 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: [PATCH 0/2] PowerPC: 4xx uic updates
Message-ID: <20071113200514.72d03792@zod.rchland.ibm.com>
In-Reply-To: <20071113201559.GA26172@ru.mvista.com>
References: <20071113201559.GA26172@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, dwg@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 13 Nov 2007 23:15:59 +0300
Valentine Barshak <vbarshak@ru.mvista.com> wrote:

> These patches update 4xx uic code. The first one
> fixes a minor issue with edge-triggered interrupts,
> while the second one makes it use generic level and edge irq
> handlers. I've added irq ack'ing to the unmask callback for
> level-triggered interrupts, because to de-assert them we have
> to do 2 things is the exact order as below:
> 1. de-assert the external source in the ISR.
> 2. ack the IRQ on the UIC.
> So, ack'ing level interrupts before unmasking them makes possible
> to use generic level irq handler and it doesn't hurt, cause
> we can never miss a level-triggered interrupt. It always stays
> asserted untill the external source is removed and ack'ed on UIC.
> 
> These have been tested on Sequoia PowerPC 440EPx board.

Is my mail server slow, or did patch 2 of 2 never make it out?

josh
