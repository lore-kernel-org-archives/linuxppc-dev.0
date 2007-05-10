Return-Path: <kniht@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 86FA1DDED1
	for <linuxppc-dev@ozlabs.org>; Fri, 11 May 2007 08:33:06 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4AMX32I019524
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 18:33:03 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4AMX2XD179408
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 16:33:02 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4AMX2Et019778
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 16:33:02 -0600
Message-ID: <46439D9D.8080609@linux.vnet.ibm.com>
Date: Thu, 10 May 2007 17:33:01 -0500
From: Jon Tollefson <kniht@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Generalize hpte_decode()
References: <17986.44428.934539.499645@cargo.ozlabs.ibm.com>
In-Reply-To: <17986.44428.934539.499645@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras wrote:
> This adds the necessary support to hpte_decode() to handle 1TB
> segments and 16GB pages, and also removes an uninitialized value
> warning on avpn.
>
> We don't have any code to generate HPTEs for 1TB segments or 16GB
> pages yet, so this is mostly for completeness, and also to fix the
> warning.
>
> Signed-off-by: Paul Mackerras <paulus@samba.org>
> ---
>
> diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
> index 7b7fe2d..7d722ee 100644
> --- a/arch/powerpc/mm/hash_native_64.c
> +++ b/arch/powerpc/mm/hash_native_64.c
> @@ -376,31 +376,28 @@ static void hpte_decode(hpte_t *hpte, unsigned long slot,
>  		}
>  	}
>
> -	/*
> -	 * FIXME, the code below works for 16M, 64K, and 4K pages as these
> -	 * fall under the p<=23 rules for calculating the virtual address.
> -	 * In the case of 16M pages, an extra bit is stolen from the AVPN
> -	 * field to achieve the requisite 24 bits.
> -	 *
> -	 * Does not work for 16G pages or 1 TB segments.
> -	 */
> +	/* This works for all page sizes, and for 256M and 1T segments */
>  	shift = mmu_psize_defs[size].shift;
> -	if (mmu_psize_defs[size].avpnm)
> -		avpnm_bits = __ilog2_u64(mmu_psize_defs[size].avpnm) + 1;
>   
The variable avpnm_bits doesn't appear to be used anymore.  Does it make 
sense to remove it's declaration?

Jon
