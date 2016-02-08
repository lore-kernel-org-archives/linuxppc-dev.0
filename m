Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 275DE1A0205
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Feb 2016 16:47:19 +1100 (AEDT)
Date: Mon, 8 Feb 2016 13:54:04 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: mpe@ellerman.id.au, benh@kernel.crashing.org,
 linuxppc-dev@lists.ozlabs.org, aik@ozlabs.ru, thuth@redhat.com,
 lvivier@redhat.com
Subject: Re: [RFCv2 3/9] arch/powerpc: Handle removing maybe-present bolted
 HPTEs
Message-ID: <20160208025404.GC30807@oak.ozlabs.ibm.com>
References: <1454045043-25545-1-git-send-email-david@gibson.dropbear.id.au>
 <1454045043-25545-4-git-send-email-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1454045043-25545-4-git-send-email-david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jan 29, 2016 at 04:23:57PM +1100, David Gibson wrote:
> At the moment the hpte_removebolted callback in ppc_md returns void and
> will BUG_ON() if the hpte it's asked to remove doesn't exist in the first
> place.  This is awkward for the case of cleaning up a mapping which was
> partially made before failing.
> 
> So, we add a return value to hpte_removebolted, and have it return ENOENT
> in the case that the HPTE to remove didn't exist in the first place.
> 
> In the (sole) caller, we propagate errors in hpte_removebolted to its
> caller to handle.  However, we handle ENOENT specially, continuing to
> complete the unmapping over the specified range before returning the error
> to the caller.
> 
> This means that htab_remove_mapping() will work sanely on a partially
> present mapping, removing any HPTEs which are present, while also returning
> ENOENT to its caller in case it's important there.
> 
> There are two callers of htab_remove_mapping():
>    - In remove_section_mapping() we already WARN_ON() any error return,
>      which is reasonable - in this case the mapping should be fully
>      present
>    - In vmemmap_remove_mapping() we BUG_ON() any error.  We change that to
>      just a WARN_ON() in the case of ENOENT, since failing to remove a
>      mapping that wasn't there in the first place probably shouldn't be
>      fatal.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

[snip]

> --- a/arch/powerpc/mm/hash_utils_64.c
> +++ b/arch/powerpc/mm/hash_utils_64.c
> @@ -269,6 +269,7 @@ int htab_remove_mapping(unsigned long vstart, unsigned long vend,
>  {
>  	unsigned long vaddr;
>  	unsigned int step, shift;
> +	int rc = 0;
>  
>  	shift = mmu_psize_defs[psize].shift;
>  	step = 1 << shift;
> @@ -276,10 +277,13 @@ int htab_remove_mapping(unsigned long vstart, unsigned long vend,
>  	if (!ppc_md.hpte_removebolted)
>  		return -ENODEV;
>  
> -	for (vaddr = vstart; vaddr < vend; vaddr += step)
> -		ppc_md.hpte_removebolted(vaddr, psize, ssize);
> +	for (vaddr = vstart; vaddr < vend; vaddr += step) {
> +		rc = ppc_md.hpte_removebolted(vaddr, psize, ssize);
> +		if ((rc < 0) && (rc != -ENOENT))
> +			return rc;
> +	}
>  
> -	return 0;
> +	return rc;

This will return the rc from the last hpte_removebolted call, which
might be 0 even if earlier calls had returned -ENOENT.  Or, if the
last call fails with -ENOENT, this will return -ENOENT.  Is that
exactly what you meant?  In the case where some calls to
hpte_removebolted return -ENOENT, I would think we would want a
consistent return value, which could be either 0 or -ENOENT, but it
shouldn't depend on which specific calls fail with -ENOENT, in my
opinion.

Paul.
