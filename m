Return-Path: <SRS0=1PmZ=FA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E49C56201
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2020 03:29:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B679A21741
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2020 03:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="pNqni0Cn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B679A21741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ChNY24q29zDqsq
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2020 14:29:42 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4ChNWN0gRNzDqR1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2020 14:28:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=pNqni0Cn; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4ChNWM6GC3z9sRK;
 Thu, 26 Nov 2020 14:28:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1606361295;
 bh=JeXbhqzrtPmg4rJYX0q0j0uEabWtbH2W+EYspiTNMGY=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=pNqni0Cncm3R71SA98AtxaRi9bg2wNEm2ckVk61g0qDTfXquAbblujf7+jsGbLcDw
 4pOrI67kEJmjHWbnX0cYQZmzI2lEspX1voEnGx0eKE2oSNx01ZUfX1YWzg+va8nD3n
 q9MomgFZd9mhRVPdjysA666631ncdNJyhtRhSn1pKHYXIKjfQxUZbnryUuxKtdGuf5
 sixIFr/6715Tw5ork0/h/Ox1GCO7OPOXEMJjuv+zbgf42ZeRgxrB3Cmi7gKHGiwXXX
 D2v57CggFyF6/gkR9zQXHukM4GSrC8g4jIdJ09q4Ow8T3jeBv5zblpbWBlydRjPF3s
 0mezdqUkWQEDA==
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v6 04/22] powerpc/book3s64/kuap/kuep: Move uamor setup to
 pkey init
In-Reply-To: <20201125051634.509286-5-aneesh.kumar@linux.ibm.com>
References: <20201125051634.509286-1-aneesh.kumar@linux.ibm.com>
 <20201125051634.509286-5-aneesh.kumar@linux.ibm.com>
Date: Thu, 26 Nov 2020 14:28:15 +1100
Message-ID: <87tutcyey8.fsf@mpe.ellerman.id.au>
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
> This patch consolidates UAMOR update across pkey, kuap and kuep features.
> The boot cpu initialize UAMOR via pkey init and both radix/hash do the
> secondary cpu UAMOR init in early_init_mmu_secondary.
>
> We don't check for mmu_feature in radix secondary init because UAMOR
> is a supported SPRN with all CPUs supporting radix translation.
> The old code was not updating UAMOR if we had smap disabled and smep enabled.
> This change handles that case.
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  arch/powerpc/mm/book3s64/radix_pgtable.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
> index 3adcf730f478..bfe441af916a 100644
> --- a/arch/powerpc/mm/book3s64/radix_pgtable.c
> +++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
> @@ -620,9 +620,6 @@ void setup_kuap(bool disabled)
>  		cur_cpu_spec->mmu_features |= MMU_FTR_RADIX_KUAP;
>  	}
>  
> -	/* Make sure userspace can't change the AMR */
> -	mtspr(SPRN_UAMOR, 0);
> -
>  	/*
>  	 * Set the default kernel AMR values on all cpus.
>  	 */
> @@ -721,6 +718,11 @@ void radix__early_init_mmu_secondary(void)
>  
>  	radix__switch_mmu_context(NULL, &init_mm);
>  	tlbiel_all();
> +
> +#ifdef CONFIG_PPC_PKEY
> +	/* Make sure userspace can't change the AMR */
> +	mtspr(SPRN_UAMOR, 0);
> +#endif

If PPC_PKEY is disabled I think this leaves UAMOR unset, which means it
could potentially allow AMR to be used as a covert channel between
processes.

cheers
