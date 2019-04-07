Return-Path: <SRS0=YAae=SJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A12C282DA
	for <linuxppc-dev@archiver.kernel.org>; Sun,  7 Apr 2019 01:35:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67D0C213A2
	for <linuxppc-dev@archiver.kernel.org>; Sun,  7 Apr 2019 01:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="nDzOMH9P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67D0C213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44cGMM2zxDzDqNk
	for <linuxppc-dev@archiver.kernel.org>; Sun,  7 Apr 2019 11:35:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=lca.pw
 (client-ip=2607:f8b0:4864:20::843; helo=mail-qt1-x843.google.com;
 envelope-from=cai@lca.pw; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=lca.pw header.i=@lca.pw header.b="nDzOMH9P"; 
 dkim-atps=neutral
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44cGKl4S96zDqNL
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  7 Apr 2019 11:33:44 +1000 (AEST)
Received: by mail-qt1-x843.google.com with SMTP id p20so11619337qtc.9
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 06 Apr 2019 18:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Fi356eH+q127lLencdKNQdR5QyRqbuh3N7FTciKvLiw=;
 b=nDzOMH9P7cuNlPh+9hFeb4vYXTETfEp6qOsWVmqAxXuoj9mD4QXCeDbdaG/xZrtf69
 PBNcUPCn0Q8wGk1PP71FrTBjfgYkwunbZBVcukYBdwwKogOXxknCSdqC1KDyCj7cK0Hg
 E8qt9qFE7874i7FzSXQQX4Q7bw/ioeBNMhKD3YUW7W0jt4JY9tWbFWyOVkKqTjOvaHSy
 8vWnYTEwsh0seJxJLIigJ4u4UdNoMI9DmIZ3kRUERf4WGiKTQdr4YHCbomQEe9HjkeID
 iV4yqdpcDDRsDKM4t5DFCdErEUNZKatJWwaTopq6gOLfRLdvwNjSi7tkZWQv6Tq6WVC7
 FlOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Fi356eH+q127lLencdKNQdR5QyRqbuh3N7FTciKvLiw=;
 b=uAQGxavy8GR7vT0eEGTf30CopKyKTOWe7eQgzaDR2DB9+OL4hAgEbFTA15Cq7zeSm+
 R09Eg6siGsbmctzjYfe9pG6p6ZlZ0aOb1oTK/OcRopZIwTJlkEMzVIVfBBW1H8bZGLlC
 F0c8OY4aefdBe1ICa0dN12kOPV9J7c9SB+zQYTm/lXvKmrRAfD5hno2RKK0/N/HOmg3/
 vwm/1haJ2dN23D3M12qVzQ5OenE9emuEYUs1Dgqxsxw7Z7X30B5hfF6L2ESAy6NPtvyB
 oWQ0nJljT4PrC1g6z8hS3Mv1P32CiS9jr/utGuyLEou2V+a7LmTXBaXbarvTwjU/3IaN
 VWFg==
X-Gm-Message-State: APjAAAWZrQYXgCtePbc09f3PFs3euJpHwYFKHcRririSmGdwetqCl3L3
 Bl9ScwuIS5qxtJ6zxC0AqJOpqg==
X-Google-Smtp-Source: APXvYqz+s+zSDC3WkXOR5/Wrb4QxhNvjPWYAjxAZKT7Y4rnzoOPSOd8pMo8+h5UOTD8iDVFpdIP1Fg==
X-Received: by 2002:aed:3e94:: with SMTP id n20mr18758602qtf.268.1554600821785; 
 Sat, 06 Apr 2019 18:33:41 -0700 (PDT)
Received: from ovpn-120-94.rdu2.redhat.com
 (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
 by smtp.gmail.com with ESMTPSA id g12sm16086539qki.76.2019.04.06.18.33.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 06 Apr 2019 18:33:41 -0700 (PDT)
Subject: Re: [PATCH v2] powerpc: silence unused-but-set-variable warnings
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
References: <20190307144031.52494-1-cai@lca.pw>
From: Qian Cai <cai@lca.pw>
Message-ID: <0987de8e-4549-4392-ee27-8cdcc3f5026a@lca.pw>
Date: Sat, 6 Apr 2019 21:33:38 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190307144031.52494-1-cai@lca.pw>
Content-Type: text/plain; charset=utf-8
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

Ping. The patchwork status is still New after a month.

On 3/7/19 9:40 AM, Qian Cai wrote:
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
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
> 
> v2: make it a static inline function.
> 
>  arch/powerpc/include/asm/book3s/64/pgtable.h | 3 ++-
>  arch/powerpc/include/asm/nohash/64/pgtable.h | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
> index 868fcaf56f6b..d798e33a0c86 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -1006,7 +1006,8 @@ extern struct page *pgd_page(pgd_t pgd);
>  	(((pte_t *) pmd_page_vaddr(*(dir))) + pte_index(addr))
>  
>  #define pte_offset_map(dir,addr)	pte_offset_kernel((dir), (addr))
> -#define pte_unmap(pte)			do { } while(0)
> +
> +static inline void pte_unmap(pte_t *pte) { }
>  
>  /* to find an entry in a kernel page-table-directory */
>  /* This now only contains the vmalloc pages */
> diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
> index e77ed9761632..0384a3302fb6 100644
> --- a/arch/powerpc/include/asm/nohash/64/pgtable.h
> +++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
> @@ -205,7 +205,8 @@ static inline void pgd_set(pgd_t *pgdp, unsigned long val)
>    (((pte_t *) pmd_page_vaddr(*(dir))) + (((addr) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1)))
>  
>  #define pte_offset_map(dir,addr)	pte_offset_kernel((dir), (addr))
> -#define pte_unmap(pte)			do { } while(0)
> +
> +static inline void pte_unmap(pte_t *pte) { }
>  
>  /* to find an entry in a kernel page-table-directory */
>  /* This now only contains the vmalloc pages */
> 
