Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 826CADDF83
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Dec 2008 08:19:03 +1100 (EST)
Subject: Re: [PATCH 11/16] powerpc/mm: Add SMP support to no-hash TLB
	handling v3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <B5573CC7-9ED1-48CE-9BE9-51A0BF5CB247@kernel.crashing.org>
References: <20081215054554.E883EDDF9D@ozlabs.org>
	<B3FDD472-0720-4454-9329-5A1C8A9BF84A@freescale.com>
	<1229373978.26324.120.camel@pasglop>
	<C0519630-66EF-4860-A27E-15CC749D98DC@freescale.com>
	<1229374984.26324.125.camel@pasglop>
	<B5573CC7-9ED1-48CE-9BE9-51A0BF5CB247@kernel.crashing.org>
Content-Type: text/plain
Date: Tue, 16 Dec 2008 08:18:57 +1100
Message-Id: <1229375937.26324.128.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-12-15 at 15:10 -0600, Kumar Gala wrote:

> Hmm.. are you mixing the two different locking needs together?  The is  
> locking of ivax vs tlbwe and there is locking around multiple "msgs"  
> on the bus.  I know for us we can have any # of ivax's on the bus, but  
> only one tlbsync.

I'm purely talking about the later. Right now I only issue one ivax +
one tlbsycn anyway but I was thinking about having _tlbivax_bcast take a
count for small ranges, but I would still lock the whole thing because
some impl I know of don't like multiple ivax coliding form different
sources neither.

Cheers,
Ben.
