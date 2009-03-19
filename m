Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B06B5DDD1B
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Mar 2009 03:16:36 +1100 (EST)
Message-Id: <B4A09128-F47D-4BE1-98BC-6AF1A3220979@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20090311035336.4F609DE163@ozlabs.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH 5/9] powerpc/mm: Merge various PTE bits and accessors
	definitions (v2)
Date: Thu, 19 Mar 2009 11:16:30 -0500
References: <20090311035336.4F609DE163@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 10, 2009, at 10:53 PM, Benjamin Herrenschmidt wrote:

> +
> +/* Conversion functions: convert a page and protection to a page  
> entry,
> + * and a page entry and page directory to the page they refer to.
> + *
> + * Even if PTEs can be unsigned long long, a PFN is always an  
> unsigned
> + * long for now.
> + */
> +static inline pte_t pfn_pte(unsigned long pfn, pgprot_t pgprot) {
> +	return __pte((pfn << PTE_RPN_SHIFT) | pgprot_val(pgprot)); }

This needs to be:

	return __pte(((pte_basic_t)(pfn) << PTE_RPN_SHIFT) |  
pgprot_val(pgprot)); }

Otherwise on ppc32 w/36-bit physical we lose the upper bits of the pfn.

- k
