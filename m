Return-Path: <SRS0=+pA4=RK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111A4C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Mar 2019 06:36:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C84F20835
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Mar 2019 06:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="vYKcdrAL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C84F20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44FLWb0hC1zDqCM
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Mar 2019 17:36:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="vYKcdrAL"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44FLTd70tdzDqCD
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Mar 2019 17:35:01 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44FLTX3gtpz9v089;
 Thu,  7 Mar 2019 07:34:56 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=vYKcdrAL; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id ONlGw92ZOTaR; Thu,  7 Mar 2019 07:34:56 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44FLTX2T0fz9v087;
 Thu,  7 Mar 2019 07:34:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1551940496; bh=DLUTU4N4tm+YaD4okkr0dCWy+RzGTcAsCUFznaJT8bg=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=vYKcdrALMijKxu+/AbgZqIMVsjVA7eUSEl6BWAHINsOy8p0Sx4xTfORmsU3AOaDVO
 YTvvH0RqDj7quR2CUk6ouxca/cxEuhq7FK0woblI5+bR4TwpGaZ9RtKbeni1HuFbms
 qQcP0Swl2zWp6JgyfwgjhIdVQ0enWZKpihZpmnzw=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 229C28B8C7;
 Thu,  7 Mar 2019 07:34:52 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id UwmCsRx0nhL3; Thu,  7 Mar 2019 07:34:52 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id AD4418B8C2;
 Thu,  7 Mar 2019 07:34:51 +0100 (CET)
Subject: Re: [PATCH] powerpc: silence unused-but-set-variable warnings
To: Qian Cai <cai@lca.pw>, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au
References: <20190307034821.48769-1-cai@lca.pw>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <b378a6fe-06f3-000a-55ec-86e819b741c6@c-s.fr>
Date: Thu, 7 Mar 2019 06:34:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190307034821.48769-1-cai@lca.pw>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 03/07/2019 03:48 AM, Qian Cai wrote:
> pte_unmap() compiles away on some powerpc platforms, so silence the
> warnings below by using the argument to pte_unmap() as a nop. Also, fix
> checkpatch.pl warnings "Single statement macros should not use a do {}
> while (0) loop".
> 
> mm/memory.c: In function 'copy_pte_range':
> mm/memory.c:820:24: warning: variable 'orig_dst_pte' set but not used
> [-Wunused-but-set-variable]
> mm/memory.c:820:9: warning: variable 'orig_src_pte' set but not used
> [-Wunused-but-set-variable]
> mm/madvise.c: In function 'madvise_free_pte_range':
> mm/madvise.c:318:9: warning: variable 'orig_pte' set but not used
> [-Wunused-but-set-variable]
> mm/swap_state.c: In function 'swap_ra_info':
> mm/swap_state.c:634:15: warning: variable 'orig_pte' set but not used
> [-Wunused-but-set-variable]
> 
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>   arch/powerpc/include/asm/book3s/64/pgtable.h | 2 +-
>   arch/powerpc/include/asm/nohash/64/pgtable.h | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
> index 868fcaf56f6b..ec00ce6dd312 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -1006,7 +1006,7 @@ extern struct page *pgd_page(pgd_t pgd);
>   	(((pte_t *) pmd_page_vaddr(*(dir))) + pte_index(addr))
>   
>   #define pte_offset_map(dir,addr)	pte_offset_kernel((dir), (addr))
> -#define pte_unmap(pte)			do { } while(0)
> +#define pte_unmap(pte)			(void)(pte)

I think it would be better with a static inline

--- a/arch/powerpc/include/asm/nohash/64/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
@@ -205,7 +205,8 @@ static inline void pgd_set(pgd_t *pgdp, unsigned 
long val)
    (((pte_t *) pmd_page_vaddr(*(dir))) + (((addr) >> PAGE_SHIFT) & 
(PTRS_PER_PTE - 1)))

  #define pte_offset_map(dir,addr)	pte_offset_kernel((dir), (addr))
-#define pte_unmap(pte)			do { } while(0)
+
+static inline void pte_unmap(pte_t *pte) { }

  /* to find an entry in a kernel page-table-directory */
  /* This now only contains the vmalloc pages */


Christophe

>   
>   /* to find an entry in a kernel page-table-directory */
>   /* This now only contains the vmalloc pages */
> diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
> index e77ed9761632..103071afab3d 100644
> --- a/arch/powerpc/include/asm/nohash/64/pgtable.h
> +++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
> @@ -205,7 +205,7 @@ static inline void pgd_set(pgd_t *pgdp, unsigned long val)
>     (((pte_t *) pmd_page_vaddr(*(dir))) + (((addr) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1)))
>   
>   #define pte_offset_map(dir,addr)	pte_offset_kernel((dir), (addr))
> -#define pte_unmap(pte)			do { } while(0)
> +#define pte_unmap(pte)			(void)(pte)
>   
>   /* to find an entry in a kernel page-table-directory */
>   /* This now only contains the vmalloc pages */
> 
