Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 644C167B93
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 19:01:04 +1100 (EST)
Date: Fri, 17 Nov 2006 09:00:52 +0100
From: Christoph Hellwig <hch@lst.de>
To: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: Re: [PATCH 2/5] [POWERPC] 8xx: generic 8xx code arch/powerpc port
Message-ID: <20061117080052.GA16985@lst.de>
References: <20061114012504.17455.13833.stgit@localhost.localdomain>
	<20061114012816.17455.12059.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061114012816.17455.12059.stgit@localhost.localdomain>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I've done some grepping, so here are some more useful comments on
the fault.c additions:

> +#ifdef CONFIG_8xx
> +
> +/* The pgtable.h claims some functions generically exist, but I
> + * can't find them......
> + */

This comment is copied from arch/ppc/ but utterly wrong - no one
but 8xx implements any of these functions.  I'd say just kill it.

> +pte_t *va_to_pte(unsigned long address)

this is used by arch/ppc/fec.c to set mapping uncachable, which
seems rather odd to me.  For now we'll have to keep it I think, but
it might make sense to move the implementation to fec.c.

> +unsigned long va_to_phys(unsigned long address)

this is completely unused. You should probably remove it from arch/ppc
aswell.

> +void
> +print_8xx_pte(struct mm_struct *mm, unsigned long addr)

> +int
> +get_8xx_pte(struct mm_struct *mm, unsigned long addr)

These two are only used by arch/ppc/kernel/softemu8xx.c and should
bew move to that file.
