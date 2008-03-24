Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4B69ADDFCB
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Mar 2008 08:17:17 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m2OLHEqs018077
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Mar 2008 17:17:14 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m2OLHDKJ157744
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Mar 2008 15:17:13 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m2OLHDVR013499
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Mar 2008 15:17:13 -0600
Date: Mon, 24 Mar 2008 16:15:03 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Re: [PATCH 1/2 v2] [POWERPC] Add PPC4xx L2-cache support (440GX)
Message-ID: <20080324161503.4b8ecb28@zod.rchland.ibm.com>
In-Reply-To: <1206392355.7197.38.camel@pasglop>
References: <1206181736-21796-1-git-send-email-sr@denx.de>
	<20080324083957.2945077c@zod.rchland.ibm.com>
	<1206392355.7197.38.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 25 Mar 2008 07:59:15 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> On Mon, 2008-03-24 at 08:39 -0500, Josh Boyer wrote:
> > > +
> > > +     local_irq_save(flags);
> > > +     asm volatile ("sync" ::: "memory");
> > 
> > Perhaps just call iosync() for these instead of the open coded asm
> > volatile stuff?
> 
> Not sure about that. iosync() will do a sync but it's not meant at being
> used for things unrelated to IOs (and who knows... we might make it do
> something else one day ?).
> 
> In low level arch code like that, an open coded sync might be proper
> especially if it matches some documented sequence.

Either way, it doesn't matter to me.

josh
