Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ttZFh2ST1zDqFn
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jan 2017 13:17:12 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id n5so35331112pgh.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Jan 2017 18:17:12 -0800 (PST)
Date: Wed, 4 Jan 2017 12:16:58 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy
 <christophe.leroy@c-s.fr>, Scott Wood <oss@buserror.net>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: fix pgtable pmd cache init
Message-ID: <20170104121658.1298adac@roar.ozlabs.ibm.com>
In-Reply-To: <87eg0j7f7q.fsf@linux.vnet.ibm.com>
References: <20170103155517.24347-1-npiggin@gmail.com>
 <87eg0j7f7q.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 04 Jan 2017 07:34:41 +0530
"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> wrote:

> Nicholas Piggin <npiggin@gmail.com> writes:
> 
> > Commit 9b081e10805cd ("powerpc: port 64 bits pgtable_cache to 32 bits")
> > mixed up PMD_INDEX_SIZE and PMD_CACHE_INDEX a couple of times. This
> > resulted in 64s/hash/4k configs to panic at boot with a false positive
> > error check.
> >
> > Fix that and simplify error handling by moving the check to the caller.
> >
> > Fixes: 9b081e10805cd ("powerpc: port 64 bits pgtable_cache to 32 bits")
> > Cc: Christophe Leroy <christophe.leroy@c-s.fr>
> > Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> > Cc: Scott Wood <oss@buserror.net>
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>  
> 
> I did another fix here.
> 
> https://lkml.kernel.org/r/20161214043349.23677-1-aneesh.kumar@linux.vnet.ibm.com
> 
> But this patch makes it much simpler. Hence.
> 
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> 
> There is this hunk in the patch I did.

Ah, I missed that. My patch just fixes the 9b081e10805cd bug, but this
hunk looks like it should still go in as another patch. Will you resend
it?

Thanks,
Nick


> 
> --- a/arch/powerpc/include/asm/book3s/64/hash.h
> +++ b/arch/powerpc/include/asm/book3s/64/hash.h
> @@ -33,9 +33,9 @@
> 				 H_PUD_INDEX_SIZE + H_PGD_INDEX_SIZE + PAGE_SHIFT)
>  #define H_PGTABLE_RANGE		(ASM_CONST(1) << H_PGTABLE_EADDR_SIZE)
> 
> -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +#if defined(CONFIG_TRANSPARENT_HUGEPAGE) &&  defined(CONFIG_PPC_64K_PAGES)
>  /*
> - * only with hash we need to use the second half of pmd page table
> + * only with hash 64k we need to use the second half of pmd page table
>   * to store pointer to deposited pgtable_t
>   */
>  #define H_PMD_CACHE_INDEX	(H_PMD_INDEX_SIZE + 1)
> 
