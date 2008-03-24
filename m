Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 99379DDF79
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Mar 2008 08:11:41 +1100 (EST)
Subject: Re: [PATCH 1/2 v2] [POWERPC] Add PPC4xx L2-cache support (440GX)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20080324083957.2945077c@zod.rchland.ibm.com>
References: <1206181736-21796-1-git-send-email-sr@denx.de>
	<20080324083957.2945077c@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Tue, 25 Mar 2008 07:59:15 +1100
Message-Id: <1206392355.7197.38.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2008-03-24 at 08:39 -0500, Josh Boyer wrote:
> > +
> > +     local_irq_save(flags);
> > +     asm volatile ("sync" ::: "memory");
> 
> Perhaps just call iosync() for these instead of the open coded asm
> volatile stuff?

Not sure about that. iosync() will do a sync but it's not meant at being
used for things unrelated to IOs (and who knows... we might make it do
something else one day ?).

In low level arch code like that, an open coded sync might be proper
especially if it matches some documented sequence.

Cheers,
Ben.
