Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x241.google.com (mail-pa0-x241.google.com
 [IPv6:2607:f8b0:400e:c03::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rqjQH4pn1zDqxj
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 14:29:11 +1000 (AEST)
Received: by mail-pa0-x241.google.com with SMTP id dx3so4029786pab.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 21:29:11 -0700 (PDT)
Date: Thu, 14 Jul 2016 14:29:02 +1000
From: Balbir Singh <bsingharora@gmail.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH for-4.8 07/12] powerpc/mm/hash: Update SDR1 size encoding
 as documented in ISA 3.0
Message-ID: <20160714042902.GH18277@balbir.ozlabs.ibm.com>
Reply-To: bsingharora@gmail.com
References: <1468402531-4914-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1468402531-4914-8-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1468402531-4914-8-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 13, 2016 at 03:05:26PM +0530, Aneesh Kumar K.V wrote:
> ISA 3.0 document hash table size in bytes = 2^(HTABSIZE + 18)
> 
> No functionality change by this patch.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/mm/hash_utils_64.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
> index b90fe2480089..47d59a1f12f1 100644
> --- a/arch/powerpc/mm/hash_utils_64.c
> +++ b/arch/powerpc/mm/hash_utils_64.c
> @@ -714,10 +714,9 @@ int remove_section_mapping(unsigned long start, unsigned long end)
>  #endif /* CONFIG_MEMORY_HOTPLUG */
>  
>  static void __init hash_init_partition_table(phys_addr_t hash_table,
> -					     unsigned long pteg_count)
> +					     unsigned long htab_size)
>  {
>  	unsigned long ps_field;
> -	unsigned long htab_size;
>  	unsigned long patb_size = 1UL << PATB_SIZE_SHIFT;
>  
>  	/*
> @@ -725,7 +724,7 @@ static void __init hash_init_partition_table(phys_addr_t hash_table,
>  	 * We can ignore that for lpid 0
>  	 */
>  	ps_field = 0;
> -	htab_size =  __ilog2(pteg_count) - 11;
> +	htab_size =  __ilog2(htab_size) - 18;

I was wondering if we should just do

#define HPT_MIN_SIZE_SHIFT	18

and then use it instead?
