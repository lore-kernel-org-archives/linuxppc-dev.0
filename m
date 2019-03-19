Return-Path: <SRS0=MfaX=RW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6115C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Mar 2019 09:22:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33E9020857
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Mar 2019 09:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="mryVepj3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33E9020857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Nndj706NzDqJs
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Mar 2019 20:22:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="mryVepj3"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Nnbv30HmzDqHS
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2019 20:21:15 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44Nnbp27x6z9v08k;
 Tue, 19 Mar 2019 10:21:10 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=mryVepj3; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 7DrcefFBUkBG; Tue, 19 Mar 2019 10:21:10 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44Nnbp0zsHz9v08j;
 Tue, 19 Mar 2019 10:21:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1552987270; bh=6sikFZ4N/jQ0ISBwJMTWaFVlQYPTbXGpIXPC7q5qSnQ=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=mryVepj3HeXZZ1CFwjxrvhgQJDPXEm9cdLFlbC05IPyBLzAnB1kf5gYVCSruqO9N0
 yf/INIXoDBzhZmMsGEk4xprAi635b94alsddNr3yYm4XufGw0kkDfLRn3AhAiRgpfj
 rH7SqYfMy6jCZW3BB7QQkdZGyvWsRvqqABKovnXQ=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 1BBE38B74F;
 Tue, 19 Mar 2019 10:21:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id zLWCCoHGdv0u; Tue, 19 Mar 2019 10:21:11 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 7AEF68B8C6;
 Tue, 19 Mar 2019 10:21:10 +0100 (CET)
Subject: Re: [RESEND PATCH v2] powerpc: mute unused-but-set-variable warnings
To: Qian Cai <cai@lca.pw>, mpe@ellerman.id.au, benh@kernel.crashing.org,
 paulus@samba.org
References: <20190317220516.92654-1-cai@lca.pw>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <1ffdc5ae-2d5f-6c81-3997-0e6c81c67516@c-s.fr>
Date: Tue, 19 Mar 2019 10:21:10 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190317220516.92654-1-cai@lca.pw>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
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

Is there a reason for resending ? AFAICS, both are identical and still 
marked new in patchwork: 
https://patchwork.ozlabs.org/project/linuxppc-dev/list/?submitter=76055

Indeed, the resend has an issue in the commit log and fails the 
checkpatch (a :: in Reviewed-by::)

Christophe

Le 17/03/2019 à 23:05, Qian Cai a écrit :
> pte_unmap() compiles away on some powerpc platforms, so silence the
> warnings below by making it a static inline function.
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
> Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Reviewed-by:: Christophe Leroy <christophe.leroy@c-s.fr>
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
> 
> v2: make it a static inline function.
> 
>   arch/powerpc/include/asm/book3s/64/pgtable.h | 3 ++-
>   arch/powerpc/include/asm/nohash/64/pgtable.h | 3 ++-
>   2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
> index 868fcaf56f6b..d798e33a0c86 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -1006,7 +1006,8 @@ extern struct page *pgd_page(pgd_t pgd);
>   	(((pte_t *) pmd_page_vaddr(*(dir))) + pte_index(addr))
>   
>   #define pte_offset_map(dir,addr)	pte_offset_kernel((dir), (addr))
> -#define pte_unmap(pte)			do { } while(0)
> +
> +static inline void pte_unmap(pte_t *pte) { }
>   
>   /* to find an entry in a kernel page-table-directory */
>   /* This now only contains the vmalloc pages */
> diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
> index e77ed9761632..0384a3302fb6 100644
> --- a/arch/powerpc/include/asm/nohash/64/pgtable.h
> +++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
> @@ -205,7 +205,8 @@ static inline void pgd_set(pgd_t *pgdp, unsigned long val)
>     (((pte_t *) pmd_page_vaddr(*(dir))) + (((addr) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1)))
>   
>   #define pte_offset_map(dir,addr)	pte_offset_kernel((dir), (addr))
> -#define pte_unmap(pte)			do { } while(0)
> +
> +static inline void pte_unmap(pte_t *pte) { }
>   
>   /* to find an entry in a kernel page-table-directory */
>   /* This now only contains the vmalloc pages */
> 
