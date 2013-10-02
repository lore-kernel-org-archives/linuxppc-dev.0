Return-Path: <cascardo@linux.vnet.ibm.com>
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e24smtp02.br.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BF9A42C00BB
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Oct 2013 22:32:49 +1000 (EST)
Received: from /spool/local
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cascardo@linux.vnet.ibm.com>;
 Wed, 2 Oct 2013 09:32:43 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 92AE13520065
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Oct 2013 08:32:40 -0400 (EDT)
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
 by d24relay02.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r92CUmUS43188288
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Oct 2013 09:30:48 -0300
Received: from d24av04.br.ibm.com (localhost [127.0.0.1])
 by d24av04.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r92CWdd4002669
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Oct 2013 09:32:39 -0300
Date: Wed, 2 Oct 2013 09:32:37 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/iommu: use GFP_KERNEL instead of GFP_ATOMIC in
 iommu_init_table()
Message-ID: <20131002123237.GD24092@oc0268524204.ibm.com>
References: <20131001210453.GB4065@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131001210453.GB4065@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 01, 2013 at 02:04:53PM -0700, Nishanth Aravamudan wrote:
> Under heavy (DLPAR?) stress, we tripped this panic() in
> arch/powerpc/kernel/iommu.c::iommu_init_table():
>     
> 	page = alloc_pages_node(nid, GFP_ATOMIC, get_order(sz));
> 	if (!page)
> 		panic("iommu_init_table: Can't allocate %ld bytes\n",
>     sz);
>     
> Before the panic() we got a page allocation failure for an order-2
> allocation. There appears to be memory free, but perhaps not in the
> ATOMIC context. I looked through all the call-sites of
> iommu_init_table() and didn't see any obvious reason to need an ATOMIC
> allocation. Most call-sites in fact have an explicit GFP_KERNEL
> allocation shortly before the call to iommu_init_table(), indicating we
> are not in an atomic context. There is some indirection for some paths,
> but I didn't see any locks indicating that GFP_KERNEL is inappropriate.
> 
> With this change under the same conditions, we have not been able to
> reproduce the panic.
>     
> Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
> 
> diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
> index 0adab06..572bb5b 100644
> --- a/arch/powerpc/kernel/iommu.c
> +++ b/arch/powerpc/kernel/iommu.c
> @@ -661,7 +661,7 @@ struct iommu_table *iommu_init_table(struct iommu_table *tbl, int nid)
>  	/* number of bytes needed for the bitmap */
>  	sz = BITS_TO_LONGS(tbl->it_size) * sizeof(unsigned long);
> 
> -	page = alloc_pages_node(nid, GFP_ATOMIC, get_order(sz));
> +	page = alloc_pages_node(nid, GFP_KERNEL, get_order(sz));
>  	if (!page)
>  		panic("iommu_init_table: Can't allocate %ld bytes\n", sz);
>  	tbl->it_map = page_address(page);

I didn't respond to the previous message, but also checked if there were
any history on the logs, and found this was as it is from the start. I
also found no other reasons why it needs to be atomic. Therefore,

Acked-by: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
