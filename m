Return-Path: <nacc@us.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 024C0B6F84
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 15 Mar 2011 05:33:31 +1100 (EST)
Received: from d01dlp01.pok.ibm.com (d01dlp01.pok.ibm.com [9.56.224.56])
	by e5.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p2EI85Uh005267
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Mar 2011 14:08:05 -0400
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 8B72A38C8038
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 14 Mar 2011 14:33:03 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p2EIX6WR356392
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Mar 2011 14:33:06 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p2EIX6PM028207
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Mar 2011 15:33:06 -0300
Date: Mon, 14 Mar 2011 11:33:00 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] powerpc: Add pgprot_writecombine
Message-ID: <20110314183300.GA2932@us.ibm.com>
References: <20110301170047.601c83b7@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110301170047.601c83b7@kryten>
Cc: linuxppc-dev@lists.ozlabs.org, swise@chelsio.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01.03.2011 [17:00:47 +1100], Anton Blanchard wrote:
> 
> A number of drivers are using pgprot_writecombine() to enable write
> combining on userspace mappings. Implement it on powerpc.

Given this patch, should drivers/infiniband/hw/cxgb4/t4.h

be updated?:

static inline pgprot_t t4_pgprot_wc(pgprot_t prot)
{
#if defined(__i386__) || defined(__x86_64__)
        return pgprot_writecombine(prot);
#elif defined(CONFIG_PPC64)
        return __pgprot((pgprot_val(prot) | _PAGE_NO_CACHE) &
                        ~(pgprot_t)_PAGE_GUARDED);
#else
        return pgprot_noncached(prot);
#endif
}

Thanks,
Nish

> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---
> 
> diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
> index 89f1587..88b0bd9 100644
> --- a/arch/powerpc/include/asm/pgtable.h
> +++ b/arch/powerpc/include/asm/pgtable.h
> @@ -170,6 +170,7 @@ extern int ptep_set_access_flags(struct vm_area_struct *vma, unsigned long addre
>  #define pgprot_cached_wthru(prot) (__pgprot((pgprot_val(prot) & ~_PAGE_CACHE_CTL) | \
>  				            _PAGE_COHERENT | _PAGE_WRITETHRU))
> 
> +#define pgprot_writecombine pgprot_noncached_wc
> 
>  struct file;
>  extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

-- 
Nishanth Aravamudan <nacc@us.ibm.com>
IBM Linux Technology Center
