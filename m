Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp05.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 11E822C00C3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Oct 2013 16:25:37 +1100 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 17 Oct 2013 10:55:32 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 06F4B394004D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Oct 2013 10:55:10 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r9H5SBJN44040254
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Oct 2013 10:58:12 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r9H5PSSt002414
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Oct 2013 10:55:28 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Alistair Popple <alistair@popple.id.au>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: Fix 64K page size support for PPC44x
In-Reply-To: <1381986910-16310-1-git-send-email-alistair@popple.id.au>
References: <1381986910-16310-1-git-send-email-alistair@popple.id.au>
Date: Thu, 17 Oct 2013 10:55:25 +0530
Message-ID: <87mwm8qxiy.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Alistair Popple <alistair@popple.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alistair Popple <alistair@popple.id.au> writes:

> PPC44x supports page sizes other than 4K however when 64K page sizes
> are selected compilation fails. This is due to a change in the
> definition of pgtable_t introduced by the following patch:
>
> commit 5c1f6ee9a31cbdac90bbb8ae1ba4475031ac74b4
> Author: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> powerpc: Reduce PTE table memory wastage
>
> The above patch only implements the new layout for PPC64 so it doesn't
> compile for PPC32 with a 64K page size. Ideally we should implement
> the same layout for PPC32 however for the meantime this patch reverts
> the definition of pgtable_t for PPC32.
>
> Signed-off-by: Alistair Popple <alistair@popple.id.au>
> ---
>  arch/powerpc/include/asm/page.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
> index b9f4262..b142d58 100644
> --- a/arch/powerpc/include/asm/page.h
> +++ b/arch/powerpc/include/asm/page.h
> @@ -403,7 +403,7 @@ void arch_free_page(struct page *page, int order);
>
>  struct vm_area_struct;
>
> -#ifdef CONFIG_PPC_64K_PAGES
> +#if defined(CONFIG_PPC_64K_PAGES) && defined(PPC64)
                                               ^^^ CONFIG_PPC64 ?                                             

>  typedef pte_t *pgtable_t;
>  #else
>  typedef struct page *pgtable_t;
> -- 
> 1.7.10.4
