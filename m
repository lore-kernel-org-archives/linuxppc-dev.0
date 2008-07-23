Return-Path: <luisgpm@linux.vnet.ibm.com>
Received: from igw3.br.ibm.com (igw3.br.ibm.com [32.104.18.26])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "igw3.br.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8CF95DE1E4
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jul 2008 01:48:17 +1000 (EST)
Received: from mailhub3.br.ibm.com (unknown [9.18.232.110])
	by igw3.br.ibm.com (Postfix) with ESMTP id 196A1390437
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 12:29:42 -0300 (BRST)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.18.232.46])
	by mailhub3.br.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m6NFeTrc2924574
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 12:48:14 -0300
Received: from d24av01.br.ibm.com (loopback [127.0.0.1])
	by d24av01.br.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m6NEfvkq006664
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 11:41:57 -0300
Subject: Re: [RFC] 4xx hardware watchpoint support
From: Luis Machado <luisgpm@linux.vnet.ibm.com>
To: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20080723142335.GA22767@lst.de>
References: <1211391577.6232.15.camel@gargoyle>
	<18484.60888.981390.893747@cargo.ozlabs.ibm.com>
	<1213992894.6635.41.camel@gargoyle>
	<20080719093752.5aada45c@zod.rchland.ibm.com>
	<1216658194.5727.36.camel@gargoyle>
	<20080721130551.23a06006@zod.rchland.ibm.com>
	<1216777678.5727.82.camel@gargoyle>  <20080723142335.GA22767@lst.de>
Content-Type: text/plain
Date: Wed, 23 Jul 2008 11:42:02 -0300
Message-Id: <1216824122.5727.91.camel@gargoyle>
Mime-Version: 1.0
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
Reply-To: luisgpm@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Some comment, first the above negate conditional
> looks rather ugly, I'd rather do a
> 
> #if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
> 	dbcr0 case
> #else
> 	dabr case
> #endif

Yes, it makes sense. I'll switch it around.

> second I wonder why we have the notify_die only for one case, that seems
> rather odd.  Looking further the notify_die is even more odd because
> DIE_DABR_MATCH doesn't actually appear anywhere else in the kernel.
> I'd suggest simply removing it.

DIE_DABR_MATCH doesn't appear anywhere else because there is only a
single function responsible for handling the DABR/DAC events on powerPC
with this modification. It would make sense to call this to both the
DAC/DABR cases though (i.e. taking it out of the #ifdef), what do you
think?

> Can you redo this in the normal Linux comment style, ala:
> 
> 	/*
> 	 * For processors using DABR (i.e. 970), the bottom 3 bits are flags.
> 	 *  It was assumed, on previous implementations, that 3 bits were
> 	 *  passed together with the data address, fitting the design of the
> 	 *  DABR register, as follows:
> 	 *
> 	 *  bit 0: Read flag
> 	 *  bit 1: Write flag
> 	 *  bit 2: Breakpoint translation
> 	 *
> 	 *  Thus, we use them here as so.
> 	 */
> 
> and similar in few other places.

Will do, thanks for reviewing this one.

Regards,
Luis
