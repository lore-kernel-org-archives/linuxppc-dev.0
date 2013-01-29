Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 000282C0098
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jan 2013 11:36:38 +1100 (EST)
Message-ID: <1359419756.18955.16.camel@pasglop>
Subject: Re: [PATCH v2] ppc/iommu: use find_first_bit to look up entries in
 the iommu table
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
Date: Tue, 29 Jan 2013 11:35:56 +1100
In-Reply-To: <1357846419-13515-1-git-send-email-cascardo@linux.vnet.ibm.com>
References: <1357846419-13515-1-git-send-email-cascardo@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, shangw@linux.vnet.ibm.com,
 anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-01-10 at 17:33 -0200, Thadeu Lima de Souza Cascardo wrote:
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
> ---
> v2:
> Remove the unneeded extra variable i, which caused build failure.

I believe something equivalent is already in -next, can you dbl check ?

Cheers,
Ben.

> ---
>  arch/powerpc/kernel/iommu.c |    9 ++-------
>  1 files changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
> index 6d48ff8..0fc44d2 100644
> --- a/arch/powerpc/kernel/iommu.c
> +++ b/arch/powerpc/kernel/iommu.c
> @@ -708,7 +708,7 @@ struct iommu_table *iommu_init_table(struct iommu_table *tbl, int nid)
>  
>  void iommu_free_table(struct iommu_table *tbl, const char *node_name)
>  {
> -	unsigned long bitmap_sz, i;
> +	unsigned long bitmap_sz;
>  	unsigned int order;
>  
>  	if (!tbl || !tbl->it_map) {
> @@ -725,14 +725,9 @@ void iommu_free_table(struct iommu_table *tbl, const char *node_name)
>  		clear_bit(0, tbl->it_map);
>  
>  	/* verify that table contains no entries */
> -	/* it_size is in entries, and we're examining 64 at a time */
> -	for (i = 0; i < (tbl->it_size/64); i++) {
> -		if (tbl->it_map[i] != 0) {
> +	if (find_first_bit(tbl->it_map, tbl->it_size) < tbl->it_size)
>  			printk(KERN_WARNING "%s: Unexpected TCEs for %s\n",
>  				__func__, node_name);
> -			break;
> -		}
> -	}
>  
>  	/* calculate bitmap size in bytes */
>  	bitmap_sz = (tbl->it_size + 7) / 8;
