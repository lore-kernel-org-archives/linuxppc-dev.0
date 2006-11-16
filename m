Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B882B67B8F
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 09:48:53 +1100 (EST)
Subject: Re: [PATCH 2/5] [POWERPC] 8xx: generic 8xx code arch/powerpc port
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20061115182316.GA20719@lst.de>
References: <20061114012504.17455.13833.stgit@localhost.localdomain>
	<20061114012816.17455.12059.stgit@localhost.localdomain>
	<20061115182316.GA20719@lst.de>
Content-Type: text/plain
Date: Fri, 17 Nov 2006 09:48:43 +1100
Message-Id: <1163717323.5940.407.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> But wha do you need this for anyway?  It's not used anywhere currently,
> and it's not 8xx-specific at all?
> 
> > +unsigned long va_to_phys(unsigned long address)
> > +{
> > +	pte_t *pte;
> > +
> > +	pte = va_to_pte(address);
> > +	if (pte)
> > +		return(((unsigned long)(pte_val(*pte)) & PAGE_MASK) | (address & ~(PAGE_MASK)));
> > +	return (0);
> > +}
> 
> Shouldn't you use virt_to_phys instead?
> 
> Also for the last two I'd prefer if you'd find a way to avoid adding
> them.

I think those 2 are used for cases where they either have a non-linear
mapping a-la Amiga/APUS or in cases where they try to get addresses of
things in the vmalloc area no ?.

Ben.
