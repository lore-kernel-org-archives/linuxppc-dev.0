Return-Path: <SRS0=VpCV=5J=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F3EC2BAEE
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Mar 2020 06:39:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F48420714
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Mar 2020 06:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="P980gS4R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F48420714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48mhSJ3dz9zDr22
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Mar 2020 17:39:44 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48mhQV2gbNzDqM7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2020 17:38:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=P980gS4R; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 48mhQT5tdwz9sSJ;
 Tue, 24 Mar 2020 17:38:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1585031889;
 bh=c7EjEegKT+OeVcqyzvOF99g11jBviXeT8/NLjLaNQzo=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=P980gS4R4sI5OSwbEJUbqKjgYycPnM84V1zzgmgVE4fM09CFijk7cAMaO9TQ+PTQU
 Vj60BQ9rOMK8XoLqvpcUS+LzOerFZ17jS1jj5mYaIUvdGlkka5ifeDaWN+BnzhGx+S
 YDSj/xlo72a8piEc56yuB2DTuN79XzVDBi1oGCMFqFWUAmfh4k8u8P80oQOMZgpQcm
 J99BJmapuG+ncw6e7xwtJIv7hEO7wBAKI79vRVzliiaN3v0Bm1u8zEcg1t+c81PwIC
 z+knQe9fKj0jbtnPRde3fhdYkWoj3B4rxlKRCu02hy5144RxovwkwUpTUmyOSQIYaG
 Qt6997W9O2POA==
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, paulus@ozlabs.org
Subject: Re: [PATCH] arch/powerpc/mm: Enable compound page check for both THP
 and HugeTLB
In-Reply-To: <20200320103256.229365-1-aneesh.kumar@linux.ibm.com>
References: <20200320103256.229365-1-aneesh.kumar@linux.ibm.com>
Date: Tue, 24 Mar 2020 17:38:17 +1100
Message-ID: <87eetixnom.fsf@mpe.ellerman.id.au>
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
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
> THP config can result in compound pages. Make sure kernel enables the
> PageCompound() check when only THP is enabled.

Or else what happens ... nothing, rampant data corruption, something in
between?

And "when only THP is enabled" is not very clear, AFAIK there is no
relation between CONFIG_TRANSPARENT_HUGEPAGE and CONFIG_HUGETLB_PAGE.

You mean when either or both of THP or HUGETLB is enabled right?

cheers


> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> index 9b4f5fb719e0..b03cbddf9054 100644
> --- a/arch/powerpc/mm/mem.c
> +++ b/arch/powerpc/mm/mem.c
> @@ -485,7 +485,7 @@ EXPORT_SYMBOL(flush_dcache_page);
>  
>  void flush_dcache_icache_page(struct page *page)
>  {
> -#ifdef CONFIG_HUGETLB_PAGE
> +#if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_HUGETLB_PAGE)
>  	if (PageCompound(page)) {
>  		flush_dcache_icache_hugepage(page);
>  		return;
> -- 
> 2.25.1
