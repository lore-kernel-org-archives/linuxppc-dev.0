Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 88631DDE9E
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Dec 2008 09:19:53 +1100 (EST)
Message-Id: <01FA1F1A-0A98-4553-B27D-CBC627E3EC02@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1229375937.26324.128.camel@pasglop>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH 11/16] powerpc/mm: Add SMP support to no-hash TLB handling
	v3
Date: Mon, 15 Dec 2008 16:19:47 -0600
References: <20081215054554.E883EDDF9D@ozlabs.org>
	<B3FDD472-0720-4454-9329-5A1C8A9BF84A@freescale.com>
	<1229373978.26324.120.camel@pasglop>
	<C0519630-66EF-4860-A27E-15CC749D98DC@freescale.com>
	<1229374984.26324.125.camel@pasglop>
	<B5573CC7-9ED1-48CE-9BE9-51A0BF5CB247@kernel.crashing.org>
	<1229375937.26324.128.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 15, 2008, at 3:18 PM, Benjamin Herrenschmidt wrote:

> On Mon, 2008-12-15 at 15:10 -0600, Kumar Gala wrote:
>
>> Hmm.. are you mixing the two different locking needs together?  The  
>> is
>> locking of ivax vs tlbwe and there is locking around multiple "msgs"
>> on the bus.  I know for us we can have any # of ivax's on the bus,  
>> but
>> only one tlbsync.
>
> I'm purely talking about the later. Right now I only issue one ivax +
> one tlbsycn anyway but I was thinking about having _tlbivax_bcast  
> take a
> count for small ranges, but I would still lock the whole thing because
> some impl I know of don't like multiple ivax coliding form different
> sources neither.

Ok.  Lets use MMU_FTR_LOCK_BCAST_TLB_OPS and have a comment about  
locking because bus implementations cant handle multiple ivax and/or  
multiple syncs.

- k
