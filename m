Return-Path: <SRS0=FHsg=IT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,RDNS_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (unknown [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B3DC433DB
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Mar 2021 02:49:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF1956195A
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Mar 2021 02:49:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF1956195A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bombadil.infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F32Cj2QM6z3byL
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Mar 2021 13:49:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ff1dQ5SO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=rdunlap@infradead.org; receiver=<UNKNOWN>)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F2wjv4j5Jz2yRh
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Mar 2021 09:41:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
 References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=4mDsL15abTqOqk7vZ4xYCrnDfgqfrdW7pgSkeCPBCaY=; b=ff1dQ5SO1IOX3GCqwxUc2DiqIv
 92REu42OwWBMdUoGVpqkqy97OZM2t951WjCMi4tcKE1MBkJ8jyfTNGD6lGsR4n4Ww7NKbcjFbTuXz
 LFg5HlUPeeJ7rareEj9CslUbMzzDNr8gnea2ZrHgqHp3RtCSnGt7ZLoVgF97+cj3dnjwIpydy3jU7
 GWw3Og9gzmkuFUUI8fBATo0StNYmbGBWjbkBxOLx3X/iMmzbMI48gYHvA1deLGMwP6OKe4mkNeXsc
 KEslviC+PB/9OkS7uZADatHRsJ6AM7YUsA2MhYUpZ+PRV10aL+iAwxoNtJGMUww0MpKw72yA2/zPh
 33vgAScQ==;
Received: from rdunlap (helo=localhost)
 by bombadil.infradead.org with local-esmtp (Exim 4.94 #2 (Red Hat Linux))
 id 1lNkHt-0024j2-Jd; Sat, 20 Mar 2021 22:41:42 +0000
Date: Sat, 20 Mar 2021 15:41:41 -0700 (PDT)
From: Randy Dunlap <rdunlap@bombadil.infradead.org>
To: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: Re: [PATCH] powerpc: epapr: A typo fix
In-Reply-To: <20210320213932.22697-1-unixbhaskar@gmail.com>
Message-ID: <58285cd-cc1e-3988-2753-a8eaae9e419@bombadil.infradead.org>
References: <20210320213932.22697-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210320_154141_669336_4759A38C 
X-CRM114-Status: GOOD (  12.73  )
X-Mailman-Approved-At: Sun, 21 Mar 2021 13:48:15 +1100
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
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On Sun, 21 Mar 2021, Bhaskar Chowdhury wrote:

>
> s/parmeters/parameters/
>
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>


> ---
> arch/powerpc/include/asm/epapr_hcalls.h | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/include/asm/epapr_hcalls.h b/arch/powerpc/include/asm/epapr_hcalls.h
> index c99ba08a408d..cdf3c6df5123 100644
> --- a/arch/powerpc/include/asm/epapr_hcalls.h
> +++ b/arch/powerpc/include/asm/epapr_hcalls.h
> @@ -65,7 +65,7 @@
>  * but the gcc inline assembly syntax does not allow us to specify registers
>  * on the clobber list that are also on the input/output list.  Therefore,
>  * the lists of clobbered registers depends on the number of register
> - * parmeters ("+r" and "=r") passed to the hypercall.
> + * parameters ("+r" and "=r") passed to the hypercall.
>  *
>  * Each assembly block should use one of the HCALL_CLOBBERSx macros.  As a
>  * general rule, 'x' is the number of parameters passed to the assembly
> --
> 2.26.2
>
>
