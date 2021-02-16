Return-Path: <SRS0=jy/z=HS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA2EC433DB
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Feb 2021 05:40:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E026364DAF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Feb 2021 05:40:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E026364DAF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DfqZ11q3Zz3cGC
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Feb 2021 16:40:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=axtens.net header.i=@axtens.net header.a=rsa-sha256 header.s=google header.b=FIFkH4tI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=axtens.net (client-ip=2607:f8b0:4864:20::432;
 helo=mail-pf1-x432.google.com; envelope-from=dja@axtens.net;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=axtens.net header.i=@axtens.net header.a=rsa-sha256
 header.s=google header.b=FIFkH4tI; dkim-atps=neutral
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DfqYS55N0z30Gd
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2021 16:39:53 +1100 (AEDT)
Received: by mail-pf1-x432.google.com with SMTP id y25so2198979pfp.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Feb 2021 21:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtens.net; s=google;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=jr+gyTBDN4GpRjLzY8XDxkrfLwIUwO/4+yo6uYSRMXM=;
 b=FIFkH4tIM0oXd/wgZB0MpbuxLgF78eUeo248QeQ247/HeX8YnsKZYv2iN4+d+FpMVR
 2aemT0w1RtMVMFRkQlx6S0uymf+t8+DXIH/dBXlT+VRv4hiWZj/kFOTV+6LU2T8clT1B
 cTx3kBtJYxV6zBdY4E9MIXncjm81OP1jBuUPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=jr+gyTBDN4GpRjLzY8XDxkrfLwIUwO/4+yo6uYSRMXM=;
 b=pZUU5+2v2WpevviFRVYxg/KD3XQnx0O+LNp34IBk18DIRdUjPguDWfRsKBrUdVvh2w
 nP1AcTOWc7Xg2xyZ8VMCOL3CHF71qujYH9PfGteOkxvi4NitODHEHSb0owLUl5eOoMev
 b5ty3mWcQ/k6Onby3uAlHqo9NvB/UGbTwiwj5zpGiZbH3+C/0E1UsSesDzQf3Zetk5yx
 2x8fgH+rtkYEIFTE8Ici7/SmXTWp1CEXhCYfze3FP76ebi1pG/vwHqDjspzia1ThTAls
 GSrYaVAkZKu0j1/gXwU1lga5lAFNPn350u4f+JuQhs4NCNaPTtejjCdSxXumztLUjCZS
 V1+g==
X-Gm-Message-State: AOAM5321DXPrdNj+zdng39+oIhAHphAOK2/hYWOfkB9ybWX9bhPGyTVZ
 Rri0sECyWwlbIwC8itjy8MX5cgqDtCXeypNu
X-Google-Smtp-Source: ABdhPJzmDwwaFvcoeIQoBHQ78dVnyJcv2ezrZEkwYpklVEKLs8WHv2ZFAQz3QS/+zK1ovMQgSVX6jw==
X-Received: by 2002:a65:6a48:: with SMTP id o8mr17653103pgu.424.1613453989375; 
 Mon, 15 Feb 2021 21:39:49 -0800 (PST)
Received: from localhost
 (2001-44b8-1113-6700-7ad2-5bb3-4fd4-d737.static.ipv6.internode.on.net.
 [2001:44b8:1113:6700:7ad2:5bb3:4fd4:d737])
 by smtp.gmail.com with ESMTPSA id y23sm17802224pfo.50.2021.02.15.21.39.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Feb 2021 21:39:48 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/6] powerpc/pseries: Add key to flags in
 pSeries_lpar_hpte_updateboltedpp()
In-Reply-To: <20210211135130.3474832-2-mpe@ellerman.id.au>
References: <20210211135130.3474832-1-mpe@ellerman.id.au>
 <20210211135130.3474832-2-mpe@ellerman.id.au>
Date: Tue, 16 Feb 2021 16:39:45 +1100
Message-ID: <87tuqca7vi.fsf@linkitivity.dja.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: aneesh.kumar@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Michael Ellerman <mpe@ellerman.id.au> writes:

> The flags argument to plpar_pte_protect() (aka. H_PROTECT), includes
> the key in bits 9-13, but currently we always set those bits to zero.
>
> In the past that hasn't been a problem because we always used key 0
> for the kernel, and updateboltedpp() is only used for kernel mappings.
>
> However since commit d94b827e89dc ("powerpc/book3s64/kuap: Use Key 3
> for kernel mapping with hash translation") we are now inadvertently
> changing the key (to zero) when we call plpar_pte_protect().
>
> That hasn't broken anything because updateboltedpp() is only used for
> STRICT_KERNEL_RWX, which is currently disabled on 64s due to other
> bugs.
>
> But we want to fix that, so first we need to pass the key correctly to
> plpar_pte_protect(). In the `newpp` value the low 3 bits of the key
> are already in the correct spot, but the high 2 bits of the key need
> to be shifted down.
>
> Fixes: d94b827e89dc ("powerpc/book3s64/kuap: Use Key 3 for kernel mapping with hash translation")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/platforms/pseries/lpar.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
> index 764170fdb0f7..8bbbddff7226 100644
> --- a/arch/powerpc/platforms/pseries/lpar.c
> +++ b/arch/powerpc/platforms/pseries/lpar.c
> @@ -976,11 +976,13 @@ static void pSeries_lpar_hpte_updateboltedpp(unsigned long newpp,
>  	slot = pSeries_lpar_hpte_find(vpn, psize, ssize);
>  	BUG_ON(slot == -1);
>  
> -	flags = newpp & 7;
> +	flags = newpp & (HPTE_R_PP | HPTE_R_N);
>  	if (mmu_has_feature(MMU_FTR_KERNEL_RO))
>  		/* Move pp0 into bit 8 (IBM 55) */
>  		flags |= (newpp & HPTE_R_PP0) >> 55;
>  
> +	flags |= ((newpp & HPTE_R_KEY_HI) >> 48) | (newpp & HPTE_R_KEY_LO);
> +

I'm really confused about how these bits are getting packed into the
flags parameter. It seems to match how they are unpacked in
kvmppc_h_pr_protect, but I cannot figure out why they are packed in that
order, and the LoPAR doesn't seem especially illuminating on this topic
- although I may have missed the relevant section.

Kind regards,
Daniel

>  	lpar_rc = plpar_pte_protect(flags, slot, 0);
>  
>  	BUG_ON(lpar_rc != H_SUCCESS);
> -- 
> 2.25.1
