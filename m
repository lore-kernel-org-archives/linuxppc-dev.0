Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zPxqn3DVdzF0X6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jan 2018 14:34:13 +1100 (AEDT)
In-Reply-To: <20171128083440.18688-1-aneesh.kumar@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: powerpc/hash: Skip non initialized page size in
 init_hpte_page_sizes
Message-Id: <3zPxqn00Y1z9sDB@ozlabs.org>
Date: Mon, 22 Jan 2018 14:34:11 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-11-28 at 08:34:40 UTC, "Aneesh Kumar K.V" wrote:
> One of the easiest way to test config with 4K HPTE is to disable 64K hardware
> page size like below.
> 
> int __init htab_dt_scan_page_sizes(unsigned long node,
> 
>  		size -= 3; prop += 3;
>  		base_idx = get_idx_from_shift(base_shift);
> -		if (base_idx < 0) {
> +		if (base_idx < 0 || base_idx == MMU_PAGE_64K) {
>  			/* skip the pte encoding also */
>  			prop += lpnum * 2; size -= lpnum * 2;
> 
> But then this results in error in other part of the code such as MPSS parsing
> where we look at 4K base page size and 64K actual page size support.
> 
> This patch fix MPSS parsing by ignoring the actual page sizes marked
> unsupported. In reality this can happen only with a corrupt device tree. But it
> is good to tighten the error check.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/10527e808123f4b12db604993638b3

cheers
