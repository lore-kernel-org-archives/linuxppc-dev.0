Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 7D3202C007C
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Jun 2013 14:27:13 +1000 (EST)
Message-ID: <1371356818.21896.114.camel@pasglop>
Subject: Re: [PATCH 2/4] powerpc: Prepare to support kernel handling of
 IOMMU map/unmap
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Sun, 16 Jun 2013 14:26:58 +1000
In-Reply-To: <1370412673-1345-3-git-send-email-aik@ozlabs.ru>
References: <1370412673-1345-1-git-send-email-aik@ozlabs.ru>
 <1370412673-1345-3-git-send-email-aik@ozlabs.ru>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Alexander Graf <agraf@suse.de>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> +#if defined(CONFIG_SPARSEMEM_VMEMMAP) || defined(CONFIG_FLATMEM)
> +int realmode_get_page(struct page *page)
> +{
> +	if (PageCompound(page))
> +		return -EAGAIN;
> +
> +	get_page(page);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(realmode_get_page);
> +
> +int realmode_put_page(struct page *page)
> +{
> +	if (PageCompound(page))
> +		return -EAGAIN;
> +
> +	if (!atomic_add_unless(&page->_count, -1, 1))
> +		return -EAGAIN;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(realmode_put_page);
> +#endif

Several worries here, mostly that if the generic code ever changes
(something gets added to get_page() that makes it no-longer safe for use
in real mode for example, or some other condition gets added to
put_page()), we go out of sync and potentially end up with very hard and
very subtle bugs.

It might be worth making sure that:

 - This is reviewed by some generic VM people (and make sure they
understand why we need to do that)

 - A comment is added to get_page() and put_page() to make sure that if
they are changed in any way, dbl check the impact on our
realmode_get_page() (or "ping" us to make sure things are still ok).

Cheers,
Ben.
