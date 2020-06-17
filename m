Return-Path: <SRS0=OkvJ=76=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63155C433E1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Jun 2020 14:24:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11C8820897
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Jun 2020 14:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="WE0MqTxx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11C8820897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49n6l05zFkzDqxs
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Jun 2020 00:24:12 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49n6Vn3TQgzDqwn
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jun 2020 00:13:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=WE0MqTxx; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 49n6Vl166Tz9sSF;
 Thu, 18 Jun 2020 00:13:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1592403215;
 bh=yJ7IVrfjUL7bvgBlIpbHcEVKh7AcaV7LQqGjQYFZ0aU=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=WE0MqTxxT7dIxRLJ1twvDRMuwovW0/xLVJHQQjQ77nBMyuaW+4pKigwfQEwOPoqSg
 SuL1eUB6O244tcxeQSyJG+pZLUwLacx+6JYcX89Oi5cuw5j3odJYTC9tzT3sEJFCSV
 XUhvqflTg1ebHEyELsLH2TQPWFRos+vDbiRngKUmO4qdwqR5n/rnU+vZciKgvUN4vM
 01dzSGX/L/TtPqQlMZL1wymLIahPaolbCzP1RatjHTPaaFBHt2NfhS5dr79EPzjAa9
 +HaFiIkR5yUz9AKVVSGITnpMClbXpZwt6FmnU4angf2OZeBux5BdqzKSGQxy5ugWxj
 +ZGCwIn3mfFwg==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Will Deacon <will@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Peter Zijlstra \(Intel\)" <peterz@infradead.org>
Subject: Re: [PATCH 1/3] mm/gup: Use huge_ptep_get() in gup_hugepte()
In-Reply-To: <ffc3714334c3bfaca6f13788ad039e8759ae413f.1592225558.git.christophe.leroy@csgroup.eu>
References: <cover.1592225557.git.christophe.leroy@csgroup.eu>
 <ffc3714334c3bfaca6f13788ad039e8759ae413f.1592225558.git.christophe.leroy@csgroup.eu>
Date: Thu, 18 Jun 2020 00:14:05 +1000
Message-ID: <87zh91dbki.fsf@mpe.ellerman.id.au>
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
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> gup_hugepte() reads hugepage table entries, it can't read
> them directly, huge_ptep_get() must be used.
>
> Fixes: 2ab3a0a02905 ("READ_ONCE: Enforce atomicity for {READ,WRITE}_ONCE() memory accesses")

I see that commit in older versions of linux-next but not in mainline.

In mainline it seems to be: 9e343b467c70 ("READ_ONCE: Enforce atomicity for {READ,WRITE}_ONCE() memory accesses")

I guess it got rebased somewhere along the way.

I fixed it up when applying, and the other two as well.

cheers

> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  mm/gup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/gup.c b/mm/gup.c
> index de9e36262ccb..761df4944ef5 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2425,7 +2425,7 @@ static int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
>  	if (pte_end < end)
>  		end = pte_end;
>  
> -	pte = READ_ONCE(*ptep);
> +	pte = huge_ptep_get(ptep);
>  
>  	if (!pte_access_permitted(pte, flags & FOLL_WRITE))
>  		return 0;
> -- 
> 2.25.0
