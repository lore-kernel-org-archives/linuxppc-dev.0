Return-Path: <SRS0=42OU=IK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC7EC433E6
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Mar 2021 16:42:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B719964FD9
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Mar 2021 16:42:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B719964FD9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Dxs6R0D20z3d76
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Mar 2021 03:42:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=merlin.20170209 header.b=dY53Jxah;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1234::107; helo=merlin.infradead.org;
 envelope-from=rdunlap@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=merlin.20170209 header.b=dY53Jxah; 
 dkim-atps=neutral
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1234::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Dxs5x0mb4z2yjK
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Mar 2021 03:41:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
 Reply-To:Cc:Content-ID:Content-Description;
 bh=NjO5e3NHxlfLBPFzxRL/627oFgY8z8FkhHekhopo2VY=; b=dY53Jxah5kMEb2PGNAmWb0SzKP
 gZ0ZjGbQwOxh/bpVmAx0Vu0XmnCsOOhiybXokrnaVeDkmC1EqHpqEElhZd5QCWdSUToD8/pVJJ32T
 SuYfuBbNMr6cD/oqhG/gjshO16+NnhL7e7+5+Yrq3BdOpfWmzslhQKR/8XMiXQOrp5ns+9uTAxjY3
 VDUYwmLZagGQWSWBinh+x2Eg1RqPt0AUFUlDl6vW7LRwKs1kGlnuYdZ6HPLGR1SK2xmjJsA9+q6EW
 C5m8KKIfgnFAUtPTSVjedpd6NdQWkbzhcMSD5g7FtsJUZz2dV37cHHuPv7rvhP4mtr/GSVpawhaiE
 MqpDf43Q==;
Received: from [2601:1c0:6280:3f0::3ba4]
 by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lKkqv-0014IL-Um; Fri, 12 Mar 2021 16:41:30 +0000
Subject: Re: [PATCH] powerpc: mm: book3s64: Fix a typo in the file
 mmu_context.c
To: Bhaskar Chowdhury <unixbhaskar@gmail.com>, mpe@ellerman.id.au,
 benh@kernel.crashing.org, paulus@samba.org, npiggin@gmail.com,
 aneesh.kumar@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20210312112537.4585-1-unixbhaskar@gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7a2b6ee3-33cf-00a3-fb5c-f8bcf404f29c@infradead.org>
Date: Fri, 12 Mar 2021 08:41:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210312112537.4585-1-unixbhaskar@gmail.com>
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 3/12/21 3:25 AM, Bhaskar Chowdhury wrote:
> 
> s/detalis/details/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  arch/powerpc/mm/book3s64/mmu_context.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/mm/book3s64/mmu_context.c b/arch/powerpc/mm/book3s64/mmu_context.c
> index 0c8557220ae2..c10fc8a72fb3 100644
> --- a/arch/powerpc/mm/book3s64/mmu_context.c
> +++ b/arch/powerpc/mm/book3s64/mmu_context.c
> @@ -119,7 +119,7 @@ static int hash__init_new_context(struct mm_struct *mm)
>  		/* This is fork. Copy hash_context details from current->mm */
>  		memcpy(mm->context.hash_context, current->mm->context.hash_context, sizeof(struct hash_mm_context));
>  #ifdef CONFIG_PPC_SUBPAGE_PROT
> -		/* inherit subpage prot detalis if we have one. */
> +		/* inherit subpage prot details if we have one. */
>  		if (current->mm->context.hash_context->spt) {
>  			mm->context.hash_context->spt = kmalloc(sizeof(struct subpage_prot_table),
>  								GFP_KERNEL);
> --


-- 
~Randy

