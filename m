Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x243.google.com (mail-pa0-x243.google.com
 [IPv6:2607:f8b0:400e:c03::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rqhs071QhzDqxj
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 14:03:48 +1000 (AEST)
Received: by mail-pa0-x243.google.com with SMTP id hh10so3983170pac.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 21:03:48 -0700 (PDT)
Date: Thu, 14 Jul 2016 14:03:38 +1000
From: Balbir Singh <bsingharora@gmail.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH for-4.8 06/12] powerpc/mm: Print formation regarding the
 the MMU mode
Message-ID: <20160714040338.GE18277@balbir.ozlabs.ibm.com>
Reply-To: bsingharora@gmail.com
References: <1468402531-4914-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1468402531-4914-7-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1468402531-4914-7-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 13, 2016 at 03:05:25PM +0530, Aneesh Kumar K.V wrote:
> This helps in easily identifying the MMU mode with which the kernel
> is operating.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/mm/hash_utils_64.c | 3 ++-
>  arch/powerpc/mm/pgtable-radix.c | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
> index 7e6d38e01645..b90fe2480089 100644
> --- a/arch/powerpc/mm/hash_utils_64.c
> +++ b/arch/powerpc/mm/hash_utils_64.c
> @@ -739,7 +739,7 @@ static void __init hash_init_partition_table(phys_addr_t hash_table,
>  	 * For now UPRT is 0 for us.
>  	 */
>  	partition_tb->patb1 = 0;
> -	DBG("Partition table %p\n", partition_tb);
> +	pr_info("Partition table %p\n", partition_tb);
>  	/*
>  	 * update partition table control register,
>  	 * 64 K size.
> @@ -943,6 +943,7 @@ void __init hash__early_init_mmu(void)
>  	 */
>  	htab_initialize();
>  
> +	pr_info("Initializing hash mmu with SLB\n");

Can we be consistent and use Hash MMU like for Radix MMU below

Balbir Singh
