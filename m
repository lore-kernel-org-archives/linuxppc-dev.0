Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3446BDDE09
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2007 14:46:54 +1100 (EST)
Subject: Re: [PATCH 0/2] PowerPC: 4xx uic updates
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20071113200514.72d03792@zod.rchland.ibm.com>
References: <20071113201559.GA26172@ru.mvista.com>
	<20071113200514.72d03792@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Wed, 14 Nov 2007 14:40:53 +1100
Message-Id: <1195011653.28865.25.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, dwg@au1.ibm.com
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 2007-11-13 at 20:05 -0600, Josh Boyer wrote:
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

It never reached me neither.

Ben
